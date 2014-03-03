#include "kernel.h"

void inizializeBees(Bees dev_bees, curandState *dev_randState)
{
	cudaEmployedPlacement<<<BLOCK, THREAD_PER_BLOCK>>>(dev_bees, dev_randState);
}



void beesWork(Bees dev_bees, curandState *dev_randState)
{
	assignEmployed(dev_bees, dev_randState);
	beesSearch(dev_bees, dev_randState);
}

	void assignEmployed(Bees dev_bees, curandState *dev_randState)
	{
		cudaOnlookerPlacement<<<BLOCK, THREAD_PER_BLOCK>>>(dev_bees, dev_randState);
	}

	void beesSearch(Bees dev_bees, curandState *dev_randState)
	{
		cudaFoodExploitation<<<BLOCK, THREAD_PER_BLOCK>>>(dev_bees, dev_randState);
	}
