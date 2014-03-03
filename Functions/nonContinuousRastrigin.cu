#include "nonContinuousRastrigin.h"

#if FUNCTION == NON_CONTINUOUS_RASTRIGIN

__device__ float formulae(float values[])
{
	float result = 0.0;
	float partialResult, value;
	int i;

	for (i=0; i<D; i++)
	{
		value = calculateValue(values[i]);
		partialResult = 2 * (float) M_PI * value;
		partialResult = -10 * cosf(partialResult);
		partialResult = partialResult + 10;
		result = result + powf(value, 2) + partialResult;
	}
	return result;
}

	__device__ float calculateValue(float value)
	{
		if (fabs(value) >= 0.5)
			return (2 * (float) round2(value)) / 2;
		return value;
	}

		__device__ int round2(float number)
		{
			return (number >= 0) ? (int)(number + 0.5) : (int)(number - 0.5);
		}

#endif