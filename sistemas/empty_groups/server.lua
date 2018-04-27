--[[
 *	*******************************************	*
 * Developed by:	-Rex-						*
 * Last modified:	11/04/2018					*
 * Description:									*
 *	*******************************************	*
 ]]--

function checker( )
	local groupsList = get_groups();
	for i,v in ipairs(groupsList) do
		if ( #get_group_member( v["groupname"] ) <= 0) then
			outputServerLog("* [GROUP-CHECKER] El grupo "..v["groupname"].." tiene 0 miembros y sera eliminado" );
			deleteGroup( v["groupname"] );
		end
	end
end
setTimer( checker, 5000, 0 );