sprite_index = -1;

tilemap = layer_tilemap_get_id("Tiles");
tilemap_size= 26;
tile_size = 16;
border_surface = -1;

/// -----[Variables]-----
mouse_tile_x = -1;
mouse_tile_y = -1;
group_count = 0;

selected_group = -1;


/// -----[Functions]-----

// Reset every variable and get reimport tile from room tilemap.
import_map = function()
{
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
				left: false,
				group: -1
			}
		}
	}
}

reset_map = function()
{
	group_count = 0;
	for (var _i = 0; _i < tilemap_size; _i++)
	{
		for(var _j = 0; _j < tilemap_size; _j++)
		{
			game_map[_i][_j].top = false;
			game_map[_i][_j].bottom = false;
			game_map[_i][_j].left = false;
			game_map[_i][_j].right = false;
			game_map[_i][_j].group = -1;
		}
	}
}

is_tile_valid = function(_x, _y)
{
	if _x < 0 or _x > tilemap_size-1 return false;
	if _y < 0 or _y > tilemap_size-1 return false;
	return true;
}


// Find all connected territories of the same color
recursive_fill_borders = function(_x, _y, _color, _group)
{
	if not is_tile_valid(_x, _y) return;
	if game_map[_x][_y].tile != _color return;
	if game_map[_x][_y].group == _group return;
	
	game_map[_x][_y].group = _group;
	
	
	// Right
	if not is_tile_valid(_x+1, _y) or game_map[_x+1][_y].tile != _color
	{
		game_map[_x][_y].right = true;
	}
	else recursive_fill_borders(_x+1, _y, _color, _group);
	
	// Left
	if not is_tile_valid(_x-1, _y) or game_map[_x-1][_y].tile != _color
	{
		game_map[_x][_y].left = true;
	}
	else recursive_fill_borders(_x-1, _y, _color, _group);
	
	// Top
	if not is_tile_valid(_x, _y-1) or game_map[_x][_y-1].tile != _color
	{
		game_map[_x][_y].top = true;
	}
	else recursive_fill_borders(_x, _y-1, _color, _group);
	
	// Bottom
	if not is_tile_valid(_x, _y+1) or game_map[_x][_y+1].tile != _color
	{
		game_map[_x][_y].bottom = true;
	}
	else recursive_fill_borders(_x, _y+1, _color, _group);
}

// Recalculates borders and groups
calculate_borders = function()
{
	reset_map();
	
	//Must go through every cell to find every possible group
	for (var _i = 0; _i < tilemap_size; _i++)
	{
		for(var _j = 0; _j < tilemap_size; _j++)
		{
			// 1 is unclaimed territory, so all of it goes to group 0.
			var _color = tilemap_get(tilemap, _i, _j);
			if _color == 1
			{
				recursive_fill_borders(_i, _j, _color, 0);
			}
			else if _color > 0 and game_map[_i][_j].group == -1
			{
				group_count++;
				recursive_fill_borders(_i, _j, _color, group_count);
			}		
		}
	}
	
	border_surface = -1; //Redraw borders.
}

change_tile = function(_x, _y, _color)
{
	if not is_tile_valid(_x, _y) return;
	if game_map[_x][_y].tile == _color return;
	game_map[_x][_y].tile = _color;
	tilemap_set(tilemap, _color, _x, _y);
	
	calculate_borders();
}

/// -----[Function Calls]-----
import_map();
calculate_borders();