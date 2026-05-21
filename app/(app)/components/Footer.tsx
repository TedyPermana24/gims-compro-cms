import Link from "next/link";

export default function Footer() {
  return (
    <footer className="bg-navy-dark text-white">
      {/* Main footer */}
      <div className="mx-auto max-w-7xl px-6 lg:px-8 py-16">
        <div className="grid gap-10 sm:grid-cols-2 lg:grid-cols-4">
          {/* Brand */}
          <div>
            <Link href="/" className="inline-block mb-5">
              <span className="text-xl font-bold tracking-tight font-[var(--font-outfit)]">
                GIMS
              </span>
            </Link>
            <p className="text-sm text-white/40 leading-relaxed mb-4">
              PT. Global Inovasi Mitra Solusi — Innovation, Partners, Solutions.
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
              {[
                { label: "GIMS Clean Pipe", href: "/products#clean-pipe" },
                { label: "Internet Connectivity", href: "/products#internet-connectivity" },
                { label: "Fiber Connection", href: "/products#fiber-connection" },
                { label: "Cloud & Colocation", href: "/products#cloud-colocation" },
                { label: "Managed Services", href: "/products#managed-services" },
                { label: "Smart Platform & Education", href: "/products#smart-platform-education" },
              ].map((item) => (
                <li key={item.label}>
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
                { label: "Contact", href: "/contact" },
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
              <a href="mailto:contact@gimsnet.co.id" className="hover:text-teal-light transition-colors">
                contact@gimsnet.co.id
              </a>
              <a href="tel:02230502080" className="hover:text-teal-light transition-colors">
                022 3050 2080
              </a>
              <a href="https://www.gimsnet.co.id" target="_blank" rel="noopener noreferrer" className="hover:text-teal-light transition-colors">
                www.gimsnet.co.id
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
