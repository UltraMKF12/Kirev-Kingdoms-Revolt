sprite_index = -1;
tile_size = 32;
tile_surface = -1;

fps_second = fps_real;
alarm[0] = 1;

tile_layer = layer_tilemap_get_id("Tiles_1");
size = 500;

//for (var _i = 0; _i < size; _i++) {
//    for (var _j = 0; _j < size; _j++) {
//		tilemap_set(tile_layer, floor(random_range(1, 4)), _i, _j);
//	}
//}

var _sprite_size = 100;

for (var _i = 0; _i < _sprite_size; _i++) 
{
	for (var _j = 0; _j < _sprite_size; _j++) 
	{
		color_array[_i][_j] = choose(c_aqua, c_white, c_blue, c_green, c_lime, c_olive, c_navy);
	}
}