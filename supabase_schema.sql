CREATE TABLE grades (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    subject TEXT NOT NULL,
    grade TEXT NOT NULL,
    score INTEGER NOT NULL
);

INSERT INTO grades (subject, grade, score) VALUES
('Data Structures & Algorithms', 'A+', 90),
('Object-Oriented Programming (C++/Java)', 'D', 57),
('Database Management Systems (DBMS)', 'C', 64),
('Operating Systems', 'B', 79),
('Computer Networks', 'D', 57);

ALTER TABLE grades ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read access" ON grades FOR SELECT USING (true);
CREATE POLICY "Allow public update access" ON grades FOR UPDATE USING (true) WITH CHECK (true);

CREATE OR REPLACE FUNCTION get_student_grades()
RETURNS json AS $$
BEGIN
    RETURN (
        SELECT json_agg(t)
        FROM (
            SELECT id, subject, grade, score 
            FROM grades 
            ORDER BY id ASC
        ) t
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_student_grades(items json)
RETURNS void AS $$
DECLARE
    item json;
BEGIN
    FOR item IN SELECT * FROM json_array_elements(items) LOOP
        UPDATE grades 
        SET score = (item->>'score')::integer,
            grade = item->>'grade'
        where id = (item->>'id')::integer;
    END LOOP;
END;
$$ LANGUAGE plpgsql;
