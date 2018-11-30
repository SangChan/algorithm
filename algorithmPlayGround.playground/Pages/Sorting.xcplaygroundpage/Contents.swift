//: [Previous](@previous)

import Foundation

/*
 Sorting
 */

//var sortList : Array<Int> = [8,2,10,9,11,1,7,3,4]

func insertionSort(_ sortList : inout Array<Int>) {
    var x = 0 ,y = 0
    for key in sortList {
        print("{\(x):\(key)}")
        let newList = sortList.prefix(through: x)
        y = newList.count - 1
        for reverseKey in newList.reversed()  {
            print("[\(y):\(reverseKey)]")
            if key < reverseKey {
                print("oldSortList=\(sortList)")
                sortList.remove(at: y+1)
                sortList.insert(key, at: y)
                print("newSortList=\(sortList)")
            }
            y -= 1
        }
        x += 1
    }
    
    print("done \(sortList)")
}

//insertionSort()

func bubbleSort(_ sortList : inout Array<Int>) {
    var z,passes,key: Int
    
    for x in 0..<sortList.count {
        passes = sortList.count - 1 - x
        print("{x=\(x),passes=\(passes)}")
        for y in 0..<passes {
            key = sortList[y]
            print("[y=\(y), key=\(key)]")
            if key > sortList[y+1] {
                print("oldSortList=\(sortList)")
                z = sortList[y+1]
                sortList[y+1] = key
                sortList[y] = z
                print("newSortList=\(sortList)")
            }
        }
    }
    
    print("done \(sortList)")
}

//bubbleSort()

func quickSort(_ sortList : inout Array<Int>) {
    
}

/*
 function partition(a, left, right, pivotIndex)
 pivotValue := a[pivotIndex]
 swap(a[pivotIndex], a[right]) // 피벗을 끝으로 옮겨 놓는다.
 storeIndex := left
 for i from left to right-1
 if a[i] <= pivotValue then
 swap(a[storeIndex], a[i])
 storeIndex := storeIndex + 1
 swap(a[right], a[storeIndex]) // 피벗을 두 리스트 사이에 위치시킨다.
 return storeIndex
 
 void quickSort(int arr[], int left, int right) {
 int i = left, j = right;
 int pivot = arr[(left + right) / 2];
 int temp;
 do
 {
 while (arr[i] < pivot)
 i++;
 while (arr[j] > pivot)
 j--;
 if (i<= j)
 {
 temp = arr[i];
 arr[i] = arr[j];
 arr[j] = temp;
 i++;
 j--;
 }
 } while (i<= j);
 
 /* recursion */
 if (left < j)
 quickSort(arr, left, j);
 
 if (i < right)
 quickSort(arr, i, right);
 }
 
 */

func mergeSort() {
    
}

func selectionSort() {
    
}
