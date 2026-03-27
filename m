Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D513910AB830
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41E3E10E37A;
	Fri, 27 Mar 2026 14:25:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="di03aXMv";
	dkim-atps=neutral
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 634C110E37A
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 14:25:47 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7d1872504cbso1995932a34.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 07:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774621546; cv=none;
 d=google.com; s=arc-20240605;
 b=Rf7nXrdDYQWeSGVhm3EZV6+WngHPN6YpEozzkmqmpm/sjp1YYhziwQqhkwj8XnSPQI
 IzQXamx54Lka3nt58hoLRuYYITplFHAMytPYy9lzMkYDBlucWjcZ4W76ZhlEaRq/2aTj
 zFksw/CKEpwMvrAMoe7tYUWjiOzCKNrhEOlXX5ohj3d1emAyYURPo5VCfaACoP8uIRcW
 Sq3EsWwccIgnOoq9JmrjQiJRqB1c2VHMx2zzcQBwane5NJwbGQYRwZKNIM3Mx9qVfuHH
 1mJphE3HekZ5HXF5YJPAN4BPMhDtN6et7u1Ua6ujrxiXGFtgWfbG51TB9r3YLslM7RNY
 baaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4CkbRyLOqwqwWGIOpFw2bUHzgPgIG2tUM7yOxEtSZu8=;
 fh=/mcyupyNrYaI/wC2SDtikwqkWCuVih2c8jsNRNjkKrU=;
 b=e8ZniOJ1IoDEAsayOF2bUeK/TDuXO82JD2qSezpSDZX+xMDcJZo4k94KqeqWzNwWBJ
 cVt6+qSA/GfcLF5I7VdtdpOiiJr+Vgako/ciedb5F4lftnhSZRyqAnNVl6kRFKD2rBhq
 VSLMaWF0yreBzgcRBAUdWxOwjRSnZQveX3PBAV1zRyYR+h9tPjxg2mDE23DFxlyPZv1Z
 fuAEH4PO7ZR8YRAmq+2pbB+8bxf0LX7NbAmmjqyXbz4avML+6sXznt+79Xo1xF78OVV2
 pwXMetGo6GsqzUx4POCGSQJWBL/z1dW38Bb7pECdLKH/oMeJxMK8pzE0R1IZOBQ8Ecsb
 4GFQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774621546; x=1775226346; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4CkbRyLOqwqwWGIOpFw2bUHzgPgIG2tUM7yOxEtSZu8=;
 b=di03aXMvK3PaMda9sGpiwC4B6L85hgB9UzfbxPF2t+glIikVyal2PV1RY+Nqmcxu9V
 UHvysKSgic8wpSpXj2pHAgoI3ppA8L0mSf9LVh8bR5PlZ8UH06byG/eCMd+XP1dvb93U
 usUyXt46Qv5XvFaLl6RqyQRcgk1+uGdMsVbo8hZwLo+q5yeA5pZb3h2HBCLwvaYIwZx7
 /1ho8ZbcCsJ8byyJ5Fc3bVkmgyv7CIFEpuczIsUZpzqh86B64F2Ub3NXvAcatunOtM5z
 ORlGLLrekSLkBHkDUPCIpLbjM+VxRWQ36nLws86asrFajJAdlTJmlgDP9qRCNcapXMqa
 Aytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774621546; x=1775226346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4CkbRyLOqwqwWGIOpFw2bUHzgPgIG2tUM7yOxEtSZu8=;
 b=oIycxPVCRvfa2Z0uiMhDtiuniOAljG6H9tdG2E0lD24pZZ2dspisR+WtLX47FPgrhz
 im6wT2kFG2yDNL3xTB5G3Q3ur2ZZsWkNV3y7kR1SWhDl4V2CtNrNxmt+mF/l+vaNPG5D
 gU1FTIBH3K0LTKHaZ/wM/Wmaj+AwvBcvgzd8C1vmOYelA94QEj4cNRXX9wpFhNMTeMlq
 oYDNBM3Mlchf4qV8McYgyjJc2wJyP+TQm/IpB56sj1/dndJmOdI1ccR0GBBinxMFQ9up
 vgV9XuOi2RL//H46bPoqElWvp8Msn9HEL7BTxaY/JSTVXpH29UwB1rVh70c8sg+QU2Pw
 ELPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnjwZVRglEhuY7jpoaqjcPqnlbHIejW3yKT0/zUxs0BJ8t/qM+7DkaPKa2/FGKXzaNDCxohOGOWKI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQJY9Wg0IhCJ0QHsfqHQ3zp4E2ommhMKDfJQ6HLEDVElktJnYt
 dE7HCMA3gSp9h2UKaPK0lrZRynldPNgrrCQGjgmCcqVSQR5714rCuWl/fNhqQEjb23Ay0ETc9Ct
 7UXmLNSlA8ZiSVR3Tzcg4zVH5bgg28aU=
X-Gm-Gg: ATEYQzxUWAh7Tbdo5IXEtaPc0IIUdP7oedaRngnqlYDrs9Y9GzdyFamek1PrRYxjvTP
 o4PvLh3K6ThG0agHhagry+K6dFSzwzY3joMJ+exfPnmQ8rrW/D064WK5SKXQ5KDUNPV4f/hrlv5
 YjpiWqswrMCR4J5u/H3chI6SygBWpmZA3HELMjIFVaxyRNn/5goonLlP8h6NsddkzhAsSAJ3477
 wQOiL5b6tUt26MsEILhP3bsYKKjDPnwgm1Ej3oC3XRPDrh+UdHl2touBtcDyjnYNmvKXg8JCDFY
 BSFW3cv3/hKpsoo6zA==
X-Received: by 2002:a9d:7dc5:0:b0:7d7:45b7:ed8a with SMTP id
 46e09a7af769-7d9ee135024mr2298331a34.5.1774621546467; Fri, 27 Mar 2026
 07:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260317053653.28888-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260317053653.28888-1-mikhail.v.gavrilov@gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 27 Mar 2026 19:25:33 +0500
X-Gm-Features: AQROBzAfh4NA1agUQwts4_skWqTwNVSjJPXSowustcL8qGk_2W0rk3crVq32Jhw
Message-ID: <CABXGCsOCjQQ65uO3c8DFGx+ErLtn9jSVnktb3MgVdHRfU2pbVw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf/udmabuf: skip redundant cpu sync to fix cacheline
 EEXIST warning
To: kraxel@redhat.com, vivek.kasireddy@intel.com
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Mar 17, 2026 at 10:37=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> When CONFIG_DMA_API_DEBUG_SG is enabled, importing a udmabuf into a DRM
> driver (e.g. amdgpu for video playback in GNOME Videos / Showtime)
> triggers a spurious warning:
>
>   DMA-API: amdgpu 0000:03:00.0: cacheline tracking EEXIST, \
>       overlapping mappings aren't supported
>   WARNING: kernel/dma/debug.c:619 at add_dma_entry+0x473/0x5f0
>
> The call chain is:
>
>   amdgpu_cs_ioctl
>    -> amdgpu_ttm_backend_bind
>     -> dma_buf_map_attachment
>      -> [udmabuf] map_udmabuf -> get_sg_table
>       -> dma_map_sgtable(dev, sg, direction, 0)  // attrs=3D0
>        -> debug_dma_map_sg -> add_dma_entry -> EEXIST
>
> This happens because udmabuf builds a per-page scatter-gather list via
> sg_set_folio().  When begin_cpu_udmabuf() has already created an sg
> table mapped for the misc device, and an importer such as amdgpu maps
> the same pages for its own device via map_udmabuf(), the DMA debug
> infrastructure sees two active mappings whose physical addresses share
> cacheline boundaries and warns about the overlap.
>
> The DMA_ATTR_SKIP_CPU_SYNC flag suppresses this check in
> add_dma_entry() because it signals that no CPU cache maintenance is
> performed at map/unmap time, making the cacheline overlap harmless.
>
> All other major dma-buf exporters already pass this flag:
>   - drm_gem_map_dma_buf() passes DMA_ATTR_SKIP_CPU_SYNC
>   - amdgpu_dma_buf_map() passes DMA_ATTR_SKIP_CPU_SYNC
>
> The CPU sync at map/unmap time is also redundant for udmabuf:
> begin_cpu_udmabuf() and end_cpu_udmabuf() already perform explicit
> cache synchronization via dma_sync_sgtable_for_cpu/device() when CPU
> access is requested through the dma-buf interface.
>
> Pass DMA_ATTR_SKIP_CPU_SYNC to dma_map_sgtable() and
> dma_unmap_sgtable() in udmabuf to suppress the spurious warning and
> skip the redundant sync.
>
> Fixes: 284562e1f348 ("udmabuf: implement begin_cpu_access/end_cpu_access =
hooks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
>  drivers/dma-buf/udmabuf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 94b8ecb892bb..9c6f8785a28a 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -162,7 +162,7 @@ static struct sg_table *get_sg_table(struct device *d=
ev, struct dma_buf *buf,
>                 sg_set_folio(sgl, ubuf->folios[i], PAGE_SIZE,
>                              ubuf->offsets[i]);
>
> -       ret =3D dma_map_sgtable(dev, sg, direction, 0);
> +       ret =3D dma_map_sgtable(dev, sg, direction, DMA_ATTR_SKIP_CPU_SYN=
C);
>         if (ret < 0)
>                 goto err_map;
>         return sg;
> @@ -177,7 +177,7 @@ static struct sg_table *get_sg_table(struct device *d=
ev, struct dma_buf *buf,
>  static void put_sg_table(struct device *dev, struct sg_table *sg,
>                          enum dma_data_direction direction)
>  {
> -       dma_unmap_sgtable(dev, sg, direction, 0);
> +       dma_unmap_sgtable(dev, sg, direction, DMA_ATTR_SKIP_CPU_SYNC);
>         sg_free_table(sg);
>         kfree(sg);
>  }
> --
> 2.53.0
>

Gentle ping on this patch.

To summarize the review so far:
  Vivek: "Looks OK to me"
  Christian: Acked-by

Note: while my separate dma-debug patch [1] would also suppress
this specific warning on x86, the udmabuf fix here is still
valuable as it removes the redundant CPU sync at map/unmap time
and aligns udmabuf with other dma-buf exporters that already
pass DMA_ATTR_SKIP_CPU_SYNC.

[1] https://lore.kernel.org/all/20260327124156.24820-1-mikhail.v.gavrilov@g=
mail.com/

Gerd, could you take a look when you have a chance?

--=20
Best Regards,
Mike Gavrilov.
