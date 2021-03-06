extends Node

var tile_data = TileInfo.new()

class TileInfo:
    enum types {
        DESERT,
        GRASS_ROAD,
        SNOW_ROAD,
        DIRT,
        STONE,
        WATER,
        SNOW,
        GRASS_TREE,
        GRASS_OTHER,
        GRASS,
    }

    var type_sprites = {
        types.DESERT: [
            preload("res://sprites/Kenney/Tile/medievalTile_01.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_02.png"),
        ],
        types.GRASS_ROAD: [
            preload("res://sprites/Kenney/Tile/medievalTile_03.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_04.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_05.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_06.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_07.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_17.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_18.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_19.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_20.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_21.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_31.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_32.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_33.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_34.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_35.png"),
        ],
        types.SNOW_ROAD: [
            preload("res://sprites/Kenney/Tile/medievalTile_08.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_09.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_10.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_11.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_12.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_22.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_23.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_24.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_25.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_26.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_36.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_37.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_38.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_39.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_40.png"),
        ],
        types.DIRT: [
            preload("res://sprites/Kenney/Tile/medievalTile_13.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_14.png"),
        ],
        types.STONE: [
            preload("res://sprites/Kenney/Tile/medievalTile_15.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_16.png"),
        ],
        types.WATER: [
            preload("res://sprites/Kenney/Tile/medievalTile_27.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_28.png"),
        ],
        types.SNOW: [
            preload("res://sprites/Kenney/Tile/medievalTile_29.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_30.png"),
        ],
        types.GRASS_TREE: [
            preload("res://sprites/Kenney/Tile/medievalTile_41.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_42.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_43.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_44.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_45.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_46.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_47.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_48.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_49.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_50.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_51.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_52.png"),
        ],
        types.GRASS_OTHER: [
            preload("res://sprites/Kenney/Tile/medievalTile_53.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_54.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_55.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_56.png"),
        ],
        types.GRASS: [
            preload("res://sprites/Kenney/Tile/medievalTile_57.png"),
            preload("res://sprites/Kenney/Tile/medievalTile_58.png"),
        ],
       }
