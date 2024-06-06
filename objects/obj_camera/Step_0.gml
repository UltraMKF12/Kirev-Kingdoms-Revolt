var _camera_w = camera_get_view_width(camera);
var _camera_h = camera_get_view_height(camera);

var _horizontal = keyboard_check(ord("A")) - keyboard_check(ord("D"));
var _vertical = keyboard_check(ord("W")) - keyboard_check(ord("S"));

var _current_mouse_x = device_mouse_x_to_gui(0);
var _current_mouse_y = device_mouse_y_to_gui(0);
var _pan_button = mouse_check_button(mb_right) or mouse_check_button(mb_middle);


/// -----[Zoom]-----
var _mwheel = mouse_wheel_up() - mouse_wheel_down();
if _mwheel != 0
{
	// Zoom to mouse location
	// Because camera is in the middle, the camera should only move /2 of the distance.
	// Zooming from 320 is 1, 480:1.5, 640:2, 800:2.5, 960:3
	// _pixel_ratio makes sure we don't overshoot, at bigger camera resolutions we need
	// to move less pixels to keep the mouse over specific position.
	if _mwheel > 0 and camera_target_w > zoom_min_w
	{
		var _pixel_ratio = _camera_w / zoom_w_change / 2;
		var _distance_x = ((mouse_x - x) / 2) / _pixel_ratio;
		var _distance_y = ((mouse_y - y) / 2) / _pixel_ratio;
		
		camera_target_x += _distance_x;
		camera_target_y += _distance_y;
	}
	
	// Zoom with mouse wheel
	camera_target_w -= _mwheel * zoom_w_change;
	camera_target_h -= _mwheel * zoom_h_change;
	
	camera_target_w = clamp(camera_target_w, zoom_min_w, zoom_max_w);
	camera_target_h = clamp(camera_target_h, zoom_min_h, zoom_max_h);
	
	
}

// Smooth zoom
var _camera_new_w = lerp(_camera_w, camera_target_w, zoom_smoothing);
var _camera_new_h = lerp(_camera_h, camera_target_h, zoom_smoothing);


// Calculate zoom value
// Normalized to get a range between 0 and 1 instead of 0.1 and 1
var _zoom_value = (_camera_new_w - zoom_min_w) / (zoom_max_w - zoom_min_w);


/// -----[Movement]-----
if _horizontal != 0
{
	var _move_speed = lerp(move_speed_min, move_speed_max, _zoom_value);
	camera_target_x -= _horizontal * _move_speed;
	
}
if _vertical != 0
{
	var _move_speed = lerp(move_speed_min, move_speed_max, _zoom_value);
	camera_target_y -= _vertical * _move_speed;
}

// Panning - Pans slower if the zoom is large

if _pan_button and
   (previous_mouse_x != _current_mouse_x or
   previous_mouse_y != _current_mouse_y)
{
	var _pan_speed = lerp(pan_speed_min, pan_speed_max, _zoom_value);
	camera_target_x -= (_current_mouse_x - previous_mouse_x) * _pan_speed;
	camera_target_y -= (_current_mouse_y - previous_mouse_y) * _pan_speed;
	x = camera_target_x;
	y = camera_target_y;
}
else
{
	// Smooth movement if not panning
	x = lerp(x, camera_target_x, movement_smoothing);
	y = lerp(y, camera_target_y, movement_smoothing);
}



// Center the camera around x, y
var _camera_target_x = x - _camera_new_w / 2;
var _camera_target_y = y - _camera_new_h / 2;


previous_mouse_x = _current_mouse_x;
previous_mouse_y = _current_mouse_y;
camera_set_view_size(camera, _camera_new_w, _camera_new_h);
camera_set_view_pos(camera, _camera_target_x, _camera_target_y);
