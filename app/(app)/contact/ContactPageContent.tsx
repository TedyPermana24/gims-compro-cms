"use client";

import Link from "next/link";
import Reveal from "../components/Reveal";
import Image from "next/image";
import { MapPin, Mail, Phone } from "lucide-react";
import { useContactPageSettings } from "../../hooks/usePageSettings";
import type { ContactPageSetting } from '@/payload-types'

export default function ContactPageContent() {
  const { data, loading } = useContactPageSettings();

  if (loading || !data) {
    return <div className="min-h-screen bg-white" />;
  }

  const kontak: ContactPageSetting['kontakInfo'] = data.kontakInfo ?? null;

  return (
    <>
      {/* Page Header */}
      <section className="relative pt-28 pb-16 lg:pt-36 lg:pb-20 bg-navy-dark">
        <div className="absolute inset-0 opacity-10">
          <Image src="/images/tech-growth.png" alt="" fill className="object-cover" priority aria-hidden="true" />
        </div>
        <div className="absolute top-0 inset-x-0 h-1 bg-gradient-to-r from-teal via-teal-light to-teal" />
        <div className="relative z-10 mx-auto max-w-7xl px-6 lg:px-8">
          <div className="flex items-center gap-2 text-sm text-white/40 mb-6">
            <Link href="/" className="hover:text-white transition-colors">Home</Link>
            <span>/</span>
            <span className="text-white/70">{data.judul ?? 'Hubungi Kami'}</span>
          </div>
          <h1 className="text-3xl sm:text-4xl lg:text-5xl font-bold font-[var(--font-outfit)] text-white mb-4">
            {data.judul ?? 'Hubungi Kami'}
          </h1>
          <p className="max-w-2xl text-white/50 text-lg leading-relaxed">
            {data.deskripsiSingkat ?? 'Hubungi kami untuk konsultasi mengenai kebutuhan teknologi bisnis Anda.'}
          </p>
        </div>
      </section>

      {/* Contact Details + Map */}
      <section className="py-20 lg:py-24 bg-white">
        <div className="mx-auto max-w-7xl px-6 lg:px-8">
          <Reveal>
            <p className="text-teal text-sm font-semibold tracking-[0.2em] uppercase mb-10">// Contact Details</p>

            <div className="grid gap-16 lg:grid-cols-[1fr_1fr] items-start">
              {/* Left — Contact Info */}
              <div className="flex flex-col gap-10">
                {/* Head Office */}
                <div className="flex items-start gap-5">
                  <div className="w-12 h-12 rounded-xl bg-slate-100 flex items-center justify-center flex-shrink-0">
                    <MapPin className="w-5 h-5 text-navy-dark" />
                  </div>
                  <div>
                    <h3 className="font-bold text-navy-dark font-[var(--font-outfit)] mb-2">Kantor Kami</h3>
                    <p className="text-slate-500 text-sm leading-relaxed">
                      {kontak?.alamat ?? '—'}
                    </p>
                  </div>
                </div>

                {/* Email */}
                <div className="flex items-start gap-5">
                  <div className="w-12 h-12 rounded-xl bg-slate-100 flex items-center justify-center flex-shrink-0">
                    <Mail className="w-5 h-5 text-navy-dark" />
                  </div>
                  <div>
                    <h3 className="font-bold text-navy-dark font-[var(--font-outfit)] mb-2">Our Mailbox</h3>
                    {kontak?.email ? (
                      <a href={`mailto:${kontak.email}`} className="text-slate-500 text-sm hover:text-teal transition-colors">
                        {kontak.email}
                      </a>
                    ) : (
                      <p className="text-slate-500 text-sm">—</p>
                    )}
                  </div>
                </div>

                {/* Phone */}
                <div className="flex items-start gap-5">
                  <div className="w-12 h-12 rounded-xl bg-slate-100 flex items-center justify-center flex-shrink-0">
                    <Phone className="w-5 h-5 text-navy-dark" />
                  </div>
                  <div>
                    <h3 className="font-bold text-navy-dark font-[var(--font-outfit)] mb-2">Our Phone</h3>
                    {kontak?.telepon ? (
                      <a href={`tel:${kontak.telepon.replace(/\s+/g, '')}`} className="text-slate-500 text-sm hover:text-teal transition-colors">
                        {kontak.telepon}
                      </a>
                    ) : (
                      <p className="text-slate-500 text-sm">—</p>
                    )}
                  </div>
                </div>
              </div>

              {/* Right — Map */}
              <div className="rounded-2xl overflow-hidden border border-slate-200 shadow-sm min-h-[360px] flex items-center justify-center bg-slate-50">
                {data.mapLink ? (
                  <iframe
                    src={data.mapLink}
                    width="100%"
                    height="360"
                    style={{ border: 0 }}
                    allowFullScreen
                    loading="lazy"
                    referrerPolicy="no-referrer-when-downgrade"
                    className="rounded-2xl"
                  />
                ) : (
                  <div className="flex flex-col items-center justify-center w-full h-full gap-4 p-8">
                    <div className="w-16 h-16 rounded-full bg-slate-200 flex items-center justify-center">
                      <MapPin className="w-8 h-8 text-slate-400" />
                    </div>
                    <p className="text-xs text-slate-400">Peta tidak tersedia</p>
                  </div>
                )}
              </div>
            </div>
          </Reveal>
        </div>
      </section>
    </>
  );
}
