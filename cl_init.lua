/*----------------------------------------------------------------------------------
Edited for Zarp Gaming
----------------------------------------------------------------------------------*/
include('shared.lua')

function ENT:Initialize ()

end

function ENT:Draw()
	self:DrawModel()
	
		
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	local AngSec = Angle(0, 0, 0)
	
	surface.SetFont("HUDNumber5")
	local TextWidth1 = surface.GetTextSize("Metal Detector")
	local TextWidth2 = surface.GetTextSize("Metal Detector")
	
	Ang:RotateAroundAxis(Ang:Up() * 1, 90)
	local TextAng = Ang

	
	

	

            TextAng:RotateAroundAxis(TextAng:Forward() * 1, 90)
            -- Draw top
            cam.Start3D2D(Pos + Ang:Up() * 0.65, TextAng, 0.1)
                    draw.RoundedBox(10, -225, -606, 460, 144, Color(0, 0, 0, 255))
                    draw.WordBox(2, -TextWidth1*0.5, -550, "Metal Detector", "HUDNumber5", Color(0, 0, 0, 0), Color(255,255,255,255))
            cam.End3D2D()
end

local sound = Sound("ambient/alarms/klaxon1.wav")
local function metalDetectorUMsg ( uMsg )
	local ent = uMsg:ReadEntity()
	
	sound.Play(Sound, ent:GetPos())


end
usermessage.Hook("metal_det", metalDetectorUMsg)