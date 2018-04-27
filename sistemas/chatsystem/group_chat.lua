
-----------------------------------------------
--  Desarrollador/Developer: -Rex-
--  Proyecto/Proyect:        N/A
--  Contacto/Contact:        https://www.facebook.com/rexscripting/
--
--  Libre uso y modificacion, No borrar los creditos, Gracias
-----------------------------------------------
local regis_db = dbConnect( "sqlite", "dbData_byRex.db" )

--//Funcion exportada
function addChatRegistry( group, playerT, message )

	--//
	assert( type ( group ) == "string", "Error bad argument @group" )

	assert( playerT:getType() == "player", "Error bad argument @player")

	assert( type ( message ) == "string", "Error bad argument @message" )
	--//
	
	-- local time = getRealTime( );
	-- local hour, min, sec = time.hour, time.minute, time.second
	-- local timeFormated = "["..hour..":"..min..":"..sec.."]"
	local timeFormated = getTimes();
	local nickname = string.gsub( playerT:getName(), "#%x%x%x%x%x%x", "")

	--//
	table.insert( cacheRegistry, { #cacheRegistry+1, timeFormated, group, nickname, message } )
	outputDebugString( "["..group.."] "..nickname..": "..message, 0 )

	--//Manda el mensaje a todos los demas players.
	local colorG = { getGroupColor( group ) }

	local tag    = colorG[1]
	local chat   = colorG[2]


	for _, players in ipairs( getElementsByType("player") ) do

		if isPlayerInGroup( players ) then

			local groupPlayers = getPlayerGroup( players )
			if ( groupPlayers == group ) then

				if getColorFromString( tag ) and getColorFromString( chat ) then
					players:outputChat(tag.."["..groupPlayers.."] "..nickname..":"..chat.." "..message,0,200,0,true)
				else
					players:outputChat( "Error en la configuración de colores del chat!",0,200,0,true)
				end

			end

		end
	end
	--//
end
--
function groupChat( source, cmd, ... )
	local account = source:getAccount();
	local guestPlayer = account:isGuest();
	local message = table.concat( {...}, " ")
	if not guestPlayer then
		if isPlayerInGroup( source ) then
			local grupo = getPlayerGroup( source )
			addChatRegistry( grupo, source, message )
		else
			outputChatBox( "No tienes grupo!", source, 255, 255, 255, true )
		end
	end
end
addCommandHandler("groupchat", groupChat)

function alianzaChat( source, cmd, ... )
	local account = source:getAccount();
	local guestPlayer = account:isGuest();
	local message = table.concat( {...}, " ")

	if guestPlayer then return; end
	if ( not isPlayerInGroup( source ) ) then
		outputChatBox( "No tienes grupo!", source, 255, 255, 255, true )
	end

	local grupo = getPlayerGroup( source )
	local aN = 0
	for i,v in ipairs( getGroupAlianzes ( grupo ) ) do
		aN = aN + 1
	end

	if aN == 0 then
		return
	end

	local nickname = string.gsub( source:getName(), "#%x%x%x%x%x%x", "")

	for _, players in ipairs( getElementsByType("player") ) do

		if isPlayerInGroup( players ) then

			local groupPlayers = getPlayerGroup( players )

			if esAliadoDe ( groupPlayers, grupo ) or ( groupPlayers == grupo ) then
				players:outputChat("#FFFF00[ALIANZA] "..nickname..": #FFFFFF"..message, 255, 255, 255, true )
			end

		end

	end
end
addCommandHandler("alianza", alianzaChat)