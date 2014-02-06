#include <time.h>
#include "types.h"
#include "bees.h"
#include "bestBee.h"
#include "bestPosition.h"
#include "printBees.h"
#include "timer.h"
#include "kernel.h"
#include "cuda.h"

__global__ void init_curand(curandState *state, time_t time) {
	int idx = threadIdx.x;
	curand_init(time, idx, 0, &state[idx]);
}

int main()
{
	clock_t begin;
	int cycles;
	Bees dev_bees;
	curandState *d_state;
	Bees bees = (Bees) malloc(sizeof (struct bees));
	BestBee bestBee = (BestBee) malloc(sizeof (struct bestBee));

	cudaMalloc((void**) &dev_bees, sizeof(Bees));
	cudaMalloc(&d_state, SN);

	init_curand<<<1, SN>>>(d_state, time(0));

	srand(time(0));
	begin = startTimer();

	setInizializedFalse(bestBee);
	initializeType(bees);
	cudaMemcpy(dev_bees, bees, sizeof(Bees), cudaMemcpyHostToDevice);
	inizializeBees(dev_bees);

	for (cycles=0; cycles<MAX_CYCLES; cycles++) 
	{
		beesWork(bees);
		cudaMemcpy(bees, dev_bees, sizeof(Bees), cudaMemcpyDeviceToHost);
		saveBestPosition(bestBee, bees);
	}

	printBestBee(bestBee);

	finishTimer(begin);

	cudaFree(dev_bees);
	cudaFree(d_state);

	free(bees);
	free(bestBee);
	system("PAUSE");
	return 0;
}