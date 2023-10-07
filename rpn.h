#ifndef RPN_H_
#define RPN_H_

#ifndef PI
#define PI 3.1415
#endif

#ifndef STACKSIZE
#define STACKSIZE 265
#endif

enum error { OK };

enum error rpn(double *result, char *expr);
void printstack(void);

#endif /* RPN_H_ */
