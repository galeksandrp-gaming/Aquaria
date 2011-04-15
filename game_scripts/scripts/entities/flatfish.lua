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
target = 0
body = 0
moving = 0

function init(me)
	setupEntity(me)
	entity_setEntityType(me, ET_ENEMY)
	entity_initSkeletal(me, "FlatFish")	
	--entity_setAllDamageTargets(me, false)
	entity_setEntityLayer(me, -1)
	
	--entity_generateCollisionMask(me)
	
	entity_setState(me, STATE_IDLE)
	
	target = entity_getBoneByName(me, "Target")
	body = entity_getBoneByName(me, "Body")
	
	bone_alpha(target)
	
	entity_setCanLeaveWater(me, true)
	
	entity_setHealth(me, 6)
	entity_setCollideRadius(me, 24)
end

function postInit(me)
	n = getNaija()
	entity_setTarget(me, n)
end

function update(me, dt)

	--entity_updateMovement(me, dt)
	entity_checkSplash(me, bone_getWorldPosition(body))
	if entity_isState(me, STATE_IDLE) then
		x, y = entity_getPosition(me)
		x2,y2 = bone_getWorldPosition(target)
		if entity_collideCircleVsLine(n, x, y, x2, y2, 100) then
			entity_setState(me, STATE_ATTACK)
		end
	end
	entity_handleShotCollisions(me)
	
	--[[
	bone = entity_collideSkeletalVsCircle(me, n)
	if bone ~= 0 then
		entity_damage(n, me, 0.5)
	end
	]]--
	entity_touchAvatarDamage(me, entity_getCollideRadius(me), 0.5, 500)	
	
	entity_clearTargetPoints(me)
	entity_addTargetPoint(me, bone_getWorldPosition(body))
end

function enterState(me)
	if entity_isState(me, STATE_IDLE) then
		entity_animate(me, "idle", -1)
	elseif entity_isState(me, STATE_ATTACK) then
		entity_setStateTime(me, entity_animate(me, "attack"))
		len = 400
		x, y = entity_getPosition(me)
		nx, ny = entity_getNormal(me)
		nx = nx * len
		ny = ny * len
		entity_setPosition(me, x+nx,y+ny,0.9, 1, -1, 1)		
	end
end

function exitState(me)
	if entity_isState(me, STATE_ATTACK) then
		entity_setState(me, STATE_IDLE)
	end
end

function damage(me, attacker, bone, damageType, dmg)
	if entity_isState(me, STATE_IDLE) then
		entity_setState(me, STATE_ATTACK)
	end
	if damageType == DT_AVATAR_BITE then
		entity_changeHealth(me, -2)
	end
	return true
end

function animationKey(me, key)
	if entity_isState(me, STATE_ATTACK) and key == 1 then

		--entity_setInternalOffset(me, 0, -400, 0.9, 1, -1, 1)
	end
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

