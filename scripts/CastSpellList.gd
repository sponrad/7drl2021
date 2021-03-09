extends ItemList


var selected_spell
var item_spells = []

onready var game_manager : Node = get_node("/root/MainScene")

func _ready():
    pass


func populate_spells(known_spells):
    clear()
    item_spells = []
    for spell in known_spells:
        var spell_def = SpellData.defs[spell]
        var text = "%s mana: %s" % [spell_def.cost, spell_def.name]
        add_item(text)
        item_spells.append(spell)


func _on_CastSpellList_item_selected(index):
    var picker = get_parent()
    selected_spell = item_spells[index]
    var spell_def = SpellData.defs[selected_spell]
    if (game_manager.current_mana >= spell_def.cost):
        picker.get_node('CastButton').disabled = false
    else:
        picker.get_node('CastButton').disabled = true
    picker.get_node('SpellName').text = spell_def.name
    var text = "%s\n\n\nCost: %s mana\nUpkeep: %s mana per turn" % [
        spell_def.description,
        spell_def.cost,
        spell_def.upkeep
    ]
    picker.get_node('SpellDescription').text = text
