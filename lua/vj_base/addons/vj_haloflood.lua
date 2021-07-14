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
local overlayTable = {
	[1] = "models/cpthazama/halo_classic/flood_human_ce_overlay.mdl",
	[2] = "models/cpthazama/halo_classic/flood_human_ce_overlay.mdl",
	[3] = "models/cpthazama/halo3/flood_human_valvebiped.mdl",
}
function ENT:VJ_CreateFloodMerge(type,ent,mdl,skin,bg)
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
	if bg then
		for i = 0,18 do
			body:SetBodygroup(i,bg[i])
		end
	end
	if isNPC then
		ent:SetBonemerge(true)
		ent:SetBonemergeEntity(body)
	end
	ent.Bonemerge = body
end