"use client";

import { useEffect, useRef } from "react";
import Link from "next/link";
import Image from "next/image";
import type { AboutPageSetting } from "@/payload-types";
import Reveal from "../components/Reveal";
import { ArrowRight } from "lucide-react";
import { useAboutPageSettings } from "../../hooks/usePageSettings";
import { getMediaAlt, getMediaSrc } from "../utils/dbContent";

function IndonesiaMap({ coverageAreas }: { coverageAreas: { name: string; lat: number; lng: number }[] }) {
  const svgRef = useRef<SVGSVGElement>(null);
  const tooltipRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    let cancelled = false;

    async function draw() {
      const [d3mod, topoMod, worldData] = await Promise.all([
        import("d3"),
        import("topojson-client"),
        fetch("/data/countries-110m.json").then((r) => r.json()),
      ]);
      if (cancelled || !svgRef.current) return;

      const d3 = d3mod;
      const topo = topoMod;

      const countries = topo.feature(worldData, worldData.objects.countries as any) as any;
      const indonesia = {
        type: "FeatureCollection" as const,
        features: countries.features.filter((f: any) => f.id === "360"),
      };

      const svg = d3.select(svgRef.current);
      svg.selectAll("*").remove();

      const seaFill = "#0f172a";
      const landFill = "#162032";
      const landStroke = "#1e3a4a";
      const dotColor = "#14b8a6";

      const projection = d3.geoMercator().fitSize([680, 300], indonesia);
      const path = d3.geoPath().projection(projection);

      svg.append("g")
        .selectAll("path")
        .data(indonesia.features)
        .join("path")
        .attr("d", path as any)
        .attr("fill", landFill)
        .attr("stroke", landStroke)
        .attr("stroke-width", 0.8);

        coverageAreas.forEach((city) => {
        const coords = projection([city.lng, city.lat]);
        if (!coords) return;
        const [cx, cy] = coords;

        const g = svg.append("g").style("cursor", "pointer");

        g.append("circle")
          .attr("cx", cx).attr("cy", cy).attr("r", 9)
          .attr("fill", `${dotColor}22`)
          .attr("stroke", `${dotColor}44`)
          .attr("stroke-width", 0.5);

        g.append("circle")
          .attr("cx", cx).attr("cy", cy).attr("r", 3.5)
          .attr("fill", dotColor)
          .attr("stroke", "#0f172a")
          .attr("stroke-width", 1.5);

        g.on("mouseenter", (e: MouseEvent) => {
          if (!tooltipRef.current || !svgRef.current) return;
          const rect = svgRef.current.getBoundingClientRect();
          tooltipRef.current.textContent = city.name;
          tooltipRef.current.style.display = "block";
          tooltipRef.current.style.left = `${e.clientX - rect.left + 12}px`;
          tooltipRef.current.style.top = `${e.clientY - rect.top - 34}px`;
        })
          .on("mousemove", (e: MouseEvent) => {
            if (!tooltipRef.current || !svgRef.current) return;
            const rect = svgRef.current.getBoundingClientRect();
            tooltipRef.current.style.left = `${e.clientX - rect.left + 12}px`;
            tooltipRef.current.style.top = `${e.clientY - rect.top - 34}px`;
          })
          .on("mouseleave", () => {
            if (tooltipRef.current) tooltipRef.current.style.display = "none";
          });
      });
    }

    draw();
    return () => { cancelled = true; };
  }, []);

  return (
    <div className="relative w-full">
      <svg
        ref={svgRef}
        className="w-full h-auto"
        viewBox="0 0 680 300"
      />
      <div
        ref={tooltipRef}
        className="hidden absolute pointer-events-none z-10
          bg-navy-dark/90 border border-white/10
          rounded-lg px-3 py-1.5 text-xs font-medium text-white
          whitespace-nowrap backdrop-blur-sm"
      />
    </div>
  );
}

export default function AboutPageContent() {
  const { data, loading } = useAboutPageSettings();

  if (loading || !data) {
    return <div className="min-h-screen bg-white" />;
  }

  const aboutCompany: AboutPageSetting["tentangPerusahaan"] = data.tentangPerusahaan ?? null;
  const visionMission: AboutPageSetting["visiMisi"] = data.visiMisi ?? null;
  const coreValues: NonNullable<NonNullable<AboutPageSetting["nilaiInti"]>["nilaiList"]> = data.nilaiInti?.nilaiList ?? [];
  const whyChooseUs: AboutPageSetting["mengapaMilihGiMS"] = data.mengapaMilihGiMS ?? null;
  const coverageAreas: { name: string; lat: number; lng: number }[] = (data.wilayahJangkauan?.kotaList ?? []).map((city: NonNullable<NonNullable<AboutPageSetting["wilayahJangkauan"]>["kotaList"]>[number]) => ({
    name: city.nama,
    lat: city.latitude,
    lng: city.longitude,
  }));

  return (
    <>
      {/* Page Header */}
      <section className="relative pt-28 pb-16 lg:pt-36 lg:pb-20 bg-navy-dark overflow-hidden">
        <div className="absolute inset-0 opacity-10">
          <Image src={getMediaSrc(aboutCompany?.gambar?.utama, "/images/tech-growth.png")} alt="" fill className="object-cover" priority aria-hidden="true" />
        </div>
        <div className="absolute top-0 inset-x-0 h-1 bg-gradient-to-r from-teal via-teal-light to-teal" />
        <div className="relative z-10 mx-auto max-w-7xl px-6 lg:px-8">
          <div className="flex items-center gap-2 text-sm text-white/40 mb-6">
            <Link href="/" className="hover:text-white transition-colors">Home</Link>
            <span>/</span>
            <span className="text-white/70">{data.judul}</span>
          </div>
          <h1 className="text-3xl sm:text-4xl lg:text-5xl font-bold font-[var(--font-outfit)] text-white mb-4">{data.judul}</h1>
          <p className="max-w-3xl text-white/50 text-lg leading-relaxed">
            {data.deskripsiSingkat}
          </p>
        </div>
      </section>

      {/* Company Profile — Narrative Layout  */}
      <section className="py-24 bg-white">
        <div className="mx-auto max-w-7xl px-6 lg:px-8">
          <Reveal>
            <div className="grid gap-16 lg:grid-cols-5 items-start">
              <div className="lg:col-span-3">
                <p className="text-teal text-sm font-semibold tracking-[0.2em] uppercase mb-4">{aboutCompany?.label ?? "Company Profile"}</p>
                <h2 className="text-2xl sm:text-3xl font-bold text-navy-dark font-[var(--font-outfit)] mb-8">
                  {aboutCompany?.judul ?? data.judul}
                </h2>
                <div className="flex flex-col gap-6 text-slate-600 leading-relaxed">
                  {aboutCompany?.paragraf?.map((paragraph) => (
                    <p key={paragraph.id ?? paragraph.teks.slice(0, 24)}>{paragraph.teks}</p>
                  ))}
                </div>
              </div>
              <div className="lg:col-span-2">
                <div className="relative h-[420px]">

                  {/* Gambar utama — besar, posisi kiri atas */}
                  <div className="absolute top-0 left-0 w-[80%] h-[260px] rounded-2xl overflow-hidden shadow-xl z-10">
                    <Image
                      src={getMediaSrc(aboutCompany?.gambar?.utama, "/images/cloud-infra.png")}
                      alt={getMediaAlt(aboutCompany?.gambar?.utama, "Team")}
                      fill
                      className="object-cover"
                    />
                  </div>

                  {/* Gambar kanan — menimpa sudut kanan gambar utama */}
                  <div className="absolute top-16 right-0 w-[50%] h-[200px] rounded-2xl overflow-hidden shadow-xl z-20 border-4 border-white">
                    <Image
                      src={getMediaSrc(aboutCompany?.gambar?.kanan, "/images/datacenter.png")}
                      alt={getMediaAlt(aboutCompany?.gambar?.kanan, "Infrastructure")}
                      fill
                      className="object-cover"
                    />
                  </div>

                  {/* Gambar bawah — menimpa kedua gambar di atas */}
                  <div className="absolute bottom-0 left-10 w-[60%] h-[180px] rounded-2xl overflow-hidden shadow-xl z-30 border-4 border-white">
                    <Image
                      src={getMediaSrc(aboutCompany?.gambar?.bawah, "/images/fiber-optic.png")}
                      alt={getMediaAlt(aboutCompany?.gambar?.bawah, "Network")}
                      fill
                      className="object-cover"
                    />
                  </div>

                </div>
              </div>
            </div>
          </Reveal>
        </div>
      </section>

      {/* Vision & Mission */}
      <section className="relative py-24 bg-slate-50 overflow-hidden">
        <div className="relative z-10 mx-auto max-w-7xl px-6 lg:px-8">

          {/* Label — di atas grid, full width */}
          <Reveal>
            <div className="w-10 h-0.5 bg-teal mb-6" />
            <p className="text-teal text-xs font-semibold tracking-[0.2em] uppercase mb-10">
              {visionMission?.label ?? "Vision & Mission"}
            </p>
          </Reveal>

          <div className="grid grid-cols-1 lg:grid-cols-[360px_1fr] gap-12 lg:gap-16 items-start">

            {/* Kolom Kiri — Gambar */}
            <Reveal variant="left" className="hidden lg:flex flex-col gap-4 sticky top-28">
              <div className="relative w-full aspect-[3/4] flex items-center justify-center">
                <Image
                    src={getMediaSrc(visionMission?.gambar, "/images/vision-mision.png")}
                    alt={getMediaAlt(visionMission?.gambar, "Visi dan Misi GiMS")}
                  fill
                  sizes="(max-width: 1024px) 100vw, 50vw"
                  className="object-contain object-center scale-[2.0] xl:scale-[2.2] origin-center"
                />
              </div>
            </Reveal>

            {/* Kolom Kanan — Visi & Misi */}
            <div>
              {/* Vision */}
              <Reveal>
                <div className="grid grid-cols-1 lg:grid-cols-[140px_1fr] gap-6 lg:gap-12 py-8 border-t border-slate-200">
                  <div>
                    <p className="text-5xl font-semibold leading-none tracking-tight text-navy-dark font-[var(--font-outfit)]">
                      Visi
                    </p>
                    <p className="text-xs font-semibold tracking-[0.15em] uppercase text-teal mt-3">
                      Vision
                    </p>
                  </div>
                  <p className="text-base leading-relaxed text-slate-500 self-center">
                    {visionMission?.visi?.deskripsi}
                  </p>
                </div>
              </Reveal>

              {/* Mission */}
              <Reveal>
                <div className="grid grid-cols-1 lg:grid-cols-[140px_1fr] gap-6 lg:gap-12 py-8 border-t border-b border-slate-200">
                  <div>
                    <p className="text-5xl font-semibold leading-none tracking-tight text-navy-dark font-[var(--font-outfit)]">
                      Misi
                    </p>
                    <p className="text-xs font-semibold tracking-[0.15em] uppercase text-teal mt-3">
                      Mission
                    </p>
                  </div>
                  <ol className="flex flex-col self-center">
                    {visionMission?.misi?.map((point, i) => (
                      <li
                        key={point.id ?? point.teks.slice(0, 24)}
                        className="flex items-start gap-4 py-3 border-b border-slate-100 last:border-b-0 first:border-t first:border-slate-100"
                      >
                        <span className="text-xs font-semibold text-teal/40 pt-1 min-w-[20px] tabular-nums">
                          {String(i + 1).padStart(2, "0")}
                        </span>
                        <p className="text-sm leading-relaxed text-slate-500">{point.teks}</p>
                      </li>
                    ))}
                  </ol>
                </div>
              </Reveal>
            </div>

          </div>
        </div>
      </section>

      {/* Core Values */}
      <section className="py-24 bg-white">
        <div className="mx-auto max-w-7xl px-6 lg:px-8">
          <Reveal>
            <p className="text-teal text-sm font-semibold tracking-[0.2em] uppercase mb-4">{data.nilaiInti?.label ?? "Core Values"}</p>
            <h2 className="text-2xl sm:text-3xl font-bold text-navy-dark font-[var(--font-outfit)] mb-4">Nilai-Nilai Inti G.I.M.S.</h2>
            <p className="text-slate-500 mb-16 max-w-3xl">
              {data.nilaiInti?.deskripsiSingkat ?? "Nilai-nilai inti yang membentuk identitas GiMS dan menjadi fondasi dalam setiap layanan kami."}
            </p>
          </Reveal>
          <div className="grid gap-8 sm:grid-cols-2 lg:grid-cols-4">
            {coreValues.map((cv, i) => {
              return (
                <Reveal key={cv.id ?? cv.huruf} delay={i * 100}>
                  <div className="group bg-slate-50 hover:bg-navy-dark rounded-2xl p-8 transition-all duration-500 h-full">
                    <span className="text-5xl font-black text-teal/20 group-hover:text-teal-light/30 font-[var(--font-outfit)] transition-colors duration-500">{cv.huruf}</span>
                    <h3 className="text-lg font-bold text-navy-dark group-hover:text-white font-[var(--font-outfit)] mb-1 transition-colors duration-500">{cv.judul}</h3>
                    <p className="text-xs font-semibold text-teal group-hover:text-teal-light mb-3 transition-colors duration-500">({cv.subtitle})</p>
                    <p className="text-sm text-slate-500 group-hover:text-white/50 leading-relaxed transition-colors duration-500">{cv.deskripsi}</p>
                  </div>
                </Reveal>
              );
            })}
          </div>
        </div>
      </section>

      {/* Why Choose Us */}
      <section id="why-choose-us-complete" className="py-24 bg-slate-50 scroll-mt-20 overflow-hidden">
        <div className="mx-auto max-w-7xl px-6 lg:px-8">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-16 lg:gap-24 items-center">

            {/* Left — Content */}
            <div>
              <Reveal>
                <p className="text-teal text-xs font-semibold tracking-[0.2em] uppercase mb-2">
                  {whyChooseUs?.label ?? "Why Choose Us"}
                </p>
                <h2 className="text-2xl sm:text-3xl font-bold text-navy-dark font-[var(--font-outfit)] mb-4">
                  {whyChooseUs?.judul ?? "Kenapa Memilih GiMS?"}
                </h2>
                <p className="text-sm text-slate-400 leading-relaxed mb-12 max-w-md">
                  {whyChooseUs?.deskripsiSingkat}
                </p>
              </Reveal>

              <div className="flex flex-col">
                {whyChooseUs?.alasanList?.map((group, gi) => {
                  return (
                    <Reveal key={group.id ?? group.kategori} delay={gi * 80}>
                      <div className="flex items-start gap-5 py-6 border-t border-slate-200 last:border-b">
                        {/* Text */}
                        <div>
                          <div className="flex items-baseline gap-2 mb-1">
                            <h3 className="text-sm font-semibold text-navy-dark font-[var(--font-outfit)]">
                              {group.kategori}
                            </h3>
                            <span className="text-xs text-slate-400">{group.subtitle}</span>
                          </div>
                          {/* Show first item desc as summary */}
                          <p className="text-sm leading-relaxed text-slate-500">
                            {group.deskripsi}
                          </p>
                        </div>
                      </div>
                    </Reveal>
                  );
                })}
              </div>
            </div>

            {/* Right — Image */}
            <Reveal variant="right">
              <div className="relative w-full h-[560px] lg:h-[680px] rounded-3xl overflow-hidden">
                <Image
                  src={getMediaSrc(whyChooseUs?.gambar, "/images/internet-tower.png")}
                  alt={getMediaAlt(whyChooseUs?.gambar, "Tim GiMS siap melayani Anda")}
                  fill
                  sizes="(max-width: 1024px) 100vw, 50vw"
                  className="object-cover object-center"
                />
                {/* Subtle overlay gradient at bottom */}
                <div className="absolute inset-0 bg-gradient-to-t from-navy-dark/20 to-transparent" />
              </div>
            </Reveal>

          </div>
        </div>
      </section>

      {/* Coverage Areas — Map */}
      <section className="py-24 bg-navy-dark text-white">
        <div className="mx-auto max-w-7xl px-6 lg:px-8">

          <Reveal>
            <p className="text-teal-light text-xs font-semibold tracking-[0.2em] uppercase mb-2">
              {data.wilayahJangkauan?.label ?? "Coverage"}
            </p>
            <h2 className="text-2xl sm:text-3xl font-bold font-[var(--font-outfit)] mb-4">
              {data.wilayahJangkauan?.judul ?? "Jangkauan Nasional"}
            </h2>
            <p className="text-white/40 mb-12 max-w-2xl leading-relaxed text-sm">
              {data.wilayahJangkauan?.deskripsi}
            </p>
          </Reveal>

          {/* Peta */}
          <Reveal>
            <IndonesiaMap coverageAreas={coverageAreas} />
          </Reveal>

        </div>
      </section>

      {/* CTA */}
      <section className="py-16 bg-white">
        <div className="mx-auto max-w-7xl px-6 lg:px-8">
          <Reveal>
            <div className="flex flex-col sm:flex-row items-center justify-between gap-6">
              <div>
                <h3 className="text-xl font-bold text-navy-dark font-[var(--font-outfit)]">Ready to Partner with Us?</h3>
                <p className="text-slate-500 text-sm mt-1">Hubungi kami untuk konsultasi kebutuhan teknologi bisnis Anda.</p>
              </div>
              <div className="flex gap-4">
                <Link href="/contact" className="group inline-flex items-center gap-2 bg-teal hover:bg-teal-light text-white px-7 py-3 text-sm font-semibold rounded-lg transition-all duration-300">
                  Contact Us <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
                </Link>
                <Link href="/products" className="inline-flex items-center gap-2 border border-slate-200 text-navy hover:bg-slate-50 px-7 py-3 text-sm font-semibold rounded-lg transition-colors duration-300">
                  View Products
                </Link>
              </div>
            </div>
          </Reveal>
        </div>
      </section>
    </>
  );
}
