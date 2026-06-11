"use client";

import Link from "next/link";
import Image from "next/image";
import type { ContactPageSetting, Media } from "@/payload-types";
import { useContactPageSettings } from "../../hooks/usePageSettings";
import type { ProductPageSetting } from "@/payload-types";
import { useProductPageSettings, useGeneralSettings } from "../../hooks/usePageSettings";

const DEFAULT_CONTACT_EMAIL = "contact@gimsnet.co.id";
const DEFAULT_CONTACT_PHONE = "022 3050 2080";

function formatContactPhone(phone?: string | null) {
  return phone?.trim() || DEFAULT_CONTACT_PHONE;
}

function getTelHref(phone?: string | null) {
  const normalized = phone?.replace(/[^\d+]/g, "");
  return normalized ? `tel:${normalized}` : "tel:02230502080";
}

function getProductLinks(settings?: ProductPageSetting | null) {
  return (settings?.kategoriProduk ?? [])
    .slice(0, 7)
    .map((category) => ({
      label: category.judul,
      href: `/products#${category.id}`,
    }));
}

export default function Footer() {
  const { data } = useContactPageSettings();
  const { data: productData } = useProductPageSettings();
  const { data: generalData } = useGeneralSettings();
  const kontak: ContactPageSetting["kontakInfo"] = data?.kontakInfo ?? null;
  const phone = formatContactPhone(kontak?.telepon ?? DEFAULT_CONTACT_PHONE);
  const email = kontak?.email ?? DEFAULT_CONTACT_EMAIL;
  const productLinks = getProductLinks(productData);

  const footerLogo = (generalData?.logoFooter || generalData?.logo) as Media | null | undefined;
  const siteName = generalData?.namaSitus || "GIMS";

  return (
    <footer className="bg-navy-dark text-white">
      {/* Main footer */}
      <div className="mx-auto max-w-7xl px-6 lg:px-8 py-16">
        <div className="grid gap-10 sm:grid-cols-2 lg:grid-cols-4">
          {/* Brand */}
          <div>
            <Link href="/" className="inline-block mb-5">
              {footerLogo?.url ? (
                <Image
                  src={footerLogo.url}
                  alt={footerLogo.alt || siteName}
                  width={footerLogo.width || 120}
                  height={footerLogo.height || 40}
                  className="h-9 w-auto object-contain brightness-0 invert"
                />
              ) : (
                <span className="text-xl font-bold tracking-tight font-[var(--font-outfit)]">
                  {siteName}
                </span>
              )}
            </Link>
            <p className="text-sm text-white/40 leading-relaxed mb-4">
              PT. Global Inovasi Mitra Solusi. Innovation, Partners, Solutions.
            </p>
            <p className="text-xs text-white/30 leading-relaxed">
              Penyedia layanan infrastruktur dan solusi teknologi terdepan untuk
              menunjang kebutuhan perusahaan Anda.
            </p>
          </div>

          {/* Products */}
          <div>
            <h4 className="text-sm font-bold uppercase tracking-widest text-white/70 mb-5">Products</h4>
            <ul className="flex flex-col gap-2.5">
              {(productLinks.length > 0
                ? productLinks
                : [
                    { label: "GIMS Clean Pipe", href: "/products#clean-pipe" },
                    { label: "Internet Connectivity", href: "/products#internet-connectivity" },
                    { label: "Fiber Connection", href: "/products#fiber-connection" },
                    { label: "Cloud & Colocation", href: "/products#cloud-colocation" },
                    { label: "Managed Services", href: "/products#managed-services" },
                    { label: "Smart Platform & Education", href: "/products#smart-platform-education" },
                  ]
              ).map((item) => (
                <li key={item.href}>
                  <Link href={item.href} className="text-sm text-white/40 hover:text-teal-light transition-colors">
                    {item.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Company */}
          <div>
            <h4 className="text-sm font-bold uppercase tracking-widest text-white/70 mb-5">Company</h4>
            <ul className="flex flex-col gap-2.5">
              {[
                { label: "About Us", href: "/about" },
                { label: "Our Products", href: "/products" },
                { label: "Contacts", href: "/contact" },
              ].map((item) => (
                <li key={item.label}>
                  <Link href={item.href} className="text-sm text-white/40 hover:text-teal-light transition-colors">
                    {item.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Contact Info */}
          <div>
            <h4 className="text-sm font-bold uppercase tracking-widest text-white/70 mb-5">Contact</h4>
            <div className="flex flex-col gap-3 text-sm text-white/40">
              <p>Jl. Taman Kopo Indah 1 M27, Bandung</p>
              <a href={`mailto:${email}`} className="hover:text-teal-light transition-colors">
                {email}
              </a>
              <a href={getTelHref(kontak?.telepon ?? DEFAULT_CONTACT_PHONE)} className="hover:text-teal-light transition-colors">
                {phone}
              </a>  
            </div>
          </div>
        </div>
      </div>

      {/* Bottom bar */}
      <div className="border-t border-white/10">
        <div className="mx-auto max-w-7xl px-6 lg:px-8 py-5 flex flex-col sm:flex-row items-center justify-between gap-3">
          <p className="text-xs text-white/30">
            Copyright &copy; {new Date().getFullYear()} by PT. Global Inovasi Mitra Solusi. All Rights Reserved.
          </p>
        </div>
      </div>
    </footer>
  );
}
