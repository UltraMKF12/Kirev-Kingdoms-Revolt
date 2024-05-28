/// @description Draw borders


// Surface is used for performance reasons
if not surface_exists(border_surface)
{
	border_surface = surface_create(room_width, room_height);
	surface_set_target(border_surface);
	draw_clear_alpha(c_black, 0);
	
	draw_set_color(c_black);
	for (var _i = 0; _i < tilemap_size; _i++)
	{
		for(var _j = 0; _j < tilemap_size; _j++)
		{
			if game_map[_i][_j].tile != 0
			{
				// Top
				if game_map[_i][_j].top
				{
					draw_rectangle(_i*tile_size, _j*tile_size, _i*tile_size+tile_size-1, _j*tile_size, false);
				}
			
				// Bottom
				if game_map[_i][_j].bottom
				{
					draw_rectangle(_i*tile_size, _j*tile_size+tile_size, _i*tile_size+tile_size-1, _j*tile_size+tile_size, false);
				}
			
				// Left
				if game_map[_i][_j].left
				{
					draw_rectangle(_i*tile_size, _j*tile_size, _i*tile_size, _j*tile_size+tile_size, false);
				}
			
				// Right
				if game_map[_i][_j].right
				{
					draw_rectangle(_i*tile_size+tile_size, _j*tile_size, _i*tile_size+tile_size, _j*tile_size+tile_size, false);
				}
			}
		}
	}

	
	surface_reset_target();
}

draw_surface(border_surface, 0, 0);

// Selection
if selected_group != -1
{
	draw_set_alpha(0.5);
	draw_set_color(c_yellow);
	
	for (var _i = 0; _i < tilemap_size; _i++)
	{
		for(var _j = 0; _j < tilemap_size; _j++)
		{
			if game_map[_i][_j].group == selected_group
			{
				draw_rectangle(_i * tile_size, _j*tile_size, _i*tile_size + tile_size-1, _j*tile_size + tile_size-1, false);
			}
		}
	}
	
	draw_set_alpha(1);
	draw_set_color(c_white);
}