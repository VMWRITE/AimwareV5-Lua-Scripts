-- CREATED BY Ozaron#5101
callbacks.Register("SendStringCmd", function(cmd) 
	if string.find(cmd:Get(),"say ") == 1 then 
		preby1 = cmd:Get():gsub("say ","") 
		preby2 = preby1:gsub('n',"ກ"):gsub('N', 'Ń'):gsub('D', 'Ɗ⁣⁣⁣⁣⁣⁣'):gsub('d', 'ď⁣⁣⁣'):gsub("i", "1⁣⁣⁣⁣"):gsub("g", "ġ"):gsub("Х", "χ"):gsub("а", "ά" ):gsub("Ч", "4"):gsub("ч", "4"):gsub("А", "Ằ"):gsub("O", "Õ"):gsub("o", "ò"):gsub("й", "น"):gsub("и", "ũ"):gsub("е", "é"):gsub("б", "ƃ")
		cmd:Set( "say "..preby2 );
	end 
end)
