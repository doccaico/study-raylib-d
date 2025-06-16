module constants;

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
