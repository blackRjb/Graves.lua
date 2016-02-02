if GetObjectName(GetMyHero()) ~= "Graves" then return end

require('Inspired')
require('DamageLib')

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
-------------------------------------------------------------------------
--DamageSpell
if ValidTarget(target, 1800) then
if CanUseSpell(myHero,_Q) == READY then
		local QPred = GetPredictionForPlayer(myHeroPos,target,GetMoveSpeed(target),2000,250,925,50,false,false)
		if QPred.HitChance == 1 then
		
		local targetPos = GetOrigin(target)
		
		local checkPos1 = myHeroPos + ((VectorWay(myHeroPos, targetPos))/GetDistance(myHeroPos,targetPos))*930
		local checkPos2 = myHeroPos + ((VectorWay(myHeroPos, targetPos))/GetDistance(myHeroPos,targetPos))*(925/1.2)
		local checkPos3 = myHeroPos + ((VectorWay(myHeroPos, targetPos))/GetDistance(myHeroPos,targetPos))*(925/1.5)
		local checkPos4 = myHeroPos + ((VectorWay(myHeroPos, targetPos))/GetDistance(myHeroPos,targetPos))*(925/2)
		local checkPos5 = myHeroPos + ((VectorWay(myHeroPos, targetPos))/GetDistance(myHeroPos,targetPos))*(925/3)
		local checkPos6 = myHeroPos + ((VectorWay(myHeroPos, targetPos))/GetDistance(myHeroPos,targetPos))*(925/6)

		if MapPosition:inWall(checkPos6) == true then 
			if GetDistance(myHeroPos, checkPos6) > GetDistance(myHeroPos, targetPos) then
				qDMG = CalcDamage(myHero,target,(85*GetCastLevel(myHero,_Q)+65+((0.95+(0.20*GetCastLevel(myHero,_Q)))*(GetBonusDmg(myHero)))),0)
			end
		elseif MapPosition:inWall(checkPos5) == true then 
			if GetDistance(myHeroPos, checkPos5) > GetDistance(myHeroPos, targetPos) then
				qDMG = CalcDamage(myHero,target,(85*GetCastLevel(myHero,_Q)+65+((0.95+(0.20*GetCastLevel(myHero,_Q)))*(GetBonusDmg(myHero)))),0)
			end
		elseif MapPosition:inWall(checkPos4) == true then 
			if GetDistance(myHeroPos, checkPos4) > GetDistance(myHeroPos, targetPos) then
				qDMG = CalcDamage(myHero,target,(85*GetCastLevel(myHero,_Q)+65+((0.95+(0.20*GetCastLevel(myHero,_Q)))*(GetBonusDmg(myHero)))),0)
			end
		elseif MapPosition:inWall(checkPos3) == true then 
			if GetDistance(myHeroPos, checkPos3) > GetDistance(myHeroPos, targetPos) then
				qDMG = CalcDamage(myHero,target,(85*GetCastLevel(myHero,_Q)+65+((0.95+(0.20*GetCastLevel(myHero,_Q)))*(GetBonusDmg(myHero)))),0)
			end
		elseif MapPosition:inWall(checkPos2) == true then
			if GetDistance(myHeroPos, checkPos2) > GetDistance(myHeroPos, targetPos) then
				qDMG = CalcDamage(myHero,target,(85*GetCastLevel(myHero,_Q)+65+((0.95+(0.20*GetCastLevel(myHero,_Q)))*(GetBonusDmg(myHero)))),0)
			end
		elseif MapPosition:inWall(checkPos1) == true then 
			if GetDistance(myHeroPos, checkPos1) > GetDistance(myHeroPos, targetPos) then
				qDMG = CalcDamage(myHero,target,(85*GetCastLevel(myHero,_Q)+65+((0.95+(0.20*GetCastLevel(myHero,_Q)))*(GetBonusDmg(myHero)))),0)
			end
		else
			qDMG = CalcDamage(myHero,target,(20*GetCastLevel(myHero,_Q)+40+(0.75*GetBonusDmg(myHero))),0)
		end
		
		else qDMG = CalcDamage(myHero,target,(20*GetCastLevel(myHero,_Q)+40+(0.75*GetBonusDmg(myHero))),0)
		
		end
	else qDMG = 0
end

if CanUseSpell(myHero,_R) == READY then
	rDMG = CalcDamage(myHero,target,(120*GetCastLevel(myHero,_R)+80+(1.2*GetBonusDmg(myHero))),0)
else rDMG = 0
end

if GotBuff(myHero,"itemstatikshankcharge") == 100 then
	extraDMG = CalcDamage(myHero,target,0,100)
else
	extraDMG = 0
end

DPS = qDMG + rDMG + extraDMG

end
