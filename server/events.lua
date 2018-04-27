handle_event( 
function( )
	asignar_team();
end
, "on_group_created");

handle_event(
function( args )
	local kRazon 	 = args[1];
	local pExpulsado = getPlayerFromName ( args[2] );
	local kBy 		 = args[3];
	local kBy_name 	 = kBy:getName();
	local group 	 = args[4];
	refresh_blips();
	createNotification(
		"Jugador expulsado!", 
		kBy
	)
	local gLog = string.format( 
		"%s fue expulsado por %s ( %s ) razon: %s", 
		args[2], 
		kBy_name, 
		kBy:getAccount():getName(), 
		kRazon 
	);
	addGroupLog( 
		group, 
		gLog
	)
	op_ter( isElement ( pExpulsado ),
		function()
			outputChatBox( string.format( "Fuiste expulsado de %s por: %s", group, kBy_name ), pExpulsado, 255, 255, 255, true)
		end,
		function()
			addAcountMsg( pExpulsado:getAccount():getName(), string.format( "Fuiste expulsado por %s razon: %s", kBy_name, kRazon ) )
		end
	)

end, "on_member_kick");

handle_event( 
	function( args )
		local lPlayer = args[1];
		local lGroup  = args[2];
		createNotification("Abandonaste el grupo!", lPlayer )
		setGroup ( lPlayer, "N/A" )
		addGroupLog( 
		lGroup, 
			string.format( 
				"%s ".." Abandono el grupo.", 
				getPlayerName( lPlayer ) 
			) 
		)
		refresh_blips();
	end
, "on_member_leave");

handle_event(
function( args )

	local group = args[1];
	local dBy   = args[2];
	for _, columna in ipairs( get_group_member( group ) ) do
		setGroup ( Player( columna["membername"] ), "N/A" );
	end
	createNotification("Grupo eliminado!",dBy)
	setGroup ( dBy, "N/A" )
	refresh_blips();
end, 
"on_group_deleted" );

handle_event(
function( args )
	local pPlayer  = getPlayerFromName( args[1] );
	local byPlayer = args[2];
	local nRank	   = args[3];
	local group    = args[4];

	local myName   = source:getName();
	if isElement( pPlayer ) then
		outputChatBox(myName.."[ "..getPlayerRank( source ).." ] te promovio al rango: "..nRank, pPlayer, 255, 255, 255, true)
	end
	local log = string.format( 
		"%s [ %s ] Modifico el rango de %s Ahora es %s",
		myName,
		getPlayerRank( source ),
		args[1],
		nRank
	)
	addGroupLog( group, log );
	createNotification("Rango cambiado!",byPlayer)
	allgpdateforpromote2( byPlayer )
end, "on_mrank_changed" );


handle_event(
function(args)
	local group = args[1];
	local cBy   = args[3];
	addGroupLog( group, cBy:getName().."[ "..getPlayerRank( cBy ).." ] Actualizo la informacion del grupo" );
	createNotification("Has actualizado la informacion del grupo", cBy, 255, 255, 255, true)
end, "on_ginfo_changed");

handle_event(
function( args )
	local group_invited = args[1];
	local pl_invited 	= args[2];
	local inv_by	 	= args[3];
	pl_invited:outputChat( "Recibiste una invitacion de: "..group_invited.."! Usa #00FF00/aceptar", 255, 255, 255, true )
	local log = string.format( "%s ( %s ) Envió una solicitud para: %s", inv_by:getName(), inv_by:getAccount():getName(), pl_invited:getName() );
	addGroupLog( group_invited, log );
end, "on_player_invited" );

handle_event(
function( args )
	local pl_accept = args[1];
	local group 	= args[2];
	for _, players in ipairs( getElementsByType( "player" ) ) do
		if players:getData( "gang" ) == group then
			outputChatBox(pl_accept:getName().."#ffffff Entro al grupo", players, 255, 255, 255, true)
		end
	end
	addGroupLog( group, pl_accept:getName().." Ingreso al grupo." )
	refresh_blips();
end, "on_player_accept_inv" );