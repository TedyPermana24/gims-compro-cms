"use client";

import Link from "next/link";
import Image from "next/image";
import type { ProductPageSetting } from "@/payload-types";
import Reveal from "../components/Reveal";
import { useCart } from "../context/CartContext";
import { ArrowRight, ShoppingCart, Check } from "lucide-react";
import { useState, useCallback, useEffect, useRef } from "react";
import { useProductPageSettings } from "../../hooks/usePageSettings";
import { getMediaAlt, getMediaSrc, renderLexicalParagraphs } from "../utils/dbContent";

type ProductDescription = {
  nama: string;
  deskripsi: unknown;
  id?: string | null;
};

type ProductCategory = {
  id: string;
  judul: string;
  gambar: unknown;
  altGambar: string;
  intro: string;
  produkList?: ProductDescription[] | null;
};

function AddToCategoryCartButton({ categoryId, categoryTitle }: { categoryId: string; categoryTitle: string }) {
  const { addItem, removeItem, isInCart } = useCart();
  const [justAdded, setJustAdded] = useState(false);
  const inCart = isInCart(categoryId);

  const handleToggle = useCallback(() => {
    if (inCart) {
      removeItem(categoryId);
    } else {
      addItem({ id: categoryId, name: categoryTitle });
      setJustAdded(true);
      setTimeout(() => setJustAdded(false), 1500);
    }
  }, [addItem, removeItem, categoryId, categoryTitle, inCart]);

  return (
    <button
      onClick={handleToggle}
      className={`inline-flex items-center gap-2 px-5 py-2.5 rounded-xl text-sm font-semibold transition-all duration-300 active:scale-95 ${justAdded
        ? "bg-green-500 text-white shadow-lg shadow-green-500/25"
        : inCart
          ? "bg-teal text-white shadow-lg shadow-teal/25 hover:bg-red-500 hover:shadow-red-500/25"
          : "bg-navy-dark text-white hover:bg-navy-light shadow-lg shadow-navy-dark/15 hover:shadow-navy-dark/25"
        }`}
    >
      {justAdded ? (
        <><Check className="w-4 h-4" /> Ditambahkan!</>
      ) : inCart ? (
        <><Check className="w-4 h-4" /> Sudah di Keranjang</>
      ) : (
        <> Tambah ke Keranjang</>
      )}
    </button>
  );
}

export default function ProductsPageContent() {
  const [activeSection, setActiveSection] = useState<string>("");
  const navRef = useRef<HTMLDivElement>(null);
  const { data, loading } = useProductPageSettings();

  const productCategories: NonNullable<ProductPageSetting["kategoriProduk"]> = data?.kategoriProduk ?? [];

  useEffect(() => {
    if (!productCategories.length) {
      return;
    }

    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            setActiveSection(entry.target.id);
          }
        });
      },
      {
        rootMargin: "-120px 0px -60% 0px", // Trigger when section is near the top
        threshold: 0,
      }
    );

    productCategories.forEach((cat) => {
      const element = document.getElementById(cat.id);
      if (element) observer.observe(element);
    });

    return () => observer.disconnect();
  }, [productCategories]);

  // Auto-scroll the sticky nav so the active item is always visible
  useEffect(() => {
    if (activeSection && navRef.current) {
      const activeLink = navRef.current.querySelector<HTMLAnchorElement>(`a[href="#${activeSection}"]`);
      if (activeLink) {
        activeLink.scrollIntoView({ behavior: "smooth", inline: "center", block: "nearest" });
      }
    }
  }, [activeSection]);

  if (loading || !data) {
    return <div className="min-h-screen bg-white" />;
  }

  return (
    <>
      {/* Page Header */}
      <section className="relative pt-28 pb-16 lg:pt-36 lg:pb-20 bg-navy-dark overflow-hidden">
        <div className="absolute inset-0 opacity-10">
          <Image src={getMediaSrc(productCategories[0]?.gambar, "/images/tech-growth.png")} alt="" fill className="object-cover" priority aria-hidden="true" />
        </div>
        <div className="absolute top-0 inset-x-0 h-1 bg-gradient-to-r from-teal via-teal-light to-teal" />
        <div className="relative z-10 mx-auto max-w-7xl px-6 lg:px-8">
          <div className="flex items-center gap-2 text-sm text-white/40 mb-6">
            <Link href="/" className="hover:text-white transition-colors">Home</Link>
            <span>/</span>
            <span className="text-white/70">{data.judul}</span>
          </div>
          <h1 className="text-3xl sm:text-4xl lg:text-5xl font-bold font-[var(--font-outfit)] text-white mb-4">{data.judul}</h1>
          <p className="max-w-3xl text-white/50 text-lg leading-relaxed">
            {data.deskripsiSingkat}
          </p>
        </div>
      </section>

      {/* Sticky Category Nav */}
      <nav className="sticky top-[64px] z-40 bg-white border-b border-slate-200 shadow-sm">
        <div className="mx-auto max-w-7xl px-6 lg:px-8">
          <div ref={navRef} className="flex gap-0 overflow-x-auto scrollbar-hide">
            {productCategories.map((cat) => (
              <a 
                key={cat.id} 
                href={`#${cat.id}`} 
                className={`flex-shrink-0 inline-flex items-center gap-2 px-5 py-4 text-sm font-medium transition-all duration-200 whitespace-nowrap border-b-2 ${
                  activeSection === cat.id 
                    ? "text-teal-dark border-teal font-bold bg-slate-50/50" 
                    : "text-slate-500 hover:text-navy border-transparent hover:border-teal/50"
                }`}
              >
                {cat.judul}
              </a>
            ))}
          </div>
        </div>
      </nav>

      {/* Product Category Sections */}
      {productCategories.map((category, ci) => (
        <section key={category.id} id={category.id} className={`scroll-mt-28 ${ci % 2 === 0 ? "bg-white" : "bg-slate-50"}`}>
          {/* Category Hero */}
          <div className="py-20">
            <div className="mx-auto max-w-7xl px-6 lg:px-8">
              <Reveal>
                <div className="grid gap-12 lg:grid-cols-2 items-center">
                  <div className={ci % 2 !== 0 ? "lg:order-2" : ""}>
                    <p className="text-teal text-sm font-semibold tracking-[0.2em] uppercase mb-4">// {category.id}</p>
                    <h2 className="text-2xl sm:text-3xl font-bold text-navy-dark font-[var(--font-outfit)] mb-6">{category.judul}</h2>
                    <p className="text-slate-500 leading-relaxed mb-8">{category.intro}</p>
                    <AddToCategoryCartButton categoryId={category.id} categoryTitle={category.judul} />
                  </div>
                  <div className={`relative ${ci % 2 !== 0 ? "lg:order-1" : ""}`}>
                    <div className="relative aspect-[16/10] rounded-2xl overflow-hidden shadow-xl">
                      <Image src={getMediaSrc(category.gambar, "/images/cloud-infra.png")} alt={getMediaAlt(category.gambar, category.altGambar)} fill className="object-cover" sizes="(max-width: 1024px) 100vw, 50vw" />
                      <div className="absolute inset-0 bg-gradient-to-t from-navy-dark/20 to-transparent" />
                    </div>
                  </div>
                </div>
              </Reveal>
            </div>
          </div>

          {/* Individual Products  */}
          {category.produkList && category.produkList.length > 0 && (
            <div className={`pb-20 ${ci % 2 === 0 ? "bg-white" : "bg-slate-50"}`}>
              <div className="mx-auto max-w-7xl px-6 lg:px-8">
                <div className="flex flex-col">
                  {category.produkList?.map((product, pi) => (
                    <Reveal key={product.id ?? product.nama} delay={pi * 60}>
                      <article className={`grid gap-6 lg:gap-10 lg:grid-cols-5 items-start py-10 ${pi > 0 ? "border-t border-slate-200" : ""}`}>
                        <div className="lg:col-span-2">
                          <span className="text-xs text-teal font-mono font-semibold">{String(pi + 1).padStart(2, "0")}</span>
                          <h3 className="text-lg font-bold text-navy-dark font-[var(--font-outfit)] mt-1">{product.nama}</h3>
                        </div>
                        <div className="lg:col-span-3">
                          <div className="text-slate-600 leading-relaxed space-y-4">
                            {renderLexicalParagraphs(product.deskripsi)}
                          </div>
                        </div>
                      </article>
                    </Reveal>
                  ))}
                </div>
              </div>
            </div>
          )}
        </section>
      ))}

      {/* CTA */}
      <section className="py-20 bg-navy-dark text-white">
        <div className="mx-auto max-w-4xl px-6 lg:px-8 text-center">
          <Reveal>
            <h2 className="text-2xl sm:text-3xl font-bold font-[var(--font-outfit)] mb-4">Solusi Lengkap untuk Transformasi Digital Anda</h2>
            <p className="text-white/50 mb-8 max-w-2xl mx-auto leading-relaxed">
              Dari infrastruktur jaringan hingga cloud services — GiMS menghadirkan solusi end-to-end
              yang terintegrasi untuk mendukung pertumbuhan bisnis Anda.
            </p>
            <div className="flex flex-wrap justify-center gap-4">
              <Link href="/contact" className="group inline-flex items-center gap-2 bg-teal hover:bg-teal-light text-white px-7 py-3 text-sm font-semibold rounded-lg transition-all duration-300">
                Hubungi Kami <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
              </Link>
              <Link href="/about" className="inline-flex items-center gap-2 border border-white/20 text-white hover:bg-white/10 px-7 py-3 text-sm font-semibold rounded-lg transition-all duration-300">
                About GiMS
              </Link>
            </div>
          </Reveal>
        </div>
      </section>
    </>
  );
}
