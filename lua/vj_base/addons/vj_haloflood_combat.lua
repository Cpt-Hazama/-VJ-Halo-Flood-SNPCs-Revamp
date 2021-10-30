/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.VJ_IsFloodCombatForm = true

ENT.HasHealthRegeneration = true
ENT.HealthRegenerationAmount = 1
ENT.HealthRegenerationDelay = VJ_Set(5,5)

ENT.SoundTbl_MeleeAttackExtra = {
	"vj_halo3flood/shared/melee_swish1.wav",
	"vj_halo3flood/shared/melee_swish3.wav",
	"vj_halo3flood/shared/melee_swish5.wav",
	"vj_halo3flood/shared/melee_swish6.wav",
	"vj_halo3flood/shared/melee_swish7.wav",
	"vj_halo3flood/shared/melee_swish8.wav",
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

ENT.MaxJumpLegalDistance = VJ_Set(1800,2000)

ENT.MeleeAttackAngleRadius = 180
ENT.MeleeAttackDamageAngleRadius = 110
ENT.PropAP_MaxSize = 2.5

ENT.ConstantlyFaceEnemy_IfVisible = true
ENT.ConstantlyFaceEnemy_IfAttacking = false
ENT.ConstantlyFaceEnemy_Postures = "Both"

ENT.RevivalChance = 4
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.Default_AnimTbl_MeleeAttack = self.AnimTbl_MeleeAttack

	if self.OnInit then
		if self:OnInit() == false then return end
	end

	local defWeapon = GetConVar("gmod_npcweapon"):GetString()
	if defWeapon != "" then
		self:Give(defWeapon)
	end

	self.AnimationSet = 0 -- 0 = Not set, 1 = Default, 2 = Weapon, 3 = Walking (1), 4 = Walking (2)
	self.CanRevive = true

	self.DoWalkT = 0
	self.NextWalkT = 0
	self.IsWalking = false
	self.CanChaseWeapon = false
	self.ChaseWeapon = nil
	self.NextWepCheckT = 0

	self.LastWeaponClass = nil

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
function ENT:CustomOnThink()
	local wep = self:GetActiveWeapon()
	local ent = self:GetEnemy()
	local dist = IsValid(ent) && self:VJ_GetNearestPointToEntityDistance(ent) or 999999999

	if self.OnThink then
		if self:OnThink(wep,ent,dist) == false then return end
	end

	local set = self.AnimationSet
	self.IsWalking = self.DoWalkT > CurTime()
	if IsValid(ent) && CurTime() > self.NextWalkT && dist > 500 && math.random(1,50) == 1 then
		local t = CurTime() +math.Rand(5,15)
		self.DoWalkT = t
		self.NextWalkT = t +math.Rand(5,15)
	end
	self.ConstantlyFaceEnemy = IsValid(wep)
	if IsValid(wep) then
		if self.LastWeaponClass != wep:GetClass() then
			self.LastWeaponClass = wep:GetClass()
			self.ConstantlyFaceEnemyDistance = wep.NPC_FiringDistanceMax or 5000
			wep.InfiniteAmmo = GetConVar("vj_halo_infiniteammo"):GetBool()
		end

		if wep.InfiniteAmmo then
			wep:SetClip1(99999)
		end

		// Useless code, ig at some point Vrej decided to make weapons shoot regardless of any MUCH NEEDED enemy parameters -_-
		-- if dist <= wep.NPC_FiringDistanceMax && dist > self.MeleeAttackDistance && !self:IsBusy() && ent:Visible(self) && (self:GetForward():Dot((ent:GetPos() -self:GetPos()):GetNormalized()) > math.cos(math.rad(self.MeleeAttackAngleRadius -15))) then
		-- 	self.DoingWeaponAttack = true
		-- else
		-- 	self.DoingWeaponAttack = false
		-- end
		if wep:Clip1() <= 0 then
			local dat = wep:GetBonePosition(1) or wep:GetPos()
			local ent = ents.Create("prop_physics")
			ent:SetModel(wep:GetModel())
			ent:SetPos(dat)
			ent:SetAngles(wep:GetAngles())
			ent:Spawn()
			ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			local phys = ent:GetPhysicsObject()
			if IsValid(phys) then
				phys:ApplyForceCenter(VectorRand() *50)
			end
			wep:Remove()
			SafeRemoveEntityDelayed(ent,25)
		end
		if self.IsWalking then
			if set != 4 then
				self.NextIdleStandTime = 0
				self.AnimTbl_IdleStand = {ACT_IDLE_STIMULATED}
				self.AnimTbl_Walk = {ACT_WALK_STIMULATED}
				self.AnimTbl_Run = {ACT_WALK_STIMULATED}
				self.AnimationSet = 4
			end
			return
		end
		if set != 2 then
			self.NextIdleStandTime = 0
			self.AnimTbl_IdleStand = {ACT_IDLE_STIMULATED}
			self.AnimTbl_Walk = {ACT_WALK_STIMULATED}
			self.AnimTbl_Run = {ACT_RUN_STIMULATED}
			self.AnimationSet = 2
		end
	else
		if self.IsWalking then
			if set != 3 then
				self.NextIdleStandTime = 0
				self.AnimTbl_IdleStand = {ACT_IDLE_STIMULATED}
				self.AnimTbl_Walk = {ACT_WALK}
				self.AnimTbl_Run = {ACT_WALK}
				self.AnimationSet = 3
			end
			return
		end
		if !self.CanChaseWeapon && CurTime() > self.NextWepCheckT then
			for _,v in ipairs(ents.FindInSphere(self:GetPos(),450)) do
				if IsValid(v) && v.IsVJBaseWeapon && !IsValid(v:GetOwner()) then
					self.CanChaseWeapon = true
					self.ChaseWeapon = v
					break
				end
			end
			self.NextWepCheckT = CurTime() +5
		end
		if self.CanChaseWeapon then
			self.DisableChasingEnemy = true
			local chaseWep = self.ChaseWeapon
			if !IsValid(chaseWep) then
				self.CanChaseWeapon = false
				self.ChaseWeapon = NULL
				self.DisableChasingEnemy = false
				return
			else
				if IsValid(chaseWep:GetOwner()) then
					self.CanChaseWeapon = false
					self.ChaseWeapon = NULL
					self.DisableChasingEnemy = false
					return
				end
			end
			self:SetLastPosition(chaseWep:GetPos())
			self:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH")
			if self:GetPos():Distance(chaseWep:GetPos()) <= 70 then
				self:Give(chaseWep:GetClass())
				chaseWep:Remove()
				self.CanChaseWeapon = false
				self.DisableChasingEnemy = false
			end
		end
		if set != 1 then
			self.NextIdleStandTime = 0
			self.AnimTbl_IdleStand = {ACT_IDLE}
			self.AnimTbl_Walk = {ACT_WALK}
			self.AnimTbl_Run = {ACT_RUN}
			self.AnimationSet = 1
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_BeforeStartTimer()
	local ene = self:GetEnemy()
	if !IsValid(ene) then return end

	if !(self:GetForward():Dot((ene:GetPos() -self:GetPos()):GetNormalized()) > math.cos(math.rad(100))) then
		self.AnimTbl_MeleeAttack = {ACT_GESTURE_MELEE_ATTACK1}
	else
		self.AnimTbl_MeleeAttack = self.Default_AnimTbl_MeleeAttack
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnChangeActivity(newAct)
	if newAct == ACT_LAND then
		VJ_CreateStepSound(self,32,self.SoundTbl_FootStep,true)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetCamo(set)
	if set then
		self:SetMaterial("models/cpthazama/halo3/cloak")
		self.VJ_NoTarget = true
		self:DrawShadow(false)
		if IsValid(self:GetActiveWeapon()) then
			self:GetActiveWeapon():DrawShadow(false)
			self:GetActiveWeapon():SetMaterial("models/cpthazama/halo3/cloak")
		end
		for _, x in ipairs(ents.GetAll()) do
			if (x:GetClass() != self:GetClass() && x:GetClass() != "npc_grenade_frag") && x:IsNPC() && self:Visible(x) then
				x:AddEntityRelationship(self,D_NU,99)
				if x.IsVJBaseSNPC == true then
					x.MyEnemy = NULL
					x:SetEnemy(NULL)
					x:ClearEnemyMemory()
				end
				if VJ_HasValue(self.NPCTbl_Combine,x:GetClass()) or VJ_HasValue(self.NPCTbl_Resistance,x:GetClass()) then
					x:VJ_SetSchedule(SCHED_RUN_RANDOM)
					x:SetEnemy(NULL)
					x:ClearEnemyMemory()
				end
			end
		end
	else
		self:SetMaterial(" ")
		self.VJ_NoTarget = false
		self:DrawShadow(true)
		if IsValid(self:GetActiveWeapon()) then
			self:GetActiveWeapon():DrawShadow(true)
			self:GetActiveWeapon():SetMaterial(" ")
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if self.OnDamaged then
		if self:OnDamaged(dmginfo, hitgroup) == false then return end
	end

	self.NextWalkT = CurTime() +math.Rand(5,15)
	self.DoWalkT = 0
end
---------------------------------------------------------------------------------------------------------------------------------------------
local gib_mdlAAll = {"models/gibs/xenians/sgib_01.mdl","models/gibs/xenians/sgib_02.mdl","models/gibs/xenians/sgib_03.mdl","models/gibs/xenians/mgib_01.mdl","models/gibs/xenians/mgib_02.mdl","models/gibs/xenians/mgib_03.mdl","models/gibs/xenians/mgib_04.mdl","models/gibs/xenians/mgib_05.mdl","models/gibs/xenians/mgib_06.mdl","models/gibs/xenians/mgib_07.mdl"}
local gib_mdlASmall = {"models/gibs/xenians/sgib_01.mdl","models/gibs/xenians/sgib_02.mdl","models/gibs/xenians/sgib_03.mdl"}
local gib_mdlABig = {"models/gibs/xenians/mgib_01.mdl","models/gibs/xenians/mgib_02.mdl","models/gibs/xenians/mgib_03.mdl","models/gibs/xenians/mgib_04.mdl","models/gibs/xenians/mgib_05.mdl","models/gibs/xenians/mgib_06.mdl","models/gibs/xenians/mgib_07.mdl"}
local gib_mdlHSmall = {"models/gibs/humans/sgib_01.mdl","models/gibs/humans/sgib_02.mdl","models/gibs/humans/sgib_03.mdl"}
local gib_mdlHBig = {"models/gibs/humans/mgib_01.mdl","models/gibs/humans/mgib_02.mdl","models/gibs/humans/mgib_03.mdl","models/gibs/humans/mgib_04.mdl","models/gibs/humans/mgib_05.mdl","models/gibs/humans/mgib_06.mdl","models/gibs/humans/mgib_07.mdl"}
--
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
	GetCorpse.IsFloodModel = true

	local wep = self:GetActiveWeapon()
	if IsValid(wep) then
		local ent = ents.Create(wep:GetClass())
		ent:SetPos(wep:GetPos())
		ent:SetAngles(wep:GetAngles())
		ent:Spawn()
		ent:SetClip1(wep:Clip1())
		wep:Remove()
	end

	local maxHP = self:GetMaxHealth()

	if self.CanRevive && math.random(1,self.RevivalChance) == 1 then
	-- if self.CanRevive then
		timer.Simple(math.random(8,30),function()
		-- timer.Simple(2,function()
			if IsValid(GetCorpse) && !GetCorpse.Dead then
				local flood = ents.Create(GetCorpse.FloodClass)
				flood:SetPos(GetCorpse:GetPos())
				flood:SetAngles(GetCorpse:GetAngles())
				flood.Skin = GetCorpse:GetSkin()
				flood:Spawn()
				undo.ReplaceEntity(self,flood)
				flood:SetHealth(GetCorpse.BodyHealthMax *(GetCorpse.BodyHealth /GetCorpse.BodyHealthMax))
				if GetCorpse:IsOnFire() then flood:Ignite(5) end
				flood.CanRevive = false
				timer.Simple(0,function()
					if IsValid(flood) then
						flood:VJ_ACT_PLAYACTIVITY(ACT_ROLL_LEFT,true,false,false)
						SafeRemoveEntity(GetCorpse)
					end
				end)
			end
		end)
	end

	GetCorpse.BloodEffect = self.CustomBlood_Particle
	GetCorpse.BodyHealth = maxHP *2.5
	GetCorpse.BodyHealthMax = maxHP *2.5
	GetCorpse.FloodClass = self:GetClass()
	GetCorpse.Dead = false
	GetCorpse.CanRevive = self.CanRevive
	GetCorpse.DeathSound = self.SoundTbl_Death
	GetCorpse.CreateGibEntity = function(cringe, cringe2, models, extraOptions, customFunc)
		// self:CreateGibEntity("prop_ragdoll", "", {Pos=self:LocalToWorld(Vector(0,3,0)), Ang=self:GetAngles(), Vel=})
		local bloodType = "Red"
		class = class or "obj_vj_gib"
		if models == "UseAlien_Small" then
			models =  VJ_PICK(gib_mdlASmall)
			bloodType = "Yellow"
		elseif models == "UseAlien_Big" then
			models =  VJ_PICK(gib_mdlABig)
			bloodType = "Yellow"
		elseif models == "UseHuman_Small" then
			models =  VJ_PICK(gib_mdlHSmall)
		elseif models == "UseHuman_Big" then
			models =  VJ_PICK(gib_mdlHBig)
		else -- Custom models
			models = VJ_PICK(models)
			if VJ_HasValue(gib_mdlAAll, models) then
				bloodType = "Yellow"
			end
		end
		extraOptions = extraOptions or {}
			local vel = extraOptions.Vel or Vector(math.Rand(-100, 100), math.Rand(-100, 100), math.Rand(150, 250))
			if self.SavedDmgInfo then
				local dmgForce = self.SavedDmgInfo.force / 70
				if extraOptions.Vel_ApplyDmgForce != false && extraOptions.Vel != "UseDamageForce" then -- Use both damage force AND given velocity
					vel = vel + dmgForce
				elseif extraOptions.Vel == "UseDamageForce" then -- Use damage force
					vel = dmgForce
				end
			end
			bloodType = extraOptions.BloodType or bloodType -- Certain entities such as the VJ Gib entity, you can use this to set its gib type
			local removeOnCorpseDelete = extraOptions.RemoveOnCorpseDelete or false -- Should the entity get removed if the corpse is removed?
		local gib = ents.Create("obj_vj_gib")
		gib:SetModel(models)
		gib:SetPos(extraOptions.Pos or (self:GetPos() + self:OBBCenter()))
		gib:SetAngles(extraOptions.Ang or Angle(math.Rand(-180, 180), math.Rand(-180, 180), math.Rand(-180, 180)))
		if gib:GetClass() == "obj_vj_gib" then
			gib.BloodType = bloodType
			gib.Collide_Decal = extraOptions.BloodDecal or "Default"
			gib.CollideSound = extraOptions.CollideSound or "Default"
		end
		gib:Spawn()
		gib:Activate()
		gib.IsVJBase_Gib = true
		gib.RemoveOnCorpseDelete = removeOnCorpseDelete
		if GetConVar("vj_npc_gibcollidable"):GetInt() == 0 then gib:SetCollisionGroup(1) end
		local phys = gib:GetPhysicsObject()
		if IsValid(phys) then
			phys:AddVelocity(vel)
			phys:AddAngleVelocity(extraOptions.AngVel or Vector(math.Rand(-200, 200), math.Rand(-200, 200), math.Rand(-200, 200)))
		end
		if extraOptions.NoFade != true && GetConVar("vj_npc_fadegibs"):GetInt() == 1 then
			if gib:GetClass() == "obj_vj_gib" then timer.Simple(GetConVar("vj_npc_fadegibstime"):GetInt(), function() SafeRemoveEntity(gib) end)
			elseif gib:GetClass() == "prop_ragdoll" then gib:Fire("FadeAndRemove", "", GetConVar("vj_npc_fadegibstime"):GetInt())
			elseif gib:GetClass() == "prop_physics" then gib:Fire("kill", "", GetConVar("vj_npc_fadegibstime"):GetInt()) end
		end
		if removeOnCorpseDelete == true then //self.Corpse:DeleteOnRemove(extraent)
			self.ExtraCorpsesToRemove_Transition[#self.ExtraCorpsesToRemove_Transition + 1] = gib
		end
		if (customFunc) then customFunc(gib) end
	end

	local hookName = "VJ_HaloFlood_CorpseBlood_" .. GetCorpse:EntIndex()
	hook.Add("EntityTakeDamage",hookName,function(ent,dmginfo)
		if !IsValid(GetCorpse) then
			hook.Remove("EntityTakeDamage",hookName)
			return
		end
		if ent == GetCorpse then
			local attacker = dmginfo:GetAttacker()
			GetCorpse.BodyHealth = GetCorpse.BodyHealth -dmginfo:GetDamage()
			if GetCorpse.BodyHealth <= 0 then
				GetCorpse.Dead = true
				if GetCorpse.CanRevive then
					local snd = VJ_PICK(GetCorpse.DeathSound)
					if snd != false then
						GetCorpse:EmitSound(snd)
					end
				end

				local gibMaxs = GetCorpse:OBBMaxs()
				local gibMins = GetCorpse:OBBMins()
				local centerPos = GetCorpse:GetPos() +GetCorpse:OBBCenter()
				for i = 1,5 do
					GetCorpse:CreateGibEntity(GetCorpse,"UseAlien_Small",{Pos=centerPos + Vector(math.random(gibMins.x, gibMaxs.x), math.random(gibMins.y, gibMaxs.y), 10)})
				end
				for i = 1,3 do
					GetCorpse:CreateGibEntity(GetCorpse,"UseAlien_Big",{Pos=centerPos + Vector(math.random(gibMins.x, gibMaxs.x), math.random(gibMins.y, gibMaxs.y), 10)})
				end

				local bloodeffect = EffectData()
				bloodeffect:SetOrigin(GetCorpse:GetPos() +GetCorpse:OBBCenter())
				bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
				bloodeffect:SetScale(120)
				util.Effect("VJ_Blood1",bloodeffect)
				
				local bloodspray = EffectData()
				bloodspray:SetOrigin(GetCorpse:GetPos() +GetCorpse:OBBCenter())
				bloodspray:SetScale(8)
				bloodspray:SetFlags(3)
				bloodspray:SetColor(1)
				util.Effect("bloodspray",bloodspray)
				VJ_EmitSound(GetCorpse,"vj_halo3flood/explode0" .. math.random(1,2) .. ".mp3",85)

				GetCorpse:Remove()
			end
			if GetCorpse.BloodEffect then
				for _,i in ipairs(GetCorpse.BloodEffect) do
					sound.Play("vj_halo3flood/damage0"..math.random(1,3)..".mp3",dmginfo:GetDamagePosition(),60,100)
					ParticleEffect(i,dmginfo:GetDamagePosition(),Angle(math.random(0,360),math.random(0,360),math.random(0,360)),nil)
				end
			end
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
	bloodeffect:SetScale(120)
	util.Effect("VJ_Blood1",bloodeffect)
	
	local bloodspray = EffectData()
	bloodspray:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodspray:SetScale(8)
	bloodspray:SetFlags(3)
	bloodspray:SetColor(1)
	util.Effect("bloodspray",bloodspray)
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	
	VJ_EmitSound(self,"vj_halo3flood/explode0" .. math.random(1,2) .. ".mp3",85)
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
print("\nSuccessfully loaded Combat Form AI!")