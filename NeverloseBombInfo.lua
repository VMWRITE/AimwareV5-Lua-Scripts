-- CREATED BY Ozaron#5101

local w, h = draw.GetScreenSize()
local font = draw.CreateFont( "Arial", 18, 5000 )
local font2 = draw.CreateFont( "Arial", 24, 550 )
local defusing = false;
local plantedat = 0;
local bombsite = "???";
local display = false

local texture = draw.CreateTexture(common.DecodePNG(http.Get("https://i.imgur.com/hcnUI4D.png")))
local texture2 = draw.CreateTexture(common.DecodePNG(http.Get("https://i.imgur.com/c5FeE3B.png")))

local function lerp_pos(x1, y1, z1, x2, y2, z2, percentage) 
local x = (x2 - x1) * percentage + x1 
local y = (y2 - y1) * percentage + y1
local z = (z2 - z1) * percentage + z1 

	return x, y, z 
end

local function sitename(site) 

local avec = entities.GetPlayerResources():GetProp("m_bombsiteCenterA")
local bvec = entities.GetPlayerResources():GetProp("m_bombsiteCenterB")
local sitevec1 = site:GetMins()
local sitevec2 = site:GetMaxs()
local site_x, site_y, site_z = lerp_pos(sitevec1.x, sitevec1.y, sitevec1.z , sitevec2.x, sitevec2.y, sitevec2.z, 0.5)
local distance_a, distance_b = vector.Distance({site_x, site_y, site_z}, {avec.x, avec.y, avec.z}), vector.Distance({site_x, site_y, site_z}, {bvec.x, bvec.y, bvec.z})

	return distance_b > distance_a and "A" or "B" 

end

function 
	(Event)

	if Event:GetName() == "bomb_beginplant" then 
		
		display = true
		planter = client.GetPlayerNameByUserID(Event:GetInt("userid")) 
		plantingStarted = globals.CurTime() 
		bombsite = sitename(entities.GetByIndex(Event:GetInt("site")))
		planting = true 
		
		
	end
	
	if Event:GetName() == "bomb_abortplant" then 
	
		display = false
		planting = false
		
	end
	
	if Event:GetName() == "bomb_begindefuse" then
		
		defusing = true
	
	elseif Event:GetName() == "bomb_abortdefuse" then
	
		defusing = false
	
	elseif Event:GetName() == "round_officially_ended" or Event:GetName() == "bomb_defused" or Event:GetName() == "bomb_exploded" then
		
		display = false
		defusing = false
		planting = false
	
	end
	
	if Event:GetName() == "bomb_planted" then

		plantedat = globals.CurTime()
		planting = false
	
	end
	
end



callbacks.Register("Draw", "NeverLoseBombInfo", function()
local Bomb = entities.FindByClass("CPlantedC4")[1];
if display then
if entities.FindByClass("CPlantedC4")[1] ~= nil then	
	local bombtimer = math.floor((plantedat - globals.CurTime() + Bomb:GetProp("m_flTimerLength")) * 10) / 10
	draw.SetFont(font)
	draw.Color(0, 150, 255, 50)
	draw.RoundedRectFill( 2, h/2.2, 268, h/2+3, 3, true, true, true, true )
    draw.Color(5,14,26, 255)
    draw.FilledRect(5, h/2-45, 265, h/2)
	draw.Color(255,255,255,255)
	if defusing == true then
					local defusetime = math.floor( (Bomb:GetProp("m_flDefuseCountDown") - globals.CurTime()) * 10 ) / 10
                
                defusetime = tostring(defusetime)
                if not string.find(defusetime, "%.") then
                    defusetime = defusetime .. ""
                end
				draw.Text(65, h/2-40, "Defuse Time: "..defusetime)
	else
	draw.Text(65, h/2-40, "Defuse Time: 0")
	end
	draw.Text(65, h/2-16, "Damage: "..math.floor(0.5 + BombDamage(Bomb)))
	draw.SetFont(font2)
	draw.Text(195, h/2-30, bombsite)
	draw.Text(225, h/2-30, math.floor(0.5 + bombtimer).."s")
	draw.SetTexture( texture );
    draw.FilledRect( 0, h/2-65, 67, h/2+15 );
end
end
end)

function BombDamage(Bomb)

  local playerOrigin = entities.GetLocalPlayer():GetAbsOrigin()
  local bombOrigin = Bomb:GetAbsOrigin()

	local C4Distance = math.sqrt((bombOrigin.x - playerOrigin.x) ^ 2 + 
	(bombOrigin.y - playerOrigin.y) ^ 2 + 
	(bombOrigin.z - playerOrigin.z) ^ 2);

	local Gauss = (C4Distance - 75.68) / 789.2 
	local flDamage = 450.7 * math.exp(-Gauss * Gauss);

		if entities.GetLocalPlayer():GetProp("m_ArmorValue") > 0 then

			local flArmorRatio = 0.5;
			local flArmorBonus = 0.5;

			if entities.GetLocalPlayer():GetProp("m_ArmorValue") > 0 then
			
				local flNew = flDamage * flArmorRatio;
				local flArmor = (flDamage - flNew) * flArmorBonus;
			 
				if flArmor > entities.GetLocalPlayer():GetProp("m_ArmorValue") then
				
					flArmor = entities.GetLocalPlayer():GetProp("m_ArmorValue") * (1 / flArmorBonus);
					flNew = flDamage - flArmor;
					
				end
			 
			flDamage = flNew;

			end

		end 
		
	return math.max(flDamage, 0);
	
end
callbacks.Register("FireGameEvent", "EventHookB", EventHook);
client.AllowListener( "bomb_beginplant" );
client.AllowListener( "bomb_abortplant" );
client.AllowListener( "bomb_begindefuse" );
client.AllowListener( "bomb_abortdefuse" ); 
client.AllowListener( "bomb_defused" );
client.AllowListener( "bomb_exploded" );
client.AllowListener( "round_officially_ended" );
client.AllowListener( "bomb_planted" );

