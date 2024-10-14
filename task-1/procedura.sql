create PROCEDURE GetAncestors(
    i_name IN KOPELDAV.VYDRA.JMENO%TYPE,
    i_ancestor_type IN VARCHAR2
)
IS
    i_cv KOPELDAV.VYDRA.CV%TYPE;
    i_ancestor_type_name VARCHAR2(10);
    line_delimiter VARCHAR2(30) := '--------------------------';
    
    CURSOR AncestorCursor(p_cv KOPELDAV.VYDRA.CV%TYPE, p_ancestor_type VARCHAR2) IS
        WITH Ancestors (cv, jmeno, otec, matka, pohlavi, generation) AS (
            SELECT
                v.cv, v.jmeno, v.otec, v.matka, v.pohlavi, 1 AS generation
            FROM
                vydra v
            WHERE
                v.cv = p_cv

            UNION ALL

            SELECT
                v.cv, v.jmeno, v.otec, v.matka, v.pohlavi, a.generation + 1 AS generation
            FROM
                vydra v
            JOIN
                Ancestors a ON (v.cv = a.otec OR v.cv = a.matka)
            WHERE
                (p_ancestor_type = 'male' AND v.pohlavi = 'M')
                OR (p_ancestor_type = 'female' AND v.pohlavi = 'Z')
                OR p_ancestor_type = 'both'
        )
        
        SELECT
            jmeno || '(' || generation || ')' AS line
        FROM
            Ancestors;
BEGIN
    IF i_ancestor_type NOT IN ('male', 'female', 'both') THEN
        RAISE_APPLICATION_ERROR(-20001, 'Invalid line type. Please specify either male, female, or both.');
    END IF;
    
    SELECT cv INTO i_cv FROM vydra WHERE jmeno = i_name;

    CASE i_ancestor_type
        WHEN 'male' THEN i_ancestor_type_name := 'Muzska';
        WHEN 'female' THEN i_ancestor_type_name := 'Zenska';
        ELSE i_ancestor_type_name := 'Cela';
    END CASE;

    DBMS_OUTPUT.PUT_LINE(i_ancestor_type_name|| ' rodova linie vydry '||i_name);
    DBMS_OUTPUT.PUT_LINE(line_delimiter);
    
    FOR AncestorRecord IN AncestorCursor(i_cv, i_ancestor_type) LOOP
        DBMS_OUTPUT.PUT_LINE(AncestorRecord.line);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(line_delimiter);
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        -- Handle case when no rows are found
        DBMS_OUTPUT.PUT_LINE('No data found for ' || i_name);
END;
/

