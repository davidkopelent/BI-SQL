create trigger STOCK_TRANSACTION_CHECKER
    before insert
    on STOCK_TRANSACTION
    for each row
DECLARE
    v_cash KOPELDAV.INVESTOR.AVAILABLE_CASH%TYPE;
    v_stock_price KOPELDAV.STOCK.PRICE%TYPE;
    v_total_price KOPELDAV.STOCK.PRICE%TYPE;
    v_amount KOPELDAV.STOCK_TRANSACTION.AMOUNT%TYPE := :NEW.AMOUNT;
    v_investor_id KOPELDAV.STOCK_TRANSACTION.INVESTOR_ID%TYPE := :NEW.INVESTOR_ID;
    v_stock_id KOPELDAV.STOCK_TRANSACTION.STOCK_ID%TYPE := :NEW.STOCK_ID;
BEGIN
    SELECT AVAILABLE_CASH INTO v_cash
    FROM KOPELDAV.INVESTOR
    WHERE INVESTOR_ID = v_investor_id;

    SELECT PRICE INTO v_stock_price
    FROM KOPELDAV.STOCK
    WHERE STOCK_ID = v_stock_id;

    v_total_price := v_stock_price * v_amount;

    IF v_cash < v_total_price THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nemáte dostatek finančních prostředků pro provedení transakce. Velikost transakce činí ' || v_total_price ||
                                        ' a Váš zůstatek činí ' || v_cash);
    END IF;
END;
/
