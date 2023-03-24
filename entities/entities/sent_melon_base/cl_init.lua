include("shared.lua")

local matBomb = Material("effects/redflare")

-- ENT:Initialize - Setup some variables --
function ENT:Initialize()
	self.BombTimer = 0
	self.BombTimerLast = 0
	self.BombDuration = 0
end

-- ENT:Draw - Draw the model & effects --
function ENT:Draw()
	-- Set bomb timer
	if (self.BombTimer != self.BombTimerLast) then
		self.BombDuration = CurTime() + 0.15
		self.BombTimerLast = self.BombTimer
	end

	-- Apply bomb effect
	if (self.BombDuration > CurTime()) then
		render.SetMaterial(matBomb)
		render.DrawSprite(self:GetPos(), 64, 64, Color(255, 255, 255, 255))
	end

	-- Draw model
	self:DrawModel()
end

-- ENT:DrawTranslucent - Do nothing --
function ENT:DrawTranslucent()
	self:Draw()
end

-- Usermessage 'sent_melon RecieveHP' --
local function RecieveHP()
	local Ply = net.ReadEntity()
	local Melon = Ply:GetNWEntity("Melon")

	if (Melon:IsValid()) then
		-- Set the HP clientside so we can draw it on the HUD
		local HP = net.ReadFloat()

		Melon.HP = HP
		Melon:SetNWInt("HP", HP)
	end
end
net.Receive("sent_melon_RecieveHP", RecieveHP)

-- Usermessage 'sent_melon BombTimer' --
local function BombTimer()
	local Ply = net.ReadEntity()
	local Melon = Ply:GetNWEntity("Melon")

	if (Melon:IsValid()) then
		Melon.BombTimer = net.ReadUInt(8)
	end
end
net.Receive("sent_melon_BombTimer", BombTimer)