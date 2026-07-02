-- *************************************************
-- PARTE 3: TRIGGER EL REGISTRO ESTA CERRADO
-- *************************************************

SET search_path TO titanic;

CREATE OR REPLACE FUNCTION fn_limite_pasajeros()
RETURNS TRIGGER AS $$
DECLARE
    cantidad_actual INT;
BEGIN
    SELECT COUNT(*) INTO cantidad_actual FROM pasajero;
    IF cantidad_actual >= 1309 THEN
        RAISE EXCEPTION 'No puedes registrar mas pasajeros. El titanic salio hace años';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_limite_pasajeros ON pasajero;

CREATE TRIGGER trg_limite_pasajeros
BEFORE INSERT ON pasajero
FOR EACH ROW
EXECUTE FUNCTION fn_limite_pasajeros();

INSERT INTO schema_migrations (version) VALUES ('004_trigger_registro_cerrado');