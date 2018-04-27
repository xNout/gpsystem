---------------------------------------------------------------------
--  Desarrollador/Developer: -Rex-
--  Proyecto/Proyect:        N/A
--  Contacto/Contact:        https://www.facebook.com/rexscripting/
--
--  Libre uso y modificacion, No borrar los creditos, Gracias
---------------------------------------------------------------------

local logsTable = { }
local groupsLog = { }
function addGroupLog( grupo, texto )
	
	if not logsTable[grupo] then
		createLog( grupo )
	end

	if ( texto:len() <= 5 ) then return; end

	for i, players in ipairs( getElementsByType( "player" ) ) do
		if getPlayerGroup( players ) == grupo then
			outputChatBox(texto, players, 255, 0, 161, true)
		end
	end

	logsTable[grupo] = texto.."\n"..logsTable[grupo]

end

function saveLogsG(  )
	
	for i,v in ipairs( groupsLog ) do
		
		if fileExists( "logsystem/grupos/"..tostring( v )..".rex" ) then
			fileDelete ( "logsystem/grupos/"..tostring( v )..".rex" )
		end

		local file = fileCreate ( "logsystem/grupos/"..tostring( v )..".rex" )		
		fileWrite( file, logsTable[v] )
		fileClose( file )
	end

end
addEventHandler("onResourceStop",getResourceRootElement( getThisResource() ), saveLogsG)


function groupLog(  )
	
	local grupo = getPlayerGroup( source )
	if not logsTable[grupo] then
		createLog( grupo )
	end
	
	triggerClientEvent( source, "memoLog", source, logsTable[grupo] )
end
addEvent("getLogsGroup",true)
addEventHandler("getLogsGroup",getRootElement(  ),groupLog)

function createLog( grupo )
	if not fileExists( "logsystem/grupos/"..grupo..".rex" ) then
		local file = fileCreate ( "logsystem/grupos/"..grupo..".rex" )
		fileClose( file )
	end

	local hFile = fileOpen("logsystem/grupos/"..grupo..".rex", true) 
	local buffer = ""
	if hFile then
		while not fileIsEOF(hFile) do  
   			buffer = fileRead(hFile, 1000).."\n"..buffer
		end
		fileClose( hFile )
	end
	logsTable[grupo] = buffer
	table.insert( groupsLog, grupo )
end



