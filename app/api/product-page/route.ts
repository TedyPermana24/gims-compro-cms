import { getPayload } from 'payload'
import config from '@/payload.config'

export async function GET(request: Request) {
  try {
    const payload = await getPayload({ config })

    const productPageSettings = await payload.find({
      collection: 'product-page-settings',
      limit: 1,
      depth: 3,
    })

    return Response.json(productPageSettings.docs[0] || null)
  } catch (error) {
    console.error('Error fetching product page settings:', error)
    return Response.json({ error: 'Failed to fetch data' }, { status: 500 })
  }
}
