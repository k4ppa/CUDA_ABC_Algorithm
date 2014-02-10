#include "schwefel.h"

#if FUNCTION == SCHWEFEL

__device__ float formulae(float values[])
{
	float result = 418.9829f * D;
	return (result) - calculation(values);
}

	__device__ float calculation(float values[])
	{
		float result = 0.0;
		int i;

		for (i=0; i<D; i++)
			result = result + values[i] * sinf(sqrtf(fabs(values[i])));
		return result;
	}

#endif