#include "bees.h"

void setType(Bees bees, int i, unsigned int newType)
{
	setBits(&bees->type[i], newType);
}

__host__ __device__ unsigned int getType(Bees bees, int i)
{
	return getBits(&bees->type[i]);
}

__device__ void setTrial(Bees bees, int i, int newTrial)
{
	bees->trial[i] = newTrial;
}

int getTrial(Bees bees, int i)
{
	return bees->trial[i];
}

__device__ void setFitness(Bees bees, int i, float newFitness)
{
	bees->fitness[i] = newFitness;
}

float getFitness(Bees bees, int i)
{
	return bees->fitness[i];
}
/*
void setP(Bees bees, int i, float newP)
{
	bees->p[i] = newP;
}

float getP(Bees bees, int i)
{
	return bees->p[i];
}
*/
void setPosition(Bees bees, int i, float newPosition[])
{
	int y;
	for (y=0; y<D; y++)
		bees->positions[i][y] = newPosition[y];
}

float *getPosition(Bees bees, int i)
{
	return bees->positions[i];
}
