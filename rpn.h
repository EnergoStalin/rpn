#ifndef RPN_H_
#define RPN_H_

#include <stdio.h>
#include <stdlib.h>
#define STACKSIZE 265

enum error { OK };

enum error rpn(double *result, char *expr);

#endif /* RPN_H_ */
