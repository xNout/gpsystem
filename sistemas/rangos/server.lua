---------------------------------------------------------------------
--  Desarrollador/Developer: -Rex-
--  Proyecto/Proyect:        N/A
--  Contacto/Contact:        https://www.facebook.com/rexscripting/
--
--  Libre uso y modificacion, No borrar los creditos, Gracias
---------------------------------------------------------------------
local connection = dbConnect( "sqlite", "dbData_byRex.db" )

function ClientCreateRank ( nombreRank, kick, chat, Crangos, Alianzas, apelaciones, informacion, bool )

	local playerGroup = getPlayerGroup( source )

	if not isRankAlreadyCreated ( playerGroup, nombreRank ) then
		addGroupLog( playerGroup, getPlayerName( source ).." [ "..getPlayerRank( source ).." ] Creo un nuevo Rango: "..nombreRank )
		createNewGroupRank( playerGroup, nombreRank, kick, chat, Crangos, Alianzas, apelaciones, informacion )
		createNotification( "Rango creado con exito!", source )
		triggerClientEvent( source, "closeCCRanks", source )
	else

		if bool then
			createNotification( "Rango modificado con exito!", source )
			addGroupLog( playerGroup, getPlayerName( source ).." [ "..getPlayerRank( source ).." ] Modifico el Rango: "..nombreRank )
			setGroupRankPermission( playerGroup, nombreRank, "kick", kick )
			setGroupRankPermission( playerGroup, nombreRank, "pchat", chat )
			setGroupRankPermission( playerGroup, nombreRank, "crank", Crangos )
			setGroupRankPermission( playerGroup, nombreRank, "alianzas", Alianzas )
			setGroupRankPermission( playerGroup, nombreRank, "apelacion", apelaciones )
			setGroupRankPermission( playerGroup, nombreRank, "informacion", informacion )

			triggerClientEvent( source, "closeCCRanks", source )
		else
			createNotification( "El rango ya existe!", source )
		end

	end

end
addEvent( "saveNewRank", true )
addEventHandler( "saveNewRank", getRootElement(  ), ClientCreateRank )

function groupRanks(  )
	
	local playerGroup = getPlayerGroup( source )
	local ranksTable  = getGroupRanks ( playerGroup )
	triggerClientEvent( source, "addRanks", source, ranksTable )
end
addEvent( "getRanksGroup", true )
addEventHandler( "getRanksGroup", getRootElement(  ), groupRanks )

function groupRanks2( source )
	
	local playerGroup = getPlayerGroup( source )
	local ranksTable  = getGroupRanks ( playerGroup )
	triggerClientEvent( source, "addRanks", source, ranksTable )
end

function getP( rango )
	local playerGroup = getPlayerGroup( source )
	local kick, chat, Crangos, Alianzas, apelaciones, informacion = getGroupRankPermisos ( playerGroup, rango )
	triggerClientEvent( source, "setCheckboksqueflojerahdp", source, kick, chat, Crangos, Alianzas, apelaciones, informacion )
end
addEvent( "getRankPermissions", true )
addEventHandler( "getRankPermissions", getRootElement(  ), getP )

function deleteRanks( rankName )

	if rankName == "Trial" then
		createNotification( "No puedes eliminar un rango por defecto!", source )
		return
	end

	local playerGroup = getPlayerGroup( source )
	deleteGroupRank( playerGroup, rankName )
	createNotification( "Rango eliminado con exito!", source )
	--
	addGroupLog( playerGroup, getPlayerName( source ).." [ "..getPlayerRank( source ).." ] Elimino el Rango: "..rankName )

	local qh = dbQuery( connection, "SELECT * FROM groupmembers WHERE name=?", playerGroup )
	local poll = dbPoll( qh, -1 )
	for _, columna in ipairs(poll) do

		local accName = columna["memberacc"]
		local theRank = columna["rang"]

		if theRank == rankName then
			dbExec( connection, "UPDATE groupmembers SET rang=? WHERE memberacc=? AND name=?", "Trial", accName, playerGroup )
			groupRanks2 ( source )
		end

	end

	local playerGroup = getPlayerGroup( source )
	local ranksTable  = getGroupRanks ( playerGroup )
	triggerClientEvent( source, "addRanks", source, ranksTable )	
end
addEvent( "deleterank", true )
addEventHandler( "deleterank", getRootElement(  ), deleteRanks )

function createNewGroupRank( grupo, rankName, kick, chat, Crangos, Alianzas, apelaciones, informacion )
	
	if grupo and rankName and kick and chat and Crangos and Alianzas and apelaciones and informacion then

		dbExec( connection, "INSERT INTO groupRanks ( grupo, rankName, kickP, Pchat, CRank, AAlianzas, Apelaciones, informacion) VALUES(?,?,?,?,?,?,?,?)", grupo, rankName, kick, chat, Crangos, Alianzas, apelaciones, informacion )
	end

end

function getGroupRanks( grupo )
	
	local caC = { }
	local testQuery = dbQuery( connection, "SELECT * FROM groupRanks WHERE grupo=?", grupo )
	local poll      = dbPoll ( testQuery, -1 )
	for i,columna in ipairs( poll ) do
		local kick        = columna["kickP"]  
        local chat        = columna["Pchat"]      
        local Crangos     = columna["CRank"]      
        local Alianzas    = columna["AAlianzas"]  
        local apelaciones = columna["Apelaciones"]
        local informacion = columna["informacion"]
		table.insert( caC, { columna["rankName"], kick, chat, Crangos, Alianzas, apelaciones, informacion } )
	end

	return caC

end
function getGroupRankPermisos( grupo, rankName )
	
	if grupo and rankName then

		local testQuery = dbQuery( connection, "SELECT * FROM groupRanks WHERE grupo=? AND rankName=?", grupo, rankName )
		local poll      = dbPoll ( testQuery, -1 )

		for i, columna in ipairs( poll ) do

			local kick        = columna["kickP"]  
            local chat        = columna["Pchat"]       
            local Crangos     = columna["CRank"]       
            local Alianzas    = columna["AAlianzas"]   
            local apelaciones = columna["Apelaciones"] 
            local informacion = columna["informacion"] 
            return tostring ( kick ), tostring ( chat ), tostring ( Crangos ), tostring ( Alianzas ), tostring ( apelaciones ), tostring ( informacion )
		end
		return nil, nil, nil, nil, nil, nil

	end

end

function deleteGroupRank( grupo, rank )
	dbExec( connection, "DELETE FROM groupRanks WHERE grupo=? AND rankName=?", grupo, rank)
end

function setGroupRankPermission( grupo, rankName, permisoName, bool )

	if grupo and rankName and permisoName and bool then

		local self

		if permisoName == "kick" then
			self = "kickP"
		elseif permisoName == "pchat" then
			self = "Pchat"
		elseif permisoName == "crank" then
			self = "CRank"
		elseif permisoName == "alianzas" then
			self = "AAlianzas"
		elseif permisoName == "apelacion" then
			self = "Apelaciones"
		elseif permisoName == "informacion" then
			self = "informacion"
		end

		if self then
			dbExec( connection, "UPDATE groupRanks SET "..self.."=? WHERE grupo=? AND rankName=?", tostring( bool ), grupo, rankName )
		end

	end
end

function isRankAlreadyCreated( group, rank )
	local testQuery = dbQuery( connection, "SELECT rankName FROM groupRanks WHERE grupo=?", group )
	local poll      = dbPoll ( testQuery, -1 )

	for i,v in ipairs( poll ) do
		
		local ra = v["rankName"]

		if ra == rank then
			return true
		end

	end

	return false

end

local tbool = 
{
    [true]    = "true",
    [false]   = "false",
    ["true"]  = true,
    ["false"] = false,
}

function tr( s )
    
    if tbool[s] then
        return tbool[s]
    end

    return nil

end