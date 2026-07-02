-- **************************************************************
-- PRIMERA PARTE: MIGRACION: MARCAR es_tripulacion
-- **************************************************************

SET search_path TO titanic;

ALTER TABLE pasajero 
ADD COLUMN IF NOT EXISTS es_tripulacion BOOLEAN NOT NULL DEFAULT FALSE;

INSERT INTO schema_migrations (version) VALUES ('002_marcar_tripulacion');