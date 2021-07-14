if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "Type-51 Carbine"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base"
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.MadeForNPCsOnly 			= true -- Is tihs weapon meant to be for NPCs only?
SWEP.WorldModel					= "models/cpthazama/halo3/weapons/carbine.mdl"
SWEP.AnimationType 				= "Pistol"
SWEP.HoldType 					= "ar2"
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_NextPrimaryFire 		= 0.5 -- Next time it can use primary fire
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_CustomSpread	 		= 0.25
SWEP.NPC_TimeUntilFireExtraTimers = {} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
	-- World Model ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel_UseCustomPosition = true -- Should the gun use custom position? This can be used to fix guns that are in the crotch
SWEP.WorldModel_CustomPositionAngle = Vector(0,7,0)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1,9,1)
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 10 -- Damage
SWEP.Primary.Force				= 3 -- Force applied on the object the bullet hits
SWEP.Primary.ClipSize			= 18 -- Max amount of bullets per clip
SWEP.Primary.Ammo				= "AR2" -- Ammo type
SWEP.Primary.Sound = {
	"vj_halo3flood/weapons/carbine_fire1.wav",
	"vj_halo3flood/weapons/carbine_fire2.wav",
	"vj_halo3flood/weapons/carbine_fire3.wav",
}
SWEP.Primary.DistantSound = {
	"vj_halo3flood/weapons/carbine_lod_far1.wav",
	"vj_halo3flood/weapons/carbine_lod_far2.wav",
	"vj_halo3flood/weapons/carbine_lod_far3.wav",
}
SWEP.Primary.TracerType			= "VJ_Halo3_BeamCarbine"
SWEP.PrimaryEffects_MuzzleAttachment = "muzzle"
SWEP.PrimaryEffects_MuzzleFlash = false
SWEP.PrimaryEffects_SpawnShells = false
SWEP.PrimaryEffects_DynamicLightColor = Color(0,255,0)