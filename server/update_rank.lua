
addEvent("newrangforplayer",true)
addEventHandler("newrangforplayer",getRootElement(  ),
function ( jugador, new_rank )

	local player = getPlayerFromName( jugador )
	local nombre_source = source:getName()
	if nombre_source == jugador then
		createNotification("Elige un jugador que no seas tú",source, 255, 255, 255, true)
		return;
	end

	local gang = getPlayerGroup( source )
	if isAccountOfFounder( getAccountFromName( jugador ), gang ) then
		createNotification("No puedes cambiarle el rango al Creador",source,255, 255, 255, true)
		return
	end
	update_member_rank( jugador, new_rank );
	exec_event( "on_mrank_changed", jugador, source, new_rank, gang )
end)