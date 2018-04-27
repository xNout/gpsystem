---------------------------------------------------------------------
--  Desarrollador/Developer: -Rex-
--  Proyecto/Proyect:        N/A
--  Contacto/Contact:        https://www.facebook.com/rexscripting/
--
--  Libre uso y modificacion, No borrar los creditos, Gracias
---------------------------------------------------------------------

loggui = guiCreateWindow(485, 129, 475, 377, "Logs", false)
guiWindowSetSizable(loggui, false)

memolog = guiCreateMemo(10, 29, 455, 322, "", false, loggui)
guiMemoSetReadOnly(memolog, true)
xlog = guiCreateButton(426, 351, 29, 17, "X", false, loggui)
guiSetFont(xlog, "default-bold-small")
guiSetProperty(xlog, "NormalTextColour", "FFFFFFFF")    

guiSetVisible( loggui, false )
centerWindow( loggui )

function OpenLog(  )
	guiSetText( memolog, "")
	triggerServerEvent( "getLogsGroup", getLocalPlayer(  ))
end
addEventHandler("onClientGUIClick", logsOpen, OpenLog, false)

function closeLLogs(  )
	guiSetVisible( loggui, false )
end
addEventHandler("onClientGUIClick", xlog, closeLLogs, false)

function memoSetLogs( texto )
	guiSetText( memolog, texto)
	guiBringToFront( loggui )
	gSetVisible( loggui, true )
end
addEvent("memoLog",true)
addEventHandler("memoLog", getLocalPlayer(  ),memoSetLogs)