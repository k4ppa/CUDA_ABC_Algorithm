#ifndef BESTBEE_H_
#define BESTBEE_H_

#include "costant.h"
#include "types.h"

struct bestBee
{
	float bestPosition[D];
	float bestFitness;
	BOOL inizialized;
};
typedef struct bestBee *BestBee;

void setBestFitness(BestBee bestBee, float newBestFitness);
float getBestFitness(BestBee bestBee);
void setBestPosition(BestBee bestBee, float newBestPosition[]);
float *getBestPosition(BestBee bestBee);
void setInizializedTrue(BestBee bestBee);
void setInizializedFalse(BestBee bestBee);
BOOL getInizialized(BestBee bestBee);

#endif
