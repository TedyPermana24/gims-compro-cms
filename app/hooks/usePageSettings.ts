

import { useEffect, useState } from 'react'

interface CacheEntry {
  data: any
  timestamp: number
}

const cache: Record<string, CacheEntry> = {}
const CACHE_DURATION = 5 * 60 * 1000 // 5 menit

export function usePageSettings(endpoint: string) {
  const [data, setData] = useState<any>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    const fetchData = async () => {
      try {
        // Cek cache terlebih dahulu
        const cached = cache[endpoint]
        if (cached && Date.now() - cached.timestamp < CACHE_DURATION) {
          setData(cached.data)
          setLoading(false)
          return
        }

        const response = await fetch(endpoint)
        if (!response.ok) {
          throw new Error(`Failed to fetch: ${response.statusText}`)
        }

        const result = await response.json()

        // Simpan ke cache
        cache[endpoint] = {
          data: result,
          timestamp: Date.now(),
        }

        setData(result)
        setError(null)
      } catch (err) {
        const errorMessage = err instanceof Error ? err.message : 'Unknown error'
        setError(errorMessage)
        console.error(`Error fetching ${endpoint}:`, err)
      } finally {
        setLoading(false)
      }
    }

    fetchData()
  }, [endpoint])

  return { data, loading, error }
}

export function useHomePageSettings() {
  return usePageSettings('/api/home-page')
}

export function useAboutPageSettings() {
  return usePageSettings('/api/about-page')
}

export function useProductPageSettings() {
  return usePageSettings('/api/product-page')
}

export function useContactPageSettings() {
  return usePageSettings('/api/contact-page')
}

export function useGeneralSettings() {
  return usePageSettings('/api/general-settings')
}
