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

-- song cave collectible

dofile("scripts/include/collectibletemplate.lua")

function init(me)
	v.commonInit(me, "Collectibles/treasure-chest", FLAG_COLLECTIBLE_CHEST)
	entity_initEmitter(me, 0, "Bubbles01")
	entity_startEmitter(me, 0)
end

function update(me, dt)
	v.commonUpdate(me, dt)
end

function enterState(me, state)
	v.commonEnterState(me, state)
	if entity_isState(me, STATE_COLLECTEDINHOUSE) then
		--[[
		createEntity("JellySmall", "", node_x(me)-64, node_y(me))
		createEntity("JellySmall", "", node_x(me)+64, node_y(me))
		createEntity("JellySmall", "", node_x(me), node_y(me)+32)
		]]--
	end	
end

function exitState(me, state)
	v.commonExitState(me, state)
end
