// import std.stdio;
// import std.string;

import raylib;


debug {
    const(char*) windowTitle = "lifegame (debug)";
} else {
    const(char*) windowTitle = "lifegame";
}

const cellSize = 2;
const initialCellCount = 80;
const fps = 30;

const screenWidth = 480;
const screenHeight = 640;
const colSize = (screenWidth / cellSize + 2);
const rowSize = (screenHeight / cellSize + 2);

void main()
{
    // call this before using raylib
    validateRaylibBinding();

    InitWindow(screenWidth, screenHeight, windowTitle);

    SetTargetFPS(fps);

    while (!WindowShouldClose()) {
        BeginDrawing();
        ClearBackground(Colors.RAYWHITE);
        // DrawText("Hello, World!", 400, 300, 28, Colors.BLACK);
        EndDrawing();
    }
    CloseWindow();
}
