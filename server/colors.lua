addEvent("coloresOfGroup", true)
addEventHandler("coloresOfGroup", getRootElement(), 
function ( )
	local colorG = { getGroupColor( getPlayerGroup( source ) ) }
	triggerClientEvent(source,"coloorChat",source, colorG[1], colorG[2])
end)

addEvent("donecolorchange",true)
addEventHandler("donecolorchange",getRootElement(  ),
function ( colorTag, colorChat )
local gang = getPlayerGroup( source )
	setGroupColor( gang, colorTag, colorChat )
	createNotification("Nuevos colores asignados!",source, 255, 255, 255, true)
	refresh_blips();
	addGroupLog( gang, getPlayerName( source ).." [ "..getPlayerRank( source ).." ] Modifico los colores." )
end)