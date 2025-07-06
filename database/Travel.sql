CREATE DATABASE Travel;
GO

USE Travel;
GO

-- Tabel SUPIR
CREATE TABLE Supir (
    id_supir VARCHAR(15) NOT NULL UNIQUE,
    nama_supir VARCHAR(50) NOT NULL,
    no_telepon CHAR(12) NOT NULL UNIQUE,
    PRIMARY KEY(id_supir)
);
GO

-- Tabel ARMADA
CREATE TABLE Armada (
    no_stnk VARCHAR(15) NOT NULL UNIQUE,
    jenis VARCHAR(20) NOT NULL,
    kapasitas INT NOT NULL,
    id_supir VARCHAR(15) NOT NULL,
    PRIMARY KEY(no_stnk),
    FOREIGN KEY (id_supir) REFERENCES Supir(id_supir)
);
GO

-- Tabel REGION
CREATE TABLE Region (
    id_region VARCHAR(15) NOT NULL UNIQUE,
    nama_region VARCHAR(50) NOT NULL,
    kode_pos VARCHAR(7) NOT NULL UNIQUE,
    PRIMARY KEY(id_region)
);
GO

-- Tabel USER
CREATE TABLE [User] (
    id_user VARCHAR(15) NOT NULL UNIQUE,
    nama VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    no_telepon CHAR(12) NOT NULL UNIQUE,
    gender CHAR(1) CHECK (gender IN ('L', 'P')) NOT NULL,
    domisili VARCHAR(50) NOT NULL,
    PRIMARY KEY(id_user)
);
GO

-- Tabel WISATA
CREATE TABLE Wisata (
    id_wisata VARCHAR(15) NOT NULL UNIQUE,
    nama_wisata VARCHAR(50) NOT NULL,
    jam_buka TIME NOT NULL,
    jam_tutup TIME NOT NULL,
    deskripsi TEXT NOT NULL,
    id_region VARCHAR(15) NOT NULL,
    PRIMARY KEY(id_wisata),
    FOREIGN KEY(id_region) REFERENCES Region(id_region)
);
GO

-- Tabel PAKET_TOUR
CREATE TABLE Paket_Tour (
    id_paket VARCHAR(15) NOT NULL UNIQUE,
    nama_paket VARCHAR(50) NOT NULL,
    biaya INT NOT NULL,
    durasi VARCHAR(30),
    PRIMARY KEY(id_paket)
);
GO

-- Tabel relasi Many-to-Many: PAKET_TOUR - WISATA
CREATE TABLE Paket_Wisata (
    id_paket VARCHAR(15) NOT NULL,
    id_wisata VARCHAR(15) NOT NULL,
    PRIMARY KEY (id_paket, id_wisata),
    FOREIGN KEY(id_paket) REFERENCES Paket_Tour(id_paket),
    FOREIGN KEY(id_wisata) REFERENCES Wisata(id_wisata)
);
GO

-- Tabel TRANSAKSI
CREATE TABLE Transaksi (
    id_transaksi VARCHAR(15) NOT NULL UNIQUE,
    id_user VARCHAR(15) NOT NULL,
    id_paket VARCHAR(15) NOT NULL,
    no_stnk VARCHAR(15) NOT NULL,
    tanggal_transaksi DATETIME NOT NULL,
    total_biaya DECIMAL(12,2) NOT NULL,
    status_pembayaran VARCHAR(10) CHECK (status_pembayaran IN ('Pending', 'Lunas', 'Batal')) NOT NULL,
    PRIMARY KEY(id_transaksi),
    FOREIGN KEY(id_user) REFERENCES [User](id_user),
    FOREIGN KEY(id_paket) REFERENCES Paket_Tour(id_paket), -- Baris ini yang diperbaiki
    FOREIGN KEY(no_stnk) REFERENCES Armada(no_stnk)
);
GO
