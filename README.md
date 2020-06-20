# Agribalyse

Données de référence sur les impacts environnementaux des produits agricoles et alimentaires

## Usage

Ce code **R** permet de créer un fichier Excel à partir des tables CSV de la base Agribalyse selon le schéma OpenLCA. Avoir un fichier Excel permet à plus de personnes de creuser dans les données. Malheureusement, à cause des limites d'Excel :
* les cellules étant limitées à 32 767 caractères, certains longs textes embarqués dans la table `PROCESSES` ont été tronqués,
* les onglet étant limités à 1 048 576 lignes, l'onget `EXCHANGES`, qui aurait dû en contenir plus de 3 millions, a dû être filtré ; nous avons fait le choix de ne conserver que les lignes ayant une quantité d'échange non nulle (environ un quart).
