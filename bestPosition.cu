#include "bestPosition.h"

#if DEBUG == ENABLED
#include "printBees.h"
#endif

void saveBestPosition(BestBee bestBee, Bees bees)
{
	int i;

	controlInizialization(bestBee, bees);
	for (i=0; i<SN; i++)
		controlPosition(bestBee, bees, i);	
}

	void controlInizialization(BestBee bestBee, Bees bees)
	{
		if (isNotAlreadyInizialized(bestBee))
		{
			replaceBestPosition(bestBee, bees, 0);
			setInizializedTrue(bestBee);
		}
	}

		BOOL isNotAlreadyInizialized(BestBee bestBee)
		{
			return getInizialized(bestBee) == FALSE;
		}
	
	void controlPosition(BestBee bestBee, Bees bees, int i)
	{
		if (isBeePositionBetter(bestBee, bees, i))
			replaceBestPosition(bestBee, bees, i);
	}

		BOOL isBeePositionBetter(BestBee bestBee, Bees bees, int i)
		{
			return getBestFitness(bestBee) > getFitness(bees, i);
		}

void replaceBestPosition(BestBee bestBee, Bees bees, int i)
{
	setBestPosition(bestBee, getPosition(bees, i));
	setBestFitness(bestBee, getFitness(bees, i));
}
