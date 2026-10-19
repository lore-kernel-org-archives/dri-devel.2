Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FAB6087498
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=U1aJ343y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2FE710EEB7;
	Mon, 19 Oct 2026 15:48:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 65EE310EEB7
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:47:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89F211682;
 Mon, 19 Oct 2026 08:47:52 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACE6B3F7D8;
 Mon, 19 Oct 2026 08:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792424875; bh=dCk6nUh5icp8CA5X/i9Oz2cAcRaobiJtEJkiiNaZ80o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=U1aJ343yN6AE5BBuB/h4fJu7tR+XjNlcxCpFPJPbA+ZlRbBLokLCIdrzpaAAbFfNW
 1QUDfx9d3Zj+6swZ1HOEFmRel/1rBd112uXKNG/aClm4WPvQ++9Yccfoy7xLQwwJ+X
 NmUpMgAIJHf4xvQy+iy2BBefCyol3beT79SeYhUk=
Message-ID: <52c9bad4-39f4-46cf-87c2-9e57e8beeb5c@arm.com>
Date: Mon, 19 Oct 2026 16:47:39 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] ARM: dma-mapping: Handle foreign buffers in
 arm_iommu_get_sgtable
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
 <20261016-b4-arm32-iommu-dma-cookie-v2-6-b06842a01938@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261016-b4-arm32-iommu-dma-cookie-v2-6-b06842a01938@nvidia.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16/10/2026 7:46 am, Mikko Perttunen wrote:
> arm_iommu_get_sgtable can only describe buffers which came from
> arm_iommu_alloc_attrs, and returns -ENXIO for anything else. This is
> stricter than iommu_dma_get_sgtable(), which falls back to describing
> the buffer as a single chunk.
> 
> The difference shows up when a buffer is allocated for one device and
> mapped for another, as TegraDRM does. Buffers are allocated on the
> host1x logical device, which has no dma_configure and therefore uses
> direct DMA ops, and are then mapped for a display controller behind the
> SMMU.
> 
> Add the same fallback as iommu_dma_get_sgtable().

Hmm, that's not actually what it's for... :(

The "fallback" is only for the case when iommu_dma_alloc() has hit the 
dma_alloc_from_pool() path, see a98d9ae937d2 ("arm64/iommu: handle 
non-remapped addresses in ->mmap and ->get_sgtable"). It was never meant 
for dipping into *other* DMA ops because the caller has erroneously 
passed the wrong device. Just like dma_mmap_attrs() and 
dma_free_attrs(), dma_get_sgtable_attrs() must match the original 
dma_alloc_attrs() call - that's a bug in TegraDRM.

Thanks,
Robin.

> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   arch/arm/mm/dma-mapping.c | 25 +++++++++++++++++++++----
>   1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index d6315baeddb9..c2ec4f107808 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1169,12 +1169,29 @@ static int arm_iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
>   {
>   	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
> +	struct page *page;
> +	int ret;
>   
> -	if (!pages)
> -		return -ENXIO;
> +	if (pages)
> +		return sg_alloc_table_from_pages(sgt, pages, count, 0, size,
> +						 GFP_KERNEL);
>   
> -	return sg_alloc_table_from_pages(sgt, pages, count, 0, size,
> -					 GFP_KERNEL);
> +	/*
> +	 * The buffer was not allocated through these DMA ops. It may belong to
> +	 * a device which is not behind an IOMMU at all, which can happen when a
> +	 * buffer is allocated on one device and mapped for another. Describe it
> +	 * as a single chunk, as iommu_dma_get_sgtable() does.
> +	 */
> +	if (is_vmalloc_addr(cpu_addr))
> +		page = vmalloc_to_page(cpu_addr);
> +	else
> +		page = virt_to_page(cpu_addr);
> +
> +	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> +	if (!ret)
> +		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
> +
> +	return ret;
>   }
>   
>   /*
> 

