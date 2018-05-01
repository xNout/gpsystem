--[[
 *  ******************************************* *
 *  Developed by:   -Rex-                       *
 *  Last modified:  11/04/2018                  *
 *  Contact:https://www.fb.com/rexscripting/    *
 *  ******************************************* *
 ]]--

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

 alianzasGUI = {
    checkbox = {},
    edit = {},
    button = {},
    window = {},
    label = {},
    gridlist = {}
}
alianzasGUI.window[1] = guiCreateWindow(29, 58, 471, 303, "Administrar Alianzas", false)
guiWindowSetSizable(alianzasGUI.window[1], false)

alianzasGUI.gridlist[1] = guiCreateGridList(10, 34, 190, 259, false, alianzasGUI.window[1])
a = guiGridListAddColumn(alianzasGUI.gridlist[1], "Grupo", 0.5)
b = guiGridListAddColumn(alianzasGUI.gridlist[1], "Miembros", 0.5)
alianzasGUI.button[1] = guiCreateButton(224, 44, 109, 24, "Enviar solicitudes", false, alianzasGUI.window[1])
guiSetFont(alianzasGUI.button[1], "default-bold-small")
guiSetProperty(alianzasGUI.button[1], "NormalTextColour", "FFC7C7C7")
alianzasGUI.button[2] = guiCreateButton(224, 78, 109, 24, "Actualizar lista", false, alianzasGUI.window[1])
guiSetFont(alianzasGUI.button[2], "default-bold-small")
guiSetProperty(alianzasGUI.button[2], "NormalTextColour", "FFC7C7C7")
alianzasGUI.button[3] = guiCreateButton(343, 44, 109, 24, "Eliminar alianza", false, alianzasGUI.window[1])
guiSetFont(alianzasGUI.button[3], "default-bold-small")
guiSetProperty(alianzasGUI.button[3], "NormalTextColour", "FFC7C7C7")
alianzasGUI.button[4] = guiCreateButton(343, 78, 109, 24, "Solicitudes", false, alianzasGUI.window[1])
guiSetFont(alianzasGUI.button[4], "default-bold-small")
guiSetProperty(alianzasGUI.button[4], "NormalTextColour", "FFC7C7C7")

alianzasGUI.checkbox[1] = guiCreateCheckBox(234, 141, 119, 15, "Blip's en el mapa", false, false, alianzasGUI.window[1])

alianzasGUI.label[1] = guiCreateLabel(224, 112, 101, 14, "Opciones:", false, alianzasGUI.window[1])

alianzasGUI.checkbox[2] = guiCreateCheckBox(234, 166, 119, 15, "Chat de grupo", false, false, alianzasGUI.window[1])

alianzasGUI.button[5] = guiCreateButton(428, 277, 33, 16, "X", false, alianzasGUI.window[1])
guiSetFont(alianzasGUI.button[5], "default-bold-small")
guiSetProperty(alianzasGUI.button[5], "NormalTextColour", "FFC7C7C7")
alianzasGUI.button[6] = guiCreateButton(343, 112, 109, 24, "Ver otras alianzas", false, alianzasGUI.window[1])
guiSetFont(alianzasGUI.button[6], "default-bold-small")
guiSetProperty(alianzasGUI.button[6], "NormalTextColour", "FFC7C7C7")


alianzasGUI.window[2] = guiCreateWindow(900, 15, 360, 355, "Enviar solicitud", false)
guiWindowSetSizable(alianzasGUI.window[2], false)

alianzasGUI.gridlist[2] = guiCreateGridList(10, 54, 158, 290, false, alianzasGUI.window[2])
c = guiGridListAddColumn(alianzasGUI.gridlist[2], "Grupo", 0.9)
alianzasGUI.edit[1] = guiCreateEdit(10, 26, 121, 22, "", false, alianzasGUI.window[2])
alianzasGUI.button[7] = guiCreateButton(189, 64, 74, 29, "Enviar", false, alianzasGUI.window[2])
guiSetFont(alianzasGUI.button[7], "default-bold-small")
guiSetProperty(alianzasGUI.button[7], "NormalTextColour", "FFAAAAAA")
alianzasGUI.button[8] = guiCreateButton(273, 64, 74, 29, "Cerrar", false, alianzasGUI.window[2])
guiSetFont(alianzasGUI.button[8], "default-bold-small")
guiSetProperty(alianzasGUI.button[8], "NormalTextColour", "FFAAAAAA")


alianzasGUI.window[3] = guiCreateWindow(576, 68, 292, 167, "Solicitudes", false)
guiWindowSetSizable(alianzasGUI.window[3], false)

alianzasGUI.gridlist[3] = guiCreateGridList(10, 25, 134, 135, false, alianzasGUI.window[3])
d = guiGridListAddColumn(alianzasGUI.gridlist[3], "Grupo", 0.9)
alianzasGUI.button[9] = guiCreateButton(154, 31, 59, 25, "Aceptar", false, alianzasGUI.window[3])
guiSetFont(alianzasGUI.button[9], "default-bold-small")
guiSetProperty(alianzasGUI.button[9], "NormalTextColour", "FFAAAAAA")
alianzasGUI.button[10] = guiCreateButton(223, 31, 59, 25, "Borrar", false, alianzasGUI.window[3])
guiSetFont(alianzasGUI.button[10], "default-bold-small")
guiSetProperty(alianzasGUI.button[10], "NormalTextColour", "FFAAAAAA")
alianzasGUI.button[11] = guiCreateButton(154, 66, 59, 25, "Actualizar", false, alianzasGUI.window[3])
guiSetFont(alianzasGUI.button[11], "default-bold-small")
guiSetProperty(alianzasGUI.button[11], "NormalTextColour", "FFAAAAAA")
alianzasGUI.button[12] = guiCreateButton(223, 66, 59, 25, "Cerrar", false, alianzasGUI.window[3])
guiSetFont(alianzasGUI.button[12], "default-bold-small")
guiSetProperty(alianzasGUI.button[12], "NormalTextColour", "FFAAAAAA")


alianzasGUI.window[4] = guiCreateWindow(370, 155, 380, 307, "Alianzas de otros grupos", false)
guiWindowSetSizable(alianzasGUI.window[4], false)

alianzasGUI.edit[2] = guiCreateEdit(10, 27, 121, 22, "", false, alianzasGUI.window[4])
alianzasGUI.gridlist[4] = guiCreateGridList(10, 55, 143, 241, false, alianzasGUI.window[4])
e = guiGridListAddColumn(alianzasGUI.gridlist[4], "Grupos", 0.9)

alianzasGUI.label[2] = guiCreateLabel(163, 65, 97, 15, "", false, alianzasGUI.window[4])
alianzasGUI.label[3] = guiCreateLabel(163, 90, 207, 132, "", false, alianzasGUI.window[4])
guiLabelSetHorizontalAlign(alianzasGUI.label[3], "left", true)
alianzasGUI.button[13] = guiCreateButton(342, 282, 30, 14, "X", false, alianzasGUI.window[4])
guiSetFont(alianzasGUI.button[13], "default-bold-small")
guiSetProperty(alianzasGUI.button[13], "NormalTextColour", "FFAAAAAA")

centerWindow ( alianzasGUI.window[1] )
centerWindow ( alianzasGUI.window[2] )
centerWindow ( alianzasGUI.window[3] )
centerWindow ( alianzasGUI.window[4] )
guiSetVisible ( alianzasGUI.window[1], false )
guiSetVisible ( alianzasGUI.window[2], false )
guiSetVisible ( alianzasGUI.window[3], false )
guiSetVisible ( alianzasGUI.window[4], false )

guiSetVisible ( alianzasGUI.label[2], false )
guiSetVisible ( alianzasGUI.label[3], false )

function openClosePanel( )
    
    guiSetVisible ( alianzasGUI.window[2], false )
    guiSetVisible ( alianzasGUI.window[3], false )
    guiSetVisible ( alianzasGUI.window[4], false )
    local status = not guiGetVisible( alianzasGUI.window[1] )
    gSetVisible ( alianzasGUI.window[1], status )
    gSetVisible(guiconfiggp, not status )
    if status then
        getGroupList ( )
    end
    triggerServerEvent( "requestGroupConfigs", getLocalPlayer(  ))
end

function closeALL( )
    guiSetVisible ( alianzasGUI.window[1], false )
    guiSetVisible ( alianzasGUI.window[2], false )
    guiSetVisible ( alianzasGUI.window[3], false )
    guiSetVisible ( alianzasGUI.window[4], false )
    gSetVisible(guiconfiggp,true)
end

function getGroupList(  )
    guiGridListClear( alianzasGUI.gridlist[1] )
    triggerServerEvent( "requestGPList", getLocalPlayer(  ))
end

function GPList( t )

    guiGridListClear( alianzasGUI.gridlist[1] )
    if ( #t == 0 ) then
        local row = guiGridListAddRow( alianzasGUI.gridlist[1] )
        guiGridListSetItemText( alianzasGUI.gridlist[1], row, a, "No hay alianzas", true, true )
        return;
    end

    for i,v in ipairs(t) do
        local row = guiGridListAddRow( alianzasGUI.gridlist[1] )
        guiGridListSetItemText( alianzasGUI.gridlist[1], row, a, v[1], false, false )
        guiGridListSetItemText( alianzasGUI.gridlist[1], row, b, v[2], false, false )
    end
end
addEvent( "addGPList", true )
addEventHandler( "addGPList", getLocalPlayer(  ), GPList )

local bools = 
{
    ["true"] = true,
    ["false"] = false,
}

function applyGroupConfigs( a, b )


    guiCheckBoxSetSelected( alianzasGUI.checkbox[1], a )
    guiCheckBoxSetSelected( alianzasGUI.checkbox[2], b )
   

end
addEvent( "groupConfigs", true )
addEventHandler( "groupConfigs", getLocalPlayer(  ), applyGroupConfigs )

function GPList2( grupo )
    local row2 = guiGridListAddRow( alianzasGUI.gridlist[2] )
    guiGridListSetItemText( alianzasGUI.gridlist[2], row2, c, grupo, false, false )
end
addEvent( "addGPList2", true )
addEventHandler( "addGPList2", getLocalPlayer(  ), GPList2 )

function clicks(  )
    
    if source == alianzasGUI.button[5] then
        closeALL ( )

    elseif source == alianzasGUI.button[1] then

        gSetVisible ( alianzasGUI.window[2], true )
        guiSetVisible ( alianzasGUI.window[1], false )

        guiGridListClear( alianzasGUI.gridlist[2] )
        triggerServerEvent( "requestFINDList", getLocalPlayer(  ), "" )

    elseif source == alianzasGUI.button[8] then

        getGroupList(  )
        guiSetVisible ( alianzasGUI.window[2], false )
        gSetVisible ( alianzasGUI.window[1], true )

    elseif source == alianzasGUI.button[2] then
        getGroupList ( )
        guiSetEnabled( alianzasGUI.button[2], false )

        setTimer( guiSetEnabled, 3000, 1, alianzasGUI.button[2], true )

    elseif source == alianzasGUI.checkbox[1] then

        triggerServerEvent( "requestChangeGPConig", getLocalPlayer(  ), ( guiCheckBoxGetSelected( alianzasGUI.checkbox[1] ) ), guiCheckBoxGetSelected( alianzasGUI.checkbox[2] ) )

    elseif source == alianzasGUI.checkbox[2] then

        triggerServerEvent( "requestChangeGPConig", getLocalPlayer(  ), guiCheckBoxGetSelected( alianzasGUI.checkbox[1] ), ( guiCheckBoxGetSelected( alianzasGUI.checkbox[2] ) ) )

    elseif source == alianzasGUI.button[7] then

        local row, col = guiGridListGetSelectedItem( alianzasGUI.gridlist[2] )

        if row == -1 or col == -1 then
            createNotification( "Selecciona algo!", 242, 242, 242, true )
            return
        end

        local grupo = guiGridListGetItemText( alianzasGUI.gridlist[2], row, col )
        triggerServerEvent( "requestsendInvGP", getLocalPlayer(  ), grupo )

        guiSetEnabled( alianzasGUI.button[7], false )

        setTimer( guiSetEnabled, 3000, 1, alianzasGUI.button[7], true )

    elseif source == alianzasGUI.button[4] then

        guiSetVisible ( alianzasGUI.window[1], false )
        gSetVisible ( alianzasGUI.window[3], true )
        loadInvs ( )

    elseif source == alianzasGUI.button[11] then

        loadInvs ( )

    elseif source == alianzasGUI.button[12] then
        getGroupList(  )
        gSetVisible ( alianzasGUI.window[1], true )
        guiSetVisible ( alianzasGUI.window[3], false )


    elseif source == alianzasGUI.button[9] then

        local row, col = guiGridListGetSelectedItem( alianzasGUI.gridlist[3] )

        if row == -1 or col == -1 then
            createNotification( "Selecciona algo!", 242, 242, 242, true )
            return
        end

        local grupo = guiGridListGetItemText( alianzasGUI.gridlist[3], row, col )
        guiGridListClear( alianzasGUI.gridlist[3] )
        triggerServerEvent( "requestAcceptInv", getLocalPlayer(  ), grupo )

    elseif source == alianzasGUI.button[3] then

        local row, col = guiGridListGetSelectedItem( alianzasGUI.gridlist[1] )

        if row == -1 or col == -1 then
            createNotification( "Selecciona algo!", 242, 242, 242, true )
            return
        end

        local grupo = guiGridListGetItemText( alianzasGUI.gridlist[1], row, col )
        triggerServerEvent( "requestDeleteAlianze", getLocalPlayer(  ), grupo )

    elseif source == alianzasGUI.button[10] then

        local row, col = guiGridListGetSelectedItem( alianzasGUI.gridlist[3] )

        if row == -1 or col == -1 then
            createNotification( "Selecciona algo!", 242, 242, 242, true )
            return
        end

        local grupo = guiGridListGetItemText( alianzasGUI.gridlist[3], row, col )
        guiGridListClear( alianzasGUI.gridlist[3] )
        triggerServerEvent( "requestDeleteInvGP", getLocalPlayer(  ), grupo )

    elseif source == alianzasGUI.button[6] then

        guiSetVisible ( alianzasGUI.window[1], false )
        gSetVisible ( alianzasGUI.window[4], true )
        loadGroupsA( )

    elseif source == alianzasGUI.gridlist[4] then

        local row, col = guiGridListGetSelectedItem( alianzasGUI.gridlist[4] )

        if row == -1 or col == -1 then
            guiSetVisible( alianzasGUI.label[2], false )
            guiSetVisible( alianzasGUI.label[3], false )
            return
        else
            gSetVisible( alianzasGUI.label[2], true )
            gSetVisible( alianzasGUI.label[3], true )
            guiSetText( alianzasGUI.label[2], "" )
            guiSetText( alianzasGUI.label[3], "" )
        end

        local grupo = guiGridListGetItemText( alianzasGUI.gridlist[4], row, col )
        guiSetText( alianzasGUI.label[2], "Grupo: "..grupo )
        triggerServerEvent( "requestGroupAlianzesInfo", getLocalPlayer(  ), grupo )

    elseif source == alianzasGUI.button[13] then

        gSetVisible ( alianzasGUI.window[1], true )
        guiSetVisible ( alianzasGUI.window[4], false )

    end
   -- local row, col = guiGridListGetSelectedItem( alianzasGUI.gridlist[1] )

end
addEventHandler( "onClientGUIClick", getRootElement(  ), clicks )

function loadGroupsA( )
    guiGridListClear( alianzasGUI.gridlist[4] )
    triggerServerEvent( "getALLGPList", getLocalPlayer(  ) )
end

function loadInvs( )
    guiGridListClear( alianzasGUI.gridlist[3] )
    triggerServerEvent( "requestGetInvList", getLocalPlayer(  ) )
end

function changeGUI( )
    
    if source == alianzasGUI.edit[1] then

        local text = guiGetText( alianzasGUI.edit[1] )

        guiGridListClear( alianzasGUI.gridlist[2] )
        triggerServerEvent( "requestFINDList", getLocalPlayer(  ), text )

    elseif source == alianzasGUI.edit[2] then

        local text = guiGetText( alianzasGUI.edit[2] )

        guiGridListClear( alianzasGUI.gridlist[4] )
        triggerServerEvent( "requestFINDList2", getLocalPlayer(  ), text )
    end

end
addEventHandler( "onClientGUIChanged", getRootElement(  ), changeGUI )

function GPiNVlIST( grupo )
    local row = guiGridListAddRow( alianzasGUI.gridlist[3] )
    guiGridListSetItemText( alianzasGUI.gridlist[3], row, d, grupo, false, false )
end
addEvent( "addInvsList", true )
addEventHandler( "addInvsList", getLocalPlayer(  ), GPiNVlIST )

function GPAllList( grupo )
    local row = guiGridListAddRow( alianzasGUI.gridlist[4] )
    guiGridListSetItemText( alianzasGUI.gridlist[4], row, e, grupo, false, false )
end
addEvent( "addGPList2", true )
addEventHandler( "addGPList2", getLocalPlayer(  ), GPAllList )

function GPAllList2( grupo )
    local row = guiGridListAddRow( alianzasGUI.gridlist[4] )
    guiGridListSetItemText( alianzasGUI.gridlist[4], row, e, grupo, false, false )
end
addEvent( "addGPList3", true )
addEventHandler( "addGPList3", getLocalPlayer(  ), GPAllList2 )

function infoAlianzaGP( buffer )
    guiSetText( alianzasGUI.label[3], "Grupo Aliados: "..buffer )
end
addEvent( "GPInfoAlList", true )
addEventHandler( "GPInfoAlList", getLocalPlayer(  ), infoAlianzaGP )


function isAliated( grupo )
    
    for i, v in ipairs( getElementData( getLocalPlayer( ), "GroupsAliatedTable" ) ) do
        
        if grupo == v[1] then
            return true
        end

    end

    return false

end

function aliatedBlipColor( grupo )
    
    for i, v in ipairs( getElementData( getLocalPlayer( ), "GroupsAliatedTable" ) ) do
        
        if grupo == v[1] then
            
            local r, g, b = getColorFromString( v[2] )
            return r, g, b
        end

    end

    return 200, 200, 0

end