extends Area2D


var known_spells: Array = []


# Called when the node enters the scene tree for the first time.
func _ready():
    known_spells = [
        SpellData.spells.ENCHANT_AREA,
        SpellData.spells.FAR_SIGHT,
        SpellData.spells.MAGIC_SPIRIT,
        SpellData.spells.FIRE_BOLT,
        SpellData.spells.IMP,
    ]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
