AddCSLuaFile("shared.lua")
include('shared.lua')
include("vj_base/addons/vj_haloflood_combat.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/halo3/flood_brute.mdl"}
ENT.StartHealth = 225
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_FLOOD","CLASS_PARASITE"}

ENT.VJC_Data = {
    CameraMode = 1,
    ThirdP_Offset = Vector(0, 0, 0),
    FirstP_Bone = "head",
    FirstP_Offset = Vector(2, 0, 5)
}

ENT.BloodColor = "Yellow"
ENT.CustomBlood_Particle = {"cpt_blood_flood","cpt_blood_flood","cpt_blood_flood","vj_impact1_purple"}

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

ENT.SoundTbl_FootStep = {
	"vj_halo3flood/combatform/humanform_longmove1.wav",
	"vj_halo3flood/combatform/humanform_longmove2.wav",
	"vj_halo3flood/combatform/humanform_longmove3.wav",
	"vj_halo3flood/combatform/humanform_longmove4.wav",
	"vj_halo3flood/combatform/humanform_longmove5.wav",
	"vj_halo3flood/combatform/humanform_longmove6.wav",
	"vj_halo3flood/combatform/humanform_longmove7.wav",
	"vj_halo3flood/combatform/humanform_longmove8.wav",
	"vj_halo3flood/combatform/humanform_longmove9.wav",
	"vj_halo3flood/combatform/humanform_longmove10.wav",
	"vj_halo3flood/combatform/humanform_longmove11.wav",
	"vj_halo3flood/combatform/humanform_longmove12.wav",
	"vj_halo3flood/combatform/humanform_longmove13.wav",
	"vj_halo3flood/combatform/humanform_longmove14.wav",
	"vj_halo3flood/combatform/humanform_longmove15.wav"
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	self:SetCollisionBounds(Vector(15,15,60),Vector(-15,-15,0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	-- Entity(1):ChatPrint(key)
	if key == "event_emit step" then
		VJ_CreateStepSound(self,32,self.SoundTbl_FootStep,true)
	elseif key == "event_mattack" then
		self.MeleeAttackDamage = 32
		self.HasMeleeAttackKnockBack = false
		self:MeleeAttackCode()
	elseif key == "event_mattack forward" then
		self.MeleeAttackDamage = 38
		self.HasMeleeAttackKnockBack = false
		self:MeleeAttackCode()
	elseif key == "event_pattack" then
		self.MeleeAttackDamage = 20
		self.HasMeleeAttackKnockBack = true
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDamaged(dmginfo, hitgroup)
	dmginfo:ScaleDamage(0.65)
end