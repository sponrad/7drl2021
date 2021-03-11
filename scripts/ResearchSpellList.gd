extends ItemList


var selected_spell
var item_spells = []

onready var game_manager : Node = get_node("/root/MainScene")

func _ready():
    pass


func populate_spells(discovered_spells):
    clear()
    item_spells = []
    for spell in discovered_spells:
        var spell_def = SpellData.defs[spell]
        var text = "%s" % spell_def.name
        add_item(text)
        item_spells.append(spell)


func _on_ResearchSpellList_item_selected(index):
    var picker = get_parent()
    selected_spell = item_spells[index]
    var spell_def = SpellData.defs[selected_spell]
    if (game_manager.current_mana >= spell_def.research_cost):
        picker.get_node("ResearchSpellButton").disabled = false
    else:
        picker.get_node("ResearchSpellButton").disabled = true
    picker.get_node('SpellName').text = spell_def.name
    var text = "%s\n\nResearch Cost: %s mana\nCast Cost: %s mana\nUpkeep: %s mana per turn\nAttack: %s\nHealth: %s" % [
        spell_def.description,
        spell_def.research_cost,
        spell_def.cost,
        spell_def.upkeep,
        spell_def.attack,
        spell_def.health,
    ]
    picker.get_node('SpellDescription').text = text


func _on_ResearchButton_pressed():
    pass # Replace with function body.
