---------------------------------------------------------------------
--  Desarrollador/Developer: -Rex-
--  Proyecto/Proyect:        N/A
--  Contacto/Contact:        https://www.facebook.com/rexscripting/
--
--  Libre uso y modificacion, No borrar los creditos, Gracias
---------------------------------------------------------------------
local regis_db = dbConnect( "sqlite", "dbData_byRex.db" )
cosaTextsT = {}
function textLabels( group )
	cosaTextsT[group] = ""
	local members = getGroupSlots( group ) --membername
	local qh = regis_db:query("SELECT * FROM groupmembers WHERE name=?", group)
	for _, columna in ipairs( dbPoll( qh, -1 ) ) do
		local player = getPlayerFromName( columna["membername"] ) 
		if isElement( player ) then
			if isPlayerFounder( player, group ) then
				if string.len(cosaTextsT[group]) <= 0 then
					cosaTextsT[group] = string.gsub( columna["membername"], "#%x%x%x%x%x%x", "" )
				else
					cosaTextsT[group] = cosaTextsT[group]..","..string.gsub( columna["membername"], "#%x%x%x%x%x%x", "" )
				end	
			end
		end
	end
	triggerClientEvent( source, "textLabels", source, members, cosaTextsT[group] )
end
addEventHandler("getGPCLabels", root, textLabels )

function getServerListGPC( )
	local newBi = {}
	local qh = regis_db:query("SELECT groupname FROM groupsystem ORDER BY groupname ASC")
	for _, columna in ipairs( dbPoll(qh, -1) ) do
		for _, groupName in pairs ( columna ) do
			local totalMembers, totalSlots = getGroupSlots( groupName )
			if totalMembers and totalSlots then
				triggerClientEvent( source, "sendServerListGPC", source, groupName, tostring( totalMembers ).."/"..tostring( totalSlots ) )
			end
		end
	end
end
addEventHandler("getGPCListG", root, getServerListGPC )

function getInfoGPCgRop( group )
	if isGroupExists( group ) then
		local qh = regis_db:query("SELECT info FROM groupinfo WHERE gpname=?", group)
		for _, columna in pairs( dbPoll( qh, -1 ) ) do
			local info = columna["info"]
			triggerClientEvent( source, "sendInfoOfGPC", source, info)
		end
	end
end
addEventHandler("getGPCGROUPInfo", root, getInfoGPCgRop )

function getMembersOfGP( group )
	local newMb = {}
	local qh = regis_db:query("SELECT * FROM groupmembers WHERE name=? ORDER BY rang DESC", group)
	for _, columna in ipairs( dbPoll( qh, -1 ) ) do
		local nick, rango, estado = columna["membername"], columna["rang"], columna["status"];
		local jugador = getPlayerFromName( nick );
		if isElement ( jugador ) then
			table.insert( newMb, { nick, rango, estado, 0, 200, 0 } )
		else
			table.insert( newMb, { nick, rango, estado, 200, 0, 0 } )
		end
	end
	triggerClientEvent( source, "sendGPCMembersGPList", source, newMb )
end
addEventHandler("getMembersGPCList", root, getMembersOfGP )

function findGPCPlayerG( texto, grupo )
	local NewJh = {}
	local qh = regis_db:query( "SELECT membername, rang, status FROM groupmembers WHERE name=?", grupo )
	for _, col in ipairs( dbPoll( qh, -1 ) ) do
		local nick, rango, estado = col["membername"], col["rang"], col["status"];
		if nick:gsub( "#%x%x%x%x%x%x", "" ):find( texto ) then
			local player = getPlayerFromName( nick );
			if isElement( player ) then
				table.insert( NewJh, { nick, rango, estado, 0, 200, 0 } )
			else
			    table.insert( NewJh, { nick, rango, estado, 200, 0, 0 } )
			end
		end
	end
	triggerClientEvent( source, "sendGPCMembersGPList", source, NewJh )
end
addEventHandler("findMemberGPC", root, findGPCPlayerG )

function aGPCTetxs( nick )
	local player = getPlayerFromName( nick );
	local accountName = player:getAccount():getName();
	triggerClientEvent( source, "labelsGPCTextmm", source, accountName )
end
addEventHandler("getAccountGPCText", root, aGPCTetxs )

function gpcListPlayerG( )
	local Mmnew = {}
	local theTable = getElementsByType( "player" );
	for _, player in ipairs( theTable ) do
		local account = player:getAccount();
		local guestPlayer = account:isGuest();
		if not guestPlayer then
			local name = player:getName();
			if isPlayerInGroup( player ) then
				local group = getPlayerGroup( player )
				table.insert( Mmnew, { name, group } )
			else
				table.insert( Mmnew, { name, "N/A" } )
			end
		end
	end
	triggerClientEvent( source, "sendTablePlAdd", source, Mmnew )
end
addEventHandler("getPlayerGPCListAdd", root, gpcListPlayerG )

function findAAggedGpcmm( texto )
	local Mmnew = {}
	local theTable = getElementsByType( "player" );
	for _, player in ipairs( theTable ) do
		local account = player:getAccount();
		local guestPlayer = account:isGuest();
		if not guestPlayer then
			local name = player:getName();
			if name:gsub( "#%x%x%x%x%x%x", "" ):find( texto ) then
				if isPlayerInGroup( player ) then
					local group = getPlayerGroup( player )
					table.insert( Mmnew, { name, group } )
				else
					table.insert( Mmnew, { name, "N/A" } )
				end
			end
		end
	end
	triggerClientEvent( source, "sendTablePlAdd", source, Mmnew )
end
addEventHandler("findAAggedMemberGPC", root, findAAggedGpcmm )
