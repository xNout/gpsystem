function exists_in_table( tTable, value )
	for i,v in ipairs(tTable) do
		if ( value == v ) then
			return true;
		end
	end
	return false;
end

--	//Esta funcion es parecida al operador ternario de PHP.
function op_ter( c, v, f )
	if( c ~= false or c ~= nil ) then
		if ( not v ) then v = false end
		if( type(v) == "function" ) then return v(); end
		return v;
	else
		if ( not f ) then f = false end
		if( type(f) == "function" ) then return f(); end
		return f;
	end

end


function switch(arg)

	if ( arg == nil ) then return; end
        if(type(arg)~="table")then return switch end
        local switching, default, done; --Default is nil
        if(tostring(arg[1]):len()<=2)and(tostring(arg[2]):len()<=2)then switching=arg[1] end
        table.remove(arg, 1);
        for i=1, #arg do
                if(tostring(arg[i]):len()<=3)and(arg[i]==switching)then
                        if(type(arg[i+1])=="function")then
                                pcall(arg[i+1])
                                done=true;
                                break
                        else
                                break
                        end
                end
                if(arg[i]==nil)and(arg[i]==switching)and(type(arg[i+1])=="function")then pcall(arg[i+1]) end
        end
end

local formatzero = function ( number )
	
	if( number < 10 ) then
		return "0"..tostring(number);
	end
	return tostring(number);
end
function getTimes ( )

	local time = getRealTime(  )
	local dia = time.monthday;
	local mes = time.month+1;
	return formatzero(dia).."/"..formatzero( mes ).."/20"..( time.year - 100 ).." "..formatzero(time.hour)..":"..formatzero(time.minute)..":"..formatzero(time.second)
end
