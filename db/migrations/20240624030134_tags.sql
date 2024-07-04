-- migrate:up
CALL electric.migration_version('20240624030134');

CREATE TABLE IF NOT EXISTS tags(
    id uuid primary key,
    workspace_id uuid  NOT NULL REFERENCES workspaces ("id") ON DELETE CASCADE,
    electric_user_id UUID NOT NULL,
    name text,
    related_num int);
    
CREATE TABLE IF NOT EXISTS draft_tags(
    id uuid primary key,
    electric_user_id UUID NOT NULL,
    tag_id uuid NOT NULL REFERENCES tags("id") ON DELETE CASCADE,
    draft_id uuid NOT NULL REFERENCES drafts("id") ON DELETE CASCADE);
    
CREATE INDEX IF NOT EXISTS tags_user_id ON tags(electric_user_id);
CREATE INDEX IF NOT EXISTS draft_tags_user_id ON draft_tags(electric_user_id);

ALTER TABLE tags ENABLE ELECTRIC;
ALTER TABLE draft_tags ENABLE ELECTRIC;
-- migrate:down

