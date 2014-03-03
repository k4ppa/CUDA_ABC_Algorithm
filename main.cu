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
	int tid = blockIdx.x * blockDim.x + threadIdx.x;
	curand_init(time, tid, 0, &randState[tid]);
}

int main()
{
	clock_t begin;
	int cycles;
	//float elapsedTime;
	Bees dev_bees;
	curandState *dev_randState;
	//cudaEvent_t start, stop;

	Bees bees = (Bees) malloc(sizeof (struct bees));
	BestBee bestBee = (BestBee) malloc(sizeof (struct bestBee));

	cudaMalloc((void**) &dev_bees, sizeof(struct bees));
	cudaMalloc(&dev_randState, SN);

	init_curand<<<BLOCK, THREAD_PER_BLOCK>>>(dev_randState, time(0));

	srand((unsigned int) time(0));
	begin = startTimer();
	/*cudaEventCreate( &start );
	cudaEventCreate( &stop );
	cudaEventRecord( start, 0 );*/

	setInizializedFalse(bestBee);
	initializeType(bees);
	cudaMemcpy(dev_bees, bees, sizeof(struct bees), cudaMemcpyHostToDevice);
	inizializeBees(dev_bees, dev_randState);

	//printBees(bees);

	for (cycles=0; cycles<MAX_CYCLES; cycles++) 
	{
		beesWork(dev_bees, dev_randState);
		//cudaMemcpy(bees, dev_bees, sizeof(struct bees), cudaMemcpyDeviceToHost);
		//saveBestPosition(bestBee, bees);
		//printBees(bees);
	}
	
	//printBestBee(bestBee);

	finishTimer(begin);
	/*cudaEventRecord( stop, 0 );
	cudaEventSynchronize( stop );
	
	cudaEventElapsedTime( &elapsedTime, start, stop );
	printf( "Time to generate: %3.1f s\n", elapsedTime  / CLOCKS_PER_SEC);
	cudaEventDestroy( start );
	cudaEventDestroy( stop );*/

	cudaFree(dev_bees);
	cudaFree(dev_randState);

	free(bees);
	free(bestBee);
	system("PAUSE");
	return 0;
}