extends Node

enum targeting {
    ANYWHERE,
    ANY_VISIBILE,
    NEXT_TO_WIZARD,
    ANY_FOG,
    ITEM,
    SELF,
}

enum spells {
    SPELL_OF_MASTERY,
    ENCHANT_AREA,
    MAGIC_SPIRIT, # start
    FAR_SIGHT,
    FIRE_BOLT, # start
    CRAB,
    TELEPORT_ITEM, # start
    LIGHTNING,
    SPIDER,
    VOID_RAY,
    ROOTS,
    BARRIER,
    CLEAR_FOG, # start
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
    var research_cost

    func _init(name, description, cost, research_cost, targeting, scene_path, stats=null):
        self.name = name
        self.description = description
        self.cost = cost
        self.research_cost = research_cost
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
        20,
        targeting.ANY_VISIBILE,
        'res://scenes/spells/ENCHANT_AREA.tscn'
    ),
    spells.MAGIC_SPIRIT: Spell.new(
        'Summon Magic Spirit',
        'Summon a small quick spirit that cannot attack. It can scout and pick up items though, a great little thing.',
        2,
        4,
        targeting.NEXT_TO_WIZARD,
        'res://scenes/spells/MAGIC_SPIRIT.tscn',
        {'upkeep': 1, 'attack': 0, 'health': 1}
    ),
    spells.FAR_SIGHT: Spell.new(
        'Far Sight',
        'Magically remove the foggy clouds from a large region of the map. Enemies stay asleep to boot!',
        5,
        10,
        targeting.ANY_FOG,
        'res://scenes/spells/FAR_SIGHT.tscn'
    ),
    spells.FIRE_BOLT: Spell.new(
        'Fire Bolt',
        'Shoot a bolt of slightly intense flame at a single target',
        2,
        4,
        targeting.ANY_VISIBILE,
        'res://scenes/spells/FIRE_BOLT.tscn',
        {'upkeep': 0, 'attack': 1, 'health': 0}
    ),
    spells.CRAB: Spell.new(
        'Summon Crab',
        'Summon a small crabby helper',
        5,
        10,
        targeting.NEXT_TO_WIZARD,
        'res://scenes/spells/CRAB.tscn',
        {'upkeep': 2, 'attack': 1, 'health': 2}
    ),
    spells.TELEPORT_ITEM: Spell.new(
        'Teleport Item',
        'Grab an item on the map',
        0,
        2,
        targeting.ITEM,
        'res://scenes/spells/TELEPORT_ITEM.tscn'
    ),
    spells.SPELL_OF_MASTERY: Spell.new(
        'Spell of Mastery',
        'You win no questions asked',
        100,
        200,
        targeting.SELF,
        'res://scenes/spells/MASTERY.tscn'
    ),
    spells.LIGHTNING: Spell.new(
        'Lightning',
        'Conjure lightning, damages all enemies within range of 2 or so',
        20,
        40,
        targeting.ANY_VISIBILE,
        'res://scenes/spells/LIGHTNING.tscn',
        {'upkeep': 0, 'attack': 4, 'health': 0}
    ),
    spells.SPIDER: Spell.new(
        'Summon Giant Armored Spider',
        'Summon a spider. A huge one that is armored',
        25,
        40,
        targeting.NEXT_TO_WIZARD,
        'res://scenes/spells/SPIDER.tscn',
        {'upkeep': 10, 'attack': 4, 'health': 12}
    ),
    spells.VOID_RAY: Spell.new(
        'Void Ray',
        'Pure void energy extends from you to the target. Not many things survive that.',
        50,
        100,
        targeting.ANY_VISIBILE,
        'res://scenes/spells/VOID_RAY.tscn',
        {'upkeep': 0, 'attack': 25, 'health': 0}
    ),
    spells.ROOTS: Spell.new(
        'Roots',
        'Summon some roots to grab an enemy and hold them in place',
        10,
        20,
        targeting.ANY_VISIBILE,
        'res://scenes/spells/ROOTS.tscn'
    ),
    spells.BARRIER: Spell.new(
        'Shimmering Barrier',
        'Surround yourself with a barrier that blocks damage',
        10,
        20,
        targeting.SELF,
        'res://scenes/spells/BARRIER.tscn'
    ),
    spells.CLEAR_FOG: Spell.new(
        'Clear Fog',
        'Clear a small amount of foggy clouds. Enemies wake up if you cast this on them!',
        0,
        2,
        targeting.ANY_VISIBILE,
        'res://scenes/spells/CLEAR_FOG.tscn'
    )
}


func summon_check_for_items(summon):
    for mapitem in get_tree().get_nodes_in_group("map_items"):
        if Globals.position_to_grid(mapitem.position) \
            == Globals.position_to_grid(summon.position):
            mapitem.gain_item()


func summon_move_to(summon, target_tile):
    # if movable, then move there
    if target_tile.has_enemy():
        var enemy = target_tile.has_enemy()
        enemy.take_damage(summon.attack)
    elif target_tile.is_moveable():
        summon.position = target_tile.position
        # check if there is an item on this tile
        summon_check_for_items(summon)
    summon.game_manager.map.clear_fov_at_position(summon.position, 2)
    summon.game_manager.end_turn()


func summon_take_damage(summon, amount):
    Globals.show_damage((summon.position + Vector2(-16, -16)), amount)
    summon.health -= amount
    var new_val = float(summon.health) / float(SpellData.defs[summon.spell].health) * 100.0
    summon.get_node('HealthBar').value = new_val
    if summon.health <= 0:
        # do an animation or something
        var game_manager = summon.game_manager
        game_manager.map.disable_tile_highlights()
        summon.queue_free()
        game_manager.update_per_turn_numbers()
