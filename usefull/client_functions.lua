function gSetVisible( gui, bool )
    
    if ( bool ) then
        setTimer( function( f ) guiSetVisible( f, true ); end, 500, 1, gui )
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