#include <time.h>
#include "types.h"
#include "bees.h"
#include "bestBee.h"
#include "bestPosition.h"
#include "printBees.h"
#include "timer.h"

void assignEmployed(Bees bees);
void beesSearch(Bees bees);

void beesWork(Bees bees)
{
	assignEmployed(bees);
	beesSearch(bees);
}

	void assignEmployed(Bees bees)
	{
		int i;
		for (i=NUMBER_OF_ONLOOKER; i<SN; i++)
		{
			onlookerPlacement(bees, i);
			dprintf("ONLOOKER PLACEMENT %d\n", i);
			printBees(bees);
		}
	}

	void beesSearch(Bees bees)
	{
		int i;
		for (i=0; i<SN; i++)
		{
			foodExploitation(bees, i);
			dprintf("FOOD EXPLOITATION %d\n", i);
			printBees(bees);
		}
	}

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
	for (i=0; i<NUMBER_OF_EMPLOYED; i++)
		employedPlacement(bees, i);

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