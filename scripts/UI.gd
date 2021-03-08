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


# called when a turn is over - resets the UI
func on_end_turn ():
    # update the cur turn text and enable the building buttons
    curTurnText.text = "Turn: " + str(game_manager.current_turn)
    actionButtons.visible = true

# updates the resource text to show the current values
func update_resource_text ():
    var manaPower = ""
    # sets the text, e.g. "13 (+5)"
    manaPower += str(game_manager.current_mana) + " (" + ("+" if game_manager.mana_per_turn >= 0 else "") + str(game_manager.mana_per_turn) + ")"
    manaPower += "\n"
    manaPower += str(game_manager.power_per_turn)
    mana_power_text.text = manaPower
    # set the food and metal text
#    var foodMetal = ""
#    # sets the text, e.g. "13 (+5)"
#    foodMetal += str(game_manager.curFood) + " (" + ("+" if game_manager.foodPerTurn >= 0 else "") + str(game_manager.foodPerTurn) + ")"
#    foodMetal += "\n"
#    foodMetal += str(game_manager.curMetal) + " (" + ("+" if game_manager.metalPerTurn >= 0 else "") + str(game_manager.metalPerTurn) + ")"
#    foodMetalText.text = foodMetal
    # set the oxygen and energy text
#    var oxygenEnergy = ""
#    # set the text, e.g. "13 (+5)"
#    oxygenEnergy += str(game_manager.curOxygen) + " (" + ("+" if game_manager.oxygenPerTurn >= 0 else "") + str(game_manager.oxygenPerTurn) + ")"
#    oxygenEnergy += "\n"
#    oxygenEnergy += str(game_manager.curEnergy) + " (" + ("+" if game_manager.energyPerTurn >= 0 else "") + str(game_manager.energyPerTurn) + ")"
#    oxygenEnergyText.text = oxygenEnergy

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

