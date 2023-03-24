include('shared.lua')

-- local Outline = Material("models/props_combine/portalball001_sheet")

-- ENT:Initialize - Nothing? --
function ENT:Initialize()

end

-- ENT:Draw - Draw the model --
function ENT:Draw()
	-- Draw the normal model
	self:SetModelScale( 0.8, 1 )
	self:SetRenderMode(RENDERMODE_TRANSCOLOR)
	self:SetColor( Color(100, 30, 255, 128) )
	self:DrawModel()

	-- Draw the outlining
	self:SetModelScale( 0.825, 1 )

	self:DrawModel()
	-- Draw the outlining again
	self:SetModelScale( 0.85, 1 )
	self:DrawModel()

	-- Put it back to normal
	self:SetModelScale( 0.8, 1 )
end

