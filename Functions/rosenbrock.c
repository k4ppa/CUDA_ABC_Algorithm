#include "rosenbrock.h"

#if FUNCTION == ROSENBROCK

float formulae(float values[])
{
	float result = 0.0;
	float partialResult1, partialResult2;
	int i;

	for (i=0; i<D-1; i++)
	{
		partialResult1 = values[i+1] - powf(values[i], 2);
		partialResult1 = 100.0f * powf(partialResult1, 2);
		partialResult2 = values[i] - 1.0f;
		partialResult2 = powf(partialResult2, 2);
		result = result + (partialResult1 + partialResult2);
	}
	return result;
}

#endif