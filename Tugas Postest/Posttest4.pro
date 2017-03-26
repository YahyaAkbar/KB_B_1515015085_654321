/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  
 FileName: CH04E12.PRO
 Purpose: 
 Written by: PDC
 Modifyed by: Eugene Akimov
 Comments: 
******************************************************************************/

trace
domains
  name,sex,occupation,object,vice,substance = symbol
  age=integer

predicates
  person(name,age,sex,occupation) - nondeterm (o,o,o,o), nondeterm (i,o,o,i), nondeterm (i,o,i,o)
  had_affair(name,name) - nondeterm (i,i), nondeterm (i,o)
  killed_with(name,object) - determ (i,o)
  killed(name) - procedure (o)
  killer(name) - nondeterm (o)
  motive(vice) - nondeterm (i)
  smeared_in(name,substance) - nondeterm (i,o), nondeterm (i,i)
  owns(name,object) - nondeterm (i,i)
  operates_identically(object,object) - nondeterm (o,i)
  owns_probably(name,object) - nondeterm (i,i)
  suspect(name) - nondeterm (i)

/* * * Facts about the murder * * */
clauses
  person(bert,55,m,carpenter).
  person(allan,25,m,football_player).
  person(allan,25,m,butcher).
  person(john,25,m,pickpocket).

  had_affair(barbara,john).
  had_affair(barbara,bert).
  had_affair(susan,john).

  killed_with(susan,club).
  killed(susan).

  motive(money).
  motive(jealousy).
  motive(righteousness).

  smeared_in(bert,blood).
  smeared_in(susan,blood).
  smeared_in(allan,mud).
  smeared_in(john,chocolate).
  smeared_in(barbara,chocolate).

  owns(bert,wooden_leg).
  owns(john,pistol).

/* * * Background knowledge * * */

  operates_identically(wooden_leg, club).
  operates_identically(bar, club).
  operates_identically(pair_of_scissors, knife).
  operates_identically(football_boot, club).

  owns_probably(X,football_boot):-
	person(X,_,_,football_player).
  owns_probably(X,pair_of_scissors):-
	person(X,_,_,hairdresser).
  owns_probably(X,Object):-
	owns(X,Object).

/* * * * * * * * * * * * * * * * * * * * * * *
 * Suspect all those who own a weapon with   *
 * which Susan could have been killed.       *
 * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-
	killed_with(susan,Weapon) ,
	operates_identically(Object,Weapon) ,
	owns_probably(X,Object).

/* * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect men who have had an affair with Susan.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-
	motive(jealousy),
	person(X,_,m,_),
	had_affair(susan,X).

/* * * * * * * * * * * * * * * * * * * * *
 * Suspect females who have had an       *
 * affair with someone that Susan knew.  *
 * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-
	motive(jealousy),
	person(X,_,f,_),
	had_affair(X,Man),
	had_affair(susan,Man).

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect pickpockets whose motive could be money.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-
	motive(money),
	person(X,_,_,pickpocket).

  killer(Killer):-
	person(Killer,_,_,_), %ini sebagai sub goal kepertama
	killed(Killed), %ini sebagai sub goal kedua
	Killed <> Killer, 
	suspect(Killer), %ini sebagai sub goal ketiga
	smeared_in(Killer,Goo),
	smeared_in(Killed,Goo).

goal
  killer(X).
                         %%------ANALISIS------%%
/*
1.)  Tujuan dari program diatas adalah mencari/melacak data yang cocok yang sesuai goal yang dicari.
2.)  sesuai dengan goal yang dicari "killer(x)," maka yang pertama di telusuri program ialah melacak.
3.)  setelah itu program akan memanggil sub goal pertama yaitu "person(Killer,_,_,_)," disini terdapapat ("_") yang berada di argumen "age,sex,occupation".
4.)  selanjutnya program akan mencari kecoccokan dengan sub goal kedua yaitu "Killed(Killed),".
     hasil dari pelacakan itu ditemukan bahwa yang terbunuh adalah susan "Killed(susan),".
6.)  selanjutnya program akan mencari  lewat sub berikutnya yaitu "suspect(Killer)," darii sub ini maka akan dipanggil  suspect(X),
     dari sini prolog akan menganalisis sub selanjutnya yaitu killed_with(susan,Weapon), dari sini ditemukanlah bahwasannya susan terbunuh dengan club atau pentungan.
7.)  selanjutnya ditemukan wooden_leg, bar, dan football_boot adalah alat yang bisa dijadikan club atau pentungan.
8.)  di sub selanjutnya owns_probably(X,Object) disini  ditemukan bahwa wooden_leg adalah milikk bert, dan dari sini bert dicurigai.
9.)  dari fakta-fakta yang dicurigai diatas selanjutnya prolog akan nenyusuri sub berikutnya smeared_in(Killer,Goo), dari sini ditemukaan bert terrnodai darah.
10.) sub selanjutnta smeared_in(Killer,Goo), juga sama bahwa susan juga tenodai darah 
11.) dan ditemukanlah bahwa bert adalah pembunuhnya.

                          %%------SELESAI-----%%
*/