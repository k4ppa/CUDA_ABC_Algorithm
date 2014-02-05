#include "types.h"

void setBits(Flag *type, unsigned int newBits)
{
	(*type).bits = newBits;
}

unsigned int getBits(Flag *type)
{
	return (*type).bits;
}