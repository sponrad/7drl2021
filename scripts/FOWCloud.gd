extends Sprite


var total_time = randf() * 1
var start_pos: Vector2
var fading_off = false
var opacity = 1.0
var fade_direction
var velocity = 200


func _ready():
    var angle = randf() * 2 * PI
    fade_direction = Vector2(cos(angle), -1)
    start_pos = position
    z_index = (randi() % 10) * -1
    position.y += (randi() % 6) - 3

func _process(delta):
    if fading_off:
        position = position + fade_direction.normalized() * delta * velocity
        opacity -= delta
        modulate.a = opacity
        if opacity < 0:
            queue_free()
    else:
        #sway side to side by a few pixels
        total_time += delta
        position = start_pos + Vector2(sin(total_time) * 2, 0)

func fade_off():
    fading_off = true
