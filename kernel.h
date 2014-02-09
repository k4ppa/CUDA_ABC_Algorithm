#ifndef KERNEL_H_
#define KERNEL_H_

#include "bees.h"

void inizializeBees(Bees dev_bees, curandState *dev_randState);
void beesWork(Bees dev_bees, curandState *dev_randStates);
	void assignEmployed(Bees dev_bees, curandState *dev_randState);
	void beesSearch(Bees bees);

#endif
