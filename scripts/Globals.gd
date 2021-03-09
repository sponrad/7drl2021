extends Node

var wizard_start: Vector2 = Vector2(1, 4)

func position_to_grid(position):
    return Vector2(
        int(position.x) / 64,
        int(position.y) / 64
    )
