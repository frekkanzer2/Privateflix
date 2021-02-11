Privateflix

Simulazione dell'applicativo Netflix realizzato con Flutter
Codice open source utilizzabile per creare app **personali** non a scopo di lucro.
L'app realizzabile risulta essere un media client per contenuti video hostati su piattaforme online.
Attenzione: non mi ritengo responsabile circa l'uso illecito dell'app legato alla pirateria.

INFORMAZIONI CIRCA L'UTILIZZO DEL CODICE OPEN SOURCE
1. È possibile creare app personali, quindi che non siano a scopo di lucro;
2. È obbligatorio non rimuovere i crediti dalla home, i quali devono rimanere visibili nella stessa identica posizione in riferimento al codice originario.

SETUP
L'applicativo fa uso di un database no-sql contenente metadati riguardanti i video da mostrare.
La struttura del database è reperibile all'indirizzo lib/Utils/db.json
È possibile modificare la struttura del database, ma con conseguente riadattamento del codice: il codice dell'app dipende fortemente dalla struttura del database, quindi c'è alto accoppiamento (purtroppo).
È necessario, quindi, creare un database no-sql e caricarne la relativa struttura con dati eventualmente inseriti.
Una volta fatto ciò, è necessario inserire l'indirizzo del database a cui fare le richieste REST in NetworkingController.databaseAddress

INFORMAZIONI SULL'OGGETTO VIDEO
Ogni video (bean) comprende quattro caratteristiche: il titolo, il link in cui è possibile vederlo, un'immagine di copertina e un'immagine visionabile nei dettagli del video.
Ovviamente è possibile modificare il bean in modo tale che rientrino maggiori informazioni per ogni video.
