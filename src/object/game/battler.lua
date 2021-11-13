local Battler, super = Class(Object)

function Battler:init(x, y, width, height)
    super:init(self, x, y, width, height)

    self.layer = LAYERS["battlers"]

    self:setOrigin(0.5, 1)
    self:setScale(2)

    self.hit_count = 0
end

function Battler:flash(sprite)
    local sprite_to_use = sprite or self.sprite
    local offset = sprite_to_use:getOffset()
    local flash = FlashFade(sprite_to_use.texture, -offset[1], -offset[2])
    self:addChild(flash)
end

function Battler:sparkle(r, g, b)
    Game.battle.timer:every(1/30, function()
        for i = 1, 2 do
            local x = self.x + ((love.math.random() * self.width) - (self.width / 2)) * 2
            local y = self.y - (love.math.random() * self.height) * 2
            local sparkle = HealSparkle(x, y)
            if r and g and b then
                sparkle:setColor(r, g, b)
            end
            self.parent:addChild(sparkle)
        end
    end, 4)
end

function Battler:statusMessage(x, y, type, arg, color, kill)
    x, y = self:getRelativePos(x, y)

    local offset = 0
    if not kill then
        offset = (self.hit_count * 20)
    end

    local percent = DamageNumber(type, arg, x + 4, y + 20 - offset, color)
    if kill then
        percent.kill_others = true
    end
    self.parent:addChild(percent)

    if not kill then
        self.hit_count = self.hit_count + 1
    end

    return percent
end

-- Shorthand for convenience
function Battler:setAnimation(animation, callback)
    return self.sprite:setAnimation(animation, callback)
end

function Battler:setCustomSprite(sprite, ox, oy, speed, loop, after)
    self.sprite:setCustomSprite(sprite, ox, oy)
    if not self.sprite.directional and speed then
        self.sprite:play(speed, loop, after)
    end
end

return Battler