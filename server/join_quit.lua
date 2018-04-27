--[[
 *	*******************************************	*
 * Developed by:	-Rex-						*
 * Last modified:	26/01/2018					*
 * Description:									*
 *	*******************************************	*
 ]]--
 
addEvent("onPlayerDayZLogin", true)
addEventHandler("onPlayerDayZLogin", getRootElement(), function()
	setGroup ( source, getPlayerGroup( source ) );
end)


addEventHandler("onPlayerChangeNick", getRootElement(), 
function ( _, nick )
   	if ( not isGuestPlayer( source ) ) then
   		update_member_nick ( nick, source:getAccount ( ):getName() )
   	end
end)

addEventHandler ("onPlayerLogin", getRootElement(), function() update_join(source) end )

addEvent("onPlayerDayZLogin", true)
addEventHandler("onPlayerDayZLogin", getRootElement(), 
function( _, _, player )
	update_join( player);
end)

addEventHandler ( "onPlayerQuit", getRootElement(), 
function ( )
	update_member_datetime( source );
	if invitaciones[source] then
		invitaciones[source] = nil
	end
	refresh_blips();
end )