--[[
 *  ******************************************* *
 *  Developed by:   -Rex-                       *
 *  Last modified:  -                           *
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

rangosGUI = {
    checkbox = {},
    edit = {},
    button = {},
    window = {},
    label = {}
}

rangosMain = guiCreateWindow(406, 219, 450, 195, "Crear rango", false)
guiWindowSetSizable(rangosMain, false)

rangoeditbox = guiCreateEdit(10, 46, 177, 30, "", false, rangosMain)
guiEditSetMaxLength(rangoeditbox, 15)
rangosGUI.label[1] = guiCreateLabel(10, 26, 110, 15, "Nombre del rango", false, rangosMain)
guiSetFont(rangosGUI.label[1], "default-bold-small")
rangosGUI.checkbox[1] = guiCreateCheckBox(20, 93, 15, 15, "", false, false, rangosMain)
rangosGUI.label[2] = guiCreateLabel(39, 93, 148, 15, "Expulsar miembros.", false, rangosMain)
guiSetFont(rangosGUI.label[2], "clear-normal")
rangosGUI.checkbox[2] = guiCreateCheckBox(20, 118, 15, 15, "", false, false, rangosMain)
rangosGUI.label[3] = guiCreateLabel(39, 118, 194, 15, "Personalizacion de chat.", false, rangosMain)
guiSetFont(rangosGUI.label[3], "clear-normal")
rangosGUI.checkbox[3] = guiCreateCheckBox(20, 143, 15, 15, "", false, false, rangosMain)
rangosGUI.label[4] = guiCreateLabel(39, 143, 194, 15, "Cambiar rangos de miembros.", false, rangosMain)
guiSetFont(rangosGUI.label[4], "clear-normal")
rangosGUI.checkbox[4] = guiCreateCheckBox(20, 168, 15, 15, "", false, false, rangosMain)
rangosGUI.label[5] = guiCreateLabel(39, 168, 194, 15, "Administración de Alianzas.", false, rangosMain)
guiSetFont(rangosGUI.label[5], "clear-normal")
rangosGUI.checkbox[5] = guiCreateCheckBox(233, 31, 15, 15, "", false, false, rangosMain)
rangosGUI.label[6] = guiCreateLabel(253, 31, 194, 15, "Invitar jugadores", false, rangosMain)
guiSetFont(rangosGUI.label[6], "clear-normal")
rangosGUI.checkbox[6] = guiCreateCheckBox(233, 56, 15, 15, "", false, false, rangosMain)
rangosGUI.label[7] = guiCreateLabel(253, 56, 194, 15, "Editar información.", false, rangosMain)
guiSetFont(rangosGUI.label[7], "clear-normal")
rangosGUI.button[1] = guiCreateButton(258, 95, 166, 28, "Guardar", false, rangosMain)
guiSetFont(rangosGUI.button[1], "default-bold-small")
rangosGUI.button[2] = guiCreateButton(258, 130, 166, 28, "Cancelar accion", false, rangosMain)
guiSetFont(rangosGUI.button[2], "default-bold-small")    
guiSetVisible( rangosMain, false )
centerWindow ( rangosMain )


admRangos = {
    gridlist = {},
    window = {},
    button = {}
}

admRangos.window[1] = guiCreateWindow(270, 179, 627, 246, "Administrar Rangos", false)
guiWindowSetSizable(admRangos.window[1], false)

admRangos.gridlist[1] = guiCreateGridList(10, 29, 435, 206, false, admRangos.window[1])
rC  = guiGridListAddColumn(admRangos.gridlist[1], "Rango", 0.2)
eC  = guiGridListAddColumn(admRangos.gridlist[1], "Expulsar", 0.1)
ccC = guiGridListAddColumn(admRangos.gridlist[1], "Colores Chat", 0.15)
crC = guiGridListAddColumn(admRangos.gridlist[1], "Cambiar Rangos", 0.17)
aC  = guiGridListAddColumn(admRangos.gridlist[1], "Alianzas", 0.1)
apC = guiGridListAddColumn(admRangos.gridlist[1], "Inv. Jugadores", 0.15)
ifC = guiGridListAddColumn(admRangos.gridlist[1], "Informacion", 0.2)

admRangos.button[1] = guiCreateButton(462, 39, 148, 28, "Crear nuevo rango", false, admRangos.window[1])
guiSetFont(admRangos.button[1], "default-bold-small")
admRangos.button[2] = guiCreateButton(462, 73, 148, 28, "Modificar rango", false, admRangos.window[1])
guiSetFont(admRangos.button[2], "default-bold-small")
admRangos.button[3] = guiCreateButton(462, 107, 148, 28, "Borrar rango", false, admRangos.window[1])
guiSetFont(admRangos.button[3], "default-bold-small")
admRangos.button[4] = guiCreateButton(572, 141, 45, 23, "Cerrar", false, admRangos.window[1])
guiSetFont(admRangos.button[4], "default-bold-small")    
centerWindow ( admRangos.window[1] )
guiSetVisible ( admRangos.window[1], false )


local modoR = "creacion"

function setRPanelMode( modo, nombreRag )
    
    if modo == "creacion" then
        modoR = modo
        allChecboks(  )
        guiSetText( rangoeditbox, "" )
        guiSetText( rangosMain, "Crear rango" )
        guiSetVisible( admRangos.window[1], false )
        gSetVisible( rangosMain, true )
        guiSetEnabled( rangoeditbox, true )
    elseif modo == "modificacion" then
        if nombreRag then
            modoR = modo
            guiSetText( rangoeditbox, nombreRag )
            guiSetText( rangosMain, "Modificar rango" )
            triggerServerEvent ( "getRankPermissions", getLocalPlayer(  ), nombreRag )
            guiSetVisible( admRangos.window[1], false )
            gSetVisible( rangosMain, true )
            guiSetEnabled( rangoeditbox, false )
        end

    end

end

local tbool = 
{
    [true]    = "true",
    [false]   = "false",
    ["true"]  = true,
    ["false"] = false,
}

local cbool = 
{
    ["Si"]    = true,
    ["No"]    = false,
    ["true"]  = "Si",
    ["false"] = "No",
}

function tr2( s )
    
    if cbool[s] then
        return cbool[s]
    end

    return false

end

function tr( s )
    
    if tbool[s] then
        return tbool[s]
    end

    return false

end

function clikButtons(  )

    if source == admRangos.button[1] then
        setRPanelMode( "creacion" )

    elseif source == admRangos.button[2] then

        local row,col = guiGridListGetSelectedItem( admRangos.gridlist[1] )
        local name = guiGridListGetItemText( admRangos.gridlist[1], row, rC )
        if row == -1 or col == -1 then createNotification( "Selecciona un rango de la lista!" ) return false end

        if name == "Creador" or name == "Trial" or name == "creador" or name == "trial" then
            createNotification( "Elige otro rango!" )
            return
        end
        setRPanelMode( "modificacion", name )

    elseif source == rangosGUI.button[1] then

        local nombreRank  = guiGetText( rangoeditbox )
        
        local TbOOl = false
        if modoR == "modificacion" then
            TbOOl = true
            if nombreRank == "Creador" or nombreRank == "Trial" or nombreRank == "creador" or nombreRank == "trial" then
                createNotification( "Elige otro rango!" )
                return
            end
        end

        if nombreRank == "Creador" or nombreRank == "Trial" or nombreRank == "creador" or nombreRank == "trial" then
            createNotification( "Elige otro nombre!" )
            return
        end

        local kick        = guiCheckBoxGetSelected( rangosGUI.checkbox[1] )
        local chat        = guiCheckBoxGetSelected( rangosGUI.checkbox[2] )
        local Crangos     = guiCheckBoxGetSelected( rangosGUI.checkbox[3] )
        local Alianzas    = guiCheckBoxGetSelected( rangosGUI.checkbox[4] )
        local apelaciones = guiCheckBoxGetSelected( rangosGUI.checkbox[5] )
        local informacion = guiCheckBoxGetSelected( rangosGUI.checkbox[6] )

        if string.len( nombreRank ) > 3 then
            triggerServerEvent ( "saveNewRank", getLocalPlayer(  ), nombreRank, tr ( kick ), tr ( chat ), tr ( Crangos ), tr ( Alianzas ), tr ( apelaciones ), tr ( informacion ), TbOOl )
        else
            createNotification( "Ingresa un nombre con más de tres digitos!" )
        end

    elseif source == admRangos.button[3] then
        local row,col = guiGridListGetSelectedItem( admRangos.gridlist[1] )
        local name = guiGridListGetItemText( admRangos.gridlist[1], row, rC )
        if row == -1 or col == -1 then createNotification( "Selecciona un rango de la lista!" ) return false end
        triggerServerEvent ( "deleterank", getLocalPlayer(  ), name )

    elseif source == rangosGUI.button[2] then
        triggerServerEvent ( "getRanksGroup", getLocalPlayer(  ) )
        gSetVisible ( admRangos.window[1], true )
        guiSetVisible ( rangosMain, false )

    elseif source == admRangos.button[4] then
        clearCList(  )
        gSetVisible( guiconfiggp, true )
        guiSetVisible ( admRangos.window[1], false )
    end

end
addEventHandler("onClientGUIClick", root, clikButtons )


function gridRanks( tab )
    
    guiGridListClear( admRangos.gridlist[1] )
    if #tab > 0 then

        for i,v in ipairs(tab) do
            row = guiGridListAddRow( admRangos.gridlist[1] )
            guiGridListSetItemText( admRangos.gridlist[1], row, rC,  tostring( v[1] ), false, false )
            guiGridListSetItemText( admRangos.gridlist[1], row, eC,  tostring( tr2 ( v[2] ) ), false, false )
            guiGridListSetItemText( admRangos.gridlist[1], row, ccC, tostring( tr2 ( v[3] ) ), false, false )
            guiGridListSetItemText( admRangos.gridlist[1], row, crC, tostring( tr2 ( v[4] ) ), false, false )
            guiGridListSetItemText( admRangos.gridlist[1], row, aC,  tostring( tr2 ( v[5] ) ), false, false )
            guiGridListSetItemText( admRangos.gridlist[1], row, apC, tostring( tr2 ( v[6] ) ), false, false )
            guiGridListSetItemText( admRangos.gridlist[1], row, ifC, tostring( tr2 ( v[7] ) ), false, false )
            guiGridListSetItemColor( admRangos.gridlist[1], row, rC,  0, 255, 0,  200 )
            guiGridListSetItemColor( admRangos.gridlist[1], row, eC,  0, 255, 0,  200 )
            guiGridListSetItemColor( admRangos.gridlist[1], row, ccC, 0, 255, 0,  200 )
            guiGridListSetItemColor( admRangos.gridlist[1], row, crC, 0, 255, 0,  200 )
            guiGridListSetItemColor( admRangos.gridlist[1], row, aC,  0, 255, 0,  200 )
            guiGridListSetItemColor( admRangos.gridlist[1], row, apC, 0, 255, 0,  200 )
            guiGridListSetItemColor( admRangos.gridlist[1], row, ifC, 0, 255, 0,  200 )
        end
            
    else
        row = guiGridListAddRow( admRangos.gridlist[1] )
        guiGridListSetItemText( admRangos.gridlist[1], row, rC, "No hay rangos creados.", true, true )
    end

end
addEvent("addRanks",true)
addEventHandler("addRanks",getLocalPlayer(), gridRanks )

function rankPermissionC( kick, chat, Crangos, Alianzas, apelaciones, informacion )
    guiCheckBoxSetSelected( rangosGUI.checkbox[1], tr( kick ) )
    guiCheckBoxSetSelected( rangosGUI.checkbox[2], tr( chat ) )
    guiCheckBoxSetSelected( rangosGUI.checkbox[3], tr( Crangos ) )
    guiCheckBoxSetSelected( rangosGUI.checkbox[4], tr( Alianzas ) )
    guiCheckBoxSetSelected( rangosGUI.checkbox[5], tr( apelaciones ) )
    guiCheckBoxSetSelected( rangosGUI.checkbox[6], tr( informacion ) )
end
addEvent("setCheckboksqueflojerahdp",true)
addEventHandler("setCheckboksqueflojerahdp",getLocalPlayer(), rankPermissionC )

function allChecboks(  )
    guiCheckBoxSetSelected( rangosGUI.checkbox[1], false )
    guiCheckBoxSetSelected( rangosGUI.checkbox[2], false )
    guiCheckBoxSetSelected( rangosGUI.checkbox[3], false )
    guiCheckBoxSetSelected( rangosGUI.checkbox[4], false )
    guiCheckBoxSetSelected( rangosGUI.checkbox[5], false )
    guiCheckBoxSetSelected( rangosGUI.checkbox[6], false )
end
function CC( )
    triggerServerEvent ( "getRanksGroup", getLocalPlayer(  ) )
    gSetVisible ( admRangos.window[1], true )
    guiSetVisible ( rangosMain, false )
end
addEvent("closeCCRanks",true)
addEventHandler("closeCCRanks",getLocalPlayer(), CC)

function ranksAgg( tT )
    
    guiComboBoxClear( boxpromote )

    for i,v in ipairs(tT) do
        guiComboBoxAddItem(boxpromote, v)
    end
    
end
addEvent("agregarRangos",true)
addEventHandler("agregarRangos",getLocalPlayer(), ranksAgg )