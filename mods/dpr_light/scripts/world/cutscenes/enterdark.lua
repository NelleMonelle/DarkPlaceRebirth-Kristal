---@type table<string,fun(cutscene:WorldCutscene, ...)>
local enterdark = {}

function enterdark.shelter(cutscene)

    cutscene:text("* (Enter the Dark World?)")
    if cutscene:choicer({"Yes", "No"}) == 2 then return end

    Game.world:getEvents("sheltersound")[1]:remove()

    local player = Game.world.player

    cutscene:detachCamera()
    cutscene:detachFollowers()

    local party = {Game.world.player}
    for _, follower in ipairs(Game.world.followers) do
        table.insert(party,follower)
    end
    for index, value in ipairs(party) do
        cutscene:slideTo(value,  320 + (60 * (index-(#party/2)) - 30) , 2396, 0.25)
    end
    -- cutscene:slideTo(susie, 620 + 30, 280, 0.25)
    cutscene:panTo(620, 2240, 0.25)
    cutscene:wait(0.25)
    
    local transition = LoadingDarkTransition(-500)
    transition.loading_callback = function() 
        -- Game.world:loadMap("light/hometown/apartments")
        DTRANS = true
        Game:swapIntoMod("dpr_main", false, "main_hub")
        if Game.world.music then
            Game.world.music:stop()
        end
        for _,party in ipairs(Game.party) do
            local char = Game.world:getCharacter(party.id) or Game.world:getCharacter(party.lw_actor.id)
            if char then
                char.visible = false
            end
        end
    end
    transition.layer = 99999

    Game.world:addChild(transition)
    for _, value in ipairs(party) do
        value.visible = false
    end
    local waiting = true
    local endData = nil
    transition.end_callback = function(transition, data)
        waiting = false
        endData = data
    end

    cutscene:wait(function() return not waiting end)
    
    if not Game:hasPartyMember("ralsei") then
        Game:addPartyMember("ralsei")
    end

    for _, character in ipairs(endData) do
        local char = Game.world:getPartyCharacterInParty(character.party)
        local kx, ky = character.sprite_1:localToScreenPos(character.sprite_1.width / 2, 0)
        if char then
            char:setScreenPos(kx, transition.final_y)
            char.visible = true
            char:setFacing("down")
        end
    end

    cutscene:interpolateFollowers()

    cutscene:attachCamera()
    cutscene:attachFollowers()
end

return enterdark