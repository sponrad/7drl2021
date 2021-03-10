extends Node

var wizard_start: Vector2 = Vector2(1, 4)

func position_to_grid(position):
    return Vector2(
        int(position.x) / 64,
        int(position.y) / 64
    )
    
func grid_to_position(grid):
    return grid * Vector2(64, 64)

var DamageNumber = preload("res://scenes/DamageNumber.tscn")

func show_damage(position, amount):
    var damage = DamageNumber.instance()
    damage.position = position
    damage.set_text(str(amount))
    add_child(damage)
