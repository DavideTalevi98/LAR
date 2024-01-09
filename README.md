# GreenWaysAR

## Introduzione
Esplora la bellezza naturale in modo completamente nuovo con GreenWaysAR, un'app iOS sviluppata utilizzando SwiftUI e la libreria MapboxAR. Questa innovativa applicazione ti invita a immergerti in avventure aumentate, guidandoti attraverso i sentieri di un affascinante parco naturale.

### Caratteristiche Principali
- **Realtà Aumentata Immediata:** Scopri il parco naturale attraverso la lente della realtà aumentata, trasformando il tuo dispositivo iOS in una finestra interattiva su un mondo virtualmente arricchito.
- **Minimappa Intuitiva:** Utilizzando la potente libreria MapboxAR, GreenWaysAR offre una minimappa interattiva che mostra i percorsi e le attrazioni principali del parco. Naviga con facilità e sicurezza, grazie alle indicazioni chiare e alla visualizzazione intuitiva.
- **Esplorazione Virtuale:** Oltre alle informazioni essenziali sui sentieri, GreenWaysAR ti offre dettagli sui punti di interesse del parco, come ristoranti, bar, info point e WC. Un compagno digitale per arricchire la tua esperienza di esplorazione.

### Come Iniziare
1. Scarica il repository [GreenWaysAR](https://github.com/DavideTalevi98/LAR.git) e apri il progetto in Xcode (v.15.2 Beta).
2. Esegui il comando `pod install` dal terminale per installare le dipendenze.
3. Inserisci nel file `info.plist` il token Mapbox.
4. Installa l'applicazione nel tuo dispositivo iOS.
5. Apri l'app in uno spazio all'aperto e immergiti nel parco.
6. Scegli il percorso desiderato sulla minimappa e lasciati guidare dalla bellezza virtuale e reale del parco naturale.

### Tecnologie e Architettura
- **Ambiente di Sviluppo:** Xcode-beta v.15.2, iOS 17.0, Swift.
- **Architettura:** SwiftUI con Model-View-ViewModel (MVVM).
- **Gestione dello Stato:** Utilizzo di @State, @Binding, e @EnvironmentObject in SwiftUI.
- **AR e 3D:** Integrato MapboxAR con SceneKit per una visualizzazione tridimensionale del terreno e degli itinerari.

### Problematiche e Limiti
- **Deprecazione di SceneKit:** L'utilizzo di SceneKit è deprecato e non riceve più supporto ufficiale. Considerare l'adozione di alternative moderne come RealityKit.
- **Complessità della Scena:** SceneKit potrebbe mostrare rallentamenti con scene complesse o su dispositivi più datati.

### Conclusioni
GreenWaysAR rappresenta un passo avanti nell'integrazione di tecnologie avanzate per migliorare l'esperienza di esplorazione in ambienti naturali. L'applicazione è un esempio di come la tecnologia possa arricchire le esperienze in ambienti naturali, aprendo nuove possibilità per la fruizione del patrimonio naturalistico.

---
*Nota: Per ulteriori dettagli sull'implementazione e l'architettura del progetto, consultare la documentazione completa nel repository.*
