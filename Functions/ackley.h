#ifndef ACKLEY_H_
#define ACKLEY_H_

#define _USE_MATH_DEFINES

#include <math.h>
#include "../costant.h"

#if FUNCTION == ACKLEY

	#define MIN_SEARCH_RANGE -32768.0
	#define MAX_SEARCH_RANGE 32768.0

	float formulae(float values[]);
		float firstCalculation(float values[]);
		float secondCalculation(float values[]);

#endif
#endif