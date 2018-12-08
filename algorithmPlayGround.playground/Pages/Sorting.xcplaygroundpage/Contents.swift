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

func quickSort(_ arr : inout [Int], left : Int, right : Int) {
    var i : Int = left
    var j : Int = right
    let pivot : Int = arr[left+right/2]
    var tmp : Int
    if left < right {
        while (i < j) {
            while (arr[j] > pivot) {
                j -= 1
            }
            while (i < j && arr[i] <= pivot) {
                i += 1
            }
            
            tmp = arr[i]
            arr[i] = arr[j]
            arr[j] = tmp
        }
    }
        
    quickSort(&arr, left: left, right: i-1)
    quickSort(&arr, left: i+1, right: right)
}

var sortList : [Int] = [8,2,10,9,11,1,7,3,4]
quickSort(&sortList, left: 0, right: sortList.count-1)
print(sortList)

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
 
 public void quickSort(int[] arr, int left, int right) {
 int i, j, pivot, tmp;
 if (left < right) {
 i = left;   j = right;
 pivot = arr[(left+right)/2];
 //분할 과정
 while (i < j) {
 while (arr[j] > pivot) j--;
 // 이 부분에서 arr[j-1]에 접근해서 익셉션 발생가능함.
 while (i < j && arr[i] <= pivot) i++;
 
 tmp = arr[i];
 arr[i] = arr[j];
 arr[j] = tmp;
 }
 //정렬 과정
 quickSort(arr, left, i - 1);
 quickSort(arr, i + 1, right);
 }
 }
 
 */

func mergeSort() {
    
}

func selectionSort() {
    
}
