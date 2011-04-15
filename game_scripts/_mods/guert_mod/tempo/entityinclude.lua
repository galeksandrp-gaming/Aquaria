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

-- emotes
EMOTE_NAIJAEVILLAUGH	= 0
EMOTE_NAIJAGIGGLE		= 1
EMOTE_NAIJALAUGH		= 2
EMOTE_NAIJASADSIGH		= 3
EMOTE_NAIJASIGH			= 4
EMOTE_NAIJAWOW			= 5
EMOTE_NAIJAUGH			= 6
EMOTE_NAIJALOW			= 7
EMOTE_NAIJALI			= 8
EMOTE_NAIJAEW			= 9

OVERRIDE_NONE			= 315

--actions
ACTION_MENULEFT			= 6
ACTION_MENURIGHT		= 7
ACTION_MENUUP			= 8
ACTION_MENUDOWN			= 9

WATCH_QUIT				= 1

-- ingredient effect types
IET_NONE		= -1
IET_HP			= 0
IET_DEFENSE		= 1
IET_SPEED		= 2
IET_RANDOM		= 3
IET_MAXHP		= 4
IET_INVINCIBLE	= 5
IET_TRIP		= 6
IET_REGEN		= 7
IET_LI			= 8
IET_FISHPOISON	= 9
IET_BITE		= 10
IET_EAT			= 11
IET_LIGHT		= 12
IET_YUM			= 13
IET_PETPOWER	= 14
IET_WEB			= 15
IET_ENERGY		= 16
IET_POISON		= 17
IET_BLIND		= 18
IET_ALLSTATUS	= 19
IET_MAX			= 20

-- menu pages
MENUPAGE_NONE		= -1
MENUPAGE_SONGS		= 0
MENUPAGE_FOOD		= 1
MENUPAGE_TREASURES	= 2
MENUPAGE_PETS		= 3

-- Entity States
STATE_DEAD			= 0
STATE_IDLE			= 1
STATE_PUSH			= 2
STATE_PUSHDELAY		= 3
STATE_PLANTED 		= 4
STATE_TRANSFORM		= 5
STATE_PULLED		= 6
STATE_FOLLOWNAIJA	= 7
STATE_DEATHSCENE	= 8
STATE_ATTACK		= 9
STATE_CHARGE0		= 10
STATE_CHARGE1		= 11
STATE_CHARGE2		= 12
STATE_CHARGE3		= 13
STATE_WAIT			= 20
STATE_HUG			= 21
STATE_EATING		= 22
STATE_FOLLOW		= 23
STATE_TITLE			= 24
STATE_HATCH			= 25
STATE_CARRIED		= 26

STATE_HOSTILE		= 100

STATE_CLOSE			= 200
STATE_OPEN			= 201
STATE_CLOSED		= 202
STATE_OPENED		= 203
STATE_CHARGED 		= 300
STATE_INHOLDER 		= 301
STATE_DISABLED		= 302
STATE_FLICKER		= 303
STATE_ACTIVE		= 304
STATE_USED			= 305
STATE_BLOATED		= 306
STATE_DELAY			= 307
STATE_DONE			= 309
STATE_RAGE			= 310
STATE_CALM			= 311
STATE_DESCEND		= 312
STATE_SING 			= 313
STATE_TRANSFORM		= 314
STATE_GROW			= 315
STATE_MATING		= 316
STATE_SHRINK		= 317
STATE_MOVE			= 319
STATE_TRANSITION	= 320
STATE_TRANSITION2 	= 321
STATE_TRAPPEDINCREATOR = 322
STATE_GRAB			= 323
STATE_FIGURE		= 324
STATE_CUTSCENE		= 325
STATE_WAITFORCUTSCENE	= 326
STATE_FIRE			= 327
STATE_FIRING		= 328
STATE_PREP			= 329
STATE_INTRO			= 330
STATE_PUPPET		= 331

STATE_COLLECT				= 400
STATE_COLLECTED				= 401
STATE_COLLECTEDINHOUSE 		= 402


--STATE_ATTACK 		= 500
STATE_STEP			= 501
STATE_AWAKEN		= 502

STATE_WEAK			= 600
STATE_BREAK			= 601
STATE_BROKEN		= 602

STATE_PULSE			= 700
STATE_ON			= 701
STATE_OFF			= 702
STATE_SEED			= 703
STATE_PLANTED		= 704
STATE_SK_RED		= 705
STATE_SK_GREEN		= 706
STATE_SK_BLUE		= 707
STATE_SK_YELLOW		= 708
STATE_WAITFORKISS 	= 710
STATE_KISS			= 711
STATE_START			= 712
STATE_RACE			= 714
STATE_RESTART		= 715
STATE_APPEAR		= 716

STATE_MOVETOWEED			= 2000
STATE_PULLWEED				= 2001
STATE_DONEWEED				= 2002

ORIENT_NONE		= -1
ORIENT_LEFT		= 0
ORIENT_RIGHT	= 1
ORIENT_UP		= 2
ORIENT_DOWN		= 3
ORIENT_HORIZONTAL =4
ORIENT_VERTICAL = 5

-- for entity_isNearObstruction
OBSCHECK_RANGE	= 0
OBSCHECK_4DIR	= 1
OBSCHECK_DOWN	= 2

EV_WALLOUT				= 0
EV_WALLTRANS			= 1
EV_CLAMPING				= 2
EV_SWITCHCLAMP			= 3
EV_CLAMPTRANSF			= 4
EV_MOVEMENT				= 5
EV_COLLIDE				= 6
EV_TOUCHDMG				= 7
EV_FRICTION				= 8
EV_LOOKAT				= 9
EV_CRAWLING				= 10
EV_ENTITYDIED			= 11
EV_TYPEID				= 12
EV_COLLIDELEVEL			= 13
EV_BONELOCKED			= 14
EV_FLIPTOPATH			= 15
EV_NOINPUTNOVEL			= 16
EV_VINEPUSH				= 17
EV_BEASTBURST			= 18
EV_MINIMAP				= 19
EV_SOULSCREAMRADIUS		= 20
EV_WEBSLOW				= 21
EV_MAX					= 22

EVT_NONE				= 0
EVT_THERMALVENT			= 1
EVT_GLOBEJELLY			= 2
EVT_CELLWHITE			= 3
EVT_CELLRED				= 4
EVT_PET					= 5
EVT_DARKLISHOT			= 6
EVT_ROCK				= 7
EVT_FORESTGODVINE		= 8
EVT_CONTAINER			= 9
EVT_PISTOLSHRIMP		= 10
EVT_GATEWAYMUTANT		= 11


-- PATH/node types
PATH_NONE			= 0
PATH_CURRENT 		= 1
PATH_STEAM			= 2
PATH_LI				= 3
PATH_SAVEPOINT		= 4
PATH_WARP			= 5
PATH_SPIRITPORTAL	= 6
PATH_BGSFXLOOP		= 7
PATH_RADARHIDE		= 8
PATH_COOK			= 9
PATH_WATERBUBBLE	= 10
PATH_GEM			= 11
PATH_SETING			= 12
PATH_SETENT			= 13

-- Entity Types
ET_AVATAR			=0
ET_ENEMY			=1
ET_PET				=2
ET_FLOCK			=3
ET_NEUTRAL			=4
ET_INGREDIENT		=5

EP_SOLID			=0
EP_MOVABLE			=1
EP_BATTERY			=2
EP_BLOCKER			=3

-- Entity Behaviors
BT_NORMAL			=0
BT_MOTHER			=1
BT_ACTIVEPET		=2

-- ACTIVATION TYPES
AT_NONE				=-1
AT_NORMAL 			=0
AT_CLICK			=0
AT_RANGE			=1

WT_NORMAL			= 0
WT_SPIRIT			= 1

SPEED_NORMAL		= 0
SPEED_SLOW			= 1
SPEED_FAST			= 2
SPEED_VERYFAST 	 	= 3
SPEED_MODSLOW		= 4
SPEED_VERYSLOW		= 5
SPEED_FAST2			= 6

BOUNCE_NONE			= -1
BOUNCE_SIMPLE		= 0
BOUNCE_REAL			= 1

LOOP_INFINITE		= -1
LOOP_INF			= -1

LAYER_BODY			= 0
LAYER_UPPERBODY		= 1
LAYER_HEAD			= 2
LAYER_OVERRIDE		= 3

SONG_NONE				= -1
SONG_HEAL				= 0
SONG_ENERGYFORM			= 1
SONG_SONGDOOR1			= 2
SONG_SPIRITFORM			= 3
SONG_BIND				= 4
SONG_PULL				= 4
SONG_NATUREFORM			= 5
SONG_BEASTFORM			= 6
SONG_SHIELDAURA			= 7
SONG_SHIELD				= 7
SONG_SONGDOOR2			= 8
SONG_DUALFORM			= 9
SONG_FISHFORM			= 10
SONG_LIGHTFORM			= 11
SONG_SUNFORM			= 11
SONG_LI					= 12
SONG_TIME				= 13
SONG_LANCE				= 14
SONG_MAP				= 15
SONG_ANIMA				= 16
SONG_MAX				= 17

BLEND_DEFAULT			= 0
BLEND_ADD				= 1
BLEND_ADDITIVE			= 1

SAY_NORMAL				= 0
SAY_QUEUE				= 1
SAY_INTERUPT			= 2

--[[
VO_BEGIN					= 200
FLAG_VO_TITLE				= 200
FLAG_VO_NAIJACAVE			= 201
FLAG_VO_SINGING				= 202
FLAG_VO_MINIMAP				= 203
FLAG_VO_SPEEDBOOST			= 204
FLAG_VO_VERSE				= 205
FLAG_VO_VEDHACAVE			= 206
FLAG_VO_SHIELDSONG				= 207
FLAG_VO_VEDHAEXPLORE			= 208
FLAG_VO_MEMORYCRYSTALS			= 209
FLAG_VO_SONGCAVEENTER			= 210
FLAG_VO_SONGDOOR				= 211
FLAG_VO_SONGCRYSTAL				= 212
FLAG_VO_ENERGYTEMPLEENTER		= 213
FLAG_VO_ENERGYFORM				= 214
FLAG_VO_ENERGYFORMSHOT			= 215
FLAG_VO_ENERGYFORMCHARGE		= 216
FLAG_VO_RETURNTONORMALFORM		= 217
FLAG_VO_ENERGYTEMPLEBOSSOVER	= 218
]]--

ENDING_NAIJACAVE				= 10
ENDING_NAIJACAVEDONE			= 11
ENDING_SECRETCAVE				= 12
ENDING_MAINAREA					= 13
ENDING_DONE						= 14


FLAG_SONGCAVECRYSTAL			= 20
FLAG_TEIRA						= 50
FLAG_SHARAN						= 51
FLAG_DRASK						= 52
FLAG_VEDHA						= 53

FLAG_ENERGYTEMPLE01DOOR			= 100
FLAG_ENERGYDOOR02				= 101
FLAG_ENERGYSLOT01				= 102
FLAG_ENERGYSLOT02				= 103
FLAG_ENERGYSLOT_MAINAREA		= 104
FLAG_MAINAREA_ENERGYTEMPLE_ROCK	= 105
FLAG_ENERGYSLOT_FIRST			= 106
FLAG_ENERGYDOOR03				= 107
FLAG_ENERGYGODENCOUNTER			= 108
FLAG_ENERGYBOSSDEAD				= 109
FLAG_MAINAREA_ETENTER2			= 110
FLAG_SUNTEMPLE_WATERLEVEL		= 111
FLAG_SUNTEMPLE_LIGHTCRYSTAL		= 112
FLAG_SUNKENCITY_PUZZLE			= 113
FLAG_SUNKENCITY_BOSS			= 114
FLAG_MITHALAS_THRONEROOM		= 115
FLAG_BOSS_MITHALA				= 116
FLAG_BOSS_FOREST				= 117
FLAG_FISHCAVE					= 118
FLAG_VISION_VEIL				= 119
FLAG_MITHALAS_PRIESTS			= 120
FLAG_FIRSTTRANSTURTLE			= 121
FLAG_13PROGRESSION				= 122
FLAG_FINAL						= 123
FLAG_SPIRIT_ERULIAN				= 124
FLAG_SPIRIT_KROTITE				= 125
FLAG_SPIRIT_DRASK				= 126
FLAG_SPIRIT_DRUNIAD				= 127
FLAG_BOSS_SUNWORM				= 128
FLAG_WHALELAMPPUZZLE			= 129

FLAG_TRANSTURTLE_VEIL01			= 130
FLAG_TRANSTURTLE_OPENWATER06	= 131
FLAG_TRANSTURTLE_FOREST04		= 132
FLAG_TRANSTURTLE_OPENWATER03	= 133
FLAG_TRANSTURTLE_FOREST05		= 134
FLAG_TRANSTURTLE_MAINAREA		= 135
FLAG_TRANSTURTLE_SEAHORSE		= 136
FLAG_TRANSTURTLE_VEIL02			= 137
FLAG_TRANSTURTLE_ABYSS03		= 138
FLAG_TRANSTURTLE_FINALBOSS		= 139

FLAG_NAIJA_SWIM					= 200
FLAG_NAIJA_MINIMAP				= 201
FLAG_NAIJA_SPEEDBOOST			= 202
FLAG_NAIJA_MEMORYCRYSTAL		= 203
FLAG_NAIJA_SINGING				= 204
FLAG_NAIJA_LEAVESVEDHA			= 205
FLAG_NAIJA_SONGDOOR				= 206
FLAG_NAIJA_ENTERVEDHACAVE		= 207
FLAG_NAIJA_INTERACT				= 208
FLAG_NAIJA_ENTERSONGCAVE		= 209
FLAG_NAIJA_ENERGYFORMSHOT		= 210
FLAG_NAIJA_ENERGYFORMCHARGE		= 211
FLAG_NAIJA_RETURNTONORMALFORM	= 212
FLAG_NAIJA_ENERGYBARRIER		= 213
FLAG_NAIJA_SOLIDENERGYBARRIER	= 214
FLAG_NAIJA_ENTERENERGYTEMPLE	= 215
FLAG_NAIJA_OPENWATERS			= 216
FLAG_NAIJA_SINGING				= 217
FLAG_NAIJA_INGAMEMENU			= 218
FLAG_NAIJA_SINGINGHINT			= 219
FLAG_NAIJA_LOOK					= 220
FLAG_HINT_MINIMAP				= 221
FLAG_HINT_HEALTHPLANT			= 222
FLAG_HINT_SLEEP					= 223
FLAG_HINT_COLLECTIBLE			= 224
FLAG_HINT_IGFDEMO				= 225
FLAG_HINT_BEASTFORM1			= 226
FLAG_HINT_BEASTFORM2			= 227
FLAG_HINT_LISONG				= 228
FLAG_HINT_ENERGYTARGET			= 229
FLAG_HINT_NATUREFORMABILITY		= 230
FLAG_HINT_LICOMBAT				= 231
FLAG_HINT_COOKING				= 232
FLAG_NAIJA_FIRSTVINE			= 233
FLAG_SECRET01					= 234
FLAG_SECRET02					= 235
FLAG_SECRET03					= 236
FLAG_DEEPWHALE					= 237
FLAG_OMPO						= 238
FLAG_HINT_SINGBULB				= 239
FLAG_ENDING						= 240
FLAG_NAIJA_BINDSHELL			= 241
FLAG_NAIJA_BINDROCK				= 242
FLAG_HINT_ROLLGEAR				= 243
FLAG_FIRSTHEALTHUPGRADE			= 244
FLAG_MAINAREA_TRANSTURTLE_ROCK	= 245
FLAG_SKIPSECRETCHECK			= 246
FLAG_SEAHORSEBESTTIME			= 247
FLAG_SEAHORSETIMETOBEAT			= 248


FLAG_CREATORVOICE				= 250

FLAG_HINT_DUALFORMCHANGE		= 251
FLAG_HINT_DUALFORMCHARGE		= 252
FLAG_HINT_HEALTHUPGRADE			= 253

FLAG_VISION_ENERGYTEMPLE		= 300

FLAG_COLLECTIBLE_START				= 500
FLAG_COLLECTIBLE_SONGCAVE			= 500
FLAG_COLLECTIBLE_ENERGYTEMPLE		= 501
FLAG_COLLECTIBLE_ENERGYSTATUE		= 502
FLAG_COLLECTIBLE_ENERGYBOSS     	= 503
FLAG_COLLECTIBLE_NAIJACAVE			= 504
FLAG_COLLECTIBLE_CRABCOSTUME		= 505
FLAG_COLLECTIBLE_JELLYPLANT			= 506
FLAG_COLLECTIBLE_MITHALASPOT		= 507
FLAG_COLLECTIBLE_SEAHORSECOSTUME	= 508
--FLAG_COLLECTIBLE_TURTLESHELL		= 508
FLAG_COLLECTIBLE_CHEST				= 509
FLAG_COLLECTIBLE_BANNER				= 510
FLAG_COLLECTIBLE_MITHALADOLL		= 511
FLAG_COLLECTIBLE_WALKERBABY			= 512
FLAG_COLLECTIBLE_SEEDBAG			= 513
FLAG_COLLECTIBLE_ARNASSISTATUE		= 514
FLAG_COLLECTIBLE_GEAR				= 515
FLAG_COLLECTIBLE_SUNKEY				= 516
FLAG_COLLECTIBLE_URCHINCOSTUME		= 517
FLAG_COLLECTIBLE_TEENCOSTUME		= 518
FLAG_COLLECTIBLE_MUTANTCOSTUME		= 519
FLAG_COLLECTIBLE_JELLYCOSTUME		= 520
FLAG_COLLECTIBLE_MITHALANCOSTUME	= 521
FLAG_COLLECTIBLE_ANEMONESEED		= 522
FLAG_COLLECTIBLE_BIOSEED			= 523
FLAG_COLLECTIBLE_TURTLEEGG			= 524
FLAG_COLLECTIBLE_SKULL				= 525
FLAG_COLLECTIBLE_TRIDENTHEAD		= 526
FLAG_COLLECTIBLE_SPORESEED			= 527
FLAG_COLLECTIBLE_UPSIDEDOWNSEED		= 528
FLAG_COLLECTIBLE_STONEHEAD			= 529
FLAG_COLLECTIBLE_STARFISH			= 530
FLAG_COLLECTIBLE_BLACKPEARL			= 531
--FLAG_COLLECTIBLE_BABYCRIB			= 532
FLAG_COLLECTIBLE_END				= 600

FLAG_PET_ACTIVE					= 600
FLAG_PET_NAMESTART				= 601
FLAG_PET_NAUTILUS				= 601
FLAG_PET_DUMBO					= 602
FLAG_PET_BLASTER				= 603
FLAG_PET_PIRANHA				= 604

FLAG_UPGRADE_WOK				= 620
-- does the player have access to 3 slots all the time?

FLAG_COLLECTIBLE_NAUTILUSPRIME  = 630
FLAG_COLLECTIBLE_DUMBOEGG		= 631
FLAG_COLLECTIBLE_BLASTEREGG		= 632
FLAG_COLLECTIBLE_PIRANHAEGG		= 633

FLAG_ENTER_HOMEWATERS			= 650
FLAG_ENTER_SONGCAVE				= 651
FLAG_ENTER_ENERGYTEMPLE			= 652
FLAG_ENTER_OPENWATERS			= 653
FLAG_ENTER_HOMECAVE				= 654
FLAG_ENTER_FOREST				= 655
FLAG_ENTER_VEIL					= 656
FLAG_ENTER_MITHALAS				= 657
FLAG_ENTER_MERMOGCAVE			= 658
FLAG_ENTER_MITHALAS				= 659
FLAG_ENTER_SUNTEMPLE			= 660
FLAG_ENTER_ABYSS				= 661
FLAG_ENTER_SUNKENCITY			= 662
FLAG_ENTER_FORESTSPRITECAVE		= 663


FLAG_MINIBOSS_START				= 700
FLAG_MINIBOSS_NAUTILUSPRIME		= 700
FLAG_MINIBOSS_KINGJELLY			= 701
FLAG_MINIBOSS_MERGOG			= 702
FLAG_MINIBOSS_CRAB				= 703
FLAG_MINIBOSS_OCTOMUN			= 704
FLAG_MINIBOSS_END				= 800

FLAG_SONGDOOR1					= 800
FLAG_SEALOAFANNOYANCE			= 801

FLAG_SEAL_KING					= 900
FLAG_SEAL_QUEEN					= 901
FLAG_SEAL_PRINCE				= 902

FLAG_LI							= 1000
FLAG_LICOMBAT					= 1001



MAX_FLAGS						= 1024

ALPHA_NEARZERO					= 0.001

SUNKENCITY_START				= 0
SUNKENCITY_CLIMBDOWN			= 1
SUNKENCITY_RUNAWAY				= 2
SUNKENCITY_INHOLE				= 3
SUNKENCITY_GF					= 4
SUNKENCITY_BULLIES				= 5
SUNKENCITY_ANIMA				= 6
SUNKENCITY_BOSSWAIT				= 7
SUNKENCITY_CLAY1				= 8
SUNKENCITY_CLAY2				= 9
SUNKENCITY_CLAY3				= 10
SUNKENCITY_CLAY4				= 11
SUNKENCITY_CLAY5				= 12
SUNKENCITY_CLAY6				= 13
SUNKENCITY_CLAYDONE				= 14
SUNKENCITY_BOSSFIGHT			= 15
SUNKENCITY_BOSSDONE				= 16
SUNKENCITY_FINALTONGUE			= 17

FINAL_START						= 0
FINAL_SOMETHING					= 1
FINAL_FREEDLI					= 2

ANIM_NONE			= 0
ANIM_POS			= 1
ANIM_ROT			= 2
ANIM_ALL			= 10

FORM_NORMAL			= 0
FORM_ENERGY			= 1
FORM_BEAST			= 2
FORM_NATURE			= 3
FORM_SPIRIT			= 4
FORM_DUAL			= 5
FORM_FISH			= 6
FORM_LIGHT			= 7
FORM_SUN			= 7
FORM_MAX			= 8

VFX_SHOCK			= 0
VFX_RIPPLE			= 1

EAT_NONE				= -1
EAT_DEFAULT				= 0
EAT_FILE				= 1
EAT_MAX					= 2

--[[
DT_ENEMY				= 0
DT_ENEMY_ENERGYBLAST	= 1
DT_ENEMY_SHOCK			= 2
DT_ENEMY_BITE			= 3
DT_ENEMY_TRAP			= 4
DT_ENEMY_WEB			= 5
DT_ENEMY_BEAM			= 6
DT_ENEMY_GAS			= 100
DT_ENEMY_INK			= 101
DT_ENEMY_POISON			= 102
DT_ENEMY_ACTIVEPOISON	= 103
DT_ENEMY_CREATOR		= 600
DT_AVATAR				= 1000
DT_AVATAR_ENERGYBLAST	= 1001
DT_AVATAR_SHOCK			= 1002
DT_AVATAR_BITE			= 1003
DT_AVATAR_VOMIT			= 1004
DT_AVATAR_ACID			= 1005
DT_AVATAR_SPORECHILD	= 1006
DT_AVATAR_LIZAP			= 1007
DT_AVATAR_NATURE		= 1008
DT_AVATAR_ENERGYROLL	= 1009
DT_AVATAR_VINE			= 1010
DT_AVATAR_EAT			= 1011
DT_AVATAR_EAT_BASICSHOT	= 1011
DT_AVATAR_EAT_MAX		= 1012
DT_AVATAR_LANCEATTACH	= 1013
DT_AVATAR_LANCE			= 1014
DT_AVATAR_CREATORSHOT	= 1015
DT_AVATAR_DUALFORMLI	= 1016
DT_AVATAR_DUALFORMNAIJA = 1017
DT_AVATAR_BUBBLE		= 1018
DT_AVATAR_SEED			= 1019
DT_AVATAR_PETNAUTILUS	= 1020

DT_AVATAR_END			= 2000
DT_TOUCH				= 2000
DT_CRUSH				= 2001
DT_SPIKES				= 2002
]]--

DT_NONE					= -1
DT_ENEMY				= 0
DT_ENEMY_ENERGYBLAST	= 1
DT_ENEMY_SHOCK			= 2
DT_ENEMY_BITE			= 3
DT_ENEMY_TRAP			= 4
DT_ENEMY_WEB			= 5
DT_ENEMY_BEAM			= 6
DT_ENEMY_GAS			= 7
DT_ENEMY_INK			= 8
DT_ENEMY_POISON			= 9
DT_ENEMY_ACTIVEPOISON	= 10
DT_ENEMY_CREATOR		= 11
DT_ENEMY_MANTISBOMB		= 12
DT_ENEMY_MAX			= 13
DT_ENEMY_END			= 13

DT_AVATAR				= 1000
DT_AVATAR_ENERGYBLAST	= 1001
DT_AVATAR_SHOCK			= 1002
DT_AVATAR_BITE			= 1003
DT_AVATAR_VOMIT			= 1004
DT_AVATAR_ACID			= 1005
DT_AVATAR_SPORECHILD	= 1006
DT_AVATAR_LIZAP			= 1007
DT_AVATAR_NATURE		= 1008
DT_AVATAR_ENERGYROLL	= 1009
DT_AVATAR_VINE			= 1010
DT_AVATAR_EAT			= 1011
DT_AVATAR_EAT_BASICSHOT	= 1011
DT_AVATAR_EAT_MAX		= 1012
DT_AVATAR_LANCEATTACH	= 1013
DT_AVATAR_LANCE			= 1014
DT_AVATAR_CREATORSHOT	= 1015
DT_AVATAR_DUALFORMLI	= 1016
DT_AVATAR_DUALFORMNAIJA = 1017
DT_AVATAR_BUBBLE		= 1018
DT_AVATAR_SEED			= 1019
DT_AVATAR_PET			= 1020
DT_AVATAR_PETNAUTILUS	= 1021
DT_AVATAR_PETBITE		= 1022
DT_AVATAR_MAX			= 1030
DT_AVATAR_END			= 1030

DT_TOUCH				= 1031
DT_CRUSH				= 1032
DT_SPIKES				= 1033
DT_STEAM				= 1034


-- collide radius
-- must match value in ScriptedEntity::setupConversationEntity
CR_DEFAULT			= 40

FRAME_TIME			= 0.04

FORMUPGRADE_ENERGY1		= 0
FORMUPGRADE_ENERGY2		= 1
FORMUPGRADE_BEAST		= 2


TILE_SIZE				= 20

function watchForVoice()
	while isStreamingVoice() do watch(FRAME_TIME) end
end

function entity_watchSwimToEntitySide(ent1, ent2)	
	local xoff=entity_getCollideRadius(ent2)+64
	if entity_x(ent1) < entity_x(ent2) then
		xoff = -xoff
	end
	entity_swimToPosition(ent1, entity_x(ent2)+xoff, entity_y(ent2))
	entity_watchForPath(ent1)
	entity_idle(ent1)
	entity_clearVel(ent1)
	entity_flipToEntity(ent1, ent2)
	entity_flipToEntity(ent2, ent1)
end
