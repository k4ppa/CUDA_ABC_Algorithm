#include "rastrigin.h"

#if FUNCTION == RASTRIGIN

float formulae(float values[])
{
	float result = 0.0;
	float partialResult;
	int i;

	for (i=0; i<D; i++)
	{
		partialResult = 2 * (float) M_PI * values[i];
		partialResult = -10 * cosf(partialResult);
		partialResult = partialResult + 10;
		result = result + powf(values[i], 2) + partialResult;
	}
	return result;
}

#endif