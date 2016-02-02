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
-------------------------------------------------------------------------
--Killsteal
if mainMenu.Killsteal.ksQ:Value() then
for i,enemy in pairs(GetEnemyHeroes()) do
		if CanUseSpell(myHero,_Q) == READY and ValidTarget(enemy, 1500) and mainMenu.Killsteal.ksQ:Value() and GetCurrentHP(enemy) < qDMG then
			
			if ValidTarget(enemy,1500) and CanUseSpell(myHero,_E) == READY and not IsInDistance(enemy, 925) and mainMenu.Killsteal.ksE:Value() then
				local targetPos = GetOrigin(enemy)
				CastSkillShot(_E, targetPos.x, targetPos.y, targetPos.z)
			end
			
			local QPred = GetPredictionForPlayer(myHeroPos,enemy,GetMoveSpeed(enemy),2000,250,925,50,false,false)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			end	
		end	
	end
end	

if mainMenu.Killsteal.ksR:Value() then
	for i,enemy in pairs(GetEnemyHeroes()) do
		if CanUseSpell(myHero,_R) == READY and ValidTarget(enemy, 2300) and mainMenu.Killsteal.ksR:Value() and GetCurrentHP(enemy) < CalcDamage(myHero,enemy,(120*GetCastLevel(myHero,_R)+80+(1.2*GetBonusDmg(myHero))),0) then
			
			if ValidTarget(enemy,2300) and CanUseSpell(myHero,_E) == READY and not IsInDistance(enemy, 1800) and mainMenu.Killsteal.ksE:Value() then
				local targetPos = GetOrigin(enemy)
				CastSkillShot(_E, targetPos.x, targetPos.y, targetPos.z)
			end			
			
			local RPred2 = GetPredictionForPlayer(myHeroPos,enemy,GetMoveSpeed(enemy),2000,250,1800,100,false,false)
			if RPred2.HitChance == 1 then
				CastSkillShot(_R,RPred2.PredPos.x,RPred2.PredPos.y,RPred2.PredPos.z)
			end
		end
	end
end
-------------------------------------------------------------------------
--Combo
if mainMenu.Combo.Combo1:Value() then
  
if CanUseSpell(myHero,_E) == READY and ValidTarget(target, 950) and GotBuff(myHero, "gravesbasicattackammo2") == 0 and mainMenu.Combo.useE:Value() then
		CastSkillShot(_E, mouse.x, mouse.y, mouse.z)
	end

	if CanUseSpell(myHero,_Q) == READY and ValidTarget(target, 950) and mainMenu.Combo.useQ:Value() then
---------------------------- Q		
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
				CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			end
		elseif MapPosition:inWall(checkPos5) == true then 
			if GetDistance(myHeroPos, checkPos5) > GetDistance(myHeroPos, targetPos) then
				CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			end
		elseif MapPosition:inWall(checkPos4) == true then 
			if GetDistance(myHeroPos, checkPos4) > GetDistance(myHeroPos, targetPos) then
				CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			end
		elseif MapPosition:inWall(checkPos3) == true then 
			if GetDistance(myHeroPos, checkPos3) > GetDistance(myHeroPos, targetPos) then
				CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			end
		elseif MapPosition:inWall(checkPos2) == true then
			if GetDistance(myHeroPos, checkPos2) > GetDistance(myHeroPos, targetPos) then
				CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			end
		elseif MapPosition:inWall(checkPos1) == true then 
			if GetDistance(myHeroPos, checkPos1) > GetDistance(myHeroPos, targetPos) then
				CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			end
		else
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= 40 then
				CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			end
		end
		
		end
		
------------------------ Q	
	end

	if CanUseSpell(myHero,_W) == READY and ValidTarget(target, 950) and GetCurrentMana(myHero) > 170 and mainMenu.Combo.useW:Value() then
		local WPred = GetPredictionForPlayer(myHeroPos,target,GetMoveSpeed(target),1500,250,950,50,false,false)
		if WPred.HitChance == 1 then
			CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
	end
	
	--R 1
	if CanUseSpell(myHero,_R) == READY and mainMenu.Combo.useR:Value() and ValidTarget(target,1000) and GetCurrentHP(target) < CalcDamage(myHero,target,(150*GetCastLevel(myHero,_R)+100+(1.5*GetBonusDmg(myHero))),0) then
		-- PrintChat("R1")
		local RPred1 = GetPredictionForPlayer(myHeroPos,target,GetMoveSpeed(target),2100,250,1800,100,false,false)
		if RPred1.HitChance == 1 then
			CastSkillShot(_R,RPred1.PredPos.x,RPred1.PredPos.y,RPred1.PredPos.z)
		end
	end
	--R 2
	if ValidTarget(target,2000) and CanUseSpell(myHero,_R) == READY and mainMenu.Combo.useR:Value() and not IsInDistance(target, 1000) and IsInDistance(target,1800) and GetCurrentHP(target) < CalcDamage(myHero,target,(120*GetCastLevel(myHero,_R)+80+(1.2*GetBonusDmg(myHero))),0) then
		local RPred2 = GetPredictionForPlayer(myHeroPos,target,GetMoveSpeed(target),2000,250,1800,100,false,false)
		if RPred2.HitChance == 1 then
			CastSkillShot(_R,RPred2.PredPos.x,RPred2.PredPos.y,RPred2.PredPos.z)
		end
	end

end

-- Harass Q
if mainMenu.Harass.Harass1:Value() then
	-- MoveToXYZ(mouse)
if CanUseSpell(myHero,_Q) == READY and ValidTarget(target, 700) and mainMenu.Harass.hQ:Value() and (GetMaxMana(myHero) / GetCurrentMana(myHero)) <= 1.5 then
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
				CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			end
		elseif MapPosition:inWall(checkPos5) == true then 
			if GetDistance(myHeroPos, checkPos5) > GetDistance(myHeroPos, targetPos) then
				CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			end
		elseif MapPosition:inWall(checkPos4) == true then 
			if GetDistance(myHeroPos, checkPos4) > GetDistance(myHeroPos, targetPos) then
				CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			end
		elseif MapPosition:inWall(checkPos3) == true then 
			if GetDistance(myHeroPos, checkPos3) > GetDistance(myHeroPos, targetPos) then
				CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			end
		elseif MapPosition:inWall(checkPos2) == true then
			if GetDistance(myHeroPos, checkPos2) > GetDistance(myHeroPos, targetPos) then
				CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			end
		elseif MapPosition:inWall(checkPos1) == true then 
			if GetDistance(myHeroPos, checkPos1) > GetDistance(myHeroPos, targetPos) then
				CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			end
		else
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
		
		end
end
end

end)

OnDraw(function(myHero)
local target = GetCurrentTarget()

if mainMenu.Drawings.drawBurst:Value() and ValidTarget(target, 1800) then
	DrawDmgOverHpBar(target,GetCurrentHP(target),DPS,0,0xff00ff00)
end	

end)

function VectorWay(A,B)
WayX = B.x - A.x
WayY = B.y - A.y
WayZ = B.z - A.z
return Vector(WayX, WayY, WayZ)
end
