
/*---------------------------------
Add and Remove Weapons on line 68
---------------------------------*/


AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')


MixRange = 150;



function ENT:Initialize()
	self:SetModel("models/props_wasteland/interior_fence002e.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	
	local pos = self:GetPos()
	self:SetPos(pos + Vector(0,0,100))
	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then phys:Wake() end
	
	self:SetNWInt("Mode", 0)
end

function ENT:SetItemOwner ( Owner )
	self:GetTable().Owner = Owner;
end

-- Add Weapons --
local weapons = {"weapon_ak472", "weapon_mad_57", "weapon_mad_357", "weapon_mad_ak47", "weapon_mad_aug", "weapon_mad_auto_glock", "weapon_mad_awp", "weapon_mad_c4", "weapon_mad_deagle", "weapon_mad_famas", "weapon_mad_g3", "weapon_mad_galil", "weapon_mad_glock", "weapon_mad_grenade", "weapon_mad_knife", "weapon_mad_m3", "weapon_mad_m4", "weapon_mad_m249", "weapon_mad_mac10", "weapon_mad_mp5", "weapon_mad_mp7", "weapon_mad_p90", "weapon_mad_p228", "weapon_mad_scout", "weapon_mad_sg550", "weapon_mad_sg552", "weapon_mad_spas", "weapon_mad_tmp", "weapon_mad_ump", "weapon_mad_usp_match", "weapon_mad_xm1014", "weapon_mad_dual"}
-- Add Weapons --

local timerNext = 0
function ENT:Think ( )
	if (self.goingOff && (self.goingOff + 5) > CurTime()) then return end

	local min = self:OBBMins()
	local cen = self:OBBCenter()
	local real = self:LocalToWorld(Vector(cen.x, cen.y, min.z))+ Vector(0, 0, 30)

	for _, each in pairs(player.GetAll()) do
		if (each:GetPos():Distance(real)  < 35) then 
			local foundGun = false
			for _, each in pairs(each:GetWeapons()) do
				local cl = string.lower(each:GetClass())
				
				for _, class in pairs(weapons) do
					if (cl == class) then
						foundGun = true
						break
					end
				end
				
				if (foundGun) then break end
			end


			
			if (foundGun) then
			self:SetNWInt("Mode", 1)
			timer.Create( "SetColor", 1, 1, function() self:SetNWInt("Mode", 0) end )
    		else
			self:SetNWInt("Mode", 2)
			//self:EmitSound("HL1/fvox/bell.wav", 500, 120)
			timer.Create( "SetColor", 1, 1, function() self:SetNWInt("Mode", 0) end )
			end
			
			
			local timetoBuzz = 0.25
			local timeDelay = 1 + (timetoBuzz * 3)
			
			if (foundGun) then
				if timerNext < CurTime() then
					self:EmitSound("ambient/alarms/klaxon1.wav", 500, 120)
					timer.Simple(timetoBuzz, function()
						self:EmitSound("ambient/alarms/klaxon1.wav", 500, 120)
						timer.Simple(timetoBuzz, function() 
							self:EmitSound("ambient/alarms/klaxon1.wav", 500, 120)
						end)
					end)
					timerNext = CurTime() + timeDelay
					return
				end
			else
				if timerNext < CurTime() then
					self:EmitSound("HL1/fvox/bell.wav", 500, 120)
					timerNext = CurTime() + timeDelay
					return
				end
			end
		end
	end
end


local function RemoveMetalDetector(ply, cmd, args)
        local ent = ply:GetEyeTrace().Entity
        local Owner = ent.dt.owning_ent
        if ply != Owner then return false end
        if IsValid(ent) and ent:GetClass() == "zarp_metal_detector" then
                ent:Remove()
                GAMEMODE:Notify(ply, 1, 4, "You have removed your metal detector")
        else
                GAMEMODE:Notify(ply, 1, 4, "You must be looking at your metal detector to do this!")
        end
end
concommand.Add("remove_metal_det", RemoveMetalDetector)