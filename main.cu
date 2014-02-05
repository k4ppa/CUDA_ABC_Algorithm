#include <time.h>
#include "types.h"
#include "bees.h"
#include "bestBee.h"
#include "bestPosition.h"
#include "printBees.h"
#include "timer.h"
#include "kernel.h"
#include "cuda.h"

int main()
{
	clock_t begin;
	int cycles;
	Bees *dev_bees;
	Bees bees = (Bees) malloc(sizeof (struct bees));
	BestBee bestBee = (BestBee) malloc(sizeof (struct bestBee));

	cudaMalloc((void**) &dev_bees, sizeof(Bees));
	
	srand(time(0));
	begin = startTimer();

	setInizializedFalse(bestBee);
	initializeType(bees);
	cudaMemcpy(dev_bees, bees, sizeof(Bees), cudaMemcpyHostToDevice);
	inizializeBees(bees);

	for (cycles=0; cycles<MAX_CYCLES; cycles++) 
	{
		beesWork(bees);
		cudaMemcpy(bees, dev_bees, sizeof(Bees), cudaMemcpyDeviceToHost);
		saveBestPosition(bestBee, bees);
	}

	printBestBee(bestBee);

	finishTimer(begin);

	cudaFree(dev_bees);

	free(bees);
	free(bestBee);
	system("PAUSE");
	return 0;
}