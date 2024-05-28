/// @description Insert description here
// You can write your code in this editor
var _x = device_mouse_x_to_gui(0);
var _y = device_mouse_y_to_gui(0);

if not is_tile_valid(mouse_tile_x, mouse_tile_y)
{
	draw_text(_x+10, _y, "ERROR!");
	exit;
}

draw_text(_x+10, _y, $"POS: {mouse_tile_x} {mouse_tile_y}");
draw_text(_x+10, _y+12, $"TileData: {game_map[mouse_tile_x][mouse_tile_y].tile}, top:{game_map[mouse_tile_x][mouse_tile_y].top}, right:{game_map[mouse_tile_x][mouse_tile_y].right}, down:{game_map[mouse_tile_x][mouse_tile_y].bottom}, left:{game_map[mouse_tile_x][mouse_tile_y].left}");
draw_text(_x+10, _y+24, $"Mouse: {mouse_x} {mouse_y}");
