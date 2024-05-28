var _x = mouse_x div tile_size;
var _y = mouse_y div tile_size;

if mouse_check_button_pressed(mb_left)
{
	var _color = floor(random_range(1, 9));
	recursive_fill(_x, _y, _color);
	recalculate_borders();
}

if keyboard_check(vk_control)
{
	change_tile(_x, _y, 0);
}

if keyboard_check(vk_space)
{
	var _color = floor(random_range(1, 9));
	change_tile(_x, _y, _color);
}