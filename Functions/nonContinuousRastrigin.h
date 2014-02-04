#ifndef NON_CONTINUOUS_RASTRIGIN_H_
#define NON_CONTINUOUS_RASTRIGIN_H_

#define _USE_MATH_DEFINES

#include <math.h>
#include "../costant.h"

#if FUNCTION == NON_CONTINUOUS_RASTRIGIN

	#define MIN_SEARCH_RANGE -5.12f
	#define MAX_SEARCH_RANGE 5.12f

	float formulae(float values[]);
		float calculateValue(float value);
			int round(float number);

#endif
#endif