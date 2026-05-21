import type { CollectionConfig } from 'payload'

export const ProductPageSettings: CollectionConfig = {
  slug: 'product-page-settings',
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
      name: 'kategoriProduk',
      type: 'array',
      label: 'Kategori Produk',
      required: true,
      fields: [
        {
          name: 'id',
          type: 'text',
          required: true,
          label: 'ID Kategori (slug)',
        },
        {
          name: 'judul',
          type: 'text',
          required: true,
          label: 'Judul Kategori',
        },
        {
          name: 'gambar',
          type: 'relationship',
          relationTo: 'media',
          required: true,
          label: 'Gambar Kategori',
        },
        {
          name: 'altGambar',
          type: 'text',
          required: true,
          label: 'Alt Text Gambar',
        },
        {
          name: 'intro',
          type: 'textarea',
          required: true,
          label: 'Pengenalan Kategori',
        },
        {
          name: 'produkList',
          type: 'array',
          label: 'Daftar Produk',
          fields: [
            {
              name: 'nama',
              type: 'text',
              required: true,
              label: 'Nama Produk',
            },
            {
              name: 'deskripsi',
              type: 'richText',
              required: true,
              label: 'Deskripsi Produk',
            },
          ],
        },
      ],
      minRows: 1,
    },
  ],
}
