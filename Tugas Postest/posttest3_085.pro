 DOMAINS
  nama,memiliki = symbol
  umur = integer
  tinggi  = integer
  berat = integer
  
PREDICATES

  nondeterm wanita(symbol,integer,integer) 
  nondeterm memiliki(symbol,integer,integer)
  nondeterm berat(symbol, integer)

CLAUSES
  memiliki("Winda Astikatuti", 170,22).
  memiliki("Yuyun Safitri", 172,24).
  memiliki("Nur Arifka", 171,55).
  memiliki("Yeni putri",166,67).
  memiliki("Nadya ", 170,37).
  memiliki("Putri", 166,19).

  berat("Winda Astikatuti", 51).
  berat("Yuyun Safitri", 56).
  berat("Nur Arifka", 55).
  berat("Yeni putri", 80).
  berat("Nadya", 70).
  berat("Putri", 90).
  
  
  wanita(Nama,Tinggi,Berat):-
      memiliki(Nama,Tinggi,Umur),Tinggi>=166,
      berat(Nama,Berat),Berat<60,Umur>20,Umur<30.

GOAL
  write("Jadi cewek yang cocok di jadikan istri : "),nl,
  wanita(Nama,Tinggi,Berat).