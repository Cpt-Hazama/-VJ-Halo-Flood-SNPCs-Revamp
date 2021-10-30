/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2021 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Halo Trilogy Flood SNPCs"
local AddonName = "Halo Trilogy Flood"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_halo3_flood_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

	VJ.AddConVar("vj_halo_developmenttime",1000)
	VJ.AddConVar("vj_halo_infiniteammo",0)

	VJ.AddNPCWeapon("VJ_H3F_BattleRifle","weapon_vj_halo_br")
	VJ.AddNPCWeapon("VJ_H3F_MA5B-CE","weapon_vj_halo_ma5b")
	VJ.AddNPCWeapon("VJ_H3F_MA5C-3","weapon_vj_halo_ma5c")
	VJ.AddNPCWeapon("VJ_H3F_Needler-Reach","weapon_vj_halo_needler")
	VJ.AddNPCWeapon("VJ_H3F_PlasmaRifle-CE","weapon_vj_halo_plasma")
	VJ.AddNPCWeapon("VJ_H3F_PlasmaPistol-3","weapon_vj_halo_plasmapistol")
	VJ.AddNPCWeapon("VJ_H3F_PlasmaRifle-3","weapon_vj_halo_plasmarifle")
	VJ.AddNPCWeapon("VJ_H3F_M90-3","weapon_vj_halo_shotgun")
	VJ.AddNPCWeapon("VJ_H3F_SMG-3","weapon_vj_halo_smg")
	VJ.AddNPCWeapon("VJ_H3F_Type25-3","weapon_vj_halo_spiker")
	VJ.AddNPCWeapon("VJ_H3F_BeamRifle-3","weapon_vj_halo_beamrifle")
	VJ.AddNPCWeapon("VJ_H3F_Type51-Carbine-3","weapon_vj_halo_carbine")
	VJ.AddNPCWeapon("VJ_H3F_M41-SPNKR","weapon_vj_halo_rpg")

	local vCat1 = "Halo CE"
	VJ.AddCategoryInfo(vCat1,{Icon = "vj_icons/halo1_flood.png"})
	local vCat2 = "Halo 2"
	VJ.AddCategoryInfo(vCat2,{Icon = "vj_icons/halo2_flood.png"})
	local vCat3 = "Halo 3"
	VJ.AddCategoryInfo(vCat3,{Icon = "vj_icons/halo3_flood.png"})
	local vCatHW = "Halo Wars"
	VJ.AddCategoryInfo(vCatHW,{Icon = "vj_icons/halowars_flood.png"})

	VJ.AddNPC("Flood Combat Form","npc_vj_hcf_human",vCat1)
	VJ.AddNPC("Flood Carrier Form","npc_vj_hcf_carrier",vCat1)
	VJ.AddNPC("Flood Infection Form","npc_vj_hcf_infection",vCat1)
	VJ.AddNPC("Flood Combat Sangheili Form","npc_vj_hcf_elite",vCat1)

	VJ.AddNPC("Flood Combat Form","npc_vj_hcf_human2",vCat2)
	VJ.AddNPC("Flood Infection Form","npc_vj_hcf_infection2",vCat2)
	VJ.AddNPC("Flood Combat Sangheili Form","npc_vj_hcf_elite2",vCat2)
	VJ.AddNPC("Flood Juggernaut Form","npc_vj_hcf_juggernaut",vCat2)
	VJ.AddNPC("Flood Water Form","npc_vj_hcf_cmonkey",vCat2)

	VJ.AddNPC("Flood Combat Form","npc_vj_flood_combat",vCat3)
	VJ.AddNPC("Flood Carrier Form","npc_vj_flood_carrier",vCat3)
	VJ.AddNPC("Flood Infection Form","npc_vj_flood_infection",vCat3)
	VJ.AddNPC("Flood Stalker Form","npc_vj_flood_stalker",vCat3)
	VJ.AddNPC("Flood Tank Form","npc_vj_flood_tank",vCat3)
	VJ.AddNPC("Flood Ranged Form","npc_vj_flood_ranged",vCat3)
	VJ.AddNPC("Flood Combat Jiralhanae Form","npc_vj_flood_combat_brute",vCat3)
	VJ.AddNPC("Flood Combat Sangheili Form","npc_vj_flood_combat_elite",vCat3)
	-- VJ.AddNPC("Flood Combat Sangheili Form (Camo)","npc_vj_flood_combat_elite_invis",vCat3)
	VJ.AddNPC("Flood Spawner","sent_vj_flood_randflood",vCat3)
	VJ.AddNPC("Flood Combat Spawner","sent_vj_flood_randcombat",vCat3)
	VJ.AddNPC("Pure Flood Spawner","sent_vj_flood_randpureflood",vCat3)
	VJ.AddNPC("Flood Infection Spawner","sent_vj_flood_randinfection",vCat3)
	-- VJ.AddNPC("Map Flood Spawner","sent_vj_flood_director",vCat3)
	VJ.AddNPC("Flood Egg Sack","npc_vj_flood_egg",vCat3)

	VJ.AddNPC("Flood Hive Mind","npc_vj_flood_hivemind",vCatHW)
	VJ.AddNPC("Flood Swarm Form","npc_vj_flood_swarm",vCatHW)
	VJ.AddNPC("Flood Mortar","npc_vj_flood_mortar",vCatHW)
	VJ.AddNPC("Flood Abomination Form","npc_vj_flood_abomination",vCatHW)
	VJ.AddNPC("Flood Seeder Form","npc_vj_flood_seeder",vCatHW)
	VJ.AddNPC("Flood Spawner Form","npc_vj_flood_spawner",vCatHW)
	VJ.AddNPC("Flood Infester Form","npc_vj_flood_infester",vCatHW)

	VJ.AddNPC("Flood Infection Form","npc_vj_hwf_infection",vCatHW)
	VJ.AddNPC("Flood Combat Form","npc_vj_hwf_combat",vCatHW)
	VJ.AddNPC("Flood Combat Jiralhanae Form","npc_vj_hwf_combat_brute",vCatHW)
	VJ.AddNPC("Flood Combat Sangheili Form","npc_vj_hwf_combat_elite",vCatHW)

	if SERVER then
		-- include('vj_base/extensions/vj_ai_extension.lua')
		include('vj_base/addons/vj_haloflood.lua')
	end

	game.AddParticles("particles/flood.pcf")
	game.AddParticles("particles/cpt_flood_blood_impact.pcf")
	game.AddParticles("particles/cpt_flood_effects.pcf")
	game.AddParticles("particles/cpt_flood_infection.pcf")
	game.AddParticles("particles/cpt_flood_spores.pcf")
	game.AddParticles("particles/cpt_flood_mortar1.pcf")
	game.AddParticles("particles/cpt_flood_mortar2.pcf")
	game.AddParticles("particles/cpt_flood_shield.pcf")

	hook.Add("ShouldCollide","VJ_HaloFlood_NoCollide",function(ent1,ent2)
		if ent1.VJ_IsFloodInfectionForm && ent2.VJ_IsFloodForm or ent2.VJ_IsFloodInfectionForm && ent1.VJ_IsFloodForm then
			return false
		end
		return true
	end)

	local ENT = ENT or FindMetaTable("Entity")
	local NPC = FindMetaTable("NPC")
	local SWEP = SWEP or FindMetaTable("Weapon")
	local PLY = FindMetaTable("Player")

	VJ_Vec0 = Vector(0,0,0)
	VJ_Ang0 = Angle(0,0,0)

	local matStepSounds = {
		[MAT_ANTLION] = {
			"physics/flesh/flesh_impact_hard1.wav",
			"physics/flesh/flesh_impact_hard2.wav",
			"physics/flesh/flesh_impact_hard3.wav",
			"physics/flesh/flesh_impact_hard4.wav",
			"physics/flesh/flesh_impact_hard5.wav",
			"physics/flesh/flesh_impact_hard6.wav",
		},
		[MAT_BLOODYFLESH] = {
			"physics/flesh/flesh_impact_hard1.wav",
			"physics/flesh/flesh_impact_hard2.wav",
			"physics/flesh/flesh_impact_hard3.wav",
			"physics/flesh/flesh_impact_hard4.wav",
			"physics/flesh/flesh_impact_hard5.wav",
			"physics/flesh/flesh_impact_hard6.wav",
		},
		[MAT_CONCRETE] = {
			"player/footsteps/concrete1.wav",
			"player/footsteps/concrete2.wav",
			"player/footsteps/concrete3.wav",
			"player/footsteps/concrete4.wav",
		},
		[MAT_DIRT] = {
			"player/footsteps/dirt1.wav",
			"player/footsteps/dirt2.wav",
			"player/footsteps/dirt3.wav",
			"player/footsteps/dirt4.wav",
		},
		[MAT_FLESH] = {
			"physics/flesh/flesh_impact_hard1.wav",
			"physics/flesh/flesh_impact_hard2.wav",
			"physics/flesh/flesh_impact_hard3.wav",
			"physics/flesh/flesh_impact_hard4.wav",
			"physics/flesh/flesh_impact_hard5.wav",
			"physics/flesh/flesh_impact_hard6.wav",
		},
		[MAT_GRATE] = {
			"player/footsteps/metalgrate1.wav",
			"player/footsteps/metalgrate2.wav",
			"player/footsteps/metalgrate3.wav",
			"player/footsteps/metalgrate4.wav",
		},
		[MAT_ALIENFLESH] = {
			"physics/flesh/flesh_impact_hard1.wav",
			"physics/flesh/flesh_impact_hard2.wav",
			"physics/flesh/flesh_impact_hard3.wav",
			"physics/flesh/flesh_impact_hard4.wav",
			"physics/flesh/flesh_impact_hard5.wav",
			"physics/flesh/flesh_impact_hard6.wav",
		},
		[74] = { -- Snow
			"player/footsteps/sand1.wav",
			"player/footsteps/sand2.wav",
			"player/footsteps/sand3.wav",
			"player/footsteps/sand4.wav",
		},
		[MAT_PLASTIC] = {
			"physics/plaster/drywall_footstep1.wav",
			"physics/plaster/drywall_footstep2.wav",
			"physics/plaster/drywall_footstep3.wav",
			"physics/plaster/drywall_footstep4.wav",
		},
		[MAT_METAL] = {
			"player/footsteps/metal1.wav",
			"player/footsteps/metal2.wav",
			"player/footsteps/metal3.wav",
			"player/footsteps/metal4.wav",
		},
		[MAT_SAND] = {
			"player/footsteps/sand1.wav",
			"player/footsteps/sand2.wav",
			"player/footsteps/sand3.wav",
			"player/footsteps/sand4.wav",
		},
		[MAT_FOLIAGE] = {
			"player/footsteps/grass1.wav",
			"player/footsteps/grass2.wav",
			"player/footsteps/grass3.wav",
			"player/footsteps/grass4.wav",
		},
		[MAT_COMPUTER] = {
			"physics/plaster/drywall_footstep1.wav",
			"physics/plaster/drywall_footstep2.wav",
			"physics/plaster/drywall_footstep3.wav",
			"physics/plaster/drywall_footstep4.wav",
		},
		[MAT_SLOSH] = {
			"player/footsteps/slosh1.wav",
			"player/footsteps/slosh2.wav",
			"player/footsteps/slosh3.wav",
			"player/footsteps/slosh4.wav",
		},
		[MAT_TILE] = {
			"player/footsteps/tile1.wav",
			"player/footsteps/tile2.wav",
			"player/footsteps/tile3.wav",
			"player/footsteps/tile4.wav",
		},
		[85] = { -- Grass
			"player/footsteps/grass1.wav",
			"player/footsteps/grass2.wav",
			"player/footsteps/grass3.wav",
			"player/footsteps/grass4.wav",
		},
		[MAT_VENT] = {
			"player/footsteps/duct1.wav",
			"player/footsteps/duct2.wav",
			"player/footsteps/duct3.wav",
			"player/footsteps/duct4.wav",
		},
		[MAT_WOOD] = {
			"player/footsteps/wood1.wav",
			"player/footsteps/wood2.wav",
			"player/footsteps/wood3.wav",
			"player/footsteps/wood4.wav",
			"player/footsteps/woodpanel1.wav",
			"player/footsteps/woodpanel2.wav",
			"player/footsteps/woodpanel3.wav",
			"player/footsteps/woodpanel4.wav",
		},
		[MAT_GLASS] = {
			"physics/glass/glass_sheet_step1.wav",
			"physics/glass/glass_sheet_step2.wav",
			"physics/glass/glass_sheet_step3.wav",
			"physics/glass/glass_sheet_step4.wav",
		}
	}
	---------------------------------------------------------------------------------------------------------------------------------------------
	function VJ_GetVarInt(var)
		local var = GetConVar(var)
		return (var && var:GetInt()) or -1
	end
	---------------------------------------------------------------------------------------------------------------------------------------------
	function VJ_PlaySound(sndType,ent,snd,vol,pit,delay)
		delay = delay or 0
		vol = vol or 75
		timer.Simple(delay,function()
			pit = (pit or 100) *VJ_GetVarInt("host_timescale")
			if sndType == 1 && IsValid(ent) then
				VJ_CreateSound(ent,snd,vol,pit)
			elseif sndType == 2 && IsValid(ent) then
				VJ_EmitSound(ent,snd,vol,pit)
			elseif sndType == 3 then
				sound.Play(VJ_PICK(snd),type(ent) == "Vector" && ent or (IsValid(ent) && ent:GetPos()) or VJ_Vec0,vol,pit,1)
			end
		end)
	end
	---------------------------------------------------------------------------------------------------------------------------------------------
	function VJ_ReplaceEntity(newClass,oldEnt,onReplaced)
		if !IsValid(oldEnt) then
			return
		end
		local newEnt = ents.Create(newClass)
		if !IsValid(newEnt) then
			return
		end
		newEnt:SetPos(oldEnt:GetPos())
		newEnt:SetAngles(oldEnt:GetAngles())
		newEnt:Spawn()
		undo.ReplaceEntity(oldEnt,newEnt)
		if onReplaced then
			onReplaced(oldEnt,newEnt)
		end
		VJ_Remove(oldEnt)
	end
	---------------------------------------------------------------------------------------------------------------------------------------------
	function VJ_Remove(ent)
		if !IsValid(ent) then
			return
		end
		ent:Remove()
	end
	---------------------------------------------------------------------------------------------------------------------------------------------
	function ENT:PlayGesture(restart,gest,ayer,rate)
		if restart then
			self:RestartGesture(gest)
			return
		end
		local gesture = self:AddGestureSequence(self:LookupSequence(gest))
		self:SetLayerPriority(gesture,layer or 1)
		self:SetLayerPlaybackRate(gesture,rate or 0.5)
	end
	---------------------------------------------------------------------------------------------------------------------------------------------
	function VJ_GetBone(ent,bone)
		if !IsValid(ent) then
			return
		end
		if type(bone) == "string" then
			return ent:GetBonePosition(ent:LookupBone(bone))
		end
		return ent:GetBonePosition(bone)
	end
	---------------------------------------------------------------------------------------------------------------------------------------------
	function VJ_CreateStepSound(ent,stepHeight,overrideSound,overrideSoundOverlap)
		if !ent:IsOnGround() then return end
		stepHeight = stepHeight or 32
		local tr = util.TraceLine({
			start = ent:GetPos(),
			endpos = ent:GetPos() +Vector(0,0,-stepHeight),
			filter = {ent}
		})
		local matTable = (overrideSoundOverlap != true && overrideSound) or matStepSounds[tr.MatType]
		local waterLVL = ent:WaterLevel()
		local vol = ent.FootStepSoundLevel or 70
		local pit = ent:VJ_DecideSoundPitch(ent.FootStepPitch1 or 95,ent.FootStepPitch2 or 105) or 100
		if tr.Hit && matTable then
			VJ_PlaySound(2,ent,matTable,vol,pit)
			if overrideSoundOverlap then
				VJ_PlaySound(2,ent,overrideSound,vol,pit)
			end
		end
		if waterLVL > 0 && waterLVL < 3 then
			VJ_PlaySound(2,ent,"player/footsteps/wade" .. math.random(1,8) .. ".wav",vol,pit)
		end
	end

-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end