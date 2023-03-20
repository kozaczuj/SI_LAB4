:- dynamic xpositive/2.
:- dynamic xnegative/2.

%1. Opis obiektów (ich cech charakterystycznych)
vehicle_is(...) :-
	it_is(...) ,
	positive(...,...) ,
	negative(...,...).

%2. Opis cech charakterystycznych dla klas obiektów
it_is(dostawczak) :-
	positive(jest, do_przewożenia_towarów).
	negative(ma, udźwig_powyżej_3_i_pół_tony).
	positive(ma, wysokość_poniżej_3_metrów).

it_is(tir) :-
	positive(jest, do_przewożenia_towarów).
	positive(ma, udźwig_powyżej_3_i_pół_tony).
	positive(ma, naczepę).
	positive(ma, szoferkę).
	negative(ma, wysokość_poniżej_3_metrów).
	positive(ma, długość_powyżej_10_metrów).

it_is(terenowy) :-
	negative(jest, do_przewożenia_towarów).
	positive(ma, napęd_na_4).
	positive(spala, powyżej_10_litrów_na_100_metrów).
	positive(ma, opony_z_dużym_profilem).

it_is(sportowy) :-
	negative(jest, do_przewożenia_towarów).
	positive(jest, dwu_drzwiowy).
	positive(spala, powyżej_10_litrów_na_100_metrów).
	positive(ma, opływowy_kształt).

it_is(miejski) :-
	negative(jest, do_przewożenia_towarów).
	positive(jest, dwu_drzwiowy).
	positive(jest, krótszy_niż_4_i_pół_metra).
	negative(spala, powyżej_10_litrów_na_100_metrów).

%3. Szukanie potwierdzenia cechy obiektu w dynamicznej bazie
positive(X,Y) :- xpositive(X,Y),!.
positive(X,Y) :-
	not(xnegative(X,Y)) , ask(X,Y,yes).
	negative(X,Y) :-xnegative(X,Y),!.
	negative(X,Y) :-
	not(xpositive(X,Y)) ,
	ask(X,Y,no).
	
%4. Zadawanie pytań użytkownikowi
ask(X,Y,yes) :-
	write(X), write(' on '),write(Y), write('\n'),
	read(Reply),
	sub_string(Reply,0,1,_,'y'),!,
	remember(X,Y,yes).

ask(X,Y,no) :-
	write(X), write(' on '),write(Y), write('\n'),
	read(Reply),
	sub_string(Reply,0,1,_, 'n'),!,
	remember(X,Y,no).
	
%5. Zapamiętanie odpowiedzi w dynamicznej bazie
remember(X,Y,yes) :-
	asserta(xpositive(X,Y)).
remember(X,Y,no) :-
	asserta(xnegative(X,Y)).
	
%6. Uruchomienie programu
run :-
	vehicle_is(X),!,
	write('\nTwoim pojazdem może być: '),write(X),
	nl,nl,clear_facts.
run :-
	write('\nNie można określić'),
	write('jaki jest Twój pojazd.\n\n'),clear_facts.
	
%7. Wyczyszczenie zawartości dynamicznej bazy
clear_facts :-
	retract(xpositive(_,_)),fail.
clear_facts :-
	retract(xnegative(_,_)),fail.
clear_facts :-
	write('\n\nNaciśnij spację aby zakończyć\n').
