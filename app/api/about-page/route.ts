import { getPayload } from 'payload'
import config from '@/payload.config'

export async function GET(request: Request) {
  try {
    const payload = await getPayload({ config })

    const aboutPageSettings = await payload.find({
      collection: 'about-page-settings',
      limit: 1,
      depth: 3,
    })

    return Response.json(aboutPageSettings.docs[0] || null)
  } catch (error) {
    console.error('Error fetching about page settings:', error)
    return Response.json({ error: 'Failed to fetch data' }, { status: 500 })
  }
}
