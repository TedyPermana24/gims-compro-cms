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
    {
      name: 'whatsapp',
      type: 'group',
      label: 'Widget WhatsApp & Kontak',
      admin: {
        description: 'Pengaturan untuk floating WhatsApp widget dan info kontak di footer/widget.',
      },
      fields: [
        {
          name: 'nomor',
          type: 'text',
          label: 'Nomor WhatsApp',
          defaultValue: '022 3050 2080',
          admin: {
            description: 'Nomor telepon untuk WhatsApp (bisa format 08xx, 62xx, atau dengan spasi).',
          },
        },
        {
          name: 'email',
          type: 'email',
          label: 'Email Kontak',
          defaultValue: 'contact@gimsnet.co.id',
          admin: {
            description: 'Alamat email yang ditampilkan di widget dan footer.',
          },
        },
        {
          name: 'teksGreeting',
          type: 'text',
          label: 'Teks Greeting WhatsApp',
          defaultValue: 'Halo GiMS! Saya ingin bertanya mengenai layanan Anda.',
          admin: {
            description: 'Pesan default yang akan terisi saat user klik chat WhatsApp.',
          },
        },
        {
          name: 'labelTombol',
          type: 'text',
          label: 'Label Tombol WhatsApp',
          defaultValue: 'Apa yang bisa saya Bantu?',
          admin: {
            description: 'Teks yang muncul di tombol WhatsApp (desktop).',
          },
        },
        {
          name: 'namaPerusahaan',
          type: 'text',
          label: 'Nama Perusahaan (Footer Widget)',
          defaultValue: 'PT. Global Inovasi Mitra Solusi',
          admin: {
            description: 'Nama yang ditampilkan di footer popup WhatsApp.',
          },
        },
      ],
    },
  ],
}
