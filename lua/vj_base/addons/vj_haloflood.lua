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
function VJ_FloodTravelUnique(self,speed,targetPos)
	local lastTime = CurTime()
	local lastTracePos = self:GetPos()
	local reachedGoal = false
	speed = speed or self.ClimbSpeed

	self:StopMoving()
	self:SetVelocity(Vector(0,0,2))
	self:SetMoveType(MOVETYPE_FLY)
	self:SetGroundEntity(NULL)

	local startPos = self:GetPos() +Vector(0,0,(speed *self:GetModelScale() *(CurTime() -lastTime)))
	local tr = util.TraceHull({
		start = startPos,
		endpos = targetPos or (startPos +self:GetForward() *50),
		filter = self,
		mask = MASK_SOLID_BRUSHONLY,
		mins = Vector(-8,-8,-8),
		maxs = Vector(8,8,8),
	})

	local setAngs = self:GetFaceAngle((tr.HitPos -self:GetPos()):Angle())
	self:SetIdealYawAndUpdate(setAngs.y)
	self:SetVelocity((self:GetPos() -(startPos)):GetNormalized() *speed)
	-- VJ_CreateTestObject(startPos,Angle(0,0,0),Color(25,0,255),5)
	-- VJ_CreateTestObject(tr.HitPos,Angle(0,0,0),Color(255,0,0),5)
	-- VJ_CreateTestObject(tr.HitPos +tr.HitNormal *8,Angle(0,0,0),Color(0,255,34),5)

	local startPos = self:GetPos() +self:GetUp() *10
	local tr2 = util.TraceHull({
		start = startPos,
		endpos = startPos +self:GetForward() *100,
		filter = self,
		mask = MASK_SOLID_BRUSHONLY,
		mins = Vector(-8,-8,-8),
		maxs = Vector(8,8,8),
	})

	lastTracePos = tr2.HitPos
	if !tr2.Hit or tr2.HitSky then
		reachedGoal = true
	end

	return reachedGoal, lastTracePos
end
---------------------------------------------------------------------------------------------------------------------------------------------
function VJ_FindVerticleSurface(self,ent)
	local startPos = self:GetPos() +Vector(0,0,100)
	local targetPos = ent:GetPos()
	targetPos.z = startPos.z
	local tr = util.TraceHull({
		start = startPos,
		endpos = targetPos,
		filter = self,
		mask = MASK_SOLID_BRUSHONLY,
		mins = Vector(-8,-8,-8),
		maxs = Vector(8,8,8),
	})
	-- util.ParticleTracerEx("vortigaunt_beam", startPos, targetPos, false, self:EntIndex(), 0)
	-- util.ParticleTracerEx("Weapon_Combine_Ion_Cannon_Beam", tr.StartPos, tr.HitPos, false, self:EntIndex(), 0)
	-- VJ_CreateTestObject(tr.HitPos,Angle(0,0,0),Color(255,0,200),5)
	if tr.Hit then
		local tr2 = util.TraceHull({
			start = tr.HitPos,
			endpos = tr.HitPos +Vector(0,0,-10000),
			filter = self,
			mask = MASK_SOLID_BRUSHONLY,
			mins = Vector(-8,-8,-8),
			maxs = Vector(8,8,8),
		})
		local tr3 = util.TraceHull({
			start = tr2.HitPos,
			endpos = tr2.HitPos +Vector(0,0,(tr2.HitPos:Distance(tr.HitPos)) *1.1),
			filter = self,
			mask = MASK_SOLID_BRUSHONLY,
			mins = Vector(-8,-8,-8),
			maxs = Vector(8,8,8),
		})
		-- util.ParticleTracerEx("Weapon_Combine_Ion_Cannon_Beam", tr2.StartPos, tr3.HitPos, false, self:EntIndex(), 0)
		-- util.ParticleTracerEx("Weapon_Combine_Ion_Cannon_Beam", tr2.StartPos, tr3.HitPos, false, self:EntIndex(), 0)
		-- VJ_CreateTestObject(tr2.HitPos,Angle(0,0,0),Color(0,225,255),5)
		-- VJ_CreateTestObject(tr3.HitPos,Angle(0,0,0),Color(229,255,0),5)
		-- print("Dist",(tr2.HitPos:Distance(tr.HitPos)) *1.1,"Hit",tr3.Hit)
		if !tr3.Hit then
			return tr2.HitPos
		end
	end
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
local translationClass = {
	["npc_vj_hcf_infection"] = {Human="npc_vj_hcf_human",Elite="npc_vj_hcf_elite"}, -- Halo 1
	["npc_vj_hcf_infection2"] = {Human="npc_vj_hcf_human2",Elite="npc_vj_hcf_elite2"}, -- Halo 2
	["npc_vj_flood_infection"] = {Human="npc_vj_flood_combat",Brute="npc_vj_flood_combat_brute",Elite="npc_vj_flood_combat_elite"}, -- Halo 3
	["npc_vj_hwf_infection"] = {Human="npc_vj_hwf_combat",Brute="npc_vj_hwf_combat_brute",Elite="npc_vj_hwf_combat_elite"} -- Halo Wars
}
--
function VJ_FloodInfection(ent,inflictor,attacker)
	local isRagdoll = !(ent:IsNPC() or ent:IsPlayer())
	local isFlood = isRagdoll && ent.IsFloodModel

	local classData = translationClass[inflictor:GetClass()]
	local spawnClass = classData.Human
	if isRagdoll && ent.FloodClass then
		for k,v in pairs(classData) do
			if ent.FloodClass == v then
				spawnClass = v
				break
			end
		end
	end

	local ang = ent:GetAngles()
	if isRagdoll then
		local bonePos, boneAng = ent:GetBonePosition(0)
		ang = Angle(ang.x,boneAng.y,ang.z)
	end
	local flood = ents.Create(spawnClass)
	flood:SetPos(ent:GetPos())
	flood:SetAngles(ang)
	flood:Spawn()
	if isFlood then
		flood:SetSkin(ent:GetSkin())
	end

	local wep = !isRagdoll && ent:GetActiveWeapon()
	if IsValid(wep) && wep.IsVJBaseWeapon then
		flood:Give(wep:GetClass())
	end

	ent.HasDeathRagdoll = false

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
	[4] = "models/cpthazama/halo_classic/flood_human_ce_overlay.mdl",
}
function VJ_CreateFloodMerge(type,ent,mdl,skin,bgEnt)
	local isNPC = ent:IsNPC()
	if isNPC then
		local cBounds = select(2,ent:GetCollisionBounds())
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