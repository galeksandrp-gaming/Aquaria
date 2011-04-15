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
#ifndef __render_object__
#define __render_object__

#include "Base.h"
#include "Texture.h"
#include "Flags.h"

class Core;
class StateData;

enum RenderObjectFlags
{
	RO_CLEAR			= 0x00,
	RO_RENDERBORDERS	= 0x01,
	RO_NEXT				= 0x02,
	RO_MOTIONBLUR		= 0x04
};

enum AutoSize
{
	AUTO_VIRTUALWIDTH		= -101,
	AUTO_VIRTUALHEIGHT		= -102
};

enum ParentManaged
{
	PM_NONE					= 0,
	PM_POINTER				= 1,
	PM_STATIC				= 2
};

enum ChildOrder
{
	CHILD_BACK				= 0,
	CHILD_FRONT				= 1
};

enum RenderBeforeParent
{
	RBP_NONE				= -1,
	RBP_OFF					= 0,
	RBP_ON					= 1
};

struct MotionBlurFrame
{
	Vector position;
	float rotz;
};

typedef std::vector<RectShape> CollideRects;

class RenderObjectLayer;

class RenderObject
{
public:
	friend class Core;
	RenderObject();
	virtual ~RenderObject();
	virtual void render();

	static RenderObjectLayer *rlayer;

	enum AddRefChoice { NO_ADD_REF = 0, ADD_REF = 1};

	void setTexturePointer(Texture *t, AddRefChoice addRefChoice)
	{
		this->texture = t;
		if (addRefChoice == ADD_REF)
			texture->addRef();
		onSetTexture();
	}

	void setStateDataObject(StateData *state);
	void setTexture(const std::string &name);

	void toggleAlpha(float t = 0.2);
	void matrixChain();

	virtual void update(float dt);
	bool isDead() const {return _dead;}

	void setLife(float life)
	{
		maxLife = this->life = life;
	}
	void setDecayRate(float decayRate)
	{
		this->decayRate = decayRate;
	}
	void setBlendType (int bt)
	{
		blendType = bt;
	}

	//enum DestroyType { RANDOM=0, REMOVE_STATE };
	virtual void destroy();

	virtual void flipHorizontal();
	virtual void flipVertical();

	bool isfh() { return _fh; }
	bool isfv() { return _fv; }

	// recursive
	bool isfhr();
	bool isfvr();

	int getIdx() { return idx; }
	void setIdx(int idx) { this->idx = idx; }
	void moveToFront();
	void moveToBack();

	virtual int getCullRadius();

	int getTopLayer();

	void setColorMult(const Vector &color, const float alpha);
	void clearColorMult();

	void enableMotionBlur(int sz=10, int off=5);
	void disableMotionBlur();

	void addChild(RenderObject *r, ParentManaged pm, RenderBeforeParent rbp = RBP_NONE, ChildOrder order = CHILD_BACK);
	void removeChild(RenderObject *r);
	void removeAllChildren();
	void recursivelyRemoveEveryChild();

	Vector getRealPosition();
	Vector getRealScale();

	virtual float getSortDepth();

	StateData *getStateData();

	void setPositionSnapTo(InterpolatedVector *positionSnapTo);

	virtual bool isOnScreen();

	bool isCoordinateInRadius(const Vector &pos, float r);

	void copyProperties(RenderObject *target);

	const RenderObject &operator=(const RenderObject &r);

	void enableProjectCollision();
	void disableProjectCollision();

	void toggleCull(bool value);
	
	void safeKill();

	void enqueueChildDeletion(RenderObject *r);

	Vector getWorldPosition();
	Vector getWorldCollidePosition(const Vector &vec=Vector(0,0,0));
	Vector getInvRotPosition(const Vector &vec);
	bool isPieceFlippedHorizontal();

	RenderObject *getTopParent();

	virtual void onAnimationKeyPassed(int key){}

	Vector getAbsoluteRotation();
	float getWorldRotation();
	Vector getNormal();
	Vector getFollowCameraPosition();
	Vector getForward();
	void setOverrideCullRadius(int ovr);
	void setRenderPass(int pass) { renderPass = pass; }
	int getRenderPass() { return renderPass; }
	void setOverrideRenderPass(int pass) { overrideRenderPass = pass; }
	int getOverrideRenderPass() { return overrideRenderPass; }
	enum { RENDER_ALL=314, OVERRIDE_NONE=315 };

	void lookAt(const Vector &pos, float t, float minAngle, float maxAngle, float offset=0);
	RenderObject *getParent() const {return parent;}
	void applyBlendType();
	void fhTo(bool fh);
	void addDeathNotify(RenderObject *r);
	virtual void unloadDevice();
	virtual void reloadDevice();

	Vector getCollisionMaskNormal(int index);

	//-------------------------------- Methods above, fields below

	static bool renderCollisionShape;
	static bool integerizePositionForRender;
	static bool renderPaths;
	static int lastTextureApplied;
	static bool lastTextureRepeat;

	InterpolatedVector position, scale, color, alpha, rotation;
	InterpolatedVector offset, rotationOffset, internalOffset, beforeScaleOffset;
	InterpolatedVector velocity, gravity;

	Texture *texture;

	//int mode;

	bool fadeAlphaWithLife;

	bool blendEnabled;
	enum BlendTypes { BLEND_DEFAULT = 0, BLEND_ADD, BLEND_SUB };
	unsigned char blendType;

	float life;
	//float lifeAlphaFadeMultiplier;
	float followCamera;

	//bool useColor;
	bool renderBeforeParent;
	bool updateAfterParent;

	//bool followXOnly;
	//bool renderOrigin;

	//float updateMultiplier;
	//EventPtr deathEvent;

	bool colorIsSaved;  // Used for both color and alpha
	Vector savedColor;  // Saved values from setColorMult()
	float savedAlpha;

	bool shareAlphaWithChildren;
	bool shareColorWithChildren;

	bool renderBorders;

	bool cull;
	int updateCull;
	int layer;

	InterpolatedVector *positionSnapTo;

	//DestroyType destroyType;
	typedef std::list<RenderObject*> Children;
	Children children, childGarbage;

	//Flags flags;

#ifdef BBGE_BUILD_DIRECTX
	bool useDXTransform;
	//D3DXMATRIX matrix;
#endif

	int collideRadius;
	Vector collidePosition;
	bool useCollisionMask;
	//Vector collisionMaskHalfVector;
	std::vector<Vector> collisionMask;
	std::vector<Vector> transformedCollisionMask;

	CollideRects collisionRects;
	int collisionMaskRadius;
	int touchDamage;

	float alphaMod;

	bool ignoreUpdate;
	bool useOldDT;
	
protected:
	virtual void onFH(){}
	virtual void onFV(){}
	virtual void onDestroy(){}
	virtual void onSetTexture(){}
	virtual void onRender(){}
	virtual void onUpdate(float dt);
	virtual void deathNotify(RenderObject *r);
	virtual void onEndOfLife() {}

	void addDeathNotifyInternal(RenderObject *r);
	// spread parentManagedStatic flag to the entire child tree
	void propogateParentManagedStatic();
	void propogateAlpha();

	inline void updateLife(float dt)
	{
		if (decayRate > 0)
		{
			life -= decayRate*dt;
			if (life<=0)
			{
				safeKill();
			}
		}
		if (fadeAlphaWithLife && !alpha.isInterpolating())
		{
			//alpha = ((life*lifeAlphaFadeMultiplier)/maxLife);
			alpha = life/maxLife;
		}
	}

	// Is this object or any of its children rendered in pass "pass"?
	bool hasRenderPass(const int pass);

	inline void renderCall();
	void renderCollision();

	bool repeatTexture;
	//ParentManaged pm;
	unsigned char pm;  // unsigned char to save space
	typedef std::list<RenderObject*> RenderObjectList;
	RenderObjectList deathNotifications;
	int overrideRenderPass;
	int renderPass;
	int overrideCullRadius;
	float motionBlurTransitionTimer;
	int motionBlurFrameOffsetCounter, motionBlurFrameOffset;
	std::vector<MotionBlurFrame>motionBlurPositions;
	bool motionBlur, motionBlurTransition;

	int idx;
	bool _dead;
	bool _fv, _fh;
	//bool rotateFirst;
	RenderObject *parent;
	StateData *stateData;
	float decayRate;
	float maxLife;

	static InterpolatedVector savePosition;
};

#endif
