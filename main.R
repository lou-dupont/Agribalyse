options(java.parameters = "-Xmx8G")

library(xlsx)

wb = createWorkbook()

filenames = list.files("./", pattern="*.csv", full.names=FALSE)
for (filename in filenames) {
  cat('Chargement de', filename, '\n')
  df = read.csv(filename, encoding='UTF-8')
  if (filename == 'TBL_EXCHANGES.csv') {
    # 3.5 millions de lignes, cela dépasse la limite Excel. 
    # On ne conserve que les lignes avec une quantité non nulle
    df = df[df$RESULTING_AMOUNT_VALUE != 0, ]
    # On écrit le fichier dans un CSV à copier à la main dans Excel 
    # (pour contourner la limite de mémoire de rJava / xlsx)
    write.csv2(df, paste0('EXCEL_', filename), row.names=FALSE, na='')
  }
  # Ne charge ni _SEQUENCE_ ni OPENCLA_VERSION qui ne sont pas utiles
  if (nrow(df) > 1) {
    cat('Ecriture dans le fichier\n')
    name = gsub('(TBL_|.csv)', '', filename)
    # On écrit directement chaque onglet, saufe TBL_EXCHANGES qui est ajouté à la main
    if (nrow(df) <= 100000) {
      sheet = createSheet(wb, name)
      addDataFrame(df, sheet=sheet, row.names=FALSE, showNA=FALSE)
    }
  }
}

# Certaines cases sont tronquées à 32767 caractères. C'est la vie avec Excel.
saveWorkbook(wb, "Agribalyse-3.0.xlsx")

# Penser à ajouter à la main TBL_EXCHANGES
