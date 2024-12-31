# Objective-C KVO Crash: Observing a Deallocated Object

This repository demonstrates an uncommon Objective-C bug related to Key-Value Observing (KVO) and memory management.  The issue arises when an object observes another object that is deallocated before the observation is explicitly removed, resulting in a crash.

## The Bug

The `bug.m` file contains code that sets up KVO observation.  The observed object is deallocated before the observer removes itself from observing, leading to the crash. This is a classic example of memory management issues in the context of KVO.

## The Solution

The `bugSolution.m` file provides a solution. Before deallocating the observed object, the observer removes itself from observation using `removeObserver`. This prevents the application from attempting to send messages to a deallocated object.

## How to Reproduce

1. Clone this repository.
2. Open the project in Xcode.
3. Build and run the `bug.m` version. You will likely see a crash.
4. Then, run `bugSolution.m`, which demonstrates the correct way of handling KVO and object deallocation.