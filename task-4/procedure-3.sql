CREATE OR REPLACE PROCEDURE FILL_STOCK_TRANSACTION(records IN PLS_INTEGER)
    AUTHID CURRENT_USER IS
    TYPE string_array IS TABLE OF VARCHAR2(10) INDEX BY PLS_INTEGER;
    c_start_date     DATE   := TO_DATE('2020-01-01', 'YYYY-MM-DD');
    c_end_date       DATE   := TO_DATE('2023-12-31', 'YYYY-MM-DD');
    v_types          string_array;
    v_type           VARCHAR2(10);
    v_random_days    NUMBER;
    v_random_date    DATE;
    v_control        PLS_INTEGER;
    v_stock_id       NUMBER;
    v_investor_id    NUMBER;
    v_transaction_id NUMBER := 1;

BEGIN
    BEGIN
        SELECT COUNT(*) INTO v_control FROM STOCK_TRANSACTION;
        IF (v_control > 0)
        THEN
            DBMS_OUTPUT.PUT_LINE('Table STOCK_TRANSACTION is not empty, ending!');
            return;
        END IF;
    END;

    v_types(1) := 'BUY';
    v_types(2) := 'SELL';
    DBMS_OUTPUT.PUT_LINE('Inserting data into STOCK_TRANSACTION.');

    FOR i IN 1..records
        LOOP
            v_stock_id := FLOOR(DBMS_RANDOM.VALUE(1, records));
            v_investor_id := FLOOR(DBMS_RANDOM.VALUE(1, records));
            v_random_days := TRUNC(DBMS_RANDOM.VALUE * (c_end_date - c_start_date + 1));
            v_random_date := c_start_date + v_random_days;
            v_type := v_types(DBMS_RANDOM.VALUE(1, v_types.COUNT));

            INSERT INTO STOCK_TRANSACTION("TRANSACTION_ID", "STOCK_ID", "INVESTOR_ID", "TYPE", "AMOUNT",
                                          "TRANSACTION_DATE")
            VALUES (v_transaction_id,
                    v_stock_id,
                    v_investor_id,
                    v_type,
                    FLOOR(DBMS_RANDOM.VALUE(1, 1000)),
                    v_random_date);

            v_transaction_id := v_transaction_id + 1;
        END LOOP;

    DBMS_OUTPUT.PUT_LINE(records || ' rows were successfully inserted into STOCK_TRANSACTION.');
END;
/

