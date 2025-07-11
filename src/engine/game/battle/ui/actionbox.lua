---@class ActionBox : Object
---@overload fun(...) : ActionBox
local ActionBox, super = Class(Object)

function ActionBox:init(x, y, index, battler)
    super.init(self, x, y)
    
    self.selection_siner = 0

    self.index = index
    self.battler = battler

    self.selected_button = 1

    self.revert_to = 40

    self.data_offset = 0

    self.box = ActionBoxDisplay(self)
    self.box.layer = 1
    self:addChild(self.box)

    self.head_offset_x, self.head_offset_y = battler.chara:getHeadIconOffset()

    self.head_sprite = Sprite(battler.chara:getHeadIcons().."/"..battler:getHeadIcon(), 13 + self.head_offset_x, 11 + self.head_offset_y)
    if not self.head_sprite:getTexture() then
        self.head_sprite:setSprite(battler.chara:getHeadIcons().."/head")
    end
    self.force_head_sprite = false

    self.name_offset_x, self.name_offset_y = battler.chara:getNameOffset()

    if battler.chara:getNameSprite() then
        self.name_sprite = Sprite(battler.chara:getNameSprite(), 51 + self.name_offset_x, 14 + self.name_offset_y)
        self.box:addChild(self.name_sprite)
        
        if Game:getFlag("SHINY", {})[battler.actor:getShinyID()] and not (Game.world and Game.world.map.dont_load_shiny) then
            self.name_sprite:addFX(GradientFX(COLORS.white, {235/255, 235/255, 130/255}, 1, math.pi/2))
        end
    end

    self.hp_sprite = Sprite("ui/hp", 109, 22)

    self.box:addChild(self.head_sprite)
    self.box:addChild(self.hp_sprite)

    self:createButtons()
end

function ActionBox:getButtons(battler)
end

function ActionBox:createButtons()
    for _,button in ipairs(self.buttons or {}) do
        button:remove()
    end

    self.buttons = {}

    local btn_types = {"fight", "act", "magic", "item", "spare", "defend"}

        if self.battler.chara.set_buttons then
		btn_types = self.battler.chara.set_buttons
	elseif self.battler.chara:hasSkills() then
		btn_types = {"fight", "skill", "item", "spare", "defend"}
	else
		if not self.battler.chara:hasAct() then Utils.removeFromTable(btn_types, "act") end
		if not self.battler.chara:hasSpells() then Utils.removeFromTable(btn_types, "magic") end
	end

    for lib_id,_ in Kristal.iterLibraries() do
        btn_types = Kristal.libCall(lib_id, "getActionButtons", self.battler, btn_types) or btn_types
    end
    btn_types = Kristal.modCall("getActionButtons", self.battler, btn_types) or btn_types

    local start_x = (213 / 2) - ((#btn_types-1) * 35 / 2) - 1

    if (#btn_types <= 5) and Game:getConfig("oldUIPositions") then
        start_x = start_x - 5.5
    end

    if (#btn_types <= 6) and Game:getConfig("oldUIPositions") then
        start_x = 30
    end

    for i,btn in ipairs(btn_types) do
        if type(btn) == "string" then
            local button = ActionButton(btn, self.battler, math.floor(start_x + ((i - 1) * 35)) + 0.5, 21)
            button.actbox = self
            table.insert(self.buttons, button)
            self:addChild(button)
        elseif type(btn) ~= "boolean" then -- nothing if a boolean value, used to create an empty space
            btn:setPosition(math.floor(start_x + ((i - 1) * 35)) + 0.5, 21)
            btn.battler = self.battler
            btn.actbox = self
            table.insert(self.buttons, btn)
            self:addChild(btn)
        end
    end

    self.selected_button = Utils.clamp(self.selected_button, 1, #self.buttons)
end

function ActionBox:setHeadIcon(icon)
    self.force_head_sprite = true
    
    self.head_sprite:setColor(1, 1, 1)

    local full_icon = self.battler.chara:getHeadIcons().."/"..icon
    if self.head_sprite:hasSprite(full_icon) then
        self.head_sprite:setSprite(full_icon)
    else
        self.head_sprite:setSprite(self.battler.chara:getHeadIcons().."/head")
    end
end

function ActionBox:resetHeadIcon()
    self.force_head_sprite = false

    self.head_sprite:setColor(1, 1, 1)

    local full_icon = self.battler.chara:getHeadIcons().."/"..self.battler:getHeadIcon()
    if self.head_sprite:hasSprite(full_icon) then
        self.head_sprite:setSprite(full_icon)
    else
        self.head_sprite:setSprite(self.battler.chara:getHeadIcons().."/head")
    end
end

function ActionBox:update()
    self.selection_siner = self.selection_siner + 2 * DTMULT

    if Game.battle.current_selecting == self.index then
        if self.box.y > -32 then self.box.y = self.box.y - 2 * DTMULT end
        if self.box.y > -24 then self.box.y = self.box.y - 4 * DTMULT end
        if self.box.y > -16 then self.box.y = self.box.y - 6 * DTMULT end
        if self.box.y > -8  then self.box.y = self.box.y - 8 * DTMULT end
        -- originally '= -64' but that was an oversight by toby
        if self.box.y < -32 then self.box.y = -32 end
    elseif self.box.y < -14 then
        self.box.y = self.box.y + 15 * DTMULT
    else
        self.box.y = 0
    end

    self.head_sprite.y = 11 - self.data_offset + self.head_offset_y
    if self.name_sprite then
        self.name_sprite.y = 14 - self.data_offset + self.name_offset_y
    end
    self.hp_sprite.y = 22 - self.data_offset

    if not self.force_head_sprite then

        --its a bit messy but i dont have the willpower to clean it

        local current_head = self.battler.chara:getHeadIcons().."/"..self.battler:getHeadIcon()
        local head_has_icons = true
        if not self.head_sprite:hasSprite(current_head) then
            current_head = "ui/battle/icon/"..self.battler:getHeadIcon()
            head_has_icons = false
            if not self.head_sprite:hasSprite(current_head) then
               current_head = self.battler.chara:getHeadIcons().."/head"
            end
        end

        if not self.head_sprite:isSprite(current_head) then
            local color = {1, 1, 1}
            self.head_sprite:setColor(self.battler.chara.icon_color or color)
            if self.battler:getHeadIcon() == "head" or self.battler:getHeadIcon() == "head_hurt" or self.battler:getHeadIcon() == "head_low" or head_has_icons == true then
                -- These icons are already colored and don't play nice with the coloring system.
                self.head_sprite:setColor(color)
            end
            self.head_sprite:setSprite(current_head)
        end
    end

    for i,button in ipairs(self.buttons) do
        if (Game.battle.current_selecting == self.index) then
            button.selectable = true
            button.hovered = (self.selected_button == i)
        else
            button.selectable = false
            button.hovered = false
        end
    end

    super.update(self)
end

function ActionBox:select()
    self.buttons[self.selected_button]:select()
end

function ActionBox:unselect()
    self.buttons[self.selected_button]:unselect()
end

function ActionBox:draw()
    self:drawSelectionMatrix()
    self:drawActionBox()

    super.draw(self)

    if not self.name_sprite then
        local font = Assets.getFont("name")
        love.graphics.setFont(font)
        Draw.setColor(1, 1, 1, 1)

        local name = self.battler.chara:getName():upper()

        local start_x = self.box.x + (51 + self.name_offset_x)
        local end_x = start_x + (55 - self.name_offset_x)
        for i = 1, name:len() do
            local letter = name:sub(i, i)
            love.graphics.print(letter, (start_x + ((i) * ((end_x - start_x)/name:len()))) - font:getWidth(letter), self.box.y + 14 - self.data_offset - 1 + self.name_offset_y)
        end
    end
end

function ActionBox:drawActionBox()
    if Game.battle.current_selecting == self.index then
        Draw.setColor(self.battler.chara:getColor())
        love.graphics.setLineWidth(2)
        love.graphics.line(1  , 2, 1,   37)
        love.graphics.line(Game:getConfig("oldUIPositions") and 211 or 212, 2, Game:getConfig("oldUIPositions") and 211 or 212, 37)
        love.graphics.line(0  , 6, 212, 6 )
    end
    Draw.setColor(1, 1, 1, 1)
end

function ActionBox:drawSelectionMatrix()
    -- Draw the background of the selection matrix
    Draw.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 2, 2, 209, 35)

    if Game.battle.current_selecting == self.index then
        local r,g,b,a = self.battler.chara:getColor()

        for i = 0, 11 do
            local siner = self.selection_siner + (i * (10 * math.pi))

            love.graphics.setLineWidth(2)
            Draw.setColor(r, g, b, a * math.sin(siner / 60))
            if math.cos(siner / 60) < 0 then
                love.graphics.line(1 - (math.sin(siner / 60) * 30) + 30, 0, 1 - (math.sin(siner / 60) * 30) + 30, 37)
                love.graphics.line(211 + (math.sin(siner / 60) * 30) - 30, 0, 211 + (math.sin(siner / 60) * 30) - 30, 37)
            end
        end

        Draw.setColor(1, 1, 1, 1)
    end
end

return ActionBox