--[[
 *	*******************************************	*
 * 	Developed by:	-Rex-						*
 * 	Last modified:	-							*
 * 	Contact:https://www.fb.com/rexscripting/	*
 *	*******************************************	*
 ]]--
 

addEvent("createnewGroup",true)
addEventHandler("createnewGroup",getRootElement(  ),
function( group_name )

	if isGroupExists( group_name ) then
		createNotification("El grupo ya existe!",source,255, 255, 255, true)
		return;
	end
	if ( isPlayerInGroup(source) ) then
		createNotification("Ya tienes un grupo!",source,255, 255, 255, true)
		return;
	end


	local pAccount = source:getAccount():getName();
	local pName    = source:getName();
	create_group( 
		group_name, 
		pAccount, 
		pName 
	);

	exec_event("on_group_created");
end)


addEvent("leaveofgroup",true)
addEventHandler("leaveofgroup",getRootElement(  ),
function (  )
	local the_group = getPlayerGroup(source)
	if isPlayerFounder( source, the_group) then
		createNotification("Debes eliminar el grupo para poder salirte!", source );
		return
	end
	
	removePlayerFromGroup(source, the_group)
	exec_event( "on_member_leave", source, the_group )
end)



addEvent("deletemygp",true)
addEventHandler("deletemygp",getRootElement(  ),
function(  )

	local gang = getPlayerGroup( source )
	if ( not isPlayerInGroup(source) ) then
		return;
	end

	if ( not isPlayerFounder(  source, gang ) ) then
		createNotification("Permiso denegado!",source,200,0,0,true)
		return;
	end

	deleteGroup( gang )
	exec_event( "on_group_deleted", gang, source )
end)


function refreshDatas( )

	for i, players in ipairs( getElementsByType ( "player" ) ) do
		setGroup ( players, getPlayerGroup ( players ) )
	end
end
setTimer( refreshDatas, 30000, 0 )

