import type { Metadata } from "next";
import ProductsPageContent from "./ProductsPageContent";

export const metadata: Metadata = {
  title: "Products — GiMS | Internet, Fiber, Cloud, Clean Pipe & Smart Solutions",
  description:
    "Explore GiMS products: Internet Connectivity, Fiber Connection, Cloud & Colocation, Managed Services, GIMS Clean Pipe, Smart Platform, and Smart Education.",
};

export default function ProductsPage() {
  return <ProductsPageContent />;
}
