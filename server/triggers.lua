addEvent("reproms",true)
addEventHandler("reproms",getRootElement(  ),
function (  )
	local grupo = getPlayerGroup(source)
	for _,columna in ipairs(get_group_member( grupo )) do
		triggerClientEvent(source,"addPronmgListM",source,columna["membername"],columna["rang"])
	end

	local Ca = { }

	for i,v in ipairs(getGroupRanks( grupo )) do
		table.insert( Ca, v[1] )
	end
	triggerClientEvent(source,"agregarRangos", source, Ca)
end)

function allgpdateforpromote2( player )
	for _,columna in ipairs(get_group_member( getPlayerGroup( player ) )) do
		triggerClientEvent(player,"addPronmgListM",player, columna["membername"],columna["rang"])
	end
end

addEvent("gtlistgpsv",true)
addEventHandler("gtlistgpsv",getRootElement(  ),
function (  )
	
	local groups = get_groups();
	if #groups > 0 then
		local listCache = { }

		for i,columna in ipairs(groups) do

			for _,grupo in pairs ( columna ) do

				local GPSlot  = { getGroupSlots(grupo) }
				local players = GPSlot[1]
				local slots   = GPSlot[2]

				if players and slots then
					table.insert( listCache, { grupo, players.."/"..slots })
				end

			end

		end

		triggerClientEvent(source,"addGLLListM",source, listCache )
	end
end)



addEvent("gpgpphelpinfo",true)
addEventHandler("gpgpphelpinfo",getRootElement(  ),
function (  )
	send_info_toclient( source,"goupinfo" )
end)


addEvent("setinfotoedit",true)
addEventHandler("setinfotoedit",getRootElement(  ),
function ( )
	send_info_toclient( source,"toeditinfogp" )
end)

function send_info_toclient( player, event )
	triggerClientEvent(player,event, player, get_group_information( getPlayerGroup( player ) ))
end

function send_memberlist_toclient( player, event )
	triggerClientEvent(player, event, player, player_groupmembers( player ) )
end

addEvent("getcdtgroup",true)
addEventHandler("getcdtgroup",getRootElement(  ),
function (  )
	send_memberlist_toclient( source, "addCgListM" );
end)

addEvent("viewmembersall",true)
addEventHandler("viewmembersall",getRootElement(  ),
function (  )
	send_memberlist_toclient( source, "listofmebers" );
end)

add_event(
function ( )

	local gang = source:getData("group") or source:getData("gang")

	if( gang == "N/A" ) then return end

	if ( not isPlayerInGroup(source) ) then
		triggerClientEvent(source,"datosdegui",source,"N/A","no", "no")
		return;
	end

	local tActive = 0;
	for _, players in ipairs( getElementsByType("player")) do
		if( getPlayerGroup( players ) == gang ) then
			tActive = tActive + 1;
		end
	end
	-- local tMiembros = #get_group_member( gang ) or 0;

	if isPlayerFounder(source,gang) then
		triggerClientEvent(source,"datosdegui",source,gang,"si","si", "true", "true", "true", "true", "true", "true", "true", tActive)
		return;
	end

	local c           = { getGroupRankPermisos( gang, getPlayerRank( source ) ) }
	local kick        = c[1]
	local chat        = c[2]
	local Crangos     = c[3]
	local Alianzas    = c[4]
	local apelaciones = c[5]
	local informacion = c[6]

	local result = 
	function() 

		if kick == "true" or chat == "true" 
		or Crangos == "true" or Alianzas == "true" 
		or apelaciones == "true" or informacion == "true" then 
			return "si"; 
		else 
			return "no";
		end 
	end

	

	triggerClientEvent(source,"datosdegui",source,gang,"si","no", result(), kick, chat, Crangos, Alianzas, apelaciones, informacion, tActive );
end, "get_group_datas", root )

add_event(
function ( )
	local t = { }
	for i,v in ipairs(getGroupRanks( getPlayerGroup( source ) )) do
		table.insert( t, v[1] )
	end
	triggerClientEvent( source, "send_ranks_t", source, t )
end, "get_ranks_list", root )