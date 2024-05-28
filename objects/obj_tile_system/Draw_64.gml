/// @description Insert description here
// You can write your code in this editor
var _x = device_mouse_x_to_gui(0);
var _y = device_mouse_y_to_gui(0);
var _i = mouse_x div tile_size;
var _j = mouse_y div tile_size;

if not is_tile_valid(_i, _j)
{
	draw_text(_x+10, _y, "ERROR!");
	exit;
}

draw_text(_x+10, _y, $"POS: {_i} {_j}");
draw_text(_x+10, _y+12, $"TileData: {game_map[_i][_j][0]}, top:{game_map[_i][_j][1]}, right:{game_map[_i][_j][2]}, down:{game_map[_i][_j][3]}, left:{game_map[_i][_j][4]}");