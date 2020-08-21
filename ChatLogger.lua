local function fileAppend( filename, contents )

	local f = file.Open( filename, "ab", "DATA" )
	if not f then return end

	f:Write( contents .. "\n" )
	f:Close()

end

fileAppend("logging.txt", "****SCRIPT LOADED! STARING LOGGIN ON: "..tostring(engine.GetServerIP()).."****")

local function UserMessageCallback( msg )    
    if msg:GetID() == 6 then
        local index = msg:GetInt( 1 );
        local message = tostring(msg:GetString( 4, 1 ));
		
        local name = client.GetPlayerNameByIndex( index );
		local steamid = client.GetPlayerInfo(index).SteamID
		local formattedmessage = "["..name.." | "..client.GetPlayerInfo(index).SteamID.."]: "..message
		fileAppend("logging.txt", formattedmessage)		
    end    

end

callbacks.Register( "DispatchUserMessage", "UserMessageExample", UserMessageCallback );

callbacks.Register("Unload", function()
    fileAppend("logging.txt", "****UNLOADED SCRIPT! LOGGING STOPPED****")
end);
