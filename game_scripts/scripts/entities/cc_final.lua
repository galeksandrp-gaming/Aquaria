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
singDelay = 0

function init(me)
	setupEntity(me)
	entity_setEntityType(me, ET_NEUTRAL)
	entity_setAllDamageTargets(me, false)
	
	entity_initSkeletal(me, "CC")
	
	
	entity_scale(me, 0.6, 0.6)
	
	entity_setState(me, STATE_IDLE)
	entity_setBeautyFlip(me, false)
	entity_fh(me)
	entity_setCullRadius(me, 256)
	
	loadSound("DualFormSong")
end

function postInit(me)
	n = getNaija()
end

function update(me, dt)
	if not hasSong(SONG_DUALFORM) and entity_isEntityInRange(me, n, 600) then	
		singDelay = singDelay - dt
		if singDelay < 0 then
			singDelay = 10
			debugLog("singing")
			playSfx("DualFormSong")
		end
	end
end

function enterState(me)
	if entity_isState(me, STATE_IDLE) then
		entity_animate(me, "touchCage", -1)
	end
end

function exitState(me)
end

function damage(me, attacker, bone, damageType, dmg)
	return false
end

function animationKey(me, key)
end

function hitSurface(me)
end

function songNote(me, note)
end

function songNoteDone(me, note)
end

function freeLi(me)
--[[
	entity_flipToEntity(n, li)
	if isFlag(FLAG_SPIRIT_ERULIAN, 1) and isFlag(FLAG_SPIRIT_KROTITE, 1) and isFlag(FLAG_SPIRIT_DRUNIAD, 1) and isFlag(FLAG_SPIRIT_DRASK, 1) then
		debugLog("FREE LI!")
		if not hasLi() then
			li = entity_getNearestEntity(me, "Li")
			if li ~= 0 and entity_isEntityInRange(n, li, 512) then
				cam_toEntity(li)
				watch(2)
				setFlag(FLAG_LI, 100)
				entity_setState(li, STATE_IDLE)
				setLi(li)
				watch(2)
				cam_toEntity(n)
				setFlag(FLAG_FINAL, FINAL_FREEDLI)
				learnSong(SONG_DUALFORM)
			end
		end
	else
		debugLog("NEED MORE SPIRITS!")
	end
	]]--
end

function song(me, song)
	if song == SONG_ANIMA then
	end
end
--[[
curNote = 0
function songNoteDone(me, note)
	if curNote == 0 and note == 1 then
		curNote = 1
	elseif curNote == 1 and note == 3 then
		curNote = 2
	elseif curNote == 2 and note == 4 then
		curNote = 3
	elseif curNote == 3 and note == 5 then
		curNote = 4
		freeLi(me)
	else
		curNote = 0
	end
end
]]--

function activate(me)
end
