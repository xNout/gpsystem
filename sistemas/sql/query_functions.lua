local connection = dbConnect( "sqlite", "dbData_byRex.db" );

function get_groups( )
	return dbPoll( connection:query( "SELECT groupname FROM groupsystem"), -1 );
end

function get_group_member( group_name )
	return dbPoll( connection:query( "SELECT * FROM groupmembers WHERE name=? ORDER BY uactive ASC", group_name), -1 );
end

function get_group_information( group_name )

	if ( not isGroupExists( group_name ) ) then
		return system_configs.default_info;
	end
	return dbPoll( connection:query( "SELECT * FROM groupinfo WHERE gpname=?", group_name), -1 )[1]["info"] or system_configs.default_info;
end