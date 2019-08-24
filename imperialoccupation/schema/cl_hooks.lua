-- Here is where all of your clientside hooks should go.

-- Disables the crosshair permanently.
function Schema:CharacterLoaded(character)
	self:ExampleFunction("@serverWelcome", character:GetName())
end

function Schema:GetMaxPlayerCharacter(client)
    local rank = serverguard.player:GetRank(client)
    local defmax = ix.config.Get("maxCharacters",3)
    local newmax
    if rank == "bronze" then
        newmax = defmax + 1
    elseif rank == "silver" then
        newmax = defmax + 2
    elseif rank == "gold" then
        newmax = defmax + 3
    elseif rank == "diamond" then
        newmax = defmax + 4
    elseif rank == "legendary" or rank == "admin" or rank == "superadmin" or rank == "founder" or rank == "dev" then
        newmax = defmax + 5
    else
        return defmax
    end
    return newmax 
end