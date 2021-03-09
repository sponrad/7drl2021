extends Area2D

onready var game_manager : Node = get_node("/root/MainScene")
var spell = SpellData.spells.MAGIC_SPIRIT
var health = SpellData.defs[spell].health
var attack = SpellData.defs[spell].attack

func _ready():
    game_manager.map.clear_fov_at_position(position, 2)
    if game_manager.current_summon:
        game_manager.current_summon.take_damage(10000)
    game_manager.current_summon = self

func move_to(target_tile):
    # if movable, then move there
    if target_tile.has_enemy():
        print('yeah we go one')
        var enemy = target_tile.has_enemy()
        enemy.take_damage(attack)
    elif target_tile.is_moveable():
        position = target_tile.position
    game_manager.map.clear_fov_at_position(position, 2)
    game_manager.end_turn()

func take_damage(amount):
    Globals.show_damage((position + Vector2(-16, -16)), amount)
    health -= amount
    var new_val = float(health) / float(SpellData.defs[spell].health) * 100.0
    $HealthBar.value = new_val
    if health <= 0:
        # do an animation or something
        queue_free()
