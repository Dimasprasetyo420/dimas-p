-- Migration number: 0001 	 2025-06-29T17:22:05.455Z
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    address TEXT
);
CREATE TABLE IF NOT EXISTS todos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    content TEXT NOT NULL,
    done BOOLEAN DEFAULT FALSE,
    category TEXT CHECK(category IN ('biasa', 'penting')),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);