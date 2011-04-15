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

dofile("scripts/entities/entityinclude.lua")

n = 0
dir = 0
fireDelay = 1 + math.random(3)

function init(me)
	setupEntity(me)
	entity_setEntityType(me, ET_ENEMY)
	entity_initSkeletal(me, "Orbiter")	
	entity_setAllDamageTargets(me, true)
	
	entity_setCollideRadius(me, 32)
	bone_setSegs(entity_getBoneByName(me, "Tentacles"), 16, 16, 0.6, 0.6, -0.06, 0, 6, 1)
	
	entity_setState(me, STATE_IDLE)
	entity_setHealth(me, 4)
	entity_setUpdateCull(me, 3000)
	entity_setDeathParticleEffect(me, "TinyGreenExplode")
	dir = math.random(2)-1
	if dir == 0 then
		entity_rotateOffset(me, 90)
		--entity_rotateOffset(me, 80)
		--entity_rotateOffset(me, 110, 1, -1)
	else
		entity_rotateOffset(me, -90)
		--entity_rotateOffset(me, -80)
		--entity_rotateOffset(me, -110, 1, -1)
	end
	--entity_scale(me, 0.8, 0.8)
	entity_setDropChance(me, 10, 1)
	entity_setEatType(me, EAT_FILE, "Orbiter")
	entity_setEntityLayer(me, 1)
end

function postInit(me)
	n = getNaija()
	
end

function update(me, dt)	
	if entity_hasTarget(me) then
		if entity_isTargetInRange(me, 400) then
			entity_moveTowardsTarget(me, dt, 2000)
			if entity_isTargetInRange(me, 256) then			
				entity_moveTowardsTarget(me, dt, -2000)
			end
			
			entity_setMaxSpeedLerp(me, 2, 0.5)
			entity_moveAroundTarget(me, dt, 3000, dir)
			fireDelay = fireDelay - dt*1.5
			entity_doEntityAvoidance(me, dt, 8, 0.5)
			entity_rotateToVel(me, 0.1)
		else
			fireDelay = fireDelay - dt
			entity_doEntityAvoidance(me, dt, 16, 1)
			entity_doEntityAvoidance(me, dt, 32, 0.6)
			
			entity_setMaxSpeedLerp(me, 1, 0.5)
			entity_moveTowardsTarget(me, dt, 1000)
			entity_rotate(me, 90, 0.5)
		end
		if fireDelay < 0 then
			fireDelay = 5 + math.random(2)
			s = createShot("Orbiter", me, entity_getTarget(me))
			shot_setOut(s, 32)
		end
		
		entity_doCollisionAvoidance(me, dt, 8, 0.8)
		entity_findTarget(me, 1200)
		
	else
		entity_findTarget(me, 900)
	end
	
	entity_updateMovement(me, dt)
	entity_handleShotCollisions(me)
	entity_touchAvatarDamage(me, entity_getCollideRadius(me), 0, 400)
end

function enterState(me)
	if entity_isState(me, STATE_IDLE) then
		entity_animate(me, "idle", -1)
	end
end

function exitState(me)
end

function damage(me, attacker, bone, damageType, dmg)
	if entity_isName(attacker, "Orbiter") then
		return false
	end
	return true
end

function animationKey(me, key)
end

function hitSurface(me)
end

function songNote(me, note)
end

function songNoteDone(me, note)
end

function song(me, song)
end

function activate(me)
end

