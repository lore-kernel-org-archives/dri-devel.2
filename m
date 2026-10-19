Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB69606A322
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sng5j+Zz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E020910EA3C;
	Mon, 19 Oct 2026 16:55:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 56ECB10E92E
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:55:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C869204C;
 Mon, 19 Oct 2026 09:55:04 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD3273F673;
 Mon, 19 Oct 2026 09:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792428907; bh=g0MCRM90bHOY9xtPWztIDlp+2g+2cg4X+xov3AAv2Po=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sng5j+ZzFPDKIUj2toxn/TcsqEiuqIvvYLh9Yr5Pwf6ZrnfHiO9wuC1inCAEV3TpQ
 p7pS065DFJmLupgiAFGyl3YkDf/3uNsTsKqraz3NzjmlCJeBovUBlLUAp/tmllNJd2
 sXy+3vjJWuLa0jAC8Y7hKQgSL+h1opd/Ug5uqnsI=
Message-ID: <5173dbaa-2a49-420d-bf4e-97c9cc340bd9@arm.com>
Date: Mon, 19 Oct 2026 17:55:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] ARM: dma-mapping: Bypass the legacy path for
 core-owned DMA API domains
To: Mikko Perttunen <mperttunen@nvidia.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>,
 Thierry Reding <thierry.reding@kernel.org>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
References: <20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com>
 <20261016-b4-arm32-iommu-dma-cookie-v2-5-b06842a01938@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261016-b4-arm32-iommu-dma-cookie-v2-5-b06842a01938@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16/10/2026 7:46 am, Mikko Perttunen wrote:
> ARM's arch_setup_dma_ops / arm_setup_iommu_dma_ops creates a custom
> IOMMU domain for DMA API usage, and continues to do so when the IOMMU
> driver doesn't explicitly request a DMA default domain type.
> 
> When, however, that DMA default domain is requested and the core owns
> the domain, we need to skip our own domain management. Add checks to
> arm_setup/teardown_iommu_dma_ops for these cases. In such a case IOVAs
> can be allocated from anywhere in the domain's geometry, so also add a
> check to ensure the device's dma-ranges cover it. Presently, this is the
> case for all platforms except some OMAP platforms with a non-zero
> dma-ranges base.

It's probably worth adding some cleverness to arm_iommu_detach_device() 
as well - it might work out benign to attempt to detach from a real 
core-owned default domain, but we'll now want to set dma_ops and 
to_dma_iommu_mapping according to the default domain itself (since we'll 
now have the possibility of switching between an explicit unmanaged 
dma_iommu_mapping and the implicit default one.)

Thanks,
Robin.

> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   arch/arm/mm/dma-mapping.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index f2d3e8ec3487..d6315baeddb9 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1761,13 +1761,33 @@ EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
>   
>   static void arm_setup_iommu_dma_ops(struct device *dev)
>   {
> -	struct dma_iommu_mapping *mapping;
> +	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
>   	u64 dma_base = 0, size = 1ULL << 32;
>   
>   	if (dev->dma_range_map) {
>   		dma_base = dma_range_map_min(dev->dma_range_map);
>   		size = dma_range_map_max(dev->dma_range_map) - dma_base;
>   	}
> +
> +	/*
> +	 * An existing cookie means the core owns the domain. Only set the
> +	 * per-binding DMA ops. IOVAs are allocated from the whole aperture,
> +	 * so the device's dma-ranges must cover it.
> +	 */
> +	if (mapping) {
> +		const struct iommu_domain_geometry *geo =
> +			&mapping->domain->geometry;
> +
> +		if (dma_base > geo->aperture_start ||
> +		    dma_base + size < geo->aperture_end) {
> +			dev_err(dev, "dma-ranges do not cover the IOMMU aperture\n");
> +			return;
> +		}
> +
> +		set_dma_ops(dev, &iommu_ops);
> +		return;
> +	}
> +
>   	mapping = arm_iommu_create_mapping(dev, dma_base, size);
>   	if (IS_ERR(mapping)) {
>   		pr_warn("Failed to create %llu-byte IOMMU mapping for device %s\n",
> @@ -1792,6 +1812,9 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
>   	if (!mapping)
>   		return;
>   
> +	if (!mapping->owns_domain)
> +		return;
> +
>   	arm_iommu_detach_device(dev);
>   	arm_iommu_release_mapping(mapping);
>   }
> 

