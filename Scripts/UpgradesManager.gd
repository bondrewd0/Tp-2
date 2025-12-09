extends Node

var Cannon_counter:int=10
var current_cannons:int=2
var Max_speed_upgrades:int=10
var Max_HP_upgrades:int=20
var current_hp_upgrade:int=0
var current_speed_upgrade:int=0
var Current_ship:int=0
var player_ref:PlayerShip=null
var vessel_ref:Vessel=null
const TEST_CANNON = preload("uid://dsdkpd6l22k5j")
const IMPERIAL_SHIP = preload("uid://dcl547k5hqih4")
const INSURGENT = preload("uid://sshykcxpid3")
const ZENITH = preload("uid://bl54v6k1upv11")



func initiate(player:PlayerShip):
	player_ref=player
	vessel_ref=player.Currrent_Vessel
	Cannon_counter= player_ref.Currrent_Vessel.Max_Cannons
	current_cannons=vessel_ref.Current_Cannons
func place_turrets():
	
	print("changing turrets")
	player_ref.remove_cannons()
	player_ref.Currrent_Vessel.add_mounts_to_list()
	var positions:Array[Marker3D]=player_ref.Currrent_Vessel.Cannon_mounts
	var placed_cannons:int=0
	for pos in positions:
		if placed_cannons<=current_cannons:
			var cannon_ins=TEST_CANNON.instantiate()
			player_ref.Currrent_Vessel.add_child(cannon_ins)
			cannon_ins.global_position=pos.global_position
			cannon_ins.rotation=pos.rotation
			cannon_ins.scale=pos.scale
			placed_cannons+=1
		else: return

func upgrade_speed(value:float):
	print("Upgrading speed")
	player_ref.max_speed+=value
	current_speed_upgrade+=1

func upgrade_health(value:int):
	print("Upgrading health")
	print(value)
	current_hp_upgrade+=1
	pass

func increase_turrets():
	current_cannons+=2
	vessel_ref.Current_Cannons=current_cannons
	place_turrets()

func upgrade_vessel():
	print("upgrading vessel")
	Current_ship+=1
	if Current_ship>=2:
		Current_ship=2
	change_vessel()

func change_vessel():
	print("changing vessel: ", Current_ship)
	var vessel_ins=null
	match Current_ship:
		0:
			vessel_ins=ZENITH.instantiate()
		1:
			vessel_ins=INSURGENT.instantiate()
		2:
			vessel_ins=IMPERIAL_SHIP.instantiate()
	player_ref.Currrent_Vessel.queue_free()
	player_ref.Currrent_Vessel=null
	player_ref.add_child(vessel_ins)
	player_ref.Currrent_Vessel=vessel_ins
