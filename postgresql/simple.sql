-- Initialize schema
CREATE SCHEMA IF NOT EXISTS event_platform_simple;

-- Users table
CREATE TABLE event_platform_simple.users (
    id SERIAL PRIMARY KEY,
    email TEXT NOT NULL UNIQUE,
    first_name TEXT NOT NULL CHECK (char_length(first_name) < 80),
    last_name TEXT CHECK (char_length(last_name) < 80),
    about TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Events table
CREATE TABLE event_platform_simple.events (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    location TEXT,
    organizer_id INTEGER REFERENCES event_platform_simple.users(id) ON UPDATE CASCADE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Event settings table
CREATE TABLE event_platform_simple.event_settings (
    event_id INTEGER PRIMARY KEY REFERENCES event_platform_simple.events(id) ON DELETE CASCADE ON UPDATE CASCADE,
    landing_page_config JSONB,
    registration_config JSONB,
    team_formation_enabled BOOLEAN DEFAULT TRUE
);

-- Participants table
CREATE TABLE event_platform_simple.participants (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES event_platform_simple.users(id) ON UPDATE CASCADE,
    event_id INTEGER REFERENCES event_platform_simple.events(id) ON UPDATE CASCADE,
    registration_date TIMESTAMP DEFAULT NOW(),
    status TEXT CHECK (status IN ('registered', 'confirmed', 'attended', 'cancelled')),
    UNIQUE(user_id, event_id)
);

-- Teams table
CREATE TABLE event_platform_simple.teams (
    id SERIAL PRIMARY KEY,
    event_id INTEGER REFERENCES event_platform_simple.events(id) ON DELETE CASCADE ON UPDATE CASCADE,
    name TEXT NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Team members table
CREATE TABLE event_platform_simple.team_members (
    team_id INTEGER REFERENCES event_platform_simple.teams(id) ON DELETE CASCADE ON UPDATE CASCADE,
    participant_id INTEGER REFERENCES event_platform_simple.participants(id) ON UPDATE CASCADE,
    joined_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (team_id, participant_id)
);

-- Projects table
CREATE TABLE event_platform_simple.projects (
    id SERIAL PRIMARY KEY,
    team_id INTEGER REFERENCES event_platform_simple.teams(id) ON DELETE CASCADE ON UPDATE CASCADE,
    event_id INTEGER REFERENCES event_platform_simple.events(id) ON UPDATE CASCADE,
    title TEXT NOT NULL,
    description TEXT,
    github_url TEXT,
    demo_url TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Create indexes
CREATE INDEX idx_simple_users_email ON event_platform_simple.users(email);
CREATE INDEX idx_simple_events_date ON event_platform_simple.events(start_date, end_date);
CREATE INDEX idx_simple_events_organizer ON event_platform_simple.events(organizer_id);
CREATE INDEX idx_simple_participants_event ON event_platform_simple.participants(event_id);
CREATE INDEX idx_simple_participants_user ON event_platform_simple.participants(user_id);
CREATE INDEX idx_simple_teams_event ON event_platform_simple.teams(event_id);
CREATE INDEX idx_simple_projects_event ON event_platform_simple.projects(event_id);
CREATE INDEX idx_simple_projects_team ON event_platform_simple.projects(team_id);

-- Comment on schema objects for documentation
COMMENT ON SCHEMA event_platform_simple IS 'Simplified schema for event hosting platform without security features';
