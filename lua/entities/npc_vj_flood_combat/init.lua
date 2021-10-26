AddCSLuaFile("shared.lua")
include('shared.lua')
include("vj_base/addons/vj_haloflood_combat.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/halo3/flood_human.mdl"}
ENT.StartHealth = 100
ENT.HullType = HULL_HUMAN
ENT.EntitiesToNoCollide = {"npc_vj_flood_infection","npc_vj_hcf_infection","npc_vj_hcf_infection2"}
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
ENT.SoundTbl_Idle = {"vj_halo3flood/vo/invsgt10.mp3","vj_halo3flood/vo/invsgt1.mp3","vj_halo3flood/vo/invsgt2.mp3","vj_halo3flood/vo/invsgt5.mp3","vj_halo3flood/vo/invsgt6.mp3","vj_halo3flood/vo/invsgt8.mp3","vj_halo3flood/vo/invsgt9.mp3","vj_halo3flood/vo/invsgt_fail1.mp3","vj_halo3flood/vo/invsgt_fail10.mp3","vj_halo3flood/vo/invsgt_fail2.mp3","vj_halo3flood/vo/invsgt_fail3.mp3","vj_halo3flood/vo/invsgt_fail5.mp3","vj_halo3flood/vo/invsgt_fail7.mp3","vj_halo3flood/vo/invsgt_fail8.mp3","vj_halo3flood/vo/invsgt_fail9.mp3","vj_halo3flood/combatform/pain1.wav","vj_halo3flood/combatform/pain2.wav","vj_halo3flood/combatform/pain3.wav","vj_halo3flood/combatform/pain4.wav","vj_halo3flood/combatform/pain5.wav","vj_halo3flood/combatform/pain6.wav","vj_halo3flood/combatform/pain7.wav","vj_halo3flood/combatform/pain8.wav","vj_halo3flood/combatform/pain9.wav","vj_halo3flood/combatform/pain10.wav","vj_halo3flood/combatform/pain11.wav","vj_halo3flood/combatform/pain12.wav","vj_halo3flood/combatform/pain13.wav","vj_halo3flood/combatform/pain14.wav","vj_halo3flood/combatform/pain15.wav","vj_halo3flood/combatform/pain16.wav","vj_halo3flood/combatform/pain17.wav"}
ENT.SoundTbl_Alert = {
	"vj_halo3flood/combatform/spot1.wav",
	"vj_halo3flood/combatform/scream1.wav",
	"vj_halo3flood/combatform/scream2.wav",
	"vj_halo3flood/combatform/scream3.wav",
	"vj_halo3flood/combatform/scream4.wav",
	"vj_halo3flood/combatform/scream5.wav",
	"vj_halo3flood/combatform/scream6.wav",
	"vj_halo3flood/combatform/scream7.wav",
	"vj_halo3flood/combatform/scream8.wav",
	"vj_halo3flood/combatform/scream9.wav",
	"vj_halo3flood/vo/foundfoe10.mp3",
	"vj_halo3flood/vo/foundfoe11.mp3",
	"vj_halo3flood/vo/foundfoe12.mp3",
	"vj_halo3flood/vo/foundfoe1.mp3",
	"vj_halo3flood/vo/foundfoe2.mp3",
	"vj_halo3flood/vo/foundfoe3.mp3",
	"vj_halo3flood/vo/foundfoe4.mp3",
	"vj_halo3flood/vo/foundfoe5.mp3",
	"vj_halo3flood/vo/foundfoe6.mp3",
	"vj_halo3flood/vo/foundfoe7.mp3",
	"vj_halo3flood/vo/foundfoe8.mp3",
	"vj_halo3flood/vo/foundfoe9.mp3",
}
ENT.SoundTbl_CombatIdle = {
	"vj_halo3flood/vo/thrtn1.mp3",
	"vj_halo3flood/vo/thrtn2.mp3",
	"vj_halo3flood/vo/thrtn3.mp3",
	"vj_halo3flood/vo/thrtn4.mp3",
	"vj_halo3flood/vo/thrtn5.mp3",
	"vj_halo3flood/vo/thrtn6.mp3",
	"vj_halo3flood/vo/thrtn7.mp3",
	"vj_halo3flood/vo/thrtn8.mp3",
	"vj_halo3flood/vo/thrtn9.mp3",
	"vj_halo3flood/vo/thrtn10.mp3",
	"vj_halo3flood/vo/thrtn11.mp3",
	"vj_halo3flood/vo/crs1.mp3",
	"vj_halo3flood/vo/crs2.mp3",
	"vj_halo3flood/vo/crs3.mp3",
	"vj_halo3flood/vo/crs4.mp3",
	"vj_halo3flood/vo/crs5.mp3",
	"vj_halo3flood/vo/crs6.mp3",
	"vj_halo3flood/vo/crs7.mp3",
	"vj_halo3flood/vo/strk11.mp3",
	"vj_halo3flood/vo/strk10.mp3",
	"vj_halo3flood/vo/strk1.mp3",
	"vj_halo3flood/vo/strk2.mp3",
	"vj_halo3flood/vo/strk3.mp3",
	"vj_halo3flood/vo/strk4.mp3",
	"vj_halo3flood/vo/strk5.mp3",
	"vj_halo3flood/vo/strk6.mp3",
	"vj_halo3flood/vo/strk7.mp3",
	"vj_halo3flood/vo/strk8.mp3",
	"vj_halo3flood/vo/strk9.mp3",
	"vj_halo3flood/vo/seefoe1.mp3",
	"vj_halo3flood/vo/seefoe2.mp3",
	"vj_halo3flood/vo/seefoe3.mp3",
	"vj_halo3flood/vo/seefoe4.mp3",
	"vj_halo3flood/vo/seefoe5.mp3",
	"vj_halo3flood/vo/seefoe6.mp3",
	"vj_halo3flood/vo/seefoe7.mp3",
	"vj_halo3flood/vo/seefoe8.mp3",
}
ENT.SoundTbl_CallForHelp = {
	"vj_halo3flood/vo/newordr_charge1.mp3",
	"vj_halo3flood/vo/newordr_charge2.mp3",
	"vj_halo3flood/vo/newordr_charge3.mp3",
	"vj_halo3flood/vo/newordr_charge4.mp3",
}
ENT.SoundTbl_OnKilledEnemy = {
	"vj_halo3flood/vo/chr_deadmc1.mp3",
	"vj_halo3flood/vo/chr_deadmc2.mp3",
	"vj_halo3flood/vo/chr_deadmc3.mp3",
	"vj_halo3flood/vo/chr_deadmc4.mp3",
	"vj_halo3flood/vo/chr_deadmc5.mp3",
	"vj_halo3flood/vo/chr_deadmc6.mp3",
	"vj_halo3flood/vo/chr_deadmc7.mp3",
	"vj_halo3flood/vo/chr_deadmc8.mp3",
	"vj_halo3flood/vo/chr_deadmc9.mp3",
	"vj_halo3flood/vo/chr_deadmc10.mp3",
}
ENT.SoundTbl_AllyDeath = {
	"vj_halo3flood/vo/lmnt_deadally1.mp3",
	"vj_halo3flood/vo/lmnt_deadally3.mp3",
	"vj_halo3flood/vo/lmnt_deadally4.mp3",
	"vj_halo3flood/vo/lmnt_deadally5.mp3",
	"vj_halo3flood/vo/lmnt_deadally6.mp3",
	"vj_halo3flood/vo/lmnt_deadally7.mp3",
}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_halo3flood/combatform/attack1.wav","vj_halo3flood/combatform/attack2.wav","vj_halo3flood/combatform/attack3.wav","vj_halo3flood/combatform/attack4.wav","vj_halo3flood/combatform/attack5.wav","vj_halo3flood/combatform/attack6.wav"}
ENT.SoundTbl_Pain = {"vj_halo3flood/vo/dth_hdsht2.mp3","vj_halo3flood/vo/dth_hdsht3.mp3","vj_halo3flood/vo/dth_hdsht4.mp3","vj_halo3flood/vo/dth_hdsth1.mp3","vj_halo3flood/combatform/pain1.wav","vj_halo3flood/combatform/pain2.wav","vj_halo3flood/combatform/pain3.wav","vj_halo3flood/combatform/pain4.wav","vj_halo3flood/combatform/pain5.wav","vj_halo3flood/combatform/pain6.wav","vj_halo3flood/combatform/pain7.wav","vj_halo3flood/combatform/pain8.wav","vj_halo3flood/combatform/pain9.wav","vj_halo3flood/combatform/pain10.wav","vj_halo3flood/combatform/pain11.wav","vj_halo3flood/combatform/pain12.wav","vj_halo3flood/combatform/pain13.wav","vj_halo3flood/combatform/pain14.wav","vj_halo3flood/combatform/pain15.wav","vj_halo3flood/combatform/pain16.wav","vj_halo3flood/combatform/pain17.wav"}
ENT.SoundTbl_Death = {"vj_halo3flood/combatform/death1.wav","vj_halo3flood/combatform/death2.wav","vj_halo3flood/combatform/death3.wav","vj_halo3flood/combatform/death4wav","vj_halo3flood/combatform/death5.wav","vj_halo3flood/combatform/death6.wav","vj_halo3flood/combatform/death7.wav","vj_halo3flood/combatform/death8.wav","vj_halo3flood/combatform/death9.wav","vj_halo3flood/combatform/death10.wav","vj_halo3flood/combatform/death11.wav","vj_halo3flood/combatform/death12.wav"}
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
function ENT:OnThink()

end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/