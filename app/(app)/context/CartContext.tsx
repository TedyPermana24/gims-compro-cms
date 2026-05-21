"use client";

import { createContext, useContext, useState, useCallback, ReactNode } from "react";

export interface CartItem {
  id: string;
  name: string;
}

interface CartContextType {
  items: CartItem[];
  addItem: (item: CartItem) => void;
  removeItem: (id: string) => void;
  clearCart: () => void;
  isInCart: (id: string) => boolean;
  totalItems: number;
  isCartOpen: boolean;
  setIsCartOpen: (open: boolean) => void;
  checkoutToWhatsApp: () => void;
}

const CartContext = createContext<CartContextType | undefined>(undefined);

const WHATSAPP_NUMBER = "6202230502080"; // GiMS phone number

export function CartProvider({ children }: { children: ReactNode }) {
  const [items, setItems] = useState<CartItem[]>([]);
  const [isCartOpen, setIsCartOpen] = useState(false);

  const addItem = useCallback((item: CartItem) => {
    setItems((prev) => {
      const existing = prev.find((i) => i.id === item.id);
      if (existing) return prev; // already in cart
      return [...prev, item];
    });
  }, []);

  const removeItem = useCallback((id: string) => {
    setItems((prev) => prev.filter((i) => i.id !== id));
  }, []);

  const clearCart = useCallback(() => {
    setItems([]);
  }, []);

  const isInCart = useCallback(
    (id: string) => items.some((i) => i.id === id),
    [items]
  );

  const totalItems = items.length;

  const checkoutToWhatsApp = useCallback(() => {
    if (items.length === 0) return;

    const itemsList = items
      .map((item, idx) => `${idx + 1}. *${item.name}*`)
      .join("\n");

    const message = encodeURIComponent(
      `Halo GiMS! 👋\n\nSaya tertarik dengan layanan berikut:\n\n${itemsList}\n\nMohon informasi lebih lanjut mengenai harga dan detail layanan.\n\nTerima kasih! 🙏`
    );

    const url = `https://wa.me/${WHATSAPP_NUMBER}?text=${message}`;
    window.open(url, "_blank");
  }, [items]);

  return (
    <CartContext.Provider
      value={{
        items,
        addItem,
        removeItem,
        clearCart,
        isInCart,
        totalItems,
        isCartOpen,
        setIsCartOpen,
        checkoutToWhatsApp,
      }}
    >
      {children}
    </CartContext.Provider>
  );
}

export function useCart() {
  const context = useContext(CartContext);
  if (!context) {
    throw new Error("useCart must be used within a CartProvider");
  }
  return context;
}
