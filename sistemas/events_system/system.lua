events = {}
events.handled = {};
events.callbacks = { };

function exec_event( event_name, ... )
	local arguments = { ... };
	arguments.lenght = #arguments;
	local event_callback = function( event_name, arguments )
		for i, _function in ipairs(events.callbacks) do
			_function( event_name, arguments);		
		end
	end
	
	if( events.handled[event_name] ~= nil ) then
		event_callback( event_name, arguments );
		for i, _functions in ipairs(events.handled[event_name] or { }) do
			_functions( arguments );
		end
	end
end

function handle_event( _function, event )
	
	if ( not events.handled[event] ) then
		events.handled[event] = { };
	end
	local result = false;

	if not exists_in_table( events.handled[event] ) then
		table.insert( events.handled[event], _function ) 
		result = true; 
	end

	if( not result ) then
		outputDebugString( 
			"Event: [ ".. event .." ] already handled", 
			3, 
			255, 
			0, 
			0 
		);
		return;
	end
	outputDebugString( 
			"Event: [ ".. event .." ] handled", 
			0, 
			0, 
			255, 
			0 
		);
end
--	//Este funcion se ejecuta cada que sucede un evento y retorna los argumentos del mismo ( En pocas palabras, un delegado )
function add_ecallback( _function )

	if not exists_in_table( _function, events.callbacks) then
		table.insert( events.callbacks, _function );
		outputDebugString(  debug.getinfo(1,"n").name .." was added to events callback" );
	else
		outputDebugString(  debug.getinfo(1,"n").name .." was already been added" )
	end

end

-- events = {}
-- events.handled = {};
-- events.callbacks = { };

-- function exec_event( event_name, ... )
-- 	local arguments = { ... };
-- 	arguments.lenght = #arguments;
-- 	local event_callback = function( event_name, arguments )
-- 		for i, _function in ipairs(events.callbacks) do
-- 			_function( event_name, arguments);		
-- 		end
-- 	end
	
-- 	op_ter( events.handled[event_name], 
-- 	function( ) 
-- 		event_callback( event_name, arguments );
-- 		for i, _functions in ipairs(events.handled[event_name] or { }) do
-- 			_functions( arguments );
-- 		end
-- 	end
-- 	);
-- end

-- function handle_event( _function, event )
	
-- 	if ( not events.handled[event] ) then
-- 		events.handled[event] = { };
-- 	end
-- 	local result = op_ter( 
-- 		not exists_in_table( events.handled[event] ), 
-- 		function( ) 
-- 			table.insert( events.handled[event], _function ) 
-- 			return true; 
-- 		end, 
-- 		false 
-- 	);
-- 	if( not result ) then
-- 		outputDebugString( 
-- 			"Event: [ ".. event .." ] already handled", 
-- 			3, 
-- 			255, 
-- 			0, 
-- 			0 
-- 		);
-- 		return;
-- 	end
-- 	outputDebugString( 
-- 			"Event: [ ".. event .." ] handled", 
-- 			0, 
-- 			0, 
-- 			255, 
-- 			0 
-- 		);
-- end
-- --	//Este funcion se ejecuta cada que sucede un evento y retorna los argumentos del mismo ( En pocas palabras, un delegado )
-- function add_ecallback( _function )

-- 	op_ter( not exists_in_table( _function, events.callbacks), 
-- 		function()
-- 			table.insert( events.callbacks, _function );
-- 			outputDebugString(  debug.getinfo(1,"n").name .." was added to events callback" );
-- 			return true;
-- 		end,
-- 		outputDebugString(  debug.getinfo(1,"n").name .." was already been added" )
-- 		)
-- end


-- exec_event( );