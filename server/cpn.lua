addEvent("cServerName",true)
addEventHandler("cServerName",getRootElement(  ),
function ( nGroupName )
	

	local oGName = source:getData("gang");
	local rChange = update_group_name(
		oGName, 
		nGroupName 
	);
	if ( not rChange ) then
		createNotification(
			"Error! Nombre no disponible", 
			source 
		);
		return false;
	end

	createNotification(
			"Grupo actualizado!", 
			source 
		);

	exec_event( 
		"group_name_changed", 
		source 
	);

	addGroupLog( nGroupName, source:getName().. " [ "..getPlayerRank( source ).." ] actualizo el nombre del grupo");
end )

handle_event(
	function ( args )
		local event_to = args[1]; 
		triggerClientEvent( 
			event_to, 
			"cpn_client_event", 
			event_to 
		);
	end, 
"group_name_changed");


-- addCommandHandler("xdx", 
-- function()

-- 	local s = string.format( "Mi variable es %s", "variable1 y variable2");
-- 	outputChatBox( tostring(s))
-- end)