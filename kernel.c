#include "kernel.h"

void inizializeBees(Bees bees)
{
	int i;
	for (i=0; i<NUMBER_OF_EMPLOYED; i++)
		employedPlacement(bees, i);
}

void beesWork(Bees bees)
{
	assignEmployed(bees);
	beesSearch(bees);
}

	void assignEmployed(Bees bees)
	{
		int i;
		for (i=NUMBER_OF_ONLOOKER; i<SN; i++)
			onlookerPlacement(bees, i);
	}

	void beesSearch(Bees bees)
	{
		int i;
		for (i=0; i<SN; i++)
			foodExploitation(bees, i);
	}
