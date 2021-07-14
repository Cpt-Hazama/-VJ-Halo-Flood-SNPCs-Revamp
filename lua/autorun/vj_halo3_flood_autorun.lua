/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2021 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Halo 3 SNPCs"
local AddonName = "Halo 3"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_halo3_flood_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

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
	VJ.AddCategoryInfo(vCat3,{Icon = "vj_icons/halo1_flood.png"})

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
	VJ.AddNPC("Flood Combat Sangheili Form (Camo)","npc_vj_flood_combat_elite_invis",vCat3)
	VJ.AddNPC("Flood Spawner","sent_vj_flood_randflood",vCat3)
	VJ.AddNPC("Flood Combat Spawner","sent_vj_flood_randcombat",vCat3)
	VJ.AddNPC("Pure Flood Spawner","sent_vj_flood_randpureflood",vCat3)
	VJ.AddNPC("Flood Infection Spawner","sent_vj_flood_randinfection",vCat3)
	-- VJ.AddNPC("Map Flood Spawner","sent_vj_flood_director",vCat3)
	VJ.AddNPC("Flood Egg Sack","npc_vj_flood_egg",vCat3)

	VJ.AddNPC("Flood Hive Mind","npc_vj_flood_hivemind",vCatHW)
	VJ.AddNPC("Flood Mortar","npc_vj_flood_mortar",vCatHW)
	VJ.AddNPC("Flood Abomination Form","npc_vj_flood_abomination",vCatHW)
	VJ.AddNPC("Flood Seeder Form","npc_vj_flood_seeder",vCatHW)
	VJ.AddNPC("Flood Spawner Form","npc_vj_flood_spawner",vCatHW)
	VJ.AddNPC("Flood Infester Form","npc_vj_flood_infester",vCatHW)

	if SERVER then
		include('vj_base/extensions/vj_ai_extension.lua')
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