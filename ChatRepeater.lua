-- CREATED BY Ozaron#5101
callbacks.Register( "DispatchUserMessage", "AutoRepeatChat ", function( msg )    
    if msg:GetID() == 6 then
        local index = msg:GetInt( 1 );
        local message = msg:GetString( 4, 1 );
		local player = entities.GetByIndex(index);
		if player:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() then -- team check
			client.ChatSay( message )
		end
    end    
end);
