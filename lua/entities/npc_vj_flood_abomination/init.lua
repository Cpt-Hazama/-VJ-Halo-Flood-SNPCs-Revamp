AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/halowars2/flood_abomination.mdl"}
ENT.StartHealth = 7500
ENT.HullType = HULL_LARGE
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
ENT.CustomBlood_Particle = {"cpt_blood_flood"}

ENT.HasMeleeAttack = true
ENT.MeleeAttackDamage = 225
ENT.MeleeAttackDistance = 250
ENT.MeleeAttackDamageDistance = 625
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
ENT.TimeUntilMeleeAttackDamage = false
ENT.MeleeAttackDamageType = bit.bor(DMG_SLASH,DMG_CRUSH)
ENT.MeleeAttackAnimationFaceEnemy = false

ENT.DisableFootStepSoundTimer = true
ENT.HasExtraMeleeAttackSounds = true

ENT.GeneralSoundPitch1 = 100

ENT.SoundTbl_FootStep = {
	"vj_halo3flood/tank/tank_melee_hit7.wav",
	"vj_halo3flood/tank/tank_melee_hit8.wav",
	"vj_halo3flood/tank/tank_melee_hit9.wav",
	"vj_halo3flood/tank/tank_melee_hit10.wav",
	"vj_halo3flood/tank/tank_melee_hit11.wav",
	"vj_halo3flood/tank/tank_melee_hit12.wav",
}
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
	self:SetCollisionBounds(Vector(85,85,475),Vector(-85,-85,0))

	self:SetCustomCollisionCheck(true)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		VJ_EmitSound(self,VJ_PICK(self.SoundTbl_FootStep),95,math.random(55,65))
		util.ScreenShake(self:GetPos(),16,100,2,1800)
	elseif key == "melee" then
		self:MeleeAttackCode()
	elseif key == "melee_impact" then
		util.ScreenShake(self:GetPos(),16,100,4,2500)
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/