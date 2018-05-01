---------------------------------------------------------------------
--  Desarrollador/Developer: -Rex-
--  Proyecto/Proyect:        N/A
--  Contacto/Contact:        https://www.facebook.com/rexscripting/
--
--  Libre uso y modificacion, No borrar los creditos, Gracias
---------------------------------------------------------------------
addEvent( "sendACGPCList", true )
addEvent( "textLabels", true )
addEvent( "openGPCGUI", true )
addEvent( "sendServerListGPC", true )
addEvent( "sendChatRegGPC", true )
addEvent( "clearGPCListG", true )
addEvent( "sendInfoOfGPC", true )
addEvent( "sendGPCMembersGPList", true )
addEvent( "labelsGPCTextmm", true )
addEvent( "sendTablePlAdd", true )
addEvent( "refreshGPCListMmm", true )

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

local serverEvent = triggerServerEvent
local group_selected
local player_selected

messageG = {
    [1] = "Por favor selecciona Algo de la lista",
    [2] = "Ingresa una cantidad mayor a 2 digitos",
    [3] = "No puedes eliminar a un Fundador!",
    [4] = "Error! El jugador ya tiene grupo"
}

admpanel = {
    label = {}
}

admingrouppanel = guiCreateWindow(442, 44, 437, 443, "Administracion de grupos", false)
guiWindowSetSizable(admingrouppanel, false)
centerWindow(admingrouppanel)
tabpanel = guiCreateTabPanel(9, 21, 418, 412, false, admingrouppanel)

tabgrupos = guiCreateTab("Grupos", tabpanel)

gruposlist = guiCreateGridList(7, 13, 172, 365, false, tabgrupos)
group1 = guiGridListAddColumn(gruposlist, "Grupo", 0.5)
slots1 = guiGridListAddColumn(gruposlist, "Slots", 0.5)
delgp = guiCreateButton(194, 27, 87, 40, "Borrar grupo", false, tabgrupos)
guiSetFont(delgp, "default-bold-small")
guiSetProperty(delgp, "NormalTextColour", "FFAAAAAA")
editslots = guiCreateButton(305, 27, 87, 40, "Editar slots", false, tabgrupos)
guiSetFont(editslots, "default-bold-small")
guiSetProperty(editslots, "NormalTextColour", "FFAAAAAA")
editcggname = guiCreateButton(194, 77, 87, 40, "Editar nombre", false, tabgrupos)
guiSetFont(editcggname, "default-bold-small")
guiSetProperty(editcggname, "NormalTextColour", "FFAAAAAA")
editinfo = guiCreateButton(305, 77, 87, 40, "Editar informacion", false, tabgrupos)
guiSetFont(editinfo, "default-bold-small")
guiSetProperty(editinfo, "NormalTextColour", "FFAAAAAA")
admpanel.label[1] = guiCreateLabel(195, 185, 96, 15, "Total miembros:", false, tabgrupos)
guiSetFont(admpanel.label[1], "default-bold-small")
totalmmlabel = guiCreateLabel(291, 185, 96, 15, "", false, tabgrupos)
guiSetFont(totalmmlabel, "default-bold-small")
admpanel.label[2] = guiCreateLabel(195, 210, 67, 15, "Total slots:", false, tabgrupos)
guiSetFont(admpanel.label[2], "default-bold-small")
totalslotsllbl = guiCreateLabel(262, 210, 96, 15, "", false, tabgrupos)
guiSetFont(totalslotsllbl, "default-bold-small")
admpanel.label[3] = guiCreateLabel(195, 235, 96, 15, "Lideres activos:", false, tabgrupos)
guiSetFont(admpanel.label[3], "default-bold-small")
activeleaders = guiCreateLabel(194, 260, 214, 44, "", false, tabgrupos)
guiSetFont(activeleaders, "default-bold-small")
guiLabelSetHorizontalAlign(activeleaders, "left", true)

--fecha
fechaconfg = guiCreateLabel(302, 314, 96, 15, "", false, tabgrupos)
guiSetFont(fechaconfg, "default-bold-small")
-------------------------

groupconfig = guiCreateButton(194, 127, 87, 40, "Configuracion de grupo", false, tabgrupos)
guiSetFont(groupconfig, "default-bold-small")
guiSetProperty(groupconfig, "NormalTextColour", "FFAAAAAA")
cerrar1 = guiCreateButton(305, 127, 87, 40, "Cerrar", false, tabgrupos)
guiSetFont(cerrar1, "default-bold-small")
guiSetProperty(cerrar1, "NormalTextColour", "FFAAAAAA")

guiSetVisible(admingrouppanel, false )


maineditslots = guiCreateWindow(470, 205, 246, 136, "Editar slots", false)
guiWindowSetSizable(maineditslots, false)
centerWindow( maineditslots )
labsaanbsadjadisda = guiCreateLabel(14, 30, 197, 18, "Ingresa la nueva cantidad de slots", false, maineditslots)
guiSetFont(labsaanbsadjadisda, "default-bold-small")
editsss = guiCreateEdit(13, 58, 216, 26, "", false, maineditslots)
guiEditSetMaxLength(editsss, 4)
contieslotsedit = guiCreateButton(13, 97, 64, 25, "Continuar", false, maineditslots)
guiSetFont(contieslotsedit, "default-bold-small")
guiSetProperty(contieslotsedit, "NormalTextColour", "FFAAAAAA")
cancels1 = guiCreateButton(87, 97, 64, 25, "Cancelar", false, maineditslots)
guiSetFont(cancels1, "default-bold-small")
guiSetProperty(cancels1, "NormalTextColour", "FFAAAAAA")
guiSetVisible(maineditslots, false )

guiconfig = guiCreateWindow(410, 98, 478, 408, "Configuracion de grupo", false)
guiWindowSetSizable(guiconfig, false)
guiSetVisible(guiconfig, false )
configlistmembers = guiCreateGridList(10, 66, 234, 328, false, guiconfig)
nickgpc = guiGridListAddColumn(configlistmembers, "Nick", 0.5)
rangogpc = guiGridListAddColumn(configlistmembers, "Rango", 0.35)
--estadogpc = guiGridListAddColumn(configlistmembers, "Estado", 0.3)
editfind = guiCreateEdit(10, 33, 162, 27, "", false, guiconfig)
kickmember = guiCreateButton(267, 67, 82, 37, "Expulsar Miembro", false, guiconfig)
guiSetFont(kickmember, "default-bold-small")
guiSetProperty(kickmember, "NormalTextColour", "FFAAAAAA")
addmember = guiCreateButton(359, 67, 82, 37, "Agregar miembro", false, guiconfig)
guiSetFont(addmember, "default-bold-small")
guiSetProperty(addmember, "NormalTextColour", "FFAAAAAA")
editrango = guiCreateButton(267, 114, 82, 37, "Editar rango", false, guiconfig)
guiSetFont(editrango, "default-bold-small")
guiSetProperty(editrango, "NormalTextColour", "FFAAAAAA")
close5 = guiCreateButton(359, 114, 82, 37, "Cerrar", false, guiconfig)
guiSetFont(close5, "default-bold-small")
guiSetProperty(close5, "NormalTextColour", "FFAAAAAA")
admpanel.label[1] = guiCreateLabel(269, 167, 80, 16, "Nickname:", false, guiconfig)
guiSetFont(admpanel.label[1], "default-bold-small")
lblnamer = guiCreateLabel(332, 167, 109, 16, "", false, guiconfig)
guiSetFont(lblnamer, "default-bold-small")
admpanel.label[2] = guiCreateLabel(269, 193, 80, 16, "Cuenta:", false, guiconfig)
guiSetFont(admpanel.label[2], "default-bold-small")
lblcuentac = guiCreateLabel(332, 193, 109, 16, "", false, guiconfig)
guiSetFont(lblcuentac, "default-bold-small")
admpanel.label[3] = guiCreateLabel(269, 219, 80, 16, "Rango:", false, guiconfig)
guiSetFont(admpanel.label[3], "default-bold-small")
lblfoundr = guiCreateLabel(332, 219, 109, 16, "", false, guiconfig)
guiSetFont(lblfoundr, "default-bold-small")
centerWindow(guiconfig)

addplto = guiCreateWindow(432, 114, 385, 419, "Agregar miembro", false)
guiWindowSetSizable(addplto, false)
guiSetVisible(addplto, false )
addmcpslala = guiCreateGridList(15, 60, 189, 338, false, addplto)
nmAggg = guiGridListAddColumn(addmcpslala, "Nombre", 0.5)
gpgpcm = guiGridListAddColumn(addmcpslala, "Grupo", 0.5)
editplfindaddg = guiCreateEdit(15, 29, 189, 25, "", false, addplto)
addto = guiCreateButton(214, 64, 71, 40, "Agregar", false, addplto)
guiSetFont(addto, "default-bold-small")
guiSetProperty(addto, "NormalTextColour", "FFAAAAAA")
refreshpllistadd = guiCreateButton(295, 64, 71, 40, "Actualizar Lista", false, addplto)
guiSetFont(refreshpllistadd, "default-bold-small")
guiSetProperty(refreshpllistadd, "NormalTextColour", "FFAAAAAA")
close6 = guiCreateButton(214, 114, 71, 40, "Cerrar", false, addplto)
guiSetFont(close6, "default-bold-small")
guiSetProperty(close6, "NormalTextColour", "FFAAAAAA")
centerWindow(addplto)


infoeditadmin = guiCreateWindow(451, 143, 308, 401, "Editar informacion", false)
guiWindowSetSizable(infoeditadmin, false)

memogpced = guiCreateMemo(10, 40, 288, 315, "", false, infoeditadmin)
continuegpceditinfo = guiCreateButton(127, 368, 61, 23, "Continuar", false, infoeditadmin)
guiSetFont(continuegpceditinfo, "default-bold-small")
guiSetProperty(continuegpceditinfo, "NormalTextColour", "FFAAAAAA")
close12 = guiCreateButton(227, 368, 61, 23, "Cerrar", false, infoeditadmin)
guiSetFont(close12, "default-bold-small")
guiSetProperty(close12, "NormalTextColour", "FFAAAAAA")
centerWindow(infoeditadmin)
guiSetVisible(infoeditadmin, false )

guigpcrang = guiCreateWindow(522, 235, 236, 130, "Editar rango", false)
guiWindowSetSizable(guigpcrang, false)

boxranggpc = guiCreateComboBox(14, 42, 212, 78, "", false, guigpcrang)
saddsa = guiCreateLabel(14, 22, 136, 15, "Selecciona un rango", false, guigpcrang)
guiSetFont(saddsa, "default-bold-small")
conteditrang = guiCreateButton(14, 87, 71, 33, "Continuar", false, guigpcrang)
guiSetFont(conteditrang, "default-bold-small")
guiSetProperty(conteditrang, "NormalTextColour", "FFAAAAAA")
cancel45 = guiCreateButton(95, 87, 71, 33, "Cancelar", false, guigpcrang)
guiSetFont(cancel45, "default-bold-small")
guiSetProperty(cancel45, "NormalTextColour", "FFAAAAAA")
centerWindow(guigpcrang)
guiSetVisible(guigpcrang, false )

maingpchgn = guiCreateWindow(488, 212, 241, 140, "Editar nombre", false)
guiWindowSetSizable(maingpchgn, false)

sad = guiCreateLabel(16, 28, 160, 17, "Ingresa el nuevo nombre", false, maingpchgn)
guiSetFont(sad, "default-bold-small")
editgpchgnm = guiCreateEdit(16, 50, 210, 27, "", false, maingpchgn)
conteditgpnamece = guiCreateButton(16, 87, 68, 35, "Continuar", false, maingpchgn)
guiSetFont(conteditgpnamece, "default-bold-small")
guiSetProperty(conteditgpnamece, "NormalTextColour", "FFAAAAAA")
close1c1 = guiCreateButton(98, 87, 68, 35, "Cancelar", false, maingpchgn)
guiSetFont(close1c1, "default-bold-small")
guiSetProperty(close1c1, "NormalTextColour", "FFAAAAAA")
centerWindow(maingpchgn)
guiSetVisible(maingpchgn, false )


function openGPCINT( )
    if guiGetVisible( admingrouppanel ) == false then
        enableGPCGui()
        showCursor(true)
    else
        disableGPCGui()
        showCursor( false )
    end
end
addEventHandler( "openGPCGUI", getLocalPlayer(  ), openGPCINT )

function enableGPCGui()
    guiSetInputMode("no_binds_when_editing")
    guiGridListClear( gruposlist )
    serverEvent("getGPCListG", getLocalPlayer(  ))
    triggerServerEvent("getGPCActiList", getLocalPlayer(  ))
    gSetVisible ( admingrouppanel, true)
end

function disableGPCGui( )
    guiSetInputMode("allow_binds")
    guiGridListClear( gruposlist )
    guiSetVisible ( admingrouppanel, false)
    guiSetVisible ( addplto, false)
    guiSetVisible ( guiconfig, false)
    guiSetVisible ( addplto, false)
    guiSetVisible ( maineditslots, false)
    guiSetVisible ( admingrouppanel, false)
end

function textLabns( a, b )
    guiSetText( totalmmlabel, a)
    guiSetText( activeleaders, b)
end
addEventHandler( "textLabels", getLocalPlayer(  ), textLabns )

function setLabelsMainText( )
    local selected = guiGridListGetSelectedItem( gruposlist )
    local group = guiGridListGetItemText( gruposlist, selected, group1 )
    local slots = guiGridListGetItemText( gruposlist, selected, slots1 )
    if selected ==-1 then
        guiSetText( totalslotsllbl, "N/A")
        guiSetText( totalmmlabel, "N/A")
        guiSetText( activeleaders, "N/A")
    else
        guiSetText( totalslotsllbl, slots)
        triggerServerEvent("getGPCLabels",getLocalPlayer(  ), tostring( group ) )
    end
end
addEventHandler("onClientGUIClick", gruposlist, setLabelsMainText, false)

function recibeListaGPC( group,slots)
        local row = guiGridListAddRow( gruposlist )
        guiGridListSetItemText( gruposlist, row, group1, group, false, false )
        guiGridListSetItemText( gruposlist, row, slots1, slots, false, false )
        guiGridListSetItemColor( gruposlist, row, group1, 0,200,0,255 )
        guiGridListSetItemColor( gruposlist, row, slots1, 0,200,0,255 )
end
addEventHandler( "sendServerListGPC", getLocalPlayer(  ), recibeListaGPC )

function clearggg(  )
    guiGridListClear( gruposlist )
    serverEvent("getGPCListG", getLocalPlayer(  ))
end
addEventHandler( "clearGPCListG", getLocalPlayer(  ), clearggg )


function closeMainGUI(  )
    guiSetVisible( admingrouppanel, false)
    showCursor(false)
    openGPCGUIState = false
end
addEventHandler("onClientGUIClick", cerrar1, closeMainGUI, false)

function deleteAGP(  )
    local row, col = guiGridListGetSelectedItem( gruposlist )
    local group = guiGridListGetItemText( gruposlist, row, group1 )
    if row==-1 or col ==-1 then
        createNotification(messageG[1])
        return
    end
    triggerServerEvent("deleteAGP", getLocalPlayer(  ), group)
    enableGPCGui()
end
addEventHandler("onClientGUIClick", delgp, deleteAGP, false)

function editSlotsAGP(  )
    local row, col = guiGridListGetSelectedItem( gruposlist )
    local group = guiGridListGetItemText( gruposlist, row, group1 )
    if row==-1 or col ==-1 then
        createNotification(messageG[1])
        return
    end
    group_selected = group
    guiSetVisible( maineditslots, true )
    guiSetVisible( admingrouppanel, false )
end
addEventHandler("onClientGUIClick", editslots, editSlotsAGP, false)

function senddatasSlots ()
    local ammount = editsss:getText();
    if ammount:len() >= 2 then
        triggerServerEvent("editSlotsAGP", getLocalPlayer(  ), group_selected, ammount )
        guiSetVisible( maineditslots, false )
        enableGPCGui()
        group_selected = ""
    else
        createNotification(messageG[2])
    end
end
addEventHandler("onClientGUIClick", contieslotsedit, senddatasSlots, false)

function closeEditSlotsG(  )
    guiSetVisible( maineditslots, false )
     enableGPCGui()
    group_selected = ""
end
addEventHandler("onClientGUIClick", cancels1, closeEditSlotsG, false)

function getInfoEditGPC(  )
    local row = guiGridListGetSelectedItem( gruposlist )
    if row ==-1 then
        createNotification(messageG[1])
        return
    end
    local group = guiGridListGetItemText( gruposlist, row, group1 )
    group_selected = group
    triggerServerEvent("getGPCGROUPInfo", getLocalPlayer(  ), group_selected )
end
addEventHandler("onClientGUIClick", editinfo, getInfoEditGPC, false)

function recieGPCInfo( info )
    guiSetText( memogpced, info)
    guiSetVisible( admingrouppanel, false)
    guiSetVisible( infoeditadmin, true)
end
addEventHandler( "sendInfoOfGPC", getLocalPlayer(  ), recieGPCInfo )

function saveInfoGPC( )
    local texto = memogpced:getText()
    local grupo = group_selected;
    triggerServerEvent("saveINFOGPC", getLocalPlayer(  ), texto, grupo)
     enableGPCGui()
    guiSetVisible( infoeditadmin, false)
end
addEventHandler("onClientGUIClick", continuegpceditinfo, saveInfoGPC, false)

function closeinfogpcedit(  )
     enableGPCGui()
    guiSetVisible( infoeditadmin, false)
end
addEventHandler( "onClientGUIClick", close12, closeinfogpcedit, false )

function openConfigGPC(  )
    local row, col = guiGridListGetSelectedItem( gruposlist )
    local group = guiGridListGetItemText( gruposlist, row, group1 )
    if row==-1 or col ==-1 then
        createNotification(messageG[1])
        return
    end
    group_selected = group;
    guiGridListClear( configlistmembers )
    triggerServerEvent( "getMembersGPCList", getLocalPlayer(), group_selected )
    guiSetVisible( admingrouppanel, false )
    guiSetVisible( guiconfig, true )
end
addEventHandler( "onClientGUIClick", groupconfig, openConfigGPC, false )

function closConfigGPC(  )
    guiGridListClear( gruposlist )
    serverEvent("getGPCListG", getLocalPlayer(  ))
    guiSetVisible( admingrouppanel, true )
    guiSetVisible( guiconfig, false )
end
addEventHandler( "onClientGUIClick", close5, closConfigGPC, false )

function addListGPCMembers( tablee )
    for _, value in ipairs( tablee ) do
        local nick, rango, estado, r, g, b = value[1], value[2], value[3], value[4], value[5], value[6]
        local row = guiGridListAddRow( configlistmembers )
        guiGridListSetItemText( configlistmembers, row, nickgpc, nick, false, false )
        guiGridListSetItemText( configlistmembers, row, rangogpc, rango, false, false )
       -- guiGridListSetItemText( configlistmembers, row, estadogpc, estado, false, false )
        guiGridListSetItemColor( configlistmembers, row, nickgpc, r, g, b, 255 )
        guiGridListSetItemColor( configlistmembers, row, rangogpc, r, g, b, 255 )
       -- guiGridListSetItemColor( configlistmembers, row, estadogpc, r, g, b, 255 )
    end
end
addEventHandler( "sendGPCMembersGPList", getLocalPlayer(  ), addListGPCMembers )

function findAGPCPlMm(  )
    guiGridListClear( configlistmembers )
    local texto = editfind:getText();
    triggerServerEvent( "findMemberGPC", getLocalPlayer(  ), texto, group_selected )
end
addEventHandler("onClientGUIChanged" , editfind, findAGPCPlMm )

function setLablsGPCCCTxt(  )
    local row = guiGridListGetSelectedItem( configlistmembers )
    if row ==-1 then
        guiSetText( lblnamer, "N/A" )
        guiSetText( lblfoundr, "N/A" )
        guiSetText( lblcuentac, "N/A" )
    else
        local name = guiGridListGetItemText( configlistmembers, row, nickgpc )
        local rango = guiGridListGetItemText( configlistmembers, row, rangogpc )
        guiSetText( lblnamer, name:gsub( "#%x%x%x%x%x%x", "" ) )
        guiSetText( lblfoundr, rango )
        triggerServerEvent( "getAccountGPCText", getLocalPlayer(  ), name )
    end
end
addEventHandler( "onClientGUIClick", configlistmembers, setLablsGPCCCTxt, false )

function setAtEXTsdasa( cuenta )
    guiSetText( lblcuentac, cuenta )
end
addEventHandler( "labelsGPCTextmm", getLocalPlayer(  ), setAtEXTsdasa )

function deleteAmemberGPC( )
    local row = guiGridListGetSelectedItem( configlistmembers )
    if row==-1 then
        createNotification(messageG[1], 200, 0, 0, true )
        return
    end
    local name = guiGridListGetItemText( configlistmembers, row, nickgpc )
    local rango = guiGridListGetItemText( configlistmembers, row, rangogpc )
    if rango ~= "Fundador" then
        triggerServerEvent( "deleteAmmGpc", getLocalPlayer(  ), name, group_selected )
        guiGridListClear( configlistmembers )
        triggerServerEvent( "getMembersGPCList", getLocalPlayer(), group_selected )
    else
        guiGridListClear( configlistmembers )
        triggerServerEvent( "getMembersGPCList", getLocalPlayer(), group_selected )
        createNotification(messageG[3], 200, 0, 0, true)
    end
end
addEventHandler( "onClientGUIClick", kickmember, deleteAmemberGPC, false )

function aggAMemberGPC ( )
    refreshAGgMemberList()
    guiSetVisible( guiconfig,false )
    guiSetVisible( addplto,true )
end
addEventHandler( "onClientGUIClick", addmember, aggAMemberGPC, false )

function closeaggAMemberGPC ( )
    guiGridListClear( configlistmembers )
    triggerServerEvent( "getMembersGPCList", getLocalPlayer(), group_selected )
    guiSetVisible( guiconfig,true )
    guiSetVisible( addplto,false )
end
addEventHandler( "onClientGUIClick", close6, closeaggAMemberGPC, false )

function refreshAGgMemberList()
    guiGridListClear( addmcpslala )
    triggerServerEvent( "getPlayerGPCListAdd", getLocalPlayer(  ) )
end
addEventHandler( "onClientGUIClick", refreshpllistadd, refreshAGgMemberList, false )

function addGPCListAddMm( tablee )
    for _, value in ipairs( tablee ) do
        local name, group = value[1], value[2];
        local row = guiGridListAddRow( addmcpslala )
        guiGridListSetItemText( addmcpslala, row, nmAggg, name, false, false )
        guiGridListSetItemText( addmcpslala, row, gpgpcm, group, false, false )
        guiGridListSetItemColor( addmcpslala, row, nmAggg, 0, 200, 0, 255 )
        guiGridListSetItemColor( addmcpslala, row, gpgpcm, 0, 200, 0, 255 )
    end
end
addEventHandler( "sendTablePlAdd", getLocalPlayer(  ), addGPCListAddMm )

function aggAmembersOfLis( )
    local row = guiGridListGetSelectedItem( addmcpslala )
    if row==-1 then
        createNotification(messageG[1], 200, 0, 0, true )
        return
    end
    local name = guiGridListGetItemText( addmcpslala, row, nmAggg )
    local group = guiGridListGetItemText( addmcpslala, row, gpgpcm )
    if group == "N/A" then
        triggerServerEvent( "addAmemberGPCListlel", getLocalPlayer(  ), name, group_selected )
        refreshAGgMemberList()
    else
        createNotification(messageG[4])
        refreshAGgMemberList()
    end
end
addEventHandler( "onClientGUIClick", addto, aggAmembersOfLis, false )

function findAGgGpcMm(  )
    guiGridListClear( addmcpslala )
    local texto = editplfindaddg:getText();
    triggerServerEvent( "findAAggedMemberGPC", getLocalPlayer(  ), texto )
end
addEventHandler("onClientGUIChanged" , editplfindaddg, findAGgGpcMm )


function editaRangO(  )
    local row = guiGridListGetSelectedItem( configlistmembers )
    if row==-1 then
        createNotification(messageG[1], 200, 0, 0, true )
        return
    end
    local name = guiGridListGetItemText( configlistmembers, row, nickgpc )
    player_selected = name;
    guiSetVisible( guiconfig, false)
    guiSetVisible( guigpcrang, true)

    --guiComboBoxClear( boxranggpc )
    triggerServerEvent( "getRanksOfGroup2", getLocalPlayer(  ))
end
addEventHandler("onClientGUIClick", editrango, editaRangO, false)

function addRanks2( theTable )
    guiComboBoxClear( boxranggpc )

    guiComboBoxAddItem(boxranggpc, "Creador")
    for i,v in ipairs(theTable) do
        guiComboBoxAddItem(boxranggpc, v)
    end
end
addEvent("aggRanks2", true )
addEventHandler("aggRanks2", getLocalPlayer(  ), addRanks2 )

function editAMemberGPCRango(  )
    local row = guiComboBoxGetSelected( boxranggpc )
    if row==-1 then
        createNotification(messageG[1], 200, 0, 0, true )
        return
    end
    local rang = guiComboBoxGetItemText( boxranggpc, row )
    triggerServerEvent( "editArangGPC", getLocalPlayer(  ), player_selected, rang )
end
addEventHandler("onClientGUIClick", conteditrang, editAMemberGPCRango, false)

function closeEditR( )
    rrr()
    guiComboBoxSetSelected( boxranggpc, -1 )
end
addEventHandler("onClientGUIClick", cancel45, closeEditR, false)

function rrr(  )
    guiGridListClear( configlistmembers )
    triggerServerEvent( "getMembersGPCList", getLocalPlayer(), group_selected )
    guiSetVisible( guiconfig, true)
    guiSetVisible( guigpcrang, false)
end
addEventHandler( "refreshGPCListMmm", getLocalPlayer(  ), rrr )

function editGPNameGPC(  )
    local editText =  editgpchgnm:getText()
    if editText:len() > 4 then
        guiSetText( editgpchgnm, "")
        guiSetVisible( maingpchgn,false)
        triggerServerEvent( "editGPNAMEGPC", getLocalPlayer(  ),  group_selected, string.gsub( editText, "%s", "_" ) )
        enableGPCGui()
    else
        createNotification("Ingresa un nombre mas largo!")
    end
end
addEventHandler("onClientGUIClick", conteditgpnamece, editGPNameGPC, false)

function openEditname( )
    local row = guiGridListGetSelectedItem( gruposlist )
    if row==-1 then
        createNotification(messageG[1], 200, 0, 0, true )
        return
    end
    local grupo = guiGridListGetItemText( gruposlist, row, group1 )
    group_selected = grupo;
    guiSetVisible( admingrouppanel,false)
    guiSetVisible( maingpchgn,true)
end
addEventHandler("onClientGUIClick", editcggname, openEditname, false)

function closeEdasdas( )
    guiGridListClear( gruposlist )
    serverEvent("getGPCListG", getLocalPlayer(  ))
    guiSetVisible( maingpchgn,false)
    enableGPCGui()
end
addEventHandler("onClientGUIClick", close1c1, closeEdasdas, false)