function centerWindow (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    guiSetPosition(center_window, x, y, false)
end

local function YesNo( title, description)
	
	if ( title == nil ) then
		title = "Advertencia"
	end

	if ( description == nil ) then
		description = "¿Estás seguro/a?"
	end

	local nWindowTitle = title;
	local nDescription = description;
	local nYes 		   = "Si";
	local nNo 		   = "No";
	local nCancel 	   = "Cancelar";

	local nWindow = guiCreateWindow(470, 241, 341, 105, nWindowTitle, false)
	guiWindowSetSizable(nWindow, false)
	local nDescriptionLabel = guiCreateLabel(10, 30, 321, 37, nDescription, false, nWindow)
	guiLabelSetHorizontalAlign(nDescriptionLabel, "center", true)
	guiLabelSetVerticalAlign(nDescriptionLabel, "center")

	local nYesButton = guiCreateButton(52, 73, 72, 22, nYes, false, nWindow)
	guiSetFont(nYesButton, "default-bold-small")

	local nNoButton = guiCreateButton(134, 73, 72, 22, nNo, false, nWindow)
	guiSetFont(nNoButton, "default-bold-small")

	local nCancelButton = guiCreateButton(216, 73, 72, 22, nCancel, false, nWindow)
	guiSetFont(nCancelButton, "default-bold-small")

	
	guiBringToFront ( nWindow )
	centerWindow( nWindow )
	local gui = 
	{
		window       = nWindow,
		description  = nDescriptionLabel,
		yesButton    = nYesButton,
		noButton     = nNoButton,
		cancelButton = nCancelButton
	}
	return gui
end

local function OK( title, description )
	
	if ( title == nil ) then
		title = "Informacion"
	end

	if ( description == nil ) then
		description = "¿Estás seguro/a?"
	end

	local nWindowTitle = title;
	local nDescription = description;
	local nOK 		   = "OK";

	local nWindow = guiCreateWindow(470, 241, 341, 105, nWindowTitle, false)
	guiWindowSetSizable(nWindow, false)

	local nDescriptionLabel = guiCreateLabel(10, 30, 321, 37, nDescription, false, nWindow)
	guiLabelSetHorizontalAlign(nDescriptionLabel, "center", true)
	guiLabelSetVerticalAlign(nDescriptionLabel, "center")

	local nOKButton = guiCreateButton(133, 73, 72, 22, nOK, false, nWindow)
	guiSetFont(nOKButton, "default-bold-small")

	guiBringToFront ( nWindow )
	centerWindow( nWindow )
	local gui = 
	{
		window       = nWindow,
		description  = nDescriptionLabel,
		okButton     = nOKButton,
	}

	return gui
end

local function AcceptCancel( title, description )
	
	if ( title == nil ) then
		title = "Advertencia"
	end

	if ( description == nil ) then
		description = "¿Estás seguro/a?"
	end

	local nWindowTitle = title;
	local nDescription = description;
	local nAccept 	   = "Aceptar";
	local nCancel 	   = "Cancelar";

	local nWindow = guiCreateWindow(470, 241, 341, 105, nWindowTitle, false)
	guiWindowSetSizable(nWindow, false)
	local nDescriptionLabel = guiCreateLabel(10, 30, 321, 37, nDescription, false, nWindow)
	guiLabelSetHorizontalAlign(nDescriptionLabel, "center", true)
	guiLabelSetVerticalAlign(nDescriptionLabel, "center")

	local nAcceptButton = guiCreateButton(89, 73, 72, 22, nAccept, false, nWindow)
	guiSetFont(nAcceptButton, "default-bold-small")
	local nCancelButton = guiCreateButton(179, 73, 72, 22, nCancel, false, nWindow)
	guiSetFont(nCancelButton, "default-bold-small")

	guiBringToFront ( nWindow )
	centerWindow( nWindow )
	local gui = 
	{
		window       = nWindow,
		description  = nDescriptionLabel,
		AcceptButton       = nAcceptButton,
		CancelButton       = nCancelButton,
	}

	return gui
end

local function SelectItems( title, description, list )

	if ( title == nil ) then
		title = "Lista"
	end

	if ( description == nil ) then
		description = "Elegi un elemento de la lista"
	end

	local nWindowTitle = title;
	local nDescription = description;
	local nAccept 	   = "Elegir";
	local nCancel 	   = "Cancelar";

	SL_ITEMSGUI = guiCreateWindow(532, 244, 212, 186, title, false)
	guiWindowSetSizable(SL_ITEMSGUI, false)

	SL_DESCRIPTION = guiCreateLabel(3, 25, 204, 16, description, false, SL_ITEMSGUI)
	guiSetFont(SL_DESCRIPTION, "default-bold-small")
	guiLabelSetHorizontalAlign(SL_DESCRIPTION, "center", false)

	SL_LIST = guiCreateComboBox(10, 51, 187, 87, "", false, SL_ITEMSGUI)

	for i,v in ipairs(list) do
		guiComboBoxAddItem( SL_LIST, v )
	end

	SL_ACCEPTBUTTON = guiCreateButton(54, 148, 68, 28, nAccept, false, SL_ITEMSGUI)
	guiSetFont(SL_ACCEPTBUTTON, "default-bold-small")
	SL_CANCEL = guiCreateButton(132, 148, 68, 28, nCancel, false, SL_ITEMSGUI)
	guiSetFont(SL_CANCEL, "default-bold-small")

	guiBringToFront ( SL_ITEMSGUI )
	centerWindow( SL_ITEMSGUI )
	local gui = 
	{
		window       = SL_ITEMSGUI,
		item_list	 = SL_LIST,
		description  = SL_DESCRIPTION,
		AcceptButton = SL_ACCEPTBUTTON,
		CancelButton = SL_CANCEL,
	}

	return gui
end


local types = {
	["YesNo"] 		 = 1,
	["OK"]    		 = 2,
	["AcceptCancel"] = 3,
	["SelectItems"]  = 4,
}

function create_notify_window( tipo, args, callbackFunc )
	local title = args.title;
	local des   = args.description;
	switch{
		types[tipo];
			1, 
				function ( )
					local gYesNo;
					if ( title ~= nil and des ~= nil ) then
						gYesNo = YesNo( title, des )
					else
						gYesNo = YesNo( )
					end

					local results =
					{
						Yes    = false,
						No     = false,
						Cancel = false
					}

					addEventHandler("onClientGUIClick", gYesNo.yesButton, 
					function()
						results.Yes = true;
						callbackFunc( results )
						destroyElement( gYesNo.window )
					end, false)

					addEventHandler("onClientGUIClick", gYesNo.noButton, 
					function()
						results.No = true;
						callbackFunc( results )
						destroyElement( gYesNo.window )
					end, false)

					addEventHandler("onClientGUIClick", gYesNo.cancelButton, 
					function()
						results.Cancel = true;
						callbackFunc( results )
						destroyElement( gYesNo.window )
					end, false)
				end,
			2,
				function ( )

					local gOK;
					if ( title ~= nil and des ~= nil ) then
						gOK = OK( title, des )
					else
						gOK = OK( )
					end

					local results =
					{
						OK    = false,
					}

					addEventHandler("onClientGUIClick", gOK.okButton, 
					function()
						results.OK = true;
						callbackFunc( results )
						destroyElement( gOK.window )
					end, false)

				end,
			3,
				function ( )
					local gAcceptCancel;
					if ( title ~= nil and des ~= nil ) then
						gAcceptCancel = AcceptCancel( title, des )
					else
						gAcceptCancel = AcceptCancel( )
					end

					local results =
					{
						Accept    = false,
						Cancel    = false,
					}

					addEventHandler("onClientGUIClick", gAcceptCancel.AcceptButton, 
					function()
						results.Accept = true;
						callbackFunc( results )
						destroyElement( gAcceptCancel.window )
					end, false)

					addEventHandler("onClientGUIClick", gAcceptCancel.CancelButton, 
					function()
						results.Cancel = true;
						callbackFunc( results )
						destroyElement( gAcceptCancel.window )
					end, false)

				end,

			4,
				function ( )
					local gSelectItems;
					if ( title ~= nil and des ~= nil ) then
						gSelectItems = SelectItems( title, des, args.list )
					else
						gSelectItems = SelectItems( )
					end

					local results =
					{
						Select    	  = false,
						item_selected = nil,
						Cancel   	  = false,
					}

					addEventHandler("onClientGUIClick", gSelectItems.AcceptButton, 
					function()

						local comboBox = gSelectItems.item_list;
						local row = guiComboBoxGetSelected( comboBox )
						local item = guiComboBoxGetItemText( comboBox, row )
						if ( row == -1 ) then
							guiSetText( gSelectItems.description, "Debes elegir un item!")
							return
						end
						results.item_selected = item
						results.Select = true;
						callbackFunc( results )
						destroyElement( gSelectItems.window )
					end, false)

					addEventHandler("onClientGUIClick", gAcceptCancel.CancelButton, 
					function()
						results.Cancel = true;
						callbackFunc( results )
						destroyElement( gAcceptCancel.window )
					end, false)

				end,
	}
end