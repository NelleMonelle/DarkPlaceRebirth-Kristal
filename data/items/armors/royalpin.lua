local item, super = Class(Item, "royalpin")

function item:init()
    super:init(self)

    -- Display name
    self.name = "RoyalPin"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "Elegant\nbrooch"
    -- Menu description
    self.description = "A brooch engraved with Queen's face.\nCareful of the sharp part."

    -- Shop buy price
    self.buy_price = 1000
    -- Shop sell price (usually half of buy price)
    self.sell_price = 500

    -- Consumable target mode (party, enemy, noselect, or none/nil)
    self.target = nil
    -- Where this item can be used (world, battle, all, or none/nil)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        defense = 3,
        magic = 1,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions
    self.reactions = {
        susie = "ROACH? Oh, brooch. Heh.",
        ralsei = "I'm a cute little corkboard!",
        noelle = "Queen... gave this to me.",
    }
end

return item