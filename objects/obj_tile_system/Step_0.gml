mouse_tile_x = mouse_x >= 0 ? mouse_x div tile_size : -1;
mouse_tile_y = mouse_y >= 0 ? mouse_y div tile_size : -1;

if mouse_check_button_pressed(mb_left)
{
	var _color = floor(random_range(1, 9));
	recursive_fill(mouse_tile_x, mouse_tile_y, _color);
	recalculate_borders();
}

if keyboard_check(vk_control)
{
	change_tile(mouse_tile_x, mouse_tile_y, 0);
}

if keyboard_check(ord("1"))
{
	var _color = 1;
	change_tile(mouse_tile_x, mouse_tile_y, _color);
}
if keyboard_check(ord("2"))
{
	var _color = 2;
	change_tile(mouse_tile_x, mouse_tile_y, _color);
}
if keyboard_check(ord("3"))
{
	var _color = 3;
	change_tile(mouse_tile_x, mouse_tile_y, _color);
}
if keyboard_check(ord("4"))
{
	var _color = 4;
	change_tile(mouse_tile_x, mouse_tile_y, _color);
}