-- COOL CHAT LOGGER WITH DISCORD WEBHOOK

-- CONFIG
-- CONFIG
-- CONFIG


local steampi = "your steam api"
local webhook = "your discord webhook"

-- CONFIG END
-- CONFIG END
-- CONFIG END


local json = RunScript("json.lua") -- u need that https://github.com/OzaronZ/AimwareV5-Lua-Scripts/blob/master/json.lua
local function UserMessageCallback( msg )     -- yes standart API
    if msg:GetID() == 6 then
        local index = msg:GetInt( 1 );
        local message = tostring(msg:GetString( 4, 1 ));
        local name = client.GetPlayerNameByIndex( index );
		    local steamid = [[765611]] .. 97960265728 + client.GetPlayerInfo(index).SteamID .. [[]]
		    http.Get("http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key="..steamapi.."&steamids="..steamid, function(body)
			      panorama.RunScript([[
			          $.AsyncWebRequest(']]..webhook..[[', {
				            type: 'POST',
				            data: {
					              avatar_url: "]]..json.decode(body)['response']['players'][1]['avatar']..[[",
					              username: "]].. name .. [[ or ]].. steamid ..[[",
					              content: '`]] .. message .. [[`'
				            }
			          });
		        ]])
		    end)	
    end    
end

callbacks.Register( "DispatchUserMessage", "UserMessageExample", UserMessageCallback );
