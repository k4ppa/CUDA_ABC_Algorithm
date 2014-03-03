#include "bees.h"
#include "stdio.h"
void initializeType(Bees bees)
{
	int i;
	for (i=0; i<SN; i++)
		chooseBeeType(bees, i);
}

	void chooseBeeType(Bees bees, int i)
	{
		if (i < NUMBER_OF_EMPLOYED)
			setType(bees, i, EMPLOYED);
		else
			setType(bees, i, UNASSIGNED_ONLOOKER);
	}


__global__ void cudaEmployedPlacement(Bees bees, curandState *randState)
{
	int i = blockIdx.x * blockDim.x + threadIdx.x;
	employedPlacement(bees, i, randState);
}

	__device__ void employedPlacement(Bees bees, int i, curandState *randState)
	{
		float fitness;
	
		if (isEmployed(bees, i)) 
		{
			generateNewPosition(bees, i, randState);
			fitness = evaluateFitness(bees->positions[i]);
			setFitness(bees, i, fitness);
			setTrial(bees, i, 0);
			//setP(bees, i, 0.0);
		}
	}
	
		__device__ BOOL isEmployed(Bees bees, int i)
		{
			return getType(bees, i) == EMPLOYED;
		}

		__device__ void generateNewPosition(Bees bees, int i, curandState *randState)
		{
			int y;
			for (y=0; y<D; y++) {
				bees->positions[i][y] = chooseRandomValueBetweenRange(MIN_SEARCH_RANGE, MAX_SEARCH_RANGE, randState);
				//printf("\n%f\n", bees->positions[i][y]);
			}
		}

			__device__ float chooseRandomValueBetweenRange(float lowerBound, float upperBound, curandState *randState)
			{
				int tid = threadIdx.x;
				float random = curand_uniform(&randState[tid]);;
				float range = upperBound - lowerBound;
				return lowerBound + (random * range);
			}

		__device__ float evaluateFitness(float position[])
		{
			float fitness = formulae(position);
			//if (fitness == 0.0)
				//return 1;
			return fabs(fitness);
		}
		



__global__ void cudaOnlookerPlacement(Bees bees, curandState *randState)
{
	int i = blockIdx.x * blockDim.x + threadIdx.x;
	onlookerPlacement(bees, i, randState);
}

	__device__ void onlookerPlacement(Bees bees, int i, curandState *randState)
	{
		//generateEmployedP(bees, i);
		if (isUnassignedOnlooker(bees, i))
		{
			chooseOnlookerPosition(bees, i, randState);
			setTrial(bees, i, 0);
			setType(bees, i, ASSIGNED_ONLOOKER);
		}
	}
	/*
		void generateEmployedP(Bees bees, int i)
		{
			float newP;
			if (isEmployed(bees, i)) 
				newP = calcolateP(bees, i);
				setP(bees, i, newP);
		}
	
			float calcolateP(Bees bees, int i)
			{
				float fitnessSummation = 0.0;
				int y;
				for (y=0; y<NUMBER_OF_EMPLOYED; y++)
					fitnessSummation = fitnessSummation + getFitness(bees, i);
				return getFitness(bees, i) / fitnessSummation;
			}
	*/
		__device__ BOOL isUnassignedOnlooker(Bees bees, int i)
		{
			return getType(bees, i) == UNASSIGNED_ONLOOKER;
		}

		__device__ void chooseOnlookerPosition(Bees bees, int i, curandState *randState)
		{
			int selectedEmployed = tournamentEmployedSelection(bees, randState);
			moveOnlookerInPosition(bees, i, selectedEmployed);
		}
	/*
			int rouletteWheelEmployedSelection(Bees bees)
			{
				float totalFitness = getFitness(bees, 0);
				int y;
				for (y=1; y<NUMBER_OF_EMPLOYED; y++)
				{
					totalFitness = totalFitness + getFitness(bees, y);
					if (chooseRandomValueBetweenRange(0.0f, 1.0f) < getFitness(bees, y) / totalFitness)
						return y;
				}
				return 0;
			}
	*/
			__device__ int tournamentEmployedSelection(Bees bees, curandState *randState)
			{
				int tournamentIndex[calcolateTournamentSize()];
				int i;
			
				for (i=0; i<calcolateTournamentSize(); i++)
					tournamentIndex[i] = chooseRandomValueBetweenRange(0, NUMBER_OF_EMPLOYED, randState);
					//tournamentIndex[i] = (rand() % (NUMBER_OF_EMPLOYED - 0)) + 0;

				return winnerTournament(bees, tournamentIndex);
			}

				__device__ int winnerTournament(Bees bees, int tournamentIndex[])
				{
					int i;
					int winnerBee = tournamentIndex[0];
					double winnerFitness = getFitness(bees, tournamentIndex[0]);

					for (i=1; i<calcolateTournamentSize(); i++)
					{
						if (getFitness(bees, tournamentIndex[i]) < winnerFitness)
						{
							winnerFitness = getFitness(bees, tournamentIndex[i]);
							winnerBee = tournamentIndex[i];
						}
					}
					return winnerBee;
				}

			__device__ void moveOnlookerInPosition(Bees bees, int i, int selectedEmployed)
			{
				setPosition(bees, i, getPosition(bees, selectedEmployed));
				setFitness(bees, i, getFitness(bees, selectedEmployed));
			}
	


__global__ void cudaFoodExploitation(Bees bees, curandState *randState)
{
	int i = blockIdx.x * blockDim.x + threadIdx.x;
	foodExploitation(bees, i, randState);
}

	__device__ void foodExploitation(Bees bees, int i, curandState *randState)
	{
		if (hasExceededTheLimit(bees, i))
			resetBee(bees, i, randState);
		else
			tryToFindBetterPosition(bees, i, randState);
	}

		__device__ BOOL hasExceededTheLimit(Bees bees, int i)
		{
			return getTrial(bees, i) > LIMIT;
		}


		__device__ void resetBee(Bees bees, int i, curandState *randState)
		{
			if (isEmployed(bees, i))
				employedPlacement(bees, i, randState);
			else
				setType(bees, i, UNASSIGNED_ONLOOKER);
		}

		__device__ void tryToFindBetterPosition(Bees bees, int i, curandState *randState)
		{
			float perturbedPosition[D];
			generatePerturbedPosition(bees, i, perturbedPosition, randState);
			chooseBestPosition(bees, i, perturbedPosition);
		}

		__device__ void generatePerturbedPosition(Bees bees, int i, float perturbedPosition[], curandState *randState)
		{
			int y, k;
			for (y=0; y<D; y++)
			{
				k = chooseIndex(i, randState);
				perturbedPosition[y] = bees->positions[i][y] + chooseRandomValueBetweenRange(-1.0, 1.0, randState) * (bees->positions[i][y] - bees->positions[k][y]);
				controlifExceedSearchField(perturbedPosition, y);
			}
		}

			__device__ int chooseIndex(int i, curandState *randState)
			{
				int index;
				do
					//index = (rand() % (SN - 0)) + 0;
					index = chooseRandomValueBetweenRange(0, SN, randState);
				while (index == i);

				return index;
			}

			__device__ void controlifExceedSearchField(float newPosition[], int y)
			{
				if (newPosition[y] > MAX_SEARCH_RANGE)
					newPosition[y] = MAX_SEARCH_RANGE;
				else if (newPosition[y] < MIN_SEARCH_RANGE)
					newPosition[y] = MIN_SEARCH_RANGE;
			}

		__device__ void chooseBestPosition(Bees bees, int i, float perturbedPosition[])
		{
			float perturbedFitness = evaluateFitness(perturbedPosition);

			if (isPerturbedFitnessBetter(bees, i, perturbedFitness))
				replacePosition(bees, i, perturbedPosition, perturbedFitness);	
			else
				increaseTrial(bees, i);
		}

			__device__ BOOL isPerturbedFitnessBetter(Bees bees, int i, float perturbedFitness)
			{
				return getFitness(bees, i) > perturbedFitness;
			}

			__device__ void replacePosition(Bees bees, int i, float perturbedPosition[], float perturbedFitness)
			{
				setPosition(bees, i, perturbedPosition);
				setFitness(bees, i, perturbedFitness);
				setTrial(bees, i, 0);
			}

			__device__ void increaseTrial(Bees bees, int i)
			{
				int trial = getTrial(bees, i);
				setTrial(bees, i, trial+1);
			}
