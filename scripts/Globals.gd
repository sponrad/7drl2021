extends Node

var wizard_start: Vector2 = Vector2(1, 4)

func position_to_grid(position):
    return Vector2(
        int(position.x) / 64,
        int(position.y) / 64
    )

var DamageNumber = preload("res://scenes/DamageNumber.tscn")

func show_damage(position, amount):
    print('spawning damage node at %s' % position)
    var damage = DamageNumber.instance()
    damage.position = position
    damage.set_text(str(amount))
    add_child(damage)
