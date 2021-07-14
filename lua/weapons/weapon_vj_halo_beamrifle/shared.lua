if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "Beam Rifle"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base"
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.MadeForNPCsOnly 			= true -- Is tihs weapon meant to be for NPCs only?
SWEP.WorldModel					= "models/cpthazama/halo3/weapons/beam_rifle.mdl"
SWEP.AnimationType 				= "Pistol"
SWEP.HoldType 					= "ar2"
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_NextPrimaryFire 		= 1 -- Next time it can use primary fire
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_CustomSpread	 		= 0.15
SWEP.NPC_TimeUntilFireExtraTimers = {} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
	-- World Model ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel_UseCustomPosition = true -- Should the gun use custom position? This can be used to fix guns that are in the crotch
SWEP.WorldModel_CustomPositionAngle = Vector(0,5,0)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1,8,2)
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 20 -- Damage
SWEP.Primary.Force				= 5 -- Force applied on the object the bullet hits
SWEP.Primary.ClipSize			= 3 -- Max amount of bullets per clip
SWEP.Primary.Ammo				= "AR2" -- Ammo type
SWEP.Primary.Sound = {
	"vj_halo3flood/weapons/beam_rifle_fire1.wav",
	"vj_halo3flood/weapons/beam_rifle_fire2.wav",
	"vj_halo3flood/weapons/beam_rifle_fire3.wav",
}
SWEP.Primary.DistantSound = {
	"vj_halo3flood/weapons/beam_rifle_lod_far1.wav",
	"vj_halo3flood/weapons/beam_rifle_lod_far2.wav",
	"vj_halo3flood/weapons/beam_rifle_lod_far3.wav",
}
SWEP.Primary.TracerType			= "VJ_Halo3_Beam"
SWEP.PrimaryEffects_MuzzleAttachment = "muzzle"
SWEP.PrimaryEffects_MuzzleFlash = false
SWEP.PrimaryEffects_SpawnShells = false
SWEP.PrimaryEffects_DynamicLightColor = Color(150,125,200)