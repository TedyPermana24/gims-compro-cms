"use client";

import { useEffect, useState, useRef } from "react";
import { useCart } from "../context/CartContext";
import { X, Trash2, ShoppingCart, Phone, Mail } from "lucide-react";
import type { ContactPageSetting } from "@/payload-types";
import { useContactPageSettings } from "../../hooks/usePageSettings";

const DEFAULT_CONTACT_EMAIL = "contact@gimsnet.co.id";
const DEFAULT_CONTACT_PHONE = "022 3050 2080";

function formatContactPhone(phone?: string | null) {
  return phone?.trim() || DEFAULT_CONTACT_PHONE;
}

function getWhatsAppNumber(phone?: string | null) {
  const digits = phone?.replace(/\D/g, "") ?? "";

  if (!digits) {
    return DEFAULT_CONTACT_PHONE.replace(/\D/g, "").replace(/^0/, "62");
  }

  if (digits.startsWith("62")) {
    return digits;
  }

  if (digits.startsWith("0")) {
    return `62${digits.slice(1)}`;
  }

  return digits;
}

function getWhatsAppHref(phone?: string | null, message?: string) {
  const number = getWhatsAppNumber(phone);
  const query = message ? `?text=${encodeURIComponent(message)}` : "";
  return `https://wa.me/${number}${query}`;
}

/* ───── WhatsApp Popup ───── */
function WhatsAppPopup({ phone, email }: { phone: string; email: string }) {
  const [open, setOpen] = useState(false);
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    function handleClick(e: MouseEvent) {
      if (ref.current && !ref.current.contains(e.target as Node)) setOpen(false);
    }
    document.addEventListener("mousedown", handleClick);
    return () => document.removeEventListener("mousedown", handleClick);
  }, []);

  return (
    <div ref={ref} className="relative">
      {/* Popup Card */}
      <div
        className={`absolute bottom-full right-0 mb-3 transition-all duration-300 origin-bottom-right ${open
          ? "opacity-100 scale-100 translate-y-0 pointer-events-auto"
          : "opacity-0 scale-95 translate-y-2 pointer-events-none"
          }`}
      >
        <div className="w-[300px] bg-white rounded-2xl shadow-2xl border border-slate-100 overflow-hidden">
          {/* Header */}
          <div className="bg-[#075e54] px-5 py-4">
            <div className="flex items-center justify-between">
              <p className="text-white font-bold text-sm">Hubungi Kami</p>
              <button onClick={() => setOpen(false)} className="w-6 h-6 rounded-full bg-white/20 hover:bg-white/30 flex items-center justify-center transition-colors">
                <X className="w-3 h-3 text-white" />
              </button>
            </div>
            <p className="text-white/70 text-xs mt-1">Tim kami siap membantu Anda</p>
          </div>

          {/* Contact */}
          <div className="p-4 space-y-3">
            <div className="flex items-center gap-3 p-3 rounded-xl border border-slate-100 hover:bg-[#25d366]/5 hover:border-[#25d366]/20 transition-all group">
              <div className="w-10 h-10 rounded-full bg-gradient-to-br from-[#25d366] to-[#128c7e] flex items-center justify-center flex-shrink-0">
                <svg className="w-5 h-5 text-white" viewBox="0 0 24 24" fill="currentColor">
                  <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z" />
                </svg>
              </div>
              <div className="flex-1 min-w-0">
                <p className="text-sm font-bold text-navy-dark">Support GiMS</p>
                <div className="flex items-center gap-1.5 mt-0.5">
                  <Phone className="w-3 h-3 text-slate-400" />
                  <span className="text-xs text-slate-500">{phone}</span>
                </div>
                <div className="flex items-center gap-1.5 mt-1">
                  <Mail className="w-3 h-3 text-slate-400" />
                  <a href={`mailto:${email}`} className="text-xs text-slate-500 hover:text-teal transition-colors break-all">
                    {email}
                  </a>
                </div>
              </div>
              <a
                href={getWhatsAppHref(phone, "Halo GiMS! Saya ingin bertanya mengenai layanan Anda.")}
                target="_blank"
                rel="noopener noreferrer"
                className="text-xs text-[#25d366] font-semibold group-hover:underline flex-shrink-0"
              >
                Chat
              </a>
            </div>
          </div>

          {/* Footer */}
          <div className="bg-slate-50 px-4 py-2.5 border-t border-slate-100">
            <p className="text-[10px] text-slate-400 text-center">PT. Global Inovasi Mitra Solusi</p>
          </div>
        </div>
      </div>

      {/* Toggle Button */}
      <button
        onClick={() => setOpen(!open)}
        className="bg-white shadow-lg rounded-full md:rounded-xl w-14 h-14 md:w-auto md:h-auto md:px-5 md:py-3 flex items-center justify-center whitespace-nowrap border border-slate-100 hover:shadow-xl hover:border-[#25d366]/30 transition-all duration-300 group"
      >
        <p className="text-sm font-semibold text-navy-dark flex items-center gap-2 group-hover:text-[#25d366] transition-colors">
          <svg className="w-7 h-7 md:w-5 md:h-5 text-[#25d366]" viewBox="0 0 24 24" fill="currentColor">
            <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z" />
          </svg>
          <span className="hidden md:block">Apa yang bisa saya Bantu?</span>
        </p>
      </button>
    </div>
  );
}

export default function FloatingWidgets() {
  const {
    items,
    removeItem,
    clearCart,
    totalItems,
    isCartOpen,
    setIsCartOpen,
    checkoutToWhatsApp,
  } = useCart();
  const { data } = useContactPageSettings();
  const kontak: ContactPageSetting["kontakInfo"] = data?.kontakInfo ?? null;
  const phone = formatContactPhone(kontak?.telepon ?? DEFAULT_CONTACT_PHONE);
  const email = kontak?.email ?? DEFAULT_CONTACT_EMAIL;

  // Lock body scroll when cart is open
  useEffect(() => {
    if (isCartOpen) {
      document.body.style.overflow = "hidden";
    } else {
      document.body.style.overflow = "";
    }
    return () => { document.body.style.overflow = ""; };
  }, [isCartOpen]);

  return (
    <>
      {/* ── Fixed bottom-right stack: Cart bubble (top) + WhatsApp bubble (bottom) ── */}
      <div className="fixed bottom-6 right-6 z-[80] flex flex-col items-end gap-3">
        {/* Cart Bubble — only visible when items > 0 */}
        {totalItems > 0 && (
          <div className="flex items-center gap-3">
            <div className="bg-white shadow-lg rounded-xl px-4 py-2.5 whitespace-nowrap border border-slate-100 hidden sm:block">
              <p className="text-sm font-semibold text-navy-dark">
                {totalItems} layanan dipilih
              </p>
            </div>
            <button
              onClick={() => setIsCartOpen(true)}
              className="relative w-14 h-14 rounded-full bg-navy-dark hover:bg-navy-light text-white shadow-lg shadow-navy-dark/30 hover:shadow-navy-dark/50 hover:scale-105 transition-all duration-300 flex items-center justify-center"
              aria-label="Buka keranjang"
            >
              <ShoppingCart className="w-6 h-6" />
              <span className="absolute -top-1 -right-1 w-6 h-6 bg-teal text-white text-[11px] font-bold rounded-full flex items-center justify-center shadow-md">
                {totalItems > 9 ? "9+" : totalItems}
              </span>
            </button>
          </div>
        )}

        {/* WhatsApp — popup with contact info */}
        <WhatsAppPopup phone={phone} email={email} />
      </div>

      {/* ── Cart Modal (centered) ── */}
      <div
        className={`fixed inset-0 z-[85] bg-black/40 backdrop-blur-sm transition-opacity duration-300 flex items-center justify-center p-4 sm:p-6 ${isCartOpen ? "opacity-100 pointer-events-auto" : "opacity-0 pointer-events-none"
          }`}
        onClick={() => setIsCartOpen(false)}
      >
        <div
          className={`relative w-full max-w-md bg-white rounded-2xl shadow-2xl overflow-hidden flex flex-col transition-all duration-300 max-h-full ${isCartOpen ? "scale-100 translate-y-0 opacity-100" : "scale-95 translate-y-4 opacity-0"
            }`}
          onClick={(e) => e.stopPropagation()}
        >
          <div className="flex items-center justify-between px-6 py-5 border-b border-slate-100">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-xl bg-teal/10 flex items-center justify-center">
                <ShoppingCart className="w-5 h-5 text-teal" />
              </div>
              <div>
                <h2 className="text-lg font-bold text-navy-dark font-[var(--font-outfit)]">Keranjang Layanan</h2>
                <p className="text-xs text-slate-400">{totalItems} layanan dipilih</p>
              </div>
            </div>
            <button onClick={() => setIsCartOpen(false)} className="w-9 h-9 rounded-lg bg-slate-100 hover:bg-slate-200 flex items-center justify-center transition-colors" aria-label="Tutup keranjang">
              <X className="w-4 h-4 text-slate-500" />
            </button>
          </div>

          <div className="flex-1 overflow-y-auto px-6 py-4">
            {items.length === 0 ? (
              <div className="flex flex-col items-center justify-center h-full text-center py-12">
                <div className="w-20 h-20 rounded-full bg-slate-50 flex items-center justify-center mb-5">
                  <ShoppingCart className="w-9 h-9 text-slate-300" />
                </div>
                <p className="text-slate-500 font-medium mb-2">Keranjang Kosong</p>
                <p className="text-sm text-slate-400 max-w-[220px]">Tambahkan layanan yang Anda minati ke keranjang.</p>
              </div>
            ) : (
              <ul className="flex flex-col gap-3">
                {items.map((item) => (
                  <li key={item.id} className="group relative bg-slate-50 rounded-xl p-4 transition-all hover:bg-slate-100">
                    <div className="flex items-center justify-between gap-3">
                      <p className="text-sm font-semibold text-navy-dark">{item.name}</p>
                      <button onClick={() => removeItem(item.id)} className="w-7 h-7 rounded-lg text-slate-300 hover:text-red-500 hover:bg-red-50 flex items-center justify-center transition-all flex-shrink-0" aria-label={`Hapus ${item.name}`}>
                        <Trash2 className="w-3.5 h-3.5" />
                      </button>
                    </div>
                  </li>
                ))}
              </ul>
            )}
          </div>

          {items.length > 0 && (
            <div className="border-t border-slate-100 px-6 py-5 space-y-3 bg-white">
              <button onClick={checkoutToWhatsApp} className="w-full flex items-center justify-center gap-2.5 bg-[#075e54] text-white py-3.5 rounded-xl text-sm font-semibold transition-all duration-300 shadow-lg shadow-[#25d366]/20 active:scale-[0.98]">
                <svg className="w-5 h-5" viewBox="0 0 24 24" fill="currentColor">
                  <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z" />
                </svg>
                Checkout via WhatsApp
              </button>
              <button onClick={clearCart} className="w-full flex items-center justify-center gap-2 text-slate-400 hover:text-red-500 py-2 text-xs font-medium transition-colors">
                <Trash2 className="w-3.5 h-3.5" />
                Kosongkan Keranjang
              </button>
            </div>
          )}
        </div>
      </div>
    </>
  );
}
