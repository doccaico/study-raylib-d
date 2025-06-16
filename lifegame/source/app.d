import std.random : Random, rndGen, randomShuffle, uniform;

import rl = raylib;


debug {
    const char* windowTitle = "lifegame (debug)";
} else {
    const char* windowTitle = "lifegame";
}
const cellSize = 2;
const initialCellCount = 40 * 2;
const fps = 30 / 2;
const screenWidth = 480 + 4;
const screenHeight = 640 + 4;
const colSize = (screenWidth / cellSize + 2);
const rowSize = (screenHeight / cellSize + 2);
const initialCellColor = rl.Colors.BLACK;
const initialBgColor = rl.Colors.RAYWHITE;

int[colSize][rowSize] grid;
int[colSize][rowSize] neighbors;
rl.Colors cellColor = initialCellColor;
rl.Colors bgColor = initialBgColor;
Random rnd;


void initializeGrid()
{
    foreach (i; 0 .. colSize) {
        // top
        grid[0][i] = 0;
        // bottom
        grid[rowSize - 1][i] = 0;
    }

    foreach (i; 0 .. rowSize) {
        // left
        grid[i][0] = 0;
        // right
        grid[i][colSize - 1] = 0;
    }

    foreach (i; 1 .. rowSize - 1) {
        foreach (j; 1 .. colSize - 1) {
            grid[i][j] = (1 <= j && j <= initialCellCount) ? 1 : 0;
        }
    }
}

void draw()
{
    foreach (i; 1 .. rowSize - 1) {
        foreach (j; 1 .. colSize - 1) {
            if (grid[i][j] == 1) {
                rl.DrawRectangle(
                        cellSize * (j - 1),
                        cellSize * (i - 1),
                        cellSize,
                        cellSize,
                        cellColor);
            }
        }
    }
}

void randomize()
{
    foreach (i; 1 .. rowSize - 1) {
        grid[i][1 .. colSize - 1].randomShuffle(rnd);
    }
}

void changeBgColor()
{
    bgColor = cast(rl.Colors)rl.Color(
            cast(ubyte)uniform(0, 255 + 1, rnd),
            cast(ubyte)uniform(0, 255 + 1, rnd),
            cast(ubyte)uniform(0, 255 + 1, rnd));
}

void changeCellColor()
{
    cellColor = cast(rl.Colors)rl.Color(
            cast(ubyte)uniform(0, 255 + 1, rnd),
            cast(ubyte)uniform(0, 255 + 1, rnd),
            cast(ubyte)uniform(0, 255 + 1, rnd));
}

void nextGeneration()
{
    foreach (i; 1 .. rowSize - 1) {
        foreach (j; 1 .. colSize - 1) {
            // top = top-left + top-middle + top-right
            int top = grid[i - 1][j - 1] + grid[i - 1][j] + grid[i - 1][j + 1];
            // middle = left + right
            int middle = grid[i][j - 1] + grid[i][j + 1];
            // bottom = bottom-left + bottom-middle + bottom-right
            int bottom = grid[i + 1][j - 1] + grid[i + 1][j] + grid[i + 1][j + 1];

            neighbors[i][j] = top + middle + bottom;
        }
    }

    foreach (i; 1 .. rowSize - 1) {
        foreach (j; 1 .. colSize - 1) {
            switch (neighbors[i][j]) {
                case 2:
                    // Do nothing
                    break;
                case 3:
                    grid[i][j] = 1;
                    break;
                default:
                    grid[i][j] = 0;
                    break;
            }
        }
    }
}

void main()
{
    // call this before using raylib
    rl.validateRaylibBinding();

    rnd = rndGen;
    initializeGrid();
    randomize();

    rl.InitWindow(screenWidth, screenHeight, windowTitle);

    rl.SetTargetFPS(fps);

    while (!rl.WindowShouldClose()) {
        if (rl.IsKeyPressed(rl.KeyboardKey.KEY_R)) {
            initializeGrid();
            randomize();
        } else if (rl.IsKeyPressed(rl.KeyboardKey.KEY_B)) {
            changeBgColor();
        } else if (rl.IsKeyPressed(rl.KeyboardKey.KEY_C)) {
            changeCellColor();
        }

        rl.BeginDrawing();
        rl.ClearBackground(bgColor);
        draw();
        nextGeneration();
        rl.EndDrawing();
    }
    rl.CloseWindow();
}
