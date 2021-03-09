extends Area2D

var known_spells: Array = []
var is_casting = false

func _ready():
    known_spells = [
        SpellData.spells.ENCHANT_AREA,
        SpellData.spells.FAR_SIGHT,
        SpellData.spells.MAGIC_SPIRIT,
        SpellData.spells.FIRE_BOLT,
        SpellData.spells.CRAB,
    ]

func _process(delta):
    if is_casting:
        $CastingSwirl.rotate(delta * 1.5)

func set_casting(casting):
    is_casting = casting
    if casting:
        $CastingSwirl.show()
    else:
        $CastingSwirl.hide()
