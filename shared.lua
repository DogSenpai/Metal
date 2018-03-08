ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Metal Detector"
ENT.Author = "Anti-Mingers Elite"
ENT.Category = "Gmod Warehouse"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
self:NetworkVar("Entity",1,"owning_ent")
end
