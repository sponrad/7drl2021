extends Node2D

var current_mana : int = 1
var mana_per_turn : int = 0
var power_per_turn : int = 0

var current_turn : int = 1

var currently_casting_spell: bool = false
var spell_to_cast: int

# components
onready var ui : Node = get_node("UI")
onready var map : Node = get_node("Tiles")


func _ready ():
    randomize()
    $Wizard.position = Globals.wizard_start * Vector2(64, 64)
    map.generate_map()
    # update the UI when the game rstarts
    ui.update_resource_text()
    ui.on_end_turn()

func generate_monsters():
    pass

# called when the player ends the turn
func end_turn ():
    # update our current resource amounts
    mana_per_turn = power_per_turn
    current_mana += mana_per_turn
    # increase current turn
    current_turn += 1
    # update the UI
    ui.update_resource_text()
    ui.on_end_turn()

func on_select_spell(spell):
    if (current_mana < SpellData.defs[spell].cost):
        ui.set_casting_spell_icon(false)
        #message!
        return
    currently_casting_spell = true
    spell_to_cast = spell
    map.highlight_available_tiles()

func cancel_spell_cast():
    currently_casting_spell = false
    map.disable_tile_highlights()
    ui.set_casting_spell_icon(false)

func cast_spell(target_tile):
    current_mana -= SpellData.defs[spell_to_cast].cost
    map.disable_tile_highlights()
    ui.set_casting_spell_icon(false)
    var spell_scene = load(SpellData.defs[spell_to_cast].scene_path)
    var spell = spell_scene.instance()
    spell.position = target_tile.position
    add_child(spell)

func add_to_power_per_turn(amount):
    power_per_turn += amount
    mana_per_turn = power_per_turn
    ui.update_resource_text()
