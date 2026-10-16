Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FCBCC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A2F71125E7;
	Fri, 16 Oct 2026 07:04:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECAEA1125E7
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:04:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 21DBF60008;
 Fri, 16 Oct 2026 07:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14AD1F000C4;
 Fri, 16 Oct 2026 07:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792134283;
 bh=MxUCyfN2zcZbkxv+8D6KlaUBypojJMRuwg/yJnWOm68=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YLwrIdU2jt7XfJx8s7yk/aPAhHgsmx6luYDVG+uUQe1dLJWnktnQuHq/ZflO5eEss
 CtPGOj4ddkChnnpq/m//mx9Cnu6GbUboP5NDXkK5F4WsIgMJ2QmDj77ldBkhYEFB6c
 OChbauA3SNcqVjuUwfH/D2gNaEswcs5GF0g313ulV3vI7ehwWWwoLhq9r/3uIR/1sM
 gxxU2eALvN/VsXhEUtBXV8UvZACatGhyXqPFOTAjGi2T5e7dMEIsSXLToIXVlO5+Tt
 1wqmTCDmH8uLscrFQn70kHhqkEv4rYaKlb367tR4nVDRVo5u1b0AI3qvRMoTQpaQBK
 ftBjS61FtEO0w==
Message-ID: <sashiko-outbox-173899@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/11] ARM: dma-mapping: Handle foreign buffers in
 arm_iommu_get_sgtable
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261016-b4-arm32-iommu-dma-cookie-v2-6-b06842a01938@nvidia.com>
References: <20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com>
 <20261016-b4-arm32-iommu-dma-cookie-v2-6-b06842a01938@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:04:43 +0000
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
- [High] arm/dma-mapping: invalid cast in __atomic_get_pages causes kernel =
panic on mmap/sgtable
--

commit 0f1d7f693768ddb66d127fa1093856300ee17984
Author: Mikko Perttunen <mperttunen@nvidia.com>

ARM: dma-mapping: Handle foreign buffers in arm_iommu_get_sgtable

This commit updates arm_iommu_get_sgtable() to handle foreign buffers
that were not allocated through arm_iommu_alloc_attrs(). Instead of
returning an error, it falls back to describing the buffer as a single
chunk, similar to how iommu_dma_get_sgtable() operates.

> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index d6315baeddb9c..c2ec4f1078083 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1169,12 +1169,29 @@ static int arm_iommu_get_sgtable(struct device *d=
ev, struct sg_table *sgt,
>  {
>  	unsigned int count =3D PAGE_ALIGN(size) >> PAGE_SHIFT;
>  	struct page **pages =3D __iommu_get_pages(cpu_addr, attrs);
> +	struct page *page;
> +	int ret;
> =20
> -	if (!pages)
> -		return -ENXIO;
> +	if (pages)
> +		return sg_alloc_table_from_pages(sgt, pages, count, 0, size,
> +						 GFP_KERNEL);

[Severity: High]
Does this code still cause memory corruption when handling atomic pool
allocations?

The underlying __iommu_get_pages() function can return the result of
__atomic_get_pages(), which incorrectly casts a single struct page pointer =
to
an array of pointers:

arch/arm/mm/dma-mapping.c:__atomic_get_pages() {
    ...
    return (struct page **)page;
}

When arm_iommu_get_sgtable() receives this pointer, it passes it to
sg_alloc_table_from_pages(). That function iterates over the pointer as an
array, reading pages[i]. For pages[0], this reads the internal fields of the
page object (such as flags on 32-bit ARM) and interprets them as a page
pointer. Passing this uninitialized pointer to page_to_pfn() or get_page()
causes memory corruption and kernel panics.

Can this be triggered by userspace exporting a dma-buf or mmapping an
atomic-pool DMA buffer?

The same issue appears to be present in arm_iommu_mmap_attrs() which passes
the bogus array to vm_map_pages():

arch/arm/mm/dma-mapping.c:arm_iommu_mmap_attrs() {
    ...
    return vm_map_pages(vma, pages, nr_pages);
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-b4-arm32-i=
ommu-dma-cookie-v2-0-b06842a01938@nvidia.com?part=3D6
