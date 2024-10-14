# Popis řešení

## Integritní omezení 1

Investor může nakupovat akcie v objemu, který nepřesahuje hodnotu jeho dostupných finančních prostředků (available_cash).

### Způsob řešeni 

Toto IO budu implementovat TRIGGEREM. 
Trigger bude vyvolán jako before insert do tabulky STOCK_TRANSACTION (UPDATE se neprovádí, jelikož transakci nelze měnit a pro přikoupení akcií je třeba vytvořit transakci novou).
Trigger vybere zůstatek na účtu investora, cenu jedné akcie, kterou chce investor nakoupit a z velikosti transakce určí celkový objem transakce a ověří, zda má investor dostatek prostředků pro její provedení.

## Integritní omezení 2

Investor nesmí prodat více akcií než kolik jich nakoupil.

### Způsob řešeni 

Toto IO budu implementovat PACKAGEM. PACKAGE bude obsluhovat provádění transakcí, přičemž pokud je transakce typu SELL, tak zkontroluje, zda se uživatel nesnaží prodat větší množství akcií než vlastní.


