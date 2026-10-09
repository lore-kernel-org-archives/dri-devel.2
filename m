Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8746CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 00:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D5510E98F;
	Fri,  9 Oct 2026 00:31:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WzBC5Clz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2AED10E98F
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 00:31:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A273143259;
 Fri,  9 Oct 2026 00:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505021F000FF;
 Fri,  9 Oct 2026 00:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791505911;
 bh=a7oc0bTwVs9/h0D+Ob9pfer3YpJgG90NWcUUrLuCIS4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WzBC5ClzlKzKfcJdbVCxG3otlSlanSvVMNDw2IFwNWxzuBmvU5pxw5nuzcauLpGgR
 AJesC1xNy6Op/N+suFdWV8DgIbDeo/wBr0c2RzuazzDBnaUgqSWlNUwP4sCenTTA/9
 VvAxbsMVEp5g376SEtd4oKqMP78PBIda/H5E3/Ph6qBql+CixLCcO41YEU2lNSQnwg
 c74SeVH63qFrIRd9yknxKafTbc1EEgYYSXuQstdNiHhNaJLLVu29IY8imX7HXp0qSh
 LLClVbhxtrc8HwFRy1Q5qqgAitqCmARAcd/TsezjrkXrhk38On2sCwu9kPaNCRiwzD
 ZbB7C2jfpuaFg==
Message-ID: <sashiko-outbox-164674@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] iommu: Add iommu_map_sgtable_dma()
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261009002114.67851-2-kmehltretter@gmail.com>
References: <20261009002114.67851-1-kmehltretter@gmail.com>
 <20261009002114.67851-2-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 00:31:50 +0000
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
- [Medium] iommu: unaligned len triggers un-ratelimited pr_err() log spam i=
n iommu_map_sgtable_dma
--

commit b1535b935267283d387d7d45e27e3ad27be6e57f
Author: Karl Mehltretter <kmehltretter@gmail.com>

iommu: Add iommu_map_sgtable_dma()

This commit adds an iommu-dma helper to map a live attachment into another
domain by translating through the device's default DMA domain.

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 58c624513cd43..b9a1f91ec5dbb 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
[ ... ]
> +ssize_t iommu_map_sgtable_dma(struct iommu_domain *domain, unsigned long=
 iova,
> +			      struct device *dev, struct sg_table *sgt,
> +			      int prot)
> +{
> +	struct iommu_domain *dma_domain;
> +	size_t len =3D 0, mapped =3D 0, total =3D 0;
> +	struct scatterlist *sg;
> +	size_t granule, target_granule;
[ ... ]
> +	target_granule =3D 1UL << __ffs(domain->pgsize_bitmap);
> +	if (!use_dma_iommu(dev))
> +		return -EOPNOTSUPP;
> +	dma_domain =3D iommu_get_dma_domain(dev);
> +	if (!dma_domain || !dma_domain->pgsize_bitmap)
> +		return -EOPNOTSUPP;
> +	granule =3D min(target_granule,
> +		      1UL << __ffs(dma_domain->pgsize_bitmap));
[ ... ]
> +	for_each_sgtable_dma_sg(sgt, sg, i) {
> +		dma_addr_t dma_addr =3D sg_dma_address(sg);
> +		size_t dma_len =3D sg_dma_len(sg);
> +
> +		while (dma_len) {
> +			phys_addr_t next;
> +			phys_addr_t phys;
> +
> +			phys =3D iommu_iova_to_phys(dma_domain, dma_addr);
[ ... ]
> +			if (len && phys !=3D next) {
> +				ret =3D iommu_map_nosync(domain, iova + mapped,
> +						       start, len, prot,
> +						       GFP_KERNEL);

[Severity: Medium]
Can this result in un-ratelimited kernel log spam if `len` is not aligned to
the target domain's minimum page size?

If `dma_domain` has a smaller minimum page size than the target `domain`,
`granule` will be strictly less than `target_granule`. If the DMA-BUF backi=
ng
memory is fragmented at `granule` boundaries, `phys !=3D next` will evaluate
to true at an offset aligned to `granule` but potentially unaligned to
`target_granule`.

When `iommu_map_nosync()` is called with this unaligned `len`, it eventually
reaches `__iommu_map_domain_pgtbl()` in drivers/iommu/iommu.c, which logs an
un-ratelimited error:

drivers/iommu/iommu.c:__iommu_map_domain_pgtbl() {
	...
	if (!IS_ALIGNED(iova | paddr | size, min_pagesz)) {
		pr_err("unaligned: iova 0x%lx pa %pa size 0x%zx min_pagesz 0x%x\n",
		       iova, &paddr, size, min_pagesz);
		return -EINVAL;
	}
	...
}

Could a heavily fragmented DMA-BUF provided by userspace (e.g., via a DRM
ioctl) repeatedly trigger this path and flood the kernel log?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009002114.6785=
1-1-kmehltretter@gmail.com?part=3D1
