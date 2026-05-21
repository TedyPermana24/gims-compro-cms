import type { CollectionConfig } from 'payload'

export const ContactPageSettings: CollectionConfig = {
  slug: 'contact-page-settings',
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
      name: 'kontakInfo',
      type: 'group',
      label: 'Kontak Info',
      fields: [
        {
          name: 'alamat',
          type: 'textarea',
          required: true,
          label: 'Alamat',
        },
        {
          name: 'telepon',
          type: 'text',
          required: true,
          label: 'Nomor Telepon',
        },
        {
          name: 'email',
          type: 'text',
          required: true,
          label: 'Email',
        },
      ],
    },
    {
      name: 'mapLink',
      type: 'text',
      label: 'Link Google Maps',
    },
  ],
}
