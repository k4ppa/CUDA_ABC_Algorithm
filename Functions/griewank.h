#ifndef GRIEWANK_H_
#define GRIEWANK_H_

#include <math.h>
#include "../costant.h"

#if FUNCTION == GRIEWANK

	#define MIN_SEARCH_RANGE -600.0
	#define MAX_SEARCH_RANGE 600.0

	float formulae(float values[]);
		float calculateSummation(float values[]);
		float calculateProductsOfSequences(float values[]);

#endif
#endif