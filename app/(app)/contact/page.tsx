import type { Metadata } from "next";
import ContactPageContent from "./ContactPageContent";

export const metadata: Metadata = {
  title: "Contact Us — GiMS | PT. Global Inovasi Mitra Solusi",
  description:
    "Get in touch with GiMS — PT. Global Inovasi Mitra Solusi. Contact us for IT infrastructure, cloud services, and managed solutions.",
};

export default function ContactPage() {
  return <ContactPageContent />;
}
