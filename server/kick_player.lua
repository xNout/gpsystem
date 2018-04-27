addEvent("kickamemberoption",true)
addEventHandler("kickamemberoption",getRootElement(  ),
function( nickname, razon )
	
	local group         = getPlayerGroup( source )
	local accountName = getAccountFromName( nickname )

	if isAccountOfFounder( accountName, group ) then
		createNotification("No se puede expulsar al Fundador!",source)
		return;
	end

	delete_member( 
		accountName, 
		group 
	);

	exec_event( "on_member_kick", razon, nickname, source, group );
end)