#include <time.h>
#include "types.h"
#include "bees.h"
#include "bestBee.h"
#include "bestPosition.h"
#include "printBees.h"
#include "timer.h"
#include "kernel.h"

int main()
{
	clock_t begin;
	int i, cycles;
	Bees bees = (Bees) malloc(sizeof (struct bees));
	BestBee bestBee = (BestBee) malloc(sizeof (struct bestBee));
	
	srand(time(0));
	begin = startTimer();

	setInizializedFalse(bestBee);
	initializeType(bees);
	inizializeBees(bees);

	for (cycles=0; cycles<MAX_CYCLES; cycles++) 
	{
		beesWork(bees);
		//printBees(bees);
		saveBestPosition(bestBee, bees);
		//printBestBee(bestBee);
	}

	printBestBee(bestBee);

	finishTimer(begin);
	free(bees);
	free(bestBee);
	system("PAUSE");
	return 0;
}