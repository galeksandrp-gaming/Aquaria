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

glow = 0

function init(me)
	commonInit(me, "Collectibles/jellyplant", FLAG_COLLECTIBLE_JELLYPLANT)
end

function update(me, dt)
	commonUpdate(me, dt)
	glow = createQuad("Naija/LightFormGlow", 13)
	quad_scale(glow, 10, 10)

	if glow ~= 0 then
		if entity_isInDarkness(me) then
			quad_alpha(glow, 1, 0.5)
		else
			quad_alpha(glow, 0, 0.5)
		end
	end
	
	quad_setPosition(glow, entity_getPosition(me))
	quad_delete(glow, 0.1)
	glow = 0
end

function enterState(me, state)
	commonEnterState(me, state)
	if entity_isState(me, STATE_COLLECTEDINHOUSE) then
		createEntity("Triffle", "", entity_x(me)-150, entity_y(me)-200)
		createEntity("Triffle", "", entity_x(me)+75, entity_y(me)-220)
		createEntity("DeepJelly", "", entity_x(me), entity_y(me)-400)
	end	
end

function exitState(me, state)
	commonExitState(me, state)
end
