extends Node3D


#can be edited to be as big or small as we want
#this is our grid size. we will edit it for our grids!!!
#should be multiples of 1 or 0.5 I think
var grid_step := 1.0
#should be adjusted to y value of the grid, allows us to move around the position
var grid_y = 0.5


var points := {}
var astar = AStar3D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var pathables = get_tree().get_nodes_in_group("pathable")
	_add_points(pathables)
	_connect_points()


func _add_points(pathables: Array):
	for pathable in pathables:
		var mesh = pathable.get_node("MeshInstance")
		var aabb: AABB = mesh.get_transformed_aabb()
		
		var start_point = aabb.position
		
		#needed for if we change the grid size.
		#allows our mesh and grid to be adjusted
		var x_steps = aabb.size.x / grid_step
		var z_steps = aabb.size.z /grid_step
		
		#finds our next point in the grid
		for x in x_steps:
			for z in z_steps:
				var next_point = start_point + Vector3(x * grid_step, 0 , z * grid_step)
				_add_point(next_point)
				

func _add_point(point: Vector3):
	point.y = grid_y
	
	var id = astar.get_available_point_id( )
	#creates a lookup table, so that for any world point
	#we can check if there exists a comparable astar point
	astar.add_point(id, point)
	points[world_to_astar(point)] = id

	
	
func _connect_points():
	for point in points:
		var pos_str = point.split(",")
		var world_pos := Vector3(pos_str[0], pos_str[1], pos_str[2])
		var search_coords = [-grid_step,0,grid_step]
		
		#searching through individual points
		for x in search_coords:
			for z in search_coords:
				var search_offset = Vector3(x,0,z)
				#skips the current point
				if search_offset == Vector3.ZERO:
					continue
				
				var potential_neighbor = world_to_astar(world_pos + search_offset)
				if points.has(potential_neighbor):
					var current_id = points[point]
					var neighbor_id = points[potential_neighbor]
					if not astar.are_points_connected(current_id, neighbor_id):
						astar.connect_points(current_id, neighbor_id)
				
	
func find_path(from: Vector3, to: Vector3) -> Array:
	var start_id = astar.get_closest_point(from)
	var end_id = astar.get_closest_point(to)
	return astar.get_point_path(start_id, end_id)
	
	
	
#this function converts a point into a string we can use as our function id
func world_to_astar(world_point: Vector3) -> String:
	#this part round us to the specific grid point
	#we can adjust grid_step to change how much it rounds from
	var x = snapped(world_point.x, grid_step)
	var y = snapped(world_point.y, grid_step)
	var z = snapped(world_point.z, grid_step)
	return "%d,%d,%d" % [x,y,z]
