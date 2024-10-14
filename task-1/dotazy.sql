-- Dotaz 10, muzska
WITH Ancestors (cv, jmeno, otec, matka, pohlavi, generation) AS (
    SELECT
        v.cv, v.jmeno, v.otec, v.matka, v.pohlavi, 1 AS generation
    FROM
        vydra v
    WHERE
        v.cv = 10

    UNION ALL

    SELECT
        v.cv, v.jmeno, v.otec, v.matka, v.pohlavi, a.generation + 1 AS generation
    FROM
        vydra v
    JOIN
        Ancestors a ON (v.cv = a.otec OR v.cv = a.matka)
    WHERE
        v.pohlavi = 'M'
)

SELECT
    jmeno || '(' || generation || ')' AS line
FROM
    Ancestors;

-- Dotaz 10, zenska
WITH Ancestors (cv, jmeno, otec, matka, pohlavi, generation) AS (
    SELECT
        v.cv, v.jmeno, v.otec, v.matka, v.pohlavi, 1 AS generation
    FROM
        vydra v
    WHERE
        v.cv = 10

    UNION ALL

    SELECT
        v.cv, v.jmeno, v.otec, v.matka, v.pohlavi, a.generation + 1 AS generation
    FROM
        vydra v
    JOIN
        Ancestors a ON (v.cv = a.otec OR v.cv = a.matka)
    WHERE
        v.pohlavi = 'Z'
)

SELECT
    jmeno || '(' || generation || ')' AS line
FROM
    Ancestors;

-- Dotaz 10, oboje
WITH Ancestors (cv, jmeno, otec, matka, pohlavi, generation) AS (
    SELECT
        v.cv, v.jmeno, v.otec, v.matka, v.pohlavi, 1 AS generation
    FROM
        vydra v
    WHERE
        v.cv = 10

    UNION ALL

    SELECT
        v.cv, v.jmeno, v.otec, v.matka, v.pohlavi, a.generation + 1 AS generation
    FROM
        vydra v
    JOIN
        Ancestors a ON (v.cv = a.otec OR v.cv = a.matka)
)

SELECT
    jmeno || '(' || generation || ')' AS line
FROM
    Ancestors;
