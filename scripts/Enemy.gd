extends Area2D

var typeTileMaps = {}
var typeCorpseTileMaps = {}
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
    typeCorpseTileMaps = {
        EnemyData.types.DEMON: $RedDemonCorpse,
        EnemyData.types.MAGE: $PurpleMageCorpse,
        EnemyData.types.BLOB: $BlueBlobCorpse,
        EnemyData.types.SKELETON: $OrangeSkelCorpse,
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
    var target_grid_pos: Vector2
    var current_grid = Globals.position_to_grid(position)
    var summon_distance = null
    var wizard_distance = current_grid.distance_to(Globals.wizard_start)
    var enemy
    if game_manager.current_summon:
        summon_distance = current_grid.distance_to(
            Globals.position_to_grid(game_manager.current_summon.position))
    if summon_distance and summon_distance <= wizard_distance:
        target_grid_pos = Globals.position_to_grid(game_manager.current_summon.position)
        enemy = game_manager.current_summon
    else:
        target_grid_pos = Globals.wizard_start
        enemy = game_manager.get_node('Wizard')
    if EnemyData.defs[type].attack_range >= target_grid_pos.distance_to(current_grid):
        print('performing a.. RANGED ATTACK')
        enemy.take_damage(attack)
        return
    var most_desired_direction = current_grid.direction_to(target_grid_pos)
    var desired_directions = []
    if abs(most_desired_direction.x) > abs(most_desired_direction.y):
        desired_directions.append(Vector2(most_desired_direction.x, 0).normalized())
        desired_directions.append(Vector2(0, most_desired_direction.y).normalized())
        desired_directions.append(Vector2(0, -most_desired_direction.y).normalized())
        desired_directions.append(Vector2(-most_desired_direction.x, 0).normalized())
    else:
        desired_directions.append(Vector2(0, most_desired_direction.y).normalized())
        desired_directions.append(Vector2(most_desired_direction.x, 0).normalized())
        desired_directions.append(Vector2(most_desired_direction.x, 0).normalized())
        desired_directions.append(Vector2(0, most_desired_direction.y).normalized())
    for direction in desired_directions:
        var tile = game_manager.map.get_tile_at_coords(current_grid + direction)
        if tile.is_moveable() and not tile.has_enemy():
            # could also track the last ~3 tiles to see if we have been in one recently and skip
            return move_to(tile)

func move_to(target_tile):
    # if movable, then move there
    if game_manager.current_summon \
        and Globals.position_to_grid(game_manager.current_summon.position) \
            == target_tile.grid_position():
        var enemy = game_manager.current_summon
        enemy.take_damage(attack)
    elif target_tile.grid_position() == Globals.wizard_start:
        game_manager.get_node('Wizard').take_damage(attack)
    elif target_tile.is_moveable() and not target_tile.has_enemy():
        position = target_tile.position - Vector2(32, 32)

func take_damage(amount):
    Globals.show_damage((position + Vector2(24, 0)), amount)
    awaken()
    health -= amount
    $HealthBar.value = float(health) / float(EnemyData.defs[type].health) * 100.0
    if health <= 0:
        awake = false
        $HealthBar.hide()
        remove_from_group('monsters')
        for tilemap in typeTileMaps.values():
            tilemap.hide()
        typeCorpseTileMaps[type].show()
        # maybe spawn an item
        if randi() % 100 > 70:
            game_manager.spawn_item(grid_position())
        # reward some mp
