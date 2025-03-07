create or replace PACKAGE "MAKE_STOCK_TRANSACTION"
authid CURRENT_USER
is
    V_STOCK_ID KOPELDAV.STOCK_TRANSACTION.STOCK_ID%TYPE;
    V_INVESTOR_ID KOPELDAV.STOCK_TRANSACTION.INVESTOR_ID%TYPE;
    V_TYPE KOPELDAV.STOCK_TRANSACTION.TYPE%TYPE;
    V_AMOUNT KOPELDAV.STOCK_TRANSACTION.AMOUNT%TYPE;

    procedure MAKE_TRANSACTION(TR_STOCK_ID IN KOPELDAV.STOCK_TRANSACTION.STOCK_ID%TYPE,
        TR_INVESTOR_ID IN KOPELDAV.STOCK_TRANSACTION.INVESTOR_ID%TYPE,
        TR_TYPE IN KOPELDAV.STOCK_TRANSACTION.TYPE%TYPE,
        TR_AMOUNT IN KOPELDAV.STOCK_TRANSACTION.AMOUNT%TYPE
    );
    
end MAKE_STOCK_TRANSACTION;
/

create or replace PACKAGE BODY "MAKE_STOCK_TRANSACTION" IS
    procedure BUY is
    begin
        INSERT INTO KOPELDAV.STOCK_TRANSACTION (STOCK_ID, INVESTOR_ID, "TYPE", AMOUNT, TRANSACTION_DATE) VALUES (V_STOCK_ID, V_INVESTOR_ID, V_TYPE, V_AMOUNT, CURRENT_DATE);
    end BUY;

    procedure SELL is
        V_PRICE KOPELDAV.STOCK.PRICE%TYPE;
        V_OWNED KOPELDAV.STOCK_TRANSACTION.AMOUNT%TYPE;
    begin
        SELECT PRICE INTO V_PRICE FROM KOPELDAV.STOCK WHERE STOCK_ID = V_STOCK_ID;
        SELECT SUM(AMOUNT) INTO V_OWNED FROM KOPELDAV.STOCK_TRANSACTION WHERE STOCK_ID = V_STOCK_ID;
        if (V_AMOUNT * V_PRICE > V_OWNED * V_PRICE) then
            RAISE_APPLICATION_ERROR(-20002, 'Nemůžete prodat více akcií než vlastníte!');
        else
            INSERT INTO KOPELDAV.STOCK_TRANSACTION (STOCK_ID, INVESTOR_ID, "TYPE", AMOUNT, TRANSACTION_DATE) VALUES (V_STOCK_ID, V_INVESTOR_ID, V_TYPE, V_AMOUNT, CURRENT_DATE);
        end if;
    end SELL;

    procedure MAKE_TRANSACTION(
        TR_STOCK_ID IN KOPELDAV.STOCK_TRANSACTION.STOCK_ID%TYPE,
        TR_INVESTOR_ID IN KOPELDAV.STOCK_TRANSACTION.INVESTOR_ID%TYPE,
        TR_TYPE IN KOPELDAV.STOCK_TRANSACTION.TYPE%TYPE,
        TR_AMOUNT IN KOPELDAV.STOCK_TRANSACTION.AMOUNT%TYPE
    ) is
    begin
        V_STOCK_ID := TR_STOCK_ID;
        V_INVESTOR_ID := TR_INVESTOR_ID;
        V_TYPE := TR_TYPE;
        V_AMOUNT := TR_AMOUNT;

        case V_TYPE
            when 'SELL' then
                SELL;
            when 'BUY' then
                BUY;
                RETURN;
            else
                RAISE_APPLICATION_ERROR(-20003, 'Neplatná operace!');
        end case;
    end MAKE_TRANSACTION;
end MAKE_STOCK_TRANSACTION;
/



