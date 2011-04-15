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

ent = 0
incut = false

function init(me)
	ent = node_getNearestEntity(me, "CreatorForm6")
	
	loadSound("creatorform6-die3")
end

function flash()
	fade(1, 0, 1, 1, 1)
	fade(0, 1, 1, 1, 1)
end

function update(me, dt)
	if incut then return end
	incut = true
	if entity_isState(ent, STATE_TRANSITION) then
		vision = getNode("VISION")
		visionNaija = getNode("VISIONNAIJA")
		
		n = getNaija()
		changeForm(FORM_NORMAL)
		entity_setInvincible(n)
		entity_setPosition(ent, entity_x(ent), entity_y(ent), 0.01)
		disableInput()
		entity_idle(n)
		
		entity_heal(n, 999)
		
		
		
		
		watch(1)
		
		entity_flipToEntity(n, ent)
		
		playMusicOnce("EndingPart1")
		
		overrideZoom(0.8)
		overrideZoom(0.7, 5)
		
		fade(1, 0.01, 1, 1, 1)
		
		fade(0, 5, 1, 1, 1)
		entity_msg(ent, "eye")
		entity_setAnimLayerTimeMult(ent, 0, 1.2)
		entity_setPosition(ent, entity_x(ent)+600, entity_y(ent), 7)
		playSfx("creatorform6-die3", 0, 0.2)
		flash() entity_animate(ent, "die1", -1)
		watch(5)
		flash()
		overrideZoom(0.5, 2)
		entity_msg(ent, "neck")
		watch(3)
		overrideZoom(0.4, 5)
		
		entity_setAnimLayerTimeMult(ent, 0, 4)
		flash() entity_animate(ent, "die2", -1)
		shakeCamera(5, 5)
		watch(5)
		overrideZoom(0.3, 9)
		entity_setAnimLayerTimeMult(ent, 0, 0.5)
		playSfx("creatorform6-die3")
		flash() entity_animate(ent, "die3", 0)
		shakeCamera(8, 4)
		watch(4)
		shakeCamera(15, 4)
		watch(4)
		--entity_setStateTime(ent, 0.01)
		fade(1, 0.5, 1,1,1)
		entity_setState(ent, STATE_WAIT)
		
		watch(0.5)
		
		
		entity_update(ent, 0)
		
		entity_setPosition(n, node_x(visionNaija), node_y(visionNaija))
		cam_toNode(vision)
		kid = node_getNearestEntity(me, "CC_EndOfGame")
		entity_color(kid, 0, 0, 0)
		entity_color(n, 0, 0, 0)
		
		overrideZoom(1)
		
		watch(2)
		overrideZoom(1)
		fade(0, 1, 1, 1, 1)
		watch(3)
		
		watch(1)
		entity_setPosition(kid, entity_x(n)+34, entity_y(n)+8, 4, 0, 0, 1)
		watch(3)
		entity_animate(kid, "hug")
		
		fade2(1, 2, 1, 1, 1)
		watch(2)
		--[[
		fade(0, 2, 1,1,1)
		watch(2)
		--entity_setStateTime(me, 28 - 22)
		watch(6)
		]]--
		entity_setStateTime(ent, 0.01)
		
		loadMap("eric")
		--jumpState("credits")
	end
	incut = false
end