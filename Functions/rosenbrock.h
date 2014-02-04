#ifndef ROSENBROCK_H_
#define ROSENBROCK_H_

#include <math.h>
#include "../costant.h"

#if FUNCTION == ROSENBROCK

	#define MIN_SEARCH_RANGE -2048.0
	#define MAX_SEARCH_RANGE 2048.0

	float formulae(float values[]);

#endif
#endif