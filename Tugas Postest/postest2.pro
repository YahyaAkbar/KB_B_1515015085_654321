PREDICATES
	nondeterm aktor(symbol) 
	nondeterm adalah(symbol, symbol)
	pantas (symbol,symbol)
	karena (symbol, symbol)
	nondeterm siapa_tercocok (symbol)- nondeterm (o)

CLAUSES
	%menceritakan pencarian Aktor dalam sebuah film untuk menjadi pemeran simiskin berdasarkan karakter dari kehidupan sehari-hari aktor.
	aktor(simiskin).
	aktor(sikaya).
	aktor(sederhana).
	
	adalah(pajar,simiskin).
	adalah(andre,sikaya).
	adalah(nanang,simiskin).
	adalah(nonok,simiskin).
	adalah(mahar,sederhana).
	adalah(wibowo,simiskin).
	
	pantas(pajar,iya).
	pantas(andre,tidak).
	pantas(nanang,iya).
	pantas(nonok,iya).
	pantas(mahar,tidak).
	pantas(wibowo,iya).
	
	karena(pajar,dewasa).
	karena(andre,tua).
	karena(nanang,tua).
	karena(nonok,tua).
	karena(mahar,anak).
	karena(wibowo,tua).
	
	siapa_tercocok(Y):-
		aktor(X),
		adalah(Y,X),
		pantas(Y,iya),
		karena(Y,dewasa).
		
GOAL
      siapa_tercocok(Tercocok),
      Adalah=simiskin.		