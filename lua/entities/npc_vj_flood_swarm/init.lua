AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/halowars/flood_swarm.mdl"}
ENT.StartHealth = 50
ENT.HullType = HULL_WIDE_SHORT
ENT.MovementType = VJ_MOVETYPE_AERIAL
ENT.TurningUseAllAxis = true

ENT.Aerial_FlyingSpeed_Calm = 500 -- The speed it should fly with, when it's wandering, moving slowly, etc. | Basically walking compared to ground SNPCs
ENT.Aerial_FlyingSpeed_Alerted = 750 -- The speed it should fly with, when it's chasing an enemy, moving away quickly, etc. | Basically running compared to ground SNPCs
ENT.Aerial_AnimTbl_Calm = ACT_FLY -- Animations it plays when it's wandering around while idle
ENT.Aerial_AnimTbl_Alerted = ACT_FLY -- Animations it plays when it's moving while alerted
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_FLOOD","CLASS_PARASITE"}

ENT.VJC_Data = {
    CameraMode = 1,
    ThirdP_Offset = Vector(0, 0, 0),
    FirstP_Bone = "bone_COG",
    FirstP_Offset = Vector(5, 0, 0)
}

ENT.BloodColor = "Yellow"
ENT.CustomBlood_Particle = {"cpt_blood_flood","cpt_blood_flood","cpt_blood_flood","vj_impact1_green"}

ENT.HasMeleeAttack = false

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK1} -- Range Attack Animations
ENT.RangeAttackEntityToSpawn = "obj_vj_flood_spike" -- The entity that is spawned when range attacking
ENT.RangeDistance = 1500 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.RangeAttackPos_Up = 0 -- Up/Down spawning position for range attack
ENT.RangeAttackPos_Forward = 20 -- Forward/ Backward spawning position for range attack
ENT.NextRangeAttackTime = 0.75 -- How much time until it can use a range attack?
ENT.NextRangeAttackTime_DoRand = 2 -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer

ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = "UseRangeDistance" -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = "UseRangeDistance" -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_Type = "Regular" -- "Regular" = Default behavior | "OnlyRange" = Only does it if it's able to range attack

ENT.IdleAlwaysWander = true

ENT.GeneralSoundPitch1 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(23, 23, 40), Vector(-23, -23, 0))

	self:SetCustomCollisionCheck(true)

	timer.Simple(0,function() self:SetPos(self:GetPos() +Vector(0,0,100)) end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "range" then
		self:RangeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local ent = self:GetEnemy()
	local pos = self:GetPos()
	local waypoint = pos +self:GetVelocity():Angle():Forward() *50
	local flyAnim = pos.z <= waypoint.z && ACT_FLY or ACT_GLIDE

	self.ConstantlyFaceEnemy = IsValid(ent) && self.LatestEnemyDistance <= self.RangeDistance
	self.Aerial_AnimTbl_Calm = IsValid(ent) && self.LatestEnemyDistance <= self.RangeDistance && ACT_IDLE or flyAnim
	self.Aerial_AnimTbl_Alerted = self.Aerial_AnimTbl_Calm
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled(dmginfo)
	if dmginfo:GetDamageType() == DMG_BLAST or dmginfo:GetDamageType() == DMG_BURN then return end

	local flood = ents.Create("npc_vj_flood_infection")
	flood:SetPos(self:GetPos())
	flood:SetAngles(self:GetAngles())
	flood:Spawn()
	undo.ReplaceEntity(self,flood)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/