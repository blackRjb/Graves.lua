if GetObjectName(GetMyHero()) ~= "Graves" then return end

require('Inspired')
require('DamageLib')
require('MapPositionGOS')

local myHero = GetMyHero()
local mainMenu = Menu("ADC MAIN | Graves", "Graves")  -- NOTE: you need to change the name XD looks like you took it from noddy
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
	mainMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true)  ---- NOTE: you made a menu if they have ignite that you will auto ignite, now you need to make a function aswell
end
-------------------------------------------------------------------------
-- Combo
local function comboFunction() -- NOTE: i made it a function so you can use the function in the ontick and for clean code, MORE INFORMATION ABOUT ONTICK DOWN!!! ;)
	if mainMenu.Combo.Combo1:Value() then
		-- Standart
		local target = GetCurrentTarget() -- NOTE: again (like mouse) you say target but you need to say who the target is ^^
		local mouse = GetMousePos() -- NOTE: you said mouse.x, mouse.y, mouse.z but didn't have mouse defined as a variable...
		local myHeroPos = GetOrigin(myHero) -- NOTE: Same as mouse and target ^^
		if CanUseSpell(myHero,_E) == READY and ValidTarget(target, 950) and GotBuff(myHero, "gravesbasicattackammo2") == 0 and mainMenu.Combo.useE:Value() then
			CastSkillShot(_E, mouse) -- NOTE: you can just write mouse instead of mouse.x, mouse.y, mouse.z :D
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

				if MapPosition:inWall(checkPos6) then -- You don't nee to write '== true' because it's boolean, if it's true then... so you can just write it and if it's true it will execute else it  wont
					if GetDistance(myHeroPos, checkPos6) > GetDistance(myHeroPos, targetPos) then -- NOTE: like target and mouse what is heropos? you need to define it --> defined by local myHeroPos = GetOrigin(myHero)
						CastSkillShot(_Q,QPred.PredPos)
					end
				elseif MapPosition:inWall(checkPos5) then --idem
					if GetDistance(myHeroPos, checkPos5) > GetDistance(myHeroPos, targetPos) then --idem
						CastSkillShot(_Q,QPred.PredPos) --idem
					end
				elseif MapPosition:inWall(checkPos4) then --idem
					if GetDistance(myHeroPos, checkPos4) > GetDistance(myHeroPos, targetPos) then -- idem
						CastSkillShot(_Q,QPred.PredPos) --idem
					end
				elseif MapPosition:inWall(checkPos3) then --idem
					if GetDistance(myHeroPos, checkPos3) > GetDistance(myHeroPos, targetPos) then-- idem
						CastSkillShot(_Q,QPred.PredPos) --idem
					end
				elseif MapPosition:inWall(checkPos2) then -- idem
					if GetDistance(myHeroPos, checkPos2) > GetDistance(myHeroPos, targetPos) then-- idem
						CastSkillShot(_Q,QPred.PredPos) --idem
					end
				elseif MapPosition:inWall(checkPos1) then -- idem
					if GetDistance(myHeroPos, checkPos1) > GetDistance(myHeroPos, targetPos) then-- idem
						CastSkillShot(_Q,QPred.PredPos)-- idem
					end
				else
					if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= 40 then
						CastSkillShot(_Q,QPred.PredPos) -- idem
					end
				end
			
			end
			
	------------------------ Q	
		end

		if CanUseSpell(myHero,_W) == READY and ValidTarget(target, 950) and GetCurrentMana(myHero) > 170 and mainMenu.Combo.useW:Value() then
			local WPred = GetPredictionForPlayer(myHeroPos,target,GetMoveSpeed(target),1500,250,950,50,false,false)
			if WPred.HitChance == 1 then
				CastSkillShot(_W,WPred) --idem ;)
			end
		end
		
		--R 1
		if CanUseSpell(myHero,_R) == READY and mainMenu.Combo.useR:Value() and ValidTarget(target,1000) and GetCurrentHP(target) < CalcDamage(myHero,target,(150*GetCastLevel(myHero,_R)+100+(1.5*GetBonusDmg(myHero))),0) then
			-- PrintChat("R1")
			local RPred1 = GetPredictionForPlayer(myHeroPos,target,GetMoveSpeed(target),2100,250,1800,100,false,false)
			if RPred1.HitChance == 1 then
				CastSkillShot(_R,RPred1)
			end
		end
		--R 2
		if ValidTarget(target,2000) and CanUseSpell(myHero,_R) == READY and mainMenu.Combo.useR:Value() and not IsInDistance(target, 1000) and IsInDistance(target,1800) and GetCurrentHP(target) < CalcDamage(myHero,target,(120*GetCastLevel(myHero,_R)+80+(1.2*GetBonusDmg(myHero))),0) then
			local RPred2 = GetPredictionForPlayer(myHeroPos,target,GetMoveSpeed(target),2000,250,1800,100,false,false)
			if RPred2.HitChance == 1 then
				CastSkillShot(_R,RPred2)
			end
		end

	end
end
-------------------------------------------------------------------------
-- Harass Q
local function harassFunction() -- NOTE: i made it a function so you can use the function in the ontick and for clean code, MORE INFORMATION ABOUT ONTICK DOWN!!! ;)
	if mainMenu.Harass.Harass1:Value() then
		-- MoveToXYZ(mouse)
		
		-- NOTE: SAME as combo need to define the variables you are using
		local myHeroPos = GetOrigin(myHero)
		local target = GetCurrentTarget()
		
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
				if MapPosition:inWall(checkPos6) then --idem
					if GetDistance(myHeroPos, checkPos6) > GetDistance(myHeroPos, targetPos) then--idem
						CastSkillShot(_Q,QPred.PredPos)--idem
					end
				elseif MapPosition:inWall(checkPos5) then 
					if GetDistance(myHeroPos, checkPos5) > GetDistance(myHeroPos, targetPos) then--idem
						CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)--idem
					end
				elseif MapPosition:inWall(checkPos4) then --idem
					if GetDistance(myHeroPos, checkPos4) > GetDistance(myHeroPos, targetPos) then--idem
						CastSkillShot(_Q,QPred.PredPos)--idem
					end
				elseif MapPosition:inWall(checkPos3) then --idem
					if GetDistance(myHeroPos, checkPos3) > GetDistance(myHeroPos, targetPos) then--idem
						CastSkillShot(_Q,QPred.PredPos)--idem
					end
				elseif MapPosition:inWall(checkPos2) then--idem
					if GetDistance(myHeroPos, checkPos2) > GetDistance(myHeroPos, targetPos) then--idem
						CastSkillShot(_Q,QPred.PredPos)--idem
					end
				elseif MapPosition:inWall(checkPos1) then --idem
					if GetDistance(myHeroPos, checkPos1) > GetDistance(myHeroPos, targetPos) then--idem
						CastSkillShot(_Q,QPred.PredPos)--idem
					end
				else
					CastSkillShot(_Q,QPred.PredPos)--idem
				end
				
			end
		end
	end
end


--Make auto ignite function hereif you don't know how ask ;)




-- NOTE: All code you write only get executed once!!! exept the ontick so you make everything you want to repeat as functions and put the function in the ontick like this
---- E.G
-- local function thisIsAFunction()
--  	print('A message in the chat')
-- end
-- OnTick(function(myHero)
-- 		thisIsAFunction()
-- end)
OnTick(function(myHero)
	harassFunction()
	comboFunction()
end)




-- end
