if !surface_exists(tile_surface)
{
	tile_surface = surface_create(size*tile_size, size*tile_size);
	surface_set_target(tile_surface);
	for (var _i = 0; _i < size; _i++) 
	{
		for (var _j = 0; _j < size; _j++) 
		{
			//draw_sprite_ext(spr_tile, 0, _i*tile_size, _j*tile_size, 1, 1, 0, game_map[_i][_j], 1);
			draw_tile(tm__test_tile, floor(random_range(1, 4)), 0, _i * tile_size, _j*tile_size);
		}
	}
	surface_reset_target();
}
else
{
	draw_surface(tile_surface, 0, 0);
}

var _sprite_size = 100;
var _sizestuff = 32;

for (var _i = 157; _i < _sprite_size+157; _i++) 
{
	for (var _j = 0; _j < _sprite_size; _j++) 
	{
		draw_set_color(color_array[_i-157][_j]);
		draw_rectangle(_i*_sizestuff, _j*_sizestuff, _i*_sizestuff+_sizestuff, _j*_sizestuff+_sizestuff, false);
		draw_set_color(c_white);
	}
}