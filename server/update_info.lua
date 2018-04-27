addEvent("saveAeditedinfos",true)
addEventHandler("saveAeditedinfos",getRootElement(  ),
function ( information )
	local grupo = getPlayerGroup( source );
	update_group_information( grupo, information )
	exec_event( "on_ginfo_changed", grupo, information, source )
end)
