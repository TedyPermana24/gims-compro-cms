"use client";

import Link from "next/link";
import Image from "next/image";
import { useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import type { AboutPageSetting, HomePageSetting, ProductPageSetting } from "@/payload-types";
import Reveal from "./components/Reveal";
import { useAboutPageSettings, useHomePageSettings, useProductPageSettings } from "../hooks/usePageSettings";
import { getMediaAlt, getMediaSrc } from "./utils/dbContent";
import {
  Globe,
  Zap,
  Cloud,
  Settings,
  ArrowRight,
  Shield,
  MonitorSmartphone,
  GraduationCap,
  Server,
  Database,
  Lock,
  Wifi,
  Cpu,
  HardDrive,
  Router,
  Network,
  Smartphone,
  Laptop,
  Satellite,
  Radio,
  Signal,
  Gauge,
  Layers,
  Box,
  Briefcase,
  Zap as Lightning,
  Eye,
  CheckCircle,
  AlertCircle,
  Info,
  Hexagon,
  Grid3x3,
  Activity,
  TrendingUp,
  Users,
  User,
  Award,
  Star,
  Heart,
  BarChart,
  BarChart3,
} from "lucide-react";

const iconMap: Record<string, typeof Globe> = {
  'shield': Shield,
  'globe': Globe,
  'zap': Zap,
  'cloud': Cloud,
  'settings': Settings,
  'monitor-smartphone': MonitorSmartphone,
  'graduation-cap': GraduationCap,
  'server': Server,
  'database': Database,
  'lock': Lock,
  'wifi': Wifi,
  'cpu': Cpu,
  'hard-drive': HardDrive,
  'router': Router,
  'network': Network,
  'smartphone': Smartphone,
  'laptop': Laptop,
  'satellite': Satellite,
  'radio': Radio,
  'signal': Signal,
  'gauge': Gauge,
  'layers': Layers,
  'box': Box,
  'briefcase': Briefcase,
  'lightning': Lightning,
  'eye': Eye,
  'check-circle': CheckCircle,
  'alert-circle': AlertCircle,
  'info': Info,
  'hexagon': Hexagon,
  'grid-3x3': Grid3x3,
  'activity': Activity,
  'trending-up': TrendingUp,
  'users': Users,
  'user': User,
  'award': Award,
  'star': Star,
  'heart': Heart,
  'bar-chart': BarChart,
  'bar-chart-3': BarChart3,
};

export default function Home() {
  const router = useRouter();
  const { data: homeSettings, loading: homeLoading } = useHomePageSettings();
  const { data: aboutSettings, loading: aboutLoading } = useAboutPageSettings();
  const { data: productSettings, loading: productLoading } = useProductPageSettings();
  const [current, setCurrent] = useState(0);

  const slides: NonNullable<HomePageSetting["slides"]> = homeSettings?.slides ?? [];
  const about: HomePageSetting["tentangKami"] = homeSettings?.tentangKami ?? null;
  const homeServices: NonNullable<HomePageSetting["layananDiHome"]> = homeSettings?.layananDiHome ?? [];
  const whyChooseUs: AboutPageSetting["mengapaMilihGiMS"] = aboutSettings?.mengapaMilihGiMS ?? null;

  useEffect(() => {
    if (!slides.length) {
      return;
    }

    setCurrent((prev) => prev % slides.length);
  }, [slides.length]);

  // Auto-play
  useEffect(() => {
    if (slides.length < 2) {
      return;
    }

    const timer = setInterval(() => {
      setCurrent((prev) => (prev + 1) % slides.length);
    }, 5000);
    return () => clearInterval(timer);
  }, [slides.length]);

  if (homeLoading || aboutLoading || productLoading || !homeSettings || !aboutSettings || !productSettings) {
    return <div className="min-h-screen bg-white" />;
  }

  return (
    <>
      {/* ── HERO CAROUSEL ── */}
      <section className="relative min-h-[85vh] flex items-center bg-navy-dark overflow-hidden">
        {/* Slides */}
        {slides.map((slide, i) => (
          <div
            key={i}
            className={`absolute inset-0 transition-opacity duration-700 ${i === current ? "opacity-100" : "opacity-0"}`}
          >
            <Image
              src={getMediaSrc(slide.gambar, "/images/hero-network.png")}
              alt={getMediaAlt(slide.gambar, slide.label)}
              fill
              className="object-cover"
              priority={i === 0}
              quality={90}
            />
            <div className="absolute inset-0 bg-gradient-to-r from-navy-dark via-navy-dark/90 to-navy-dark/50" />
          </div>
        ))}

        {/* Geometric accent */}
        <div className="absolute inset-0 opacity-[0.03] pointer-events-none">
          <div className="absolute top-20 right-20 w-[500px] h-[500px] border border-white rounded-full" />
          <div className="absolute bottom-20 right-40 w-[300px] h-[300px] border border-white rounded-full" />
        </div>

        {/* Content */}
        <div className="relative z-10 mx-auto max-w-7xl w-full px-6 lg:px-8 py-32">
          <div className="max-w-2xl grid grid-cols-1 grid-rows-1">
            {slides.map((slide, i) => (
              <div
                key={i}
                className={`col-start-1 row-start-1 ${
                  i === current ? "z-10 visible" : "z-0 invisible"
                }`}
                aria-hidden={i !== current}
              >
                <div
                  key={i === current ? `active-${i}` : `inactive-${i}`}
                  className={i === current ? "hero-stagger" : "opacity-0 pointer-events-none"}
                >
                  <span className="hero-accent-line mb-6" />
                  <p className="text-teal-light text-sm font-semibold tracking-[0.2em] uppercase mb-6">
                    {slide.label}
                  </p>
                  <h1 className="text-4xl sm:text-5xl lg:text-6xl font-bold leading-[1.1] font-[var(--font-outfit)] text-white mb-8">
                    {slide.judul}
                  </h1>
                  <p className="text-white/50 text-lg leading-relaxed mb-10 max-w-xl">
                    {slide.deskripsi}
                  </p>
                  <div className="flex flex-wrap gap-4">
                    <Link
                      href="/about"
                      className="group inline-flex items-center gap-2 bg-teal hover:bg-teal-light text-white px-8 py-3.5 text-sm font-semibold rounded-lg transition-all duration-300 hover:shadow-lg hover:shadow-teal/20"
                      tabIndex={i === current ? 0 : -1}
                    >
                      Selengkapnya
                      <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
                    </Link>
                    <Link
                      href="/products"
                      className="inline-flex items-center gap-2 border border-white/25 text-white hover:bg-white/10 px-8 py-3.5 text-sm font-semibold rounded-lg transition-all duration-300"
                      tabIndex={i === current ? 0 : -1}
                    >
                      Our Products
                    </Link>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Dot indicators */}
        <div className="absolute bottom-8 left-1/2 -translate-x-1/2 z-20 flex gap-2">
          {slides.map((_, i) => (
            <button
              key={i}
              onClick={() => setCurrent(i)}
              className={`transition-all duration-300 rounded-full ${i === current
                ? "w-8 h-2 bg-teal-light"
                : "w-2 h-2 bg-white/30 hover:bg-white/60"
                }`}
            />
          ))}
        </div>
      </section>

      {/* ── ABOUT PREVIEW ── */}
      <section className="py-24 bg-white">
        <div className="mx-auto max-w-7xl px-6 lg:px-8">
          <Reveal>
            <div className="grid gap-12 lg:grid-cols-2 items-center">
              <div>
                <p className="text-teal text-sm font-semibold tracking-[0.2em] uppercase mb-4">
                  {aboutSettings.tentangPerusahaan?.label ?? "About Us"}
                </p>
                <h2 className="text-2xl sm:text-3xl lg:text-4xl font-bold text-navy-dark font-[var(--font-outfit)] mb-6 leading-tight">
                  {about?.judul ?? aboutSettings.tentangPerusahaan?.judul ?? "Solusi Teknologi Informasi & Infrastruktur Jaringan Telekomunikasi"}
                </h2>
                <p className="text-slate-600 leading-relaxed mb-4">
                  {about?.deskripsi}
                </p>
                <Link
                  href="/about"
                  className="group inline-flex items-center gap-2 text-teal font-semibold text-sm hover:text-teal-dark transition-colors"
                >
                  Selengkapnya tentang GiMS
                  <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
                </Link>
              </div>
              <div className="relative">
                <div className="relative aspect-[4/3] rounded-2xl overflow-hidden shadow-2xl">
                  <Image
                    src={getMediaSrc(about?.gambar, "/images/desc-about-us.png")}
                    alt={getMediaAlt(about?.gambar, about?.judul ?? "GiMS")}
                    fill
                    className="object-cover"
                    sizes="(max-width: 1024px) 100vw, 50vw"
                  />
                  <div className="absolute inset-0 bg-gradient-to-t from-navy-dark/30 to-transparent" />
                </div>
                <div className="absolute -bottom-4 -right-4 w-full h-full rounded-2xl border-2 border-teal/20 -z-10" />
              </div>
            </div>
          </Reveal>
        </div>
      </section>

      {/* ── PRODUCTS PREVIEW ── */}
      <section className="py-24 bg-slate-50">
        <div className="mx-auto max-w-7xl px-6 lg:px-8">
          <Reveal>
            <div className="text-center mb-16">
              <p className="text-teal text-sm font-semibold tracking-[0.2em] uppercase mb-4">
                Our Services
              </p>
              <h2 className="text-2xl sm:text-3xl lg:text-4xl font-bold text-navy-dark font-[var(--font-outfit)] mb-4">
                Solusi Lengkap untuk Bisnis Anda
              </h2>
              <p className="text-slate-500 max-w-2xl mx-auto">
                Layanan end-to-end yang terintegrasi untuk mendukung pertumbuhan bisnis Anda.
              </p>
            </div>
          </Reveal>

          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
            {homeServices.map((service, i) => {
              const Icon = service.iconName ? iconMap[service.iconName] : Globe;

              return (
                <Reveal key={service.id} delay={i * 100} className="h-full">
                  <Link
                    href={`/products#${service.slug}`}
                    className="group flex flex-col h-full bg-white rounded-2xl p-8 shadow-sm border border-slate-100 hover:shadow-xl hover:-translate-y-1 transition-all duration-300"
                  >
                    <div className="w-14 h-14 rounded-xl bg-navy-dark/5 flex items-center justify-center mb-6 group-hover:bg-teal/10 transition-colors duration-300 shrink-0">
                      <Icon className="w-7 h-7 text-teal" />
                    </div>
                    <h3 className="text-lg font-bold text-navy-dark font-[var(--font-outfit)] mb-3 group-hover:text-teal transition-colors duration-300">
                      {service.judul}
                    </h3>
                    <p className="text-sm text-slate-500 leading-relaxed mb-6 flex-1">
                      {service.deskripsi}
                    </p>
                    <div className="mt-auto">
                      <span className="inline-flex items-center gap-1 text-xs font-semibold text-teal group-hover:gap-2 transition-all duration-300">
                        Selengkapnya
                        <ArrowRight className="w-3.5 h-3.5" />
                      </span>
                    </div>
                  </Link>
                </Reveal>
              );
            })}
          </div>
        </div>
      </section>

      {/* ── WHY CHOOSE US ── */}
      <section className="relative py-24 bg-navy-dark text-white overflow-hidden">
        <div className="relative z-10 mx-auto max-w-7xl px-6 lg:px-8">
          <Reveal>
            <div className="max-w-2xl mx-auto text-center">
              <p className="text-teal-light text-sm font-semibold tracking-[0.2em] uppercase mb-4">
                {whyChooseUs?.label ?? "Why Choose Us"}
              </p>
              <h2 className="text-2xl sm:text-3xl lg:text-4xl font-bold font-[var(--font-outfit)] mb-4 leading-tight">
                {whyChooseUs?.judul ?? "Mengapa Bermitra dengan GiMS?"}
              </h2>
              <p className="text-white/50 leading-relaxed mb-6">
                {whyChooseUs?.deskripsiSingkat ?? "GiMS adalah perusahaan penyedia infrastruktur teknologi informasi dan komunikasi terdepan yang dapat diandalkan untuk memenuhi kebutuhan perusahaan Anda."}
              </p>
              <button
                onClick={() => router.push("/about#why-choose-us-complete")}
                className="group inline-flex items-center gap-2 text-teal-light font-semibold text-sm hover:text-white transition-colors cursor-pointer"
              >
                Lihat Detail Selengkapnya
                <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
              </button>
            </div>
          </Reveal>
        </div>
      </section>
    </>
  );
}