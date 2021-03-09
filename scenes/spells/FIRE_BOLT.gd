extends Area2D

var total_time = 0.0
onready var game_manager : Node = get_node("/root/MainScene")
var spell = SpellData.spells.FIRE_BOLT
var start_pos = (Globals.wizard_start * 64.0)
var end_pos: Vector2
var velocity = 500
var direction: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
    # adjust to get it closer to the staff
    start_pos.y += 30
    var tile = game_manager.map.get_tile_at_position(position)
    end_pos = position
    direction = position - start_pos
    rotation = direction.angle() - 0.5 * PI
    position = start_pos

func destroy(pos):
    # remove the power from the globals
    pass

func grid_position(pos):
    return Vector2(
        int(pos.x) / 64,
        int(pos.y) / 64
    )

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    position += direction.normalized() * velocity * delta
    if grid_position(position) == grid_position(end_pos):
        print('we made it!!')
        var tile = game_manager.map.get_tile_at_coords(grid_position(position))
        var enemy = tile.has_enemy()
        if enemy:
            enemy.take_damage(
                SpellData.defs[SpellData.spells.FIRE_BOLT].attack
            )
        queue_free()
