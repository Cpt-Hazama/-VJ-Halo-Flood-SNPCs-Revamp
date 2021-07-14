if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
/*--------------------------------------------------
	*** Copyright (c) 2012-2020 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
-- Based off of the GMod lasertracer
EFFECT.MainMat = Material("effects/h3_beam")
EFFECT.FrontMat = Material("sprites/glow04_noz")

EFFECT.Speed 					= 10000
EFFECT.DynamicLightColor		= Color(150,20,250,255)
EFFECT.DynamicLightBrightness	= 2
EFFECT.DynamicLightSize			= 150

function EFFECT:Init(data)
	self.StartPos = data:GetStart()
	self.EndPos = data:GetOrigin()
	local ent = data:GetEntity()
	local att = data:GetAttachment()

	if ( IsValid( ent ) && att > 0 ) then
		if (ent.Owner == LocalPlayer() && !LocalPlayer():GetViewModel() != LocalPlayer()) then ent = ent.Owner:GetViewModel() end
		att = ent:GetAttachment(att)
		if (att) then
			self.StartPos = att.Pos
		end
	end
	self.StartTime = 0
	self.Dir = self.EndPos - self.StartPos
	self.Normal = self.Dir:GetNormal()
	self:SetRenderBoundsWS(self.StartPos, self.EndPos)
	self.TracerTime = math.min(1, self.StartPos:Distance(self.EndPos) / 30000) -- Calculate death time
	self.Length = 0.1

	local Emitter = ParticleEmitter(self.StartPos)
	for i = 1,2 do
		local size = math.random(15,18)
		local particle = Emitter:Add("particle/particle_glow_02",self.StartPos)
		particle:SetVelocity(self.Dir:Angle():Forward() *500)
		particle:SetDieTime(math.Rand(0.045,0.065))
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(size)
		particle:SetEndSize(3)
		particle:SetColor(150,20,250)
		particle:SetAirResistance(160)
	end
	Emitter:Finish()

	self.DieTime = CurTime() +self.TracerTime
end
---------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Think()
	-- self.TracerTime = self.TracerTime -FrameTime()
	self.StartTime = self.StartTime +FrameTime()
	if (CurTime() > self.DieTime) then -- If it's dead then...
		util.Decal("fadingscorch", self.EndPos +self.Dir:GetNormalized(), self.EndPos -self.Dir:GetNormalized())

		local Emitter = ParticleEmitter(self.EndPos)
		for i = 1,math.random(5,15) do
			local particle = Emitter:Add("effects/hce_spark_purple",self.EndPos)
			particle:SetVelocity(VectorRand() *math.Rand(100,350))
			particle:SetDieTime(math.Rand(0.25,0.8))
			particle:SetStartAlpha(200)
			particle:SetEndAlpha(0)
			particle:SetStartSize(1)
			particle:SetEndSize(3)
			particle:SetRoll(math.random(0,360))
			particle:SetGravity(Vector(math.random(-300,300),math.random(-300,300),math.random(-300,-700)))
			particle:SetCollide(true)
			particle:SetBounce(0.9)
			particle:SetAirResistance(120)
			particle:SetStartLength(0)
			particle:SetEndLength(0.1)
			particle:SetVelocityScale(true)
			particle:SetCollide(true)
			particle:SetColor(150,20,250)
		end
		for i = 1,2 do
			local size = math.random(10,12)
			local particle = Emitter:Add("particle/particle_glow_04",self.EndPos)
			particle:SetVelocity(VectorRand() *math.Rand(50,100))
			particle:SetDieTime(math.Rand(0.08,0.1))
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(size)
			particle:SetEndSize(0)
			particle:SetColor(150,20,250)
			particle:SetAirResistance(160)
		end
		Emitter:Finish()
		return false
	end
	
	local dLight = DynamicLight(self:EntIndex())
	local endPos = self.StartPos +self.Normal *(self.Speed *self.StartTime)
	if dLight then
		dLight.r = self.DynamicLightColor.r
		dLight.g = self.DynamicLightColor.g
		dLight.b = self.DynamicLightColor.b
		dLight.Pos = endPos
		dLight.Brightness = self.DynamicLightBrightness
		dLight.Decay = 1000
		dLight.Size = self.DynamicLightSize
		dLight.DieTime = CurTime() +3
		dLight.Style = 6
	end
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Render()
	local fDelta = (self.DieTime -CurTime()) /self.TracerTime
	fDelta = math.Clamp(fDelta,0,1) ^0.5
	render.SetMaterial(self.MainMat)
	local sinWave = math.sin(fDelta *math.pi)
	local pos = self.StartPos
	local endPos = self.EndPos -self.Dir *(fDelta +sinWave *self.Length)
	local width = 10 +sinWave *3
	local startCord = 1
	local endCord = 0
	local col = Color(150,20,250,255)
	render.DrawBeam(pos,endPos,width,startCord,endCord,col)

	render.SetMaterial(self.FrontMat)
	local EyeNormal = (EyePos() -pos):GetNormal()
	EyeNormal:Mul(self.Length /2)
	EyeNormal.z = 0
	render.DrawQuadEasy(pos,EyeNormal,width /2,width /2,col,(CurTime() *50) %360)
end
/*--------------------------------------------------
	*** Copyright (c) 2012-2020 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
