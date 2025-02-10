SCALE = 1
VIRTUAL_WIDTH = SCALE * 160
VIRTUAL_HEIGHT = SCALE * 120
-- VH2 = VIRTUAL_HEIGHT / 2
-- VW2 = VIRTUAL_WIDTH / 2
PIXEL_SCALE = 4 / SCALE
WINDOW_WIDTH = VIRTUAL_WIDTH * PIXEL_SCALE
WINDOW_HEIGHT = VIRTUAL_HEIGHT * PIXEL_SCALE

-- #define SW         160*res                  //screen width
-- #define SH         120*res                  //screen height
-- #define SW2        (SW/2)                   //half of screen width
-- #define SH2        (SH/2)                   //half of screen height
-- #define pixelScale 4/res                    //OpenGL pixel scale
-- #define GLSW       (SW*pixelScale)          //OpenGL window width
-- #define GLSH       (SH*pixelScale)   