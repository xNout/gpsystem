invitaciones = { }

addEvent("sendainvtopl",true)
addEventHandler("sendainvtopl",getRootElement(  ),
function ( player_nick )
	local source_group        = getPlayerGroup( source )
--	other payer
	local player         	  = Player( player_nick )
	if ( source:getName() == player_nick ) then
		createNotification("No puedes invitarte tu mismo",source,200,0,0,true);
		return;
	end

	-- if ( isPlayerInGroup( player ) ) then
	-- 	createNotification("El Jugador ya tiene grupo!",source, 255, 255, 255, true);
	-- 	return;
	-- end
	if haveInvitation( player, source_group ) then
		createNotification( "Invitación enviada!", source, 255, 255, 255, true )
		return;
	end

	invitaciones[player] = source_group
	setElementData( player, "InvTable", invitaciones[player] )
	createNotification( "Invitación enviada!", source, 255, 255, 255, true )
	exec_event("on_player_invited", source_group, player, source );
	
end)

function haveInvitation( player, group )
	return invitaciones[player] ~= nil or false;
end

addCommandHandler( "aceptar",  
function ( player, cmd )
	local grupo = invitaciones[player]
	local members, slots = getGroupSlots( grupo )
	if ( tonumber( members ) or 0 ) >= ( tonumber( slots ) or 1 ) then
		outputChatBox("No hay slots disponibles!", player, 255, 255, 255, true)
		return
	end

	if ( not haveInvitation( player, grupo ) ) then
		createNotification( "No tienes una invitaciones", player, 255, 255, 255, true );
		return;
	end

	invitaciones[player] = nil
	setElementData( player, "InvTable", nil )
	if ( not isGroupExists( grupo ) ) then
		outputChatBox( "El grupo fue eliminado o nunca existio", player, 255, 255, 255, true );
		return;
	end

	if ( isPlayerInGroup( player ) ) then
		local oldGroup = getPlayerGroup( player )
		addGroupLog( oldGroup, player:getName().." Abandono el grupo.")
		removePlayerFromGroup( player, oldGroup)
	end

	addPlayerToGroup( player, grupo, "Trial" )
	setGroup ( player, grupo )
	outputChatBox("Aceptaste la solicitud de "..grupo, player, 255, 255, 255, true)
	exec_event("on_player_accept_inv", player, grupo );
end)

add_event(
function (  )
	local cTABLE = { }
	for i, player in ipairs( getElementsByType("player") ) do
		if source ~= player then 
			if not isGuestPlayer( player ) then
				local groupString = "Si";
				if ( not isPlayerInGroup ( player ) ) then
					groupString = "No";
				end
				table.insert( cTABLE, { player:getName(), groupString })
			end
		end
	end
	triggerClientEvent( source, "listofplayerinv", source, cTABLE)
end, "getlistofplinvto", root );
