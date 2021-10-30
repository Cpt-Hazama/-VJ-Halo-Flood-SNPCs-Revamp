AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/halo3/flood_tank.mdl"}
ENT.StartHealth = 1
ENT.HullType = HULL_HUMAN
ENT.MaxJumpLegalDistance = VJ_Set(1200,2000)
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_FLOOD","CLASS_PARASITE"}

ENT.VJC_Data = {
    CameraMode = 1,
    ThirdP_Offset = Vector(0, 0, 0),
    FirstP_Bone = "head",
    FirstP_Offset = Vector(2, 0, 5)
}

ENT.BloodColor = "Yellow"
ENT.CustomBlood_Particle = {"cpt_blood_flood","cpt_blood_flood","cpt_blood_flood","vj_impact1_red"}

ENT.HasMeleeAttack = true
ENT.MeleeAttackDistance = 70
ENT.MeleeAttackDamageDistance = 90
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1,ACT_MELEE_ATTACK2}
ENT.TimeUntilMeleeAttackDamage = false
ENT.MeleeAttackDamageType = DMG_SLASH
ENT.MeleeAttackAnimationFaceEnemy = false

ENT.MeleeAttackKnockBack_Forward1 = 350
ENT.MeleeAttackKnockBack_Forward2 = 450
ENT.MeleeAttackKnockBack_Up1 = 220
ENT.MeleeAttackKnockBack_Up2 = 220
ENT.MeleeAttackKnockBack_Right1 = 0
ENT.MeleeAttackKnockBack_Right2 = 0

ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = {ACT_DIESIMPLE,ACT_DIE_LEFTSIDE,ACT_DIE_RIGHTSIDE}
ENT.DeathAnimationChance = 5

ENT.DisableFootStepSoundTimer = true
ENT.HasExtraMeleeAttackSounds = true
ENT.GeneralSoundPitch1 = 100

ENT.SoundTbl_FootStep = {}
ENT.SoundTbl_MeleeAttackMiss = {
	"vj_halo3flood/shared/melee_swish1.wav",
	"vj_halo3flood/shared/melee_swish3.wav",
	"vj_halo3flood/shared/melee_swish5.wav",
	"vj_halo3flood/shared/melee_swish6.wav",
	"vj_halo3flood/shared/melee_swish7.wav",
	"vj_halo3flood/shared/melee_swish8.wav",
}
ENT.SoundTbl_Impact = {
	"vj_halo3flood/damage01.mp3",
	"vj_halo3flood/damage02.mp3",
	"vj_halo3flood/damage03.mp3",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(15,15,60),Vector(-15,-15,0))

	timer.Simple(VJ_GetVarInt("vj_halo_developmenttime"),function()
		if IsValid(self) then
			VJ_ReplaceEntity("npc_vj_flood_carrier",self,function(old,new)
				for i = 0, old:GetBoneCount() -1 do
					local bonePos = old:GetBonePosition(i)
					ParticleEffect("cpt_blood_flood",bonePos,VJ_Ang0,nil)
					VJ_PlaySound(3,bonePos,{"vj_gib/gibbing1.wav","vj_gib/gibbing2.wav","vj_gib/gibbing3.wav"},55)
				end
			end)
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	Entity(1):ChatPrint(key)
	if key == "event_emit step" then
		VJ_CreateStepSound(self,32,self.SoundTbl_FootStep,true)
	elseif key == "event_mattack" then
		self.MeleeAttackDamage = 18
		self.HasMeleeAttackKnockBack = false
		self:MeleeAttackCode()
	elseif key == "event_pattack" then
		self.MeleeAttackDamage = 12
		self.HasMeleeAttackKnockBack = true
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnChangeActivity(newAct)
	if newAct == ACT_LAND then
		VJ_CreateStepSound(self,32,self.SoundTbl_FootStep,true)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local ent = self:GetEnemy()
	if IsValid(ent) then
		local dist = ent:GetPos():Distance(self:GetPos())

	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/