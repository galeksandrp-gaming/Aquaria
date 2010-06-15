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
-- Ice Shrimp
-- ================================================================================================

dofile("scripts/entities/entityinclude.lua")
-- specific
STATE_JUMP				= 1000
STATE_TRANSITION		= 1001
STATE_RETURNTOWALL		= 1002
STATE_SURFACE			= 1003

-- ================================================================================================
-- L O C A L  V A R I A B L E S 
-- ================================================================================================

moveTimer = 0
moveDir = 0
avoidCollisionsTimer = 0

-- ================================================================================================
-- FUNCTIONS
-- ================================================================================================

function init(me)
	setupBasicEntity(
	me,
	"Shrimp",					-- texture
	3,								-- health
	2,								-- manaballamount
	2,								-- exp
	10,								-- money
	16,								-- collideRadius (for hitting entities + spells)
	STATE_IDLE,						-- initState
	64,							-- sprite width	
	64,							-- sprite height
	1,								-- particle "explosion" type, 0 = none
	0,								-- 0/1 hit other entities off/on (uses collideRadius)
	4000,							-- updateCull -1: disabled, default: 4000
	1
	)
	
	entity_initSkeletal(me, "iceshrimp")
	entity_animate(me, "idle", -1)

	entity_setEatType(me, EAT_FILE, "SmallFood")

	entity_setMaxSpeed(me, 500)
	--entity_clampToSurface(me)
	entity_setState(me, STATE_IDLE)
	entity_setDropChance(me, 10)
	
	entity_setDeathParticleEffect(me, "TinyRedExplode")
	
	entity_offset(me, 0, -40, 1, -1, 1)
end

function update(me, dt)
	entity_handleShotCollisions(me)	
	
	if entity_isState(me, STATE_IDLE) then
		avoidCollisionsTimer = avoidCollisionsTimer + dt
		if avoidCollisionsTimer > 5 then
			avoidCollisionsTimer = 0
		end
		moveTimer = moveTimer + dt
		if moveTimer < 1.5 then
			-- move
			amount = 2000*dt
			if moveDir == 0 then
				entity_addVel(me, -amount, 0)
				if entity_isFlippedHorizontal(me) then
					entity_flipHorizontal(me)
				end
			elseif moveDir == 1 then
				entity_addVel(me, 0, amount)
			elseif moveDir == 2 then
				entity_addVel(me, amount, 0)
				if not entity_isFlippedHorizontal(me) then
					entity_flipHorizontal(me)
				end			
			elseif moveDir == 3 then
				entity_addVel(me, 0, amount)
			end		
		elseif moveTimer > 3 then
			-- stop 
			--entity_clearVel(me)
			moveTimer = 0
			moveDir = moveDir +1 
			if moveDir >= 4 then
				moveDir = 0
			end
		elseif moveTimer > 2.5 then
			factor = 5*dt
			entity_addVel(me, -entity_velx(me)*factor, -entity_vely(me)*factor)
		end
		if avoidCollisionsTimer < 4 then
			entity_doCollisionAvoidance(me, dt, 4, 1.0)
		end
		entity_updateMovement(me, dt)		
	elseif entity_isState(me, STATE_SURFACE) then
		entity_moveAlongSurface(me, dt, 20, 2)
		entity_rotateToSurfaceNormal(me, 0.1)
		if not entity_isFlippedHorizontal(me) then
			entity_flipHorizontal(me)
		end		
		--entity_rotateToVel(me, 0.1)
	end
	
end

function hitSurface(me)
	entity_clampToSurface(me)
	entity_setState(me, STATE_SURFACE, 3+math.random(2))
end

function enterState(me)
	if entity_isState(me, STATE_IDLE) then
		avoidCollisionsTimer = 0
	elseif entity_isState(me, STATE_SURFACE) then
		entity_clearVel(me)
		if chance(50) then
			entity_switchSurfaceDirection(me, 1)
			if entity_isFlippedHorizontal(me) then
				entity_flipHorizontal(me)
			end
		else
			entity_switchSurfaceDirection(me, 0)
			if not entity_isFlippedHorizontal(me) then
				entity_flipHorizontal(me)
			end
		end		
	end
end

function damage(me, attacker, bone, damageType, dmg)
	if damageType == DT_AVATAR_BITE then
		entity_changeHealth(me, -dmg*10)
	end
	return true
end

function exitState(me)
	if entity_isState(me, STATE_SURFACE) then
		entity_rotate(me, 0, 1)
		entity_setState(me, STATE_IDLE)		
	end
end
