"use client";

import { useState, useEffect, useRef } from "react";
import Link from "next/link";
import Image from "next/image";
import { usePathname } from "next/navigation";
import type { ContactPageSetting, Media } from "@/payload-types";
import { useContactPageSettings } from "../../hooks/usePageSettings";
import type { ProductPageSetting } from "@/payload-types";
import { useProductPageSettings, useGeneralSettings } from "../../hooks/usePageSettings";

const DEFAULT_CONTACT_EMAIL = "contact@gimsnet.co.id";

function formatContactPhone(phone?: string | null) {
  return phone?.trim() || "022 3050 2080";
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

const navLinks = [
  { href: "/", label: "Home" },
  { href: "/about", label: "About Us" },
  {
    href: "/products",
    label: "Our Products",
    submenu: [
      { href: "/products#clean-pipe", label: "GIMS Clean Pipe" },
      { href: "/products#internet-connectivity", label: "Internet Connectivity" },
      { href: "/products#fiber-connection", label: "Fiber Connection" },
      { href: "/products#cloud-colocation", label: "Cloud & Colocation" },
      { href: "/products#managed-services", label: "Managed Services" },
      { href: "/products#smart-platform-education", label: "Smart Platform & Education" },
    ],
  },
  { href: "/contact", label: "Contacts" },
];

export default function Navbar() {
  const [scrolled, setScrolled] = useState(false);
  const [mobileOpen, setMobileOpen] = useState(false);
  const [dropdownOpen, setDropdownOpen] = useState(false);
  const dropdownRef = useRef<HTMLLIElement>(null);
  const pathname = usePathname();
  const { data } = useContactPageSettings();
  const { data: productData } = useProductPageSettings();
  const { data: generalData } = useGeneralSettings();
  const kontak: ContactPageSetting["kontakInfo"] = data?.kontakInfo ?? null;
  const phone = formatContactPhone(kontak?.telepon);
  const email = kontak?.email ?? DEFAULT_CONTACT_EMAIL;
  const productLinks = getProductLinks(productData);

  const logo = generalData?.logo as Media | null | undefined;
  const siteName = generalData?.namaSitus || "GIMS";

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 10);
    window.addEventListener("scroll", onScroll, { passive: true });
    return () => window.removeEventListener("scroll", onScroll);
  }, []);

  useEffect(() => {
    function handleClickOutside(e: MouseEvent) {
      if (dropdownRef.current && !dropdownRef.current.contains(e.target as Node)) {
        setDropdownOpen(false);
      }
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  useEffect(() => {
    setMobileOpen(false);
    setDropdownOpen(false);
  }, [pathname]);

  const isActive = (href: string) => {
    if (href === "/") return pathname === "/";
    return pathname?.startsWith(href) ?? false;
  };

  return (
    <>
      {/* Top Bar */}
      <div className="hidden lg:block bg-navy-dark text-white/60 text-xs">
        <div className="mx-auto max-w-7xl px-6 lg:px-8 flex items-center justify-between py-2">
          <div className="flex items-center gap-6">
            <a href={getTelHref(kontak?.telepon)} className="flex items-center gap-1.5 hover:text-white transition-colors">
              <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
              </svg>
              {phone}
            </a>
            <a href={`mailto:${email}`} className="flex items-center gap-1.5 hover:text-white transition-colors">
              <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
              </svg>
              {email}
            </a>
          </div>
        </div>
      </div>

      {/* Main Nav */}
      <header
        id="navbar"
        className={`sticky top-0 z-50 transition-shadow duration-300 bg-white ${scrolled ? "shadow-md" : "shadow-sm"}`}
      >
        <nav className="mx-auto max-w-7xl flex items-center justify-between px-6 lg:px-8 h-16">
          {/* Logo */}
          <Link href="/" className="flex items-center gap-2">
            {logo?.url ? (
              <Image
                src={logo.url}
                alt={logo.alt || siteName}
                width={logo.width || 120}
                height={logo.height || 40}
                className="h-9 w-auto object-contain"
                priority
              />
            ) : (
              <span className="text-xl font-bold tracking-tight font-[var(--font-outfit)] text-navy-dark">
                {siteName}
              </span>
            )}
          </Link>

          {/* Desktop Nav */}
          <ul className="hidden lg:flex items-center gap-0">
            {navLinks.map((link) =>
              link.submenu ? (
                <li key={link.href} ref={dropdownRef} className="relative">
                  <button
                    onClick={() => setDropdownOpen(!dropdownOpen)}
                    className={`px-4 py-5 text-sm font-medium transition-colors inline-flex items-center gap-1 border-b-2 ${isActive(link.href)
                      ? "text-navy-dark border-teal"
                      : "text-slate-500 border-transparent hover:text-navy-dark hover:border-teal"
                      }`}
                  >
                    {link.label}
                    <svg
                      className={`w-3 h-3 transition-transform duration-200 ${dropdownOpen ? "rotate-180" : ""}`}
                      fill="none" stroke="currentColor" viewBox="0 0 24 24"
                    >
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                    </svg>
                  </button>
                  <div
                    className={`absolute top-full left-0 mt-0 w-64 transition-all duration-200 ${dropdownOpen
                      ? "opacity-100 translate-y-0 pointer-events-auto"
                      : "opacity-0 -translate-y-1 pointer-events-none"
                      }`}
                  >
                    <div className="bg-white border border-slate-200 shadow-lg py-2">
                      <Link href="/products" className="block px-5 py-2.5 text-sm font-semibold text-navy-dark hover:bg-slate-50 transition-colors" onClick={() => setDropdownOpen(false)}>
                        All Products
                      </Link>
                      <div className="border-t border-slate-100 my-1" />
                      {(productLinks.length > 0 ? productLinks : link.submenu).map((item) => (
                        <Link key={item.href} href={item.href} className="block px-5 py-2.5 text-sm text-slate-500 hover:bg-slate-50 hover:text-navy-dark transition-colors" onClick={() => setDropdownOpen(false)}>
                          {item.label}
                        </Link>
                      ))}
                    </div>
                  </div>
                </li>
              ) : (
                <li key={link.href}>
                  <Link href={link.href} className={`block px-4 py-5 text-sm font-medium transition-colors border-b-2 ${isActive(link.href) ? "text-navy-dark border-teal" : "text-slate-500 border-transparent hover:text-navy-dark hover:border-teal"}`}>
                    {link.label}
                  </Link>
                </li>
              )
            )}
          </ul>

          {/* Mobile toggle */}
          <button
            id="mobile-menu-toggle"
            className="lg:hidden w-10 h-10 flex items-center justify-center"
            onClick={() => setMobileOpen(!mobileOpen)}
            aria-label="Toggle menu"
          >
            <div className="flex flex-col gap-1.5">
              <span className={`block h-0.5 w-6 bg-navy-dark transition-all duration-300 ${mobileOpen ? "rotate-45 translate-y-2" : ""}`} />
              <span className={`block h-0.5 w-6 bg-navy-dark transition-all duration-300 ${mobileOpen ? "opacity-0" : ""}`} />
              <span className={`block h-0.5 w-6 bg-navy-dark transition-all duration-300 ${mobileOpen ? "-rotate-45 -translate-y-2" : ""}`} />
            </div>
          </button>
        </nav>

        {/* Mobile menu */}
        <div className={`lg:hidden overflow-hidden transition-all duration-300 ${mobileOpen ? "max-h-[600px]" : "max-h-0"}`}>
          <div className="border-t border-slate-100 px-6 py-4">
            <ul className="flex flex-col gap-0">
              {navLinks.map((link) => (
                <li key={link.href}>
                  <Link href={link.href} className={`block py-3 text-sm font-medium border-b border-slate-50 ${isActive(link.href) ? "text-navy-dark" : "text-slate-500"}`}>
                    {link.label}
                  </Link>
                  {link.submenu && (
                    <ul className="ml-4">
                      {(productLinks.length > 0 ? productLinks : link.submenu).map((item) => (
                        <li key={item.href}>
                          <Link href={item.href} className="block py-2 text-xs text-slate-400 hover:text-navy-dark">
                            {item.label}
                          </Link>
                        </li>
                      ))}
                    </ul>
                  )}
                </li>
              ))}
            </ul>
          </div>
        </div>
      </header>
    </>
  );
}
