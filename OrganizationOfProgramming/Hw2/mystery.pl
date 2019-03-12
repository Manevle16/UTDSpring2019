mystery(X,[X|R],R).
mystery(X,[F|R],[F|S]) :- mystery(X,R,S).
