# Popis řešení
První procedura naplní náhodnými daty tabulku INVESTOR.

Druhá procedura naplní náhodnými daty tabulku STOCK, přičemž provede kontrolu existence názvu společnosti v tabulce a pokud záznam existuje, tak nageneruje nová data pro tento řádek.

Třetí procedura naplní náhodnými daty vztahovou tabulku STOCK_TRANSACTION, přičemž rozsah klíčů stock_id a investor_id je od 1 do počtu záznamů požadovaných ke vložení. Dvojice stock_id a investor_id nemusí být unikátní. 

Procedury kontrolují zda již tabulka neobsahuje nějaké záznamy, pokud ano vypíší o tom informaci a skončí.

V adresáři examples se nachází screenshoty výstupů po spuštění těchto procedur a soubor run.sql obsahující kód pro spuštění procedur, který na začátku vypne kontrolu cizích klíčů, tak abych mohl vložit data pouze do těchto tří tabulek. Dále soubor obsahuje proměnnou c_records, která udává kolik řádek se má vložit.

## procedura 1 

- nad tabulkou: **INVESTOR**
- nazev procedury: **FILL_INVESTOR**

## procedura 2 

- nad tabulkou: **STOCK**
- nazev procedury: **FILL_STOCK**


## procedura 3 

- nad tabulkou: **STOCK_TRANSACTION**
- nazev procedury: **FILL_STOCK_TRANSACTION**


