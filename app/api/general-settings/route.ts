import { getPayload } from 'payload'
import config from '@/payload.config'

export async function GET(request: Request) {
  try {
    const payload = await getPayload({ config })
    
    const generalSettings = await payload.find({
      collection: 'general-settings',
      limit: 1,
      depth: 3,
    })

    return Response.json(generalSettings.docs[0] || null)
  } catch (error) {
    console.error('Error fetching general settings:', error)
    return Response.json({ error: 'Failed to fetch data' }, { status: 500 })
  }
}
