---------------------------------------------------------------------
--  Desarrollador/Developer: -Rex-
--  Proyecto/Proyect:        N/A
--  Contacto/Contact:        https://www.facebook.com/rexscripting/
--
--  Libre uso y modificacion, No borrar los creditos, Gracias
---------------------------------------------------------------------
function centerWindow (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    guiSetPosition(center_window, x, y, false)
end

function createNotification( mensaje )
	create_notify_window( "OK", { title = "Informacion", description = mensaje}, function() end )
end

function serverNotify( mensaje )
    createNotification( mensaje )
end
addEvent("NClient",true)
addEventHandler("NClient",getLocalPlayer(),serverNotify)


RSystem = {
    button = {},
    window = {},
    edit = {},
    label = {}
}
RSystem.window[1] = guiCreateWindow(471, 233, 352, 119, "Razón", false)
guiWindowSetSizable(RSystem.window[1], false)

RSystem.label[1] = guiCreateLabel(10, 31, 141, 16, "Escribe una razón", false, RSystem.window[1])
guiSetFont(RSystem.label[1], "default-bold-small")
RSystem.edit[1] = guiCreateEdit(10, 51, 332, 30, "", false, RSystem.window[1])
guiEditSetMaxLength( RSystem.edit[1], 50 )
RSystem.button[1] = guiCreateButton(216, 92, 61, 17, "Listo", false, RSystem.window[1])
guiSetFont(RSystem.button[1], "default-bold-small")
RSystem.button[2] = guiCreateButton(281, 92, 61, 17, "X", false, RSystem.window[1])
guiSetFont(RSystem.button[2], "default-bold-small")
RSystem.label[2] = guiCreateLabel(10, 99, 184, 18, "Jugador: Rexito-", false, RSystem.window[1])
guiSetFont(RSystem.label[2], "default-small")
centerWindow ( RSystem.window[1] )
guiSetVisible ( RSystem.window[1], false )


local temporalNick
function showRS( playerNick )
	
	if playerNick then
		guiSetVisible( guiconfiggp, false)
		temporalNick = playerNick
		guiSetText( RSystem.label[2], "Jugador "..temporalNick )
		guiSetVisible ( RSystem.window[1], true )
		guiBringToFront( RSystem.window[1] )
		centerWindow ( RSystem.window[1] )
	end

end

function clicksRS(  )
	

	if source == RSystem.button[1] then

		if temporalNick then

			local razon = guiGetText( RSystem.edit[1] )

			if razon:len( ) >= 2 then
				triggerServerEvent("kickamemberoption",getLocalPlayer(), temporalNick, razon )
	    		guiGridListClear(gridlistconfigmv)
	    		triggerServerEvent("getcdtgroup",getLocalPlayer())
    			exec_event("get_group_datas", getLocalPlayer(  ));
	    		guiSetEnabled( kickmembersb, false )
	    		setTimer( guiSetEnabled, 3000, 1, kickmembersb, true )
				guiSetVisible ( RSystem.window[1], false )
				guiSetVisible( guiconfiggp, true)
				temporalNick = nil
			else
				createNotification( "Razón muy corta!" )
			end

		end

	elseif source == RSystem.button[2] then
		temporalNick = nil
		guiSetVisible ( RSystem.window[1], false )
		guiSetVisible( guiconfiggp, true)
	end

end
addEventHandler("onClientGUIClick", root, clicksRS )
