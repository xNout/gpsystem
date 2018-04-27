--[[
 *	*******************************************	*
 * Developed by:	-Rex-						*
 * Last modified:	26/01/2018					*
 * Description:									*
 *	*******************************************	*
 ]]--
local database = dbConnect( "sqlite", "dbData_byRex.db" )
function create_table( cmd_string )
	dbFree( dbQuery( database, cmd_string ) );
end

function create_group( group_name, owner_account, owner_nickname )
	dbExec( 

		database,
		"INSERT INTO groupsystem ( groupname, colorTag, colorChat,slots) VALUES(?,?,?,?)", 
		group_name, 
		system_configs.default_color1, 
		system_configs.default_color2, 
		system_configs.slots
	)

	dbExec( 
		database,
		"INSERT INTO groupmembers ( name,memberacc,membername,rang,uactive) VALUES(?,?,?,?,?)", 
		group_name, 
		owner_account, 
		owner_nickname, 
		"Creador", 
		getTimes ( ) 
	)
	dbExec( 
		database,
		"INSERT INTO groupinfo ( gpname,info) VALUES(?,?)", 
		group_name, 
		system_configs.default_info
	)
	
	createNewGroupRank( 
		group_name, 
		"Trial", 
		"false", 
		"false", 
		"false", 
		"false", 
		"false", 
		"false" 
	)
	local log = owner_nickname.." [ "..( op_ter( isElement( Player( owner_nickname ) ) ~= nil, getPlayerRank( Player( owner_nickname ) ),owner_nickname ) ).." ] Fundo el grupo.";
	addGroupLog( group_name, log );
end