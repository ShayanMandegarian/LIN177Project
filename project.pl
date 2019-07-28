:- ['numbers.pl'].

persian(X) :-
  persianOne(X);
  persianTeen(X);
  persianTen(X);
  persianHundred(X);
  persianThousand(X).

persianOne(X) :- % numbers 0-9
  %number(X, [zero]);
  number(Z, [zero]),
  Z = [Zero | _],
  atom_concat(Zero, '', X);
  number(Z, Y),
  member(ones, Y),
  Z = [Ones | _],
  atom_concat(Ones, '', X).

persianTeen(X) :- % numbers 10-19
  %number(X, [tens, teenroot]);
  number(Z, [tens, teenroot]),
  Z = [Ten | _],
  atom_concat(Ten, '', X);
  number(Z, Y),
  member(teen, Y),
  number(A, B),
  member(teenroot, B),
  Z = [Teen | _],
  A = [Root | _],
  atom_concat(Teen, Root, X).

persianTen(X) :- % numbers 20-99
  number(Z, [tens]),
  Z = [DoubleDigit | _],
  atom_concat(DoubleDigit, '', X);
  number(Z, [tens]),
  Z = [DoubleDigit | _],
  connector(Con),
  atom_concat(DoubleDigit, ' ', Temp),
  atom_concat(Temp, Con, Temp2),
  atom_concat(Temp2, ' ', Temp3),
  persianOne(One),
  not(One = sefr),
  %number(Ones, A),
  %member(ones, A),
  %Ones = [One | _],
  atom_concat(Temp3, One, X).

persianHundred(X) :- % numbers 100-999
  number(Z, Case), % 100, 200
  member(rootless, Case),
  Z = [Hundred | _],
  atom_concat(Hundred, '', X); % 101-109, 201-209
  number(Z, Case),
  member(rootless, Case),
  Z = [Hundred | _],
  atom_concat(Hundred, ' ', Temp),
  persianOne(One),
  not(One = sefr),
  atom_concat(Temp, One, X); % 110-119, 210-219
  number(Z, Case),
  member(rootless, Case),
  Z = [Hundred | _],
  atom_concat(Hundred, ' ', Temp),
  persianTeen(Teen),
  atom_concat(Temp, Teen, X); % 120-199, 220-299
  number(Z, Case),
  member(rootless, Case),
  Z = [Hundred | _],
  atom_concat(Hundred, ' ', Temp),
  persianTen(Ten),
  atom_concat(Temp, Ten, X); % 300, 400, 500, 600, 700, 800, 900
  number(Z, Case),
  Z = [Hundred | _],
  not(member(rootless, Case)),
  member(hundreds, Case),
  number(Y, [_, 'hundroot', _]),
  Y = [Root | _],
  atom_concat(Hundred, Root, X); % 301-309, 401-409, etc
  number(Z, Case),
  Z = [Hundred | _],
  not(member(rootless, Case)),
  member(hundreds, Case),
  number(Y, [_, 'hundroot', _]),
  Y = [Root | _],
  atom_concat(Hundred, Root, Temp),
  atom_concat(Temp, ' ', Temp2),
  persianOne(One),
  not(One = sefr),
  atom_concat(Temp2, One, X); % 310-319, 410-419, etc
  number(Z, Case),
  Z = [Hundred | _],
  not(member(rootless, Case)),
  member(hundreds, Case),
  number(Y, [_, 'hundroot', _]),
  Y = [Root | _],
  atom_concat(Hundred, Root, Temp),
  atom_concat(Temp, ' ', Temp2),
  persianTeen(Teen),
  atom_concat(Temp2, Teen, X); % 320-399, 420-499, etc
  number(Z, Case),
  Z = [Hundred | _],
  not(member(rootless, Case)),
  member(hundreds, Case),
  number(Y, [_, 'hundroot', _]),
  Y = [Root | _],
  atom_concat(Hundred, Root, Temp),
  atom_concat(Temp, ' ', Temp2),
  persianTen(Ten),
  atom_concat(Temp2, Ten, X).

persianThousand(X) :- % 1000
    number(Z, [thousands]),
    Z = [Thousand | _],
    atom_concat(Thousand, '', X).
