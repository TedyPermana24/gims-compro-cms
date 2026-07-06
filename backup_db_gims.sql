--
-- PostgreSQL database dump
--

\restrict eCO1H85hhHEOX2yw2y3gY97EqKhrjRtUbEz5gcX40F5y8aGOqKmeNnTW1XKd6A3

-- Dumped from database version 16.14 (Ubuntu 16.14-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.14 (Ubuntu 16.14-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: enum_home_page_settings_layanan_di_home_icon_name; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_home_page_settings_layanan_di_home_icon_name AS ENUM (
    'shield',
    'globe',
    'zap',
    'cloud',
    'settings',
    'monitor-smartphone',
    'graduation-cap',
    'server',
    'database',
    'lock',
    'wifi',
    'cpu',
    'hard-drive',
    'router',
    'network',
    'smartphone',
    'laptop',
    'satellite',
    'radio',
    'signal',
    'gauge',
    'layers',
    'box',
    'briefcase',
    'lightning',
    'eye',
    'check-circle',
    'alert-circle',
    'info',
    'hexagon',
    'grid-3x3',
    'activity',
    'trending',
    'trending-up',
    'users',
    'user',
    'award',
    'star',
    'heart',
    'cable',
    'bar-chart',
    'bar-chart-3'
);


ALTER TYPE public.enum_home_page_settings_layanan_di_home_icon_name OWNER TO postgres;

--
-- Name: lexical_text(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.lexical_text(text_content text) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
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


ALTER FUNCTION public.lexical_text(text_content text) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: about_page_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.about_page_settings (
    id integer NOT NULL,
    judul character varying NOT NULL,
    deskripsi_singkat character varying NOT NULL,
    tentang_perusahaan_label character varying DEFAULT 'Company Profile'::character varying NOT NULL,
    tentang_perusahaan_judul character varying NOT NULL,
    tentang_perusahaan_gambar_utama_id integer NOT NULL,
    tentang_perusahaan_gambar_kanan_id integer NOT NULL,
    tentang_perusahaan_gambar_bawah_id integer NOT NULL,
    visi_misi_label character varying DEFAULT 'Vision & Mission'::character varying NOT NULL,
    visi_misi_visi_deskripsi character varying NOT NULL,
    visi_misi_gambar_id integer,
    nilai_inti_label character varying DEFAULT 'Core Values'::character varying NOT NULL,
    nilai_inti_deskripsi_singkat character varying,
    mengapa_milih_gi_m_s_label character varying DEFAULT 'Why Choose Us'::character varying NOT NULL,
    mengapa_milih_gi_m_s_judul character varying NOT NULL,
    mengapa_milih_gi_m_s_deskripsi_singkat character varying NOT NULL,
    mengapa_milih_gi_m_s_gambar_id integer NOT NULL,
    wilayah_jangkauan_label character varying DEFAULT 'Coverage'::character varying NOT NULL,
    wilayah_jangkauan_judul character varying DEFAULT 'Jangkauan Nasional'::character varying NOT NULL,
    wilayah_jangkauan_deskripsi character varying NOT NULL,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.about_page_settings OWNER TO postgres;

--
-- Name: about_page_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.about_page_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.about_page_settings_id_seq OWNER TO postgres;

--
-- Name: about_page_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.about_page_settings_id_seq OWNED BY public.about_page_settings.id;


--
-- Name: about_page_settings_mengapa_milih_gi_m_s_alasan_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.about_page_settings_mengapa_milih_gi_m_s_alasan_list (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL,
    kategori character varying NOT NULL,
    subtitle character varying NOT NULL,
    deskripsi character varying NOT NULL
);


ALTER TABLE public.about_page_settings_mengapa_milih_gi_m_s_alasan_list OWNER TO postgres;

--
-- Name: about_page_settings_nilai_inti_nilai_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.about_page_settings_nilai_inti_nilai_list (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL,
    huruf character varying NOT NULL,
    judul character varying NOT NULL,
    subtitle character varying NOT NULL,
    deskripsi character varying NOT NULL
);


ALTER TABLE public.about_page_settings_nilai_inti_nilai_list OWNER TO postgres;

--
-- Name: about_page_settings_tentang_perusahaan_paragraf; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.about_page_settings_tentang_perusahaan_paragraf (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL,
    teks character varying NOT NULL
);


ALTER TABLE public.about_page_settings_tentang_perusahaan_paragraf OWNER TO postgres;

--
-- Name: about_page_settings_visi_misi_misi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.about_page_settings_visi_misi_misi (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL,
    teks character varying NOT NULL
);


ALTER TABLE public.about_page_settings_visi_misi_misi OWNER TO postgres;

--
-- Name: about_page_settings_wilayah_jangkauan_kota_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.about_page_settings_wilayah_jangkauan_kota_list (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL,
    nama character varying NOT NULL,
    latitude numeric NOT NULL,
    longitude numeric NOT NULL
);


ALTER TABLE public.about_page_settings_wilayah_jangkauan_kota_list OWNER TO postgres;

--
-- Name: contact_page_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_page_settings (
    id integer NOT NULL,
    judul character varying NOT NULL,
    deskripsi_singkat character varying NOT NULL,
    kontak_info_alamat character varying NOT NULL,
    kontak_info_telepon character varying NOT NULL,
    kontak_info_email character varying NOT NULL,
    map_link character varying,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contact_page_settings OWNER TO postgres;

--
-- Name: contact_page_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contact_page_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contact_page_settings_id_seq OWNER TO postgres;

--
-- Name: contact_page_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contact_page_settings_id_seq OWNED BY public.contact_page_settings.id;


--
-- Name: general_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.general_settings (
    id integer NOT NULL,
    nama_situs character varying DEFAULT 'GIMS'::character varying NOT NULL,
    logo_id integer,
    logo_footer_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    whatsapp_nomor character varying DEFAULT '022 3050 2080'::character varying,
    whatsapp_email character varying DEFAULT 'contact@gimsnet.co.id'::character varying,
    whatsapp_teks_greeting character varying DEFAULT 'Halo GiMS! Saya ingin bertanya mengenai layanan Anda.'::character varying,
    whatsapp_label_tombol character varying DEFAULT 'Apa yang bisa saya Bantu?'::character varying,
    whatsapp_nama_perusahaan character varying DEFAULT 'PT. Global Inovasi Mitra Solusi'::character varying
);


ALTER TABLE public.general_settings OWNER TO postgres;

--
-- Name: general_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.general_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.general_settings_id_seq OWNER TO postgres;

--
-- Name: general_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.general_settings_id_seq OWNED BY public.general_settings.id;


--
-- Name: home_page_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.home_page_settings (
    id integer NOT NULL,
    judul character varying NOT NULL,
    tentang_kami_judul character varying NOT NULL,
    tentang_kami_deskripsi character varying NOT NULL,
    tentang_kami_gambar_id integer NOT NULL,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.home_page_settings OWNER TO postgres;

--
-- Name: home_page_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.home_page_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.home_page_settings_id_seq OWNER TO postgres;

--
-- Name: home_page_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.home_page_settings_id_seq OWNED BY public.home_page_settings.id;


--
-- Name: home_page_settings_layanan_di_home; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.home_page_settings_layanan_di_home (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL,
    slug character varying NOT NULL,
    judul character varying NOT NULL,
    deskripsi character varying NOT NULL,
    icon_name public.enum_home_page_settings_layanan_di_home_icon_name NOT NULL
);


ALTER TABLE public.home_page_settings_layanan_di_home OWNER TO postgres;

--
-- Name: home_page_settings_slides; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.home_page_settings_slides (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL,
    gambar_id integer NOT NULL,
    label character varying NOT NULL,
    judul character varying NOT NULL,
    deskripsi character varying NOT NULL
);


ALTER TABLE public.home_page_settings_slides OWNER TO postgres;

--
-- Name: media; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.media (
    id integer NOT NULL,
    alt character varying NOT NULL,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    url character varying,
    thumbnail_u_r_l character varying,
    filename character varying,
    mime_type character varying,
    filesize numeric,
    width numeric,
    height numeric,
    focal_x numeric,
    focal_y numeric
);


ALTER TABLE public.media OWNER TO postgres;

--
-- Name: media_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.media_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.media_id_seq OWNER TO postgres;

--
-- Name: media_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.media_id_seq OWNED BY public.media.id;


--
-- Name: payload_kv; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payload_kv (
    id integer NOT NULL,
    key character varying NOT NULL,
    data jsonb NOT NULL
);


ALTER TABLE public.payload_kv OWNER TO postgres;

--
-- Name: payload_kv_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payload_kv_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payload_kv_id_seq OWNER TO postgres;

--
-- Name: payload_kv_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payload_kv_id_seq OWNED BY public.payload_kv.id;


--
-- Name: payload_locked_documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payload_locked_documents (
    id integer NOT NULL,
    global_slug character varying,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.payload_locked_documents OWNER TO postgres;

--
-- Name: payload_locked_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payload_locked_documents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payload_locked_documents_id_seq OWNER TO postgres;

--
-- Name: payload_locked_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payload_locked_documents_id_seq OWNED BY public.payload_locked_documents.id;


--
-- Name: payload_locked_documents_rels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payload_locked_documents_rels (
    id integer NOT NULL,
    "order" integer,
    parent_id integer NOT NULL,
    path character varying NOT NULL,
    users_id integer,
    media_id integer,
    home_page_settings_id integer,
    about_page_settings_id integer,
    product_page_settings_id integer,
    contact_page_settings_id integer,
    general_settings_id integer
);


ALTER TABLE public.payload_locked_documents_rels OWNER TO postgres;

--
-- Name: payload_locked_documents_rels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payload_locked_documents_rels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payload_locked_documents_rels_id_seq OWNER TO postgres;

--
-- Name: payload_locked_documents_rels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payload_locked_documents_rels_id_seq OWNED BY public.payload_locked_documents_rels.id;


--
-- Name: payload_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payload_migrations (
    id integer NOT NULL,
    name character varying,
    batch numeric,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.payload_migrations OWNER TO postgres;

--
-- Name: payload_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payload_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payload_migrations_id_seq OWNER TO postgres;

--
-- Name: payload_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payload_migrations_id_seq OWNED BY public.payload_migrations.id;


--
-- Name: payload_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payload_preferences (
    id integer NOT NULL,
    key character varying,
    value jsonb,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.payload_preferences OWNER TO postgres;

--
-- Name: payload_preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payload_preferences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payload_preferences_id_seq OWNER TO postgres;

--
-- Name: payload_preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payload_preferences_id_seq OWNED BY public.payload_preferences.id;


--
-- Name: payload_preferences_rels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payload_preferences_rels (
    id integer NOT NULL,
    "order" integer,
    parent_id integer NOT NULL,
    path character varying NOT NULL,
    users_id integer
);


ALTER TABLE public.payload_preferences_rels OWNER TO postgres;

--
-- Name: payload_preferences_rels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payload_preferences_rels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payload_preferences_rels_id_seq OWNER TO postgres;

--
-- Name: payload_preferences_rels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payload_preferences_rels_id_seq OWNED BY public.payload_preferences_rels.id;


--
-- Name: product_page_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_page_settings (
    id integer NOT NULL,
    judul character varying NOT NULL,
    deskripsi_singkat character varying NOT NULL,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.product_page_settings OWNER TO postgres;

--
-- Name: product_page_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_page_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_page_settings_id_seq OWNER TO postgres;

--
-- Name: product_page_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_page_settings_id_seq OWNED BY public.product_page_settings.id;


--
-- Name: product_page_settings_kategori_produk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_page_settings_kategori_produk (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL,
    judul character varying NOT NULL,
    gambar_id integer NOT NULL,
    alt_gambar character varying NOT NULL,
    intro character varying NOT NULL
);


ALTER TABLE public.product_page_settings_kategori_produk OWNER TO postgres;

--
-- Name: product_page_settings_kategori_produk_produk_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_page_settings_kategori_produk_produk_list (
    _order integer NOT NULL,
    _parent_id character varying NOT NULL,
    id character varying NOT NULL,
    nama character varying NOT NULL,
    deskripsi jsonb NOT NULL,
    tampilkan_keranjang boolean DEFAULT false
);


ALTER TABLE public.product_page_settings_kategori_produk_produk_list OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    email character varying NOT NULL,
    reset_password_token character varying,
    reset_password_expiration timestamp(3) with time zone,
    salt character varying,
    hash character varying,
    login_attempts numeric DEFAULT 0,
    lock_until timestamp(3) with time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_sessions (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL,
    created_at timestamp(3) with time zone,
    expires_at timestamp(3) with time zone NOT NULL
);


ALTER TABLE public.users_sessions OWNER TO postgres;

--
-- Name: about_page_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.about_page_settings ALTER COLUMN id SET DEFAULT nextval('public.about_page_settings_id_seq'::regclass);


--
-- Name: contact_page_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_page_settings ALTER COLUMN id SET DEFAULT nextval('public.contact_page_settings_id_seq'::regclass);


--
-- Name: general_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.general_settings ALTER COLUMN id SET DEFAULT nextval('public.general_settings_id_seq'::regclass);


--
-- Name: home_page_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.home_page_settings ALTER COLUMN id SET DEFAULT nextval('public.home_page_settings_id_seq'::regclass);


--
-- Name: media id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media ALTER COLUMN id SET DEFAULT nextval('public.media_id_seq'::regclass);


--
-- Name: payload_kv id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_kv ALTER COLUMN id SET DEFAULT nextval('public.payload_kv_id_seq'::regclass);


--
-- Name: payload_locked_documents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_locked_documents ALTER COLUMN id SET DEFAULT nextval('public.payload_locked_documents_id_seq'::regclass);


--
-- Name: payload_locked_documents_rels id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_locked_documents_rels ALTER COLUMN id SET DEFAULT nextval('public.payload_locked_documents_rels_id_seq'::regclass);


--
-- Name: payload_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_migrations ALTER COLUMN id SET DEFAULT nextval('public.payload_migrations_id_seq'::regclass);


--
-- Name: payload_preferences id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_preferences ALTER COLUMN id SET DEFAULT nextval('public.payload_preferences_id_seq'::regclass);


--
-- Name: payload_preferences_rels id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_preferences_rels ALTER COLUMN id SET DEFAULT nextval('public.payload_preferences_rels_id_seq'::regclass);


--
-- Name: product_page_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_page_settings ALTER COLUMN id SET DEFAULT nextval('public.product_page_settings_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: about_page_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.about_page_settings (id, judul, deskripsi_singkat, tentang_perusahaan_label, tentang_perusahaan_judul, tentang_perusahaan_gambar_utama_id, tentang_perusahaan_gambar_kanan_id, tentang_perusahaan_gambar_bawah_id, visi_misi_label, visi_misi_visi_deskripsi, visi_misi_gambar_id, nilai_inti_label, nilai_inti_deskripsi_singkat, mengapa_milih_gi_m_s_label, mengapa_milih_gi_m_s_judul, mengapa_milih_gi_m_s_deskripsi_singkat, mengapa_milih_gi_m_s_gambar_id, wilayah_jangkauan_label, wilayah_jangkauan_judul, wilayah_jangkauan_deskripsi, updated_at, created_at) FROM stdin;
2	About Us	Mitra teknologi terpercaya Anda untuk inovasi, kemitraan, dan solusi di era digital.	About Us	Tentang Kami	4	5	6	Vision & Mission	Menjadi mitra strategis dan terpercaya dalam penyediaan layanan Internet dan solusi teknologi informasi yang berfokus pada kebutuhan pelanggan serta memberi nilai tambah bagi pertumbuhan bisnis.	7	Core Values	Nilai-nilai inti yang membentuk identitas GiMS dan menjadi fondasi dalam setiap layanan kami.	Why Choose Us	Kenapa Memilih GiMS?	Kami hadir sebagai mitra teknologi terpercaya yang siap mendukung pertumbuhan bisnis Anda dengan layanan Internet dan solusi IT terbaik.	8	Coverage	Jangkauan Nasional	GiMS terus memperluas jangkauan layanan infrastruktur teknologi informasi dan jaringan komunikasi di berbagai wilayah strategis Indonesia.	2026-05-22 02:47:18.666+00	2026-05-21 15:47:23.787+00
\.


--
-- Data for Name: about_page_settings_mengapa_milih_gi_m_s_alasan_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.about_page_settings_mengapa_milih_gi_m_s_alasan_list (_order, _parent_id, id, kategori, subtitle, deskripsi) FROM stdin;
1	2	51	Kualitas & Keamanan Layanan	Dapat Diandalkan	Memberikan jaminan SLA tinggi, dukungan purna jual yang responsif dan proaktif, serta penerapan keamanan data yang ketat untuk menjaga operasional dan informasi klien tetap aman.
2	2	52	Inovasi dan Adaptabilitas	Inovasi	Selalu mengikuti perkembangan teknologi terbaru seperti cloud computing, kecerdasan buatan (AI), dan menjalin kolaborasi global guna menghadirkan solusi yang modern dan efisien.
3	2	53	Komitmen pada Klien	Mitra	Mengutamakan pendekatan personal dengan solusi yang disesuaikan kebutuhan klien, serta membangun hubungan transparan dan kemitraan jangka panjang sebagai partner strategis.
4	2	54	Kompetensi SDM	Solusi	Berfokus pada solusi terintegrasi mulai dari konsultasi, implementasi, hingga layanan support untuk mendukung transformasi digital klien secara berkelanjutan.
\.


--
-- Data for Name: about_page_settings_nilai_inti_nilai_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.about_page_settings_nilai_inti_nilai_list (_order, _parent_id, id, huruf, judul, subtitle, deskripsi) FROM stdin;
1	2	41	G	Global Excellence	Global	Menjalankan setiap aspek bisnis dengan standar terbaik, mengedepankan kualitas, profesionalisme, dan daya saing global dalam layanan serta solusi teknologi.
2	2	42	I	Innovative Growth	Inovasi	Mendorong inovasi berkelanjutan melalui pemanfaatan teknologi terkini untuk menciptakan solusi yang adaptif, relevan, dan bernilai tambah bagi pelanggan.
3	2	43	M	Strategic Partnership	Mitra	Membangun hubungan kemitraan yang kuat, terpercaya, dan berkelanjutan dengan pelanggan dan mitra bisnis sebagai fondasi pertumbuhan bersama.
4	2	44	S	Solution Driven	Solusi	Berorientasi pada penyelesaian kebutuhan pelanggan dengan pendekatan yang tepat, efektif, dan terintegrasi untuk memberikan hasil yang optimal.
\.


--
-- Data for Name: about_page_settings_tentang_perusahaan_paragraf; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.about_page_settings_tentang_perusahaan_paragraf (_order, _parent_id, id, teks) FROM stdin;
1	2	21	PT. Global Inovasi Mitra Solusi (GIMS) merupakan perusahaan yang bergerak di bidang solusi teknologi informasi dan infrastruktur jaringan telekomunikasi di Indonesia. Perusahaan ini berfokus pada penyediaan layanan Internet Service Provider (ISP), integrasi sistem, serta berbagai solusi teknologi informasi yang dirancang untuk memenuhi kebutuhan sektor korporasi dan enterprise.
2	2	22	Sejak awal berdirinya, GIMS berkomitmen untuk menghadirkan layanan teknologi yang modern, andal, dan terintegrasi. Perusahaan terus berkembang dengan memperluas kapabilitasnya dalam pembangunan infrastruktur jaringan, pengelolaan layanan teknologi, serta penyediaan solusi digital yang mendukung transformasi bisnis pelanggan.
3	2	23	Dalam perjalanan pengembangannya, GIMS telah menjalin kerja sama dengan berbagai mitra strategis di industri telekomunikasi dan teknologi informasi. Kolaborasi ini memungkinkan perusahaan untuk menghadirkan layanan yang lebih inovatif, efisien, dan berkelanjutan bagi berbagai sektor industri.
\.


--
-- Data for Name: about_page_settings_visi_misi_misi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.about_page_settings_visi_misi_misi (_order, _parent_id, id, teks) FROM stdin;
1	2	31	Memperluas jangkauan layanan internet dan teknologi, untuk mendukung konektivitas dan kemajuan digital di berbagai sektor.
2	2	32	Mendorong inovasi berkelanjutan dalam pengembangan teknologi, jaringan, dan solusi digital yang adaptif terhadap perkembangan zaman.
3	2	33	Menjadi mitra terpercaya bagi pelanggan dan bisnis, dengan membangun hubungan jangka panjang yang saling menguntungkan dan berorientasi pada kepuasan.
4	2	34	Memberikan solusi teknologi yang tepat guna dan terintegrasi, untuk mendukung efisiensi, produktivitas, dan transformasi digital pelanggan.
5	2	35	Mengembangkan sumber daya manusia yang kompeten di bidang IT, guna memberikan layanan profesional dan berkualitas tinggi.
\.


--
-- Data for Name: about_page_settings_wilayah_jangkauan_kota_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.about_page_settings_wilayah_jangkauan_kota_list (_order, _parent_id, id, nama, latitude, longitude) FROM stdin;
1	2	61	Medan	3.59	98.67
2	2	62	Batam	1.07	104.03
3	2	63	Jakarta	-6.21	106.85
4	2	64	Bandung	-6.91	107.61
5	2	65	Surabaya	-7.25	112.75
6	2	66	Bali	-8.65	115.22
7	2	67	Kalimantan	-0.157242	113.864574
8	2	68	Sulawesi	-2.279919	120.112575
\.


--
-- Data for Name: contact_page_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contact_page_settings (id, judul, deskripsi_singkat, kontak_info_alamat, kontak_info_telepon, kontak_info_email, map_link, updated_at, created_at) FROM stdin;
2	Contact	Hubungi kami untuk konsultasi mengenai kebutuhan teknologi bisnis Anda.	Jl. Taman Kopo Indah 1 M27, Bandung, Jawa Barat, Indonesia	02230502080	contact@gimsnet.co.id	https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3960.6!2d107.57!3d-6.96!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zNsKwNTcnMzYuMCJTIDEwN8KwMzQnMTIuMCJF!5e0!3m2!1sid!2sid!4v1	2026-07-06 07:07:16.376+00	2026-05-21 15:47:23.787+00
\.


--
-- Data for Name: general_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.general_settings (id, nama_situs, logo_id, logo_footer_id, created_at, updated_at, whatsapp_nomor, whatsapp_email, whatsapp_teks_greeting, whatsapp_label_tombol, whatsapp_nama_perusahaan) FROM stdin;
1	GIMS	17	17	2026-06-11 15:38:53.086+00	2026-07-06 02:13:55.644+00	081511111033	contact@gimsnet.co.id	Halo GiMS! Saya ingin bertanya mengenai layanan Anda.	Apa yang bisa saya Bantu?	PT. Global Inovasi Mitra Solusi
\.


--
-- Data for Name: home_page_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.home_page_settings (id, judul, tentang_kami_judul, tentang_kami_deskripsi, tentang_kami_gambar_id, updated_at, created_at) FROM stdin;
1	Home	Solusi Teknologi Informasi & Infrastruktur Jaringan Telekomunikasi	PT. Global Inovasi Mitra Solusi (GIMS) merupakan perusahaan yang bergerak di bidang solusi teknologi informasi dan infrastruktur jaringan telekomunikasi di Indonesia, berfokus pada penyediaan layanan Internet Service Provider (ISP), integrasi sistem, serta berbagai solusi teknologi informasi.\n\nSejak awal berdirinya, GIMS berkomitmen untuk menghadirkan layanan teknologi yang modern, andal, dan terintegrasi untuk memenuhi kebutuhan sektor korporasi dan enterprise.	16	2026-06-19 02:23:53.167+00	2026-05-21 15:47:23.787+00
\.


--
-- Data for Name: home_page_settings_layanan_di_home; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.home_page_settings_layanan_di_home (_order, _parent_id, id, slug, judul, deskripsi, icon_name) FROM stdin;
1	1	201	internet-connectivity	Internet Connectivity	Dedicated Internet, Broadband Internet, IP Transit, dan Virtual Private Network (VPN).	globe
2	1	202	fiber-connection	Fiber Connection	Solusi jaringan berbasis Fiber Optic melalui layanan Local Loop, Fiber Core, dan Data Feed IDX.	lightning
3	1	203	cloud-colocation	Cloud & Colocation	Fasilitas Co-Location berstandar tinggi, serta dukungan layanan Hosting & Mail Domain.	cloud
4	1	204	managed-services	Managed Services	IT Consulting, System Integrators (SI), Engineering On Site, hingga solusi Digital TV & IPTV.	settings
5	1	205	clean-pipe	GIMS Clean Pipe	Layanan keamanan internet terintegrasi untuk perlindungan maksimal dari ancaman serangan DDoS.	shield
6	1	206	smart-platform	Smart Platform	Solusi sistem digital dan informasi terintegrasi untuk sektor hospitality, retail, dan korporasi.	monitor-smartphone
7	1	207	smart-education	Smart Education	Platform sistem manajemen sekolah, komunikasi orang tua, dan pembelajaran cerdas berbasis IoT.	graduation-cap
\.


--
-- Data for Name: home_page_settings_slides; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.home_page_settings_slides (_order, _parent_id, id, gambar_id, label, judul, deskripsi) FROM stdin;
1	1	11	1	PT. Global Inovasi Mitra Solusi	Penyedia Layanan Infrastruktur & Solusi Teknologi Terdepan	Berfokus pada penyediaan layanan Internet Service Provider (ISP), integrasi sistem, serta berbagai solusi teknologi informasi yang dirancang untuk memenuhi kebutuhan sektor korporasi dan enterprise.
2	1	12	2	Infrastruktur Kelas Enterprise	Konektivitas Andal & Cepat untuk Bisnis Anda	Kami menyediakan layanan Dedicated Internet, Fiber Optic, hingga Cloud & Colocation yang dirancang untuk menjamin uptime dan performa bisnis Anda.
3	1	13	3	Mitra Teknologi Terpercaya	Solusi Terintegrasi dari Jaringan hingga Cloud	Dari managed services, SD-WAN, hingga IT consulting. GiMS hadir sebagai mitra strategis yang mendukung transformasi digital perusahaan Anda.
\.


--
-- Data for Name: media; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.media (id, alt, updated_at, created_at, url, thumbnail_u_r_l, filename, mime_type, filesize, width, height, focal_x, focal_y) FROM stdin;
7	Vision and mission illustration	2026-05-21 15:47:23.787+00	2026-05-21 15:47:23.787+00	/media/vision-mision.png	/media/vision-mision.png	vision-mision.png	image/png	1	1200	800	50	50
9	Technology growth hero background	2026-05-21 15:47:23.787+00	2026-05-21 15:47:23.787+00	/media/tech-growth.png	/media/tech-growth.png	tech-growth.png	image/png	1	1200	800	50	50
1	Modern corporate office building — GiMS headquarters	2026-06-14 14:30:54.773+00	2026-05-21 15:47:23.787+00	/api/media/file/HOME-IMAGE-1.jpg	\N	HOME-IMAGE-1.jpg	image/jpeg	758221	2480	1600	50	50
2	GiMS modern data center facility	2026-06-14 14:32:47.315+00	2026-05-21 15:47:23.787+00	/api/media/file/HOME-IMAGE-2.jpg	\N	HOME-IMAGE-2.jpg	image/jpeg	834953	2480	1600	50	50
3	Technology growth and innovation	2026-06-14 14:33:48.078+00	2026-05-21 15:47:23.787+00	/api/media/file/HOME-IMAGE-3.jpg	\N	HOME-IMAGE-3.jpg	image/jpeg	772101	2480	1600	50	50
5	Datacenter illustration	2026-06-14 14:40:57.692+00	2026-05-21 15:47:23.787+00	/api/media/file/ABOUT-US-IMAGE-2.jpg	\N	ABOUT-US-IMAGE-2.jpg	image/jpeg	251545	1024	1024	50	50
6	Fiber optic infrastructure	2026-06-14 14:41:22.487+00	2026-05-21 15:47:23.787+00	/api/media/file/ABOUT-US-IMAGE-3.jpg	\N	ABOUT-US-IMAGE-3.jpg	image/jpeg	204829	1024	1024	50	50
4	Cloud infrastructure illustration	2026-06-14 14:42:29.031+00	2026-05-21 15:47:23.787+00	/api/media/file/ABOUT-US-IMAGE-1.jpg	\N	ABOUT-US-IMAGE-1.jpg	image/jpeg	231027	1024	1024	50	50
8	Internet tower illustration	2026-06-14 14:50:51.491+00	2026-05-21 15:47:23.787+00	/api/media/file/ABOUT-US-IMAGE-4.jpg	\N	ABOUT-US-IMAGE-4.jpg	image/jpeg	312945	1024	1024	50	50
10	GIMS Clean Pipe illustration	2026-06-14 14:56:28.702+00	2026-05-21 15:47:23.787+00	/api/media/file/OUR-PRODUCT-IMAGE-1.jpg	\N	OUR-PRODUCT-IMAGE-1.jpg	image/jpeg	376651	1024	1024	50	50
11	Internet connectivity illustration	2026-06-14 14:56:51.646+00	2026-05-21 15:47:23.787+00	/api/media/file/OUR-PRODUCT-IMAGE-2.jpg	\N	OUR-PRODUCT-IMAGE-2.jpg	image/jpeg	454618	1024	1024	50	50
12	Network operations center illustration	2026-06-14 14:57:55.159+00	2026-05-21 15:47:23.787+00	/api/media/file/OUR-PRODUCT-IMAGE-4.jpg	\N	OUR-PRODUCT-IMAGE-4.jpg	image/jpeg	183977	1024	1024	50	50
13	Smart platform illustration	2026-06-14 14:58:16.94+00	2026-05-21 15:47:23.787+00	/api/media/file/OUR-PRODUCT-IMAGE-5.jpg	\N	OUR-PRODUCT-IMAGE-5.jpg	image/jpeg	266472	1024	1024	50	50
14	Smart education illustration	2026-06-14 14:58:38.639+00	2026-05-21 15:47:23.787+00	/api/media/file/OUR-PRODUCT-IMAGE-6.jpg	\N	OUR-PRODUCT-IMAGE-6.jpg	image/jpeg	329923	1024	1024	50	50
15	GIMS	2026-06-16 08:46:17.224+00	2026-06-11 16:03:41.828+00	/api/media/file/OUR-PRODUCT-IMAGE-3.jpg	\N	OUR-PRODUCT-IMAGE-3.jpg	image/jpeg	408969	1024	1024	50	50
16	test	2026-06-16 08:53:14.762+00	2026-06-16 02:43:20.478+00	/api/media/file/HOME%20IMAGE%202-1.jpg	\N	HOME IMAGE 2-1.jpg	image/jpeg	313145	1024	1024	50	50
17	LOGO-GIMS-HORISONTAL.png	2026-06-19 02:20:47.834+00	2026-06-19 02:20:47.834+00	/api/media/file/LOGO-GIMS-HORISONTAL.png	\N	LOGO-GIMS-HORISONTAL.png	image/png	69333	1456	512	50	50
\.


--
-- Data for Name: payload_kv; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payload_kv (id, key, data) FROM stdin;
\.


--
-- Data for Name: payload_locked_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payload_locked_documents (id, global_slug, updated_at, created_at) FROM stdin;
\.


--
-- Data for Name: payload_locked_documents_rels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payload_locked_documents_rels (id, "order", parent_id, path, users_id, media_id, home_page_settings_id, about_page_settings_id, product_page_settings_id, contact_page_settings_id, general_settings_id) FROM stdin;
\.


--
-- Data for Name: payload_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payload_migrations (id, name, batch, updated_at, created_at) FROM stdin;
1	dev	-1	2026-05-21 15:43:21.619+00	2026-05-21 13:52:55.615+00
\.


--
-- Data for Name: payload_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payload_preferences (id, key, value, updated_at, created_at) FROM stdin;
1	collection-users	{}	2026-05-21 13:56:21.288+00	2026-05-21 13:56:21.287+00
5	collection-product-page-settings	{}	2026-05-21 15:47:57.391+00	2026-05-21 15:47:57.391+00
6	collection-contact-page-settings	{}	2026-05-21 15:47:58.489+00	2026-05-21 15:47:58.489+00
3	collection-home-page-settings	{"limit": 10}	2026-05-21 15:57:17.592+00	2026-05-21 15:47:32.177+00
4	collection-about-page-settings	{"limit": 10}	2026-05-21 15:57:25.385+00	2026-05-21 15:47:47.395+00
2	collection-media	{"limit": 10}	2026-05-26 01:46:44.194+00	2026-05-21 13:56:23.436+00
9	collection-general-settings	{"limit": 10}	2026-06-11 15:03:22.053+00	2026-06-11 14:59:43.113+00
7	collection-product-page-settings-3	{"fields": {"kategoriProduk": {"collapsed": ["Internet Connectivity", "Cloud & Colocation", "Managed Services", "Smart Platform", "Smart Education"]}, "kategoriProduk.1.produkList": {"collapsed": ["6a0fc333f9bd9378cef0bb3a"]}}}	2026-07-06 04:30:40.262+00	2026-05-22 02:45:20.824+00
8	nav	{"open": true}	2026-07-06 07:05:00.174+00	2026-05-26 02:08:55.817+00
\.


--
-- Data for Name: payload_preferences_rels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payload_preferences_rels (id, "order", parent_id, path, users_id) FROM stdin;
1	\N	1	user	1
5	\N	5	user	1
6	\N	6	user	1
7	\N	3	user	1
8	\N	4	user	1
12	\N	2	user	1
17	\N	9	user	1
33	\N	7	user	1
37	\N	8	user	1
\.


--
-- Data for Name: product_page_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_page_settings (id, judul, deskripsi_singkat, updated_at, created_at) FROM stdin;
3	Our Products	Berbagai solusi teknologi informasi dan jaringan yang dirancang untuk mendukung konektivitas, infrastruktur digital, serta operasional bisnis perusahaan secara optimal.	2026-07-06 04:30:47.139+00	2026-05-21 15:47:23.787+00
\.


--
-- Data for Name: product_page_settings_kategori_produk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_page_settings_kategori_produk (_order, _parent_id, id, judul, gambar_id, alt_gambar, intro) FROM stdin;
1	3	GIMS Clean Pipe	GIMS Clean Pipe	10	GIMS Clean Pipe - Network Security	Layanan keamanan internet yang dirancang untuk membantu perusahaan berbasis ICT di Indonesia dalam menghadapi berbagai ancaman jaringan, termasuk serangan DDoS, sehingga operasional bisnis tetap berjalan dengan aman dan stabil.
2	3	Internet Connectivity	Internet Connectivity	11	Enterprise-grade core network routers and massive network switches providing high-speed internet connectivity	Kami menyediakan berbagai layanan konektivitas internet yang stabil dan berkinerja tinggi untuk mendukung operasional bisnis Anda, meliputi Dedicated Internet, Broadband Internet, IP Transit, Virtual Private Network (VPN), serta layanan tambahan seperti Add Service IP.
3	3	Cloud & Colocation	Cloud & Colocation	15	Cloud computing infrastructure with interconnected server nodes	Untuk mendukung kebutuhan infrastruktur digital perusahaan, kami menyediakan layanan Cloud dan Colocation, termasuk hosting dan manajemen domain, layanan colocation server, serta konektivitas cloud exchange untuk integrasi dengan berbagai platform cloud.
4	3	Managed Services	Managed Services	12	Network operations center with engineers monitoring IT infrastructure	Kami juga menyediakan layanan Managed Services yang membantu perusahaan dalam mengelola infrastruktur teknologi secara lebih efisien. Layanan ini meliputi IT Consulting, System Integration (SI), Technical Support On Demand, Engineering On Site (EOS), Add Service IP, SD-WAN, serta Direct Connectivity ke berbagai platform cloud.
5	3	Smart Platform	Smart Platform	13	Smart digital platform with interactive displays and centralized dashboard management in a modern hotel lobby	GIMS Smart Platform merupakan solusi digital terintegrasi yang dirancang untuk meningkatkan pengalaman pengguna, efisiensi operasional, serta nilai layanan pada berbagai sektor seperti hospitality, apartemen, retail, dan korporasi.
6	3	Smart Education	Smart Education	14	Smart education classroom with academic dashboards, learning analytics, and digital learning technology	GIMS Smart Education adalah solusi digital terintegrasi yang dirancang untuk mendukung transformasi dunia pendidikan menuju sistem yang lebih modern, efisien, dan berbasis teknologi.
\.


--
-- Data for Name: product_page_settings_kategori_produk_produk_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_page_settings_kategori_produk_produk_list (_order, _parent_id, id, nama, deskripsi, tampilkan_keranjang) FROM stdin;
1	GIMS Clean Pipe	711	Dedicated Internet	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Layanan Dedicated Internet menyediakan bandwidth eksklusif yang memastikan koneksi internet lebih stabil, cepat, dan optimal. Dengan jalur khusus tanpa berbagi bandwidth, pengguna dapat menikmati performa upload dan download yang konsisten untuk mendukung aktivitas bisnis secara maksimal setiap saat.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	t
2	GIMS Clean Pipe	712	Broadband Internet	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Broadband Internet merupakan layanan internet yang efisien dan ekonomis tanpa mengurangi kualitas konektivitas. Tersedia berbagai pilihan paket yang fleksibel sesuai kebutuhan, sehingga menjadi solusi yang tepat untuk memenuhi kebutuhan akses internet Anda.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	t
3	GIMS Clean Pipe	713	IP Transit	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Layanan IP Transit memastikan ketersediaan rute jaringan dan alokasi bandwidth yang optimal sehingga menghadirkan konektivitas internet berkecepatan tinggi dengan biaya yang efisien. Jaringan kami terhubung langsung ke berbagai internet backbone dan internet exchange, sehingga mampu menyediakan jalur akses dengan latensi rendah ke berbagai platform populer. Layanan ini juga didukung dengan penggunaan Border Gateway Protocol (BGP) untuk pengelolaan rute jaringan.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	t
4	GIMS Clean Pipe	714	Virtual Private Network (VPN)	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Virtual Private Network (VPN) membantu perusahaan membangun koneksi jaringan yang aman antara kantor pusat dan cabang. Dengan teknologi VPN Access, perusahaan dapat meningkatkan efisiensi operasional, termasuk dalam komunikasi data, layanan telepon berbasis VoIP, hingga proses pengiriman data dan dokumen secara aman.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	t
1	Cloud & Colocation	741	Co-Location	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Layanan Co-Location menyediakan fasilitas data center berstandar tinggi dengan dukungan bandwidth besar, infrastruktur unggulan, serta sistem keamanan yang terjamin. Solusi ini memungkinkan perusahaan untuk menempatkan server dan aplikasi secara optimal, sehingga meningkatkan efisiensi operasional dan keandalan akses data.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
2	Cloud & Colocation	742	Hosting & Mail Domain	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Kami menyediakan layanan web hosting dan domain untuk mendukung pengembangan website perusahaan secara profesional. Dilengkapi dengan fitur seperti cPanel, WHM, dan IP Public, layanan kami hadir dengan berbagai pilihan paket yang fleksibel sesuai kebutuhan bisnis Anda.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
3	Cloud & Colocation	743	Our Co-Locations	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Cyber 1\\\\n\\\\nIDC Duren 3\\\\n\\\\nMenara Tendean (MTEN)\\\\n\\\\nBersama Digital Data Center (BDDC)\\\\n\\\\nWisma BBU\\\\n\\\\nNeucentrix Telkom\\\\n\\\\nDCI Indonesia", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
1	Managed Services	751	IT Consulting	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "GIMS menghadirkan layanan audit dan evaluasi komprehensif untuk memetakan kondisi infrastruktur jaringan perusahaan Anda saat ini. Melalui identifikasi yang mendalam, kami membekali tenaga IT Anda dengan wawasan strategis untuk mengambil keputusan yang tepat dan mengoptimalkan performa jaringan.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
2	Managed Services	752	System Integrators (SI)	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "GIMS berkomitmen menjadi mitra strategis dalam menyatukan berbagai subsistem komponen teknologi Anda ke dalam satu ekosistem yang terpadu dan efisien. Didukung oleh tim ahli yang berpengalaman, kami siap membantu perusahaan Anda menyelesaikan tantangan otomatisasi serta integrasi sistem dan aplikasi bisnis yang kompleks.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
3	Managed Services	753	Engineering On Site (EOS)	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "GIMS menyediakan dukungan tenaga ahli melalui layanan teknisi dan engineer yang siap diterjunkan langsung ke lokasi. Layanan ini fleksibel untuk berbagai skala bisnis, mulai dari sektor perhotelan, perbankan, sekuritas, hingga industri minyak dan gas.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
4	Managed Services	754	Direct Connectivity	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Melalui solusi Direct Connect dari GIMS, infrastruktur jaringan internal Anda kini dapat terhubung secara privat ke platform cloud global seperti AWS, Azure, Zenlayer, hingga MS.O365. Hal ini menjamin transmisi data yang lebih aman, latensi rendah, serta akses penuh ke wilayah cloud publik maupun layanan khusus.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
5	Managed Services	755	Add Service IP	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Menanggapi tingginya permintaan akan IP Public di tengah keterbatasan stok global, GIMS hadir sebagai mitra penyedia layanan bagi sektor korporasi maupun telekomunikasi. Kami melayani jasa penyewaan IP Public serta memfasilitasi proses pendaftaran IP Public yang terdaftar secara resmi dan diakui oleh APNIC.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
6	Managed Services	756	Digital TV	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "GIMS menghadirkan solusi perangkat dan layanan berbasis teknologi digital mutakhir untuk memberikan pengalaman menonton yang lebih berkualitas. Produk ini menawarkan kejernihan gambar dan suara superior, fitur interaktif yang cerdas, serta akses ke berbagai pilihan konten on-demand.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
7	Managed Services	757	IPTV Solutions	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Kami menawarkan cara modern dalam menikmati tayangan televisi melalui infrastruktur jaringan internet (IP). Layanan IPTV GIMS memberikan akses tanpa hambatan ke berbagai saluran TV siaran langsung serta koleksi video on-demand dengan kualitas tinggi yang stabil.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
1	Smart Platform	761	Customizable Interface	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Tampilan home screen dapat disesuaikan secara fleksibel sesuai kebutuhan bisnis, mulai dari branding, informasi, hingga menu layanan utama, sehingga menciptakan pengalaman yang lebih personal dan profesional.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
2	Smart Platform	762	Centralized Dashboard Management	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Sistem dilengkapi dengan dashboard terpusat yang memudahkan pengelolaan konten, monitoring, dan operasional secara real-time dengan antarmuka yang sederhana dan user-friendly.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
3	Smart Platform	763	Smart Guest Engagement	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Menyediakan fitur interaktif seperti welcome greeting, informasi profil, promosi, hingga konten hiburan, yang mampu meningkatkan engagement dan pengalaman pengguna secara menyeluruh.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
4	Smart Platform	764	Dynamic Content & Information	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Konten pada platform bersifat dinamis dan dapat diperbarui secara real-time, termasuk informasi cuaca, waktu, pesan berjalan, promosi, hingga informasi layanan.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
5	Smart Platform	765	Integration & Connectivity	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Platform dapat terintegrasi dengan berbagai sistem seperti PMS, self-ordering system, WiFi access, hingga third-party services, sehingga mendukung ekosistem digital yang lebih luas.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
6	Smart Platform	766	Entertainment & Live Services	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Menyediakan akses ke Live TV, aplikasi hiburan, serta informasi real-time seperti traffic CCTV, untuk memberikan pengalaman yang lebih modern dan informatif.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
1	Smart Education	771	Integrated Academic System	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Mengelola seluruh aktivitas akademik dalam satu platform, mulai dari data siswa, jadwal, nilai, kurikulum, hingga manajemen kelas secara terpusat dan terintegrasi.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
2	Smart Education	772	Smart Attendance & Monitoring	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Sistem absensi digital yang memungkinkan pemantauan kehadiran siswa secara real-time, baik oleh sekolah maupun orang tua.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
3	Smart Education	773	Financial & Administration Management	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Menyediakan fitur pengelolaan keuangan dan administrasi, termasuk pembayaran sekolah, laporan keuangan, dan pengelolaan data institusi secara efisien.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
4	Smart Education	774	E-Learning & Digital Learning	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Mendukung proses pembelajaran modern melalui platform e-learning, memungkinkan kegiatan belajar mengajar dilakukan secara fleksibel, baik offline maupun online.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
5	Smart Education	775	Parent & Communication System	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Menghubungkan sekolah dengan orang tua melalui sistem komunikasi langsung, sehingga orang tua dapat memantau perkembangan akademik, aktivitas, dan informasi penting siswa secara real-time.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
6	Smart Education	776	Big Data & Reporting	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Mengelola data pendidikan dalam skala besar (Big Data) untuk mendukung proses analisis, evaluasi, dan pengambilan keputusan yang lebih cepat dan akurat.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "direction": "ltr"}}	f
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, updated_at, created_at, email, reset_password_token, reset_password_expiration, salt, hash, login_attempts, lock_until) FROM stdin;
1	2026-06-16 08:42:11.913+00	2026-05-21 13:56:14.265+00	admin@gmail.com	\N	\N	40d76d61139b4aed5c3425bcedae4f6b401ad77018f5f65f9e4ee685edb46eb5	fa39042fbed16261c24d7fff8d6902e0544a8dc2eaf01e48613e97e8915d06d46609cd364e0745e6c84915119881de5e1a2c0a3111ef581f4137b21578b8a2b2d57c14b8ca9a1325529afb6c9c1d9e812653edcddb8e9ef8427c11ccf72058086523e7721642e982bf9c59fa1e5d337371ddf89fe159f2a8209cb8fefd1678d5c71bb115a513e09a5cad29cd1e495fc76dd167897aa6c01ca79692d9e98d933619c8cc591e9873c3f0fbe6715cb48590d2d1b427a37ec3d8194eb65b60b998d2c6ce47bc0ca12b13a0237eb000f65bb69901813c11995f87433c8e6f5c62327a34e8f0b248ce86bb8abaf2751ca9783fd8d0b62085d9ab5df538ad47af99337a4f66529ac0255f2fad683e77b9242c09628ba822a80612417046b038228c8ea3c37cafb109302c9c538d59672f307e8367c1d1bdc6b91b8ae8bd53bb88208d27c6427eb6d557d280b50a1eb4fa0320fe4a8b0e9622a816b096957097c88c717ec722618d3604333c455ba14222c9e665ddfe7e9162ea08553ffe1abb5606abf3f864242a39abde54ce92d02c051b581e70336d019d604da5b9b03a752299664af24126bf7857881d0a71d7c07c594d218c4f597d4e0ded599599e68734a221eea3b9f2943f0b53912713d70bd98dbd43967e6bea781528226e480ea25255a9845cf98008e1add61c432bb0ed987775277098ebb2849b5aa7e7ca14af69600507	0	\N
\.


--
-- Data for Name: users_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_sessions (_order, _parent_id, id, created_at, expires_at) FROM stdin;
1	1	7ad54669-bc5a-4e36-927e-f96a1c947c4b	2026-07-06 06:54:39.208+00	2026-07-06 08:54:39.208+00
2	1	3f823f8d-d439-4001-bb99-0d4c3ac4f765	2026-07-06 07:04:47.405+00	2026-07-06 09:04:47.405+00
\.


--
-- Name: about_page_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.about_page_settings_id_seq', 3, false);


--
-- Name: contact_page_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contact_page_settings_id_seq', 3, false);


--
-- Name: general_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.general_settings_id_seq', 2, false);


--
-- Name: home_page_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.home_page_settings_id_seq', 2, false);


--
-- Name: media_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.media_id_seq', 17, true);


--
-- Name: payload_kv_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payload_kv_id_seq', 1, false);


--
-- Name: payload_locked_documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payload_locked_documents_id_seq', 53, true);


--
-- Name: payload_locked_documents_rels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payload_locked_documents_rels_id_seq', 106, true);


--
-- Name: payload_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payload_migrations_id_seq', 1, true);


--
-- Name: payload_preferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payload_preferences_id_seq', 9, true);


--
-- Name: payload_preferences_rels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payload_preferences_rels_id_seq', 37, true);


--
-- Name: product_page_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_page_settings_id_seq', 4, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: about_page_settings_mengapa_milih_gi_m_s_alasan_list about_page_settings_mengapa_milih_gi_m_s_alasan_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.about_page_settings_mengapa_milih_gi_m_s_alasan_list
    ADD CONSTRAINT about_page_settings_mengapa_milih_gi_m_s_alasan_list_pkey PRIMARY KEY (id);


--
-- Name: about_page_settings_nilai_inti_nilai_list about_page_settings_nilai_inti_nilai_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.about_page_settings_nilai_inti_nilai_list
    ADD CONSTRAINT about_page_settings_nilai_inti_nilai_list_pkey PRIMARY KEY (id);


--
-- Name: about_page_settings about_page_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.about_page_settings
    ADD CONSTRAINT about_page_settings_pkey PRIMARY KEY (id);


--
-- Name: about_page_settings_tentang_perusahaan_paragraf about_page_settings_tentang_perusahaan_paragraf_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.about_page_settings_tentang_perusahaan_paragraf
    ADD CONSTRAINT about_page_settings_tentang_perusahaan_paragraf_pkey PRIMARY KEY (id);


--
-- Name: about_page_settings_visi_misi_misi about_page_settings_visi_misi_misi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.about_page_settings_visi_misi_misi
    ADD CONSTRAINT about_page_settings_visi_misi_misi_pkey PRIMARY KEY (id);


--
-- Name: about_page_settings_wilayah_jangkauan_kota_list about_page_settings_wilayah_jangkauan_kota_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.about_page_settings_wilayah_jangkauan_kota_list
    ADD CONSTRAINT about_page_settings_wilayah_jangkauan_kota_list_pkey PRIMARY KEY (id);


--
-- Name: contact_page_settings contact_page_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_page_settings
    ADD CONSTRAINT contact_page_settings_pkey PRIMARY KEY (id);


--
-- Name: general_settings general_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.general_settings
    ADD CONSTRAINT general_settings_pkey PRIMARY KEY (id);


--
-- Name: home_page_settings_layanan_di_home home_page_settings_layanan_di_home_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.home_page_settings_layanan_di_home
    ADD CONSTRAINT home_page_settings_layanan_di_home_pkey PRIMARY KEY (id);


--
-- Name: home_page_settings home_page_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.home_page_settings
    ADD CONSTRAINT home_page_settings_pkey PRIMARY KEY (id);


--
-- Name: home_page_settings_slides home_page_settings_slides_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.home_page_settings_slides
    ADD CONSTRAINT home_page_settings_slides_pkey PRIMARY KEY (id);


--
-- Name: media media_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media
    ADD CONSTRAINT media_pkey PRIMARY KEY (id);


--
-- Name: payload_kv payload_kv_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_kv
    ADD CONSTRAINT payload_kv_pkey PRIMARY KEY (id);


--
-- Name: payload_locked_documents payload_locked_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_locked_documents
    ADD CONSTRAINT payload_locked_documents_pkey PRIMARY KEY (id);


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_pkey PRIMARY KEY (id);


--
-- Name: payload_migrations payload_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_migrations
    ADD CONSTRAINT payload_migrations_pkey PRIMARY KEY (id);


--
-- Name: payload_preferences payload_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_preferences
    ADD CONSTRAINT payload_preferences_pkey PRIMARY KEY (id);


--
-- Name: payload_preferences_rels payload_preferences_rels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_preferences_rels
    ADD CONSTRAINT payload_preferences_rels_pkey PRIMARY KEY (id);


--
-- Name: product_page_settings_kategori_produk product_page_settings_kategori_produk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_page_settings_kategori_produk
    ADD CONSTRAINT product_page_settings_kategori_produk_pkey PRIMARY KEY (id);


--
-- Name: product_page_settings_kategori_produk_produk_list product_page_settings_kategori_produk_produk_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_page_settings_kategori_produk_produk_list
    ADD CONSTRAINT product_page_settings_kategori_produk_produk_list_pkey PRIMARY KEY (id);


--
-- Name: product_page_settings product_page_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_page_settings
    ADD CONSTRAINT product_page_settings_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_sessions users_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_sessions
    ADD CONSTRAINT users_sessions_pkey PRIMARY KEY (id);


--
-- Name: about_page_settings_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX about_page_settings_created_at_idx ON public.about_page_settings USING btree (created_at);


--
-- Name: about_page_settings_mengapa_milih_gi_m_s_alasan_list_order_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX about_page_settings_mengapa_milih_gi_m_s_alasan_list_order_idx ON public.about_page_settings_mengapa_milih_gi_m_s_alasan_list USING btree (_order);


--
-- Name: about_page_settings_mengapa_milih_gi_m_s_alasan_list_parent_id_; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX about_page_settings_mengapa_milih_gi_m_s_alasan_list_parent_id_ ON public.about_page_settings_mengapa_milih_gi_m_s_alasan_list USING btree (_parent_id);


--
-- Name: about_page_settings_mengapa_milih_gi_m_s_mengapa_milih_g_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX about_page_settings_mengapa_milih_gi_m_s_mengapa_milih_g_idx ON public.about_page_settings USING btree (mengapa_milih_gi_m_s_gambar_id);


--
-- Name: about_page_settings_nilai_inti_nilai_list_order_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX about_page_settings_nilai_inti_nilai_list_order_idx ON public.about_page_settings_nilai_inti_nilai_list USING btree (_order);


--
-- Name: about_page_settings_nilai_inti_nilai_list_parent_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX about_page_settings_nilai_inti_nilai_list_parent_id_idx ON public.about_page_settings_nilai_inti_nilai_list USING btree (_parent_id);


--
-- Name: about_page_settings_tentang_perusahaan_gambar_tentang__1_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX about_page_settings_tentang_perusahaan_gambar_tentang__1_idx ON public.about_page_settings USING btree (tentang_perusahaan_gambar_kanan_id);


--
-- Name: about_page_settings_tentang_perusahaan_gambar_tentang__2_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX about_page_settings_tentang_perusahaan_gambar_tentang__2_idx ON public.about_page_settings USING btree (tentang_perusahaan_gambar_bawah_id);


--
-- Name: about_page_settings_tentang_perusahaan_gambar_tentang_pe_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX about_page_settings_tentang_perusahaan_gambar_tentang_pe_idx ON public.about_page_settings USING btree (tentang_perusahaan_gambar_utama_id);


--
-- Name: about_page_settings_tentang_perusahaan_paragraf_order_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX about_page_settings_tentang_perusahaan_paragraf_order_idx ON public.about_page_settings_tentang_perusahaan_paragraf USING btree (_order);


--
-- Name: about_page_settings_tentang_perusahaan_paragraf_parent_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX about_page_settings_tentang_perusahaan_paragraf_parent_id_idx ON public.about_page_settings_tentang_perusahaan_paragraf USING btree (_parent_id);


--
-- Name: about_page_settings_updated_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX about_page_settings_updated_at_idx ON public.about_page_settings USING btree (updated_at);


--
-- Name: about_page_settings_visi_misi_misi_order_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX about_page_settings_visi_misi_misi_order_idx ON public.about_page_settings_visi_misi_misi USING btree (_order);


--
-- Name: about_page_settings_visi_misi_misi_parent_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX about_page_settings_visi_misi_misi_parent_id_idx ON public.about_page_settings_visi_misi_misi USING btree (_parent_id);


--
-- Name: about_page_settings_visi_misi_visi_misi_gambar_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX about_page_settings_visi_misi_visi_misi_gambar_idx ON public.about_page_settings USING btree (visi_misi_gambar_id);


--
-- Name: about_page_settings_wilayah_jangkauan_kota_list_order_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX about_page_settings_wilayah_jangkauan_kota_list_order_idx ON public.about_page_settings_wilayah_jangkauan_kota_list USING btree (_order);


--
-- Name: about_page_settings_wilayah_jangkauan_kota_list_parent_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX about_page_settings_wilayah_jangkauan_kota_list_parent_id_idx ON public.about_page_settings_wilayah_jangkauan_kota_list USING btree (_parent_id);


--
-- Name: contact_page_settings_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX contact_page_settings_created_at_idx ON public.contact_page_settings USING btree (created_at);


--
-- Name: contact_page_settings_updated_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX contact_page_settings_updated_at_idx ON public.contact_page_settings USING btree (updated_at);


--
-- Name: general_settings_logo_footer_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX general_settings_logo_footer_idx ON public.general_settings USING btree (logo_footer_id);


--
-- Name: general_settings_logo_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX general_settings_logo_idx ON public.general_settings USING btree (logo_id);


--
-- Name: home_page_settings_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX home_page_settings_created_at_idx ON public.home_page_settings USING btree (created_at);


--
-- Name: home_page_settings_layanan_di_home_order_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX home_page_settings_layanan_di_home_order_idx ON public.home_page_settings_layanan_di_home USING btree (_order);


--
-- Name: home_page_settings_layanan_di_home_parent_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX home_page_settings_layanan_di_home_parent_id_idx ON public.home_page_settings_layanan_di_home USING btree (_parent_id);


--
-- Name: home_page_settings_slides_gambar_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX home_page_settings_slides_gambar_idx ON public.home_page_settings_slides USING btree (gambar_id);


--
-- Name: home_page_settings_slides_order_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX home_page_settings_slides_order_idx ON public.home_page_settings_slides USING btree (_order);


--
-- Name: home_page_settings_slides_parent_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX home_page_settings_slides_parent_id_idx ON public.home_page_settings_slides USING btree (_parent_id);


--
-- Name: home_page_settings_tentang_kami_tentang_kami_gambar_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX home_page_settings_tentang_kami_tentang_kami_gambar_idx ON public.home_page_settings USING btree (tentang_kami_gambar_id);


--
-- Name: home_page_settings_updated_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX home_page_settings_updated_at_idx ON public.home_page_settings USING btree (updated_at);


--
-- Name: media_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX media_created_at_idx ON public.media USING btree (created_at);


--
-- Name: media_filename_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX media_filename_idx ON public.media USING btree (filename);


--
-- Name: media_updated_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX media_updated_at_idx ON public.media USING btree (updated_at);


--
-- Name: payload_kv_key_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX payload_kv_key_idx ON public.payload_kv USING btree (key);


--
-- Name: payload_locked_documents_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_created_at_idx ON public.payload_locked_documents USING btree (created_at);


--
-- Name: payload_locked_documents_global_slug_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_global_slug_idx ON public.payload_locked_documents USING btree (global_slug);


--
-- Name: payload_locked_documents_rels_about_page_settings_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_rels_about_page_settings_id_idx ON public.payload_locked_documents_rels USING btree (about_page_settings_id);


--
-- Name: payload_locked_documents_rels_contact_page_settings_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_rels_contact_page_settings_id_idx ON public.payload_locked_documents_rels USING btree (contact_page_settings_id);


--
-- Name: payload_locked_documents_rels_general_settings_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_rels_general_settings_id_idx ON public.payload_locked_documents_rels USING btree (general_settings_id);


--
-- Name: payload_locked_documents_rels_home_page_settings_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_rels_home_page_settings_id_idx ON public.payload_locked_documents_rels USING btree (home_page_settings_id);


--
-- Name: payload_locked_documents_rels_media_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_rels_media_id_idx ON public.payload_locked_documents_rels USING btree (media_id);


--
-- Name: payload_locked_documents_rels_order_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_rels_order_idx ON public.payload_locked_documents_rels USING btree ("order");


--
-- Name: payload_locked_documents_rels_parent_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_rels_parent_idx ON public.payload_locked_documents_rels USING btree (parent_id);


--
-- Name: payload_locked_documents_rels_path_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_rels_path_idx ON public.payload_locked_documents_rels USING btree (path);


--
-- Name: payload_locked_documents_rels_product_page_settings_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_rels_product_page_settings_id_idx ON public.payload_locked_documents_rels USING btree (product_page_settings_id);


--
-- Name: payload_locked_documents_rels_users_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_rels_users_id_idx ON public.payload_locked_documents_rels USING btree (users_id);


--
-- Name: payload_locked_documents_updated_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_updated_at_idx ON public.payload_locked_documents USING btree (updated_at);


--
-- Name: payload_migrations_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_migrations_created_at_idx ON public.payload_migrations USING btree (created_at);


--
-- Name: payload_migrations_updated_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_migrations_updated_at_idx ON public.payload_migrations USING btree (updated_at);


--
-- Name: payload_preferences_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_preferences_created_at_idx ON public.payload_preferences USING btree (created_at);


--
-- Name: payload_preferences_key_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_preferences_key_idx ON public.payload_preferences USING btree (key);


--
-- Name: payload_preferences_rels_order_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_preferences_rels_order_idx ON public.payload_preferences_rels USING btree ("order");


--
-- Name: payload_preferences_rels_parent_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_preferences_rels_parent_idx ON public.payload_preferences_rels USING btree (parent_id);


--
-- Name: payload_preferences_rels_path_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_preferences_rels_path_idx ON public.payload_preferences_rels USING btree (path);


--
-- Name: payload_preferences_rels_users_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_preferences_rels_users_id_idx ON public.payload_preferences_rels USING btree (users_id);


--
-- Name: payload_preferences_updated_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_preferences_updated_at_idx ON public.payload_preferences USING btree (updated_at);


--
-- Name: product_page_settings_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX product_page_settings_created_at_idx ON public.product_page_settings USING btree (created_at);


--
-- Name: product_page_settings_kategori_produk_gambar_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX product_page_settings_kategori_produk_gambar_idx ON public.product_page_settings_kategori_produk USING btree (gambar_id);


--
-- Name: product_page_settings_kategori_produk_order_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX product_page_settings_kategori_produk_order_idx ON public.product_page_settings_kategori_produk USING btree (_order);


--
-- Name: product_page_settings_kategori_produk_parent_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX product_page_settings_kategori_produk_parent_id_idx ON public.product_page_settings_kategori_produk USING btree (_parent_id);


--
-- Name: product_page_settings_kategori_produk_produk_list_order_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX product_page_settings_kategori_produk_produk_list_order_idx ON public.product_page_settings_kategori_produk_produk_list USING btree (_order);


--
-- Name: product_page_settings_kategori_produk_produk_list_parent_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX product_page_settings_kategori_produk_produk_list_parent_id_idx ON public.product_page_settings_kategori_produk_produk_list USING btree (_parent_id);


--
-- Name: product_page_settings_updated_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX product_page_settings_updated_at_idx ON public.product_page_settings USING btree (updated_at);


--
-- Name: users_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_created_at_idx ON public.users USING btree (created_at);


--
-- Name: users_email_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_email_idx ON public.users USING btree (email);


--
-- Name: users_sessions_order_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_sessions_order_idx ON public.users_sessions USING btree (_order);


--
-- Name: users_sessions_parent_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_sessions_parent_id_idx ON public.users_sessions USING btree (_parent_id);


--
-- Name: users_updated_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_updated_at_idx ON public.users USING btree (updated_at);


--
-- Name: about_page_settings_mengapa_milih_gi_m_s_alasan_list about_page_settings_mengapa_milih_gi_m_s_alasan_list_parent_id_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.about_page_settings_mengapa_milih_gi_m_s_alasan_list
    ADD CONSTRAINT about_page_settings_mengapa_milih_gi_m_s_alasan_list_parent_id_ FOREIGN KEY (_parent_id) REFERENCES public.about_page_settings(id) ON DELETE CASCADE;


--
-- Name: about_page_settings about_page_settings_mengapa_milih_gi_m_s_gambar_id_media_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.about_page_settings
    ADD CONSTRAINT about_page_settings_mengapa_milih_gi_m_s_gambar_id_media_id_fk FOREIGN KEY (mengapa_milih_gi_m_s_gambar_id) REFERENCES public.media(id) ON DELETE SET NULL;


--
-- Name: about_page_settings_nilai_inti_nilai_list about_page_settings_nilai_inti_nilai_list_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.about_page_settings_nilai_inti_nilai_list
    ADD CONSTRAINT about_page_settings_nilai_inti_nilai_list_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.about_page_settings(id) ON DELETE CASCADE;


--
-- Name: about_page_settings about_page_settings_tentang_perusahaan_gambar_bawah_id_media_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.about_page_settings
    ADD CONSTRAINT about_page_settings_tentang_perusahaan_gambar_bawah_id_media_id FOREIGN KEY (tentang_perusahaan_gambar_bawah_id) REFERENCES public.media(id) ON DELETE SET NULL;


--
-- Name: about_page_settings about_page_settings_tentang_perusahaan_gambar_kanan_id_media_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.about_page_settings
    ADD CONSTRAINT about_page_settings_tentang_perusahaan_gambar_kanan_id_media_id FOREIGN KEY (tentang_perusahaan_gambar_kanan_id) REFERENCES public.media(id) ON DELETE SET NULL;


--
-- Name: about_page_settings about_page_settings_tentang_perusahaan_gambar_utama_id_media_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.about_page_settings
    ADD CONSTRAINT about_page_settings_tentang_perusahaan_gambar_utama_id_media_id FOREIGN KEY (tentang_perusahaan_gambar_utama_id) REFERENCES public.media(id) ON DELETE SET NULL;


--
-- Name: about_page_settings_tentang_perusahaan_paragraf about_page_settings_tentang_perusahaan_paragraf_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.about_page_settings_tentang_perusahaan_paragraf
    ADD CONSTRAINT about_page_settings_tentang_perusahaan_paragraf_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.about_page_settings(id) ON DELETE CASCADE;


--
-- Name: about_page_settings about_page_settings_visi_misi_gambar_id_media_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.about_page_settings
    ADD CONSTRAINT about_page_settings_visi_misi_gambar_id_media_id_fk FOREIGN KEY (visi_misi_gambar_id) REFERENCES public.media(id) ON DELETE SET NULL;


--
-- Name: about_page_settings_visi_misi_misi about_page_settings_visi_misi_misi_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.about_page_settings_visi_misi_misi
    ADD CONSTRAINT about_page_settings_visi_misi_misi_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.about_page_settings(id) ON DELETE CASCADE;


--
-- Name: about_page_settings_wilayah_jangkauan_kota_list about_page_settings_wilayah_jangkauan_kota_list_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.about_page_settings_wilayah_jangkauan_kota_list
    ADD CONSTRAINT about_page_settings_wilayah_jangkauan_kota_list_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.about_page_settings(id) ON DELETE CASCADE;


--
-- Name: general_settings general_settings_logo_footer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.general_settings
    ADD CONSTRAINT general_settings_logo_footer_id_fkey FOREIGN KEY (logo_footer_id) REFERENCES public.media(id) ON DELETE SET NULL;


--
-- Name: general_settings general_settings_logo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.general_settings
    ADD CONSTRAINT general_settings_logo_id_fkey FOREIGN KEY (logo_id) REFERENCES public.media(id) ON DELETE SET NULL;


--
-- Name: home_page_settings_layanan_di_home home_page_settings_layanan_di_home_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.home_page_settings_layanan_di_home
    ADD CONSTRAINT home_page_settings_layanan_di_home_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.home_page_settings(id) ON DELETE CASCADE;


--
-- Name: home_page_settings_slides home_page_settings_slides_gambar_id_media_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.home_page_settings_slides
    ADD CONSTRAINT home_page_settings_slides_gambar_id_media_id_fk FOREIGN KEY (gambar_id) REFERENCES public.media(id) ON DELETE SET NULL;


--
-- Name: home_page_settings_slides home_page_settings_slides_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.home_page_settings_slides
    ADD CONSTRAINT home_page_settings_slides_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.home_page_settings(id) ON DELETE CASCADE;


--
-- Name: home_page_settings home_page_settings_tentang_kami_gambar_id_media_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.home_page_settings
    ADD CONSTRAINT home_page_settings_tentang_kami_gambar_id_media_id_fk FOREIGN KEY (tentang_kami_gambar_id) REFERENCES public.media(id) ON DELETE SET NULL;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_about_page_settings_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_about_page_settings_fk FOREIGN KEY (about_page_settings_id) REFERENCES public.about_page_settings(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_contact_page_settings_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_contact_page_settings_fk FOREIGN KEY (contact_page_settings_id) REFERENCES public.contact_page_settings(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_general_settings_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_general_settings_id_fkey FOREIGN KEY (general_settings_id) REFERENCES public.general_settings(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_home_page_settings_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_home_page_settings_fk FOREIGN KEY (home_page_settings_id) REFERENCES public.home_page_settings(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_media_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_media_fk FOREIGN KEY (media_id) REFERENCES public.media(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_parent_fk FOREIGN KEY (parent_id) REFERENCES public.payload_locked_documents(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_product_page_settings_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_product_page_settings_fk FOREIGN KEY (product_page_settings_id) REFERENCES public.product_page_settings(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_users_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_users_fk FOREIGN KEY (users_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: payload_preferences_rels payload_preferences_rels_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_preferences_rels
    ADD CONSTRAINT payload_preferences_rels_parent_fk FOREIGN KEY (parent_id) REFERENCES public.payload_preferences(id) ON DELETE CASCADE;


--
-- Name: payload_preferences_rels payload_preferences_rels_users_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_preferences_rels
    ADD CONSTRAINT payload_preferences_rels_users_fk FOREIGN KEY (users_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: product_page_settings_kategori_produk product_page_settings_kategori_produk_gambar_id_media_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_page_settings_kategori_produk
    ADD CONSTRAINT product_page_settings_kategori_produk_gambar_id_media_id_fk FOREIGN KEY (gambar_id) REFERENCES public.media(id) ON DELETE SET NULL;


--
-- Name: product_page_settings_kategori_produk product_page_settings_kategori_produk_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_page_settings_kategori_produk
    ADD CONSTRAINT product_page_settings_kategori_produk_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.product_page_settings(id) ON DELETE CASCADE;


--
-- Name: product_page_settings_kategori_produk_produk_list product_page_settings_kategori_produk_produk_list_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_page_settings_kategori_produk_produk_list
    ADD CONSTRAINT product_page_settings_kategori_produk_produk_list_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.product_page_settings_kategori_produk(id) ON DELETE CASCADE;


--
-- Name: users_sessions users_sessions_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_sessions
    ADD CONSTRAINT users_sessions_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict eCO1H85hhHEOX2yw2y3gY97EqKhrjRtUbEz5gcX40F5y8aGOqKmeNnTW1XKd6A3

