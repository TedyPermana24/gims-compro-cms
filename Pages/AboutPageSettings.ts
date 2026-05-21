import type { CollectionConfig } from 'payload'

export const AboutPageSettings: CollectionConfig = {
  slug: 'about-page-settings',
  admin: {
    group: 'Pages',
    useAsTitle: 'judul',
    defaultColumns: ['judul', 'updatedAt'],
  },
  access: {
    read: () => true,
  },
  fields: [
    {
      name: 'judul',
      type: 'text',
      required: true,
      label: 'Judul Halaman',
    },
    {
      name: 'deskripsiSingkat',
      type: 'textarea',
      required: true,
      label: 'Deskripsi Singkat Halaman',
    },
    {
      name: 'tentangPerusahaan',
      type: 'group',
      label: 'Bagian Tentang Perusahaan',
      fields: [
        {
          name: 'label',
          type: 'text',
          required: true,
          label: 'Label',
          defaultValue: 'Company Profile',
        },
        {
          name: 'judul',
          type: 'text',
          required: true,
          label: 'Judul Bagian',
        },
        {
          name: 'paragraf',
          type: 'array',
          label: 'Paragraf',
          required: true,
          fields: [
            {
              name: 'teks',
              type: 'textarea',
              required: true,
              label: 'Teks Paragraf',
            },
          ],
          minRows: 1,
        },
        {
          name: 'gambar',
          type: 'group',
          label: 'Gambar',
          fields: [
            {
              name: 'utama',
              type: 'relationship',
              relationTo: 'media',
              required: true,
              label: 'Gambar Utama',
            },
            {
              name: 'kanan',
              type: 'relationship',
              relationTo: 'media',
              required: true,
              label: 'Gambar Kanan',
            },
            {
              name: 'bawah',
              type: 'relationship',
              relationTo: 'media',
              required: true,
              label: 'Gambar Bawah',
            },
          ],
        },
      ],
    },
    {
      name: 'visiMisi',
      type: 'group',
      label: 'Visi & Misi',
      fields: [
        {
          name: 'label',
          type: 'text',
          required: true,
          label: 'Label',
          defaultValue: 'Vision & Mission',
        },
        {
          name: 'visi',
          type: 'group',
          label: 'Visi',
          fields: [
            {
              name: 'deskripsi',
              type: 'textarea',
              required: true,
              label: 'Deskripsi Visi',
            },
          ],
        },
        {
          name: 'misi',
          type: 'array',
          label: 'Poin Misi',
          required: true,
          fields: [
            {
              name: 'teks',
              type: 'textarea',
              required: true,
              label: 'Teks Misi',
            },
          ],
          minRows: 1,
        },
        {
          name: 'gambar',
          type: 'relationship',
          relationTo: 'media',
          label: 'Gambar Visi Misi',
        },
      ],
    },
    {
      name: 'nilaiInti',
      type: 'group',
      label: 'Nilai-Nilai Inti (G.I.M.S)',
      fields: [
        {
          name: 'label',
          type: 'text',
          required: true,
          label: 'Label',
          defaultValue: 'Core Values',
        },
        {
          name: 'deskripsiSingkat',
          type: 'textarea',
          label: 'Deskripsi Singkat',
        },
        {
          name: 'nilaiList',
          type: 'array',
          label: 'Daftar Nilai',
          required: true,
          fields: [
            {
              name: 'huruf',
              type: 'text',
              required: true,
              label: 'Huruf',
              maxLength: 1,
            },
            {
              name: 'judul',
              type: 'text',
              required: true,
              label: 'Judul Nilai',
            },
            {
              name: 'subtitle',
              type: 'text',
              required: true,
              label: 'Subtitle (Bahasa Indonesia)',
            },
            {
              name: 'deskripsi',
              type: 'textarea',
              required: true,
              label: 'Deskripsi',
            },
          ],
          minRows: 4,
        },
      ],
    },
    {
      name: 'mengapaMilihGiMS',
      type: 'group',
      label: 'Mengapa Memilih GiMS',
      fields: [
        {
          name: 'label',
          type: 'text',
          required: true,
          label: 'Label',
          defaultValue: 'Why Choose Us',
        },
        {
          name: 'judul',
          type: 'text',
          required: true,
          label: 'Judul Bagian',
        },
        {
          name: 'deskripsiSingkat',
          type: 'textarea',
          required: true,
          label: 'Deskripsi Singkat',
        },
        {
          name: 'alasanList',
          type: 'array',
          label: 'Daftar Alasan',
          required: true,
          fields: [
            {
              name: 'kategori',
              type: 'text',
              required: true,
              label: 'Kategori',
            },
            {
              name: 'subtitle',
              type: 'text',
              required: true,
              label: 'Subtitle',
            },
            {
              name: 'deskripsi',
              type: 'textarea',
              required: true,
              label: 'Deskripsi',
            },
          ],
          minRows: 1,
        },
        {
          name: 'gambar',
          type: 'relationship',
          relationTo: 'media',
          required: true,
          label: 'Gambar',
        },
      ],
    },
    {
      name: 'wilayahJangkauan',
      type: 'group',
      label: 'Wilayah Jangkauan',
      fields: [
        {
          name: 'label',
          type: 'text',
          required: true,
          label: 'Label',
          defaultValue: 'Coverage',
        },
        {
          name: 'judul',
          type: 'text',
          required: true,
          label: 'Judul',
          defaultValue: 'Jangkauan Nasional',
        },
        {
          name: 'deskripsi',
          type: 'textarea',
          required: true,
          label: 'Deskripsi',
        },
        {
          name: 'kotaList',
          type: 'array',
          label: 'Daftar Kota',
          required: true,
          fields: [
            {
              name: 'nama',
              type: 'text',
              required: true,
              label: 'Nama Kota',
            },
            {
              name: 'latitude',
              type: 'number',
              required: true,
              label: 'Latitude',
            },
            {
              name: 'longitude',
              type: 'number',
              required: true,
              label: 'Longitude',
            },
          ],
          minRows: 1,
        },
      ],
    },
  ],
}
