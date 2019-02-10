;Function that checks if integer is divisible by 7
(defun divisible-by-7 (x) (eql (mod x 7) 0))

;Function that passes in 3 to given function
(defun function-3 (x) (funcall x 3))

;Function that takes two lists and zips them into a list of pairs
(defun zipper (x y)
  (if (= (list-length x) 0) NIL
    (if (= (list-length y) 0) NIL
      (cons (cons (car x) (cons (car y) NIL)) (zipper (cdr x) (cdr y)))
    )
  )
)

;Function that applys function to every element in the given list
(defun my-map(x y)
  (if (= (list-length y) 0) NIL
    (cons (funcall x (car y)) (my-map x (cdr y)))
  )
)

;Split given integer list into a list of two list seperating evens and odds
;(NIL NIL) is equal to ('() '()) occording to online so that is the output when given an empty list
(defun segregate(x)
  (cons (get-evens x) (cons (get-odds x) NIL))
)

(defun get-evens(x)
  (if (= (list-length x) 0) NIL
    (if (= (mod (car x) 2) 0) (cons (car x) (get-evens (cdr x)))
      (get-evens (cdr x))
    )
  )
)

(defun get-odds(x)
  (if (= (list-length x) 0) NIL
    (if (= (mod (car x) 2) 1) (cons (car x) (get-odds (cdr x)))
      (get-odds (cdr x))
    )
  )
)
