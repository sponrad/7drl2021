extends Node

#start the game with a summon or a damage spell
#AND always an essence spell, essence costs a turn and you can cast it on various
#things to get their essence out in the form of mana/turn

enum types {
    ENCHANTMENT,
    DAMAGE,
    SUMMON,
    BUFF,
    UTILITY,
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
    # TODO var other_stats_abilities

    func _init(name):
        self.name = name

var defs = {
    spells.ENCHANT_AREA: Spell.new('Enchant Area'),
    spells.MAGIC_SPIRIT: Spell.new('Summon Magic Spirit'),
    spells.FAR_SIGHT: Spell.new('Far Sight'),
    spells.FIRE_BOLT: Spell.new('Fire Bolt'),
    spells.IMP: Spell.new('Summon Imp'),
}
