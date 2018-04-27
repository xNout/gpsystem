---------------------------------------------------------------------
--  Desarrollador/Developer: -Rex-
--  Proyecto/Proyect:        N/A
--  Contacto/Contact:        https://www.facebook.com/rexscripting/
--
--  Libre uso y modificacion, No borrar los creditos, Gracias
---------------------------------------------------------------------

local db = dbConnect( "sqlite", "dbData_byRex.db" )
local tableSolicitudes = { }

local bools = 
{
	["true"] = true,
	["false"] = false,
}

function getGroupConfig( grupp )

	if grupp then

		local qh = db:query ( "SELECT * FROM group_alianzas_configs WHERE grupo=?", tostring ( grupp ) )
		local tablita = qh:poll( - 1 )

		if #tablita == 0 then
			dbExec( db, "INSERT INTO group_alianzas_configs ( grupo, blipsmapa, chatGrupo ) VALUES( ?, ?, ? )", tostring ( grupp ), "true", "true" )
			return true, true
		else

			for i, v in ipairs( tablita ) do
				return bools[v["blipsmapa"]], bools[v["chatGrupo"]]
			end

		end

	end

end

function deleteAlianze( grupo, elGrupo )
	db:exec( "DELETE FROM group_alianzas WHERE grupo=? AND grupoAliado=?", tostring( grupo ), elGrupo )
	db:exec( "DELETE FROM group_alianzas WHERE grupo=? AND grupoAliado=?", tostring( elGrupo ), grupo )

	addGroupLog( grupo, elGrupo.." Elimino su la alianza." )
	addGroupLog( elGrupo, grupo.." Elimino su la alianza." )
end


function requestGroupConfig( )

	local gang = getPlayerGroup ( source )

	if gang then

		local b, c = getGroupConfig ( gang )
		triggerClientEvent( source, "groupConfigs", source, b, c )
	end

end
addEvent( "requestGroupConfigs", true )
addEventHandler( "requestGroupConfigs", getRootElement(  ), requestGroupConfig )


function requestChangeGroupConfig( a, b )

	local gang = getPlayerGroup ( source )

	if gang then
		local fundador = isPlayerFounder( source, gang )
		db:exec( "UPDATE group_alianzas_configs SET blipsmapa=?, chatGrupo=? WHERE grupo=?", tostring( a ), tostring( b ), tostring( gang ) )
		local e, d = getGroupConfig ( gang )
		triggerClientEvent( source, "groupConfigs", source, e, d )
		createPlayerBlips(  )
	end

end
addEvent( "requestChangeGPConig", true )
addEventHandler( "requestChangeGPConig", getRootElement(  ), requestChangeGroupConfig )

function requestDeleteInv( grupo )

	local gang = getPlayerGroup ( source )

	if gang then


		if esAliadoDe ( gang, grupo ) then

			deleteAlianze ( gang, grupo )
			triggerClientEvent( source, "openGUI", source )
			createNotification( "Alianza con: "..grupo.." terminada!", source, 242, 242, 242, true )

			for i, player in ipairs( getElementsByType ( "player" ) ) do
				
				local grup = getPlayerGroup ( player )

				if ( grup == grupo ) then

					local funda = isPlayerFounder( player, grup )

					if funda then
						outputChatBox( "El grupo: "..gang.." Ya no es aliado!", player, 242, 242, 242, true )
						createPlayerBlips(  )
					end

				end

			end

		end

	end

end
addEvent( "requestDeleteAlianze", true )
addEventHandler( "requestDeleteAlianze", getRootElement(  ), requestDeleteInv )

function getGroupAlianzes( group )
	local qh = db:query ( "SELECT * FROM group_alianzas WHERE grupo=?", tostring ( group ) )
	local tablita = qh:poll( - 1 )
	local n = { }
	for i, v in ipairs( tablita ) do
		table.insert( n, v["grupoAliado"] )
	end

	return n

end

function getGPList( )
	
	local list = getGroupAlianzes( getPlayerGroup ( source ) )

	local t = {}
	for i, v in ipairs( list ) do
		local miembros, slots = getGroupSlots ( v )
		local conc = miembros.."/"..slots
		table.insert( t, { v, conc }) 
	end
	triggerClientEvent( source, "addGPList", source, t )

end
addEvent( "requestGPList", true )
addEventHandler( "requestGPList", getRootElement(  ), getGPList )


function getGPList2( )
	
	local list = getGroupList(  )

	
	for i, v in ipairs( list ) do
		triggerClientEvent( source, "addGPList2", source, v[1] )
	end

end
addEvent( "getALLGPList", true )
addEventHandler( "getALLGPList", getRootElement(  ), getGPList2 )

function requestGPAliInfo( gp )

	local list = getGroupAlianzes( getPlayerGroup ( source ) )
	local a = ""
	local M = tablesize( list )
	for i, v in ipairs( list ) do

		if M > i then
			a = a..v..", "
		else
			a = a..v..". "
		end

	end

	triggerClientEvent( source, "GPInfoAlList", source, a )
end
addEvent( "requestGroupAlianzesInfo", true )
addEventHandler( "requestGroupAlianzesInfo", getRootElement(  ), requestGPAliInfo )

function findGPList( name )
	
	local list = getGroupList( )

	
	for i, v in ipairs( list ) do
		
		if  string.find( v[1], string.lower( name ) ) 
			or string.find( v[1], string.reverse( string.lower( name ) ) ) 
			or string.find( v[1], string.upper( name ) ) 
			or string.find( v[1], string.reverse( string.upper( name ) ) ) 
		then

			triggerClientEvent( source, "addGPList2", source, v[1] )

		end

	end

end
addEvent( "requestFINDList", true )
addEventHandler( "requestFINDList", getRootElement(  ), findGPList )

function findGPLis( name )
	
	local list = getGroupList( )

	
	for i, v in ipairs( list ) do
		
		if  string.find( v[1], string.lower( name ) ) 
			or string.find( v[1], string.reverse( string.lower( name ) ) ) 
			or string.find( v[1], string.upper( name ) ) 
			or string.find( v[1], string.reverse( string.upper( name ) ) ) 
		then

			triggerClientEvent( source, "addGPList3", source, v[1] )

		end

	end

end
addEvent( "requestFINDList2", true )
addEventHandler( "requestFINDList2", getRootElement(  ), findGPLis )

addEvent( "requestsendInvGP", true )
addEventHandler( "requestsendInvGP", getRootElement(  ), 
function ( gru )
	
	local gang = getPlayerGroup ( source )

	if gang then


		local solicitud = sendAlianzeSolicitud( gang, gru )

		if solicitud then

			createNotification( "Solicitud enviada!", source, 242, 242, 242, true )
			addGroupLog( gang, source:getName().." Envio solicitud de alianza para: "..gru );
			for i, player in ipairs( getElementsByType ( "player" ) ) do
				
				local grupo = getPlayerGroup ( player )

				if ( grupo == gru ) then

					local funda = isPlayerFounder( player, grupo )

					if funda then
						outputChatBox( "El grupo: "..gang.." Les envio una solicitud de alianza! ( Usa /alianza para abrir el panel )", player, 242, 242, 242, true )
					end

				end

			end

		else
			createNotification( "Solicitud NO enviada!", source, 242, 242, 242, true )
		end
	end
end  )


addEvent( "requestGetInvList", true )
addEventHandler( "requestGetInvList", getRootElement(  ), 
function  ( )
	local gang = getPlayerGroup ( source )
	if ( not tableSolicitudes[gang] ) then
		tableSolicitudes[gang] = { }
	end

	if tableSolicitudes[gang] then
		for i, v in ipairs( tableSolicitudes[gang] ) do
			triggerClientEvent( source, "addInvsList", source, v )
		end
	end
end)


addEvent( "requestDeleteInvGP", true )
addEventHandler( "requestDeleteInvGP", getRootElement(  ), 
function ( grupo )
	local gang = getPlayerGroup ( source )
	deleteInv ( gang, grupo )
	createNotification ( "Solicitud eliminada!", source, 242, 242, 242, true )
	for i, v in ipairs( tableSolicitudes[gang] ) do
		triggerClientEvent( source, "addInvsList", source, v )
	end
end )


addEvent( "requestAcceptInv", true )
addEventHandler( "requestAcceptInv", getRootElement(  ), 
function ( grupo )
	local gang = getPlayerGroup ( source )

	if gang then
		local alianza = addGroupAlianze ( gang, grupo )
		if alianza then

			createNotification ( "Aceptaste la solicitud de alianza!", source, 242, 242, 242, true )
			addGroupLog( gang, gang.." Acepto la solicitud de alianza." )
			addGroupLog( grupo, grupo.." Acepto la solicitud de alianza." )
			for i, player in ipairs( getElementsByType ( "player" ) ) do
				
				local grup = getPlayerGroup ( player )

				if ( grup == grupo ) then

					local funda = isPlayerFounder( player, grup )

					if funda then
						outputChatBox( "El grupo: "..gang.." Acepto la solicitud de alianza!", player, 242, 242, 242, true )
						createPlayerBlips(  )
					end

				end

			end

			deleteInv ( gang, grupo )
			for i, v in ipairs( tableSolicitudes[gang] ) do
				triggerClientEvent( source, "addInvsList", source, v )
			end

		else
			createNotification( "El grupo ya es aliado!", source, 242, 242, 242, true )
		end
	end

end )

function addGroupAlianze( grupo, otroGrupo )
	
	if grupo and otroGrupo and ( grupo ~= otroGrupo ) then

		if ( not esAliadoDe ( grupo, otroGrupo ) ) then
			dbExec( db, "INSERT INTO group_alianzas ( grupo, grupoAliado ) VALUES( ?, ? )", tostring ( grupo ), tostring ( otroGrupo ) )
			dbExec( db, "INSERT INTO group_alianzas ( grupo, grupoAliado ) VALUES( ?, ? )", tostring ( otroGrupo ), tostring ( grupo ) )
			addGroupLog( grupo, otroGrupo.." Ahora es aliado." )
			addGroupLog( otroGrupo, grupo.." Ahora es aliado." )
			return true
		end

	end
	return false
end

function sendAlianzeSolicitud( grupo, otroGrupo )
	
	if grupo and otroGrupo and ( grupo ~= otroGrupo ) then
	--if grupo and otroGrupo and ( grupo ~= otroGrupo ) then

		if ( not esAliadoDe ( grupo, otroGrupo ) ) then

			if ( not tableSolicitudes[otroGrupo] ) then
				tableSolicitudes[otroGrupo] = { }
			end

			if ( not yaTieneInvitacion( otroGrupo, grupo ) ) then
				table.insert ( tableSolicitudes[otroGrupo], grupo )
				return true
			end
		end

	end
	return false

end

function esAliadoDe( grupo, otroGrupo )
	
	local qh = db:query ( "SELECT * FROM group_alianzas WHERE grupo=?", tostring ( grupo ) )
	local tablita = qh:poll( - 1 )

	for i, v in ipairs( tablita ) do
		
		if v["grupoAliado"] == tostring ( otroGrupo ) then
			return true
		end
	end

	return false

end

function yaTieneInvitacion( grupo, elGrupo )
	
	if tableSolicitudes[grupo] then

		for i, v in ipairs( tableSolicitudes[grupo] ) do
			
			if v == elGrupo then
				return true
			end

		end

	end

	return false
end


function deleteInv( grupo, elGrupo )
	
	if tableSolicitudes[grupo] then

		local c = 0
		for i, v in ipairs( tableSolicitudes[grupo] ) do
			
			c = c + 1
			
			if v == elGrupo then
				table.remove( tableSolicitudes[grupo], c )
			end
			

		end

	end

end

function createPlayerBlips(  )
	
	for i, players in ipairs( getElementsByType ( "player" ) ) do
		
		local cacheTable = { }
		if isPlayerInGroup( players ) then

			local groupPlayer = getPlayerGroup ( players )

			for k, groupsAliated in ipairs( getGroupAlianzes( groupPlayer ) ) do

				local blipsConfig = getGroupConfig ( groupsAliated )
				if blipsConfig then
					local colorGAliado = { getGroupColor( groupsAliated ) }
					local tagAliado    = colorGAliado[1]
					table.insert( cacheTable, { groupsAliated,  tagAliado } )
				end
			end
			setElementData( players, "GroupColors", { getGroupColor( groupPlayer ) } )
		end

		setElementData( players, "GroupsAliatedTable", cacheTable )

		triggerClientEvent( "rhsBlips", players )
	end

end
setTimer( createPlayerBlips, 60000, 0 )