import type { Metadata } from "next";
import AboutPageContent from "./AboutPageContent";

export const metadata: Metadata = {
  title: "About Us — GiMS | PT. Global Inovasi Mitra Solusi",
  description:
    "Learn about PT. Global Inovasi Mitra Solusi (GiMS) — our vision, mission, core values, and why we are the trusted technology partner for businesses across Indonesia.",
};

export default function AboutPage() {
  return <AboutPageContent />;
}
