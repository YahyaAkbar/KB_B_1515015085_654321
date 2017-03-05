DOMAINS
  judul,pengarang = symbol
  halaman        = unsigned

PREDICATES
  buku(judul, halaman)
  nondeterm ditulis_oleh(pengarang, judul)
  nondeterm buku_tebal(judul)

CLAUSES
  ditulis_oleh(pajar, "Jomblo Makbul").
  ditulis_oleh(katon, "double wow").
  ditulis_oleh(andre, "Makan Besar").

  buku("double wow", 132).
  buku("Jomlo Makbul", 379).

  buku_tebal(Judul):-
      ditulis_oleh(_, Judul),
      buku(Judul, Tebal),
      Tebal > 300.
 
goal
	ditulis_oleh(Nama, Buku).
	

% Analisis program
% untuk mencocokkan argumen Nama dan Buku dengan argumen yang ditemukan pada masing-masing klausa ditulis_oleh program akan mencari dari yang paling atas (top) hingga ke paling bawah (bottom) dari program. 
% ika ditemukan klausa yang cocok dengan goal, maka akan mengikat nilai yang ada pada klausa ke variabel bebas sehingga goal dan klausa identik, dan goal bisa dikatakan bersatu (unify) dengan klausa. 
% Nama dan Judul merupakan variabel bebas dari goal dan variabel bebas dapat diunifikasikan ke variabel manapun dari argumen (bahkan ke variabel bebas yang lain), maka pemanggil (goal) dapat diunifikasikan dengan klausa ditulis_oleh yang pertama pada program.
% program akan melakukan pencocokan, Nama diikat ke pajar, katon, andre dan Buku diikat ke "Jomblo Makbul", "double wow", "Makan Besar".
% program akan mencari semua kemungkinan solusi, maka goal juga akan diunifikasikan ke klausa ditulis_oleh yang kedua pada program.
% Ketika sebuah panggilan mengalami pencocokan yang sukses, pemanggil kembali (is said to return), dan giliran subgoal berikutnya diuji.
% Ketika suatu variabel telah diikat (bound) pada sebuah klausa, cara-cara satu-satunya untuk membebaskan ikatan tersebut adalah melalui lacakbalik (backtracking).
% Pada saat program ini dijalankan sesuai goalnya maka hasil yang dimunculkan adalah 3 solution.
% SELESAI