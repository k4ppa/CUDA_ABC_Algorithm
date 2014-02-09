#include "types.h"

__host__ __device__ void setBits(Flag *type, unsigned int newBits)
{
	(*type).bits = newBits;
}

__host__ __device__ unsigned int getBits(Flag *type)
{
	return (*type).bits;
}
