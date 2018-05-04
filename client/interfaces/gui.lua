PRINCIPALGUI = {
    label = {}
}

function gSetVisible( gui, bool )
    
    if ( bool ) then
      if( system_configs.GUI_co_effect ) then
          setTimer( function( f ) guiSetVisible( f, true ); end, 500, 1, gui )
        else
          guiSetVisible( gui, true );
        end
    else
        guiSetVisible( gui, false );
    end

end

function centerWindow (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    guiSetPosition(center_window, x, y, false)
end

grouppanel = guiCreateWindow(524, 242, 304, 148, "Sistema de grupos", false)
guiWindowSetSizable(grouppanel, false)

editcrgp = guiCreateEdit(19, 52, 194, 27, "", false, grouppanel)
label1 = guiCreateLabel(10, 33, 204, 17, "Escribe el nombre de tu grupo", false, grouppanel)
guiSetFont(label1, "default-bold-small")
creategpb = guiCreateButton(223, 57, 65, 20, "Crear", false, grouppanel)
guiSetFont(creategpb, "default-bold-small")
guiSetProperty(creategpb, "NormalTextColour", "FFAAAAAA")
invt = guiCreateButton(12, 87, 110, 22, "Mis invitaciones", false, grouppanel)
guiSetProperty(invt, "NormalTextColour", "FFFFFEFE")
infogp = guiCreateButton(12, 149, 185, 25, "Información del grupo", false, grouppanel)
guiSetFont(infogp, "default-bold-small")
guiSetProperty(infogp, "NormalTextColour", "FFAAAAAA")
members = guiCreateButton(12, 184, 185, 25, "Miembros", false, grouppanel)
guiSetFont(members, "default-bold-small")
guiSetProperty(members, "NormalTextColour", "FFAAAAAA")
grouplistb = guiCreateButton(128, 87, 110, 22, "Grupos", false, grouppanel)
guiSetProperty(grouplistb, "NormalTextColour", "FFFFFEFE")
-- gpmoney = guiCreateButton(12, 116, 110, 22, "Abandonar grupo", false, grouppanel)
-- guiSetProperty(gpmoney, "NormalTextColour", "FFFFFEFE")
newclose = guiCreateButton(12, 116, 110, 22, "Cerrar", false, grouppanel)
guiSetProperty(newclose, "NormalTextColour", "FFFFFEFE")
guiSetVisible(grouppanel,false)
centerWindow(grouppanel)


Pgrouppanel = guiCreateWindow(524, 242, 364, 266, "Sistema de grupos", false)
guiWindowSetSizable(Pgrouppanel, false)

invt2 = guiCreateButton(12, 51, 110, 22, "Mis invitaciones", false, Pgrouppanel)
guiSetProperty(invt2, "NormalTextColour", "FFFFFEFE")
grouplistb2 = guiCreateButton(128, 51, 110, 22, "Grupos", false, Pgrouppanel)
guiSetProperty(grouplistb2, "NormalTextColour", "FFFFFEFE")
gpmoney2 = guiCreateButton(12, 80, 110, 22, "Abandonar grupo", false, Pgrouppanel)
guiSetProperty(gpmoney2, "NormalTextColour", "FFFFFEFE")
newclose2 = guiCreateButton(128, 80, 110, 22, "Cerrar", false, Pgrouppanel)
guiSetProperty(newclose2, "NormalTextColour", "FFFFFEFE")
actualizgrplabel = guiCreateLabel(10, 23, 156, 18, "Grupo:", false, Pgrouppanel)
guiSetFont(actualizgrplabel, "default-bold-small")
members2 = guiCreateButton(243, 51, 110, 22, "Miembros", false, Pgrouppanel)
guiSetProperty(members2, "NormalTextColour", "FFFFFEFE")
configgp = guiCreateButton(243, 80, 110, 22, "Gestionar grupo", false, Pgrouppanel)
guiSetProperty(configgp, "NormalTextColour", "FFFFFEFE")
lblinfo = guiCreateLabel(12, 112, 341, 18, "Información", false, Pgrouppanel)
guiSetFont(lblinfo, "clear-normal")
guiLabelSetHorizontalAlign(lblinfo, "center", false)
scrollpane = guiCreateScrollPane(12, 130, 341, 119, false, Pgrouppanel)
information_label = guiCreateLabel(0, 0, 320, 20, "", false, scrollpane)
guiLabelSetHorizontalAlign(information_label, "left", true)

guiSetVisible(Pgrouppanel,false)
centerWindow(Pgrouppanel)

infopanelg = guiCreateWindow(10, 45, 378, 323, "Informacion", false)
guiWindowSetSizable(infopanelg, false)

memoinfogp = guiCreateMemo(9, 25, 359, 254, "", false, infopanelg)
guiMemoSetReadOnly(memoinfogp, true)
closebinfo = guiCreateButton(292, 287, 71, 27, "Cerrar", false, infopanelg)
guiSetFont(closebinfo, "default-bold-small")
guiSetProperty(closebinfo, "NormalTextColour", "FFAAAAAA")

guiSetVisible(infopanelg,false)
centerWindow (infopanelg)


gplistgw = guiCreateWindow(961, 0, 309, 324, "Lista de grupos", false)
guiWindowSetSizable(gplistgw, false)

gridlistgps = guiCreateGridList(13, 33, 284, 225, false, gplistgw)
namegpl = guiGridListAddColumn(gridlistgps, "Nombre del grupo", 0.5)
membgpl = guiGridListAddColumn(gridlistgps, "Miembros", 0.4)
cerrarglgps = guiCreateButton(228, 282, 71, 32, "Cerrar", false, gplistgw)
guiSetFont(cerrarglgps, "default-bold-small")
guiSetProperty(cerrarglgps, "NormalTextColour", "FFAAAAAA")
guiSetVisible(gplistgw,false)
centerWindow (gplistgw)
       


guiconfiggp = guiCreateWindow(386, 113, 420, 367, "Configuración", false)
guiWindowSetSizable(guiconfiggp, false)

gridlistconfigmv = guiCreateGridList(14, 34, 392, 200, false, guiconfiggp)
namecol = guiGridListAddColumn(gridlistconfigmv, "Nick", 0.4)
acccol = guiGridListAddColumn(gridlistconfigmv, "Ult. Activo", 0.25)
rangcol = guiGridListAddColumn(gridlistconfigmv, "Rango", 0.3)
kickmembersb = guiCreateButton(24, 244, 81, 30, "Expulsar", false, guiconfiggp)
guiSetFont(kickmembersb, "default-bold-small")
guiSetProperty(kickmembersb, "NormalTextColour", "FFAAAAAA")
banmembers = guiCreateButton(118, 244, 81, 30, "Personalizar Chat", false, guiconfiggp)
guiSetFont(banmembers, "default-bold-small")
guiSetProperty(banmembers, "NormalTextColour", "FFAAAAAA")
promotemembers = guiCreateButton(214, 244, 81, 30, "Cambiar rango", false, guiconfiggp)
guiSetFont(promotemembers, "default-bold-small")
guiSetProperty(promotemembers, "NormalTextColour", "FFAAAAAA")
buyslots = guiCreateButton(118, 284, 81, 30, "Mis Alianzas", false, guiconfiggp)
guiSetFont(buyslots, "default-bold-small")
guiSetProperty(buyslots, "NormalTextColour", "FFAAAAAA")
invnewmemb = guiCreateButton(311, 244, 81, 30, "Invitar Jugador", false, guiconfiggp)
guiSetFont(invnewmemb, "default-bold-small")
guiSetProperty(invnewmemb, "NormalTextColour", "FFAAAAAA")
editinfo = guiCreateButton(24, 284, 81, 30, "Editar informacion", false, guiconfiggp)
guiSetFont(editinfo, "default-bold-small")
guiSetProperty(editinfo, "NormalTextColour", "FFAAAAAA")
deletegp = guiCreateButton(118, 324, 81, 30, "Borrar grupo", false, guiconfiggp)
guiSetFont(deletegp, "default-bold-small")
guiSetProperty(deletegp, "NormalTextColour", "FFAAAAAA")
leavegroup = guiCreateButton(214, 284, 81, 30, "Administrar rangos", false, guiconfiggp)
guiSetFont(leavegroup, "default-bold-small")
guiSetProperty(leavegroup, "NormalTextColour", "FFAAAAAA")
logsOpen = guiCreateButton(311, 284, 81, 30, "Logs", false, guiconfiggp)
guiSetFont(logsOpen, "default-bold-small")
guiSetProperty(logsOpen, "NormalTextColour", "FFAAAAAA")
closeconfiggui = guiCreateButton(214, 324, 81, 30, "Cerrar", false, guiconfiggp)
guiSetFont(closeconfiggui, "default-bold-small")
guiSetProperty(closeconfiggui, "NormalTextColour", "FFAAAAAA")
change_name = guiCreateButton(24, 324, 81, 30, "Cambiar nombre grupo", false, guiconfiggp)
guiSetFont(change_name, "default-bold-small")
guiSetProperty(change_name, "NormalTextColour", "FFAAAAAA")
guiSetVisible(guiconfiggp,false)
centerWindow (guiconfiggp)

guiinfogpedit = guiCreateWindow(425, 104, 339, 317, "Editar información", false)
guiWindowSetSizable(guiinfogpedit, false)

memoinfoedit = guiCreateMemo(13, 32, 315, 226, "", false, guiinfogpedit)
saveinfob = guiCreateButton(15, 271, 83, 34, "Guardar", false, guiinfogpedit)
guiSetFont(saveinfob, "default-bold-small")
guiSetProperty(saveinfob, "NormalTextColour", "FFAAAAAA")
closeeditinfobt = guiCreateButton(108, 271, 83, 34, "Cerrar", false, guiinfogpedit)
guiSetFont(closeeditinfobt, "default-bold-small")
guiSetProperty(closeeditinfobt, "NormalTextColour", "FFAAAAAA")  
guiSetVisible(guiinfogpedit,false)  
centerWindow (guiinfogpedit)
  
guiinviteplayer = guiCreateWindow(434, 118, 443, 381, "Invitar un nuevo juador", false)
guiWindowSetSizable(guiinviteplayer, false)

asdasd = guiCreateLabel(17, 34, 117, 15, "Lista de jugadores", false, guiinviteplayer)
guiSetFont(asdasd, "default-bold-small")
gridlistsendinv = guiCreateGridList(17, 59, 199, 312, false, guiinviteplayer)
plinvd = guiGridListAddColumn(gridlistsendinv, "Jugador", 0.6)
plyon = guiGridListAddColumn(gridlistsendinv, "Grupo", 0.2)
sendinvit = guiCreateButton(231, 69, 87, 34, "Mandar invitación", false, guiinviteplayer)
guiSetFont(sendinvit, "default-bold-small")
guiSetProperty(sendinvit, "NormalTextColour", "FFAAAAAA")
refreshlist = guiCreateButton(328, 69, 87, 34, "Actualizar lista", false, guiinviteplayer)
guiSetFont(refreshlist, "default-bold-small")
guiSetProperty(refreshlist, "NormalTextColour", "FFAAAAAA")
cerrapanelivn = guiCreateButton(231, 113, 87, 34, "Cerrar panel", false, guiinviteplayer)
guiSetFont(cerrapanelivn, "default-bold-small")
guiSetProperty(cerrapanelivn, "NormalTextColour", "FFAAAAAA")
guiSetVisible(guiinviteplayer,false)  
centerWindow (guiinviteplayer)

guicolor = guiCreateWindow(494, 252, 319, 134, "Color del grupo", false)
guiWindowSetSizable(guicolor, false)

PRINCIPALGUI.label[1] = guiCreateLabel(8, 27, 139, 17, "Escribe los colores R,G,B", false, guicolor)
guiSetFont(PRINCIPALGUI.label[1], "default-bold-small")
editr = guiCreateEdit(34, 60, 43, 24, "", false, guicolor)
guiEditSetMaxLength(editr, 3)
PRINCIPALGUI.label[2] = guiCreateLabel(9, 64, 15, 14, "R:", false, guicolor)
guiSetFont(PRINCIPALGUI.label[2], "default-bold-small")
editg = guiCreateEdit(94, 60, 43, 24, "", false, guicolor)
guiEditSetMaxLength(editg, 3)
editb = guiCreateEdit(153, 60, 43, 24, "", false, guicolor)
guiEditSetMaxLength(editb, 3)
PRINCIPALGUI.label[3] = guiCreateLabel(79, 64, 15, 14, "G:", false, guicolor)
guiSetFont(PRINCIPALGUI.label[3], "default-bold-small")
PRINCIPALGUI.label[4] = guiCreateLabel(138, 64, 15, 14, "B:", false, guicolor)
guiSetFont(PRINCIPALGUI.label[4], "default-bold-small")
PRINCIPALGUI.label[5] = guiCreateLabel(8, 94, 155, 17, "Ejemplo Color rojo: 255,0,0", false, guicolor)
guiSetFont(PRINCIPALGUI.label[5], "default-bold-small")
acepchangcolor = guiCreateButton(189, 100, 54, 24, "Aceptar", false, guicolor)
guiSetFont(acepchangcolor, "default-bold-small")
guiSetProperty(acepchangcolor, "NormalTextColour", "FFAAAAAA")
cancelcolorclose = guiCreateButton(253, 100, 54, 24, "Cancelar", false, guicolor)
guiSetFont(cancelcolorclose, "default-bold-small")
guiSetProperty(cancelcolorclose, "NormalTextColour", "FFAAAAAA")   
guiSetVisible( guicolor,false)  
centerWindow ( guicolor ) 

guimembersgp = guiCreateWindow(386, 113, 420, 287, "Miembros", false)
guiWindowSetSizable(guimembersgp, false)

gridmiemview = guiCreateGridList(14, 34, 392, 200, false, guimembersgp)
plggm = guiGridListAddColumn(gridmiemview, "Nick", 0.4)
plgac = guiGridListAddColumn(gridmiemview, "Ult. Activo", 0.25)
plrac = guiGridListAddColumn(gridmiemview, "Rango", 0.3)
closemembgui = guiCreateButton(328, 244, 68, 33, "Cerrar", false, guimembersgp)
guiSetFont(closemembgui, "default-bold-small")
guiSetProperty(closemembgui, "NormalTextColour", "FFAAAAAA")
guiSetVisible( guimembersgp,false)  
centerWindow ( guimembersgp )     

colorchangegui = guiCreateWindow(514, 189, 225, 252, "Colores del chat", false)
guiWindowSetSizable(colorchangegui, false)

PRINCIPALGUI.label[1] = guiCreateLabel(10, 29, 60, 15, "Color Tag", false, colorchangegui)
guiSetFont(PRINCIPALGUI.label[1], "default-bold-small")
PRINCIPALGUI.label[2] = guiCreateLabel(10, 91, 85, 15, "Color Mensaje", false, colorchangegui)
guiSetFont(PRINCIPALGUI.label[2], "default-bold-small")
PRINCIPALGUI.label[3] = guiCreateLabel(10, 194, 219, 63, "Web de colores Hexadecimales:\nClick para copiar\nhttps://color.adobe.com/es/explore/", false, colorchangegui)
guiSetFont(PRINCIPALGUI.label[3], "default-bold-small")
guiLabelSetHorizontalAlign(PRINCIPALGUI.label[3], "left", true)    


editcolortag = guiCreateEdit(10, 50, 199, 31, "#00ff00", false, colorchangegui)
guiEditSetMaxLength(editcolortag, 7)

editcolormsj = guiCreateEdit(10, 116, 199, 31, "#00ff00", false, colorchangegui)
guiEditSetMaxLength(editcolormsj, 7)

savecolorcg = guiCreateButton(85, 157, 52, 27, "Guardar", false, colorchangegui)
guiSetFont(savecolorcg, "default-bold-small")
colorchatclose = guiCreateButton(147, 157, 52, 27, "Cancelar", false, colorchangegui)
guiSetFont(colorchatclose, "default-bold-small")
guiSetVisible( colorchangegui,false)  
centerWindow ( colorchangegui )

function add_event ( event_name, event_to, funcion )

     addEvent(
          event_name, 
          true
     )
     addEventHandler(
          event_name, 
          event_to, 
          funcion
     )

end


add_event( "cpn_client_event", localPlayer, function (  )
     guiSetVisible( 
          FCPN.window[1],
          false
     )
     openconfiggroup();
end)


--[[/*=============================================
=            CPN SYSTEM                          =
=============================================*/--]]

FCPN = {
    button = {},
    window = {},
    label = {}
}
FCPN.window[1] = guiCreateWindow(500, 235, 301, 110, "Formulario", false)
guiWindowSetSizable(FCPN.window[1], false)

FCPN.label[1] = guiCreateLabel(17, 36, 146, 18, "Escribe el nuevo nombre", false, FCPN.window[1])
guiSetFont(FCPN.label[1], "default-bold-small")
n_g_Nombre = guiCreateEdit(17, 54, 187, 31, "", false, FCPN.window[1])
guiEditSetMaxLength(n_g_Nombre, 50)
FCPN.button[1] = guiCreateButton(214, 61, 69, 24, "Cambiar", false, FCPN.window[1])
guiSetFont(FCPN.button[1], "default-bold-small")
guiSetProperty(FCPN.button[1], "NormalTextColour", "FFFFFFFF")
FCPN.button[2] = guiCreateButton(245, 22, 47, 18, "X", false, FCPN.window[1])
guiSetFont(FCPN.button[2], "default-bold-small")
guiSetProperty(FCPN.button[2], "NormalTextColour", "FFFFFFFF")

local window = FCPN.window[1];

guiSetVisible(window,false)
centerWindow(window)

function open_fcpn( bool )
     gSetVisible( window, bool );
end

function button_n( button )
     
     local i = nil;
     if ( button == FCPN.button[1] ) then
          i = 1;
     elseif ( button == FCPN.button[2] ) then
          i = 2;
     end

     return i;

end

function click_buttons( )

     switch{ button_n(source);
          1, function() 
            create_notify_window( "AcceptCancel", { title = "Advertencia", description = "¿Estás seguro que quieres cambiar el nombre del grupo?"}, 
            function( dialogResult ) 
              if ( dialogResult.Accept == true ) then
                triggerServerEvent( "cServerName", localPlayer, n_g_Nombre:getText() )
              end
            end)
          end,
          2, function() guiSetVisible(window,false) openconfiggroup(  ) end,
     }

end
addEventHandler("onClientGUIClick", root, click_buttons )

function open_principalgui( )
    -- body
    triggerServerEvent("gpgpphelpinfo",getLocalPlayer());
    triggerServerEvent("get_group_datas", getLocalPlayer() )
    if( localPlayer:getData( "gang") and localPlayer:getData( "gang") ~= "N/A") then 
        guiSetVisible(grouppanel,false)
        gSetVisible(Pgrouppanel,true)
    else
        guiSetVisible(Pgrouppanel,false)
        gSetVisible(grouppanel,true)
        guiSetEnabled( creategpb, true)
        guiSetEnabled(editcrgp,true)
    end
end

addEventHandler("onClientGUIClick", change_name, 
function()
    gSetVisible(FCPN.window[1],true);
    guiSetVisible(guiconfiggp,false)
end, false)

function adsds(  )
    guiSetVisible ( alianzasGUI.window[2], false )
   guiSetVisible ( alianzasGUI.window[3], false )
   guiSetVisible ( alianzasGUI.window[4], false )
   guiSetVisible ( alianzasGUI.window[1], false )
   guiSetVisible(gplistgw,false)
   guiSetVisible(grouppanel,false)
   guiSetVisible(Pgrouppanel,false)
   guiSetVisible(guicolor,false)
   guiSetVisible( guimembersgp,false) 
   guiSetVisible(guiinfogpedit,false) 
   -- guiSetVisible(promotegui,false)
   guiSetVisible(guiinviteplayer,false)
   guiSetVisible(guiconfiggp,false)
   guiSetVisible( colorchangegui,false)  
   guiSetVisible( infopanelg,false)  
   guiSetVisible ( rangosMain, false)
   guiSetVisible ( admRangos.window[1], false)
   guiSetVisible( loggui, false )
   disableGPCGui()
   showCursor(false)
   guiSetInputEnabled( false )
end
addEventHandler("onClientGUIClick", newclose, adsds, false)
addEventHandler("onClientGUIClick", newclose2, adsds, false)

function openRangos(  )
    triggerServerEvent ( "getRanksGroup", getLocalPlayer(  ) )
    guiSetVisible( guiconfiggp, false )
    gSetVisible ( admRangos.window[1], true )
end
addEventHandler("onClientGUIClick", leavegroup, openRangos, false)

function leavegrousp(  )
     create_notify_window( "YesNo", { title = "Advertencia", description = "¿Estás seguro que quieres salir del grupo?"}, leaveG )
end
addEventHandler("onClientGUIClick", gpmoney2, leavegrousp, false)

function leaveG( dialogResult )

     if ( dialogResult.Yes == true ) then
          triggerServerEvent("leaveofgroup",getLocalPlayer(  ))
          guiSetVisible ( Pgrouppanel, false)

          setTimer(
            function()
          triggerServerEvent("get_group_datas", getLocalPlayer() )
          guiSetText( editcrgp, "")
          open_principalgui( );
          end, 1000, 1 )
     end

end

function openconfiggroup(  )
    guiSetVisible(Pgrouppanel,false)
    guiSetVisible(grouppanel,false)
    gSetVisible(guiconfiggp,true)
    clearCList()
end
addEventHandler("onClientGUIClick", configgp, openconfiggroup, false)

function openmaingroup(  )
    open_principalgui( );
    guiSetVisible(guiconfiggp,false)
end
addEventHandler("onClientGUIClick", closeconfiggui, openmaingroup, false)

function listgroups(  )
    guiSetEnabled( grouplistb, false )
    setTimer( guiSetEnabled, 3000, 1, grouplistb, true )
    guiGridListClear(gridlistgps)
    guiSetVisible(grouppanel,false)
    guiSetVisible(Pgrouppanel,false)
    guiSetVisible(guiconfiggp,false)
    gSetVisible(gplistgw,true)
    triggerServerEvent("gtlistgpsv",getLocalPlayer(  ))
end
addEventHandler("onClientGUIClick", grouplistb, listgroups, false)
addEventHandler("onClientGUIClick", grouplistb2, listgroups, false)

function sxdsxs(  )
    open_principalgui( );
    guiSetVisible(gplistgw,false)
end
addEventHandler("onClientGUIClick", cerrarglgps, sxdsxs, false)

function editinsadfo(  )
    guiSetEnabled( editinfo, false )
    setTimer( guiSetEnabled, 3000, 1, editinfo, true )
    guiSetVisible(grouppanel,false)
    guiSetVisible(Pgrouppanel,false)
    guiSetVisible(guiconfiggp,false)
    gSetVisible(guiinfogpedit,true)
    triggerServerEvent("setinfotoedit",getLocalPlayer(  ))
end
addEventHandler("onClientGUIClick", editinfo, editinsadfo, false)

function viewinfo(  )
    guiSetVisible(grouppanel,false)
    guiSetVisible(Pgrouppanel,false)
    gSetVisible(infopanelg,true)
    triggerServerEvent("gpgpphelpinfo",getLocalPlayer())
end
addEventHandler("onClientGUIClick", infogp, viewinfo, false)

function sss(  )
    guiSetVisible(infopanelg,false)
    open_principalgui( );
end
addEventHandler("onClientGUIClick", closebinfo, sss, false)

function ssss(  )
    guiSetVisible(guiinfogpedit,false)
    gSetVisible(guiconfiggp,true)
end
addEventHandler("onClientGUIClick", closeeditinfobt, ssss, false)

function openviewmyinvities(  )
     guiSetEnabled( invt, false )
     setTimer( guiSetEnabled, 3000, 1, invt, true )
     local InvTab = getElementData( getLocalPlayer( ) , "InvTable" ) or false
     if InvTab then
          createNotification( "Tienes una invitacion de: "..InvTab.." Usa /aceptar")
     else
          createNotification( "No tienes invitaciones.")
     end
end
addEventHandler("onClientGUIClick", invt, openviewmyinvities, false)
addEventHandler("onClientGUIClick", invt2, openviewmyinvities, false)

function openivinte(  )
    guiSetVisible(guiconfiggp,false)
    gSetVisible(guiinviteplayer,true)
    requestListInvitation( )
end
addEventHandler("onClientGUIClick", invnewmemb, openivinte, false)

function closeingv(  )
    gSetVisible(guiconfiggp,true)
    guiSetVisible(guiinviteplayer,false)
end
addEventHandler("onClientGUIClick", cerrapanelivn, closeingv, false)

function openpromotegui(  )
    local row,col = guiGridListGetSelectedItem( gridlistconfigmv )
    local name = guiGridListGetItemText( gridlistconfigmv, row, namecol )
    if row == -1 or col == -1 then 
      createNotification( "Debes seleccionar un jugador!")
      return false 
    end

    if( name ~= localPlayer:getName() ) then
      getLocalPlayer(  ):setData( "to_ch_rank", name)
      guiSetVisible(guiconfiggp,false)
      triggerServerEvent("get_ranks_list", getLocalPlayer(  ))
    else
      createNotification( "Selecciona otro jugador que no seas tú!")
    end
end
addEventHandler("onClientGUIClick", promotemembers, openpromotegui, false)

function openchangecolor(  )
	triggerServerEvent("coloresOfGroup",getLocalPlayer())
    guiSetVisible(guiconfiggp,false)
    gSetVisible( colorchangegui, true ) 
end
addEventHandler("onClientGUIClick", banmembers, openchangecolor, false)

function closechangecolor(  )
    gSetVisible(guiconfiggp,true)
    guiSetVisible(colorchangegui,false)
end
addEventHandler("onClientGUIClick", colorchatclose, closechangecolor, false)

function opemmebviewgui(  )
    gSetVisible(guimembersgp,true)
    guiSetVisible(grouppanel,false)
    guiSetVisible(Pgrouppanel,false)
    guiGridListClear( gridmiemview ) 
    triggerServerEvent("viewmembersall",getLocalPlayer(  ))
end
addEventHandler("onClientGUIClick", members, opemmebviewgui, false)
addEventHandler("onClientGUIClick", members2, opemmebviewgui, false)

function closemebviewgui(  )
    guiSetVisible(guimembersgp,false)
    open_principalgui( );
end
addEventHandler("onClientGUIClick", closemembgui, closemebviewgui, false)

function donechangecolor(  )
    local colorTag  = editcolortag:getText()
    local colorChat = editcolormsj:getText()


    if getColorFromString( colorTag ) and getColorFromString( colorChat ) then
        gSetVisible(guiconfiggp,true)
        guiSetVisible(colorchangegui,false)
        triggerServerEvent("donecolorchange",getLocalPlayer(  ), colorTag, colorChat )
    else
        createNotification("Colores invalidos!", 200, 0, 0, true)
    end
    guiSetEnabled( savecolorcg, false )
    setTimer( guiSetEnabled, 20000, 1, savecolorcg, true )
end
addEventHandler("onClientGUIClick", savecolorcg, donechangecolor, false)

function re(  )
    requestListInvitation( )
    guiSetEnabled( refreshlist, false )
    setTimer( guiSetEnabled, 3000, 1, refreshlist, true )
end
addEventHandler("onClientGUIClick", refreshlist, re, false)

function requestListInvitation(  )
    guiGridListClear( gridlistsendinv )
    triggerServerEvent("getlistofplinvto", getLocalPlayer(  ));
end


addEventHandler("onClientGUIClick", deletegp, 
function (  )
     create_notify_window( "YesNo", { title = "Advertencia", description = "¿Estás seguro que quieres eliminar el grupo?"}, delete_my_gp )
end, false)

function delete_my_gp( dialogResult )

     if( dialogResult.Yes == true ) then
          triggerServerEvent( "deletemygp", getLocalPlayer(  ) )
          guiSetVisible ( guiconfiggp, false)
          guiSetVisible ( guiconfig, false)
          setTimer( 
               function() 
                    open_principalgui( );
                    triggerServerEvent("get_group_datas", getLocalPlayer() )
               end, 
          500, 1 )
     end

end

function saveeditedinfo(  )
    guiSetVisible(guiinfogpedit,false)
    gSetVisible(guiconfiggp,true)
    local text = memoinfoedit:getText()
    triggerServerEvent("saveAeditedinfos",getLocalPlayer(),text)
end
addEventHandler("onClientGUIClick", saveinfob, saveeditedinfo, false)

function kickAmember(  )
    local row,col = guiGridListGetSelectedItem( gridlistconfigmv )
    local name = guiGridListGetItemText( gridlistconfigmv, row, namecol )
    if row == -1 or col == -1 then return false end
    showRS( name )
end
addEventHandler("onClientGUIClick", kickmembersb, kickAmember, false)

function invAmember(  )
    local row,col = guiGridListGetSelectedItem( gridlistsendinv )
    local name = guiGridListGetItemText( gridlistsendinv, row, plinvd )
    if row == -1 or col == -1 then return false end
    triggerServerEvent("sendainvtopl",getLocalPlayer(),name)
    guiSetEnabled( sendinvit, false )
    setTimer( guiSetEnabled, 3000, 1, sendinvit, true )
end
addEventHandler("onClientGUIClick", sendinvit, invAmember, false)


function createagroup(  )
    local name = string.gsub( guiGetText(editcrgp),"%s",'_')
    local k = name
    local ag = string.lower(k)
     if string.len(name) < 4 then 
          createNotification("Solo un nombre mayor a 4 caracteres", 255, 255, 255, true )
          return
     elseif type ( tonumber( name ) ) == "number" then
          createNotification( "Nombre invalido!", 255, 255, 255, true  )
          return
     end
     triggerServerEvent("createnewGroup",localPlayer,k);
     guiSetVisible ( grouppanel, false)
     setTimer( 
     function() 
          open_principalgui( );
          triggerServerEvent("get_group_datas", getLocalPlayer() )
     end, 500, 1 )
end
addEventHandler("onClientGUIClick", creategpb, createagroup, false)


function openAlianza(  )
     openClosePanel( );
end
addEventHandler("onClientGUIClick", buyslots, openAlianza, false)

addEventHandler("onClientGUIClick", PRINCIPALGUI.label[3],
function (  )
  -- Codigo extraido de la wiki
  -- https://wiki.multitheftauto.com/wiki/SetClipboard
  local success = setClipboard( "https://color.adobe.com/es/explore/" )
  if success then
     createNotification( "Link copiado!");
  end
end
 , false)