#ifndef TYPES_H_
#define TYPES_H_

#define BOOL int
#define TRUE 1
#define FALSE 0

#define ENABLED 1
#define DISABLED 0

#define DEBUG DISABLED

#if DEBUG == ENABLED
#define dprintf printf
#else
#define dprintf 0 && printf
#endif

struct twoBit
{
     unsigned int bits: 2;
};
typedef struct twoBit Flag;

void setBits(Flag *type, unsigned int newBits);
unsigned int getBits(Flag *type);

#endif