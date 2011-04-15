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

-- song cave collectible

dofile("scripts/include/collectibletemplate.lua")

function init(me)
	commonInit(me, "Collectibles/seed-bag", FLAG_COLLECTIBLE_SEEDBAG)
end

function update(me, dt)
	commonUpdate(me, dt)
end

function enterState(me, state)
	commonEnterState(me, state)
	if entity_isState(me, STATE_COLLECTEDINHOUSE) then
		ent = createEntity("PullPlantNormal", "", entity_x(me)-100, entity_y(me)+220)
		entity_rotate(ent, entity_getRotation(ent)-35)
		ent = createEntity("PullPlantNormal", "", entity_x(me)-130, entity_y(me)+380)
		entity_rotate(ent, entity_getRotation(ent)-20)
		ent = createEntity("PullPlantNormal", "", entity_x(me)-350, entity_y(me)+350)
		entity_rotate(ent, entity_getRotation(ent)+35)
		ent = createEntity("PullPlantNormal", "", entity_x(me)-600, entity_y(me)+330)
		entity_rotate(ent, entity_getRotation(ent)-15)
		createEntity("PullPlantNormal", "", entity_x(me)-750, entity_y(me)+290)
		ent = createEntity("PullPlantNormal", "", entity_x(me)-940, entity_y(me)+350)
		entity_rotate(ent, entity_getRotation(ent)-18)
	end	
end

function exitState(me, state)
	commonExitState(me, state)
end
