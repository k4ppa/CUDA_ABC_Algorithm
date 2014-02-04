#ifndef BEES_H_
#define BEES_H_

#include <stdlib.h>
#include "types.h"
#include "costant.h"
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
	float p[NUMBER_OF_EMPLOYED];
	int trial[SN];
};
typedef struct bees *Bees;


void initializeType(Bees bees);
	void chooseBeeType(Bees bees, int i);
			

void employedPlacement(Bees bees, int);
	BOOL isEmployed(Bees bees, int i);
	void generateNewPosition(Bees bees, int i);
		float chooseRandomValueBetweenRange(float lowerBound, float upperBound);
	float evaluateFitness(float position[]);


void onlookerPlacement(Bees bees, int i);
	void generateEmployedP(Bees bees, int i);
		float calcolateP(Bees bees, int i);
	void chooseOnlookerPosition(Bees bees, int i);
		int rouletteWheelEmployedSelection(Bees bees);
		int tournamentEmployedSelection(Bees bees);
			int winnerTournament(Bees bees, int tournamentIndex[]);
		void moveOnlookerInPosition(Bees bees, int i, int selectedEmployed);
	BOOL isUnassignedOnlooker(Bees bees, int i);


void foodExploitation(Bees bees, int i);
	BOOL hasExceededTheLimit(Bees bees, int i);
	void resetBee(Bees bees, int i);
	void tryToFindBetterPosition(Bees bees, int i);
	void generatePerturbedPosition(Bees bees, int i, float perturbedPosition[]);
		int chooseIndex(int i);
		void controlifExceedSearchField(float newPosition[], int y);
	void chooseBestPosition(Bees bees, int i, float perturbedPosition[]);
		BOOL isPerturbedFitnessBetter(Bees bees, int i, float perturbedFitness);
		void replacePosition(Bees bees, int i, float perturbedPosition[], float perturbedFitness);
		void increaseTrial(Bees bees, int i);
	

void setType(Bees bees, int i, unsigned int newType);
unsigned int getType(Bees bees, int i);
void setTrial(Bees bees, int i, int newTrial);
int getTrial(Bees bees, int i);
void setFitness(Bees bees, int i, float newFitness);
float getFitness(Bees bees, int i);
void setP(Bees bees, int i, float newP);
float getP(Bees bees, int i);
void setPosition(Bees bees, int i, float newPosition[]);
float *getPosition(Bees bees, int i);
			

#endif

