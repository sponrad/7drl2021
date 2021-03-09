extends Area2D

var typeTileMaps = {}
var type: int = EnemyData.types.SKELETON
var awake = false
# these get updated down in _ready
var health: int = 0
var attack: int = 0

onready var game_manager : Node = get_node("/root/MainScene")

# Called when the node enters the scene tree for the first time.
func _ready():
    typeTileMaps = {
        EnemyData.types.DEMON: $RedDemon,
        EnemyData.types.MAGE: $PurpleMage,
        EnemyData.types.BLOB: $BlueBlob,
        EnemyData.types.SKELETON: $OrangeSkel,
    }
    var chance = randi() % 100
    if chance > 50 and chance < 75:
        type = EnemyData.types.BLOB
    elif chance >= 75 and chance < 95:
        type = EnemyData.types.DEMON
    elif chance >= 95:
        type = EnemyData.types.MAGE
    for tilemap in typeTileMaps.values():
        tilemap.hide()
    typeTileMaps[type].show()
    health = EnemyData.defs[type].health
    attack = EnemyData.defs[type].attack
    add_to_group("monsters")

func grid_position():
    return Vector2(
        int(position.x) / 64,
        int(position.y) / 64
    )

func awaken():
    $AsleepText.hide()
    $HealthBar.show()
    awake = true

func take_turn():
    pass

func take_damage(amount):
    print('enemy taking damage %s of %s' % [amount, health])
    awaken()
    health -= amount
    var max_health = EnemyData.defs[type].health
    print(health)
    var new_val = float(health) / float(max_health) * 100.0
    $HealthBar.value = new_val
    if health <= 0:
        queue_free()
