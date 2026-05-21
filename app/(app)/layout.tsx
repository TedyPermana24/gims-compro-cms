import type { Metadata } from "next";
import { Inter, Outfit } from "next/font/google";
import "./globals.css";
import Navbar from "./components/Navbar";
import Footer from "./components/Footer";
import FloatingWidgets from "./components/FloatingWidgets";
import { CartProvider } from "./context/CartContext";

const inter = Inter({
  variable: "--font-inter",
  subsets: ["latin"],
  display: "swap",
});

const outfit = Outfit({
  variable: "--font-outfit",
  subsets: ["latin"],
  display: "swap",
});

export const metadata: Metadata = {
  title: "GiMS — PT. Global Inovasi Mitra Solusi",
  description:
    "PT. Global Inovasi Mitra Solusi (GiMS) delivers enterprise IT solutions including network infrastructure, cybersecurity, and cloud services. Your trusted technology partner for digital transformation.",
  keywords: [
    "GiMS",
    "PT Global Inovasi Mitra Solusi",
    "IT solutions",
    "network infrastructure",
    "cybersecurity",
    "cloud services",
    "digital transformation",
    "Indonesia",
  ],
  openGraph: {
    title: "GiMS — PT. Global Inovasi Mitra Solusi",
    description:
      "Enterprise IT solutions — Innovation, Partners, Solutions.",
    type: "website",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html
      lang="en"
      className={`${inter.variable} ${outfit.variable} h-full antialiased`}
    >
      <body className="min-h-full flex flex-col">
        <CartProvider>
          <Navbar />
          <main className="flex-1">{children}</main>
          <Footer />
          <FloatingWidgets />
        </CartProvider>
      </body>
    </html>
  );
}
