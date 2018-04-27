
-----------------------------------------------
--  Desarrollador/Developer: -Rex-
--  Proyecto/Proyect:        N/A
--  Contacto/Contact:        https://www.facebook.com/rexscripting/
--
--  Libre uso y modificacion, No borrar los creditos, Gracias
-----------------------------------------------
local tblBlipsGPC = {}
k = {}
addEvent("onPlayerDayZLogin", true)
addEvent("rhsBlips", true)
function createGroupBlipsF( )
	for _, ev in ipairs( tblBlipsGPC ) do
		destroyElement( ev[1] )
	end
	tblBlipsGPC = nil
	if not tblBlipsGPC then
		tblBlipsGPC = {}
	end
	local d = getElementData( getLocalPlayer(  ), "Group" ) or getElementData( getLocalPlayer(  ), "gang" )

	if d == "N/A" then 
		return
	end

	for i, player in ipairs( getElementsByType("player") ) do

		local de = getElementData( player, "Group" ) or getElementData( player, "gang" )

		if de ~= "N/A" then

			if d == de then

				local r, g, b = getColorFromString( ( getElementData( player, "GroupColors" ) or { '#00FF00' } )[1] )

				for ke, v in ipairs( tblBlipsGPC ) do
					if v[2] == player then return end
				end

				k.blip = createBlipAttachedTo( player, 0, 2, r, g, b, 200, 0, 500 )
				table.insert( tblBlipsGPC, { k.blip, player } )

			else

				if isAliated ( de ) then

					local r, g, b = aliatedBlipColor( de )

					for ke, v in ipairs( tblBlipsGPC ) do
						if v[2] == player then return end
					end

					k.blip = createBlipAttachedTo( player, 0, 2, r, g, b, 200, 0, 500 )

					table.insert( tblBlipsGPC, { k.blip, player } )
				end

			end
		end
	end	
end
setTimer(createGroupBlipsF, 1000, 1)
setTimer(createGroupBlipsF, 60000, 0)
addEventHandler("rhsBlips", getLocalPlayer(  ), createGroupBlipsF)
addEventHandler("onPlayerDayZLogin", getRootElement(), createGroupBlipsF)

function startcomando( )
    bindKey ( "y", "down", "chatbox", "groupchat" )
    bindKey ( "u", "down", "chatbox", "alianza" )
end
addEventHandler( "onClientResourceStart", getResourceRootElement ( ), startcomando)

function deleteBl( )
	for i, v in ipairs( tblBlipsGPC ) do
		destroyElement( v[1] )
		tblBlipsGPC = nil
	end
end
addEventHandler("onClientResourceStop", getResourceRootElement( getThisResource()), deleteBl )
