SET FOREIGN_KEY_CHECKS = 1;

DROP TABLE USER;
CREATE TABLE user (
	id_user INT PRIMARY KEY AUTO_INCREMENT,
	ROLE enum('admin', 'tamu'),
    nama_lengkap VARCHAR(255) NOT NULL,
    password varchar(255) NOT NULL,
    nomor_telepon VARCHAR(20),
    alamat TEXT,
    email VARCHAR(255)
);
INSERT INTO user (nama_lengkap, nomor_telepon, alamat, email) VALUES
('Alex Johnson', '08125557890', 'Jalan Raya Menteng No. 1, Jakarta Pusat', 'alex.j@hotel.com'),
('Sarah Chen', '08781234567', 'Jalan Sudirman No. 2, Jakarta Selatan', 'sarah.c@hotel.com'),
('Ryan Patel', '081198765432', 'Jalan Gatot Subroto No. 3, Jakarta Timur', 'ryan.p@hotel.com');

INSERT INTO tamu (nama_lengkap, nomor_telepon, alamat, email) VALUES
('Andi Saputra', '081234567890', 'Jalan Merpati No. 10, Jakarta', 'andi.saputra@mail.com'),
('Andini Putri', '081512345679', 'Jalan Laut No. 6, Mataram', 'andini.putri@mail.com'),
('Bagas Aditama', '081923456780', 'Jalan Gunung No. 7, Palu', 'bagas.aditama@mail.com'),
('Budi Santoso', '085678901234', 'Jalan Anggrek No. 12, Bandung', 'budi.santoso@mail.com'),
('Candra Wijaya', '089677889901', 'Jalan Danau No. 8, Kendari', 'candra.wijaya@mail.com'),
('Citra Lestari', '087811223344', 'Jalan Melati No. 5, Surabaya', 'citra.lestari@mail.com'),
('Dewi Anggraini', '082199887766', 'Jalan Kenanga No. 7, Yogyakarta', 'dewi.anggraini@mail.com'),
('Dian Susanti', '082233445567', 'Jalan Pantai No. 9, Gorontalo', 'dian.susanti@mail.com'),
('Eka Pratama', '081345678901', 'Jalan Flamboyan No. 8, Malang', 'eka.pratama@mail.com'),
('Fajar Nugroho', '085210987654', 'Jalan Mawar No. 20, Medan', 'fajar.nugroho@mail.com'),
('Gita Permata', '081512345678', 'Jalan Sawo No. 9, Semarang', 'gita.permata@mail.com'),
('Hendri Wijaya', '081923456789', 'Jalan Jeruk No. 3, Makassar', 'hendri.wijaya@mail.com'),
('Indah Puspita', '089677889900', 'Jalan Apel No. 14, Bali', 'indah.puspita@mail.com'),
('Joko Susilo', '082233445566', 'Jalan Durian No. 16, Palembang', 'joko.susilo@mail.com'),
('Kiki Amelia', '081112233445', 'Jalan Nangka No. 11, Solo', 'kiki.amelia@mail.com'),
('Lukman Hakim', '085798765432', 'Jalan Matoa No. 2, Pontianak', 'lukman.hakim@mail.com'),
('Maya Sari', '081645678901', 'Jalan Duku No. 4, Samarinda', 'maya.sari@mail.com'),
('Nina Kartika', '081787654321', 'Jalan Rambutan No. 6, Pekanbaru', 'nina.kartika@mail.com'),
('Oscar Prasetyo', '081890123456', 'Jalan Belimbing No. 18, Balikpapan', 'oscar.prasetyo@mail.com'),
('Putri Maharani', '082345678901', 'Jalan Kedondong No. 15, Manado', 'putri.maharani@mail.com'),
('Qori Hidayah', '085112345678', 'Jalan Pisang No. 22, Banjarmasin', 'qori.hidayah@mail.com'),
('Rizki Ramadhan', '081398765432', 'Jalan Manggis No. 30, Jambi', 'rizki.ramadhan@mail.com'),
('Sinta Dewi', '085811223344', 'Jalan Kersen No. 25, Aceh', 'sinta.dewi@mail.com'),
('Taufik Hidayat', '089555667788', 'Jalan Mangga No. 40, Padang', 'taufik.hidayat@mail.com'),
('Umar Bakri', '081234567891', 'Jalan Pahlawan No. 50, Jayapura', 'umar.bakri@mail.com'),
('Vina Febrianti', '085612345678', 'Jalan Garuda No. 1, Sorong', 'vina.febrianti@mail.com'),
('Wahyu Pratama', '087812345678', 'Jalan Merdeka No. 2, Ambon', 'wahyu.pratama@mail.com'),
('Xavier Putra', '082199887755', 'Jalan Cendrawasih No. 3, Ternate', 'xavier.putra@mail.com'),
('Yulia Sari', '081345678900', 'Jalan Angkasa No. 4, Bima', 'yulia.sari@mail.com'),
('Zaky Maulana', '085210987653', 'Jalan Bumi No. 5, Kupang', 'zaky.maulana@mail.com');

CREATE TABLE kategori_kamar (
    id_kategori INT PRIMARY KEY AUTO_INCREMENT,
    nama_kategori VARCHAR(50) NOT NULL,
    deskripsi TEXT,
    kapasitas_orang INT NOT NULL
);

INSERT INTO kategori_kamar (nama_kategori, deskripsi, kapasitas_orang) VALUES
('Standard', 'Kamar standar dengan 1 kasur queen size, AC, TV, kamar mandi dalam, dan Wi-Fi gratis.', 2),
('Deluxe', 'Kamar deluxe dengan ruang lebih luas, 1 kasur king size, minibar, AC, TV kabel, kamar mandi mewah.', 2),
('Family', 'Kamar keluarga dengan 2 kasur queen size, cocok untuk liburan keluarga, dilengkapi meja dan sofa.', 4),
('Suite', 'Kamar suite eksklusif dengan ruang tamu terpisah, sofa, kasur king size, bathtub, minibar, pemandangan kota.', 2),
('Presidential', 'Kamar presidential dengan fasilitas mewah, ruang tamu besar, ruang makan, kasur king size, jacuzzi, dan butler pribadi.', 2);

CREATE TABLE kamar (
    id_kamar INT PRIMARY KEY AUTO_INCREMENT,
    id_kategori INT,
    nomor_kamar VARCHAR(10) NOT NULL UNIQUE,
    lantai INT,
    harga_per_malam DECIMAL(10, 2),
    status ENUM('tersedia', 'terisi', 'perbaikan'),
    FOREIGN KEY (id_kategori) REFERENCES kategori_kamar(id_kategori)
);

INSERT INTO kamar (id_kamar, id_kategori, nomor_kamar, lantai, harga_per_malam, status) VALUES
(1, 1, '101', 1, 300000.00, 'tersedia'),
(2, 1, '102', 1, 300000.00, 'tersedia'),
(3, 3, '301', 3, 750000.00, 'tersedia'),
(4, 1, '103', 1, 300000.00, 'tersedia'),
(5, 5, '501', 5, 2500000.00, 'tersedia'),
(6, 1, '104', 1, 300000.00, 'tersedia'),
(7, 2, '201', 2, 500000.00, 'tersedia'),
(8, 2, '202', 2, 500000.00, 'tersedia'),
(9, 4, '401', 4, 1200000.00, 'tersedia'),
(10, 1, '105', 1, 300000.00, 'tersedia'),
(11, 2, '203', 2, 500000.00, 'tersedia'),
(12, 2, '204', 2, 500000.00, 'tersedia'),
(13, 3, '302', 3, 750000.00, 'tersedia'),
(14, 2, '205', 2, 500000.00, 'tersedia'),
(15, 1, '106', 1, 300000.00, 'tersedia'),
(16, 2, '206', 2, 500000.00, 'tersedia'),
(17, 2, '207', 2, 500000.00, 'tersedia'),
(18, 2, '208', 2, 500000.00, 'tersedia'),
(19, 2, '209', 2, 500000.00, 'tersedia'),
(20, 2, '210', 2, 500000.00, 'tersedia'),
(21, 3, '303', 3, 750000.00, 'tersedia'),
(22, 3, '304', 3, 750000.00, 'tersedia'),
(23, 3, '305', 3, 750000.00, 'tersedia'),
(24, 4, '402', 4, 1200000.00, 'tersedia'),
(25, 4, '403', 4, 1200000.00, 'tersedia'),
(26, 4, '404', 4, 1200000.00, 'tersedia'),
(27, 4, '405', 4, 1200000.00, 'tersedia'),
(28, 5, '502', 5, 2500000.00, 'tersedia'),
(29, 5, '503', 5, 2500000.00, 'tersedia'),
(30, 5, '504', 5, 2500000.00, 'tersedia'),
(31, 5, '505', 5, 2500000.00, 'tersedia');

CREATE TABLE reservasi (
    id_reservasi INT PRIMARY KEY AUTO_INCREMENT,
    id_user INT,
    id_kamar INT,
    kode_reservasi VARCHAR(20) UNIQUE NOT NULL,
    tanggal_pembayaran DATETIME,
    waktu_checkin DATETIME NOT NULL,
    waktu_checkout DATETIME,
    status ENUM('dipesan', 'checkin', 'checkout', 'batal'),
    total_biaya  DECIMAL(10, 2),
    metode_pembayaran ENUM('cash','transfer','e-wallet','kartu_kredit'),
    FOREIGN KEY (id_user) REFERENCES user(id_user),
    FOREIGN KEY (id_kamar) REFERENCES kamar(id_kamar)
);
