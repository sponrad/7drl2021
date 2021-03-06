extends Area2D

var typeTileMaps = []
var type
var spell_type
var direction
var velocity = 500
var wizard_pos

onready var game_manager : Node = get_node("/root/MainScene")

func _ready():
    typeTileMaps = {
        ItemData.types.SPELLBOOK: $SpellBook,
        ItemData.types.POWER_INC: $PowerNode,
        ItemData.types.MANA_INC: $ManaNode,
        ItemData.types.POWER: $PowerBurst
    }
    # should have a higher chance for spellbook
    var chance = randi() % 100
    if chance < 30:
        type = ItemData.types.SPELLBOOK
    elif chance < 65:
        type = ItemData.types.MANA_INC
    elif chance < 85:
        type = ItemData.types.POWER_INC
    else:
        type = ItemData.types.POWER
    if type == ItemData.types.SPELLBOOK:
        spell_type = ItemData.find_unique_spell(
            game_manager.get_node('Wizard'))
        if typeof(spell_type) != TYPE_INT:
            type = ItemData.types.POWER_INC
    for tilemap in typeTileMaps.values():
        tilemap.hide()
    typeTileMaps[type].show()
    add_to_group("map_items")
    direction = game_manager.get_node('Wizard').position - position
    set_process(false)
    wizard_pos = game_manager.get_node('Wizard').position

func _process(delta):
    position += direction.normalized() * velocity * delta
    if position.distance_to(wizard_pos) <= 64:
        # display some neat text here
        get_item_effect()
        queue_free()

func gain_item():
    # set velocity here
    velocity = position.distance_to(wizard_pos) * 4
    set_process(true)

func get_name():
    if type == ItemData.types.SPELLBOOK:
        return "spell: %s" % SpellData.defs[spell_type].name
    elif type == ItemData.types.POWER_INC:
        return "Power +1"
    elif type == ItemData.types.MANA_INC:
        return "Mana +10"
    elif type == ItemData.types.POWER:
        return "Mana +30"

func get_item_effect():
    var message = ""
    if type == ItemData.types.SPELLBOOK:
        game_manager.get_node('Wizard').discovered_spells.append(spell_type)
        message = "Gained spell: %s" % SpellData.defs[spell_type].name
    elif type == ItemData.types.POWER_INC:
        game_manager.power_per_turn += 1
        message = "Power +1"
    elif type == ItemData.types.MANA_INC:
        game_manager.current_mana += 10
        message = "Mana +10"
    elif type == ItemData.types.POWER:
        game_manager.current_mana += 30
        message = "Mana +30"
    game_manager.get_node('Wizard').show_message(message)
    game_manager.update_per_turn_numbers()
    game_manager.ui.update_resource_text()
