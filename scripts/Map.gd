extends Node

# all the tiles in the game
var allTiles : Array

# size of a tile
var tileSize : float = 64.0
var dimensions : Vector2 = Vector2(19, 9)

var monster_scene = preload("res://scenes/Enemy.tscn")
var boss_scene = preload("res://scenes/BossEnemy.tscn")

onready var game_manager : Node = get_node("/root/MainScene")

func _ready ():
    # when we're initialized, get all of the tiles
    allTiles = get_tree().get_nodes_in_group("Tiles")

# returns a tile at the given position - returns null if no tile is found
func get_tile_at_position (position):
    # loop through all of the tiles
    for x in range(allTiles.size()):
        # if the tile matches our given position, return it
        if allTiles[x].position == position:
            return allTiles[x]
    return null

func get_tile_at_coords(coords:Vector2):
    for x in range(allTiles.size()):
        # if the tile matches our given position, return it
        if allTiles[x].grid_position() == coords:
            return allTiles[x]
    return null

# highlights the tiles we can cast spells
func highlight_available_tiles ():
    if game_manager.currently_casting_spell:
        var targeting = SpellData.defs[game_manager.spell_to_cast].targeting
        if targeting == SpellData.targeting.ANYWHERE:
            for tile in allTiles:
                if tile.grid_position() == Globals.wizard_start:
                    continue
                tile.toggle_highlight(true)
        elif targeting == SpellData.targeting.ANY_VISIBILE:
            for tile in allTiles:
                if tile.grid_position() == Globals.wizard_start \
                    or tile.fog_of_war == true:
                    continue
                tile.toggle_highlight(true)
        elif targeting == SpellData.targeting.NEXT_TO_WIZARD:
            var pos = Globals.wizard_start
            var adjacent_tiles = [
                get_tile_at_coords(Vector2(pos.x, pos.y - 1)),
                get_tile_at_coords(Vector2(pos.x + 1, pos.y - 1)),
                get_tile_at_coords(Vector2(pos.x + 1, pos.y)),
                get_tile_at_coords(Vector2(pos.x + 1, pos.y + 1)),
                get_tile_at_coords(Vector2(pos.x, pos.y + 1)),
            ]
            for tile in adjacent_tiles:
                tile.toggle_highlight(true)
        elif targeting == SpellData.targeting.ANY_FOG:
            for tile in allTiles:
                if tile.fog_of_war == true:
                    tile.toggle_highlight(true)
        elif targeting == SpellData.targeting.ITEM:
            for tile in allTiles:
                if tile.has_item():
                    tile.toggle_highlight(true)
        elif targeting == SpellData.targeting.SELF:
            var pos = Globals.wizard_start
            get_tile_at_coords(pos).toggle_highlight(true)

    elif game_manager.currently_moving_summon:
        var summon = game_manager.current_summon
        var pos = get_tile_at_position(summon.position).grid_position()
        var adjacent_tiles = [
            get_tile_at_coords(Vector2(pos.x - 1, pos.y)),
            get_tile_at_coords(Vector2(pos.x, pos.y - 1)),
            get_tile_at_coords(Vector2(pos.x + 1, pos.y)),
            get_tile_at_coords(Vector2(pos.x, pos.y + 1)),
        ]
        for tile in adjacent_tiles:
            if tile.is_moveable():
                tile.toggle_highlight(true)

# disables all of the tile highlights
func disable_tile_highlights ():
    for x in range(allTiles.size()):
        allTiles[x].toggle_highlight(false)


func generate_map():
    for x in range(len(allTiles)):
        var grid_position = allTiles[x].grid_position()
        if grid_position.x in [0, 19] or grid_position.y in [0, 8]:
            var chance = randi() % 100
            allTiles[x].set_type(TileData.tile_types.WATER)
            if chance > 90:
                allTiles[x].place_feature(TileData.feature_types.SHRUB)
            elif chance > 98:
                # very special water feature
                pass
        elif not grid_position.x in [1, 18] and not grid_position.y in [1, 7]:
            allTiles[x].set_type(TileData.tile_types.GRASS)
            var chance = randi() % 100
            if chance > 50:
                chance = randi() % 100
                if chance > 30 and chance < 60:
                    allTiles[x].set_type(TileData.tile_types.GRASS_TREE)
                    allTiles[x].feature_type = TileData.feature_types.TREE
                elif chance >= 60 and chance < 80:
                    allTiles[x].place_feature(TileData.feature_types.ROCK_GRAY)
                elif chance >= 80:
                    # some special thing?
                    pass
        elif grid_position == Globals.wizard_start:
            continue
        else:
            #sand
            var chance = randi() % 100
            if chance > 70:
                var second_chance = randi() % 100
                if second_chance > 30:
                    allTiles[x].place_feature(TileData.feature_types.ROCK_BROWN)
                else:
                    allTiles[x].place_feature(TileData.feature_types.LOG)
            elif chance > 98:
                allTiles[x].place_feature(TileData.feature_types.FIRE)
        if allTiles[x].feature_type == null \
            and allTiles[x].tile_type != TileData.tile_types.WATER \
            and (randi() % 100 + grid_position.x - Globals.wizard_start.x) > 90:
            var monster = monster_scene.instance()
            add_child(monster)
            monster.position = grid_position * Vector2(64, 64)
        elif randi() % 100 > 90 \
            and allTiles[x].is_moveable() \
            and allTiles[x].tile_type != TileData.tile_types.WATER:
            game_manager.spawn_item(grid_position)
    # spawn the boss on a random tile on the last row, replace feature and enemy if they were there
    var boss_coord = Vector2(18, randi() % 8 + 1)
    var tile = get_tile_at_coords(boss_coord)
    if tile.has_enemy():
        tile.has_enemy().queue_free()
    tile.clear_feature()
    var boss = boss_scene.instance()
    boss.position = Globals.grid_to_position(boss_coord)
    add_child(boss)

func clear_player_fov():
    for tile in allTiles:
        if tile.grid_position().distance_to(Globals.wizard_start) < 2:
            tile.clear_fog()

func get_visible_tiles():
    var ret = []
    for tile in allTiles:
        if not tile.fog_of_war:
            ret.append(tile)
    return ret

func show_visible_tile_power(show):
    for tile in get_visible_tiles():
        tile.show_tile_power(show)

func clear_fov_at_position(position, clear_range):
    var grid_coord = Globals.position_to_grid(position)
    for tile in allTiles:
        if tile.grid_position().distance_to(grid_coord) <= clear_range:
            tile.clear_fog()
