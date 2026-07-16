Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FB6C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB91310E5CD;
	Thu, 16 Jul 2026 15:41:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m+yb7sNx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF65D10E1A7
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 15:41:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9023D40846;
 Thu, 16 Jul 2026 15:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DC01F000E9;
 Thu, 16 Jul 2026 15:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784216483;
 bh=9vJmtEa7ZvCe6+N4iC72T+uiuoXIKonH22FM7RGowQM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m+yb7sNx+89/9D1RQ1uJHnFBgGXJN3zVeec5ckJZo+jjtkP0czbcGobj/5SZMhoC3
 K2zq8KFj4Yw6alL394aY4ORe85vI7Uk9Vux2ATVRFwGZ7iVsaZ4vnz+xZGSn0ijwWT
 2G6vIMzN2SQWMba9P5rM/nVnKGDZZhBqrRfBQRyCDa522Bp9U9W5HwT2m61EmIrIpE
 zTdO5cVYjXoCxbF0scSTI+gMputZKjYLBcM1Cr5etPvwZQ3FlJaV9JwhxZ4YtrbOQj
 SWsEr177tRttgRFcFzP9vjj47YYfIOViIHeDcBmwh42NE9KXfLC7bGqMvnmlCisUau
 wZfbsGr5Nd6BQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 06/11] iommufd: Plumb dma-buf memory-type (RAM vs
 MMIO) through the phys map
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: media-ci@linuxtv.org, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <a716d496ec095e1f71bb5fc8be3e2559bbe914cc.1784194290.git.dwmw@amazon.co.uk>
References: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
 <a716d496ec095e1f71bb5fc8be3e2559bbe914cc.1784194290.git.dwmw@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:41:22 +0000
Message-Id: <20260716154123.32DC01F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Secondary domain attachments map MMIO DMA-bufs with BATCH_CPU_MEMO=
RY (IOMMU_CACHE) instead of BATCH_MMIO (IOMMU_MMIO), breaking DMA routing.
--

--- Patch [6]: [RFC PATCH 06/11] iommufd: Plumb dma-buf memory-type (RAM vs=
 MMIO) through the phys map ---
commit de7dbdc51049f527858115cc709f25b2cee585cb
Author: David Woodhouse <dwmw@amazon.co.uk>

iommufd: Plumb dma-buf memory-type (RAM vs MMIO) through the phys map

This commit plumbs the memory type of a dma-buf (CPU RAM vs MMIO) through
the IOMMU programming path. It adds an is_cpu_ram flag to dmabuf structures
to correctly choose between BATCH_CPU_MEMORY and BATCH_MMIO during mapping.
This prevents silent misrouting of device DMA on AMD-Vi when the physical
memory is RAM instead of a PCI BAR.

> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index 2d4ea41460fdc..f9b2ae6d7e96c 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c

[ ... ]

> @@ -1106,9 +1108,15 @@ static int pfn_reader_fill_dmabuf(struct pfn_reade=
r_dmabuf *dmabuf,
>  	 * always filled using page size aligned PFNs just like the other types.
>  	 * If the dmabuf has been sliced on a sub page offset then the common
>  	 * batch to domain code will adjust it before mapping to the domain.
> +	 *
> +	 * The exporter's memory type (CPU RAM vs MMIO/BAR) selects the batch
> +	 * kind so downstream iommu_map sets IOMMU_CACHE for cache-coherent RAM
> +	 * or IOMMU_MMIO for BAR memory.  The kind was captured at map time by
> +	 * the exporter dispatch.
>  	 */
>  	batch_add_pfn_num(batch, PHYS_PFN(dmabuf->phys.paddr + start),
> -			  last_index - start_index + 1, BATCH_MMIO);
> +			  last_index - start_index + 1,
> +			  dmabuf->is_cpu_ram ? BATCH_CPU_MEMORY : BATCH_MMIO);
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but does attaching a secondary domain map MMIO
DMA-bufs with BATCH_CPU_MEMORY instead of BATCH_MMIO?

When reading PFNs for a secondary domain, pfn_reader_fill_span() routes the
read to batch_from_domain() instead of pfn_reader_fill_dmabuf():

pfn_reader_fill_span() {
	if (span->is_used =3D=3D 2) {
		/* ... */
		batch_from_domain(
			&pfns->batch, area->storage_domain, area, ...);
		return 0;
	}
}

Then batch_from_domain() extracts PFNs from the already mapped domain and
unconditionally delegates to batch_add_pfn():

batch_from_domain() {
	/* ... */
	phys =3D iommu_iova_to_phys(domain, iova) - page_offset;
	if (!batch_add_pfn(batch, PHYS_PFN(phys)))
		return;
}

And batch_add_pfn() explicitly hardcodes BATCH_CPU_MEMORY:

static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
{
	return batch_add_pfn_num(batch, pfn, 1, BATCH_CPU_MEMORY);
}

Could this silently overwrite the original memory type (e.g., BATCH_MMIO)
for secondary domain mappings, causing device DMA to misroute on AMD-Vi
even after this patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f09647f427565c1789a=
6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk?part=3D6
