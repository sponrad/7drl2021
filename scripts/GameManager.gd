extends Node2D

# current amount of each resource we have
var curFood : int = 0
var curMetal : int = 0
var curOxygen : int = 0
var curEnergy : int = 0

# amount of each resource we get each turn
var foodPerTurn : int = 0
var metalPerTurn : int = 0
var oxygenPerTurn : int = 0
var energyPerTurn : int = 0

var curTurn : int = 1

# are we currently placing down a building?
var currentlyPlacingBuilding : bool = false

var currentlyCastingSpell: bool = false
var spellToCast: int

# type of building we're currently placing
var buildingToPlace : int

# components
onready var ui : Node = get_node("UI")
onready var map : Node = get_node("Tiles")


func _ready ():
    randomize()
    $Wizard.position = Globals.wizard_start * Vector2(64, 64)
    map.generate_map()
    # update the UI when the game rstarts
    ui.update_resource_text()
    ui.on_end_turn()

func generate_monsters():
    pass

# called when the player ends the turn
func end_turn ():

    # update our current resource amounts
    curFood += foodPerTurn
    curMetal += metalPerTurn
    curOxygen += oxygenPerTurn
    curEnergy += energyPerTurn

    # increase current turn
    curTurn += 1

    # update the UI
    ui.update_resource_text()
    ui.on_end_turn()

# called when we've selected a building to place
func on_select_building (buildingType):

    currentlyPlacingBuilding = true
    buildingToPlace = buildingType

    # highlight the tiles we can place a building on
    map.highlight_available_tiles()

func on_select_spell(spell):
    currentlyCastingSpell = true
    spellToCast = spell
    map.highlight_available_tiles()

func cancel_spell_cast():
    currentlyCastingSpell = false
    map.disable_tile_highlights()
    ui.set_casting_spell_icon(false)

func cast_spell(tileToCastOn):
    print('casting %s at %s' % [spellToCast, tileToCastOn.grid_position()])
    ui.set_casting_spell_icon(false)

# called when we place a building down on the grid
func place_building (tileToPlaceOn):

    currentlyPlacingBuilding = false

    var texture : Texture

    # are we placing down a Mine?
    if buildingToPlace == 1:
        texture = BuildingData.mine.iconTexture

        add_to_resource_per_turn(BuildingData.mine.prodResource, BuildingData.mine.prodResourceAmount)
        add_to_resource_per_turn(BuildingData.mine.upkeepResource, -BuildingData.mine.upkeepResourceAmount)

    # are we placing down a Greenhouse?
    elif buildingToPlace == 2:
        texture = BuildingData.greenhouse.iconTexture

        add_to_resource_per_turn(BuildingData.greenhouse.prodResource, BuildingData.greenhouse.prodResourceAmount)
        add_to_resource_per_turn(BuildingData.greenhouse.upkeepResource, -BuildingData.greenhouse.upkeepResourceAmount)

    # are we placing down a Solar Panel?
    elif buildingToPlace == 3:
        texture = BuildingData.solarpanel.iconTexture

        add_to_resource_per_turn(BuildingData.solarpanel.prodResource, BuildingData.solarpanel.prodResourceAmount)
        add_to_resource_per_turn(BuildingData.solarpanel.upkeepResource, -BuildingData.solarpanel.upkeepResourceAmount)

    # place the building on the map
    map.place_building(tileToPlaceOn, texture)

    # update the UI to show changes immediately
    ui.update_resource_text()

# adds an amount to a certain resource per turn
func add_to_resource_per_turn (resource, amount):

    # resource 0 means none, so return
    if resource == 0:
        return
    elif resource == 1:
        foodPerTurn += amount
    elif resource == 2:
        metalPerTurn += amount
    elif resource == 3:
        oxygenPerTurn += amount
    elif resource == 4:
        energyPerTurn += amount
