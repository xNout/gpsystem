--[[
 *	*******************************************	*
 * Developed by:	-Rex-						*
 * Last modified:	26/01/2018					*
 * Description:									*
 *	*******************************************	*
 ]]--

function add_event( func, event_name, to_element )
	addEvent(event_name,true)
	addEventHandler(event_name,to_element, func )
end

function tablesize( tabla )
	
	local contador = 0

	for i, v in ipairs( tabla ) do
		contador = contador + 1
	end

	return contador

end

function isDbTableEmpty( database, tabla )
	local testQuery = dbQuery( database, "SELECT * FROM "..tabla )
	local poll      = dbPoll( testQuery, -1 )
	if #poll == 0 then
		return true
	end
	return false
end

function asignar_team(  )
	for i, player in ipairs( getElementsByType("player") ) do

   		if ( not isGuestPlayer( player ) ) then
   			update_member_nick( player:getName( ), player:getAccount ( ):getName() );
			setGroup ( player, getPlayerGroup( player ) )
   		end
    end
end

function refresh_blips(  )
	for i, players in ipairs( getElementsByType ( "player" ) ) do
		triggerClientEvent( players, "rhsBlips", players );
	end
	createPlayerBlips(  );
end

function isGuestPlayer( player )
	return player:getAccount():isGuest();
end

function setGroup ( player, gang )
	if( not isElement( player ) ) then return; end
	local grupo = gang or "N/A";
	player:setData( "gang", grupo )
	player:setData( "Group", grupo )
	triggerClientEvent( player, "rhsBlips", player )
end



function getGroupList(  )
	local newT = {}
	for i,columna in ipairs(get_groups( )) do
		table.insert( newT, {columna["groupname"]} )
	end
	return newT
end


function player_groupmembers( player )
	local date = getTimes ( )
	local activesTable   = { }
	local inactivesTable = { }

	local mTable = get_group_member( getPlayerGroup(player) )
	for i,columna in ipairs( mTable ) do

		if columna["rang"] == "Creador" then

			local arguments = { "Ahora", columna["membername"], columna["rang"], 0, 200, 0 };

			if ( not isElement ( getPlayerFromName( columna["membername"] ) ) ) then
				arguments[1] = ( columna["uactive"] or date );
				arguments[4] = 200;
				arguments[5] = 0;
				arguments[6] = 0;
			end		
			table.insert( activesTable, 1, arguments);
			break
		end

	end

	for i,columna in ipairs( mTable ) do
		if columna["rang"] ~= "Creador" then

			local arguments = { "Ahora", columna["membername"], columna["rang"], 0, 200, 0 };
			if ( not isElement ( getPlayerFromName( columna["membername"] ) ) ) then
				arguments[1] = ( columna["uactive"] or date );
				arguments[4] = 200;
				arguments[5] = 0;
				arguments[6] = 0;
			end	
			if ( arguments[1] == "Ahora" ) then
				table.insert( activesTable, arguments);
			else
				table.insert( inactivesTable, arguments);
			end

		end

	end

	return activesTable, inactivesTable;
end


local database = dbConnect( "sqlite", "dbData_byRex.db" )

function isGroupExists( groupnames )

	local qh = database:query( "SELECT groupname FROM groupsystem WHERE groupname=?", tostring( groupnames ) )
	local consulta = dbPoll( qh, -1 )

	for k,con in pairs(consulta) do
		return con["groupname"] ~= nil or false;
	end	
end

function getPlayerGroup( player )

	assert( getElementType( player ) == "player", "Error bad argument @ 'player' [Expected at argument 1, got "..tostring(player).." ]")
	local pl_account = player:getAccount():getName();

	local qh = database:query( "SELECT * FROM groupmembers")
	local table = dbPoll( qh, -1 )
	
	for i, con in ipairs( table or {} ) do
		if con["memberacc"] == tostring( pl_account ) then
			local gangname = tostring(con["name"])
			return gangname or false
		end
	end 
end

function isPlayerFounder( player, gang )

	assert( getElementType( player ) == "player", "Error bad argument @ 'player' [Expected at argument 1, got "..tostring(player).." ]")
	assert( type( gang ) == "string", "Error bad argument @ 'gang' [Expected at argument 2, got "..tostring(gang).." ]" )
	
	local pl_account = player:getAccount():getName();
	
	local qh = database:query( "SELECT rang FROM groupmembers WHERE name=? AND memberacc=?",gang, pl_account)
	local consulta = dbPoll( qh, -1 )

	for i,con in ipairs (consulta) do	
		return con["rang"] == "Creador" or false
	end
end

function isAccountOfFounder( account, gang )
	

	local qh = database:query( "SELECT rang FROM groupmembers WHERE name=? AND memberacc=?",gang, account)
	local consulta = dbPoll( qh, -1 )

	for i,con in ipairs (consulta) do	
		return con["rang"] == "Creador" or false
	end

end

function getAccountFromName( name )
	

	local qh = database:query( "SELECT * FROM groupmembers WHERE membername=?", name )
	local consulta = dbPoll( qh, -1 )

	for i,con in ipairs (consulta) do	
		return con["memberacc"]
	end

end

function isPlayerInGroup( player )

	assert( getElementType( player ) == "player", "Error bad argument @ 'player' [Expected at argument 1, got "..tostring(player).." ]")

	local acc = getAccountName(getPlayerAccount( player ))

	local qh = database:query( "SELECT memberacc FROM groupmembers WHERE memberacc=?",acc )
	local consulta = dbPoll( qh, -1 )

	for i,con in ipairs(consulta) do
		return con["memberacc"] ~= nil or false
	end 
end

function isAccountInGroup( acc )

	local qh = database:query( "SELECT memberacc FROM groupmembers WHERE memberacc=?",acc )
	local consulta = dbPoll( qh, -1 )

	for i,con in ipairs(consulta) do
		return  con["memberacc"] ~= nil or false
	end 
end

function addPlayerToGroup( player, gang)
	assert( getElementType( player ) == "player" and isElement(player), "Error bad argument @ 'player' [Expected at argument 2, got "..tostring(player).." ]")
	assert( type(gang) == "string", "Error bad argument @ 'gang' [Expected at argument 2, got "..tostring(gang).." ]" )
	if isGroupExists( gang ) then
		local acc = getAccountName(getPlayerAccount( player ))
		database:exec("INSERT INTO groupmembers ( name,memberacc,membername,rang) VALUES(?,?,?,?)", gang, acc, getPlayerName(player), "Trial" )
	else
		error("Error bad argument @ 'gang [ Group is nil ] ")
	end
end

function addAccountToGroup( acc, gang)
	database:exec("INSERT INTO groupmembers ( name,memberacc,membername,rang) VALUES(?,?,?,?,?)", gang, acc, "Player", "Trial" )
end

function setPlayerRank( player, rang )
	assert( getElementType( player ) == "player" and isElement(player), "Error bad argument @ 'player' [Expected at argument 2, got "..tostring(player).." ]")

	assert( type(rang) == "string", "Error bad argument @ 'rang' [Expected at argument 2, got "..tostring(rang).." ]" )
	local acc = getAccountName(getPlayerAccount( player ))
	local gang = getPlayerGroup(player)
	if isGroupExists( gang ) then
		database:exec( "UPDATE groupmembers SET rang=? WHERE memberacc=? AND name=?", tostring( rang ),acc,gang )
	else
		error( "Error bad argument @ 'gang' [Expected at argument 1, Group is nil ]" )
	end
end

function getPlayerRank( player)

	assert( getElementType( player ) == "player" and isElement(player), "Error bad argument @ 'player' [Expected at argument 2, got "..tostring(player).." ]")
	local gang = getPlayerGroup(player)

	if isPlayerInGroup ( player ) then
		local acc = getAccountName(getPlayerAccount( player ))
		local qh = database:query( "SELECT rang FROM groupmembers WHERE memberacc=? AND name=?",acc, gang )
		local consulta = dbPoll( qh, -1 )
		for i,columna in pairs( consulta ) do
			local rang = columna["rang"]
			if rang then
				return rang
			end
		end
	else
		error( "Error bad argument @ 'gang' [Expected at argument 1, Group is nil ]" )
	end
end

function removePlayerFromGroup( player, gang)
	assert( getElementType( player ) == "player", "Error bad argument @ 'player' [Expected at argument 1, got "..tostring(player).." ]")
	assert( type( gang ) == "string", "Error bad argument @ 'gang' [Expected at argument 2, got "..tostring(gang).." ]" )

	if isGroupExists( gang ) then
		if isElement( player ) then
			local acc = getAccountName(getPlayerAccount( player ))
			database:exec( "DELETE FROM groupmembers WHERE name=? AND memberacc=?", gang,acc)
		else
			error("Error bad argument @player [ player is nil or player is offline ]")
		end
	else
		error( "Error bad argument @ 'gang' [Expected at argument 1, Group is nil ]" )
	end
end

function getGroupSlots( gangname )
	local qh = database:query( "SELECT slots FROM groupsystem WHERE groupname=?",gangname)
	local table = dbPoll( qh, -1 ) 
	for _,columna in pairs(table) do
		slots = tonumber( columna["slots"] )
		local rqh = database:query( "SELECT memberacc FROM groupmembers WHERE name=?",gangname)
		local total = dbPoll( rqh, -1 ) 
		if total then
			return #total,slots
		end
	end
end

function addGroupSlots( group, ammount )
	assert( type( group ) == "string", "Error bad argument @ 'group' [Expected at argument 1, got "..tostring(group).." ]" )
	assert( type( tonumber(ammount) ) == "number","Error bad argument @ 'ammount' [Expected at argument 2, got number" )
	if isGroupExists( group ) then
		local qh = database:query( "SELECT * FROM groupsystem WHERE groupname=?",group)
		local table = dbPoll( qh, -1 )
		for i,columna in pairs( table)  do
			local slots = columna["slots"]		
			local s = tonumber(slots) + tonumber(ammount)
			database:exec( "UPDATE groupsystem SET slots=? WHERE groupname=?", tostring( s ),group )
			outputServerLog(  group.." Changed slots to: "..tostring(s) )
		end
	else
		error( "Error bad argument @ 'group' [Expected at argument 1, got nil" )
	end
end


function deleteGroup( gang )
	local alianzas = getGroupAlianzes( gang )
	for i,v in ipairs( alianzas ) do
		deleteAlianze( gang, v )
	end

	local ranksTable  = getGroupRanks ( gang )

	for _, c in ipairs( ranksTable ) do
		deleteGroupRank( gang, c[1] )
	end
	database:exec( "DELETE FROM groupsystem WHERE groupname=?", gang)
	database:exec( "DELETE FROM groupinfo WHERE gpname=?", gang)
	local qh = database:query("SELECT * FROM groupmembers WHERE name=?",gang)
	for _, columna in ipairs( dbPoll( qh, -1 ) ) do
		local acc = columna["memberacc"]
		database:exec("DELETE FROM groupmembers WHERE memberacc=?", acc)
	end
	database:exec( "DELETE FROM groupmembers WHERE name=?", gang)

	local directorio = "logsystem/grupos/";
	local extension  = ".rex";
	local dDirectorio = directorio..gang..extension;
	if( fileExists( dDirectorio ) ) then
		fileDelete( dDirectorio );
	end

	outputServerLog( "The group "..gang.." Has been deleted" )
end

function setGroupColor( gang, colorT, colorC )
	assert( type( gang ) == "string", "Error bad argument @ 'gang' [Expected at argument 1, got "..tostring( gang ).." ]" )

	if isGroupExists ( gang ) then
		database:exec( "UPDATE groupsystem SET colorTag=?, colorChat=? WHERE groupname=?", colorT, colorC, gang )
	else
		error("Error bad argument @ 'gang [ Group is nil ] ")
	end
end

function getGroupColor( gang )
	assert( type( gang ) == "string", "Error bad argument @ 'gang' [Expected at argument 1, got "..tostring( gang ).." ]" )

	if isGroupExists ( gang ) then
		local qh = database:query( "SELECT colorTag, colorChat FROM groupsystem WHERE groupname=?",gang)
		local table = dbPoll( qh, -1 )
		for _,columna in pairs(table) do
			return columna["colorTag"], columna["colorChat"]
		end
	end
end
