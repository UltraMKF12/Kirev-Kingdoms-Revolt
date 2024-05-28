sprite_index = -1;

tilemap = layer_tilemap_get_id("Tiles");
tilemap_size= 26;
tile_size = 16;
border_surface = -1;

/// -----[Variables]-----
mouse_tile_x = -1;
mouse_tile_y = -1;


//Get every tile in the game room
for (var _i = 0; _i < tilemap_size; _i++)
{
	for(var _j = 0; _j < tilemap_size; _j++)
	{
		//tilemap_set(tilemap, round(random_range(0, 9)), _i, _j);
		game_map[_i][_j] = 
		{
			tile: tilemap_get(tilemap, _i, _j),
			top: false,
			right: false,
			bottom: false,
			left: false
		}
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
			if _j == 0 or game_map[_i][_j-1].tile != game_map[_i][_j].tile
			{
				game_map[_i][_j].top = true;
			}
			else game_map[_i][_j].top = false;
		
			// Bottom
			if _j == tilemap_size-1 or game_map[_i][_j+1].tile != game_map[_i][_j].tile
			{
				game_map[_i][_j].bottom = true;
			}
			else game_map[_i][_j].bottom = false;
		
			// Left
			if _i == 0 or game_map[_i-1][_j].tile != game_map[_i][_j].tile
			{
				game_map[_i][_j].left = true;
			}
			else game_map[_i][_j].left = false;
		
			// Right
			if _i == tilemap_size-1 or game_map[_i+1][_j].tile != game_map[_i][_j].tile
			{
				game_map[_i][_j].right = true;
			}
			else game_map[_i][_j].right = false;
		}
	}
	
	border_surface = -1; //Redraw borders.
}

is_tile_valid = function(_x, _y)
{
	if _x < 0 or _x > tilemap_size-1 return false;
	if _y < 0 or _y > tilemap_size-1 return false;
	return true;
}


recursive_fill = function(_x, _y, _color)
{
	if not is_tile_valid(_x, _y) return;
	if game_map[_x][_y].tile == _color return;
	
	game_map[_x][_y].tile = _color;
	tilemap_set(tilemap, _color, _x, _y);
	
	if game_map[_x][_y].top == false recursive_fill(_x, _y-1, _color);
	if game_map[_x][_y].right == false recursive_fill(_x+1, _y, _color);
	if game_map[_x][_y].bottom == false recursive_fill(_x, _y+1, _color);
	if game_map[_x][_y].left == false recursive_fill(_x-1, _y, _color);
	
	border_surface = -1; //Redraw borders.
}

change_tile = function(_x, _y, _color)
{
	if not is_tile_valid(_x, _y) return;
	if game_map[_x][_y].tile == _color return;
	game_map[_x][_y].tile = _color;
	tilemap_set(tilemap, _color, _x, _y);
	
	// Set the borders of self and neighbours
	// It's way more performant than recalculation all tile borders
	
	// Right tile
	if is_tile_valid(_x+1, _y) and game_map[_x+1][_y].tile != _color
	{
		game_map[_x+1][_y].left = true;
		game_map[_x][_y].right = true;
	}
	else if not is_tile_valid(_x+1, _y) game_map[_x][_y].right = true;
	else
	{
		game_map[_x+1][_y].left = false;
		game_map[_x][_y].right = false;
	}
	
	
	// Left tile
	if is_tile_valid(_x-1, _y) and game_map[_x-1][_y].tile != _color
	{
		game_map[_x-1][_y].right = true;
		game_map[_x][_y].left = true;
	}
	else if not is_tile_valid(_x-1, _y) game_map[_x][_y].left = true;
	else 
	{
		game_map[_x-1][_y].right = false;
		game_map[_x][_y].left = false;
	}
	
	
	// Bottom tile
	if is_tile_valid(_x, _y+1) and game_map[_x][_y+1].tile != _color
	{

		game_map[_x][_y+1].top = true;
		game_map[_x][_y].bottom = true;
	}
	else if not is_tile_valid(_x, _y+1) game_map[_x][_y].bottom = true;
	else 
	{
		game_map[_x][_y+1].top = false;
		game_map[_x][_y].bottom = false;
	}
	
	
	// Top tile
	if is_tile_valid(_x, _y-1) and game_map[_x][_y-1].tile != _color
	{
		game_map[_x][_y-1].bottom = true;
		game_map[_x][_y].top = true;
	}
	else if not is_tile_valid(_x, _y-1) game_map[_x][_y].top = true;
	else
	{
		game_map[_x][_y-1].bottom = false;
		game_map[_x][_y].top = false;
	}
	
	border_surface = -1; //Redraw borders.
}

/// -----[Function Calls]-----
recalculate_borders();