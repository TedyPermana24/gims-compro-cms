import type { ReactNode } from 'react'

type MediaLike = {
  url?: string | null
  thumbnailURL?: string | null
  alt?: string | null
} | string | null | undefined

export function getMediaSrc(media: MediaLike, fallback = ''): string {
  if (typeof media === 'string') {
    return media
  }

  return media?.url || media?.thumbnailURL || fallback
}

export function getMediaAlt(media: MediaLike, fallback = ''): string {
  if (typeof media === 'string') {
    return fallback
  }

  return media?.alt || fallback
}

export function renderLexicalParagraphs(value: unknown, className = 'text-slate-600 leading-relaxed'): ReactNode {
  const root = (value as { root?: { children?: unknown[] } } | undefined)?.root ?? value
  const children = (root as { children?: unknown[] } | undefined)?.children

  if (!Array.isArray(children) || children.length === 0) {
    return null
  }

  return children.map((node: any, index) => {
    if (node?.type !== 'paragraph') {
      return null
    }

    const paragraphText = Array.isArray(node.children)
      ? node.children.map((child: any) => child?.text || '').join('')
      : ''

    return (
      <p key={`${index}`} className={className}>
        {paragraphText}
      </p>
    )
  })
}