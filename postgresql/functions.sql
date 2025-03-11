-- Create function to extract Clerk user ID from JWT
CREATE OR REPLACE FUNCTION event_platform.requesting_user_id()
RETURNS TEXT AS $$
BEGIN
  -- Extract the user ID from the Clerk JWT token
  -- This assumes the JWT has a 'sub' claim with the user ID
  RETURN current_setting('request.jwt.claims', true)::json->>'sub';
EXCEPTION
  WHEN OTHERS THEN
    RETURN NULL;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

COMMENT ON FUNCTION event_platform.requesting_user_id() IS 'Function to extract Clerk user ID from JWT token';

-- Create trigger function to update timestamps
CREATE OR REPLACE FUNCTION event_platform.update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers for timestamp updates
CREATE TRIGGER update_users_timestamp
BEFORE UPDATE ON event_platform.users
FOR EACH ROW EXECUTE FUNCTION event_platform.update_timestamp();

CREATE TRIGGER update_events_timestamp
BEFORE UPDATE ON event_platform.events
FOR EACH ROW EXECUTE FUNCTION event_platform.update_timestamp();

CREATE TRIGGER update_projects_timestamp
BEFORE UPDATE ON event_platform.projects
FOR EACH ROW EXECUTE FUNCTION event_platform.update_timestamp();

-- Create function to handle new Clerk users
CREATE OR REPLACE FUNCTION event_platform.handle_new_clerk_user()
RETURNS TRIGGER AS $$
BEGIN
    -- Insert a new user record when a Clerk user is created
    INSERT INTO event_platform.users (clerk_id, email, first_name, last_name)
    VALUES (NEW.clerk_id, NEW.email, NEW.first_name, NEW.last_name);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a view for user profiles
CREATE VIEW event_platform.user_profiles AS
SELECT 
    u.id,
    u.clerk_id,
    u.email,
    u.first_name,
    u.last_name,
    u.about,
    COUNT(DISTINCT p.id) AS events_participated,
    COUNT(DISTINCT t.id) AS teams_joined,
    COUNT(DISTINCT pr.id) AS projects_submitted
FROM 
    event_platform.users u
LEFT JOIN 
    event_platform.participants p ON u.id = p.user_id
LEFT JOIN 
    event_platform.team_members tm ON p.id = tm.participant_id
LEFT JOIN 
    event_platform.teams t ON tm.team_id = t.id
LEFT JOIN 
    event_platform.projects pr ON t.id = pr.team_id
GROUP BY 
    u.id;

-- Create a view for event statistics
CREATE VIEW event_platform.event_statistics AS
SELECT 
    e.id,
    e.title,
    COUNT(DISTINCT p.id) AS participant_count,
    COUNT(DISTINCT t.id) AS team_count,
    COUNT(DISTINCT pr.id) AS project_count
FROM 
    event_platform.events e
LEFT JOIN 
    event_platform.participants p ON e.id = p.event_id
LEFT JOIN 
    event_platform.teams t ON e.id = t.event_id
LEFT JOIN 
    event_platform.projects pr ON t.id = pr.team_id
GROUP BY 
    e.id;