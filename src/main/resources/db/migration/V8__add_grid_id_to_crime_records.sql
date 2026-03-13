ALTER TABLE crime_records
    ADD COLUMN grid_id BIGINT;

UPDATE crime_records
SET grid_id =
        hashtext(
                ST_AsText(
                        ST_SnapToGrid(location, 0.01)
                )
        )::bigint
WHERE location IS NOT NULL
  AND grid_id IS NULL;

CREATE INDEX idx_crime_records_grid_id
    ON crime_records (grid_id);
