-- Here is where all of your shared hooks should go.

-- Disable entity driving.
function Schema:CanDrive(client, entity)
	return false
end

function Schema:PurchaseItems(client,x,y)
	while y > 0 do
		local succ = client:GetChar():GetInv():Add(x)
		if(!succ) then
			client:GetChar():GetInv():Add(ix.item.list[x])
		end
		hook.Run("PurchasedItems", client, x)
		y = y - 1
	end
end

function Schema:CompareFlags(client,ItemTable)
	if ItemTable.flag then
		if client:GetChar():HasFlags(ItemTable.flag) then
			return true
		else
			return false
		end
	end
end

local s_Meta = FindMetaTable( "Player" );
 
function s_Meta:CreateNewBonemerge( szModel )
    if CLIENT then
        b = ClientsideRagdoll( szModel, RENDERGROUP_OPAQUE );
        b:SetModel( szModel );
        b:InvalidateBoneCache();
        b:SetParent( self );
        b:SetNoDraw( false )
        b:DrawShadow( true )
        b:AddEffects( EF_BONEMERGE );
        b:SetupBones();
        function b:Think()
     
            local ply = self:GetParent();
       
            if( IsValid( ply ) ) then
           
                if( !self.LastParent ) then
           
                    if( !self.bLastAliveState ) then
                   
                        self.bLastAliveState = ply:Alive();
                       
                    end
                   
                    if( !self.nLastCharID ) then
                       
                        self.nLastCharID = ply:GetChar():GetID();
                       
                    end
                   
                else
               
                    if( !self.bLastAliveState ) then
                   
                        self.bLastAliveState = self.LastParent:Alive();
                       
                    end
                   
                    if( !self.nLastCharID ) then
                       
                        self.nLastCharID = self.LastParent:GetChar():GetID();
                       
                    end
               
               
                end
     
                if( ply:GetNoDraw() and !self.bLastDrawState ) then
               
                    self:SetNoDraw( true );
                   
                elseif( !ply:GetNoDraw() and self.bLastDrawState ) then
               
                    self:SetNoDraw( false );
                   
                end
     
                if( !self.LastParent ) then
               
                    if( !ply:Alive() and self.bLastAliveState ) then
                       
                        self.LastParent = ply;
                        self:SetParent( ply:GetRagdollEntity() );
                        self:AddEffects( EF_BONEMERGE );
                       
                    end
                    if ply:GetChar() then
                        if( ply:GetChar():GetID() != self.nLastCharID ) then
     
                            self:Remove();
                       
                        end
                    end
                   
                else
               
                    if( self.LastParent:Alive() and !self.bLastAliveState ) then
                   
                        self:SetParent( self.LastParent );
                        self:AddEffects( EF_BONEMERGE );
                        self.LastParent = nil;
                       
                    end
                   
                end
               
            else
           
                if( !IsValid( self.LastParent ) ) then
     
                    self:Remove(); 
                   
                else
               
                    self:SetParent( self.LastParent );
                    self:AddEffects( EF_BONEMERGE );
                    self.LastParent = nil;
               
                end
           
            end
           
            self.bLastDrawState = self:GetNoDraw();
            if( !self.LastParent ) then
           
                if( IsValid( ply ) ) then
           
                    self.bLastAliveState = ply:Alive();
                    self.nLastCharID = ply:GetChar():GetID();
                   
                end
               
            else
               
                if( !IsValid( self.LastParent ) ) then return end
           
                self.bLastAliveState = self.LastParent:Alive();
                self.nLastCharID = self.LastParent:GetChar():GetID();
           
            end
     
        end
        hook.Add( "Think", b, b.Think );
       
        return b;
    end
end

local HelmetTable = 
{
	["models/outerrimrp/playermodels/male_mandalorian1.mdl"] = 1,
	["models/outerrimrp/playermodels/male_mandalorian2.mdl"] = 1,
	["models/outerrimrp/playermodels/male_mandalorian3.mdl"] = 1,
	["models/outerrimrp/playermodels/male_mandalorian4.mdl"] = 1,
	["models/outerrimrp/playermodels/male_sandtrooper.mdl"] = 2,
	["models/outerrimrp/playermodels/male_scouttrooper.mdl"] = 2,
	["models/outerrimrp/playermodels/male_stormtrooper.mdl"] = 2,
}

local IncludeTable = 
{
	"models/outerrimrp/playermodels/female_merc1.mdl",
	"models/outerrimrp/playermodels/female_merc2.mdl",
	"models/outerrimrp/playermodels/female_merc3.mdl",
	"models/outerrimrp/playermodels/female_merc4.mdl",
	"models/outerrimrp/playermodels/female_upperclass1.mdl",
	"models/outerrimrp/playermodels/male_dengar.mdl",
	"models/outerrimrp/playermodels/male_imperialmedic.mdl",
	"models/outerrimrp/playermodels/male_imperialnavy.mdl",
	"models/outerrimrp/playermodels/male_imperialtrooper.mdl",
	"models/outerrimrp/playermodels/male_isard.mdl",
	"models/outerrimrp/playermodels/male_isb.mdl",
	"models/outerrimrp/playermodels/male_mandalorian1.mdl",
	"models/outerrimrp/playermodels/male_mandalorian2.mdl",
	"models/outerrimrp/playermodels/male_mandalorian3.mdl",
	"models/outerrimrp/playermodels/male_mandalorian4.mdl",
	"models/outerrimrp/playermodels/male_merc1.mdl",
	"models/outerrimrp/playermodels/male_merc2.mdl",
	"models/outerrimrp/playermodels/male_merc3.mdl",
	"models/outerrimrp/playermodels/male_merc4.mdl",
	"models/outerrimrp/playermodels/male_rgofficer.mdl",
	"models/outerrimrp/playermodels/male_sandtrooper.mdl",
	"models/outerrimrp/playermodels/male_scouttrooper.mdl",
	"models/outerrimrp/playermodels/male_stormtrooper.mdl",
	"models/outerrimrp/playermodels/male_upperclass1.mdl",
}

function Schema:Think()
    for k,v in pairs(player.GetAll()) do
		if IsValid(v) then
			if v:GetChar() then
				if v:GetChar():GetID() > 0 then
					local model = v:GetModel()
					if not table.HasValue(IncludeTable,model) then
						if v.BonemergeHead then v.BonemergeHead:Remove() end
				        return
				    end
					
					if table.HasValue(HelmetTable,model) then
						local bgy = HelmetTable[model]
						local bgx = v:FindBodygroupByName("Helmet")
						local bgxother = v:FindBodygroupByName("headgear")
						if v:GetBodygroup(bgx) == bgy or v:GetBodygroup(bgxother) == bgy then
							if v.BonemergeHead then v.BonemergeHead:Remove() end
							return
						end
				    end
				    
					if (!v.BonemergeHead or !IsValid(v.BonemergeHead)) then
						local character = v:GetChar()
						if SERVER then
						    local head = character:GetData("headmodel")
						    v:SetNWString("hmodel",head)
						end
						local headmodel = v:GetNWString("hmodel",head)
						if headmodel ~= nil then
						    v.BonemergeHead = v:CreateNewBonemerge(headmodel)
						end
					end
				end
			end
		end
    end
end