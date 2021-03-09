extends Node

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
    CRAB,
}

class Spell:
    var name
    var cost
    var upkeep
    var description
    var targeting
    var scene_path
    var attack
    var health

    func _init(name, description, cost, targeting, scene_path, stats=null):
        self.name = name
        self.description = description
        self.cost = cost
        self.targeting = targeting
        self.scene_path = scene_path
        self.upkeep = stats["upkeep"] if stats else 0
        self.attack = stats["attack"] if stats else 0
        self.health = stats["health"] if stats else 0


var defs = {
    spells.ENCHANT_AREA: Spell.new(
        'Enchant Tile',
        'Enchant the chosen map tile, gaining the tiles power',
        10,
        targeting.ANY_VISIBILE,
        'res://scenes/spells/ENCHANT_AREA.tscn'
    ),
    spells.MAGIC_SPIRIT: Spell.new(
        'Summon Magic Spirit',
        'Summon a small quick spirit that cannot attack',
        2,
        targeting.NEXT_TO_WIZARD,
        'res://scenes/spells/MAGIC_SPIRIT.tscn',
        {'upkeep': 1, 'attack': 0, 'health': 1}
    ),
    spells.FAR_SIGHT: Spell.new(
        'Far Sight',
        'Reveal a region of the map',
        20,
        targeting.ANYWHERE,
        'res://scenes/spells/FAR_SIGHT.tscn'
    ),
    spells.FIRE_BOLT: Spell.new(
        'Fire Bolt',
        'Shoot a bolt of slightly intense flame at a single target',
        2,
        targeting.ANY_VISIBILE,
        'res://scenes/spells/FIRE_BOLT.tscn',
        {'upkeep': 0, 'attack': 1, 'health': 0}
    ),
    spells.CRAB: Spell.new(
        'Summon Crab',
        'Summon a small crabby helper',
        5,
        targeting.NEXT_TO_WIZARD,
        'res://scenes/spells/CRAB.tscn',
        {'upkeep': 2, 'attack': 1, 'health': 2}
    ),
}
