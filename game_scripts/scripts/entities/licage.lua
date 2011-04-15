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

notes = { 1, 3, 4, 5 }
numNotes = 4
curNote = 1

g1 = 0
g2 = 0
g3 = 0

singing = false

seen = false

function init(me)
	setupEntity(me)
	entity_initSkeletal(me, "LiCage")
	
	entity_setEntityLayer(me, 1)
	
	g1 = entity_getBoneByName(me, "Glass1")
	g2 = entity_getBoneByName(me, "Glass2")
	g3 = entity_getBoneByName(me, "Glass3")
	
	entity_scale(me, 2, 2)
	
	entity_setState(me, STATE_IDLE)
	
	if isFlag(FLAG_FINAL, FINAL_FREEDLI) then
		bone_setVisible(g1, false)
		seen = true
	end
	entity_setCullRadius(me, 1024)
	
	loadSound("LiCage-Crack1")
	loadSound("LiCage-Crack2")
	loadSound("LiCage-Shatter")
	
	entity_setCollideRadius(me, 320)
	
	esetv(me, EV_BEASTBURST, 0)
	
	loadSound("mother")
	loadSound("anima")
	loadSound("dualformstart")
	loadSound("mia-appear")
end

function postInit(me)
	n = getNaija()
	entity_setTarget(me, n)
end

function update(me, dt)
	c = 0
	if isFlag(FLAG_SPIRIT_DRASK, 1) then
		c = c + 1
	elseif isFlag(FLAG_SPIRIT_KROTITE, 1) then
		c = c + 1
	elseif isFlag(FLAG_SPIRIT_DRUNIAD, 1) then
		c = c + 1
	elseif isFlag(FLAG_SPIRIT_ERULIAN, 1) then
		c = c + 1
	end
	if singing then
		x = math.random(10)-5
		y = math.random(10)-5
		x = x * 0.5
		y = y * 0.5
		x = x * c
		y = y * c
		--[[
		bone_setOffset(g1, x, y)
		bone_setOffset(g2, x, y)
		bone_setOffset(g3, x, y)
		]]--
		entity_offset(me, x, y)
	else
		entity_offset(me, 0, 0)
		--[[
		bone_setOffset(g1, 0, 0)
		bone_setOffset(g2, 0, 0)
		bone_setOffset(g3, 0, 0)
		]]--
	end
	
	if not entity_isState(me, STATE_OPEN) then
		entity_touchAvatarDamage(me, entity_getCollideRadius(me), 0, 400)
		entity_handleShotCollisions(me)
	end
	
	if not isFlag(FLAG_FINAL, FINAL_FREEDLI) then
		if not seen and entity_isEntityInRange(me, n, 600) then
			entity_flipToEntity(n, me)
			entity_idle(n)
			emote(EMOTE_NAIJALI)
			seen = true
			cam_toEntity(me)
			watch(1)
			cam_toEntity(n)
		end
	end
end

function enterState(me)
	if entity_isState(me, STATE_IDLE) then
		entity_animate(me, "idle", -1)
	elseif entity_isState(me, STATE_OPEN) then
		entity_idle(n)
		li = getLi()
		learnSong(SONG_DUALFORM)
		ent = entity_getNearestEntity(me, "CC_Final")
		if ent ~= 0 then
			entity_alpha(ent, 0, 2)
		end
		naijapos = getNode("naijapos")
		entity_setPosition(n, node_x(naijapos), node_y(naijapos))
		entity_flipToEntity(n, li)
		cam_toEntity(me)
		singing = true
		overrideZoom(0.7, 0.001)
		
		fadeOutMusic(8)
		
		watch(2)
		fade(1, 0.2, 1, 1, 1) watch(0.2)
		bone_setVisible(g1, false)
		bone_setVisible(g2, true)
		playSfx("LiCage-Crack1")
		
		
		
		fade(0, 0.5, 1, 1, 1) watch(0.5)
		watch(1)
		fade(1, 0.2, 1, 1, 1) watch(0.2)
		bone_setVisible(g2, false)
		bone_setVisible(g3, true)
		playSfx("LiCage-Crack2")
		fade(0, 0.5, 1, 1, 1) watch(0.5)
		watch(0.5)
		fade(1, 0.2, 1, 1, 1) watch(0.2)
		bone_setVisible(g3, false)
		playSfx("LiCage-Shatter")
		fade(0, 0.5, 1, 1, 1) watch(0.5)
		watch(1)
		singing = false
		
		entity_flipToEntity(n, li)
		
		debugLog("FREE LI!")

		li = entity_getNearestEntity(me, "Li")
		cam_toEntity(li)
		watch(2)
		setFlag(FLAG_LI, 100)
		entity_setState(li, STATE_IDLE)
		setLi(li)
		entity_flipToEntity(n, li)
		watch(3)
		entity_flipToEntity(n, li)
		entity_flipToEntity(li, n)
		emote(EMOTE_NAIJASIGH)
		entity_msg(li, "forcehug")
		cam_toEntity(n)
		
		overrideZoom(1, 14)
		watch(3)
		
		playMusic("moment")
		
		watch(5)
		
		playSfx("anima")
		
		watch(5)
		
		overrideZoom(1.2, 7)
		-- play some sound
		
		playSfx("mia-appear")
		
		x = (entity_x(n) + entity_x(li))/2
		spawnParticleEffect("dualformstart", x, entity_y(n))
		
		fadeOutMusic(4)
		
		watch(3)
		
		playSfx("dualformstart")
		
		fade2(1, 1.5, 1, 1, 1)
		watch(1.5)
		playSfx("mother")
		entity_msg(li, "endhug")
		entity_setState(li, STATE_IDLE)
		watch(0.5)
		
		setFlag(FLAG_FINAL, FINAL_FREEDLI)
		
		
		changeForm(FORM_DUAL)
		fade2(0, 0.5, 1, 1, 1)
		
		updateMusic()
		
		voice("Naija_Song_DualForm")

		setControlHint(getStringBank(43), 0, 0, 0, 10, "", SONG_DUALFORM)
		
		overrideZoom(0)
	
	
	else
		debugLog("NEED MORE SPIRITS!")
	end
end

function exitState(me)
end

function damage(me, attacker, bone, damageType, dmg)
	playNoEffect()
	return false
end

function animationKey(me, key)
end

function hitSurface(me)
end

function songNote(me, note)
	singing = true
end

function songNoteDone(me, note)
	singing = false
	if isFlag(FLAG_FINAL, FINAL_FREEDLI) then return end
	if isFlag(FLAG_SPIRIT_ERULIAN, 1) and isFlag(FLAG_SPIRIT_KROTITE, 1) and isFlag(FLAG_SPIRIT_DRUNIAD, 1) and isFlag(FLAG_SPIRIT_DRASK, 1) then
		if entity_isState(me, STATE_IDLE) then
			--debugLog(string.format("curNote: %d", curNote))
			if notes[curNote] == note then
				curNote = curNote + 1
			else
				curNote = 1
			end
			if curNote > numNotes then
				entity_setState(me, STATE_OPEN)
			end
		end
	end
end

function song(me, song)
end

function activate(me)
end
