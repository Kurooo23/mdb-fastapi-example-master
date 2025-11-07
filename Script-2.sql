CREATE DATABASE pemesanan_kamar_hotel;
USE pemesanan_kamar_hotel;

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

DROP ROLE IF EXISTS 'r_tamu', 'r_admin';
CREATE ROLE IF NOT EXISTS 'r_tamu', 'r_admin';

SELECT user, host, is_role
FROM mysql.user
WHERE user IN ('r_tamu','r_admin');
SHOW GRANTS FOR CURRENT_USER;


GRANT SELECT ON pemesanan_kamar_hotel.kamar TO 'r_tamu';
GRANT SELECT ON pemesanan_kamar_hotel.kategori_kamar TO 'r_tamu';
GRANT SELECT ON pemesanan_kamar_hotel.reservasi TO 'r_tamu';

GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE
  ON pemesanan_kamar_hotel.* TO 'r_admin';

CREATE USER IF NOT EXISTS 'tamu_app'@'%'  IDENTIFIED BY 'SandiTamu!';
CREATE USER IF NOT EXISTS 'admin_app'@'%' IDENTIFIED BY 'SandiAdmin!';

GRANT 'r_tamu'  TO 'tamu_app'@'%';
GRANT 'r_admin' TO 'admin_app'@'%';
SET DEFAULT ROLE 'r_tamu'  FOR 'tamu_app'@'%';
SET DEFAULT ROLE 'r_admin' FOR 'admin_app'@'%';

SHOW GRANTS FOR 'tamu_app'@'%';
SHOW GRANTS FOR 'admin_app'@'%';

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

DROP TABLE reservasi;
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

-- 1. Menghitung pendapatan per bulan
DELIMITER $$
DROP FUNCTION IF EXISTS hitung_pendapatan_bulanan $$
CREATE FUNCTION hitung_pendapatan_bulanan(p_tahun INT, p_bulan INT)
RETURNS DECIMAL(18,2)
DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
BEGIN
    DECLARE awal_bulan DATE;
    DECLARE awal_bulan_berikut DATE;
    DECLARE total_bulan DECIMAL(18,2);

    /* Validasi sederhana bulan 1..12 (opsional) */
    IF p_bulan < 1 OR p_bulan > 12 THEN
        RETURN 0.00;
    END IF;

    /* Rentang [awal_bulan, awal_bulan_berikut) */
    SET awal_bulan         = DATE(CONCAT(p_tahun, '-', LPAD(p_bulan, 2, '0'), '-01'));
    SET awal_bulan_berikut = DATE_ADD(awal_bulan, INTERVAL 1 MONTH);

    /* Agregasi total_biaya pada bulan pembayaran tsb */
    SELECT COALESCE(SUM(r.total_biaya), 0.00)
      INTO total_bulan
      FROM reservasi r
     WHERE r.status IN ('checkin', 'checkout')
       AND r.tanggal_pembayaran >= awal_bulan
       AND r.tanggal_pembayaran <  awal_bulan_berikut;

    RETURN total_bulan;
END $$
DELIMITER ;

-- SELECT hitung_pendapatan_bulanan(2025, 10) AS total_okt_2025;

-- 2. Melihat pendapatan perbulan

DROP VIEW IF EXISTS v_pendapatan_bulanan;
CREATE OR REPLACE VIEW v_pendapatan_bulanan AS
SELECT
    YEAR(r.tanggal_pembayaran)  AS tahun,
    MONTH(r.tanggal_pembayaran) AS bulan,
    COALESCE(SUM(r.total_biaya), 0.00) AS pendapatan_bulanan,
    COUNT(*) AS jumlah_transaksi
FROM reservasi r
WHERE r.tanggal_pembayaran IS NOT NULL AND r.status IN ('checkin','checkout')
GROUP BY YEAR(r.tanggal_pembayaran), MONTH(r.tanggal_pembayaran);

-- Select * from FROM v_pendapatan_bulanan ORDER BY tahun DESC, bulan DESC;

-- 3. Trigger
-- 1.	Normalisasi & Validasi user.email
DELIMITER $$
DROP TRIGGER IF EXISTS trg_user_bi_normalize_email $$
CREATE TRIGGER trg_user_bi_normalize_email
BEFORE INSERT ON `user`
FOR EACH ROW
BEGIN
  -- normalisasi email
  IF NEW.email IS NOT NULL THEN
    SET NEW.email = LOWER(TRIM(NEW.email));
  END IF;

  -- validasi admin
  IF NEW.role = 'admin' THEN
    IF NEW.email IS NULL OR RIGHT(NEW.email, 9) <> '@hotel.id' THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Isi sesuai dengan email admin.';
    END IF;
  END IF;
END $$
DELIMITER ;

-- 2. Validasi & Normalisasi reservasi (Sebelum Insert)
DELIMITER $$

DROP TRIGGER IF EXISTS trg_reservasi_bi_validate $$
CREATE TRIGGER trg_reservasi_bi_validate
BEFORE INSERT ON reservasi
FOR EACH ROW
BEGIN
  DECLARE v_count INT DEFAULT 0;

  -- Normalize kode_reservasi
  IF NEW.kode_reservasi IS NOT NULL THEN
    SET NEW.kode_reservasi = UPPER(TRIM(NEW.kode_reservasi));
  END IF;

  -- Validasi waktu
  IF NEW.waktu_checkout IS NOT NULL AND NEW.waktu_checkout <= NEW.waktu_checkin THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Checkout harus setelah checkin (trigger).';
  END IF;

  -- Cek bentrok hanya untuk status aktif
  IF NEW.status IN ('dipesan','checkin') THEN
    SELECT COUNT(*) INTO v_count
      FROM reservasi r
     WHERE r.id_kamar = NEW.id_kamar
       AND r.status   IN ('dipesan','checkin')
       AND NOT (r.waktu_checkout <= NEW.waktu_checkin
             OR r.waktu_checkin  >= NEW.waktu_checkout);
    IF v_count > 0 THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Reservasi bentrok: slot kamar sudah terpakai (trigger).';
    END IF;
  END IF;
END $$
DELIMITER ;

-- 3. Sinkronisasi status kamar saat INSERT reservasi
DELIMITER $$

DROP TRIGGER IF EXISTS trg_reservasi_ai_sync_room $$
CREATE TRIGGER trg_reservasi_ai_sync_room
AFTER INSERT ON reservasi
FOR EACH ROW
BEGIN
  IF NEW.status = 'checkin' THEN
    UPDATE kamar SET status = 'terisi' WHERE id_kamar = NEW.id_kamar;
  ELSEIF NEW.status IN ('checkout','batal') THEN
    UPDATE kamar SET status = 'tersedia' WHERE id_kamar = NEW.id_kamar;
  END IF;
END $$

DELIMITER ;

-- 4. Aturan saat Update reservasi
DELIMITER $$
DROP TRIGGER IF EXISTS trg_reservasi_bu_rules $$
CREATE TRIGGER trg_reservasi_bu_rules
BEFORE UPDATE ON reservasi
FOR EACH ROW
BEGIN
  DECLARE v_count  INT DEFAULT 0;
  DECLARE v_harga  DECIMAL(10,2);
  DECLARE v_malam  INT;

  -- Validasi waktu saat diubah
  IF NEW.waktu_checkout IS NOT NULL AND NEW.waktu_checkout <= NEW.waktu_checkin THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Checkout harus setelah checkin (trigger).';
  END IF;

  -- Cek overlap jadwal untuk status aktif
  IF NEW.status IN ('dipesan','checkin') THEN
    SELECT COUNT(*) INTO v_count
      FROM reservasi r
     WHERE r.id_kamar = NEW.id_kamar
       AND r.id_reservasi <> OLD.id_reservasi
       AND r.status   IN ('dipesan','checkin')
       AND NOT (r.waktu_checkout <= NEW.waktu_checkin
             OR r.waktu_checkin  >= NEW.waktu_checkout);
    IF v_count > 0 THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Reservasi bentrok saat update (trigger).';
    END IF;
  END IF;

  -- Menjelang checkout: lengkapi nilai-nilai jika kosong
  IF NEW.status = 'checkout' THEN
    -- checkout time default
    IF NEW.waktu_checkout IS NULL THEN
      SET NEW.waktu_checkout = NOW();
    END IF;
    -- ambil harga kamar
    SELECT k.harga_per_malam INTO v_harga
      FROM kamar k
     WHERE k.id_kamar = NEW.id_kamar;
    -- hitung malam (minimal 1)
    SET v_malam = GREATEST(1, CEIL(TIMESTAMPDIFF(MINUTE, NEW.waktu_checkin, NEW.waktu_checkout) / 1440));
    -- total biaya default
    IF NEW.total_biaya IS NULL THEN
      SET NEW.total_biaya = ROUND(v_harga * v_malam, 2);
    END IF;
    -- tanggal pembayaran default
    IF NEW.tanggal_pembayaran IS NULL THEN
      SET NEW.tanggal_pembayaran = NOW();
    END IF;
  END IF;
END $$
DELIMITER ;

-- 5. Sinkronisasi status kamar saat UPDATE reservasi
DELIMITER $$
DROP TRIGGER IF EXISTS trg_reservasi_au_sync_room $$
CREATE TRIGGER trg_reservasi_au_sync_room
AFTER UPDATE ON reservasi
FOR EACH ROW
BEGIN
  IF NEW.status = 'checkin' AND OLD.status <> 'checkin' THEN
    UPDATE kamar SET status = 'terisi' WHERE id_kamar = NEW.id_kamar;

  ELSEIF NEW.status IN ('checkout','batal') AND OLD.status <> NEW.status THEN
    UPDATE kamar SET status = 'tersedia' WHERE id_kamar = NEW.id_kamar;
  END IF;
END $$
DELIMITER ;




-- 4. Stored Procedure untuk membuat reservasi
DELIMITER $$
DROP PROCEDURE IF EXISTS buat_reservasi $$
CREATE PROCEDURE buat_reservasi(
    IN p_id_user INT,
    IN p_id_kamar INT,
    IN p_kode_reservasi VARCHAR(50),
    IN p_checkin DATETIME,
    IN p_checkout DATETIME,
    IN p_status ENUM('dipesan','checkin','checkout','batal'),           -- boleh NULL → akan jadi 'dipesan'
    IN p_total_biaya DECIMAL(10,2),
    IN p_tanggal_pembayaran DATETIME,
    IN p_metode_pembayaran ENUM('cash','transfer','e-wallet','kartu_kredit')
)
BEGIN
    DECLARE v_harga_per_malam DECIMAL(10,2);
    DECLARE v_durasi_night    INT;
    DECLARE v_total_biaya     DECIMAL(10,2);
    DECLARE v_count           INT DEFAULT 0;
    DECLARE v_status_kamar    ENUM('tersedia','terisi','perbaikan');
    DECLARE v_role_user       ENUM('admin','tamu');
    DECLARE v_status          ENUM('dipesan','checkin','checkout','batal');

    /* Handler transaksi */
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    /* 0) Validasi user & role */
    SELECT u.ROLE
      INTO v_role_user
      FROM `user` u
     WHERE u.id_user = p_id_user
     FOR UPDATE;

    IF v_role_user IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User tidak ditemukan.';
    END IF;

    IF v_role_user = 'admin' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User role admin tidak dapat membuat reservasi tamu.';
    END IF;

    /* 0b) Normalisasi status: NULL → 'dipesan' */
    IF p_status IS NULL THEN
        SET v_status := 'dipesan';
    ELSE
        SET v_status := p_status;
    END IF;

    /* 1) Ambil info kamar & kunci baris kamar */
    SELECT k.harga_per_malam, k.status
      INTO v_harga_per_malam, v_status_kamar
      FROM kamar k
     WHERE k.id_kamar = p_id_kamar
     FOR UPDATE;

    IF v_harga_per_malam IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Kamar tidak ditemukan.';
    END IF;

    /* 1b) Tolak jika kamar sedang 'terisi'/'perbaikan' saat hendak dipesan/checkin */
    IF v_status IN ('dipesan','checkin') AND v_status_kamar IN ('terisi','perbaikan') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Kamar tidak tersedia untuk dipesan.';
    END IF;

    /* 2) Validasi waktu */
    IF p_checkout <= p_checkin THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Checkout harus setelah checkin.';
    END IF;

    /* 3) Cek bentrok slot untuk status aktif */
    SELECT COUNT(*) INTO v_count
      FROM reservasi r
     WHERE r.id_kamar = p_id_kamar
       AND r.status IN ('dipesan','checkin')
       AND NOT (r.waktu_checkout <= p_checkin OR r.waktu_checkin >= p_checkout)
     FOR UPDATE;

    IF v_count > 0 AND v_status IN ('dipesan','checkin') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Reservasi gagal: jadwal kamar bentrok.';
    END IF;

    /* 4) Hitung total biaya (auto jika NULL) */
    IF p_total_biaya IS NULL THEN 
        SET v_durasi_night = GREATEST(1, CEIL(TIMESTAMPDIFF(HOUR, p_checkin, p_checkout) / 24));
        SET v_total_biaya  = ROUND(v_harga_per_malam * v_durasi_night, 2);
    ELSE 
        SET v_total_biaya  = p_total_biaya;
    END IF;

    /* 5) Insert ke RESERVASI */
    INSERT INTO reservasi (
        id_user, id_kamar, kode_reservasi,
        waktu_checkin, waktu_checkout, status,
        total_biaya, tanggal_pembayaran, metode_pembayaran
    ) VALUES (
        p_id_user, p_id_kamar, p_kode_reservasi,
        p_checkin, p_checkout, v_status,
        v_total_biaya, p_tanggal_pembayaran, p_metode_pembayaran
    );

    /* 6) Sinkron status kamar */
	IF v_status = 'checkin' THEN
       UPDATE kamar
          SET status = 'terisi'
       WHERE id_kamar = p_id_kamar;

	ELSEIF v_status IN ('checkout','batal') THEN
        UPDATE kamar
           SET status = 'tersedia'
          WHERE id_kamar = p_id_kamar;

	-- ELSE (v_status = 'dipesan'): tidak mengubah status kamar
	END IF;

    COMMIT;
END $$
DELIMITER ;

-- Ini buat mengubah status menjadi checkin
DELIMITER $$
DROP PROCEDURE IF EXISTS checkin_reservasi $$
CREATE PROCEDURE checkin_reservasi(IN p_id_reservasi INT)
BEGIN
  DECLARE v_status_lama ENUM('dipesan','checkin','checkout','batal');
  DECLARE v_id_kamar INT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN ROLLBACK; RESIGNAL; END;

  START TRANSACTION;

  SELECT r.status, r.id_kamar
    INTO v_status_lama, v_id_kamar
    FROM reservasi r
   WHERE r.id_reservasi = p_id_reservasi
   FOR UPDATE;

  IF v_status_lama IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Reservasi tidak ditemukan.';
  END IF;

  -- Hanya boleh dari 'dipesan' ke 'checkin'
  IF v_status_lama <> 'dipesan' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Status tidak valid untuk check-in.';
  END IF;

  UPDATE reservasi
     SET status = 'checkin'
   WHERE id_reservasi = p_id_reservasi;

  UPDATE kamar
     SET status = 'terisi'
   WHERE id_kamar = v_id_kamar;

  COMMIT;
END $$
DELIMITER ;

CALL checkin_reservasi(1);


-- Ini buat mengubah status menjadi checkout
DELIMITER $$

DROP PROCEDURE IF EXISTS checkout_reservasi $$
CREATE PROCEDURE checkout_reservasi(
  IN p_id_reservasi INT
)
BEGIN
  DECLARE v_status_lama ENUM('dipesan','checkin','checkout','batal');
  DECLARE v_id_kamar    INT;
  DECLARE v_checkin     DATETIME;
  DECLARE v_checkout    DATETIME;
  DECLARE v_metode      ENUM('cash','transfer','e-wallet','kartu_kredit');
  DECLARE v_tgl_bayar   DATETIME;
  DECLARE v_total       DECIMAL(10,2);
  DECLARE v_harga       DECIMAL(10,2);
  DECLARE v_malam       INT;

  /* Handler: rollback jika exception SQL */
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;

  /* Handler: reservasi tidak ditemukan */
  DECLARE EXIT HANDLER FOR NOT FOUND
  BEGIN
    ROLLBACK;
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Reservasi tidak ditemukan.';
  END;

  START TRANSACTION;

  /* Kunci & ambil data reservasi */
  SELECT r.status,
         r.id_kamar,
         r.waktu_checkin,
         r.waktu_checkout,
         r.metode_pembayaran,
         r.tanggal_pembayaran,
         r.total_biaya
    INTO v_status_lama,
         v_id_kamar,
         v_checkin,
         v_checkout,
         v_metode,
         v_tgl_bayar,
         v_total
    FROM reservasi r
   WHERE r.id_reservasi = p_id_reservasi
   FOR UPDATE;

  /* Hanya bisa checkout dari status 'checkin' */
  IF v_status_lama <> 'checkin' THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Status tidak valid untuk checkout (harus dari checkin).';
  END IF;

  /* Isi checkout jika belum ada */
  IF v_checkout IS NULL THEN
    SET v_checkout = NOW();
  END IF;

  /* Ambil harga kamar (kunci baris kamar sekaligus) */
  SELECT k.harga_per_malam
    INTO v_harga
    FROM kamar k
   WHERE k.id_kamar = v_id_kamar
   FOR UPDATE;

  /* Hitung jumlah malam (minimal 1) dan total biaya */
  SET v_malam = GREATEST(1, CEIL(TIMESTAMPDIFF(MINUTE, v_checkin, v_checkout) / 1440));
  SET v_total = ROUND(v_harga * v_malam, 2);

  /* Isi tanggal bayar default jika belum ada */
  IF v_tgl_bayar IS NULL THEN
    SET v_tgl_bayar = NOW();
  END IF;

  /* Update reservasi → checkout */
  UPDATE reservasi
     SET status             = 'checkout',
         waktu_checkout     = v_checkout,
         total_biaya        = v_total,
         tanggal_pembayaran = v_tgl_bayar,
         metode_pembayaran  = v_metode
   WHERE id_reservasi = p_id_reservasi;

  /* Kembalikan kamar → tersedia */
  UPDATE kamar
     SET status = 'tersedia'
   WHERE id_kamar = v_id_kamar;

  COMMIT;
END $$

DELIMITER ;



CALL checkout_reservasi(1, 600000, '2024-12-31 19:00:00', 'transfer');

-- Ini buat mengubah status menjadi batal
DELIMITER $$
DROP PROCEDURE IF EXISTS batal_reservasi $$
CREATE PROCEDURE batal_reservasi(IN p_id_reservasi INT)
BEGIN
  DECLARE v_status_lama ENUM('dipesan','checkin','checkout','batal');
  DECLARE v_id_kamar INT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN ROLLBACK; RESIGNAL; END;

  START TRANSACTION;

  SELECT r.status, r.id_kamar
    INTO v_status_lama, v_id_kamar
    FROM reservasi r
   WHERE r.id_reservasi = p_id_reservasi
   FOR UPDATE;

  IF v_status_lama IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Reservasi tidak ditemukan.';
  END IF;

  -- Batalkan hanya jika belum checkout
  IF v_status_lama IN ('checkout','batal') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Reservasi sudah checkout/batal.';
  END IF;

  UPDATE reservasi
     SET status = 'batal'
   WHERE id_reservasi = p_id_reservasi;

  UPDATE kamar
     SET status = 'tersedia'
   WHERE id_kamar = v_id_kamar;

  COMMIT;
END $$
DELIMITER ;

CALL batal_reservasi(1);

CALL buat_reservasi(1, 10, 'PAY002', '2025-01-01 10:00:00', '2025-01-04 10:00:00','dipesan' , 600000, '2025-01-01 07:00:00', 'cash');
CALL buat_reservasi(3, 2, 'PAY003', '2025-01-01 10:00:00', '2025-01-04 10:00:00','dipesan' , NULL, '2025-01-01 07:00:00', 'cash');
CALL checkin_reservasi(3);

truncate TABLE reservasi;

Select * FROM v_pendapatan_bulanan 
ORDER BY tahun DESC, bulan DESC;

-- Menambah user (registrasi)
DELIMITER $$
DROP PROCEDURE IF EXISTS registrasi $$
CREATE PROCEDURE registrasi(
    IN  p_nama_lengkap   VARCHAR(255),
    IN  p_nomor_telepon  VARCHAR(20),
    IN  p_alamat         TEXT,
    IN  p_email          VARCHAR(255),
    IN  p_role_in        VARCHAR(20),      -- NULL/kosong => 'tamu'; jika diisi hanya 'admin'/'tamu'
    IN  p_password       VARCHAR(255)      -- password wajib diisi
)
BEGIN
    DECLARE v_role        VARCHAR(20);
    DECLARE v_email_norm  VARCHAR(255);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Validasi wajib nama
    IF p_nama_lengkap IS NULL OR TRIM(p_nama_lengkap) = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nama lengkap wajib diisi.';
    END IF;

    -- Validasi wajib password
    IF p_password IS NULL OR TRIM(p_password) = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Password wajib diisi.';
    END IF;

    -- Normalisasi email (lowercase + trim)
    SET v_email_norm = LOWER(NULLIF(TRIM(p_email), ''));

    -- Tentukan role
    IF p_role_in IS NULL OR TRIM(p_role_in) = '' THEN
        SET v_role = 'tamu';
    ELSE
        SET v_role = LOWER(TRIM(p_role_in));
        IF v_role NOT IN ('admin','tamu') THEN
            SIGNAL SQLSTATE '45000'
              SET MESSAGE_TEXT = 'Role tidak valid. Kosong/NULL = tamu atau gunakan "admin"/"tamu".';
        END IF;
    END IF;

    -- Admin wajib @hotel.id
    IF v_role = 'admin' THEN
        IF v_email_norm IS NULL OR RIGHT(v_email_norm, 9) <> '@hotel.id' THEN
            SIGNAL SQLSTATE '45000'
              SET MESSAGE_TEXT = 'Role admin hanya untuk email @hotel.id.';
        END IF;
    END IF;

    -- (Opsional) cek email unik
    IF v_email_norm IS NOT NULL THEN
        IF EXISTS (SELECT 1 FROM `user` WHERE email = v_email_norm) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email sudah terdaftar.';
        END IF;
    END IF;

    -- Simpan data user (termasuk password)
    INSERT INTO `user` (`ROLE`, nama_lengkap, nomor_telepon, alamat, email, `password`)
    VALUES (v_role, p_nama_lengkap, p_nomor_telepon, p_alamat, v_email_norm, p_password);

    COMMIT;

    -- Kembalikan id user baru
    SELECT LAST_INSERT_ID() AS id_user_baru;
END $$
DELIMITER ;

-- procedure untuk login
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_login_user $$
CREATE PROCEDURE sp_login_user(
  IN in_email     VARCHAR(100),
  IN in_password  VARCHAR(255)
)
BEGIN
  DECLARE v_id_user       INT;
  DECLARE v_role          VARCHAR(20);
  DECLARE v_nama_lengkap  VARCHAR(100);
  DECLARE v_email         VARCHAR(100);
  DECLARE v_password_db   VARCHAR(255);
  DECLARE v_count         INT DEFAULT 0;

  SELECT COUNT(*) INTO v_count
  FROM user
  WHERE email = in_email;

  IF v_count = 0 THEN
    SELECT
      'INVALID_EMAIL'   AS status,
      'Email is not registered' AS message,
      NULL AS id_user, 
  	  NULL AS nama_lengkap,
      NULL AS role, 
      NULL AS email;
  ELSE
    SELECT id_user, role, nama_lengkap, email, password
      INTO v_id_user, v_role, v_nama_lengkap, v_email, v_password_db
    FROM user
    WHERE email = in_email
    LIMIT 1;

    IF BINARY v_password_db = BINARY in_password THEN
      SELECT
        'OK'               AS status,
        'Login successful' AS message,
        v_id_user          AS id_user,
        v_nama_lengkap     AS nama_lengkap,
        v_role             AS role,
        v_email            AS email;
    ELSE
      SELECT
        'INVALID_PASSWORD'   AS status,
        'Incorrect password' AS message,
        NULL AS id_user, 
        NULL AS nama_lengkap, 
        NULL AS role, 
        v_email AS email;
    END IF;
  END IF;
END $$
DELIMITER ;

CALL sp_login_user('bagas@gmail.com', 'uhbt1123');
CALL sp_login_user('zaki01@hotel.id', 'zak14riza');



-- INDEX
CREATE UNIQUE INDEX uq_user_role_email ON `user` (role, email);
CREATE INDEX idx_user_email ON `user` (email);
CREATE INDEX idx_kamar_kategori ON kamar (id_kategori);
CREATE INDEX idx_kamar_status ON kamar (status);
CREATE INDEX idx_reservasi_user_checkin ON reservasi (id_user, waktu_checkin);
CREATE INDEX idx_reservasi_kamar_window
  ON reservasi (id_kamar, status, waktu_checkin, waktu_checkout);
CREATE INDEX idx_reservasi_tgl_bayar ON reservasi (tanggal_pembayaran);

-- View untuk melihat katalog kamar
DROP VIEW IF EXISTS v_katalog_kategori;
CREATE OR REPLACE VIEW v_katalog_kategori AS
SELECT
    kk.id_kategori,
    kk.nama_kategori,
    kk.deskripsi,
    kk.kapasitas_orang,
    /* Agregasi hanya untuk kamar yang tersedia */
    COUNT(CASE WHEN km.status = 'tersedia' THEN 1 END) AS jumlah_kamar_tersedia,
    MIN(CASE WHEN km.status = 'tersedia' THEN km.harga_per_malam END) AS harga_min_tersedia,
    MAX(CASE WHEN km.status = 'tersedia' THEN km.harga_per_malam END) AS harga_max_tersedia,
    ROUND(AVG(CASE WHEN km.status = 'tersedia' THEN km.harga_per_malam END), 2)          AS harga_rata2_tersedia
FROM kategori_kamar kk
LEFT JOIN kamar km
       ON km.id_kategori = kk.id_kategori
GROUP BY
    kk.id_kategori, kk.nama_kategori, kk.deskripsi, kk.kapasitas_orang;

-- View untuk melihat riwayat reservasi
CREATE OR REPLACE VIEW v_riwayat_reservasi AS
SELECT
    r.id_reservasi,
    r.kode_reservasi,
    r.id_user,
    u.role,
    u.nama_lengkap,
    u.email,
    r.id_kamar,
    r.waktu_checkin,
    r.waktu_checkout,
    GREATEST(
        TIMESTAMPDIFF(DAY, r.waktu_checkin, COALESCE(r.waktu_checkout, NOW())),
        0
    ) AS lama_menginap_hari,
    r.status                AS status_reservasi,
    r.tanggal_pembayaran,
    r.metode_pembayaran,
    r.total_biaya
FROM reservasi AS r
JOIN `user`  AS u ON u.id_user = r.id_user;

-- Memanggil view pendapatan bulanan
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_refresh_dan_tampil_v_pendapatan_bulanan $$
CREATE PROCEDURE sp_refresh_dan_tampil_v_pendapatan_bulanan()
BEGIN
  /* 1) Refresh view */
  DROP VIEW IF EXISTS v_pendapatan_bulanan;

  CREATE OR REPLACE
    ALGORITHM = MERGE
    SQL SECURITY INVOKER
    VIEW v_pendapatan_bulanan AS
  SELECT
      YEAR(r.tanggal_pembayaran)  AS tahun,
      MONTH(r.tanggal_pembayaran) AS bulan,
      COALESCE(SUM(r.total_biaya), 0.00) AS pendapatan_bulanan,
      COUNT(*) AS jumlah_transaksi
  FROM reservasi r
  WHERE r.tanggal_pembayaran IS NOT NULL
    AND r.status IN ('checkin','checkout')
  GROUP BY YEAR(r.tanggal_pembayaran), MONTH(r.tanggal_pembayaran);

  /* 2) Kembalikan hasil seperti view */
  SELECT tahun, bulan, pendapatan_bulanan, jumlah_transaksi
  FROM v_pendapatan_bulanan
  ORDER BY tahun, bulan;
END $$
DELIMITER ;

CALL sp_refresh_dan_tampil_v_pendapatan_bulanan();

-- Melihat Katalog Kamar
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_v_katalog_kategori $$
CREATE PROCEDURE sp_v_katalog_kategori()
BEGIN
  /* Segarkan definisi view (MySQL 8.0.13+) */
  CREATE OR REPLACE SQL SECURITY INVOKER VIEW v_katalog_kategori AS
  SELECT
      kk.id_kategori,
      kk.nama_kategori,
      kk.deskripsi,
      kk.kapasitas_orang,
      COUNT(CASE WHEN km.status = 'tersedia' THEN 1 END) AS jumlah_kamar_tersedia,
      MIN(CASE WHEN km.status = 'tersedia' THEN km.harga_per_malam END) AS harga_min_tersedia,
      MAX(CASE WHEN km.status = 'tersedia' THEN km.harga_per_malam END) AS harga_max_tersedia,
      ROUND(AVG(CASE WHEN km.status = 'tersedia' THEN km.harga_per_malam END), 2) AS harga_rata2_tersedia
  FROM kategori_kamar kk
  LEFT JOIN kamar km
         ON km.id_kategori = kk.id_kategori
  GROUP BY
      kk.id_kategori, kk.nama_kategori, kk.deskripsi, kk.kapasitas_orang;

  /* Kembalikan hasil seperti SELECT dari view */
  SELECT * FROM v_katalog_kategori;
END $$
DELIMITER ;

CALL sp_v_katalog_kategori();

-- Melihat view untuk melihat riwayat reservasi
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_refresh_dan_tampil_v_riwayat_reservasi_tamu $$
CREATE PROCEDURE sp_refresh_dan_tampil_v_riwayat_reservasi_tamu(IN p_id_user INT)
BEGIN
  /* 1) Refresh view umum (tanpa parameter) */
  DROP VIEW IF EXISTS v_riwayat_reservasi;
  CREATE OR REPLACE
    ALGORITHM = MERGE
    SQL SECURITY INVOKER
    VIEW v_riwayat_reservasi AS
  SELECT
      r.id_reservasi,
      r.kode_reservasi,
      r.id_user,
      u.role,
      u.nama_lengkap,
      u.email,
      r.id_kamar,
      r.waktu_checkin,
      r.waktu_checkout,
      GREATEST(
          TIMESTAMPDIFF(DAY, r.waktu_checkin, COALESCE(r.waktu_checkout, NOW())),
          0
      ) AS lama_menginap_hari,
      r.status                AS status_reservasi,
      r.tanggal_pembayaran,
      r.metode_pembayaran,
      r.total_biaya
  FROM reservasi AS r
  JOIN `user`  AS u ON u.id_user = r.id_user;

  /* 2) Tampilkan hanya milik tamu (id_user) yang diminta */
  SELECT
      id_reservasi,
      kode_reservasi,
      id_user,
      role,
      nama_lengkap,
      email,
      id_kamar,
      waktu_checkin,
      waktu_checkout,
      lama_menginap_hari,
      status_reservasi,
      tanggal_pembayaran,
      metode_pembayaran,
      total_biaya
  FROM v_riwayat_reservasi
  WHERE id_user = p_id_user
  ORDER BY waktu_checkin DESC, id_reservasi DESC;
END $$
DELIMITER ;

CALL sp_refresh_dan_tampil_v_riwayat_reservasi_tamu(4);




-- Tamu
SELECT * 
FROM v_riwayat_reservasi
WHERE id_user = 4
ORDER BY COALESCE(tanggal_pembayaran, waktu_checkin) DESC;

-- Admin
SELECT *
FROM v_riwayat_reservasi
ORDER BY COALESCE(tanggal_pembayaran, waktu_checkin) DESC;

SELECT * FROM v_katalog_kategori ORDER BY id_kategori;

CALL registrasi('M. Zaki Apriza', '081266484021', 'Jalan Pemda No. 12, Samarinda', 'zaki01@hotel.id', 'admin', 'zak14riza');
CALL registrasi('Asep Sahrony', '081100112324', 'Jalan Merdeka No. 38, Samarinda', 'sahron1@hotel.id', 'admin', 'admin1234');
CALL registrasi('Bagas Yoga Pratama Pramudika', '087879558120', 'Jl. Sembako, Balikpapan Kota', 'bagas@gmail.com', '', 'uhbt1123');
CALL registrasi('Rafi Baydar', '081394271834', 'Jalan Pupuk No. 10, Bontang', 'rbaydar@sottle.org', NULL, 'oo096na');
truncate TABLE reservasi;
truncate TABLE USER;
CALL buat_reservasi(3, 1, 'PAY001',  '2025-01-05 14:00:00','2025-01-06 12:00:00', NULL, NULL, '2025-01-05 13:00:00', 'transfer');
CALL buat_reservasi(4, 3, 'PAY002',  '2025-01-05 14:00:00','2025-01-08 12:00:00', NULL, NULL, '2025-01-05 12:00:00', 'transfer');

CALL checkin_reservasi(1);
CALL checkout_reservasi(2);
