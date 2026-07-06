BEGIN;

-- ============================================================
-- 1. Buat tabel general_settings (belum pernah di-migrate oleh Payload)
-- ============================================================
CREATE TABLE IF NOT EXISTS general_settings (
  id SERIAL PRIMARY KEY,
  nama_situs varchar NOT NULL DEFAULT 'GIMS',
  logo_id integer REFERENCES media(id) ON DELETE SET NULL,
  logo_footer_id integer REFERENCES media(id) ON DELETE SET NULL,
  whatsapp_nomor varchar DEFAULT '022 3050 2080',
  whatsapp_email varchar DEFAULT 'contact@gimsnet.co.id',
  whatsapp_teks_greeting varchar DEFAULT 'Halo GiMS! Saya ingin bertanya mengenai layanan Anda.',
  whatsapp_label_tombol varchar DEFAULT 'Apa yang bisa saya Bantu?',
  whatsapp_nama_perusahaan varchar DEFAULT 'PT. Global Inovasi Mitra Solusi',
  created_at timestamptz NOT NULL DEFAULT NOW(),
  updated_at timestamptz NOT NULL DEFAULT NOW()
);

-- Index untuk relasi
CREATE INDEX IF NOT EXISTS general_settings_logo_idx ON general_settings(logo_id);
CREATE INDEX IF NOT EXISTS general_settings_logo_footer_idx ON general_settings(logo_footer_id);

-- ============================================================
-- 2. Tambahkan kolom general_settings_id ke payload_locked_documents_rels
--    (Payload CMS membutuhkan ini untuk document locking)
-- ============================================================
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'payload_locked_documents_rels'
    AND column_name = 'general_settings_id'
  ) THEN
    ALTER TABLE payload_locked_documents_rels
      ADD COLUMN general_settings_id integer
      REFERENCES general_settings(id) ON DELETE CASCADE;

    CREATE INDEX payload_locked_documents_rels_general_settings_id_idx
      ON payload_locked_documents_rels(general_settings_id);
  END IF;
END
$$;

-- ============================================================
-- 2b. Tambahkan kolom whatsapp ke tabel yang sudah ada (jika upgrade)
-- ============================================================
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'general_settings'
    AND column_name = 'whatsapp_nomor'
  ) THEN
    ALTER TABLE general_settings
      ADD COLUMN whatsapp_nomor varchar DEFAULT '022 3050 2080',
      ADD COLUMN whatsapp_email varchar DEFAULT 'contact@gimsnet.co.id',
      ADD COLUMN whatsapp_teks_greeting varchar DEFAULT 'Halo GiMS! Saya ingin bertanya mengenai layanan Anda.',
      ADD COLUMN whatsapp_label_tombol varchar DEFAULT 'Apa yang bisa saya Bantu?',
      ADD COLUMN whatsapp_nama_perusahaan varchar DEFAULT 'PT. Global Inovasi Mitra Solusi';
  END IF;
END
$$;

-- ============================================================
-- 3. Insert data default general settings
-- ============================================================
INSERT INTO general_settings (
  id,
  nama_situs,
  logo_id,
  logo_footer_id,
  whatsapp_nomor,
  whatsapp_email,
  whatsapp_teks_greeting,
  whatsapp_label_tombol,
  whatsapp_nama_perusahaan,
  created_at,
  updated_at
) VALUES (
  1,
  'GIMS',
  NULL,
  NULL,
  '022 3050 2080',
  'contact@gimsnet.co.id',
  'Halo GiMS! Saya ingin bertanya mengenai layanan Anda.',
  'Apa yang bisa saya Bantu?',
  'PT. Global Inovasi Mitra Solusi',
  NOW(),
  NOW()
)
ON CONFLICT (id) DO UPDATE SET
  nama_situs = EXCLUDED.nama_situs,
  whatsapp_nomor = EXCLUDED.whatsapp_nomor,
  whatsapp_email = EXCLUDED.whatsapp_email,
  whatsapp_teks_greeting = EXCLUDED.whatsapp_teks_greeting,
  whatsapp_label_tombol = EXCLUDED.whatsapp_label_tombol,
  whatsapp_nama_perusahaan = EXCLUDED.whatsapp_nama_perusahaan,
  updated_at = NOW();

-- Reset sequence agar ID berikutnya benar
SELECT setval('general_settings_id_seq', COALESCE((SELECT MAX(id) FROM general_settings), 0) + 1, false);

COMMIT;
