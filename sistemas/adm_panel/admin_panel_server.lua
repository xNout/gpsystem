---------------------------------------------------------------------
--  Desarrollador/Developer: -Rex-
--  Proyecto/Proyect:        N/A
--  Contacto/Contact:        https://www.facebook.com/rexscripting/
--
--  Libre uso y modificacion, No borrar los creditos, Gracias
---------------------------------------------------------------------
local regis_db = dbConnect( "sqlite", "dbData_byRex.db" )
local acl_permitido = "Admin" --Tipo de right permitido.
local deleteonrestart = false --Si deseas que se borre el registro, cambia false por true, Si no dejalo Por defecto: false.
local comandoChatGrupal = "y"
local comandoGui = "cgsp"
cosa = {}
cacheRegistry = {}
actionS = {}

addEvent("getGPCLabels", true)
addEvent("getGPCListG", true)
addEvent("getGPCChatListG", true)
addEvent("deleteAGP", true)
addEvent("editSlotsAGP", true)
addEvent("getGPCActiList", true)
addEvent("clearChatRegS", true)
addEvent("clearActiRegS", true)
addEvent("getGPCGROUPInfo", true)
addEvent("saveINFOGPC", true)
addEvent("getMembersGPCList", true)
addEvent("findMemberGPC", true)
addEvent("getAccountGPCText", true)
addEvent("deleteAmmGpc", true)
addEvent("getPlayerGPCListAdd", true)
addEvent("addAmemberGPCListlel", true)
addEvent("findAAggedMemberGPC", true)
addEvent("editArangGPC", true)
addEvent("editGPNAMEGPC", true)
addEvent("getRanksOfGroup2", true)


function openGPCPanel( source )
	local account = source:getAccount():getName();
	if isObjectInACLGroup ("user."..account, aclGetGroup ( "Admin" ) ) then
		triggerClientEvent( source, "openGPCGUI", source)
	end
end
addCommandHandler( comandoGui, openGPCPanel )

function ranksofgroup2(  )
	local grupo = getPlayerGroup(source)
	local Ca = { }

	local ranks = getGroupRanks( grupo )

	for i,v in ipairs(ranks) do
		table.insert( Ca, v[1] )
	end
	triggerClientEvent(source,"aggRanks2", source, Ca)
end
addEventHandler("getRanksOfGroup2", root, ranksofgroup2 )

function delAGP( grupo )
	if isGroupExists( grupo ) then
		local account = source:getAccount();
		local accountName = account:getName();
		deleteGroup( grupo )
		createNotification("El grupo fue eliminado", source)
		triggerClientEvent( source, "clearGPCListG", source )
	else
		createNotification("El grupo no existe",source)
	end
end
addEventHandler("deleteAGP", root, delAGP )

function editSlotsAGPP( group, ammount )
	if isGroupExists( group ) then
		local members, _ = getGroupSlots( group );
		if tonumber( members ) < tonumber( ammount ) then
			regis_db:exec( "UPDATE groupsystem SET slots=? WHERE groupname=?", tostring( ammount ),group )
			createNotification("Los slots fueron editados",source)
		else
			createNotification("Cantidad invalida",source)
		end
	end
end
addEventHandler("editSlotsAGP", root, editSlotsAGPP )

function saveTheINfoGPC( texto, grupo )
	if isGroupExists( grupo ) then
		local account = source:getAccount();
		local accountName = account:getName();
		local by = accountName.." ( "..string.gsub( source:getName(), "#%x%x%x%x%x%x", "").." )"
		regis_db:exec("UPDATE groupinfo SET info=? WHERE gpname=?", texto.."\n\n Editado por: "..by, grupo )
		createNotification("La información del grupo fue editada.", source )
	end
end
addEventHandler("saveINFOGPC", root, saveTheINfoGPC )

function deleteAMembersGPC( nick, grupo )
	local player = getPlayerFromName ( nick );
	if isElement( player ) then
		removePlayerFromGroup( player, grupo)
	else
		regis_db:exec( "DELETE FROM groupmembers WHERE name=? AND membername=?", grupo, nick)
	end
	createNotification(nick:gsub( "#%x%x%x%x%x%x", "" ).." fue expulsado de "..grupo, source)
end
addEventHandler("deleteAmmGpc", root, deleteAMembersGPC )

function aggAMemberGPCListToO( nick, group )
	local members, slots = getGroupSlots( group )
	local player = getPlayerFromName( nick );
	if isElement( player ) then
		local account = source:getAccount();
		local accountName = account:getName();
		local by = accountName.." ( "..string.gsub( source:getName(), "#%x%x%x%x%x%x", "").." )"
		player:setData( "gang", group )
		player:setData( "Group", group )
		addPlayerToGroup( player, group )
		player:outputChat("Fuiste añadido al grupo: "..group.." por "..by, 255,255,255,true)
		createNotification("Se añadio al grupo!", source)
	else
		createNotification("El jugador no existe o se desconecto!",source)
	end
end
addEventHandler("addAmemberGPCListlel", root, aggAMemberGPCListToO )

function editArangoGPC( playerName, rango )
	local player = Player( playerName )
	if isElement( player ) then
		setPlayerRank( player, rango )
		createNotification("El rango de "..playerName:gsub( "#%x%x%x%x%x%x", "" ).." ahora es "..rango,source)
		triggerClientEvent( source, "refreshGPCListMmm" , source )
	else
		createNotification("El jugador no existe!", source)
	end
end
addEventHandler("editArangGPC", root, editArangoGPC )

function editAGPNaMe( oldName, newName )
	if not isGroupExists( newName ) then
		update_group_name( oldName, newName )
		createNotification("El grupo "..oldName.." ahora se llama: "..newName, source )
	else
		createNotification("El nombre del grupo ingresado, Ya existe!", source )
	end
end
addEventHandler("editGPNAMEGPC", root, editAGPNaMe )