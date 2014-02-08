#include "kernel.h"

void inizializeBees(Bees dev_bees, curandState *dev_randState)
{
	/*int i;
	for (i=0; i<NUMBER_OF_EMPLOYED; i++)
		employedPlacement(bees, i);*/
	cudaEmployedPlacement<<<1, SN>>>(dev_bees, dev_randState);
}


/*
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
*/