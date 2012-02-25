--- 
title: Quicksort C++ implementation
---
Hello. I just had to implement a quicksort algorithm version in C++ for an exercise. Here is what I've done:

[The code on friendpaste.com](http://www.friendpaste.com/2DW2gWYPnoaQ9P5XGtmCng)


~~~ cpp
#include <iostream>
#include <vector>

using namespace std;

void swap(int &a, int &b)
{
    int temp;
    a = b;
    b = temp;
}

int split_array(vector<int>& array, int pivot, int start_index, int end_index)
{
    int left_boundary = start_index;
    int right_boundary = end_index;

    while (left_boundary < right_boundary) {

        while (pivot < array[right_boundary] && right_boundary > left_boundary) {
            right_boundary--;
        }

        swap(array[left_boundary], array[right_boundary]);

        while (pivot >= array[left_boundary] && left_boundary < right_boundary) {
            left_boundary++;
        }

        swap(array[right_boundary], array[left_boundary]);
    }

    return left_boundary;
}

void quicksort(vector<int>& array, int start_index, int end_index)
{
    int pivot = array[start_index];
    int split_point;

    if (end_index > start_index) {
        split_point = split_array(array, pivot, start_index, end_index);
        array[split_point] = pivot;
        quicksort(array, start_index, split_point-1);
        quicksort(array, split_point+1, end_index);
    }
}
~~~
