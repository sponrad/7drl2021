extends Node2D

var current_mana : int = 2
var mana_per_turn : int = 1
var power_per_turn : int = 1

var current_turn : int = 1

var currently_casting_spell: bool = false
var spell_to_cast: int

var current_summon
var currently_moving_summon: bool = false

# components
onready var ui : Node = get_node("UIZINDEX/UI")
onready var map : Node = get_node("Tiles")

var paused = false


func _ready ():
    randomize()
    $Wizard.position = Globals.wizard_start * Vector2(64, 64)
    map.generate_map()
    # clear fog of war by the wizard
#    map.clear_player_fov()
#    ui.update_resource_text()
#    ui.on_end_turn()

func start():
    map.clear_player_fov()
    ui.update_resource_text()
    ui.on_end_turn()

func set_paused(pause):
    print('setting paused to %s' % pause)
    paused = pause

# called when the player ends the turn
func end_turn ():
    if paused:
        # someone better unpause us!
        return
    # update our current resource amounts
    var summon_upkeep = 0
    if current_summon:
        summon_upkeep = SpellData.defs[current_summon.spell].upkeep
    mana_per_turn = power_per_turn - summon_upkeep
    current_mana += mana_per_turn
    # increase current turn
    current_turn += 1
    for monster in get_tree().get_nodes_in_group("monsters"):
        if monster.awake:
            monster.take_turn()
    ui.update_resource_text()
    ui.on_end_turn()
    if current_summon and current_summon.health > 0:
        start_move_summon()

func on_select_spell(spell):
    $Wizard.set_casting(true)
    if (current_mana < SpellData.defs[spell].cost):
        ui.set_casting_spell_icon(false)
        #message!
        return
    if (spell == SpellData.spells.ENCHANT_AREA):
        map.show_visible_tile_power(true)
    currently_casting_spell = true
    currently_moving_summon = false
    spell_to_cast = spell
    map.highlight_available_tiles()

func cancel_spell_cast():
    $Wizard.set_casting(false)
    currently_casting_spell = false
    map.disable_tile_highlights()
    map.show_visible_tile_power(false)
    ui.set_casting_spell_icon(false)

func cast_spell(target_tile):
    if paused:
        return
    current_mana -= SpellData.defs[spell_to_cast].cost
    #ui.update_resource_text()
    map.disable_tile_highlights()
    map.show_visible_tile_power(false)
    ui.set_casting_spell_icon(false)
    var spell_scene = load(SpellData.defs[spell_to_cast].scene_path)
    var spell = spell_scene.instance()
    spell.position = target_tile.position
    add_child(spell)
    currently_casting_spell = false
    $Wizard.set_casting(false)
    if spell.get('will_handle_end_of_turn') == null:
        end_turn()
    else:
        print('skipping end turn call on cast_spell')

func add_to_power_per_turn(amount):
    power_per_turn += amount
    mana_per_turn = power_per_turn
    ui.update_resource_text()

func start_move_summon():
    map.disable_tile_highlights()
    currently_moving_summon = true
    map.highlight_available_tiles()

func move_summon(target_tile):
    if paused:
        return
    current_summon.move_to(target_tile)

func game_over():
    $UIZINDEX/GameOver.show()

func _on_Restart_pressed():
    get_tree().reload_current_scene()

func spawn_item(grid_pos):
    # need to intelligently put an item here,
    # items can be on top of some otherwise inaccessible features
    # for tomes we dont want to duplicate spells available in tomes, so track them
    # we also dont want to spawn a tome for a spell that the wizard already has access to
    print('spawning item at %s' % grid_pos)
    var item = ItemData.mapitem_scene.instance()
    item.position = Globals.grid_to_position(grid_pos)
    add_child(item)
    
