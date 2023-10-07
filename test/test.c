#include <check.h>
#include <stdlib.h>

#include "../rpn.h"

START_TEST(rpn_1) {
  double result = 0;

  rpn(&result, "2 3 2 + / 5 *");
  ck_assert_ldouble_eq_tol(result, 5, 1e-8);

  rpn(&result, "90 c");
  ck_assert_ldouble_eq_tol(result, 5, 1e-8);

  rpn(&result, "5 C");
  ck_assert_ldouble_eq_tol(result, 5, 1e-8);
}
END_TEST

Suite *rpn_suite() {
  Suite *s;
  TCase *tc_tan;

  s = suite_create("rpn");

  tc_tan = tcase_create("rpn");
  tcase_add_test(tc_tan, rpn_1);
  suite_add_tcase(s, tc_tan);
  return s;
}

int main() {
  SRunner *sr = srunner_create(rpn_suite());

  srunner_set_fork_status(sr, CK_NOFORK);
  srunner_run_all(sr, CK_NORMAL);

  int failed = srunner_ntests_failed(sr);
  srunner_free(sr);
  return (failed == 0) ? EXIT_SUCCESS : EXIT_FAILURE;
}
