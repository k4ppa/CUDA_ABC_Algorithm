#ifndef KERNEL_H_
#define KERNEL_H_

#include "bees.h"

void inizializeBees(Bees dev_bees, curandState *dev_randState);
void beesWork(Bees bees);
	void assignEmployed(Bees bees);
	void beesSearch(Bees bees);

#endif
