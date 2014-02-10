#ifndef WEIERSTRASS_H_
#define WEIERSTRASS_H_

#define _USE_MATH_DEFINES

#include <math.h>
#include "../costant.h"

#if FUNCTION == WEIERSTRASS

	#define MIN_SEARCH_RANGE -0.5
	#define MAX_SEARCH_RANGE 0.5

	__device__ float formulae(float values[]);
		__device__ float firstCalculation(float values[]);
		__device__ float secondCalculation();
		__device__ float calcolateSummation(float num);

#endif
#endif