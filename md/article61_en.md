---
title: 【JavaScript】Tricks for easily sorting character strings in a hash array
---

How to sort hash strings in javascript sorting

## overview

1. Prepare an array whose elements are objects
```
const array = [
{ id: 1, text: 'text5' },
{ id: 2, text: 'text3' },
{ id: 5, text: 'text2' },
{ id: 3, text: 'text4' },
{ id: 4, text: 'text1' },
```

2. Sort the array


```
array.sort((a, b) => b.text > a.text ? -1 : 1)
```

3. Display the sorted array
```
console.log(array);
```

As above, when sorting an array, use the sort() method and pass the comparison function. A comparison function takes two arguments and defines a sorting criterion. In the above example, it sorts in ascending order of text based on the condition b.text > a.text. It also uses the ternary operator to determine ascending or descending order.

Note that this example sorts strings in hashes, but basically you can sort based on the properties of the objects in the array.
