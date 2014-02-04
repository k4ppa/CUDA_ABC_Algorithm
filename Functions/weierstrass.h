#ifndef WEIERSTRASS_H_
#define WEIERSTRASS_H_

#define _USE_MATH_DEFINES

#include <math.h>
#include "../costant.h"

#if FUNCTION == WEIERSTRASS

	#define MIN_SEARCH_RANGE -0.5
	#define MAX_SEARCH_RANGE 0.5

	float formulae(float values[]);
		float firstCalculation(float values[]);
		float secondCalculation();
		float calcolateSummation(float num);

#endif
#endif