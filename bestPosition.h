#include "bestBee.h"
#include "bees.h"

void saveBestPosition(BestBee bestBee, Bees bees);
	void controlInizialization(BestBee bestBee, Bees bees);
		BOOL isNotAlreadyInizialized(BestBee bestBee);
	void controlPosition(BestBee bestBee, Bees bees, int i);
		BOOL isBeePositionBetter(BestBee bestBee, Bees bees, int i);
void replaceBestPosition(BestBee bestBee, Bees bees, int i);
