var _cam = view_get_camera(0);


// Zoom
var _cam_width = camera_get_view_width(_cam);
var _cam_height = camera_get_view_height(_cam);

if mouse_wheel_up()
{
	_cam_width -= 160;
	_cam_height -= 90;
}

if mouse_wheel_down()
{
	_cam_width += 160;
	_cam_height += 90;
}

_cam_width = clamp(_cam_width, 160, 160000);
_cam_height = clamp(_cam_height, 90, 90000);

camera_set_view_size(_cam, _cam_width, _cam_height);

// Movement
var _cam_x = camera_get_view_x(_cam);
var _cam_y = camera_get_view_y(_cam);

var _up = keyboard_check(ord("W"));
var _down = keyboard_check(ord("S"));
var _left = keyboard_check(ord("A"));
var _right = keyboard_check(ord("D"));

if _up
{
	_cam_y -= 20;
}
if _down
{
	_cam_y += 20;
}

if _left
{
	_cam_x -= 20;
}
if _right
{
	_cam_x += 20;
}

camera_set_view_pos(_cam, _cam_x, _cam_y);

if keyboard_check_pressed(vk_up)
{
	surface_save(tile_surface, "tilesurfacesanyika.png");
}