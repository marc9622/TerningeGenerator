byte kast;

IntList kastListe = new IntList();

String kastListeString;

int[] soejleHoejder = new int[6];

void setup() {
  size(1280, 720);
  surface.setResizable(true);
  noStroke();
  clear();
  skrivTekst();
}

void draw() {}

//Bliver kaldt, naar der trykkes paa en knap. Derefter findes den trykkede knap og relevante funktioner kaldes.
void keyPressed() {
  
  if (key == 'k') {
    clear();
    kast();
  }
  
  else if (key == 's' && kastListe.size() > 0) {
    clear();
    fjernKast();
  }
  
  else {
    return;
  }
  
  skrivTekst();
 
  udskrivKast();
  
  tegnFordeling();
}

//Laver et nyt kast og tilfoejer vaerdien til relevante lister.
void kast() {
  kast = lavTerningeKast(1, 6);
  haevSoejleHoejde(kast); 
  tilfoejKastTilListen(kast);
}

//Fjerner det sidste kast fra relevante lister.
void fjernKast() {
  saenkSoejleHoejde();
  fjernSidsteKastFraListen();
}

//Retunere et tilfaeldigt nummer fra min til max
byte lavTerningeKast(int min, int max) {
  return byte(random(min, max + 1));
}

//Haever hoejden paa soejlen med det tilsvarende nummer.
void haevSoejleHoejde(byte soejleNr) {
  soejleHoejder[soejleNr - 1] ++;
}

//Tilfoejer det nye nummer til kastlisten.
void tilfoejKastTilListen(byte nytNr) {
  kastListe.append(nytNr);
}

//Saenker hoejden paa soejlen med det nyeste nummer fra kastlisten.
void saenkSoejleHoejde() {
  soejleHoejder[kastListe.get(kastListe.size() - 1) - 1] --;
}

//Fjerne det sidste nummer fra kastlisten.
void fjernSidsteKastFraListen() {
  kastListe.remove(kastListe.size() - 1);
}

//Skriver guideteksten.
void skrivTekst() {
  text("TRYK Paa 'k' FOR AT KASTE / OG 's' FOR AT SLETTE", 50, 50);
  text("DIT KAST BLEV: " + kast, 50, 75);
}

//Skriver listen af kast.
void udskrivKast() {    
  laverKastTekstListe();  
  text(kastListeString, width - 150, 50);
}

//Laver stringen til kaste-tekstlisten.
void laverKastTekstListe() {
  //Resetter stringen og skriver antal kast.
  kastListeString = "Antal kast: " + kastListe.size();
  
  //For hvert kast tilføjes en kort tekst om kastet til tekstlisten.
  for(int i = 0; i < min(kastListe.size(), height / 15f); i++)
    if(kastListe.get(i) != 0)
      kastListeString += "\n" + "Kast nr. " + i + " blev: " + kastListe.get(i);
}

//Tegner soejlediagrammet.
void tegnFordeling() {
  for (int i = 0; i < 6; i++) {
    rect((width - 150) / 6 * i + 10, height - 25, (width - 200) / 6 - 10, (-soejleHoejder[i] * (height - 200)) / max(max(soejleHoejder), 1));
  }
  tegnFordelingTekst();
}

//Tegner forklarende tal under søjlerne
void tegnFordelingTekst() {
  for (int i = 0; i < 6; i++) {
    text("Antal " + (i) + "'ere: " + soejleHoejder[i], (width - 150) / 6 * i + 10, height - 10);
  }
}
