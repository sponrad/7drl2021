extends Node

enum types {
    SPELLBOOK,
    POWER_INC,      # add to current power
    MANA_INC,       # adds to current mana
    POWER           # power that gets split between mana and research
}

var mapitem_scene = preload('res://scenes/MapItem.tscn')

func find_unique_spell(wizard):
    var known_or_seen_or_spawned = wizard.known_spells \
        + wizard.discovered_spells
    for mapitem in get_tree().get_nodes_in_group("map_items"):
        if mapitem.type == types.SPELLBOOK:
            known_or_seen_or_spawned.append(mapitem.spell_type)
    var found_spell
    var attempts = 0
    while not found_spell:
        if attempts > 20:
            return false
        var spell = randi() % SpellData.spells.size()
        if not spell in known_or_seen_or_spawned:
            found_spell = spell
        attempts += 1
    return found_spell
