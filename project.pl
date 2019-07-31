:- ['numbers.pl'].

% This is the main predicate that will return all of the possible persian
% numbers that this program can create. The order of the numbers is not in
% the exact order of 0-1000, mainly because in the way that some numbers have
% commonalities, ie 4,14,400, and the order in which double/triple digit
% numbers are created. ie for triple digit numbers, first numbers containing
% teens are created before numbers containing twenties, etc.
persian(X) :-
  persianOne(X);
  persianTeen(X);
  persianTen(X);
  persianHundred(X);
  persianThousand(X).

% All predicates following are created for supporting the
% main predicate and ones larger than them, but they can still be individually
% queried to test subsets of numbers rather than the whole.

% This predicate generates numbers 0-9, making it the simplest one.
% It simply grabs a number that is zero or has the 'ones' identifier and
% concats it with X.
persianOne(X) :-
  number(Z, [zero]),
  Z = [Zero | _],
  atom_concat(Zero, '', X);
  number(Z, Y),
  member(ones, Y),
  Z = [Ones | _],
  atom_concat(Ones, '', X).

% This predicate generates numbers 10-19 by taking numbers with the
% 'teen' identifier, concats it with the 'teenroot', ie 'dah' which
% is the same as ten.
persianTeen(X) :-
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

% This predicate generates numbers 20-99. First, it generates the base
% numbers, ie 20,30,40,50 etc. Then, it generates compound numbers using
% the base and all possible ones place numbers, excluding zero, by placing
% the connector "o" between the tens and the ones place numbers.
persianTen(X) :-
  number(Z, [tens]), % 20,30,40 etc
  Z = [DoubleDigit | _],
  atom_concat(DoubleDigit, '', X);
  number(Z, [tens]), % 21,22,23...,31,32,33... etc
  Z = [DoubleDigit | _],
  connector(Con),
  atom_concat(DoubleDigit, ' ', Temp),
  atom_concat(Temp, Con, Temp2),
  atom_concat(Temp2, ' ', Temp3),
  persianOne(One),
  not(One = sefr),
  atom_concat(Temp3, One, X).

% This predicate is the most complex, because numbers in the hundreds
% are the most complex in persian. Firstly, 100 and 200 do not follow the
% pattern of hundred + hundredroot, and I identified them as "rootless."
% Then, similar with persianTen, it generates the "base" numbers.
% Ie, 100 and 200, then those bases with ones place, then with a teen,
% then with a tens. Next, it generates the "base" numbers for those that
% follow the hundred + hundredroot patter, ie 300,400,500 etc. It then follows
% the same way it did for 100 and 200. There is no "o" connector required
% between the hundreds place and tens place numbers.
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

% Because the scope for this model is numbers 0-1000 because of the fact
% that beyond 1000, it becomes repetitive, this predicate needs only return
% the Persian version of '1000.' For the record, if I were to include numbers
% beyond 1000, it would follow a similar pattern as the hundreds, where the
% hundreds place number is placed next to the thousands place number with no
% needed connector, as it is reserved only for tens place numbers.
persianThousand(X) :- % 1000
    number(Z, [thousands]),
    Z = [Thousand | _],
    atom_concat(Thousand, '', X).
