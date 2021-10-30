/*--------------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Flood Spike"
ENT.Author 			= ""
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "Projectiles for my addons"
ENT.Category		= "Projectiles"

if CLIENT then
	local Name = "Flood Spike"
	local LangName = "obj_vj_flood_spike"
	language.Add(LangName, Name)
	killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

ENT.Model = "models/Gibs/wood_gib01e.mdl" -- The models it should spawn with | Picks a random one from the table
ENT.DoesDirectDamage = true -- Should it do a direct damage when it hits something?
ENT.DirectDamage = 5 -- How much damage should it do when it hits something
ENT.DirectDamageType = bit.bor(DMG_SLASH,DMG_NERVEGAS) -- Damage type
ENT.DecalTbl_DeathDecals = {"Impact.Concrete"}
ENT.SoundTbl_OnCollide = {
	"vj_halo3flood/ranged/ranged_spike_hit1.wav",
	"vj_halo3flood/ranged/ranged_spike_hit2.wav",
	"vj_halo3flood/ranged/ranged_spike_hit3.wav",
	"vj_halo3flood/ranged/ranged_spike_hit4.wav",
	"vj_halo3flood/ranged/ranged_spike_hit5.wav",
	"vj_halo3flood/ranged/ranged_spike_hit6.wav",
	"vj_halo3flood/ranged/ranged_spike_hit7.wav",
	"vj_halo3flood/ranged/ranged_spike_hit8.wav",
}---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:SetMass(1)
	phys:EnableGravity(false)
	phys:EnableDrag(false)
	phys:SetBuoyancyRatio(0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	-- ParticleEffectAttach("cpt_flood_sporeparticles", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	util.SpriteTrail(self,0, Color(230,255,127,100), false, 45, 45, 0.6, 1/(10+1)*0.5, "VJ_Base/sprites/vj_trial1.vmt")

	self:SetMaterial("flood_overlay")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPhysicsCollide(data, phys)
	if !IsValid(data.HitEntity) then
		local spike = ents.Create("prop_dynamic")
		spike:SetModel(self.Model)
		spike:SetPos(data.HitPos + data.HitNormal + self:GetForward()*-5)
		spike:SetAngles(self:GetAngles())
		spike:Spawn()
		spike:SetMaterial("flood_overlay")
		timer.Simple(6,function() if IsValid(spike) then spike:Remove() end end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data, phys)
	for i = 1,2 do
		ParticleEffect("cpt_blood_flood",self:GetPos(),Angle(math.random(0,360),math.random(0,360),math.random(0,360)),nil)
	end
end