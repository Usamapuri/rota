-- Railway Database Setup Script for Rota Management Software
-- Run this in Railway's MySQL database interface

-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS railway;
USE railway;

-- Create tables for Rota Management Software
-- This is a simplified version of the schema

-- Users table
CREATE TABLE IF NOT EXISTS cr_users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    isAdmin BOOLEAN DEFAULT FALSE,
    isActive BOOLEAN DEFAULT TRUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Sites table
CREATE TABLE IF NOT EXISTS cr_sites (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Groups table
CREATE TABLE IF NOT EXISTS cr_groups (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    siteId INT,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (siteId) REFERENCES cr_sites(id)
);

-- Roles table
CREATE TABLE IF NOT EXISTS cr_roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    groupId INT,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (groupId) REFERENCES cr_groups(id)
);

-- Event Types table
CREATE TABLE IF NOT EXISTS cr_eventTypes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    color VARCHAR(7) DEFAULT '#007bff',
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Events table
CREATE TABLE IF NOT EXISTS cr_events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    date DATE NOT NULL,
    time TIME,
    eventTypeId INT,
    groupId INT,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (eventTypeId) REFERENCES cr_eventTypes(id),
    FOREIGN KEY (groupId) REFERENCES cr_groups(id)
);

-- Event People table
CREATE TABLE IF NOT EXISTS cr_eventPeople (
    id INT AUTO_INCREMENT PRIMARY KEY,
    eventId INT NOT NULL,
    userId INT NOT NULL,
    roleId INT,
    status ENUM('confirmed', 'pending', 'declined') DEFAULT 'pending',
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (eventId) REFERENCES cr_events(id),
    FOREIGN KEY (userId) REFERENCES cr_users(id),
    FOREIGN KEY (roleId) REFERENCES cr_roles(id)
);

-- Settings table
CREATE TABLE IF NOT EXISTS cr_settings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    settingKey VARCHAR(255) NOT NULL UNIQUE,
    settingValue TEXT,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert default settings
INSERT IGNORE INTO cr_settings (settingKey, settingValue) VALUES
('site_name', 'Rota Management System'),
('site_description', 'Web-based rota management system'),
('email_enabled', 'false'),
('installation_complete', 'false');

-- Insert default event types
INSERT IGNORE INTO cr_eventTypes (name, description, color) VALUES
('Service', 'Regular service event', '#007bff'),
('Meeting', 'Group meeting', '#28a745'),
('Special Event', 'Special occasion', '#ffc107'),
('Practice', 'Practice session', '#17a2b8');

-- Insert default site
INSERT IGNORE INTO cr_sites (name, description) VALUES
('Main Site', 'Primary location for events and activities');

-- Insert default group
INSERT IGNORE INTO cr_groups (name, description, siteId) VALUES
('General', 'General group for all members', 1);

-- Insert default roles
INSERT IGNORE INTO cr_roles (name, description, groupId) VALUES
('Leader', 'Event leader or coordinator', 1),
('Assistant', 'Event assistant', 1),
('Participant', 'Event participant', 1);

-- Show created tables
SHOW TABLES LIKE 'cr_%'; 