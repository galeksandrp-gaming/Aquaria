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
-- EEL
-- ================================================================================================

dofile("scripts/entities/entityinclude.lua")

-- ================================================================================================
-- FUNCTIONS
-- ================================================================================================

dir = 0
switchDirDelay = 0
wiggleTime = 0
wiggleDir = 1
interestTimer = 0
colorRevertTimer = 0

collisionSegs = 50
avoidLerp = 0
avoidDir = 1
interest = false

paraHits = 3

openTimer = 0
parasite = true

-- initializes the entity
function init(me)
-- oldhealth : 40
	setupBasicEntity(
	me,
	"",								-- texture
	50,								-- health
	1,								-- manaballamount
	1,								-- exp
	1,								-- money
	32,								-- collideRadius (only used if hit entities is on)
	STATE_IDLE,						-- initState
	90,								-- sprite width
	90,								-- sprite height
	1,								-- particle "explosion" type, maps to particleEffects.txt -1 = none
	0,								-- 0/1 hit other entities off/on (uses collideRadius)
	-1,								-- updateCull -1: disabled, default: 4000
	1
	)
	
	entity_setDropChance(me, 50)
	
	lungeDelay = 1.0				-- prevent the nautilus from attacking right away

	--entity_initHair(me, 80, 4, 32, "eel-0001")
	entity_initSkeletal(me, "BigMouth")
	
	switchDirDelay = math.random(800)/100.0
	naija = getNaija()
	
	
	entity_setDeathParticleEffect(me, "TinyBlueExplode")
	
	entity_generateCollisionMask(me)
	entity_animate(me, "idle", -1)
	entity_setCullRadius(me, 256)
end

function activate(me)
	if parasite then
		entity_say(me, "Get it out!")
	else
		entity_say(me, "Thank you...")
	end
end

function lunge(me)
	lungeDelay = 0
	
	entity_setMaxSpeedLerp(me, 1.5)
	entity_setMaxSpeedLerp(me, 1, 1)
	entity_addVel(me, math.random(1000)-500, math.random(1000)-500)
end
-- the entity's main update function
function update(me, dt)
	if isForm(FORM_BEAST) then
		entity_setActivationType(me, AT_CLICK)
	else
		entity_setActivationType(me, AT_NONE)
	end
	
	entity_handleShotCollisionsSkeletal(me)	
	if entity_getState(me)==STATE_IDLE then		
		lungeDelay = lungeDelay + dt
		if lungeDelay > 3 then
			lunge(me)			
		end
		if not entity_hasTarget(me) then
			entity_findTarget(me, 1000)
		else
			openTimer = openTimer + dt
			
			entity_doEntityAvoidance(me, dt, 32, 0.1)
			entity_doCollisionAvoidance(me, dt, 8, 1.0)
			entity_flipToVel(me)
			
			entity_findTarget(me, 1200)
			
			if openTimer > 5 then
				if parasite then
					entity_setState(me, STATE_OPEN)
				end
				openTimer = 0 + math.random(3)
			end
		end
		entity_touchAvatarDamage(me, 64, 0, 800)
	elseif entity_isState(me, STATE_OPEN) then
		
		entity_doEntityAvoidance(me, dt, 32, 0.1)
		entity_doCollisionAvoidance(me, dt, 8, 1.0)
		if not entity_isAnimating(me) then
			entity_touchAvatarDamage(me, 64, 0.5, 800)
			entity_pullEntities(me, entity_x(me), entity_y(me), 1000, 1700, dt)

			e = getFirstEntity()
			while e ~= 0 do
				if entity_getEntityType(e)==ET_ENEMY and e ~= me then
					if entity_isEntityInRange(me, e, 64 + entity_getCollideRadius(e)) then
						entity_damage(e, me, dt*20)
					end
				end
				e = getNextEntity()
			end
		else
			entity_touchAvatarDamage(me, 64, 0, 800)
		end
	end
	entity_updateMovement(me, dt)
end

function enterState(me)
	if entity_isState(me, STATE_IDLE) then
		entity_animate(me, "idle", -1)
		entity_setMaxSpeed(me, 300)
		lunge(me)
	elseif entity_isState(me, STATE_OPEN) then
		entity_animate(me, "open")
		entity_setMaxSpeedLerp(me, 0.2, 0.1)
		entity_setStateTime(me, 5)
	elseif entity_isState(me, STATE_DEAD) then
		if parasite then
			e = createEntity("BigMouthParasite", "", entity_getPosition(me))
			entity_setHealth(e, paraHits*2)
		end				
	end
end

function exitState(me)
	if entity_isState(me, STATE_OPEN) then
		entity_setState(me, STATE_IDLE)
	end
end

function hitSurface(me)
end

function damage(me, attacker, bone, damageType, dmg)
	if parasite and bone_isName(bone,"Parasite") then
		bone_damageFlash(bone)
		paraHits = paraHits - dmg
		if paraHits <= 0 then
			bone_alpha(bone, 0)
			parasite = false
			-- die and kill parasite
			--entity_changeHealth(me, 0)
			--createEntity("BigMouthParasite", "", bone_getWorldPosition(bone))
			--return true
		end
		return false
	end
	return true
end

function songNote(me, note)
end

function dieNormal(me)
	if chance(90) then
		spawnIngredient("ButterySeaLoaf", entity_x(me), entity_y(me))
	end
end

