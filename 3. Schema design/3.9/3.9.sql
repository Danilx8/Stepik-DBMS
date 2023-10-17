CREATE TABLE Conference(
    name TEXT PRIMARY KEY,
    description TEXT
);

CREATE TABLE Venue(
    id INTEGER PRIMARY KEY,
    name TEXT,
    city TEXT,
    country TEXT,
    lat NUMERIC(7,5),
    lon NUMERIC(8,5),
    unique(lat, lon)
);

CREATE TABLE PaperSubmission(
  id INTEGER PRIMARY KEY,
  conference TEXT,
  year INTEGER,
  title TEXT,
  isbn TEXT,
  page INTEGER,
  venue_id INTEGER,
  UNIQUE(conference, venue_id, isbn),
  foreign key(conference) references Conference(name),
  foreign key(venue_id) references Venue(id)
  );