sprite_index = -1;

tilemap = layer_tilemap_get_id("Tiles");
tilemap_size= 26;
tile_size = 16;

//game_map[][][0] = Tile value
//game_map[][][1] = BorderTop
//game_map[][][2] = BorderRight
//game_map[][][3] = BorderDown
//game_map[][][4] = BorderLeft

for (var _i = 0; _i < tilemap_size; _i++)
{
	for(var _j = 0; _j < tilemap_size; _j++)
	{
		game_map[_i][_j][0] = tilemap_get(tilemap, _i, _j);
		game_map[_i][_j][1] = false;
		game_map[_i][_j][2] = false;
		game_map[_i][_j][3] = false;
		game_map[_i][_j][4] = false;
	}
}


/// -----[Functions]-----

// Go through every tile to check if it's a border tile
// Meaning its next to nothing or another color.
recalculate_borders = function()
{
	for (var _i = 0; _i < tilemap_size; _i++)
	{
		for(var _j = 0; _j < tilemap_size; _j++)
		{
			// Top
			if _j == 0 or game_map[_i][_j-1][0] != game_map[_i][_j][0]
			{
				game_map[_i][_j][1] = true;
			}
			else game_map[_i][_j][1] = false;
		
			// Down
			if _j == tilemap_size-1 or game_map[_i][_j+1][0] != game_map[_i][_j][0]
			{
				game_map[_i][_j][3] = true;
			}
			else game_map[_i][_j][3] = false;
		
			// Left
			if _i == 0 or game_map[_i-1][_j][0] != game_map[_i][_j][0]
			{
				game_map[_i][_j][4] = true;
			}
			else game_map[_i][_j][4] = false;
		
			// Right
			if _i == tilemap_size-1 or game_map[_i+1][_j][0] != game_map[_i][_j][0]
			{
				game_map[_i][_j][2] = true;
			}
			else game_map[_i][_j][2] = false;
		}
	}
}

is_tile_valid = function(_x, _y)
{
	if _x < 0 or _x > tilemap_size-1 or _y < 0 or _y > tilemap_size-1 return false;
	show_debug_message("HOGY");
	return true;
}


recursive_fill = function(_x, _y, _color)
{
	if not is_tile_valid() return;
	if game_map[_x][_y][0] == _color return;
	
	game_map[_x][_y][0] = _color;
	tilemap_set(tilemap, _color, _x, _y);
	
	if game_map[_x][_y][1] == false recursive_fill(_x, _y-1, _color);
	if game_map[_x][_y][2] == false recursive_fill(_x+1, _y, _color);
	if game_map[_x][_y][3] == false recursive_fill(_x, _y+1, _color);
	if game_map[_x][_y][4] == false recursive_fill(_x-1, _y, _color);
}

change_tile = function(_x, _y, _color)
{
	if not is_tile_valid(_x, _y) return;
	game_map[_x][_y][0] = _color;
	tilemap_set(tilemap, _color, _x, _y);
	if is_tile_valid(_x+1, _y) and game_map[_x+1][_y][0] != _color game_map[_x+1][_y][2] = true;
	if is_tile_valid(_x-1, _y) and game_map[_x-1][_y][0] != _color game_map[_x-1][_y][4] = true;
	if is_tile_valid(_x, _y+1) and game_map[_x][_y+1][0] != _color game_map[_x][_y+1][3] = true;
	if is_tile_valid(_x, _y-1) and game_map[_x][_y-1][0] != _color game_map[_x][_y-1][1] = true;
}

/// -----[Function Calls]-----
recalculate_borders();