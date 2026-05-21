import { getPayload } from 'payload'
import config from '@/payload.config'

export async function GET(request: Request) {
  try {
    const payload = await getPayload({ config })
    
    const homePageSettings = await payload.find({
      collection: 'home-page-settings',
      limit: 1,
      depth: 3,
    })

    return Response.json(homePageSettings.docs[0] || null)
  } catch (error) {
    console.error('Error fetching home page settings:', error)
    return Response.json({ error: 'Failed to fetch data' }, { status: 500 })
  }
}
