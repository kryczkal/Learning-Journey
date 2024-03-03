# Hanoi Tower Project

This repository contains an advanced C++ implementation of the classic Hanoi Tower problem. The project is structured into several files, each with a specific role in solving the problem with both recursive and non-recursive approaches.

## File Descriptions

- `hanoi.h`: Defines the `hanoi` class, which encapsulates the logic for solving the Hanoi Tower problem. It includes methods for both recursive (`hanoiRecu`) and non-recursive (`hanoiNonRecu`) solutions, as well as a custom solution (`hanoiMyNonRecu`). The class demonstrates a deep understanding of template metaprogramming, using template specialization to optionally display each move.

- `main.cpp`: The entry point of the program that creates an instance of the `hanoi` class and initiates the game. It's a practical example of how to implement the class in a working application.

- `stack.h`: Implements a generic `stack` data structure used by the `hanoi` class to represent the towers. It shows a solid grasp of generic programming in C++.

- `timer.h`: Provides a `timer` class that can be used to benchmark the different solutions. This file showcases the use of RAII (Resource Acquisition Is Initialization) principles for resource management in C++.

## Advanced Concepts

This project demonstrates my current understanding and application of C++ including:

- **Template Metaprogramming**: Utilizing templates to write generic and reusable code.
- **RAII**: Implementing classes that manage resources with a focus on performance and safety.
- **Algorithm Optimization**: Comparing recursive and non-recursive solutions for algorithm efficiency.
- **Modern C++ Features**: Employing C++11 and beyond features such as `auto`, range-based loops, lambda expressions, and smart pointers.

## Conclusion

This Hanoi Tower project is a clear indication of my proficiency in C++ and my ability to write complex, efficient, and well-structured code. It reflects my ability to not just solve problems, but also to write code that is both performant and in line with modern C++ best practices.
