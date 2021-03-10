extends Area2D

var typeTileMaps = []
var type
var spell_type
var direction
var velocity = 500
var traveling = false

onready var game_manager : Node = get_node("/root/MainScene")

func _ready():
    typeTileMaps = {
        ItemData.types.SPELLBOOK: $SpellBook,
        ItemData.types.POWER_INC: $PowerNode,
        ItemData.types.MANA_INC: $ManaNode,
        ItemData.types.POWER: $PowerBurst
    }
    # should have a higher chance for spellbook
    type = randi() % len(ItemData.types)
    if type == ItemData.types.SPELLBOOK:
        spell_type = ItemData.find_unique_spell(
            game_manager.get_node('Wizard'))
        if not spell_type:
            type = ItemData.types.POWER_INC
    for tilemap in typeTileMaps.values():
        tilemap.hide()
    typeTileMaps[type].show()
    add_to_group("map_items")
    direction = game_manager.get_node('Wizard').position - position
    set_process(false)

func _process(delta):
    position += direction.normalized() * velocity * delta
    if Globals.position_to_grid(position) == Globals.wizard_start:
        # display some neat text here
        get_item_effect()
        queue_free()

func gain_item():
    set_process(true)

func get_item_effect():
    if type == ItemData.types.SPELLBOOK:
        game_manager.get_node('Wizard').discovered_spells.append(spell_type)
    elif type == ItemData.types.POWER_INC:
        game_manager.power_per_turn += 1
    elif type == ItemData.types.MANA_INC:
        game_manager.current_mana += 1
    elif type == ItemData.types.POWER:
        # do a burst to mana and research
        pass
