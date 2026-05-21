import { withPayload } from "@payloadcms/next/withPayload";
import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  images: {
    qualities: [25, 50, 75, 90, 100],
  },
  allowedDevOrigins: ['10.15.1.59'],
};

export default withPayload(nextConfig);
