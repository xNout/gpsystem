--[[
 *	*******************************************	*
 * Developed by:	-Rex-						*
 * Date:			26/01/2018					*
 * Description:									*
 *	*******************************************	*
 ]]--

local db = dbConnect( "sqlite", "dbData_byRex.db" )

local sql_tables_strings = { };
--	//groupmembers
sql_tables_strings.grupo 	=
{
	grupo 					= "CREATE TABLE IF NOT EXISTS groupsystem (groupname STRING NOT NULL, colorTag STRING NOT NULL, colorChat STRING NOT NULL, slots INTEGER NOT NULL)",
	miembros 				= "CREATE TABLE IF NOT EXISTS groupmembers (name STRING, memberacc STRING, membername STRING, rang STRING, uactive STRING )",
	informacion 			= "CREATE TABLE IF NOT EXISTS groupinfo (gpname STRING, info STRING)"
}

sql_tables_strings.alianzas = 
{ 
	alianza 				= "CREATE TABLE IF NOT EXISTS group_alianzas ( grupo STRING, grupoAliado STRING)",
	alianza_config 			= "CREATE TABLE IF NOT EXISTS group_alianzas_configs ( grupo STRING, blipsmapa STRING, chatGrupo STRING)",

};

sql_tables_strings.rangos 	= 
{
	rango 					= "CREATE TABLE IF NOT EXISTS groupRanks ( grupo STRING, rankName STRING, kickP STRING, Pchat STRING, CRank STRING, AAlianzas STRING, Apelaciones STRING, informacion STRING)"
}



addEventHandler("onResourceStart",getResourceRootElement( getThisResource() ),
function (  )

--	//Tablas de alianza
	local alianzas = sql_tables_strings.alianzas;
	create_table( alianzas.alianza );
	create_table( alianzas.alianza_config );

--	//Tabla de rangos
	local rangos = sql_tables_strings.rangos;
	create_table( rangos.rango );

--	//Tabla de grupos.
	local grupos = sql_tables_strings.grupo;
	create_table( grupos.grupo );
	create_table( grupos.miembros );
	create_table( grupos.informacion );

end)