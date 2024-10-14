DECLARE
    c_records PLS_INTEGER := 15;

BEGIN
    -- Disable foreign key control
    FOR cur IN (SELECT CONSTRAINT_NAME, TABLE_NAME
                FROM USER_CONSTRAINTS
                WHERE CONSTRAINT_TYPE = 'R')
        LOOP
            EXECUTE IMMEDIATE 'ALTER TABLE ' || cur.table_name || ' MODIFY CONSTRAINT "' || cur.constraint_name ||
                              '" DISABLE ';
        END LOOP;

    FILL_INVESTOR(c_records);
    FILL_STOCK(c_records);
    FILL_STOCK_TRANSACTION(c_records);
END;
