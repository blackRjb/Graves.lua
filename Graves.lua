if GetObjectName(GetMyHero()) ~= "Graves" then return end

require('Inspired')

local mainMenu = Menu("ADC MAIN | Graves", "Graves")
mainMenu:Menu("Combo", "Combo")
mainMenu.Combo:Boolean("Q", "Use Q in combo", true)
mainMenu.Combo:Boolean("W", "Use W in combo", true)
mainMenu.Combo:Boolean("E", "Use E to mouse", false)
mainMenu.Combo:Boolean("R", "Use R in combo", true)
mainMenu.Combo:Key("Combo1", "Combo", string.byte(" "))
-------------------------------------------------------------------------
mainMenu:Menu("Harass", "Harass")
mainMenu.Harass:Boolean("hQ", "Use Q", true)
mainMenu.Harass:Slider("Mana", "if Mana % >", 30, 0, 80, 1)
mainMenu.Harass:Key("Harass1", "Harass", string.byte("C"))
-------------------------------------------------------------------------
mainMenu:Menu("Killsteal", "Killsteal")
mainMenu.Killsteal:Boolean("ksQ", "Use Q", true)
mainMenu.Killsteal:Boolean("ksW", "Use W", true)
mainMenu.Killsteal:Boolean("ksE", "KS-E helper", false)
mainMenu.Killsteal:Boolean("KsR", "Use R", true)
-------------------------------------------------------------------------
if Ignite ~= nil then 
mainMenu:Menu("Misc", "Misc")
mainMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true) 
end
