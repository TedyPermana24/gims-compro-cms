BEGIN;

CREATE OR REPLACE FUNCTION lexical_text(text_content text)
RETURNS jsonb
LANGUAGE plpgsql
IMMUTABLE
AS $$
BEGIN
  RETURN jsonb_build_object(
    'root',
    jsonb_build_object(
      'type', 'root',
      'children', COALESCE(
        (
          SELECT jsonb_agg(
            jsonb_build_object(
              'type', 'paragraph',
              'version', 1,
              'children', jsonb_build_array(
                jsonb_build_object(
                  'type', 'text',
                  'text', paragraph_text,
                  'version', 1,
                  'format', 0,
                  'detail', 0,
                  'mode', 'normal',
                  'style', ''
                )
              ),
              'direction', 'ltr',
              'format', '',
              'indent', 0,
              'version', 1
            )
          )
          FROM unnest(regexp_split_to_array(COALESCE(text_content, ''), E'\\n\\s*\\n')) AS t(paragraph_text)
        ),
        '[]'::jsonb
      ),
      'direction', 'ltr',
      'format', '',
      'indent', 0,
      'version', 1
    )
  );
END;
$$;

INSERT INTO media (
  id,
  alt,
  url,
  thumbnail_u_r_l,
  filename,
  mime_type,
  filesize,
  width,
  height,
  focal_x,
  focal_y,
  created_at,
  updated_at
) VALUES
  (1, 'Modern corporate office building — GiMS headquarters', '/media/hero-network.png', '/media/hero-network.png', 'hero-network.png', 'image/png', 1, 1200, 800, 50, 50, NOW(), NOW()),
  (2, 'GiMS modern data center facility', '/media/hero-server.png', '/media/hero-server.png', 'hero-server.png', 'image/png', 1, 1200, 800, 50, 50, NOW(), NOW()),
  (3, 'Technology growth and innovation', '/media/hero-cloud.png', '/media/hero-cloud.png', 'hero-cloud.png', 'image/png', 1, 1200, 800, 50, 50, NOW(), NOW()),
  (4, 'Cloud infrastructure illustration', '/media/cloud-infra.png', '/media/cloud-infra.png', 'cloud-infra.png', 'image/png', 1, 1200, 800, 50, 50, NOW(), NOW()),
  (5, 'Datacenter illustration', '/media/datacenter.png', '/media/datacenter.png', 'datacenter.png', 'image/png', 1, 1200, 800, 50, 50, NOW(), NOW()),
  (6, 'Fiber optic infrastructure', '/media/fiber-optic.png', '/media/fiber-optic.png', 'fiber-optic.png', 'image/png', 1, 1200, 800, 50, 50, NOW(), NOW()),
  (7, 'Vision and mission illustration', '/media/vision-mision.png', '/media/vision-mision.png', 'vision-mision.png', 'image/png', 1, 1200, 800, 50, 50, NOW(), NOW()),
  (8, 'Internet tower illustration', '/media/internet-tower.png', '/media/internet-tower.png', 'internet-tower.png', 'image/png', 1, 1200, 800, 50, 50, NOW(), NOW()),
  (9, 'Technology growth hero background', '/media/tech-growth.png', '/media/tech-growth.png', 'tech-growth.png', 'image/png', 1, 1200, 800, 50, 50, NOW(), NOW()),
  (10, 'GIMS Clean Pipe illustration', '/media/clean-pipe.png', '/media/clean-pipe.png', 'clean-pipe.png', 'image/png', 1, 1200, 800, 50, 50, NOW(), NOW()),
  (11, 'Internet connectivity illustration', '/media/internet-connectivity.png', '/media/internet-connectivity.png', 'internet-connectivity.png', 'image/png', 1, 1200, 800, 50, 50, NOW(), NOW()),
  (12, 'Network operations center illustration', '/media/network-noc.png', '/media/network-noc.png', 'network-noc.png', 'image/png', 1, 1200, 800, 50, 50, NOW(), NOW()),
  (13, 'Smart platform illustration', '/media/smart-platform.png', '/media/smart-platform.png', 'smart-platform.png', 'image/png', 1, 1200, 800, 50, 50, NOW(), NOW()),
  (14, 'Smart education illustration', '/media/smart-education.png', '/media/smart-education.png', 'smart-education.png', 'image/png', 1, 1200, 800, 50, 50, NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET
  alt = EXCLUDED.alt,
  url = EXCLUDED.url,
  thumbnail_u_r_l = EXCLUDED.thumbnail_u_r_l,
  filename = EXCLUDED.filename,
  mime_type = EXCLUDED.mime_type,
  filesize = EXCLUDED.filesize,
  width = EXCLUDED.width,
  height = EXCLUDED.height,
  focal_x = EXCLUDED.focal_x,
  focal_y = EXCLUDED.focal_y,
  updated_at = NOW();

INSERT INTO home_page_settings (
  id,
  judul,
  tentang_kami_judul,
  tentang_kami_deskripsi,
  tentang_kami_gambar_id,
  created_at,
  updated_at
) VALUES
  (1, 'Home', 'Tentang Kami', 'Penyedia layanan infrastruktur dan solusi teknologi terdepan untuk kebutuhan korporasi dan enterprise.', 4, NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET
  judul = EXCLUDED.judul,
  tentang_kami_judul = EXCLUDED.tentang_kami_judul,
  tentang_kami_deskripsi = EXCLUDED.tentang_kami_deskripsi,
  tentang_kami_gambar_id = EXCLUDED.tentang_kami_gambar_id,
  updated_at = NOW();

INSERT INTO home_page_settings_slides (_order, _parent_id, id, gambar_id, label, judul, deskripsi) VALUES
  (0, 1, 11, 1, 'PT. Global Inovasi Mitra Solusi', 'Penyedia Layanan Infrastruktur & Solusi Teknologi Terdepan', 'Berfokus pada penyediaan layanan Internet Service Provider (ISP), integrasi sistem, serta berbagai solusi teknologi informasi yang dirancang untuk memenuhi kebutuhan sektor korporasi dan enterprise.'),
  (1, 1, 12, 2, 'Infrastruktur Kelas Enterprise', 'Konektivitas Andal & Cepat untuk Bisnis Anda', 'Kami menyediakan layanan Dedicated Internet, Fiber Optic, hingga Cloud & Colocation yang dirancang untuk menjamin uptime dan performa bisnis Anda.'),
  (2, 1, 13, 3, 'Mitra Teknologi Terpercaya', 'Solusi Terintegrasi dari Jaringan hingga Cloud', 'Dari managed services, SD-WAN, hingga IT consulting. GiMS hadir sebagai mitra strategis yang mendukung transformasi digital perusahaan Anda.')
ON CONFLICT (id) DO UPDATE SET
  _order = EXCLUDED._order,
  _parent_id = EXCLUDED._parent_id,
  gambar_id = EXCLUDED.gambar_id,
  label = EXCLUDED.label,
  judul = EXCLUDED.judul,
  deskripsi = EXCLUDED.deskripsi;

INSERT INTO home_page_settings_layanan_di_home (_order, _parent_id, id, slug, judul, deskripsi, icon_name) VALUES
  (0, 1, 201, 'internet-connectivity', 'Internet Connectivity', 'Dedicated Internet, Broadband Internet, IP Transit, dan Virtual Private Network (VPN).', 'globe'),
  (1, 1, 202, 'fiber-connection', 'Fiber Connection', 'Solusi jaringan berbasis Fiber Optic melalui layanan Local Loop, Fiber Core, dan Data Feed IDX.', 'lightning'),
  (2, 1, 203, 'cloud-colocation', 'Cloud & Colocation', 'Fasilitas Co-Location berstandar tinggi, serta dukungan layanan Hosting & Mail Domain.', 'cloud'),
  (3, 1, 204, 'managed-services', 'Managed Services', 'IT Consulting, System Integrators (SI), Engineering On Site, hingga solusi Digital TV & IPTV.', 'settings'),
  (4, 1, 205, 'clean-pipe', 'GIMS Clean Pipe', 'Layanan keamanan internet terintegrasi untuk perlindungan maksimal dari ancaman serangan DDoS.', 'shield'),
  (5, 1, 206, 'smart-platform', 'Smart Platform', 'Solusi sistem digital dan informasi terintegrasi untuk sektor hospitality, retail, dan korporasi.', 'monitor-smartphone'),
  (6, 1, 207, 'smart-education', 'Smart Education', 'Platform sistem manajemen sekolah, komunikasi orang tua, dan pembelajaran cerdas berbasis IoT.', 'graduation-cap')
ON CONFLICT (id) DO UPDATE SET
  _order = EXCLUDED._order,
  _parent_id = EXCLUDED._parent_id,
  slug = EXCLUDED.slug,
  judul = EXCLUDED.judul,
  deskripsi = EXCLUDED.deskripsi,
  icon_name = EXCLUDED.icon_name;

INSERT INTO about_page_settings (
  id,
  judul,
  deskripsi_singkat,
  tentang_perusahaan_label,
  tentang_perusahaan_judul,
  tentang_perusahaan_gambar_utama_id,
  tentang_perusahaan_gambar_kanan_id,
  tentang_perusahaan_gambar_bawah_id,
  visi_misi_label,
  visi_misi_visi_deskripsi,
  visi_misi_gambar_id,
  nilai_inti_label,
  nilai_inti_deskripsi_singkat,
  mengapa_milih_gi_m_s_label,
  mengapa_milih_gi_m_s_judul,
  mengapa_milih_gi_m_s_deskripsi_singkat,
  mengapa_milih_gi_m_s_gambar_id,
  wilayah_jangkauan_label,
  wilayah_jangkauan_judul,
  wilayah_jangkauan_deskripsi,
  created_at,
  updated_at
) VALUES
  (2, 'About Us', 'Mitra teknologi terpercaya Anda untuk inovasi, kemitraan, dan solusi di era digital.', 'Company Profile', 'About Us', 4, 5, 6, 'Vision & Mission', 'Menjadi mitra strategis dan terpercaya dalam penyediaan layanan Internet dan solusi teknologi informasi yang berfokus pada kebutuhan pelanggan serta memberi nilai tambah bagi pertumbuhan bisnis.', 7, 'Core Values', 'Nilai-nilai inti yang membentuk identitas GiMS dan menjadi fondasi dalam setiap layanan kami.', 'Why Choose Us', 'Kenapa Memilih GiMS?', 'Kami hadir sebagai mitra teknologi terpercaya yang siap mendukung pertumbuhan bisnis Anda dengan layanan Internet dan solusi IT terbaik.', 8, 'Coverage', 'Jangkauan Nasional', 'GiMS terus memperluas jangkauan layanan infrastruktur teknologi informasi dan jaringan komunikasi di berbagai wilayah strategis Indonesia.', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET
  judul = EXCLUDED.judul,
  deskripsi_singkat = EXCLUDED.deskripsi_singkat,
  tentang_perusahaan_label = EXCLUDED.tentang_perusahaan_label,
  tentang_perusahaan_judul = EXCLUDED.tentang_perusahaan_judul,
  tentang_perusahaan_gambar_utama_id = EXCLUDED.tentang_perusahaan_gambar_utama_id,
  tentang_perusahaan_gambar_kanan_id = EXCLUDED.tentang_perusahaan_gambar_kanan_id,
  tentang_perusahaan_gambar_bawah_id = EXCLUDED.tentang_perusahaan_gambar_bawah_id,
  visi_misi_label = EXCLUDED.visi_misi_label,
  visi_misi_visi_deskripsi = EXCLUDED.visi_misi_visi_deskripsi,
  visi_misi_gambar_id = EXCLUDED.visi_misi_gambar_id,
  nilai_inti_label = EXCLUDED.nilai_inti_label,
  nilai_inti_deskripsi_singkat = EXCLUDED.nilai_inti_deskripsi_singkat,
  mengapa_milih_gi_m_s_label = EXCLUDED.mengapa_milih_gi_m_s_label,
  mengapa_milih_gi_m_s_judul = EXCLUDED.mengapa_milih_gi_m_s_judul,
  mengapa_milih_gi_m_s_deskripsi_singkat = EXCLUDED.mengapa_milih_gi_m_s_deskripsi_singkat,
  mengapa_milih_gi_m_s_gambar_id = EXCLUDED.mengapa_milih_gi_m_s_gambar_id,
  wilayah_jangkauan_label = EXCLUDED.wilayah_jangkauan_label,
  wilayah_jangkauan_judul = EXCLUDED.wilayah_jangkauan_judul,
  wilayah_jangkauan_deskripsi = EXCLUDED.wilayah_jangkauan_deskripsi,
  updated_at = NOW();

INSERT INTO about_page_settings_tentang_perusahaan_paragraf (_order, _parent_id, id, teks) VALUES
  (0, 2, 21, 'PT. Global Inovasi Mitra Solusi (GIMS) merupakan perusahaan yang bergerak di bidang solusi teknologi informasi dan infrastruktur jaringan telekomunikasi di Indonesia. Perusahaan ini berfokus pada penyediaan layanan Internet Service Provider (ISP), integrasi sistem, serta berbagai solusi teknologi informasi yang dirancang untuk memenuhi kebutuhan sektor korporasi dan enterprise.'),
  (1, 2, 22, 'Sejak awal berdirinya, GIMS berkomitmen untuk menghadirkan layanan teknologi yang modern, andal, dan terintegrasi. Perusahaan terus berkembang dengan memperluas kapabilitasnya dalam pembangunan infrastruktur jaringan, pengelolaan layanan teknologi, serta penyediaan solusi digital yang mendukung transformasi bisnis pelanggan.'),
  (2, 2, 23, 'Dalam perjalanan pengembangannya, GIMS telah menjalin kerja sama dengan berbagai mitra strategis di industri telekomunikasi dan teknologi informasi. Kolaborasi ini memungkinkan perusahaan untuk menghadirkan layanan yang lebih inovatif, efisien, dan berkelanjutan bagi berbagai sektor industri.')
ON CONFLICT (id) DO UPDATE SET _order = EXCLUDED._order, _parent_id = EXCLUDED._parent_id, teks = EXCLUDED.teks;

INSERT INTO about_page_settings_visi_misi_misi (_order, _parent_id, id, teks) VALUES
  (0, 2, 31, 'Memperluas jangkauan layanan internet dan teknologi, untuk mendukung konektivitas dan kemajuan digital di berbagai sektor.'),
  (1, 2, 32, 'Mendorong inovasi berkelanjutan dalam pengembangan teknologi, jaringan, dan solusi digital yang adaptif terhadap perkembangan zaman.'),
  (2, 2, 33, 'Menjadi mitra terpercaya bagi pelanggan dan bisnis, dengan membangun hubungan jangka panjang yang saling menguntungkan dan berorientasi pada kepuasan.'),
  (3, 2, 34, 'Memberikan solusi teknologi yang tepat guna dan terintegrasi, untuk mendukung efisiensi, produktivitas, dan transformasi digital pelanggan.'),
  (4, 2, 35, 'Mengembangkan sumber daya manusia yang kompeten di bidang IT, guna memberikan layanan profesional dan berkualitas tinggi.')
ON CONFLICT (id) DO UPDATE SET _order = EXCLUDED._order, _parent_id = EXCLUDED._parent_id, teks = EXCLUDED.teks;

INSERT INTO about_page_settings_nilai_inti_nilai_list (_order, _parent_id, id, huruf, judul, subtitle, deskripsi) VALUES
  (0, 2, 41, 'G', 'Global Excellence', 'Global', 'Menjalankan setiap aspek bisnis dengan standar terbaik, mengedepankan kualitas, profesionalisme, dan daya saing global dalam layanan serta solusi teknologi.'),
  (1, 2, 42, 'I', 'Innovative Growth', 'Inovasi', 'Mendorong inovasi berkelanjutan melalui pemanfaatan teknologi terkini untuk menciptakan solusi yang adaptif, relevan, dan bernilai tambah bagi pelanggan.'),
  (2, 2, 43, 'M', 'Strategic Partnership', 'Mitra', 'Membangun hubungan kemitraan yang kuat, terpercaya, dan berkelanjutan dengan pelanggan dan mitra bisnis sebagai fondasi pertumbuhan bersama.'),
  (3, 2, 44, 'S', 'Solution Driven', 'Solusi', 'Berorientasi pada penyelesaian kebutuhan pelanggan dengan pendekatan yang tepat, efektif, dan terintegrasi untuk memberikan hasil yang optimal.')
ON CONFLICT (id) DO UPDATE SET _order = EXCLUDED._order, _parent_id = EXCLUDED._parent_id, huruf = EXCLUDED.huruf, judul = EXCLUDED.judul, subtitle = EXCLUDED.subtitle, deskripsi = EXCLUDED.deskripsi;

INSERT INTO about_page_settings_mengapa_milih_gi_m_s_alasan_list (_order, _parent_id, id, kategori, subtitle, deskripsi) VALUES
  (0, 2, 51, 'Kualitas & Keamanan Layanan', 'Dapat Diandalkan', 'Memberikan jaminan SLA tinggi, dukungan purna jual yang responsif dan proaktif, serta penerapan keamanan data yang ketat untuk menjaga operasional dan informasi klien tetap aman.'),
  (1, 2, 52, 'Inovasi dan Adaptabilitas', 'Inovasi', 'Selalu mengikuti perkembangan teknologi terbaru seperti cloud computing, kecerdasan buatan (AI), dan menjalin kolaborasi global guna menghadirkan solusi yang modern dan efisien.'),
  (2, 2, 53, 'Komitmen pada Klien', 'Mitra', 'Mengutamakan pendekatan personal dengan solusi yang disesuaikan kebutuhan klien, serta membangun hubungan transparan dan kemitraan jangka panjang sebagai partner strategis.'),
  (3, 2, 54, 'Kompetensi SDM', 'Solusi', 'Berfokus pada solusi terintegrasi mulai dari konsultasi, implementasi, hingga layanan support untuk mendukung transformasi digital klien secara berkelanjutan.')
ON CONFLICT (id) DO UPDATE SET _order = EXCLUDED._order, _parent_id = EXCLUDED._parent_id, kategori = EXCLUDED.kategori, subtitle = EXCLUDED.subtitle, deskripsi = EXCLUDED.deskripsi;

INSERT INTO about_page_settings_wilayah_jangkauan_kota_list (_order, _parent_id, id, nama, latitude, longitude) VALUES
  (0, 2, 61, 'Medan', 3.59, 98.67),
  (1, 2, 62, 'Batam', 1.07, 104.03),
  (2, 2, 63, 'Jakarta', -6.21, 106.85),
  (3, 2, 64, 'Bandung', -6.91, 107.61),
  (4, 2, 65, 'Surabaya', -7.25, 112.75),
  (5, 2, 66, 'Bali', -8.65, 115.22),
  (6, 2, 67, 'Kalimantan', -0.157242, 113.864574),
  (7, 2, 68, 'Sulawesi', -2.279919, 120.112575)
ON CONFLICT (id) DO UPDATE SET _order = EXCLUDED._order, _parent_id = EXCLUDED._parent_id, nama = EXCLUDED.nama, latitude = EXCLUDED.latitude, longitude = EXCLUDED.longitude;

INSERT INTO product_page_settings (id, judul, deskripsi_singkat, created_at, updated_at) VALUES
  (3, 'Our Products', 'Berbagai solusi teknologi informasi dan jaringan yang dirancang untuk mendukung konektivitas, infrastruktur digital, serta operasional bisnis perusahaan secara optimal.', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET judul = EXCLUDED.judul, deskripsi_singkat = EXCLUDED.deskripsi_singkat, updated_at = NOW();

INSERT INTO product_page_settings_kategori_produk (_order, _parent_id, id, judul, gambar_id, alt_gambar, intro) VALUES
  (0, 3, 71, 'GIMS Clean Pipe', 10, 'GIMS Clean Pipe - Network Security', 'Layanan keamanan internet yang dirancang untuk membantu perusahaan berbasis ICT di Indonesia dalam menghadapi berbagai ancaman jaringan, termasuk serangan DDoS, sehingga operasional bisnis tetap berjalan dengan aman dan stabil.'),
  (1, 3, 72, 'Internet Connectivity', 11, 'Enterprise-grade core network routers and massive network switches providing high-speed internet connectivity', 'Kami menyediakan berbagai layanan konektivitas internet yang stabil dan berkinerja tinggi untuk mendukung operasional bisnis Anda, meliputi Dedicated Internet, Broadband Internet, IP Transit, Virtual Private Network (VPN), serta layanan tambahan seperti Add Service IP.'),
  (2, 3, 73, 'Fiber Connection', 6, 'High-speed fiber optic cables with glowing light transmission', 'GIMS menghadirkan solusi jaringan berbasis Fiber Optic yang cepat dan andal untuk kebutuhan komunikasi data berkapasitas tinggi, termasuk Local Loop, IP VPN, dan Fiber Core Network.'),
  (3, 3, 74, 'Cloud & Colocation', 4, 'Cloud computing infrastructure with interconnected server nodes', 'Untuk mendukung kebutuhan infrastruktur digital perusahaan, kami menyediakan layanan Cloud dan Colocation, termasuk hosting dan manajemen domain, layanan colocation server, serta konektivitas cloud exchange untuk integrasi dengan berbagai platform cloud.'),
  (4, 3, 75, 'Managed Services', 12, 'Network operations center with engineers monitoring IT infrastructure', 'Kami juga menyediakan layanan Managed Services yang membantu perusahaan dalam mengelola infrastruktur teknologi secara lebih efisien. Layanan ini meliputi IT Consulting, System Integration (SI), Technical Support On Demand, Engineering On Site (EOS), Add Service IP, SD-WAN, serta Direct Connectivity ke berbagai platform cloud.'),
  (5, 3, 76, 'Smart Platform', 13, 'Smart digital platform with interactive displays and centralized dashboard management in a modern hotel lobby', 'GIMS Smart Platform merupakan solusi digital terintegrasi yang dirancang untuk meningkatkan pengalaman pengguna, efisiensi operasional, serta nilai layanan pada berbagai sektor seperti hospitality, apartemen, retail, dan korporasi.'),
  (6, 3, 77, 'Smart Education', 14, 'Smart education classroom with academic dashboards, learning analytics, and digital learning technology', 'GIMS Smart Education adalah solusi digital terintegrasi yang dirancang untuk mendukung transformasi dunia pendidikan menuju sistem yang lebih modern, efisien, dan berbasis teknologi.')
ON CONFLICT (id) DO UPDATE SET _order = EXCLUDED._order, _parent_id = EXCLUDED._parent_id, judul = EXCLUDED.judul, gambar_id = EXCLUDED.gambar_id, alt_gambar = EXCLUDED.alt_gambar, intro = EXCLUDED.intro;

INSERT INTO product_page_settings_kategori_produk_produk_list (_order, _parent_id, id, nama, deskripsi) VALUES
  (0, 71, 711, 'Dedicated Internet', lexical_text('Layanan Dedicated Internet menyediakan bandwidth eksklusif yang memastikan koneksi internet lebih stabil, cepat, dan optimal. Dengan jalur khusus tanpa berbagi bandwidth, pengguna dapat menikmati performa upload dan download yang konsisten untuk mendukung aktivitas bisnis secara maksimal setiap saat.')),
  (1, 71, 712, 'Broadband Internet', lexical_text('Broadband Internet merupakan layanan internet yang efisien dan ekonomis tanpa mengurangi kualitas konektivitas. Tersedia berbagai pilihan paket yang fleksibel sesuai kebutuhan, sehingga menjadi solusi yang tepat untuk memenuhi kebutuhan akses internet Anda.')),
  (2, 71, 713, 'IP Transit', lexical_text('Layanan IP Transit memastikan ketersediaan rute jaringan dan alokasi bandwidth yang optimal sehingga menghadirkan konektivitas internet berkecepatan tinggi dengan biaya yang efisien. Jaringan kami terhubung langsung ke berbagai internet backbone dan internet exchange, sehingga mampu menyediakan jalur akses dengan latensi rendah ke berbagai platform populer. Layanan ini juga didukung dengan penggunaan Border Gateway Protocol (BGP) untuk pengelolaan rute jaringan.')),
  (3, 71, 714, 'Virtual Private Network (VPN)', lexical_text('Virtual Private Network (VPN) membantu perusahaan membangun koneksi jaringan yang aman antara kantor pusat dan cabang. Dengan teknologi VPN Access, perusahaan dapat meningkatkan efisiensi operasional, termasuk dalam komunikasi data, layanan telepon berbasis VoIP, hingga proses pengiriman data dan dokumen secara aman.')),
  (0, 73, 731, 'Local Loop', lexical_text('Menyediakan layanan konektivitas point-to-point maupun point-to-multipoint antar lokasi melalui jaringan eksklusif, sehingga menjamin pertukaran data yang aman, stabil, dan berkecepatan tinggi.')),
  (1, 73, 732, 'Fiber Core', lexical_text('Layanan Dark Fiber menghadirkan solusi menyeluruh untuk pengelolaan jaringan fiber optic tanpa perlu membangun dan mengelola infrastruktur secara mandiri. Kami mendukung mulai dari perancangan, implementasi, hingga pengelolaan jaringan, dengan konektivitas ke berbagai gedung, internet exchange, satellite teleport, ISP, dan NAP.')),
  (2, 73, 733, 'Data Feed IDX', lexical_text('Menyediakan akses konektivitas yang handal ke Bursa Efek Indonesia (IDX Datafeed) melalui infrastruktur jaringan berperforma tinggi, guna memastikan distribusi data pasar yang cepat, stabil, dan akurat.')),
  (0, 74, 741, 'Co-Location', lexical_text('Layanan Co-Location menyediakan fasilitas data center berstandar tinggi dengan dukungan bandwidth besar, infrastruktur unggulan, serta sistem keamanan yang terjamin. Solusi ini memungkinkan perusahaan untuk menempatkan server dan aplikasi secara optimal, sehingga meningkatkan efisiensi operasional dan keandalan akses data.')),
  (1, 74, 742, 'Hosting & Mail Domain', lexical_text('Kami menyediakan layanan web hosting dan domain untuk mendukung pengembangan website perusahaan secara profesional. Dilengkapi dengan fitur seperti cPanel, WHM, dan IP Public, layanan kami hadir dengan berbagai pilihan paket yang fleksibel sesuai kebutuhan bisnis Anda.')),
  (2, 74, 743, 'Our Co-Locations', lexical_text('Cyber 1\n\nIDC Duren 3\n\nMenara Tendean (MTEN)\n\nBersama Digital Data Center (BDDC)\n\nWisma BBU\n\nNeucentrix Telkom\n\nDCI Indonesia')),
  (0, 75, 751, 'IT Consulting', lexical_text('GIMS menghadirkan layanan audit dan evaluasi komprehensif untuk memetakan kondisi infrastruktur jaringan perusahaan Anda saat ini. Melalui identifikasi yang mendalam, kami membekali tenaga IT Anda dengan wawasan strategis untuk mengambil keputusan yang tepat dan mengoptimalkan performa jaringan.')),
  (1, 75, 752, 'System Integrators (SI)', lexical_text('GIMS berkomitmen menjadi mitra strategis dalam menyatukan berbagai subsistem komponen teknologi Anda ke dalam satu ekosistem yang terpadu dan efisien. Didukung oleh tim ahli yang berpengalaman, kami siap membantu perusahaan Anda menyelesaikan tantangan otomatisasi serta integrasi sistem dan aplikasi bisnis yang kompleks.')),
  (2, 75, 753, 'Engineering On Site (EOS)', lexical_text('GIMS menyediakan dukungan tenaga ahli melalui layanan teknisi dan engineer yang siap diterjunkan langsung ke lokasi. Layanan ini fleksibel untuk berbagai skala bisnis, mulai dari sektor perhotelan, perbankan, sekuritas, hingga industri minyak dan gas.')),
  (3, 75, 754, 'Direct Connectivity', lexical_text('Melalui solusi Direct Connect dari GIMS, infrastruktur jaringan internal Anda kini dapat terhubung secara privat ke platform cloud global seperti AWS, Azure, Zenlayer, hingga MS.O365. Hal ini menjamin transmisi data yang lebih aman, latensi rendah, serta akses penuh ke wilayah cloud publik maupun layanan khusus.')),
  (4, 75, 755, 'Add Service IP', lexical_text('Menanggapi tingginya permintaan akan IP Public di tengah keterbatasan stok global, GIMS hadir sebagai mitra penyedia layanan bagi sektor korporasi maupun telekomunikasi. Kami melayani jasa penyewaan IP Public serta memfasilitasi proses pendaftaran IP Public yang terdaftar secara resmi dan diakui oleh APNIC.')),
  (5, 75, 756, 'Digital TV', lexical_text('GIMS menghadirkan solusi perangkat dan layanan berbasis teknologi digital mutakhir untuk memberikan pengalaman menonton yang lebih berkualitas. Produk ini menawarkan kejernihan gambar dan suara superior, fitur interaktif yang cerdas, serta akses ke berbagai pilihan konten on-demand.')),
  (6, 75, 757, 'IPTV Solutions', lexical_text('Kami menawarkan cara modern dalam menikmati tayangan televisi melalui infrastruktur jaringan internet (IP). Layanan IPTV GIMS memberikan akses tanpa hambatan ke berbagai saluran TV siaran langsung serta koleksi video on-demand dengan kualitas tinggi yang stabil.')),
  (0, 76, 761, 'Customizable Interface', lexical_text('Tampilan home screen dapat disesuaikan secara fleksibel sesuai kebutuhan bisnis, mulai dari branding, informasi, hingga menu layanan utama, sehingga menciptakan pengalaman yang lebih personal dan profesional.')),
  (1, 76, 762, 'Centralized Dashboard Management', lexical_text('Sistem dilengkapi dengan dashboard terpusat yang memudahkan pengelolaan konten, monitoring, dan operasional secara real-time dengan antarmuka yang sederhana dan user-friendly.')),
  (2, 76, 763, 'Smart Guest Engagement', lexical_text('Menyediakan fitur interaktif seperti welcome greeting, informasi profil, promosi, hingga konten hiburan, yang mampu meningkatkan engagement dan pengalaman pengguna secara menyeluruh.')),
  (3, 76, 764, 'Dynamic Content & Information', lexical_text('Konten pada platform bersifat dinamis dan dapat diperbarui secara real-time, termasuk informasi cuaca, waktu, pesan berjalan, promosi, hingga informasi layanan.')),
  (4, 76, 765, 'Integration & Connectivity', lexical_text('Platform dapat terintegrasi dengan berbagai sistem seperti PMS, self-ordering system, WiFi access, hingga third-party services, sehingga mendukung ekosistem digital yang lebih luas.')),
  (5, 76, 766, 'Entertainment & Live Services', lexical_text('Menyediakan akses ke Live TV, aplikasi hiburan, serta informasi real-time seperti traffic CCTV, untuk memberikan pengalaman yang lebih modern dan informatif.')),
  (0, 77, 771, 'Integrated Academic System', lexical_text('Mengelola seluruh aktivitas akademik dalam satu platform, mulai dari data siswa, jadwal, nilai, kurikulum, hingga manajemen kelas secara terpusat dan terintegrasi.')),
  (1, 77, 772, 'Smart Attendance & Monitoring', lexical_text('Sistem absensi digital yang memungkinkan pemantauan kehadiran siswa secara real-time, baik oleh sekolah maupun orang tua.')),
  (2, 77, 773, 'Financial & Administration Management', lexical_text('Menyediakan fitur pengelolaan keuangan dan administrasi, termasuk pembayaran sekolah, laporan keuangan, dan pengelolaan data institusi secara efisien.')),
  (3, 77, 774, 'E-Learning & Digital Learning', lexical_text('Mendukung proses pembelajaran modern melalui platform e-learning, memungkinkan kegiatan belajar mengajar dilakukan secara fleksibel, baik offline maupun online.')),
  (4, 77, 775, 'Parent & Communication System', lexical_text('Menghubungkan sekolah dengan orang tua melalui sistem komunikasi langsung, sehingga orang tua dapat memantau perkembangan akademik, aktivitas, dan informasi penting siswa secara real-time.')),
  (5, 77, 776, 'Big Data & Reporting', lexical_text('Mengelola data pendidikan dalam skala besar (Big Data) untuk mendukung proses analisis, evaluasi, dan pengambilan keputusan yang lebih cepat dan akurat.'))
ON CONFLICT (id) DO UPDATE SET _order = EXCLUDED._order, _parent_id = EXCLUDED._parent_id, nama = EXCLUDED.nama, deskripsi = EXCLUDED.deskripsi;

COMMIT;
