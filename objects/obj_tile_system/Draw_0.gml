/// @description Draw borders

draw_set_color(c_black);

for (var _i = 0; _i < tilemap_size; _i++)
{
	for(var _j = 0; _j < tilemap_size; _j++)
	{
		if game_map[_i][_j][0] != 0
		{
			// Top
			if game_map[_i][_j][1]
			{
				draw_rectangle(_i*tile_size, _j*tile_size, _i*tile_size+tile_size-1, _j*tile_size, false);
			}
			
			// Bottom
			if game_map[_i][_j][3]
			{
				draw_rectangle(_i*tile_size, _j*tile_size+tile_size, _i*tile_size+tile_size-1, _j*tile_size+tile_size, false);
			}
			
			// Left
			if game_map[_i][_j][4]
			{
				draw_rectangle(_i*tile_size, _j*tile_size, _i*tile_size, _j*tile_size+tile_size, false);
			}
			
			// Right
			if game_map[_i][_j][2]
			{
				draw_rectangle(_i*tile_size+tile_size, _j*tile_size, _i*tile_size+tile_size, _j*tile_size+tile_size, false);
			}
		}
	}
}

draw_set_color(c_white);