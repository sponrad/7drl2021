extends Node

#start the game with a summon or a damage spell
#AND always an essence spell, essence costs a turn and you can cast it on various
#things to get their essence out in the form of mana/turn

enum targeting {
    ANYWHERE,
    ANY_VISIBILE,
    NEXT_TO_WIZARD,
}

enum spells {
    SPELL_OF_MASTERY,
    ENCHANT_AREA,
    MAGIC_SPIRIT,
    FAR_SIGHT,
    FIRE_BOLT,
    IMP,
}

class Spell:
    var name
    var cost
    var upkeep
    var description
    var targeting
    # TODO var other_stats_abilities

    func _init(name, description, cost, targeting):
        self.name = name
        self.description = description
        self.cost = cost
        self.targeting = targeting

var defs = {
    spells.ENCHANT_AREA: Spell.new(
        'Enchant Tile',
        'Enchant the chosen map tile, gaining the tiles power',
        1,
        targeting.ANY_VISIBILE
    ),
    spells.MAGIC_SPIRIT: Spell.new(
        'Summon Magic Spirit',
        'Summon a small quick spirit that cannot attack',
        1,
        targeting.NEXT_TO_WIZARD
    ),
    spells.FAR_SIGHT: Spell.new(
        'Far Sight',
        'Reveal a region of the map',
        1,
        targeting.ANYWHERE
    ),
    spells.FIRE_BOLT: Spell.new(
        'Fire Bolt',
        'Shoot a bolt of slightly intense flame at a single target',
        1,
        targeting.ANY_VISIBILE
    ),
    spells.IMP: Spell.new(
        'Summon Imp',
        'Summon a small demon helper',
        2,
        targeting.NEXT_TO_WIZARD
    ),
}
