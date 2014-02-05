#include <stdio.h>
#include "timer.h"

clock_t startTimer()
{
	return clock();
}

void finishTimer(clock_t begin)
{
	clock_t end = clock();
	printf("Time: %f sec\n", (double)(end - begin) / CLOCKS_PER_SEC);
}
