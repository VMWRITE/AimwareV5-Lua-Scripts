	local function is_holding_knfie(weapon)
		if (weapon == nil) then
			return false
		end
		local name = weapon:GetName()

		if (string.find(name, "knife") or string.find(name, "bayonet")) then
			return true
		end

		return false
	end


	callbacks.Register("Draw", "DrawKnifeInLeft", function()
		if not entities.GetLocalPlayer():IsAlive() then return end
		local weapon = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon");
		local name = weapon:GetName();

		if(weapon == nil) then return end

		
		if is_holding_knfie(weapon)  then client.SetConVar("cl_righthand", 0)

	else

	client.SetConVar("cl_righthand", 1)

	end
	end)
