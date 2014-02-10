#include "ackley.h"

#if FUNCTION == ACKLEY

__device__ float formulae(float values[])
{	
	return firstCalculation(values) - secondCalculation(values) + 20 + (float) M_E;
}

	__device__ float firstCalculation(float values[])
	{
		float partialResult = 0.0;
		int i;

		for (i=0; i<D; i++)
			partialResult = partialResult + (powf(values[i], 2));
		partialResult = -0.2f * sqrtf(partialResult / D);
		partialResult = -20 * expf(partialResult);
		return partialResult;
	}

	__device__ float secondCalculation(float values[])
	{
		float result = 0.0;
		int i;

		for (i=0; i<D; i++)
			result = result + (cosf(2 * M_PI * values[i]));
		return expf(result / D);
	}

#endif