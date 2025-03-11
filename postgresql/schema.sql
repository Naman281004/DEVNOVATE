-- Initialize schemas
CREATE SCHEMA IF NOT EXISTS event_platform;
CREATE SCHEMA IF NOT EXISTS event_platform_private;

-- Enable the pgcrypto extension for password hashing
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Users table
CREATE TABLE event_platform.users (
    id SERIAL PRIMARY KEY,
    clerk_id TEXT UNIQUE NOT NULL,
    email TEXT NOT NULL UNIQUE,
    first_name TEXT NOT NULL CHECK (char_length(first_name) < 80),
    last_name TEXT CHECK (char_length(last_name) < 80),
    about TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Events table
CREATE TABLE event_platform.events (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    location TEXT,
    organizer_id INTEGER REFERENCES event_platform.users(id) ON UPDATE CASCADE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Event settings table
CREATE TABLE event_platform.event_settings (
    event_id INTEGER PRIMARY KEY REFERENCES event_platform.events(id) ON DELETE CASCADE ON UPDATE CASCADE,
    landing_page_config JSONB,
    registration_config JSONB,
    team_formation_enabled BOOLEAN DEFAULT TRUE
);

-- Participants table
CREATE TABLE event_platform.participants (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES event_platform.users(id) ON UPDATE CASCADE,
    event_id INTEGER REFERENCES event_platform.events(id) ON UPDATE CASCADE,
    registration_date TIMESTAMP DEFAULT NOW(),
    status TEXT CHECK (status IN ('registered', 'confirmed', 'attended', 'cancelled')),
    UNIQUE(user_id, event_id)
);

-- Teams table
CREATE TABLE event_platform.teams (
    id SERIAL PRIMARY KEY,
    event_id INTEGER REFERENCES event_platform.events(id) ON DELETE CASCADE ON UPDATE CASCADE,
    name TEXT NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Team members table
CREATE TABLE event_platform.team_members (
    team_id INTEGER REFERENCES event_platform.teams(id) ON DELETE CASCADE ON UPDATE CASCADE,
    participant_id INTEGER REFERENCES event_platform.participants(id) ON UPDATE CASCADE,
    joined_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (team_id, participant_id)
);

-- Projects table
CREATE TABLE event_platform.projects (
    id SERIAL PRIMARY KEY,
    team_id INTEGER REFERENCES event_platform.teams(id) ON DELETE CASCADE ON UPDATE CASCADE,
    event_id INTEGER REFERENCES event_platform.events(id) ON UPDATE CASCADE,
    title TEXT NOT NULL,
    description TEXT,
    github_url TEXT,
    demo_url TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Domain events table for audit
CREATE TABLE event_platform_private.domain_events (
    id SERIAL PRIMARY KEY,
    event_type TEXT NOT NULL,
    aggregate_id TEXT NOT NULL,
    timestamp TIMESTAMP DEFAULT NOW(),
    promoter_id INTEGER REFERENCES event_platform.users(id) ON UPDATE CASCADE,
    details JSONB
);

-- Create indexes
CREATE INDEX idx_users_email ON event_platform.users(email);
CREATE INDEX idx_users_clerk_id ON event_platform.users(clerk_id);
CREATE INDEX idx_events_date ON event_platform.events(start_date, end_date);
CREATE INDEX idx_events_organizer ON event_platform.events(organizer_id);
CREATE INDEX idx_participants_event ON event_platform.participants(event_id);
CREATE INDEX idx_participants_user ON event_platform.participants(user_id);
CREATE INDEX idx_teams_event ON event_platform.teams(event_id);
CREATE INDEX idx_projects_event ON event_platform.projects(event_id);
CREATE INDEX idx_projects_team ON event_platform.projects(team_id);
CREATE INDEX idx_domain_events_aggregate ON event_platform_private.domain_events(aggregate_id);
CREATE INDEX idx_domain_events_timestamp ON event_platform_private.domain_events(timestamp);

-- Enable Row Level Security on all tables
ALTER TABLE event_platform.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE event_platform.events ENABLE ROW LEVEL SECURITY;
ALTER TABLE event_platform.event_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE event_platform.participants ENABLE ROW LEVEL SECURITY;
ALTER TABLE event_platform.teams ENABLE ROW LEVEL SECURITY;
ALTER TABLE event_platform.team_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE event_platform.projects ENABLE ROW LEVEL SECURITY;

-- Create RLS policies for users
CREATE POLICY users_self_access ON event_platform.users
    USING (clerk_id = event_platform.requesting_user_id() OR event_platform.requesting_user_id() IS NULL);

-- Create RLS policies for events
CREATE POLICY events_organizer_all ON event_platform.events
    USING (organizer_id IN (SELECT id FROM event_platform.users WHERE clerk_id = event_platform.requesting_user_id()));

CREATE POLICY events_public_read ON event_platform.events
    FOR SELECT
    USING (true);

-- Create RLS policies for participants
CREATE POLICY participants_self_access ON event_platform.participants
    USING (user_id IN (SELECT id FROM event_platform.users WHERE clerk_id = event_platform.requesting_user_id()));

CREATE POLICY participants_organizer_access ON event_platform.participants
    USING (event_id IN (SELECT id FROM event_platform.events WHERE organizer_id IN 
           (SELECT id FROM event_platform.users WHERE clerk_id = event_platform.requesting_user_id())));

-- Create RLS policies for teams
CREATE POLICY teams_member_access ON event_platform.teams
    USING (id IN (SELECT team_id FROM event_platform.team_members WHERE participant_id IN 
           (SELECT id FROM event_platform.participants WHERE user_id IN 
            (SELECT id FROM event_platform.users WHERE clerk_id = event_platform.requesting_user_id()))));

CREATE POLICY teams_organizer_access ON event_platform.teams
    USING (event_id IN (SELECT id FROM event_platform.events WHERE organizer_id IN 
           (SELECT id FROM event_platform.users WHERE clerk_id = event_platform.requesting_user_id())));

-- Create RLS policies for projects
CREATE POLICY projects_team_access ON event_platform.projects
    USING (team_id IN (SELECT team_id FROM event_platform.team_members WHERE participant_id IN 
           (SELECT id FROM event_platform.participants WHERE user_id IN 
            (SELECT id FROM event_platform.users WHERE clerk_id = event_platform.requesting_user_id()))));

CREATE POLICY projects_organizer_access ON event_platform.projects
    USING (event_id IN (SELECT id FROM event_platform.events WHERE organizer_id IN 
           (SELECT id FROM event_platform.users WHERE clerk_id = event_platform.requesting_user_id())));

-- Grant appropriate permissions
GRANT USAGE ON SCHEMA event_platform TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA event_platform TO authenticated;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA event_platform TO authenticated;

-- Revoke direct access to private schema
REVOKE ALL ON SCHEMA event_platform_private FROM PUBLIC;
REVOKE ALL ON ALL TABLES IN SCHEMA event_platform_private FROM PUBLIC;

-- Comment on schema objects for documentation
COMMENT ON SCHEMA event_platform IS 'Public schema for event hosting platform';
COMMENT ON SCHEMA event_platform_private IS 'Private schema for sensitive data and audit logs';
COMMENT ON TABLE event_platform.users IS 'User accounts with Clerk authentication integration';