-- Copyright (C) 2007, 2010 - Bit-Blot
--
-- This file is part of Aquaria.
--
-- Aquaria is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
--
-- See the GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

-- ================================================================================================
-- Merman / Thin
-- ================================================================================================

dofile("scripts/entities/entityinclude.lua")

swimTime = 0
swimTimer = swimTime - swimTime/4
dirTimer = 0
dir = 0
spiritLoop = 0
spiritDir = 1

leftHand = 0
rightHand = 0

STATE_HANG 	= 1000
STATE_SWIM 	= 1001
STATE_BURST = 1002
STATE_SPIRIT = 1003
STATE_SPIRITCHARGE = 1004
STATE_FIRING = 1005
STATE_DYING	= 1006
STATE_WAIT = 1007

fireDelay = 0
burstDelay = 0
spiritDelay = 0
shotDelay = 0

function init(me)
	-- 20 hp
	setupBasicEntity(me, 
	"",								-- texture
	50,								-- health
	1,								-- manaballamount
	1,								-- exp
	1,								-- money
	40,								-- collideRadius (only used if hit entities is on)
	STATE_IDLE,						-- initState
	64,								-- sprite width	
	64,								-- sprite height
	1,								-- particle "explosion" type, maps to particleEffects.txt -1 = none
	1,								-- 0/1 hit other entities off/on (uses collideRadius)
	4000							-- updateCull -1: disabled, default: 4000
	)
	
	entity_initSkeletal(me, "Priest")
	--entity_generateCollisionMask(me)
	entity_setCollideRadius(me, 32)
	entity_setDeathParticleEffect(me, "PriestExplode")
	
	entity_scale(me, 0.6, 0.6)

	leftHand = entity_getBoneByName(me, "LeftHand")
	rightHand = entity_getBoneByName(me, "RightHand")
	
	entity_setState(me, STATE_WAIT)
	entity_setBeautyFlip(me, false)
	
	entity_setCullRadius(me, 1024)

	-- damage targets set in setState
end

function update(me, dt)
	if entity_isState(me, STATE_SPIRITCHARGE) then		
		if not entity_isAnimating(me) then
			entity_setState(me, STATE_SPIRIT, 5)
		end		
		entity_doFriction(me, dt, 200)
	end
	if entity_hasTarget(me) then
		amt = 800
		
		if burstDelay > 0 then
			burstDelay = burstDelay - dt
		end
		
		if entity_isState(me, STATE_SPIRIT) then
			--entity_doSpellAvoidance(me, dt, 128, 0.5)
			if spiritLoop > 0 then
				spiritLoop = spiritLoop - dt
				entity_moveTowardsTarget(me, dt, 1000)
				entity_moveAroundTarget(me, dt, 1000, spiritDir)
				if spiritLoop < 0 then
					spiritLoop = 0
					entity_setMaxSpeedLerp(me, 2, 0.2)
					--entity_moveTowardsTarget(me, 1, 800)
				end
				entity_doCollisionAvoidance(me, dt, 12, 0.5)
				if spiritLoop == 0 then
					entity_sound(me, "Merman-Cry", 1800+math.random(100))
					entity_setMaxSpeedLerp(me, 1.5)
					entity_moveTowardsTarget(me, 1, 5000)
				end
			else				
				entity_moveTowardsTarget(me, dt, 1000)
			end
			
			entity_rotateToVel(me, 0.05)
			entity_flipToVel(me)
			entity_touchAvatarDamage(me, 32, 1, 1200)
		else
			if entity_isState(me, STATE_IDLE) then
				entity_flipToEntity(me, getNaija())
			end
			entity_touchAvatarDamage(me, 16, 0, 1200)
			
			entity_updateCurrents(me, dt)
		end
		
		if entity_isState(me, STATE_FIRING) then
			shotDelay = shotDelay - dt
			if shotDelay < 0 then
				vx, vy = bone_getNormal(leftHand)
				px, py = bone_getPosition(rightHand)
				--entity_fireAtTarget(me, "", 1, 800, 1000, 3, 32, px-entity_x(me), py-entity_y(me), vx, vy)
				s = createShot("Priest", me, entity_getTarget(me), px, py)
				shot_setAimVector(s, vx, vy)
				shotDelay = 0.2
			end
			entity_doFriction(me, dt, 400)
		end

		if not entity_isState(me, STATE_WAIT) then
			entity_handleShotCollisions(me)
		end
		
		if entity_isState(me, STATE_IDLE) then
			timer = timer + dt
			if timer > 5 then
				-- attack
			end
			if entity_hasTarget(me) then
				if entity_isTargetInRange(me, 200) then
					entity_moveTowardsTarget(me, dt, -400)
					entity_doSpellAvoidance(me, dt, 512, 0.5)
				else
					entity_moveTowardsTarget(me, dt, 800)					
				end
				entity_doCollisionAvoidance(me, dt, 12, 0.5)
			end
			entity_doEntityAvoidance(me, dt, 256, 0.1)
		end
		
		if entity_isState(me, STATE_IDLE) then
			fireDelay = fireDelay - dt
			if fireDelay < 0 then
				entity_setState(me, STATE_FIRING, 2)
				fireDelay = 4
			end
			
			spiritDelay = spiritDelay - dt
			if spiritDelay < 0 then
				entity_setState(me, STATE_SPIRITCHARGE)
				spiritDelay = 2 + math.random(3)
			end
		end
		
		if not entity_isState(me, STATE_SPIRITCHARGE) then			
			entity_doFriction(me, dt, 100)
		end
		entity_updateMovement(me, dt)
	else
		entity_findTarget(me, 900)
	end
end

function damage(me, attacker, bone, damageType, dmg)
	if entity_IsState(me, STATE_WAIT) then
		return false
	end
	if entity_isState(me, STATE_SPIRIT) or entity_isState(me, STATE_DYING) then
		return false
	end
	
	if entity_getHealth(me) <= dmg then
		entity_setState(me, STATE_DYING, 2.5)
		return false
	end
	return true
end

function enterState(me)
	timer = 0
	if entity_getState(me)==STATE_IDLE then
		entity_setMaxSpeedLerp(me, 1, 0.5)
		entity_setAllDamageTargets(me, true)
		entity_setDamageTarget(me, DT_AVATAR_ENERGYBLAST, true)
		entity_setDamageTarget(me, DT_ENEMY, false)
		entity_setDamageTarget(me, DT_AVATAR_SHOCK, true)	
		entity_setProperty(me, EP_MOVABLE, false)
		entity_setMaxSpeed(me, 600)
		entity_animate(me, "idle", LOOP_INF)
		entity_rotate(me, 0, 0.5)
	elseif entity_isState(me, STATE_WAIT) then
		entity_setAllDamageTargets(me, false)
		entity_alpha(me,0.05)
		entity_animate(me, "idle", -1)
	elseif entity_getState(me)==STATE_SWIM then
	elseif entity_isState(me, STATE_DYING) then
		entity_animate(me, "dying", LOOP_INF)
		entity_alpha(me, 0.5, entity_getStateTime(me))
	elseif entity_isState(me, STATE_SPIRIT) then
		entity_setDamageTarget(me, DT_AVATAR_ENERGYBLAST, false)
		entity_setDamageTarget(me, DT_AVATAR_SHOCK, false)
		if math.random(100) > 50 then
			spiritDir = 0
		else
			spiritDir = 1
		end
		entity_animate(me, "spirit", LOOP_INF)
		entity_setMaxSpeed(me, 800)
		entity_alpha(me, 0.5, 0.5)
		spiritLoop = 3.5
	elseif entity_isState(me, STATE_SPIRITCHARGE) then
		entity_flipToEntity(me, getNaija())
		entity_setColor(me, 0.6, 0.6, 1, 2)
		entity_animate(me, "charge")
	elseif entity_isState(me, STATE_FIRING) then
		entity_flipToEntity(me, getNaija())
		entity_animate(me, "firing")
	elseif entity_getState(me)==STATE_BURST then
		burstDelay = 6
		entity_animate(me, "burst")
		entity_doSpellAvoidance(me, 1, 256, 1.0)
		entity_doEntityAvoidance(me, 1, 256, 1.0)
		entity_doCollisionAvoidance(me, 1, 256, 1.0)
	elseif entity_isState(me, STATE_APPEAR) then
		entity_setStateTime(me, 3)
		entity_alpha(me, 1, 1)
	end
end

function exitState(me)
	if entity_isState(me, STATE_BURST) or entity_isState(me, STATE_FIRING) then
		entity_setState(me, STATE_IDLE)		
	elseif entity_isState(me, STATE_DYING) then
		--entity_setState(me, STATE_IDLE)
		entity_setHealth(me, 0)
		entity_setState(me, STATE_DEAD)
		--entity_damage(me, me, 5, DT_ENEMY_ENERGYBLAST)
	elseif entity_isState(me, STATE_SPIRIT) then
		entity_setMaxSpeedLerp(me, 1, 0.2)
		entity_setColor(me, 1,1,1, 1)
		entity_alpha(me, 1, 1)
		entity_setState(me, STATE_IDLE)
	end
end

function hitSurface(me)
end