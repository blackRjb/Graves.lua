if GetObjectName(GetMyHero()) ~= "Graves" then return end

require('Inspired') 
require('DeftLib')
require('DamageLib')

local GravesMenu = MenuConfig("Graves", "Graves")
GravesMenu:Menu("Combo", "Combo")
GravesMenu.Combo:Boolean("Q", "Use Q in combo", true)
GravesMenu.Combo:Boolean("W", "Use W" in combo , true)
GravesMenu.Combo:Boolean("E", "Use E to mouse", true)
GravesMenu.Combo:Boolean("R", "Use R in combo", true)
GravesMenu.Combo:Boolean("Burst", "Burst-Combo", true)
GravesMenu.Combo:Boolean("Burst", "Burst-E helper", true)
GravesMenu.Combo:Boolean("Items", "Use Items", true)
GravesMenu.Combo:Booleant("Combo1",  "Combo", string.byte(" "))

GravesMenu:Menu("Harass", "Harass")
GravesMenu.Harass:Boolean("Q", "Use Q", true)
GravesMenu.Harass:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

GravesMenu:Menu("Killsteal", "Killsteal")
GravesMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
GravesMenu.Killsteal:Boolean("W", "Killsteal with W", true)
GravesMenu.Killsteal:Boolean("E", "killsteal with E", false)
GravesMenu.Killstreal:Boolean("R", "killstreal with R", true)

if Ignite ~= nil then 
GravesMenu:Menu("Misc", "Misc")
GravesMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true) 
end

