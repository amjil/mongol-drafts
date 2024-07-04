-- migrate:up
CALL electric.migration_version('20240624030117');

CREATE TABLE IF NOT EXISTS workspaces(
    id uuid primary key,
    electric_user_id UUID NOT NULL,
    name text);
    
CREATE INDEX IF NOT EXISTS workspaces_user_id ON workspaces(electric_user_id);

ALTER TABLE workspaces ENABLE ELECTRIC;
-- migrate:down

