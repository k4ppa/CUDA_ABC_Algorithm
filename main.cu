#include <time.h>
#include "types.h"
#include "bees.h"
#include "bestBee.h"
#include "bestPosition.h"
#include "printBees.h"
#include "timer.h"
#include "kernel.h"
#include "cuda.h"
#include "curand_kernel.h"

__global__ void init_curand(curandState *randState, time_t time) {
	int tid = threadIdx.x;
	curand_init(time, tid, 0, &randState[tid]);
}

int main()
{
	clock_t begin;
	int cycles;
	Bees dev_bees;
	curandState *dev_randState;
	Bees bees = (Bees) malloc(sizeof (struct bees));
	BestBee bestBee = (BestBee) malloc(sizeof (struct bestBee));

	cudaMalloc((void**) &dev_bees, sizeof(Bees));
	cudaMalloc(&dev_randState, SN);

	init_curand<<<1, SN>>>(dev_randState, time(0));

	srand(time(0));
	begin = startTimer();

	setInizializedFalse(bestBee);
	initializeType(bees);
	cudaMemcpy(dev_bees, bees, sizeof(Bees), cudaMemcpyHostToDevice);
	inizializeBees(dev_bees, dev_randState);

	for (cycles=0; cycles<MAX_CYCLES; cycles++) 
	{
		beesWork(bees);
		cudaMemcpy(bees, dev_bees, sizeof(Bees), cudaMemcpyDeviceToHost);
		saveBestPosition(bestBee, bees);
	}

	printBestBee(bestBee);

	finishTimer(begin);

	cudaFree(dev_bees);
	cudaFree(dev_randState);

	free(bees);
	free(bestBee);
	system("PAUSE");
	return 0;
}