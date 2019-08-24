PLUGIN.name = "FNStackables"
PLUGIN.author = "Lt. Taylor"
PLUGIN.desc = "Adds a system for stackable items"

if (CLIENT) then
	local PANEL = {}
	function PANEL:Init()
	    local SplitSlider = self:Add("DNumSlider")
		SplitSlider:SetText("Stack Size")
		SplitSlider:SetMin(1)
		SplitSlider:SetMax(1)
		SplitSlider:SetValue(1)
		SplitSlider:SetDecimals(0)
		SplitSlider:Dock(FILL)
		
		self:SetTitle("Split Stack")
		self:SetSize(300, 150)
		self:Center()
		self:MakePopup()
		
		self.submit = self:Add("DButton")
		self.submit:Dock(BOTTOM)
		self.submit:DockMargin(0, 5, 0, 0)
		self.submit:SetTall(25)
		self.submit:SetText("Split")
		self.submit.DoClick = function()
		    local stack = SplitSlider:GetValue()
    		netstream.Start("StackSplit", stack, self.itemID)
    		self:Close()
		end
	end

	function PANEL:Think()
	    self:MoveToFront()
	    local kids = self:GetChildren()
	    local slider = kids[5]
	    local maximum = self.slidermax
	    if IsValid(slider) then
    	    if slider:GetMax() ~= (maximum - 1) then
    	        if maximum > 1 then
    	            slider:SetMax((maximum - 1))
	            else
	                slider:SetMax(1)
	            end
    	        slider:SetValue(math.Round((maximum - 1)/2))
            end
        end
	end

	vgui.Register("AmmoStackMenu", PANEL, "DFrame")

	netstream.Hook("StackSplit", function(dura, id)
		local adjust = vgui.Create("AmmoStackMenu")
		
	    local quan = ix.item.instances[id]
	    local maximum = quan:GetData("quantity",1)
        adjust.slidermax = maximum or 20
        
		if (id) then
			adjust.itemID = id
		end
	end)
else
	netstream.Hook("StackSplit", function(client, stack, id)
		local inv = (client:GetChar() and client:GetChar():GetInv() or nil)

		if (inv) then
			local item
			if (id) then
				item = ix.item.instances[id]
    			local ent = item:GetEntity()
    			if (item and (IsValid(ent) or item:GetOwner() == client)) then
    				(ent or client):EmitSound("buttons/combine_button1.wav", 50, 170)
    				local newitemID
    				local x
    				local y
					local invID
    				local stacksize = math.Round(stack)
    				
    				if stacksize >= item:GetData("quantity",1) then return end
    				
    				item:SetData("quantity",item:GetData("quantity",1) - stacksize)
    				for k, v in SortedPairs(ix.item.list) do
    				    if (ix.util.StringMatches(v.name, item.name)) then
							local data = {}
							data["quantity"] = stacksize
    				        x, y, invID = inv:Add(k, nil, data, nil, nil, nil)
    				        break
    				    end
    				end
    			end
			end
		end
	end)
end