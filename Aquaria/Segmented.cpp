/*
Copyright (C) 2007, 2010 - Bit-Blot

This file is part of Aquaria.

Aquaria is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
*/
#include "Segmented.h"

#include "../BBGE/MathFunctions.h"

Segmented::Segmented(float minDist, float maxDist) : minDist(minDist), maxDist(maxDist)
{
}

void Segmented::setMaxDist(float m)
{
	maxDist = m;
}

void Segmented::initSegments(const Vector &position)
{
	for (int i = 0; i < segments.size(); i++)
		segments[i]->position = position;
	numSegments = segments.size();
}

void Segmented::destroySegments(float life)
{
	for (int i = 0; i < segments.size(); i++)
	{
		segments[i]->setLife(life);
		segments[i]->setDecayRate(1.0);

		//segments[i]->setLife(1.0);
		//segments[i]->setDecayRate(1.0/life);
		//segments[i]->setDecayRate(1.0/life);
		segments[i]->fadeAlphaWithLife = true;
	}
	segments.clear();
}

RenderObject *Segmented::getSegment(int seg)
{
	if (seg < 0 || seg >= segments.size())
		return 0;
	return segments[seg];
}

void Segmented::updateSegment(int i, const Vector &diff)
{
	if (diff.getSquaredLength2D() > sqr(maxDist))
	{
		Vector useDiff = diff;
		useDiff.setLength2D(maxDist);
		Vector reallyUseDiff = diff - useDiff;
		segments[i]->position += reallyUseDiff;

		float angle;
		MathFunctions::calculateAngleBetweenVectorsInDegrees(Vector(0,0,0), diff, angle);

		segments[i]->rotation.interpolateTo(Vector(0,0,angle), 0.2);

	}
	else if (diff.getSquaredLength2D() > sqr(minDist)) // 6.3
	{
		segments[i]->position += diff*0.05;

		float angle;
		MathFunctions::calculateAngleBetweenVectorsInDegrees(Vector(0,0,0), diff, angle);

		segments[i]->rotation.interpolateTo(Vector(0,0,angle), 0.2);
	}
}

void Segmented::updateAlpha(float a)
{
	for (int i = 0; i < segments.size(); i++)
	{
		segments[i]->alpha = a;
	}
}

void Segmented::warpSegments(const Vector &position)
{
	for (int i = 0; i < segments.size(); i++)
	{
		segments[i]->position = position;
	}
}

void Segmented::updateSegments(const Vector &position, bool reverse)
{
	/*
	if (lastPositions.empty())
	{
		for (int i = 0; i < segments.size(); i++)
		{
			segments[i]->position = position;
		}
		lastPositions.resize(numSegments);
		for (int i = 0; i < numSegments; i++)
		{
			lastPositions.push_back(position);
		}
	}
	*/
	if (!reverse)
	{
		for (int i = 0; i < segments.size(); i++)
		{
			Vector diff;
			if (i == 0)
				diff = position - segments[i]->position;
			else
				diff = segments[i-1]->position - segments[i]->position;

			updateSegment(i, diff);
		}
	}
	else
	{
		int top = segments.size()-1;
		for (int i = top; i >= 0; i--)
		{
			Vector diff;
			if (i == top)
				diff = position - segments[i]->position;
			else
				diff = segments[i+1]->position - segments[i]->position;

			updateSegment(i, diff);
		}
	}
	/*
	for (int i = lastPositions.size()-1; i > 0; i--)
	{
		lastPositions[i] = lastPositions[i-1];
	}
	lastPositions[0] = position;
	*/
}

