
#General Settings
##Background Settings
###Background Color
`xsetroot -solid`

###Window Background Color
`hc attr theme.background_color`
The color behind window contents only visible on resize. This will be represented in the render as the window background color.

###Background Image
`feh --bg-scale /path/to/image`

##Other Settings
###Monitor Padding
`hc pad MONITOR [UP] [RIGHT] [DOWN [LEFT]`
Padding around outside of monitor. Use this to make room for your bars/panels.

###Window Gap
`hc set window_gap`
The gap between windows within one frame in the tiling mode.

---

#Window Border
##Inner Border
###Inner Border Width
`hc attr theme.inner_width`
The width of the innermost border on all windows.

###Inner Border Active Color
`hc attr theme.active.inner_color`
The color of the innermost border on focused windows.

### Inner Border Inactive Color
`hc attr theme.inner_color`
The color of the innermost border on unfocused windows.

##Outer Border
###Outer Border Width
`hc attr theme.border_width`
This needs to be big enough to contain your inner border width. Whatever this value is, minus your inner border width will be the size of your outer border.

###Outer Border Active Color
`hc attr theme.active.color`
The color of the outermost border on tiled windows and the middle border on floating windows when focused.

##Outer Border Inactive Color
`hc attr theme.normal.color`
The color of the outermost border on tiled windows and the middle border on floating windows when unfocused.

###Outer Border Urgent Color
`hc attr theme.urgent.color`
The color of the outermost border on tiled windows and the middle border on floating windows when the window is in an urgent state.

##Floating Border
###Floating Middle Border Width
`hc attr theme.floating.border_width`
This needs to be big enough to contain your inner border width and floating outer border width. Whatever this value is, minus your inner border width and floating outer border with will be the size of your middle border.

###Floating Outer Border Width
`hc attr theme.floating.outer_width`
The width of the outer most border on floating windows.

###Floating Outer Border Inactive
`hc attr theme.floating.outer_color`
The color of the outer most border on floating windows.

---

#Frame Styles
##Frame Settings
###Frame Gap
`hc set frame_gap`
Margin around outside of frames

###Frame Padding
`hc set frame_padding`
Padding around windows inside a frame. This stacks on top of window_gap.

###Always Show Frame
`hc set always_show_frame`
If set, all frames are displayed. If unset, only frames with focus or with windows in it are displayed.

##Frame Border
###Frame Border Width
`hc set frame_border_width`
The width of the frame border.

###Transparent Frame Border Width
`hc set frame_transparent_width`
Specifies the width of the remaining frame colored with frame_bg_active_color if frame_bg_transparent is set.

###Frame Border Active Color
`hc set frame_border_active_color`
The color of the frame border when focused.

###Frame Border Inactive Color
`hc set frame_border_normal_color`
The color of the frame border when unfocused.

##Frame Background
###Transparent Frame Background
`hc set frame_bg_transparent`
If checked the background of the frame will be transparent.

###Frame Background Active Color
`hc set frame_bg_active_color`
The background color of the frame if focused.

###Frame Background Inactive Color
`hc set frame_bg_normal_color`
The background color of the frame if unfocused.

---
#END
