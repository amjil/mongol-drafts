-- migrate:up
CALL electric.migration_version('20240624030127');

CREATE TABLE IF NOT EXISTS drafts(
    id uuid primary key,
    workspace_id uuid  NOT NULL REFERENCES workspaces ("id") ON DELETE CASCADE,
    electric_user_id UUID NOT NULL,
    content text,
    flag boolean NOT NULL,
    "status" smallint NOT NULL,
    created_at TIMESTAMP, 
    updated_at TIMESTAMP);
    
CREATE INDEX IF NOT EXISTS drafts_user_id ON drafts(electric_user_id);

ALTER TABLE drafts ENABLE ELECTRIC;
-- migrate:down

