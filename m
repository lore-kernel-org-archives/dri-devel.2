Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A851CCCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D632110E091;
	Fri, 16 Oct 2026 07:01:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F30110E091
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:01:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 07D51404A1;
 Fri, 16 Oct 2026 07:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F461F000C4;
 Fri, 16 Oct 2026 07:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792134072;
 bh=/oq9nMaBOLDNz07hiCHSXTqGXOfysU7SYCqePSGaTNs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UWv1hHEWhZfo3YW1GZE3vjvlNsPnsDf0wg1vMXsRAZDCAVTmuT3VHSqsTDiJqtbY4
 GCMRXpw+PMurD83rrGeRUxbMBjRM7A/D0EDpeHY/6GElR4DwXeVdOEqqOibFEDm8c+
 ggI5op6HoaCJKjHvx6YOdW64aypuD28TmGR7+D/XAArvTs5XBKbN3jOWl0Pgcvr6YB
 zttgFl0puwjUbFZiZu6tOioWh7HhnRb8kNgWESKGv7vj7ZkEBdN0PtHJr/dlDf2mYl
 x72LRLHehsY9huHDcgOicigITyKXQXbY/URc3DjXoo5+6o3wgdAcqqmHeiauvqjM8P
 thnyDC6YsvkhA==
Message-ID: <sashiko-outbox-173895@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/11] ARM: dma-mapping: Bypass the legacy path for
 core-owned DMA API domains
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261016-b4-arm32-iommu-dma-cookie-v2-5-b06842a01938@nvidia.com>
References: <20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com>
 <20261016-b4-arm32-iommu-dma-cookie-v2-5-b06842a01938@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:01:12 +0000
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
- [Medium] arm: dma-mapping: off-by-one size causes mixed semantic in apert=
ure check
--

commit 5535bede81dc83f33cc8029ff49a58ed02614672
Author: Mikko Perttunen <mperttunen@nvidia.com>

ARM: dma-mapping: Bypass the legacy path for core-owned DMA API domains

This commit updates the ARM DMA mapping code to bypass custom IOMMU domain
management when a DMA default domain is requested and owned by the core.
It adds checks in the setup and teardown routines to skip the legacy path
and ensures that the device's dma-ranges cover the IOMMU aperture.

> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index f2d3e8ec34872..d6315baeddb9c 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1761,13 +1761,33 @@ EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
> =20
>  static void arm_setup_iommu_dma_ops(struct device *dev)
>  {
> -	struct dma_iommu_mapping *mapping;
> +	struct dma_iommu_mapping *mapping =3D to_dma_iommu_mapping(dev);
>  	u64 dma_base =3D 0, size =3D 1ULL << 32;
> =20
>  	if (dev->dma_range_map) {
>  		dma_base =3D dma_range_map_min(dev->dma_range_map);
>  		size =3D dma_range_map_max(dev->dma_range_map) - dma_base;
>  	}
> +
> +	/*
> +	 * An existing cookie means the core owns the domain. Only set the
> +	 * per-binding DMA ops. IOVAs are allocated from the whole aperture,
> +	 * so the device's dma-ranges must cover it.
> +	 */
> +	if (mapping) {
> +		const struct iommu_domain_geometry *geo =3D
> +			&mapping->domain->geometry;
> +
> +		if (dma_base > geo->aperture_start ||
> +		    dma_base + size < geo->aperture_end) {

[Severity: Medium]
Does the new aperture check incorrectly mix inclusive and exclusive size
semantics?

When the device has a dma_range_map, the size calculation relies on
dma_range_map_max(), which returns an inclusive maximum address:

include/linux/dma-direct.h:dma_range_map_max() {
    ...
    for (; map->size; map++)
        ret =3D max(ret, map->dma_start + map->size - 1);
    return ret;
}

Since dma_range_map_max() is inclusive, size =3D max - min results in a
value 1 byte too small. The new check (dma_base + size < geo->aperture_end)
appears to mathematically rely on this off-by-one size to evaluate correctly
against an inclusive aperture_end.

If the size calculation is ever corrected, would this incorrectly accept
dma-ranges that are 1 byte smaller than the aperture? Furthermore, when
dma_range_map is absent, size defaults to 1ULL << 32 (exclusive). If
aperture_end is exactly 0x100000000, will this check incorrectly fail?

> +			dev_err(dev, "dma-ranges do not cover the IOMMU aperture\n");
> +			return;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-b4-arm32-i=
ommu-dma-cookie-v2-0-b06842a01938@nvidia.com?part=3D5
