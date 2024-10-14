CREATE OR REPLACE PROCEDURE FILL_STOCK(records IN PLS_INTEGER)
    AUTHID CURRENT_USER IS
    v_stock    VARCHAR2(100);
    v_symbol   VARCHAR2(255);
    v_control  PLS_INTEGER;
    v_records  PLS_INTEGER;
    v_stock_id NUMBER := 1;

BEGIN
    BEGIN
        SELECT COUNT(*) INTO v_control FROM STOCK;
        IF (v_control > 0)
        THEN
            DBMS_OUTPUT.PUT_LINE('Table STOCK is not empty, ending!');
            return;
        END IF;
    END;

    v_records := records;
    DBMS_OUTPUT.PUT_LINE('Inserting data into STOCK.');

    WHILE v_records > 0
        LOOP
            v_symbol := '';
            v_stock := 'Company ' || CEIL(DBMS_RANDOM.VALUE(1, 100));

            -- Generate 4 characters long symbol for new company stock
            FOR j IN 1..4
                LOOP
                    v_symbol := v_symbol || CHR(FLOOR(DBMS_RANDOM.VALUE(65, 90)));
                END LOOP;

            -- Check if company name already exists in table
            SELECT COUNT(*) INTO v_control FROM STOCK WHERE "NAME" = v_stock;

            -- Company name is unique, insert it
            IF (v_control = 0) THEN
                INSERT INTO STOCK("STOCK_ID", "SEGMENT_ID", "NAME", "SYMBOL", "PRICE", "VOLUME")
                VALUES (v_stock_id,
                        FLOOR(DBMS_RANDOM.VALUE(1, 10)),
                        v_stock,
                        v_symbol,
                        FLOOR(DBMS_RANDOM.VALUE(1, 1000)),
                        FLOOR(DBMS_RANDOM.VALUE(0, 1000000)));

                v_records := v_records - 1;
                v_stock_id := v_stock_id + 1;
            END IF;
        END LOOP;

    DBMS_OUTPUT.PUT_LINE(records || ' rows were successfully inserted into STOCK.');
END;
/


