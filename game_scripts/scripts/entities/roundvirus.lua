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

v = getVars()

dofile("scripts/entities/entityinclude.lua")

v.n = 0

v.fireDelayTime = 3
v.fireDelay = 0


function init(me)
	setupEntity(me)
	entity_setEntityType(me, ET_ENEMY)
	entity_initSkeletal(me, "roundvirus")
	
	entity_setHealth(me, 20)
	
	entity_setCollideRadius(me, 64)
	
	entity_setState(me, STATE_IDLE)
	
	entity_addVel(me, randVector(500))
	
	entity_setMaxSpeed(me, 100)
	
	entity_setUpdateCull(me, 2000)
	
	entity_setCullRadius(me, 512)
	
	entity_setDeathScene(me, true)
	entity_setDamageTarget(me, DT_ENEMY_POISON, false)
	
	entity_setDamageTarget(me, DT_AVATAR_PET, false)
	
	--entity_setDropChance(me, 100)
end

function postInit(me)
	v.n = getNaija()
	entity_setTarget(me, v.n)
end

function update(me, dt)
	entity_updateMovement(me, dt)
	
	entity_handleShotCollisions(me)
	
	entity_touchAvatarDamage(me, entity_getCollideRadius(me), 0.5, 400)
	
	entity_doCollisionAvoidance(me, dt, 8, 0.1)
	entity_doEntityAvoidance(me, dt, 64, 1)
	
	v.fireDelay = v.fireDelay - dt
	if v.fireDelay < 0 then
		entity_addVel(me, randVector(500))
		
		local s
		s = createShot("viruspoison", me, 0, entity_x(me)-20, entity_y(me)-20)
		shot_setAimVector(s, -1, -1)
		s = createShot("viruspoison", me, 0, entity_x(me)+20, entity_y(me)-20)
		shot_setAimVector(s, 1, -1)
		s = createShot("viruspoison", me, 0, entity_x(me)+20, entity_y(me)+20)
		shot_setAimVector(s, 1, 1)
		s = createShot("viruspoison", me, 0, entity_x(me)-20, entity_y(me)+20)
		shot_setAimVector(s, -1, 1)
		
		v.fireDelay = v.fireDelayTime
		
		entity_rotate(me, entity_getRotation(me)+90, 1, 0, 0, 1)
	end
end

function enterState(me)
	if entity_isState(me, STATE_IDLE) then
		entity_animate(me, "idle", -1)
	elseif entity_isState(me, STATE_DEATHSCENE) then
		entity_scale(me, 1.1, 1.1)
		entity_scale(me, 0, 0, 0.5)
		entity_setStateTime(me, 0.5)
	end
end

function exitState(me)
end

function damage(me, attacker, bone, damageType, dmg)
	if damageType == DT_ENEMY_POISON then
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

function dieNormal(me)
	spawnParticleEffect("TinyGreenExplode", entity_x(me),entity_y(me))
end


