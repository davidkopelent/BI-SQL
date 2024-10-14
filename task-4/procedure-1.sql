CREATE OR REPLACE PROCEDURE FILL_INVESTOR(records IN PLS_INTEGER)
    AUTHID CURRENT_USER IS
    TYPE string_array IS TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER;
    v_firstnames  string_array;
    v_firstname   VARCHAR2(100);
    v_lastnames   string_array;
    v_lastname    VARCHAR2(100);
    v_id_card     VARCHAR2(255);
    v_passport    VARCHAR2(255);
    v_control     PLS_INTEGER;
    v_investor_id NUMBER := 1;

BEGIN
    BEGIN
        SELECT COUNT(*) INTO v_control FROM INVESTOR;
        IF (v_control > 0)
        THEN
            DBMS_OUTPUT.PUT_LINE('Table INVESTOR is not empty, ending!');
            return;
        END IF;
    END;

    v_firstnames(1) := 'David';
    v_firstnames(2) := 'Michael';
    v_firstnames(3) := 'Peter';
    v_firstnames(4) := 'Anna';
    v_firstnames(5) := 'Veronica';

    v_lastnames(1) := 'Smith';
    v_lastnames(2) := 'Jones';
    v_lastnames(3) := 'Cooper';
    v_lastnames(4) := 'Johnson';
    v_lastnames(5) := 'Peterson';

    DBMS_OUTPUT.PUT_LINE('Inserting data into INVESTOR.');
    FOR i IN 1..records
        LOOP
            v_id_card := '';
            v_passport := '';
            v_firstname := v_firstnames(DBMS_RANDOM.VALUE(1, v_firstnames.COUNT));
            v_lastname := v_lastnames(DBMS_RANDOM.VALUE(1, v_lastnames.COUNT));

            -- Generate random id card and passport
            FOR j IN 1..10
                LOOP
                    v_id_card := v_id_card || CHR(FLOOR(DBMS_RANDOM.VALUE(65, 90)));
                    v_passport := v_passport || CHR(FLOOR(DBMS_RANDOM.VALUE(65, 90)));
                END LOOP;


            INSERT INTO INVESTOR("INVESTOR_ID", "ADDRESS_ID", "FIRSTNAME", "LASTNAME", "AVAILABLE_CASH", "ID_CARD",
                                 "PASSPORT")
            VALUES (v_investor_id,
                    FLOOR(DBMS_RANDOM.VALUE(1, 100)),
                    v_firstname,
                    v_lastname,
                    FLOOR(DBMS_RANDOM.VALUE(0, 1000000)),
                    v_id_card,
                    v_passport);

            v_investor_id := v_investor_id + 1;
        END LOOP;

    DBMS_OUTPUT.PUT_LINE(records || ' rows were successfully inserted into INVESTOR.');
END;
