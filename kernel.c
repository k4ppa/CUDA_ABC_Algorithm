#include "kernel.h"

void kernel1(Bees bees)
{
	int i;
	for (i=0; i<NUMBER_OF_EMPLOYED; i++)
		employedPlacement(bees, i);
}
