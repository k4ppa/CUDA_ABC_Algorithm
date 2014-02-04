#include "printBees.h"

void printBestBee(BestBee bestBee)
{
	int y;
	printf("\tB\t*\t%e\t%e\n", getBestFitness(bestBee), getBestFitness(bestBee));
	for(y=0; y<D; y++)
		printf("%e\t", bestBee->bestPosition[y]);
	printf("\n");
}

void printBees(Bees bees)
{
    int i;
    for (i=0; i<SN; i++)
    {
        dprintf("\t%d\t%d\t%f\n", getType(bees, i), getTrial(bees, i), getFitness(bees, i));
        printPosition(bees->positions[i]);
		dprintf("\n-------------------------------------------------------------------------------\n");
    }
	dprintf("--------------------------------------------------------------------------------\n");
}

void printPosition(float position[])
{
	int y;
	for(y=0; y<D; y++)
		dprintf("%f\t", position[y]);
	dprintf("\n");
}
