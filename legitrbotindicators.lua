callbacks.Register("Draw", "AAIndicator", function()
		        local screenW, screenH = draw.GetScreenSize();
        local screenWCenter = screenW * 0.5;
        local screenHCenter = screenH * 0.5;
        local indicatorScale = 1
        local indicatorGap = 20
 	            if (gui.GetValue("rbot.antiaim.fakeyawstyle") == 1) then

				
                draw.Color(255, 0, 0, 255);
                draw.Triangle( screenWCenter + indicatorGap + (15 * indicatorScale), screenHCenter, screenWCenter + indicatorGap, screenHCenter + (10 * indicatorScale), screenWCenter + indicatorGap, screenHCenter - (10 * indicatorScale) );
			elseif(gui.GetValue("rbot.antiaim.fakeyawstyle") == 2) then
                draw.Color(255, 0, 0, 255);
                draw.Triangle( screenWCenter - indicatorGap - (15 * indicatorScale), screenHCenter, screenWCenter - indicatorGap, screenHCenter - (10 * indicatorScale), screenWCenter - indicatorGap, screenHCenter + (10 * indicatorScale) );
            end

            draw.OutlinedCircle( screenW/2, screenH/2, gui.GetValue("rbot.aim.target.fov") * 16  )

end)
