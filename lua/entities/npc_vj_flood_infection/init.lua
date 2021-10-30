AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/halo3/flood_infection.mdl"}
ENT.StartHealth = 50
ENT.HullType = HULL_TINY
ENT.GibOnDeathDamagesTable = {"All"}
ENT.MaxJumpLegalDistance = VJ_Set(200,400)
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

ENT.HasMeleeAttack = false

ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.AnimTbl_LeapAttack = {ACT_RANGE_ATTACK1} -- Melee Attack Animations
ENT.LeapDistance = 150 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.TimeUntilLeapAttackDamage = 0 -- How much time until it runs the leap damage code?
ENT.NextLeapAttackTime = 1 -- How much time until it can use a leap attack?
ENT.NextAnyAttackTime_Leap = 1 -- How much time until it can use a attack again? | Counted in Seconds
ENT.LeapAttackExtraTimers = {0.2,0.4,0.6,0.8,1}
ENT.StopLeapAttackAfterFirstHit = true -- Should it stop the leap attack from running rest of timers when it hits an enemy?
ENT.LeapAttackVelocityForward = 15 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 200 -- How much upward force should it apply?
ENT.LeapAttackDamage = 10
ENT.LeapAttackDamageDistance = 45 -- How far does the damage go?

ENT.AttackProps = false -- Should it attack props when trying to move?

ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
ENT.FootStepTimeRun = 0.2 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.2 -- Next foot step sound when it is walking

ENT.HasExtraMeleeAttackSounds = true
ENT.GeneralSoundPitch1 = 100

ENT.SoundTbl_FootStep = {"vj_halo3flood/infection/move1.mp3","vj_halo3flood/infection/move2.mp3","vj_halo3flood/infection/move3.mp3","vj_halo3flood/infection/move4.mp3","vj_halo3flood/infection/move5.mp3","vj_halo3flood/infection/move6.mp3","vj_halo3flood/infection/move7.mp3","vj_halo3flood/infection/move8.mp3","vj_halo3flood/infection/move9.mp3"}
ENT.SoundTbl_Idle = {"vj_halo3flood/infection/infector_idle_1.mp3","vj_halo3flood/infection/infector_idle_2.mp3","vj_halo3flood/infection/infector_idle_3.mp3","vj_halo3flood/infection/infector_idle_4.mp3","vj_halo3flood/infection/infector_idle_5.mp3","vj_halo3flood/infection/infector_idle_6.mp3","vj_halo3flood/infection/infector_idle_7.mp3","vj_halo3flood/infection/infector_idle_8.mp3","vj_halo3flood/infection/infector_idle_9.mp3","vj_halo3flood/infection/infector_idle_10.mp3","vj_halo3flood/infection/infector_idle_11.mp3","vj_halo3flood/infection/infector_idle_12.mp3","vj_halo3flood/infection/infector_idle_13.mp3","vj_halo3flood/infection/infector_idle_14.mp3","vj_halo3flood/infection/infector_idle_15.mp3","vj_halo3flood/infection/infector_idle_16.mp3","vj_halo3flood/infection/infector_idle_17.mp3","vj_halo3flood/infection/infector_idle_18.mp3","vj_halo3flood/infection/infector_idle_19.mp3","vj_halo3flood/infection/infector_idle_20.mp3","vj_halo3flood/infection/infector_idle_21.mp3","vj_halo3flood/infection/infector_idle_22.mp3","vj_halo3flood/infection/infector_idle_23.mp3","vj_halo3flood/infection/infector_idle_24.mp3","vj_halo3flood/infection/infector_idle_25.mp3","vj_halo3flood/infection/infector_idle_26.mp3","vj_halo3flood/infection/infector_idle_27.mp3","vj_halo3flood/infection/infector_idle_28.mp3","vj_halo3flood/infection/infector_idle_29.mp3","vj_halo3flood/infection/infector_idle_30.mp3",}
ENT.SoundTbl_Alert = {"vj_halo3flood/infection/infector_idle_1.mp3"}
ENT.SoundTbl_LeapAttackDamage = {
	"vj_halo3flood/infection/infector_bite1.mp3",
	"vj_halo3flood/infection/infector_bite10.mp3",
	"vj_halo3flood/infection/infector_bite11.mp3",
	"vj_halo3flood/infection/infector_bite2.mp3",
	"vj_halo3flood/infection/infector_bite3.mp3",
	"vj_halo3flood/infection/infector_bite4.mp3",
	"vj_halo3flood/infection/infector_bite5.mp3",
	"vj_halo3flood/infection/infector_bite6.mp3",
	"vj_halo3flood/infection/infector_bite7.mp3",
	"vj_halo3flood/infection/infector_bite8.mp3",
	"vj_halo3flood/infection/infector_bite9.mp3",
}
ENT.SoundTbl_Impact = {
	"vj_halo3flood/damage01.mp3",
	"vj_halo3flood/damage02.mp3",
	"vj_halo3flood/damage03.mp3",
}
ENT.SoundTbl_LeapAttack = {"vj_halo3flood/infection/infector_bite1.mp3","vj_halo3flood/infection/infector_bite2.mp3","vj_halo3flood/infection/infector_bite3.mp3","vj_halo3flood/infection/infector_bite4.mp3","vj_halo3flood/infection/infector_bite5.mp3","vj_halo3flood/infection/infector_bite6.mp3","vj_halo3flood/infection/infector_bite7.mp3","vj_halo3flood/infection/infector_bite8.mp3","vj_halo3flood/infection/infector_bite9.mp3","vj_halo3flood/infection/infector_bite10.mp3","vj_halo3flood/infection/infector_bite11.mp3"}
ENT.SoundTbl_Death = {"vj_halo3flood/infection/pop1.mp3","vj_halo3flood/infection/pop2.mp3","vj_halo3flood/infection/pop3.mp3","vj_halo3flood/infection/pop4.mp3","vj_halo3flood/infection/pop5.mp3"}

ENT.MovementState = 0 -- 0 = Normal AI, 1 = Looking for climb spot, 2 = Climbing
ENT.CorpseState = 0 -- 0 = Normal AI, 1 = Moving to corpse, 2 = Infecting corpse
ENT.ClimbSpeed = 8
ENT.ClimbSpot = nil
ENT.LastClimbT = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
	bloodeffect:SetScale(10)
	util.Effect("VJ_Blood1",bloodeffect)
	
	local bloodspray = EffectData()
	bloodspray:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodspray:SetScale(1)
	bloodspray:SetFlags(3)
	bloodspray:SetColor(1)
	util.Effect("bloodspray",bloodspray)
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	
	VJ_EmitSound(self,"vj_halo3flood/explode0" .. math.random(1,2) .. ".mp3",85)
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(10,10,25),Vector(-10,-10,0))
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_JUMP,CAP_MOVE_CLIMB))

	self:ManipulateBoneJiggle(18,1)

	self.SelectedCorpse = nil
	self.NextCorpseLookT = CurTime() +math.Rand(1,3)

	local hookName = "VJ_HaloFloodInfection_Player_" .. self:EntIndex()
	hook.Add("PlayerDeath",hookName,function(victim,inflictor,attacker)
		if !IsValid(self) then
			hook.Remove("PlayerDeath",hookName)
			return
		end
		if inflictor == self then
			VJ_FloodInfection(victim,inflictor,attacker)
		end
	end)

	local hookName = "VJ_HaloFloodInfection_NPC_" .. self:EntIndex()
	hook.Add("OnNPCKilled",hookName,function(victim,inflictor,attacker)
		if !IsValid(self) then
			hook.Remove("OnNPCKilled",hookName)
			return
		end
		if inflictor == self then
			VJ_FloodInfection(victim,inflictor,attacker)
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local ent = self:GetEnemy()
	local dist = IsValid(ent) && self:VJ_GetNearestPointToEntityDistance(ent) or 999999999
	local lastHeight = self:GetPos().z
	local moveState = self.MovementState
	local corpseState = self.CorpseState

	if moveState == 0 then
		local corpse = self.SelectedCorpse
		if !IsValid(corpse) then
			if CurTime() > self.NextCorpseLookT then
				local closeDist = 999999999
				local closeEnt = nil
				for _,v in ipairs(ents.FindByClass("prop_ragdoll")) do
					local dist2 = self:VJ_GetNearestPointToEntityDistance(v)
					if (dist2 < 650 && ((IsValid(ent) && dist2 < dist) or true)) /*&& v.IsVJBaseCorpse*/ && dist2 <= closeDist && self:Visible(v) then
						closeDist = dist2
						closeEnt = v
					end
				end
				if IsValid(closeEnt) then
					self.SelectedCorpse = closeEnt
					self.CorpseState = 1
					self.DisableChasingEnemy = true
				end
				self.NextCorpseLookT = CurTime() +math.Rand(3,6)
			end
		else
			local infectDist = 28
			local distPos = corpse:GetPos()
			distPos.z = lastHeight
			local dist2 = self:GetPos():Distance(distPos)
			if corpseState == 1 then
				self:SetLastPosition(corpse:GetPos() +corpse:OBBCenter())
				self:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH")
				if dist2 <= infectDist then
					self.CorpseState = 2
				end
			elseif corpseState == 2 then
				if self:IsBusy() then return end
				self:VJ_ACT_PLAYACTIVITY(ACT_SPECIAL_ATTACK1,true,false,false,0,{OnFinish=function(interrupted, anim)
					if IsValid(corpse) then
						if dist2 <= infectDist then
							VJ_FloodInfection(corpse,self)
						else
							self.CorpseState = 1
						end
					else
						self.CorpseState = 0
					end
				end})
			end
		end
	end

	if corpseState > 0 then return end

	-- print("-----------------------------------------------")
	if IsValid(ent) then
		local cantReach = ((ent:GetPos().z -lastHeight) > 125) or self:IsUnreachable(ent)
		-- print(self,ent,cantReach,(ent:GetPos().z -lastHeight) > 125)
		if cantReach && self:Visible(ent) then
			if moveState == 0 && CurTime() > self.LastClimbT then
				local climbSpot = VJ_FindVerticleSurface(self,ent)
				if climbSpot then
					self.MovementState = 1
					self.ClimbSpot = climbSpot
				end
			end
		elseif !cantReach && moveState == 1 then
			self.MovementState = 0
			self.ClimbSpot = nil
			self:StopMoving()
			self.DisableChasingEnemy = false
		end
	end

	-- print(self,self.MovementState)

	if self.MovementState < 1 then return end
	local lastTime = CurTime()
	local lastTracePos = nil
	if self.MovementState == 1 && self.ClimbSpot then
		self.DisableChasingEnemy = true
		self:SetLastPosition(self.ClimbSpot)
		self:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH")
		-- VJ_CreateTestObject(self.ClimbSpot,Angle(0,0,0),Color(255,0,0),5)
		if self:GetPos():Distance(self.ClimbSpot) < 50 then
			self.MovementState = 2
			self.AnimTbl_IdleStand = {ACT_CLIMB_UP}
			self.NextIdleStandTime = 0
			self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
			local tr = util.TraceLine({
				start = self:GetPos(),
				endpos = self.ClimbSpot,
				filter = self,
				mask = MASK_SOLID_BRUSHONLY
			})
			self:SetAngles((tr.HitPos -self:GetPos()):Angle())
			self:SetPos(self:GetPos() +self:GetForward() *(self:GetPos():Distance(self.ClimbSpot) -10))
		end
	elseif self.MovementState == 2 then
		local isDone, lastTracePos = VJ_FloodTravelUnique(self)
		if isDone then
			self:StopMoving()
			self:SetLocalVelocity(Vector(0,0,0))
			self.MovementState = 0
			self.ClimbSpot = nil
			self.DisableChasingEnemy = false
			self:SetMoveType(MOVETYPE_STEP)
			self.AnimTbl_IdleStand = {ACT_IDLE}
			self.NextIdleStandTime = 0
			self:SetState()
			self:ForceMoveJump((lastTracePos -self:GetPos()):GetNormal() *200 +Vector(0,0,150))
			self.LastClimbT = CurTime() +5
		end
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/