/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/

local ENT = FindMetaTable("Entity")
local NPC = FindMetaTable("NPC")
local SWEP = FindMetaTable("Weapon")
local PLY = FindMetaTable("Player")
---------------------------------------------------------------------------------------------------------------------------------------------
function VJ_FloodInfection(ent,inflictor,attacker)
	local isRagdoll = !(ent:IsNPC() or ent:IsPlayer())

	local flood = ents.Create("npc_vj_flood_combat")
	flood:SetPos(ent:GetPos())
	flood:SetAngles(ent:GetAngles())
	flood:Spawn()

	local wep = !isRagdoll && ent:GetActiveWeapon()
	if IsValid(wep) && wep.IsVJBaseWeapon then
		flood:Give(wep:GetClass())
	end

	local foundBone = (ent:LookupBone("ValveBiped.Bip01_Pelvis") != nil)
	if foundBone then
		VJ_CreateFloodMerge(3,flood,ent:GetModel(),ent:GetSkin(),ent)
		flood.GibOnDeathDamagesTable = {"All"}
	end

	if isRagdoll then
		timer.Simple(0,function()
			if IsValid(flood) then
				flood:VJ_ACT_PLAYACTIVITY(ACT_ROLL_RIGHT,true,false,false,0,{OnFinish=function(interrupted, anim)
					flood:VJ_ACT_PLAYACTIVITY(ACT_ROLL_LEFT,true,false,false)
				end})
			end
		end)
	else
		timer.Simple(0,function()
			if IsValid(flood) then
				flood:VJ_ACT_PLAYACTIVITY(ACT_ROLL_LEFT,true,false,false)
			end
		end)
	end

	undo.ReplaceEntity(ent,flood)
	SafeRemoveEntity(inflictor)
	SafeRemoveEntity(ent)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local overlayTable = {
	[1] = "models/cpthazama/halo_classic/flood_human_ce_overlay.mdl",
	[2] = "models/cpthazama/halo_classic/flood_human_ce_overlay.mdl",
	[3] = "models/cpthazama/halo3/flood_human_valvebiped.mdl",
}
function VJ_CreateFloodMerge(type,ent,mdl,skin,bgEnt)
	local isNPC = ent:IsNPC()
	if isNPC then
		local cBounds = ent:GetCollisionBounds()
		ent:SetModel(overlayTable[type] or "models/cpthazama/halo3/flood_human_valvebiped.mdl")
		ent:SetCollisionBounds(Vector(cBounds.x,cBounds.y,cBounds.z),Vector(-cBounds.x,-cBounds.y,0))
	end
	local body = ents.Create("prop_vj_animatable")
	body:SetModel(mdl)
	body:SetPos(ent:GetPos())
	body:SetAngles(ent:GetAngles())
	body.VJ_Owner = ent
	function body:Initialize()
		self:AddEffects(EF_BONEMERGE)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetOwner(self.VJ_Owner)
	end
	body:Spawn()
	body:SetParent(ent)
	body:SetSkin(skin)
	if IsValid(bgEnt) then
		for i = 0,18 do
			body:SetBodygroup(i,bgEnt:GetBodygroup(i))
		end
	end
	-- if isNPC then
	-- 	ent:SetBonemerge(true)
	-- 	ent:SetBonemergeEntity(body)
	-- end
	ent.Bonemerge = body
end