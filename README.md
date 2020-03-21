# Testing Framework

A flexible and modular unit testing framework that is also easy to use.

## Documentation

To use the unit testing framework, include `framework.h` into the file where test cases are defined. Compile and link with `framework.cpp`. Note that the framework will only catch and continue running on exceptions thrown by the test case. There's nothing that can be done on segmentation faults, `assert` failures from `<cassert>`, or more exotic bugs that crash crash.

### Assertions

Test cases can be written as usual. Use the templated assertion functions: `assert_true`, `assert_false`, `assert_eq`, `assert_neq`, `assert_less`, `assert_leq`, `assert_greater`, and `assert_geq`. These functions have an associated error message parameter should the assertion fail. Under the hood, each of the assert functions throws a custom `test_error` exception that inherits from `std::exception`.

Since the framework is designed to catch exceptions, best practice is to use the appropriate assert function. This guarantees that the framework can catch and resolve failures. For best results, only use exceptions that are derived from `std::exception`. Exceptions of this type have a `what` member function that yields an error message. If anythin else is thrown, the framework simply records that it caught an unknown exception.

### Test Registration

In some main area of code, create an instance `Framework` and call `emplace` to register test names with the associated `std::function`. Note that if `emplace` is called twice with the same test name, the old function will be overwritten. Check if the framework already has a name by calling `contains`. Test case functions must have a signature of `void()` to be compatbile with the framework. That is, they don't take parameters, and they return nothing. To see the number of tests passed in, use `total_size`.

### Test state and Execution

At this point, a test can be in one of two states. It has either been executed or it has not. If a test has been executed, it can be in either a passed or failed state. If it failed, the test will have an associated error message string corresponding to the `what` result of the triggered exception. Use `executed` to check whether or not a test has been run. If it has, call the `passed` or `failed` overloads that take a `std::string` parameter to check the result of this execution. If it failed, use `error_msg` to get the corresponding error message. To run a particular test, pass the test name to `run`. This will execute the test (if it hasn't already been executed), catch any exceptions, and record the error message. As a shortcut, simply call `run_all` to call `run` on all registered tests.

### Summarizing Results

After calling `run` however many times you'd like or just using `run_all`, use `executed_size` to obtain the number of test cases that have been executed. Calling `passed` or `failed` without any parameters will return the number of passed or failed test cases, respectively. Note that `passed() + failed() == executed_size()`. The framework can produce a well-formatted summary of test results. To do so, call `result` with a test name and output stream. Doing so will print the status of the test into the output stream. The `operator<<` overload will print the status of every registered test.
