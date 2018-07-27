-- CREATE TABLES
CREATE TABLE ListenerUserID (
UserID INT PRIMARY KEY,
Email VARCHAR(255) NOT NULL,
FirstName VARCHAR(255),
LastName VARCHAR(255),
Age INT,
UNIQUE(Email)
);

CREATE TABLE ListenerEmail (
Email VARCHAR(255) PRIMARY KEY,
Password VARCHAR(255),
FOREIGN KEY (Email) REFERENCES ListenerUserID (Email)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE ArtistUserID (
UserID INT PRIMARY KEY,
Email VARCHAR(255) NOT NULL,
StageName VARCHAR(255) NOT NULL,
UNIQUE(Email),
UNIQUE(StageName)
);

CREATE TABLE ArtistEmail(
Email VARCHAR(255) PRIMARY KEY,
Password VARCHAR(255),
FOREIGN KEY (Email) REFERENCES ArtistUserID (Email)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE ArtistName(
StageName VARCHAR(255) PRIMARY KEY,
FirstName VARCHAR(255),
LastName VARCHAR(255),
FOREIGN KEY (StageName) REFERENCES ArtistUserID (StageName)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE CreatePlaylist (
UserID INT,
PlaylistName VARCHAR(255),
PRIMARY KEY(UserID, PlaylistName),
FOREIGN KEY (UserID) REFERENCES ListenerUserID (UserID)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE Album (
AlbumID INT PRIMARY KEY,
AlbumArt VARCHAR(255),
AlbumName VARCHAR(255)
);

CREATE TABLE CreateAlbum(
AlbumID INT,
UserID INT,
CreationDate DATE,
PRIMARY KEY(AlbumID, UserID),
FOREIGN KEY (AlbumID) REFERENCES Album (AlbumID)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (UserID) REFERENCES ArtistUserID(UserID)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE ContainSong(
AlbumID INT,
SongName VARCHAR(255),
TrackLength VARCHAR(20),
PRIMARY KEY (AlbumID, SongName),
FOREIGN KEY (AlbumID) REFERENCES Album (AlbumID)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE PlaylistIncludesSongs(
AlbumID INT,
SongName VARCHAR(255),
UserID INT,
PlaylistName VARCHAR(255),
PRIMARY KEY(AlbumID,SongName,UserID,PlaylistName),
FOREIGN KEY (AlbumID,SongName) REFERENCES ContainSong (AlbumID, SongName)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (UserID,PlaylistName) REFERENCES CreatePlaylist (UserID,PlaylistName)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE Genre(
GenreName VARCHAR(255) PRIMARY KEY
);

CREATE TABLE HaveSongs(
AlbumID INT,
SongName VARCHAR(255),
GenreName VARCHAR(255),
PRIMARY KEY(AlbumID, SongName, GenreName),
FOREIGN KEY (AlbumID,SongName) REFERENCES ContainSong (AlbumID,SongName)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY(GenreName) REFERENCES Genre (GenreName)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE Label(
LabelName VARCHAR(255) PRIMARY KEY
);

CREATE TABLE UnderLabel(
UserID INT,
AlbumID INT,
LabelName VARCHAR(255),
PRIMARY KEY (UserID, AlbumID, LabelName),
FOREIGN KEY (UserID) REFERENCES ArtistUserID (UserID)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (AlbumID) REFERENCES Album (AlbumID)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (LabelName) REFERENCES Label (LabelName)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE IsParentOfLabel(
ParentLabelName VARCHAR(255),
SubLabelName VARCHAR(255),
PRIMARY KEY (ParentLabelName, SubLabelName),
FOREIGN KEY (ParentLabelName) REFERENCES Label (LabelName)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (SubLabelName) REFERENCES Label (LabelName)
ON DELETE CASCADE
ON UPDATE CASCADE
);
