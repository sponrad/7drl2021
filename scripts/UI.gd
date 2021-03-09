extends Control

# container holding the building buttons
onready var actionButtons : Node = get_node("ActionButtons")

onready var mana_power_text : Label = get_node("ManaPowerText")

# text showing our current turn
onready var curTurnText : Label = get_node("TurnText")

# game manager object in order to access those functions and values
onready var game_manager : Node = get_node("/root/MainScene")

var cast_spell_icon = preload("res://sprites/Kenney/Environment/medievalEnvironment_21.png")
var cancel_cast_icon = preload("res://sprites/X.png")

func _ready():
    hide()
    get_parent().get_node("StartSplash").show()

func _input(event):
    if event.is_action_pressed('ui_spellpicker'):
        _on_SelectCastButton_pressed()
    elif event.is_action_pressed('ui_cast_spell'):
        if $SpellPicker.get_node("CastSpellList").selected_spell:
            _on_CastButton_pressed()
    elif event.is_action_pressed('ui_select'):
        if get_parent().get_node("StartSplash").visible:
            _on_StartButton_pressed()
        elif get_parent().get_node("GameOver").visible:
            game_manager._on_Restart_pressed()
        else:
            game_manager.end_turn() # calling twice...

# called when a turn is over - resets the UI
func on_end_turn():
    # update the cur turn text and enable the building buttons
    curTurnText.text = "Turn: " + str(game_manager.current_turn)
    actionButtons.visible = true

# updates the resource text to show the current values
func update_resource_text():
    var manaPower = ""
    # sets the text, e.g. "13 (+5)"
    manaPower += str(game_manager.current_mana)
    manaPower += " (" + ("+" if game_manager.mana_per_turn >= 0 else "")
    manaPower += str(game_manager.mana_per_turn) + ")"
    manaPower += "\n"
    manaPower += str(game_manager.power_per_turn)
    mana_power_text.text = manaPower

# called when the "End Turn" button is pressed
func _on_EndTurnButton_pressed ():
    game_manager.end_turn()


func _on_print_map_pressed():
    game_manager.map.print_map_tile_integers()


func _on_SelectCastButton_pressed():
    if $SpellPicker.visible or game_manager.currently_casting_spell:
        $SpellPicker.hide()
        game_manager.cancel_spell_cast()
    else:
        $SpellPicker.popup()
        game_manager.map.disable_tile_highlights()
    $SpellPicker.get_node('CastSpellList').populate_spells(game_manager.get_node('Wizard').known_spells)

func _on_CastButton_pressed():
    var spell = $SpellPicker.get_node("CastSpellList").selected_spell
    print('casting %s' % SpellData.defs[spell].name)
    $SpellPicker.hide()
    # change the image on the
    set_casting_spell_icon(true)
    game_manager.on_select_spell(spell)

func set_casting_spell_icon(casting):
    if casting:
        actionButtons.get_node("SelectCastButton").icon = cancel_cast_icon
    else:
        actionButtons.get_node("SelectCastButton").icon = cast_spell_icon

func _on_StatsButton_pressed():
    print('pressed stats')

func _on_ResearchButton_pressed():
    print('pressed research')

func _on_HelpButton_pressed():
    if $HelpDialog.visible:
        $HelpDialog.hide()
    else:
        $HelpDialog.popup()

func _on_StartButton_pressed():
    game_manager.start()
    show()
    get_parent().get_node("StartSplash").hide()
