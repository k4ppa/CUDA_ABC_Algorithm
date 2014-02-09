#ifndef BEES_H_
#define BEES_H_

#include <stdlib.h>
#include "types.h"
#include "costant.h"
#include "curand_kernel.h"
#include "cuda.h"
#include "Functions/sphere.h"
#include "Functions/rosenbrock.h"
#include "Functions/ackley.h"
#include "Functions/griewank.h"
#include "Functions/weierstrass.h"
#include "Functions/rastrigin.h"
#include "Functions/nonContinuousRastrigin.h"
#include "Functions/schwefel.h"

#define EMPLOYED 1
#define ASSIGNED_ONLOOKER 2
#define UNASSIGNED_ONLOOKER 3

struct bees
{
	Flag type[SN];
	float positions[SN][D];
	float fitness[SN];
	//float p[NUMBER_OF_EMPLOYED];
	int trial[SN];
};
typedef struct bees *Bees;

void initializeType(Bees bees);
	void chooseBeeType(Bees bees, int i);
			

__global__ void cudaEmployedPlacement(Bees bees, curandState *randState);
	__device__ void employedPlacement(Bees bees, int i, curandState *randState);
		__device__ BOOL isEmployed(Bees bees, int i);
		__device__ void generateNewPosition(Bees bees, int i, curandState *randState);
			__device__ float chooseRandomValueBetweenRange(float lowerBound, float upperBound, curandState *randState);
		__device__ float evaluateFitness(float position[]);


__global__ void cudaOnlookerPlacement(Bees bees, curandState *randState);
	__device__ void onlookerPlacement(Bees bees, int i, curandState *randState);
//		void generateEmployedP(Bees bees, int i);
//			float calcolateP(Bees bees, int i);
		__device__ void chooseOnlookerPosition(Bees bees, int i, curandState *randState);
//			int rouletteWheelEmployedSelection(Bees bees);
			__device__ int tournamentEmployedSelection(Bees bees, curandState *randState);
				__device__ int winnerTournament(Bees bees, int tournamentIndex[]);
			__device__ void moveOnlookerInPosition(Bees bees, int i, int selectedEmployed);
		__device__ BOOL isUnassignedOnlooker(Bees bees, int i);


__global__ void cudaFoodExploitation(Bees bees, curandState *randState);
	__device__ void foodExploitation(Bees bees, int i, curandState *randState);
		__device__ BOOL hasExceededTheLimit(Bees bees, int i);
		__device__ void resetBee(Bees bees, int i, curandState *randState);
		__device__ void tryToFindBetterPosition(Bees bees, int i, curandState *randState);
		__device__ void generatePerturbedPosition(Bees bees, int i, float perturbedPosition[], curandState *randState);
			__device__ int chooseIndex(int i, curandState *randState);
			__device__ void controlifExceedSearchField(float newPosition[], int y);
		__device__ void chooseBestPosition(Bees bees, int i, float perturbedPosition[]);
			__device__ BOOL isPerturbedFitnessBetter(Bees bees, int i, float perturbedFitness);
			__device__ void replacePosition(Bees bees, int i, float perturbedPosition[], float perturbedFitness);
			__device__ void increaseTrial(Bees bees, int i);
	

__host__ __device__ void setType(Bees bees, int i, unsigned int newType);
__host__ __device__ unsigned int getType(Bees bees, int i);
__device__ void setTrial(Bees bees, int i, int newTrial);
__host__ __device__ int getTrial(Bees bees, int i);
__device__ void setFitness(Bees bees, int i, float newFitness);
__host__ __device__ float getFitness(Bees bees, int i);
//void setP(Bees bees, int i, float newP);
//float getP(Bees bees, int i);
__device__ void setPosition(Bees bees, int i, float newPosition[]);
__device__ float *getPosition(Bees bees, int i);
			

#endif

