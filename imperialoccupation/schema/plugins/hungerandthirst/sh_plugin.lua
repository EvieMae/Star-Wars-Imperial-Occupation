PLUGIN.name = "Hunger and Thirst"
PLUGIN.author = "Kaptan647"
PLUGIN.description = "Adds Hunger and Thirst bars/penalties"
if(SERVER) then
	function PLUGIN:OnCharacterCreated(client, character)
		character:SetData("Hunger" , 1000)
		character:SetData("Thirst", 1000)
	end
	function PLUGIN:CharacterLoaded(character)
		timer.Simple(0.5,function()
			character:SetData("RunSpeed",character:GetPlayer():GetRunSpeed())
			character:SetData("WalkSpeed",character:GetPlayer():GetWalkSpeed())
		end)
	end
	timer.Create("HungerThirstReduce",10,0,function()
		for k,ply in pairs(player.GetAll()) do
		    local char = ply:GetCharacter()
		    if char ~= nil then
    			local faction = ix.faction.indices[char:GetFaction()]
    			if faction.name == "C.I.S Remnant" then return end
    			if(char ~= nil) then
    				if(char:GetData("Hunger") == nil or char:GetData("Thirst") == nil) then
    					char:SetData("Hunger",1000)
    					char:SetData("Thirst",1000)
    				end
    				if(char:GetData("Hunger")>0) then
    					char:SetData("Hunger",char:GetData("Hunger")-1)
    				end
    				if(char:GetData("Thirst")>0) then
    					char:SetData("Thirst",char:GetData("Thirst")-1)
    				end		
		    	end
		    end
		end
	end)


else
	ix.bar.Add(function()
		return LocalPlayer():GetCharacter():GetData("Hunger") / 1000
	end, Color(102,102,0), 2, "Hunger")
	ix.bar.Add(function()
		return LocalPlayer():GetCharacter():GetData("Thirst") / 1000
	end, Color(0,128,255), 1, "Thirst")
end

function PLUGIN:StartCommand( ply,cmd )
	if(!ply:IsBot() and ply:Alive() and cmd:GetButtons() ~= 0) then
		local char = ply:GetCharacter()
			if (char ~= nil) then
				
				if ply:GetLocalVar("stm") > 10 then
					ply:SetWalkSpeed(char:GetData("WalkSpeed"))
					ply:SetRunSpeed(char:GetData("RunSpeed"))
				end
				
				if(char:GetData("Hunger")<50) && (ply:GetLocalVar("stm") > 10)  then
					ply:SetWalkSpeed(char:GetData("WalkSpeed")* 0.7)
					ply:SetRunSpeed(char:GetData("RunSpeed")* 0.7)
				else
					ply:SetWalkSpeed(char:GetData("WalkSpeed"))
					ply:SetRunSpeed(char:GetData("RunSpeed"))
				end

				if(char:GetData("Thirst")<50) && (ply:GetLocalVar("stm") > 10) then
					ply:SetRunSpeed(char:GetData("WalkSpeed"))
				else
					ply:SetRunSpeed(ply:GetRunSpeed())
				end
				
				if ply:GetLocalVar("stm") < 10 then
					ply:SetRunSpeed(char:GetData("WalkSpeed"))
				end
			end
	end
end