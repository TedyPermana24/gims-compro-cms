import type { CollectionConfig } from 'payload'

export const GeneralSettings: CollectionConfig = {
  slug: 'general-settings',
  admin: {
    group: 'Settings',
    useAsTitle: 'namaSitus',
    defaultColumns: ['namaSitus', 'updatedAt'],
  },
  access: {
    read: () => true,
  },
  fields: [
    {
      name: 'namaSitus',
      type: 'text',
      required: true,
      label: 'Nama Situs',
      defaultValue: 'GIMS',
      admin: {
        description: 'Nama situs yang ditampilkan jika logo tidak diupload',
      },
    },
    {
      name: 'logo',
      type: 'relationship',
      relationTo: 'media',
      label: 'Logo Navbar',
      admin: {
        description: 'Upload logo untuk ditampilkan di navbar. Rekomendasi: gambar PNG transparan, tinggi 40-48px.',
      },
    },
    {
      name: 'logoFooter',
      type: 'relationship',
      relationTo: 'media',
      label: 'Logo Footer (Opsional)',
      admin: {
        description: 'Logo khusus untuk footer. Jika tidak diisi, akan menggunakan logo navbar.',
      },
    },
  ],
}
