AddCSLuaFile("shared.lua")
include('shared.lua')
include("vj_base/addons/vj_haloflood_combat.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/halo3/flood_elite.mdl"}
ENT.StartHealth = 165
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

	self:SetSkin(self.Skin or math.random(0,math.random(1,15) == 1 && 6 or 5))

	self.Shield = 150
	self.NextShieldRegenT = CurTime() +2

	local isABigBoi = self:GetSkin() >= 5
	if isABigBoi then
		local hp = self:Health() *1.35
		self:SetHealth(hp)
		self:SetMaxHealth(hp)

		self.Shield = 250
	end

	self.HasCamo = math.random(1,isABigBoi && 1 or 5) == 1
	self.Camo = 200
	self.CamoState = 0 -- 0 = Not Active, 1 = Active, 2 = Regenerating
	self.NextCamoRegenT = CurTime() +2

	self.ShieldMax = self.Shield
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	-- Entity(1):ChatPrint(key)
	if key == "event_emit step" then
		VJ_CreateStepSound(self,32,self.SoundTbl_FootStep,true)
	elseif key == "event_mattack" then
		self.MeleeAttackDamage = 26
		self.HasMeleeAttackKnockBack = false
		self:MeleeAttackCode()
	elseif key == "event_mattack forward" then
		self.MeleeAttackDamage = 30
		self.HasMeleeAttackKnockBack = false
		self:MeleeAttackCode()
	elseif key == "event_pattack" then
		self.MeleeAttackDamage = 15
		self.HasMeleeAttackKnockBack = true
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThink(wep,ent,dist)
	if self.Shield > 0 then
		self:RemoveAllDecals()
	end
	if CurTime() > self.NextShieldRegenT && (self.Shield != self.ShieldMax) then
		self.Shield = math.Clamp(self.Shield +1,0,self.ShieldMax)
	end
	if self.HasCamo then
		local state = self.CamoState
		if state == 2 then
			if self.Camo >= 200 then
				self.CamoState = 0
				return
			end
			if CurTime() > self.NextCamoRegenT then
				self.Camo = math.Clamp(self.Camo +1,0,200)
			end
		elseif state == 1 then
			self.Camo = math.Clamp(self.Camo -1,0,200)
			if self.Camo <= 0 && state != 2 then
				self.CamoState = 2
				self:SetCamo(false)
			end
		elseif state == 0 then
			if IsValid(ent) && math.random(1,50) == 1 then
				self.CamoState = 1
				self:SetCamo(true)
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDamaged(dmginfo, hitgroup)
	if self.Shield > 0 then
		self.Shield = self.Shield -dmginfo:GetDamage()
		dmginfo:SetDamage(0)
		self.NextShieldRegenT = CurTime() +5
		ParticleEffect("npcarmor_hit",dmginfo:GetDamagePosition(),Angle(0,0,0),self)
		VJ_EmitSound(self,"ambient/energy/zap" .. math.random(1,3) .. ".wav",65,math.random(90,110))

		if self.Shield <= 0 then
			self.NextShieldRegenT = CurTime() +15
			ParticleEffectAttach("npcarmor_break",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
			VJ_EmitSound(self,"ambient/energy/weld" .. math.random(1,2) .. ".wav",85,100)
		end
	end
end