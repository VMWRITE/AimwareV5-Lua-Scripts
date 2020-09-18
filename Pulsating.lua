local cb = gui.Checkbox( gui.Reference( "Visuals", "Other", "Effects" ), "esp.chams.ragdoll.pulsating", "Pulsating Chams", 0)
callbacks.Register( 'Draw', function()
if not cb:GetValue() then return end
local o = math.floor(math.sin((globals.RealTime()) * 6) * 68 + 112) - 40
gui.SetValue("esp.chams.enemyragdoll.visible.clr", 0, 255, 0, o)
gui.SetValue("esp.chams.localarms.visible.clr", 0, 98, 58, o)
gui.SetValue("esp.chams.ghost.visible.clr", 142, 214, 164, o)
end)
