let EvenOdd = (x) => {
    if(isNaN(x)){
        return 'Not a valid number';
    }

    x = Math.abs(x);
    if(x === 1){
        return 'Odd';
    }else if(x === 0){
        return 'Even';
    }

    return EvenOdd(x - 2);
};

console.log(EvenOdd(5));


MyMathFunction = (x, y, func) => {
    return func(x, y);
};

Multiply = (x, y) => {
    return x*y;
};

Divide = (x, y) => {
    if(y === 0){
        return 'Cannot Divide by 0!';
    }
    return x/y;
};

Add = (x, y) => {
    return x + y;
};

Subtract = (x, y) => {
    return x - y;
};

console.log(MyMathFunction(50, 0, Subtract));

SortMyArray = (arr) => {
    if(arr.length === 0){
        return 'Cannot sort an Empty Array!';
    }
    let found = true;
    while(found){
        found = false;
        for(let i = 0; i < arr.length - 1; i++){
            if(arr[i] > arr[i+1]){
                let temp = arr[i];
                arr[i] = arr[i+1];
                arr[i+1] = temp;
                found = true;
            }
        }
    }

    return arr;
};

var arr1=[-3,8,7,6,5,-4,3,2,1];
console.log(SortMyArray(arr1));

myFib = (x) => {
    if(isNaN(x) || !Number.isInteger(x)){
        return 'Not an integer value!';
    }

    if(x === 0 || x === 1){
        return 3;
    }

    return myFib(x - 1) + myFib(x - 2);
};

console.log(myFib(8));
