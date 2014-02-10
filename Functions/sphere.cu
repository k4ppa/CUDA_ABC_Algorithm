#include "sphere.h"

#if FUNCTION == SPHERE

__device__ float formulae(float values[])
{
	float result = 0.0;
	int i;

	for (i=0; i<D; i++)
		result = result + (values[i]*values[i]);
	return result;
}

#endif