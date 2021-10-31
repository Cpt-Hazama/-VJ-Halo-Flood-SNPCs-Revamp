AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/halo3/flood_carrier.mdl"}
ENT.StartHealth = 75
ENT.HullType = HULL_HUMAN
ENT.MaxJumpLegalDistance = VJ_Set(1200,2000)
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_FLOOD","CLASS_PARASITE"}

ENT.VJC_Data = {
    CameraMode = 1,
    ThirdP_Offset = Vector(0, 0, 0),
    FirstP_Bone = "spine2",
    FirstP_Offset = Vector(4, 0, 1)
}

ENT.BloodColor = "Yellow"
ENT.CustomBlood_Particle = {"cpt_blood_flood"}

ENT.HasMeleeAttack = false

ENT.GibOnDeathDamagesTable = {"All"}

ENT.DisableFootStepSoundTimer = true
ENT.HasExtraMeleeAttackSounds = true
ENT.GeneralSoundPitch1 = 100

ENT.SoundTbl_FootStep = {"vj_halo3flood/carrier/shared/carrier_walk1.mp3",}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_halo3flood/carrier/h3/unarmed_melee_suicide1.mp3","vj_halo3flood/carrier/h3/unarmed_melee_suicide2.mp3","vj_halo3flood/carrier/h3/unarmed_melee_suicide3.mp3"}
ENT.SoundTbl_LeapAttack = {}
ENT.SoundTbl_Pain = {"vj_halo3flood/carrier/h3/carswell2.mp3"}
ENT.SoundTbl_Death = {"vj_halo3flood/carrier/hce/die1.mp3","vj_halo3flood/carrier/hce/die2.mp3"}
ENT.SoundTbl_Impact = {
	"vj_halo3flood/damage01.mp3",
	"vj_halo3flood/damage02.mp3",
	"vj_halo3flood/damage03.mp3",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_JUMP))
	self:SetCollisionBounds(Vector(15,15,60),Vector(-15,-15,0))

	self:SetCustomCollisionCheck(true)

	self.Exploding = false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	-- Entity(1):ChatPrint(key)
	if key == "event_emit step" then
		VJ_CreateStepSound(self,32,self.SoundTbl_FootStep,true)
	elseif key == "event_mattack" then
		self:DoSplode(math.random(6,14))
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
		local dist = self:VJ_GetNearestPointToEntityDistance(ent)
		if dist <= 120 && !self.Exploding then
			self:VJ_ACT_PLAYACTIVITY("vjseq_suicide" .. math.random(1,2),true,nil,false)
			VJ_EmitSound(self,"vj_halo3flood/carrier/h3/unarmed_melee_suicide" .. math.random(1,3) .. ".mp3",85,100)
			self.Exploding = true
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoSplode(flood,dmginfo)
	util.VJ_SphereDamage(self,self,self:GetPos(),150,45,bit.bor(DMG_BLAST,DMG_NERVEGAS),false,true)
	VJ_EmitSound(self,"vj_halo3flood/explode0" .. math.random(1,2) .. ".mp3",85)
	VJ_EmitSound(self,"vj_halo3flood/carrier/h3/pop" .. math.random(1,6) .. ".mp3",120,100)
	self:SpawnFlood(flood or 1)

	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
	bloodeffect:SetScale(200)
	util.Effect("VJ_Blood1",bloodeffect)

	for i = 1,math.random(3,6) do
		self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
		self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
		if math.random(1,3) == 1 then
			self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
		end
	end

	if dmginfo == nil then
		self:Remove()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	self:DoSplode(math.random(3,8),dmginfo)
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SpawnFlood(count)
	local sCount = self.VJ_EnhancedFlood && count *2 or count
	for i = 1,sCount do
		local pos = self:GetPos() +self:OBBCenter()
		local flood = ents.Create("npc_vj_flood_infection")
		flood:SetPos(pos +self:GetForward() *math.Rand(-(4 *i),4 *i) +self:GetRight() *math.Rand(-(4 *i),4 *i))
		flood:SetAngles(Angle(self:GetAngles().x,math.Rand(0,360),self:GetAngles().z))
		flood:Spawn()
		flood:SetGroundEntity(NULL)
		local rand = 350
		flood:SetVelocity(self:GetForward() *math.random(-rand,rand) +self:GetUp() *math.random(rand -50,rand) +self:GetRight() *math.random(-rand,rand))
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/