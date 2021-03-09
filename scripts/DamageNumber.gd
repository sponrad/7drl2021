extends Node2D

var velocity = 50
var opacity = 1.0


func _ready():
    pass # Replace with function body.


func _process(delta):
    position = position + Vector2.UP * delta * velocity
    opacity -= delta
    modulate.a = opacity


func set_text(text: String):
    $Label.text = text


func _on_Timer_timeout():
    queue_free()
