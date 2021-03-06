extends Node

# all the tiles in the game
var allTiles : Array

# all the tiles which have buildings on them
var tilesWithBuildings : Array

# size of a tile
var tileSize : float = 64.0
var dimensions : Vector2 = Vector2(19, 9)

func _ready ():

    # when we're initialized, get all of the tiles
    allTiles = get_tree().get_nodes_in_group("Tiles")

    # find the start tile and place the Base building
    for x in range(allTiles.size()):
        if allTiles[x].startTile == true:
            place_building(allTiles[x], BuildingData.base.iconTexture)

# returns a tile at the given position - returns null if no tile is found
func get_tile_at_position (position):

    # loop through all of the tiles
    for x in range(allTiles.size()):
        # if the tile matches our given position, return it
        if allTiles[x].position == position and allTiles[x].hasBuilding == false:
            return allTiles[x]

    return null

# highlights the tiles we can place buildings on
func highlight_available_tiles ():

    # loop through all of the tiles with buildings
    for x in range(tilesWithBuildings.size()):

        # get the tile north, south, east and west of this one
        var northTile = get_tile_at_position(tilesWithBuildings[x].position + Vector2(0, tileSize))
        var southTile = get_tile_at_position(tilesWithBuildings[x].position + Vector2(0, -tileSize))
        var eastTile = get_tile_at_position(tilesWithBuildings[x].position + Vector2(tileSize, 0))
        var westTile = get_tile_at_position(tilesWithBuildings[x].position + Vector2(-tileSize, 0))

        # if the directional tiles aren't null, toggle their highlight - allowing us to build
        if northTile != null:
            northTile.toggle_highlight(true)
        if southTile != null:
            southTile.toggle_highlight(true)
        if eastTile != null:
            eastTile.toggle_highlight(true)
        if westTile != null:
            westTile.toggle_highlight(true)

# disables all of the tile highlights
func disable_tile_highlights ():

    for x in range(allTiles.size()):
        allTiles[x].toggle_highlight(false)

# places down a building on the map
func place_building (tile, texture):

    tilesWithBuildings.append(tile)
    tile.place_building(texture)

    disable_tile_highlights()

func generate_map():
    print('generating that map')
    for x in range(len(allTiles)):
        var grid_position = allTiles[x].grid_position()
        if grid_position.x in [0, 19] or grid_position.y in [0, 8]:
            allTiles[x].set_type(Globals.tile_data.types.WATER)

func print_map_tile_integers():
    # debug function to write out a tilemap
    print('getting tile integers')
    for tile in allTiles:
        # find the Globals.tile_paths
        # print(tile.get_node('Ground').texture.load_path)
        print(tile.grid_position())
