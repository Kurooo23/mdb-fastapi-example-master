

DROP TABLE IF EXISTS `kamar`;
CREATE TABLE `kamar` (
  `id_kamar` int NOT NULL AUTO_INCREMENT,
  `id_kategori` int DEFAULT NULL,
  `nomor_kamar` varchar(10) NOT NULL,
  `lantai` int DEFAULT NULL,
  `harga_per_malam` decimal(10,2) DEFAULT NULL,
  `status` enum('tersedia','terisi','perbaikan') DEFAULT NULL,
  PRIMARY KEY (`id_kamar`),
  UNIQUE KEY `nomor_kamar` (`nomor_kamar`),
  KEY `id_kategori` (`id_kategori`),
  CONSTRAINT `kamar_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `kategori_kamar` (`id_kategori`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `kategori_kamar`;
CREATE TABLE `kategori_kamar` (
  `id_kategori` int NOT NULL AUTO_INCREMENT,
  `nama_kategori` varchar(50) NOT NULL,
  `deskripsi` text,
  `kapasitas_orang` int NOT NULL,
  PRIMARY KEY (`id_kategori`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
DROP TABLE IF EXISTS `reservasi`;
CREATE TABLE `reservasi` (
  `id_reservasi` int NOT NULL AUTO_INCREMENT,
  `id_user` int DEFAULT NULL,
  `id_kamar` int DEFAULT NULL,
  `tanggal_pembayaran` datetime DEFAULT NULL,
  `waktu_checkin` datetime NOT NULL,
  `waktu_checkout` datetime DEFAULT NULL,
  `status` enum('dipesan','checkin','checkout','batal') DEFAULT NULL,
  `total_biaya` decimal(10,2) DEFAULT NULL,
  `metode_pembayaran` enum('cash','transfer','e-wallet','kartu_kredit') DEFAULT NULL,
  PRIMARY KEY (`id_reservasi`),
  KEY `id_user` (`id_user`),
  KEY `id_kamar` (`id_kamar`),
  CONSTRAINT `reservasi_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`),
  CONSTRAINT `reservasi_ibfk_2` FOREIGN KEY (`id_kamar`) REFERENCES `kamar` (`id_kamar`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `session_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `session_login` (
  `id_session` int NOT NULL AUTO_INCREMENT,
  `nama_lengkap` varchar(255) NOT NULL,
  `waktu_login` datetime NOT NULL,
  `waktu_logout` datetime DEFAULT NULL,
  PRIMARY KEY (`id_session`),
  KEY `idx_nama_waktu` (`nama_lengkap`,`waktu_login`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `ROLE` enum('admin','tamu') DEFAULT NULL,
  `nama_lengkap` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nomor_telepon` varchar(20) DEFAULT NULL,
  `alamat` text,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `uq_user_role_email` (`ROLE`,`email`),
  KEY `idx_user_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
DELIMITER ;;

DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `v_kamar_tersedia`
--

DROP TABLE IF EXISTS `v_kamar_tersedia`;
/*!50001 DROP VIEW IF EXISTS `v_kamar_tersedia`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_kamar_tersedia` AS SELECT 
 1 AS `nomor_kamar`,
 1 AS `lantai`,
 1 AS `nama_kategori`,
 1 AS `deskripsi`,
 1 AS `kapasitas_orang`,
 1 AS `harga_per_malam`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_katalog_kategori`
--

DROP TABLE IF EXISTS `v_katalog_kategori`;
/*!50001 DROP VIEW IF EXISTS `v_katalog_kategori`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_katalog_kategori` AS SELECT 
 1 AS `id_kategori`,
 1 AS `nama_kategori`,
 1 AS `deskripsi`,
 1 AS `kapasitas_orang`,
 1 AS `jumlah_kamar_tersedia`,
 1 AS `harga_per_malam`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_pendapatan_bulanan`
--

DROP TABLE IF EXISTS `v_pendapatan_bulanan`;
/*!50001 DROP VIEW IF EXISTS `v_pendapatan_bulanan`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_pendapatan_bulanan` AS SELECT 
 1 AS `tahun`,
 1 AS `bulan`,
 1 AS `pendapatan_bulanan`,
 1 AS `jumlah_transaksi`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_reservasi_detail`
--

DROP TABLE IF EXISTS `v_reservasi_detail`;
/*!50001 DROP VIEW IF EXISTS `v_reservasi_detail`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_reservasi_detail` AS SELECT 
 1 AS `id_reservasi`,
 1 AS `nama_lengkap`,
 1 AS `nomor_kamar`,
 1 AS `waktu_checkin`,
 1 AS `waktu_checkout`,
 1 AS `status`,
 1 AS `total_biaya`,
 1 AS `tanggal_pembayaran`,
 1 AS `metode_pembayaran`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_session_login`
--

DROP TABLE IF EXISTS `v_session_login`;
/*!50001 DROP VIEW IF EXISTS `v_session_login`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_session_login` AS SELECT 
 1 AS `id_user`,
 1 AS `nama_lengkap`,
 1 AS `waktu_login`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'pemesanan_kamar_hotel'
--

--
-- Dumping routines for database 'pemesanan_kamar_hotel'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_hitung_total_biaya` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_hitung_total_biaya`(p_id_reservasi INT) RETURNS decimal(10,2)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE v_checkin   DATETIME;
    DECLARE v_checkout  DATETIME;
    DECLARE v_harga     DECIMAL(10,2);
    DECLARE v_jam       INT;
    DECLARE v_hari      INT;
    DECLARE v_total     DECIMAL(10,2);
    -- Ambil data reservasi + harga kamar
    SELECT r.waktu_checkin,
           r.waktu_checkout,
           k.harga_per_malam
      INTO v_checkin, v_checkout, v_harga
      FROM reservasi r
      JOIN kamar k ON k.id_kamar = r.id_kamar
     WHERE r.id_reservasi = p_id_reservasi
     LIMIT 1;
    -- Jika data penting tidak ada, kembalikan NULL
    IF v_checkin IS NULL OR v_checkout IS NULL OR v_harga IS NULL THEN
        RETURN NULL;
    END IF;
    -- Hitung selisih jam antara checkin dan checkout
    SET v_jam = TIMESTAMPDIFF(HOUR, v_checkin, v_checkout);
    -- Kalau checkout <= checkin (aneh), paksa minimal 1 hari
    IF v_jam <= 0 THEN
        SET v_hari = 1;
    ELSE
        -- Hitung hari dengan pembulatan ke atas
        SET v_hari = CEIL(v_jam / 24);
    END IF;
    -- Safety: minimal tetap 1 hari
    IF v_hari < 1 THEN
        SET v_hari = 1;
    END IF;
    SET v_total = v_hari * v_harga;
    RETURN v_total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `hitung_pendapatan_bulanan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `hitung_pendapatan_bulanan`(p_tahun INT, p_bulan INT) RETURNS decimal(18,2)
    READS SQL DATA
    DETERMINISTIC
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_buat_reservasi` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buat_reservasi`(
    IN p_nama_lengkap       VARCHAR(255),
    IN p_nomor_kamar        VARCHAR(10),
    IN p_checkin            DATETIME,
    IN p_checkout           DATETIME,
    IN p_tanggal_pembayaran DATETIME,
    IN p_metode_pembayaran  ENUM('cash','transfer','e-wallet','kartu_kredit')
)
BEGIN
    DECLARE v_id_user           INT;
    DECLARE v_id_kamar          INT;
    DECLARE v_harga_per_malam   DECIMAL(10,2);
    DECLARE v_status_kamar      ENUM('tersedia','terisi','perbaikan');
    DECLARE v_role_user         ENUM('admin','tamu');
    DECLARE v_id_reservasi      INT;
    DECLARE v_total_biaya       DECIMAL(10,2);

    -- pengganti COUNT(*)
    DECLARE v_id_session_aktif  INT;
    DECLARE v_conflict_id       INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    /* 0) Map user + validasi role */
    SELECT u.id_user, u.ROLE
      INTO v_id_user, v_role_user
      FROM `user` u
     WHERE u.nama_lengkap = p_nama_lengkap
     LIMIT 1 FOR UPDATE;

    IF v_id_user IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User tidak ditemukan.';
    END IF;

    IF v_role_user = 'admin' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User role admin tidak dapat membuat reservasi tamu.';
    END IF;

    /* 0a) Wajib: user sedang login (tanpa COUNT) */
    SET v_id_session_aktif = NULL;
    SELECT s.id_session
      INTO v_id_session_aktif
      FROM session_login s
     WHERE s.nama_lengkap = p_nama_lengkap
       AND s.waktu_logout IS NULL
     ORDER BY s.waktu_login DESC
     LIMIT 1;

    IF v_id_session_aktif IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Akses ditolak: user belum login atau sesi sudah berakhir.';
    END IF;

    /* 1) Map kamar + info kamar */
    SELECT k.id_kamar, k.harga_per_malam, k.status
      INTO v_id_kamar, v_harga_per_malam, v_status_kamar
      FROM kamar k
     WHERE k.nomor_kamar = p_nomor_kamar
     LIMIT 1 FOR UPDATE;

    IF v_id_kamar IS NULL OR v_harga_per_malam IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Kamar tidak ditemukan.';
    END IF;

    IF v_status_kamar IN ('terisi','perbaikan') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Kamar tidak tersedia untuk dipesan.';
    END IF;

    /* 2) Validasi waktu & metode */
    IF p_checkin IS NULL OR p_checkout IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Waktu checkin/checkout wajib diisi.';
    END IF;

    IF p_checkout <= p_checkin THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Checkout harus setelah checkin.';
    END IF;

    IF p_metode_pembayaran IS NOT NULL
       AND p_metode_pembayaran NOT IN ('cash','transfer','e-wallet','kartu_kredit') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Metode pembayaran tidak valid.';
    END IF;

    /* 2a) Validasi tanggal pembayaran:
           - Wajib diisi
           - Boleh sebelum atau sama dengan waktu checkin
           - TIDAK boleh setelah waktu checkin
    */
    IF p_tanggal_pembayaran IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Tanggal/waktu pembayaran wajib diisi.';
    END IF;

    IF p_tanggal_pembayaran > p_checkin THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Tanggal/waktu pembayaran tidak boleh setelah waktu check-in.';
    END IF;

    /* 3) Cek bentrok slot (status dipesan/checkin dan rentang waktu bentrok) */
    SET v_conflict_id = NULL;

    SELECT r.id_reservasi
      INTO v_conflict_id
      FROM reservasi r
     WHERE r.id_kamar = v_id_kamar
       AND r.status IN ('dipesan','checkin')
       AND NOT (r.waktu_checkout <= p_checkin OR r.waktu_checkin >= p_checkout)
     LIMIT 1 FOR UPDATE;

    IF v_conflict_id IS NOT NULL THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Reservasi gagal: kamar ini sudah dipesan/terisi pada rentang waktu tersebut.';
    END IF;

    /* 4) Insert reservasi: status langsung 'dipesan' */
    INSERT INTO reservasi (
        id_user, 
        id_kamar,
        waktu_checkin, 
        waktu_checkout,
        status,
        total_biaya,
        tanggal_pembayaran, 
        metode_pembayaran
    ) VALUES (
        v_id_user, 
        v_id_kamar,
        p_checkin, 
        p_checkout,
        'dipesan',          -- status awal reservasi
        NULL,               -- total_biaya dihitung setelahnya
        p_tanggal_pembayaran, 
        p_metode_pembayaran
    );

    SET v_id_reservasi = LAST_INSERT_ID();

    /* 5) Hitung total_biaya via fungsi */
    SET v_total_biaya = fn_hitung_total_biaya(v_id_reservasi);

    IF v_total_biaya IS NOT NULL THEN
        UPDATE reservasi
           SET total_biaya = v_total_biaya
         WHERE id_reservasi = v_id_reservasi;
    END IF;

    COMMIT;

    /* 6) Kembalikan 1 row lengkap untuk API */
    SELECT
        r.id_reservasi,
        u.nama_lengkap,
        k.nomor_kamar,
        r.waktu_checkin,
        r.waktu_checkout,
        r.tanggal_pembayaran,
        r.metode_pembayaran,
        r.status,
        r.total_biaya
    FROM reservasi r
    JOIN `user` u  ON u.id_user  = r.id_user
    JOIN kamar  k  ON k.id_kamar = r.id_kamar
    WHERE r.id_reservasi = v_id_reservasi
    LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_checkin_reservasi` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checkin_reservasi`(IN p_id_reservasi INT)
BEGIN
  DECLARE v_status_reservasi ENUM('dipesan','checkin','checkout','batal');
  DECLARE v_id_kamar         INT;
  DECLARE v_checkin          DATETIME;
  DECLARE v_checkout         DATETIME;
  DECLARE v_status_kamar     ENUM('tersedia','terisi','perbaikan');
  DECLARE v_conflict_id      INT;
  /* Handler error: rollback lalu lempar ulang */
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;
  /* Validasi input */
  IF p_id_reservasi IS NULL OR p_id_reservasi <= 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Parameter id_reservasi tidak valid.';
  END IF;
  START TRANSACTION;
  /* Ambil & kunci baris reservasi */
  SELECT r.status, r.id_kamar, r.waktu_checkin, r.waktu_checkout
    INTO v_status_reservasi, v_id_kamar, v_checkin, v_checkout
    FROM reservasi r
   WHERE r.id_reservasi = p_id_reservasi
   LIMIT 1
   FOR UPDATE;
  IF v_status_reservasi IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Reservasi tidak ditemukan.';
  END IF;
  /* Hanya boleh dari "dipesan" ke "checkin" */
  IF v_status_reservasi <> 'dipesan' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Status tidak valid untuk check-in (harus dari status "dipesan").';
  END IF;
  /* Validasi waktu check-in/checkout */
  IF v_checkin IS NULL OR v_checkout IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Waktu check-in / check-out belum ditetapkan.';
  END IF;
  IF v_checkin >= v_checkout THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Rentang waktu tidak valid: check-in harus < check-out.';
  END IF;
  /* Kunci baris kamar & validasi status kamar */
  SELECT k.status
    INTO v_status_kamar
    FROM kamar k
   WHERE k.id_kamar = v_id_kamar
   LIMIT 1
   FOR UPDATE;
  IF v_status_kamar IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Kamar tidak ditemukan.';
  END IF;
  IF v_status_kamar = 'perbaikan' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Kamar sedang perbaikan; tidak dapat check-in.';
  END IF;
  /* Opsional: pastikan saat sebelum check-in kamar memang belum terisi */
  IF v_status_kamar = 'terisi' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Kamar sudah terisi; tidak dapat check-in.';
  END IF;
  /* Cek bentrok dengan reservasi lain aktif pada rentang yang sama */
  SET v_conflict_id = NULL;
  SELECT r2.id_reservasi
    INTO v_conflict_id
    FROM reservasi r2
   WHERE r2.id_kamar = v_id_kamar
     AND r2.id_reservasi <> p_id_reservasi
     AND r2.status IN ('dipesan','checkin')
     AND NOT (r2.waktu_checkout <= v_checkin OR r2.waktu_checkin >= v_checkout)
   LIMIT 1
   FOR UPDATE;
  IF v_conflict_id IS NOT NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Reservasi bentrok: kamar terpakai pada rentang ini.';
  END IF;
  /* Ubah status reservasi -> checkin */
  UPDATE reservasi
     SET status = 'checkin'
   WHERE id_reservasi = p_id_reservasi;
  /* Saat reservasi checkin, kamar menjadi tidak tersedia (terisi) */
  UPDATE kamar
     SET status = 'terisi'
   WHERE id_kamar = v_id_kamar;
  COMMIT;
  /* Ringkasan keluaran */
  SELECT r.id_reservasi,
         r.status,
         r.waktu_checkin,
         r.waktu_checkout,
         r.id_kamar,
         k.status AS status_kamar
    FROM reservasi r
    JOIN kamar k ON k.id_kamar = r.id_kamar
   WHERE r.id_reservasi = p_id_reservasi;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_checkout_reservasi` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checkout_reservasi`(
  IN p_id_reservasi INT
)
BEGIN
  DECLARE v_status_lama   ENUM('dipesan','checkin','checkout','batal');
  DECLARE v_id_kamar      INT;
  DECLARE v_checkin       DATETIME;
  DECLARE v_checkout      DATETIME;
  DECLARE v_metode        ENUM('cash','transfer','e-wallet','kartu_kredit');
  DECLARE v_tgl_bayar     DATETIME;
  DECLARE v_total         DECIMAL(10,2);
  DECLARE v_harga         DECIMAL(10,2);
  DECLARE v_malam         INT;
  DECLARE v_status_kamar  ENUM('tersedia','terisi','perbaikan');
  /* Handler error SQL → rollback lalu lempar ulang */
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;
  START TRANSACTION;
  /* Ambil & kunci data reservasi */
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
   LIMIT 1
   FOR UPDATE;
  /* Validasi ada/tidaknya reservasi */
  IF v_status_lama IS NULL THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Reservasi tidak ditemukan.';
  END IF;
  /* Hanya boleh checkout dari status 'checkin' */
  IF v_status_lama <> 'checkin' THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Status tidak valid untuk checkout (harus dari checkin).';
  END IF;
  /* Pastikan waktu check-in ada */
  IF v_checkin IS NULL THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Waktu check-in belum tercatat; tidak bisa checkout.';
  END IF;
  /* Isi waktu checkout jika belum ada */
  IF v_checkout IS NULL THEN
    SET v_checkout = NOW();
  END IF;
  /* Ambil & kunci baris kamar, sekaligus validasi keberadaan kamar */
  SELECT k.status, k.harga_per_malam
    INTO v_status_kamar, v_harga
    FROM kamar k
   WHERE k.id_kamar = v_id_kamar
   LIMIT 1
   FOR UPDATE;
  IF v_status_kamar IS NULL THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Kamar tidak ditemukan.';
  END IF;
  /* Hitung jumlah malam (minimal 1) dan total biaya */
  SET v_malam = GREATEST(1, CEIL(TIMESTAMPDIFF(MINUTE, v_checkin, v_checkout) / 1440));
  SET v_total = ROUND(v_harga * v_malam, 2);
  /* Isi tanggal bayar default jika belum ada (opsional sesuai kebijakan) */
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
  /* Ubah status kamar → tersedia */
  UPDATE kamar
     SET status = 'tersedia'
   WHERE id_kamar = v_id_kamar;
  COMMIT;
  /* Ringkasan keluaran (opsional, untuk dikonsumsi API) */
  SELECT r.id_reservasi,
         r.status,
         r.waktu_checkin,
         r.waktu_checkout,
         r.id_kamar,
         k.status AS status_kamar,
         r.total_biaya,
         r.tanggal_pembayaran,
         r.metode_pembayaran
    FROM reservasi r
    JOIN kamar k ON k.id_kamar = r.id_kamar
   WHERE r.id_reservasi = p_id_reservasi;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_login_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login_user`(
  IN in_email     VARCHAR(100),
  IN in_password  VARCHAR(255)
)
proc: BEGIN
  DECLARE v_id_user       INT;
  DECLARE v_role          VARCHAR(20);
  DECLARE v_nama_lengkap  VARCHAR(100);
  DECLARE v_email         VARCHAR(100);
  DECLARE v_password_db   VARCHAR(255);
  DECLARE v_exists        INT DEFAULT 0;
  DECLARE v_active        INT DEFAULT 0;
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;
  /* Cek email ada */
  SELECT COUNT(*) INTO v_exists
  FROM `user`
  WHERE email = in_email;
  IF v_exists = 0 THEN
    SELECT
      'INVALID_EMAIL'            AS status,
      'Email is not registered'  AS message,
      NULL AS id_user, 
      NULL AS nama_lengkap,
      NULL AS role, 
      NULL AS email;
    LEAVE proc;
  END IF;
  /* Ambil kredensial */
  SELECT id_user, role, nama_lengkap, email, `password`
    INTO v_id_user, v_role, v_nama_lengkap, v_email, v_password_db
  FROM `user`
  WHERE email = in_email
  LIMIT 1;
  /* Validasi password (contoh: plain; ganti dengan hash_verify bila perlu) */
  IF BINARY v_password_db <> BINARY in_password THEN
    SELECT
      'INVALID_PASSWORD'   AS status,
      'Incorrect password' AS message,
      NULL AS id_user, 
      NULL AS nama_lengkap, 
      NULL AS role, 
      v_email AS email;
    LEAVE proc;
  END IF;
  /* ----- Cek sesi aktif dan insert login secara atomik ----- */
  START TRANSACTION;
    /* Kunci baris sesi aktif user ini (kalau ada) untuk hindari race */
    SELECT COUNT(*) INTO v_active
    FROM session_login
    WHERE nama_lengkap = v_nama_lengkap
      AND waktu_logout IS NULL
    FOR UPDATE;
    IF v_active > 0 THEN
      ROLLBACK;
      SELECT
        'ALREADY_LOGGED_IN'         AS status,
        'User already has an active session' AS message,
        v_id_user       AS id_user,
        v_nama_lengkap  AS nama_lengkap,
        v_role          AS role,
        v_email         AS email;
      LEAVE proc;
    END IF;
    /* Catat sesi baru (aktif = waktu_logout NULL) */
    INSERT INTO session_login (nama_lengkap, waktu_login, waktu_logout)
    VALUES (v_nama_lengkap, NOW(), NULL);
  COMMIT;
  SELECT
    'OK'               AS status,
    'Login successful' AS message,
    v_id_user          AS id_user,
    v_nama_lengkap     AS nama_lengkap,
    v_role             AS role,
    v_email            AS email;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_logout_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_logout_user`(IN p_email VARCHAR(100))
BEGIN
  DECLARE v_nama_lengkap VARCHAR(100);
  -- Handler error SQL umum
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;
  -- Ambil nama_lengkap; pakai subquery agar NULL jika tidak ketemu (tanpa NOT FOUND handler)
  SET v_nama_lengkap = (
    SELECT u.nama_lengkap
    FROM `user` u
    WHERE u.email = p_email
    LIMIT 1
  );
  IF v_nama_lengkap IS NULL THEN
    SELECT 'INVALID_EMAIL' AS status, 'Email is not registered' AS message;
  ELSE
    START TRANSACTION;
      /* Urutkan berdasarkan urutan login:
         - Terbaru dulu: DESC (default di sini)
         - Kalau mau yang paling awal, ganti ke ASC
      */
      UPDATE session_login AS s
         SET s.waktu_logout = NOW()
       WHERE s.nama_lengkap = v_nama_lengkap
         AND s.waktu_logout IS NULL
       ORDER BY s.waktu_login DESC
       LIMIT 1;
      IF ROW_COUNT() = 0 THEN
        ROLLBACK;
        SELECT 'NO_ACTIVE_SESSION' AS status, 'No active session to logout' AS message;
      ELSE
        COMMIT;
        SELECT 'OK' AS status, 'Logout successful' AS message;
      END IF;
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_membatalkan_reservasi` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_membatalkan_reservasi`(
    IN p_nama_lengkap VARCHAR(255),
    IN p_nomor_kamar  VARCHAR(10)
)
BEGIN
  DECLARE v_status_lama   ENUM('dipesan','checkin','checkout','batal');
  DECLARE v_id_kamar      INT;
  DECLARE v_id_reservasi  INT;
  -- Handler error SQL
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;
  START TRANSACTION;
  SELECT 
      r.id_reservasi,
      r.status,
      r.id_kamar
  INTO 
      v_id_reservasi,
      v_status_lama,
      v_id_kamar
  FROM reservasi r
  JOIN `user` u  ON u.id_user   = r.id_user
  JOIN kamar  k  ON k.id_kamar  = r.id_kamar
  WHERE u.nama_lengkap = p_nama_lengkap
    AND k.nomor_kamar  = p_nomor_kamar
  ORDER BY r.id_reservasi DESC      
  LIMIT 1
  FOR UPDATE;
  IF v_status_lama IS NULL THEN
    SIGNAL SQLSTATE '45000' 
      SET MESSAGE_TEXT = 'Reservasi tidak ditemukan untuk tamu dan kamar tersebut.';
  END IF;
  -- Hanya boleh batal jika belum checkout / belum batal
  IF v_status_lama IN ('checkout','batal') THEN
    SIGNAL SQLSTATE '45000' 
      SET MESSAGE_TEXT = 'Reservasi sudah checkout/batal.';
  END IF;
  -- Ubah status reservasi jadi batal
  UPDATE reservasi
     SET status = 'batal'
   WHERE id_reservasi = v_id_reservasi;
  -- Kamar dikembalikan jadi tersedia
  UPDATE kamar
     SET status = 'tersedia'
   WHERE id_kamar = v_id_kamar;
   Select 'OK' AS status;
  COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_registrasi` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrasi`(
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
    DECLARE v_id_user     INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    START TRANSACTION;
    -- Validasi wajib
    IF p_nama_lengkap IS NULL OR TRIM(p_nama_lengkap) = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nama lengkap wajib diisi.';
    END IF;
    IF p_password IS NULL OR TRIM(p_password) = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Password wajib diisi.';
    END IF;
    -- Normalisasi
    SET v_email_norm = LOWER(NULLIF(TRIM(p_email), ''));
    IF p_role_in IS NULL OR TRIM(p_role_in) = '' THEN
        SET v_role = 'tamu';
    ELSE
        SET v_role = LOWER(TRIM(p_role_in));
        IF v_role NOT IN ('admin','tamu') THEN
            SIGNAL SQLSTATE '45000'
              SET MESSAGE_TEXT = 'Role tidak valid. Kosong/NULL = tamu atau gunakan "admin"/"tamu".';
        END IF;
    END IF;
    -- Aturan admin: wajib email @hotel.id
    IF v_role = 'admin' THEN
        IF v_email_norm IS NULL OR RIGHT(v_email_norm, 9) <> '@hotel.id' THEN
            SIGNAL SQLSTATE '45000'
              SET MESSAGE_TEXT = 'Role admin hanya untuk email @hotel.id.';
        END IF;
    END IF;
    -- Email unik (jika diisi)
    IF v_email_norm IS NOT NULL THEN
        IF EXISTS (SELECT 1 FROM `user` WHERE email = v_email_norm) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email sudah terdaftar.';
        END IF;
    END IF;
    -- Insert user
    INSERT INTO `user` (`ROLE`, nama_lengkap, nomor_telepon, alamat, email, `password`)
    VALUES (v_role, p_nama_lengkap, p_nomor_telepon, p_alamat, v_email_norm, p_password);
    SET v_id_user = LAST_INSERT_ID();
    COMMIT;
    -- Kembalikan data sesuai yang diharapkan controller
    SELECT
        u.id_user       AS id_user_baru,
        u.nama_lengkap  AS nama,
        u.email         AS email,
        u.`password`    AS `password`,
        u.`ROLE`        AS `ROLE`,
        u.alamat        AS alamat,
        u.nomor_telepon AS nomor_telepon
    FROM `user` u
    WHERE u.id_user = v_id_user
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_v_melihat_kamar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_v_melihat_kamar`()
BEGIN
    -- Handler error
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    -- VIEW di-create / di-replace (DDL, di luar transaksi READ ONLY)
    CREATE OR REPLACE SQL SECURITY INVOKER VIEW v_kamar_tersedia AS
    SELECT
        k.nomor_kamar,
        k.lantai,
        kk.nama_kategori,
        kk.deskripsi,
        kk.kapasitas_orang,
        k.harga_per_malam,
        k.status
    FROM kamar k
    LEFT JOIN kategori_kamar kk
           ON kk.id_kategori = k.id_kategori
    WHERE k.status = 'tersedia';
    -- Ambil data dari view dengan transaksi READ ONLY
    START TRANSACTION READ ONLY;
        SELECT
            nomor_kamar,
            lantai,
            nama_kategori,
            deskripsi,
            kapasitas_orang,
            harga_per_malam,
            status
        FROM v_kamar_tersedia;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_v_menampilkan_katalog_kategori` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_v_menampilkan_katalog_kategori`()
BEGIN
  -- Handler kalau ada error SQL
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;

  /* Definisikan / perbarui view katalog kategori */
  CREATE OR REPLACE SQL SECURITY INVOKER VIEW v_katalog_kategori AS
  SELECT
      kk.id_kategori,
      kk.nama_kategori,
      kk.deskripsi,
      kk.kapasitas_orang,
      COUNT(CASE WHEN km.status = 'tersedia' THEN km.id_kamar END) AS jumlah_kamar_tersedia,
      ROUND(AVG(CASE WHEN km.status = 'tersedia' THEN km.harga_per_malam END), 2) AS harga_per_malam
  FROM kategori_kamar kk
  LEFT JOIN kamar km
         ON km.id_kategori = kk.id_kategori
  GROUP BY
      kk.id_kategori,
      kk.nama_kategori,
      kk.deskripsi,
      kk.kapasitas_orang;

  -- Transaksi READ ONLY untuk pengambilan data dari view
  START TRANSACTION READ ONLY;
    SELECT
        id_kategori,
        nama_kategori,
        deskripsi,
        kapasitas_orang,
        jumlah_kamar_tersedia,
        harga_per_malam
    FROM v_katalog_kategori;
  COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_v_pendapatan_bulanan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_v_pendapatan_bulanan`()
BEGIN
    -- Handler jika ada error SQL: rollback lalu lempar ulang error
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
        -- Hapus view lama jika ada
        DROP VIEW IF EXISTS v_pendapatan_bulanan;

        -- Buat view baru berisi pendapatan bulanan
        CREATE SQL SECURITY INVOKER VIEW v_pendapatan_bulanan AS
        SELECT 
            YEAR(r.tanggal_pembayaran) AS tahun,
            MONTH(r.tanggal_pembayaran) AS bulan,
            SUM(r.total_biaya) AS pendapatan_bulanan,
            COUNT(*) AS jumlah_transaksi
        FROM reservasi r
        WHERE r.tanggal_pembayaran IS NOT NULL 
          AND r.status IN ('checkin','checkout')
        GROUP BY YEAR(r.tanggal_pembayaran), MONTH(r.tanggal_pembayaran);
    COMMIT;

    -- Langsung tampilkan hasil view dengan transaksi READ ONLY
    START TRANSACTION READ ONLY;
        SELECT
            tahun,
            bulan,
            pendapatan_bulanan,
            jumlah_transaksi
        FROM v_pendapatan_bulanan;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_v_reservasi_detail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_v_reservasi_detail`()
BEGIN
    -- Rollback jika ada error lalu lempar ulang
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    /* Buat/refresh view dalam transaksi */
    START TRANSACTION;
        CREATE OR REPLACE SQL SECURITY INVOKER VIEW v_reservasi_detail AS
        SELECT
            r.id_reservasi,
            u.nama_lengkap,
            k.nomor_kamar,
            r.waktu_checkin,
            r.waktu_checkout,
            r.status,
            r.total_biaya,
            r.tanggal_pembayaran,
            r.metode_pembayaran
        FROM reservasi r
        JOIN `user` u  ON u.id_user  = r.id_user
        JOIN kamar k   ON k.id_kamar = r.id_kamar;
    COMMIT;

    /* Kembalikan isinya; read-only transaction agar konsisten */
    START TRANSACTION READ ONLY;
        SELECT
            id_reservasi,
            nama_lengkap,
            nomor_kamar,
            waktu_checkin,
            waktu_checkout,
            status,
            total_biaya,
            tanggal_pembayaran,
            metode_pembayaran
        FROM v_reservasi_detail
        ORDER BY waktu_checkin DESC, id_reservasi DESC;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_v_riwayat_reservasi_by_nama` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_v_riwayat_reservasi_by_nama`(
    IN p_nama_lengkap VARCHAR(255)
)
    SQL SECURITY INVOKER
BEGIN
  DECLARE v_id_user INT;
  DECLARE v_nama    VARCHAR(255);
  -- Handler error
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;
  -- Normalisasi + validasi
  SET v_nama = NULLIF(TRIM(p_nama_lengkap), '');
  IF v_nama IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'nama_lengkap wajib diisi.';
  END IF;
  START TRANSACTION READ ONLY;
  -- Pastikan user ada (tanpa COUNT(*))
  SET v_id_user = NULL;
  SELECT u.id_user
    INTO v_id_user
    FROM `user` u
   WHERE u.nama_lengkap COLLATE utf8mb4_general_ci = v_nama
   LIMIT 1;
  IF v_id_user IS NULL THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User tidak ditemukan.';
  END IF;
  -- Kembalikan riwayat
  SELECT
      r.id_reservasi,
      u.nama_lengkap,
      k.nomor_kamar,
      r.waktu_checkin,
      r.waktu_checkout,
      GREATEST(
          TIMESTAMPDIFF(DAY, r.waktu_checkin, COALESCE(r.waktu_checkout, NOW())),
          0
      ) AS lama_menginap_hari,
      r.status             AS status_reservasi,
      r.tanggal_pembayaran,
      r.metode_pembayaran,
      r.total_biaya
  FROM reservasi r
  JOIN `user`  u ON u.id_user  = r.id_user
  JOIN kamar   k ON k.id_kamar = r.id_kamar
  WHERE u.id_user = v_id_user
  ORDER BY r.waktu_checkin DESC, r.id_reservasi DESC;
  COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_v_session_login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_v_session_login`()
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK; RESIGNAL;
  END;
  /* Hanya sesi aktif (waktu_logout IS NULL) */
  CREATE OR REPLACE SQL SECURITY INVOKER VIEW v_session_login AS
  SELECT
      u.id_user,
      s.nama_lengkap,
      s.waktu_login
  FROM session_login AS s
  JOIN `user`        AS u
    ON u.nama_lengkap = s.nama_lengkap
  WHERE s.waktu_logout IS NULL;
  START TRANSACTION READ ONLY;
  /* Urutkan sesuai urutan login (pakai DESC untuk terbaru dulu) */
  SELECT id_user, nama_lengkap, waktu_login
  FROM v_session_login
  ORDER BY waktu_login DESC;
  COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_kamar_tersedia`
--

/*!50001 DROP VIEW IF EXISTS `v_kamar_tersedia`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY INVOKER */
/*!50001 VIEW `v_kamar_tersedia` AS select `k`.`nomor_kamar` AS `nomor_kamar`,`k`.`lantai` AS `lantai`,`kk`.`nama_kategori` AS `nama_kategori`,`kk`.`deskripsi` AS `deskripsi`,`kk`.`kapasitas_orang` AS `kapasitas_orang`,`k`.`harga_per_malam` AS `harga_per_malam`,`k`.`status` AS `status` from (`kamar` `k` left join `kategori_kamar` `kk` on((`kk`.`id_kategori` = `k`.`id_kategori`))) where (`k`.`status` = 'tersedia') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_katalog_kategori`
--

/*!50001 DROP VIEW IF EXISTS `v_katalog_kategori`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY INVOKER */
/*!50001 VIEW `v_katalog_kategori` AS select `kk`.`id_kategori` AS `id_kategori`,`kk`.`nama_kategori` AS `nama_kategori`,`kk`.`deskripsi` AS `deskripsi`,`kk`.`kapasitas_orang` AS `kapasitas_orang`,count((case when (`km`.`status` = 'tersedia') then 1 end)) AS `jumlah_kamar_tersedia`,round(avg((case when (`km`.`status` = 'tersedia') then `km`.`harga_per_malam` end)),2) AS `harga_per_malam` from (`kategori_kamar` `kk` left join `kamar` `km` on((`km`.`id_kategori` = `kk`.`id_kategori`))) group by `kk`.`id_kategori`,`kk`.`nama_kategori`,`kk`.`deskripsi`,`kk`.`kapasitas_orang` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_pendapatan_bulanan`
--

/*!50001 DROP VIEW IF EXISTS `v_pendapatan_bulanan`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY INVOKER */
/*!50001 VIEW `v_pendapatan_bulanan` AS select year(`r`.`tanggal_pembayaran`) AS `tahun`,month(`r`.`tanggal_pembayaran`) AS `bulan`,coalesce(sum(`r`.`total_biaya`),0.00) AS `pendapatan_bulanan`,count(0) AS `jumlah_transaksi` from `reservasi` `r` where ((`r`.`tanggal_pembayaran` is not null) and (`r`.`status` in ('checkin','checkout'))) group by year(`r`.`tanggal_pembayaran`),month(`r`.`tanggal_pembayaran`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_reservasi_detail`
--

/*!50001 DROP VIEW IF EXISTS `v_reservasi_detail`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY INVOKER */
/*!50001 VIEW `v_reservasi_detail` AS select `r`.`id_reservasi` AS `id_reservasi`,`u`.`nama_lengkap` AS `nama_lengkap`,`k`.`nomor_kamar` AS `nomor_kamar`,`r`.`waktu_checkin` AS `waktu_checkin`,`r`.`waktu_checkout` AS `waktu_checkout`,`r`.`status` AS `status`,`r`.`total_biaya` AS `total_biaya`,`r`.`tanggal_pembayaran` AS `tanggal_pembayaran`,`r`.`metode_pembayaran` AS `metode_pembayaran` from ((`reservasi` `r` join `user` `u` on((`u`.`id_user` = `r`.`id_user`))) join `kamar` `k` on((`k`.`id_kamar` = `r`.`id_kamar`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_session_login`
--

/*!50001 DROP VIEW IF EXISTS `v_session_login`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY INVOKER */
/*!50001 VIEW `v_session_login` AS select `u`.`id_user` AS `id_user`,`s`.`nama_lengkap` AS `nama_lengkap`,`s`.`waktu_login` AS `waktu_login` from (`session_login` `s` join `user` `u` on((`u`.`nama_lengkap` = `s`.`nama_lengkap`))) where (`s`.`waktu_logout` is null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-30 16:03:55
