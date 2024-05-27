view_visible[0] = true;
view_enabled = true;

aspect_w = 16;
aspect_h = 9;

res_w = 1920;
res_h = 1080;

//16:9 = 320x180
camera = camera_create_view(0, 0, aspect_w * 20, aspect_h * 20);
view_set_camera(0, camera);

window_set_size(res_w, res_h);
window_set_position(display_get_width()/2 - res_w/2, display_get_height()/2 - res_h/2);
surface_resize(application_surface, res_w, res_h);
display_set_gui_size(res_w, res_h);


// Variables
camera_target_w = camera_get_view_width(camera);
camera_target_h = camera_get_view_height(camera);
camera_target_x = camera_get_view_x(camera);
camera_target_y = camera_get_view_y(camera);

zoom_w_change = aspect_w * 10;
zoom_h_change = aspect_h * 10;

zoom_min_w = aspect_w * 10;
zoom_min_h = aspect_h * 10;
zoom_max_w = aspect_w * 100;
zoom_max_h = aspect_h * 100;

move_speed_min = 1.5;
move_speed_max = 15;

// Calculate how much each pixel is worth in gui pixels
// Need this for better panning experience
pan_speed_min = zoom_min_w / res_w;
pan_speed_max = zoom_max_w / res_w;

zoom_smoothing = 0.1;
movement_smoothing = 0.1;

previous_mouse_x = device_mouse_x_to_gui(0);
previous_mouse_y = device_mouse_y_to_gui(0);

depth = -100; // Show above everything