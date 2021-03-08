extends ItemList


var selected_spell
var item_spells = []

func _ready():
    pass


func populate_spells(known_spells):
    clear()
    item_spells = []
    for spell in known_spells:
        print(SpellData.defs[spell].name)
        add_item(SpellData.defs[spell].name)
        item_spells.append(spell)


func _on_CastSpellList_item_selected(index):
    var picker = get_parent()
    picker.get_node('CastButton').disabled = false
    selected_spell = item_spells[index]
    picker.get_node('SpellName').text = SpellData.defs[selected_spell].name
    picker.get_node('SpellDescription').text = SpellData.defs[selected_spell].description
