#include "hanoi.h"
#include "timer.h"

// parameters
const size_t towerLevels = 20;
const bool displayTowers = false;

// configs
const bool timeRecu = false; // standard recursive solution
const bool timeNonRecu = false; // standard non-recursive solution
const bool timerMyNonRecu = false; // improved non-recursive solution
const bool timeAll = true;

int main() {
    if constexpr (timeRecu || timeAll){
        hanoi game(towerLevels);
        timer t;
        game.playGame<displayTowers>(true);
    }

    if constexpr (timeNonRecu || timeAll){
        hanoi game(towerLevels);
        timer t;
        game.playGame<displayTowers>(false);
    }

    if constexpr (timerMyNonRecu || timeAll){
        hanoi game(towerLevels);
        timer t;
        game.playGameMySol<displayTowers>();
    }

}