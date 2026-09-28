Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE39C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:52:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D09D810E790;
	Mon, 28 Sep 2026 05:52:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e76VoC0k";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C44810E790
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 05:52:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0C914408C8;
 Mon, 28 Sep 2026 05:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C848B1F000FF;
 Mon, 28 Sep 2026 05:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790574752;
 bh=Plfcelqj6YQTpzDFdfMnV+Ubrb2dddrVl0bSMDI1Px0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e76VoC0k7oM4zrQ/2vmASXp8zDJW68i1oz6nTmDC0bHTh0z2ysyedbLellaGpbMtS
 er3Uru2oYBvqZv5cboZ6z6j89rWPVIRoCqPhLJAdsTvW+tS5weWLmZ1e0fBbrUO4oC
 /p1eJv2uCr14lDYGiZhVN/xuqOsmOhFM/5gXXxNdFLi1DtfQMwAAnOsBKDBL8o+GF8
 IjLyf3kjBsOW6VCIRuZhpxk3NSRdLpY2oojoh9+rTDJxqrweyrCp0eXieLmnugrY6L
 BMhec+BVAnmLSulnWSOaIr20gj6nXCpL1gjJN19I15V33/ka2va1PUvXW3ImkfYddw
 JscHManCUXSwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] drm/msm: map page-less imported sg_tables from
 their DMA addresses
To: "Jianfeng Liu" <liujianfeng1994@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260928053901.7270-3-liujianfeng1994@gmail.com>
References: <20260928053901.7270-1-liujianfeng1994@gmail.com>
 <20260928053901.7270-3-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 05:52:32 +0000
Message-Id: <20260928055232.C848B1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] drm/msm: assuming physical contiguity for IOMMU-coalesced DMA =
segments
- [Medium] drm/msm: memory leak on error path when mapping page-less sg ent=
ries
--

commit 77e8df4ba7f003ef7b79e1521b4c58572c28169c
Author: Jianfeng Liu <liujianfeng1994@gmail.com>

drm/msm: map page-less imported sg_tables from their DMA addresses

With CONFIG_DMABUF_DEBUG=3Dy, dma_buf_map_attachment() hands importers a
copy of the attachment sg_table with the struct page pointers stripped
and sg->length zeroed. This patch translates the DMA addresses back
to physical addresses using the drm device's DMA-API domain to fix
arm-smmu translation faults caused by the missing page pointers.

> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_io=
mmu.c
> index da6782fca6bd2..8407a37f9efee 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
[ ... ]
> @@ -184,8 +202,35 @@ static int msm_iommu_pagetable_map(struct msm_mmu *m=
mu, u64 iova,
>  		return msm_iommu_pagetable_map_prr(mmu, iova, len, prot);
> =20
>  	for_each_sgtable_sg(sgt, sg, i) {
> -		size_t size =3D sg->length;
> -		phys_addr_t phys =3D sg_phys(sg);
> +		size_t size;
> +		phys_addr_t phys;
> +
> +		if (sg_page(sg)) {
> +			/* CPU-view entry: native objects, and imported
> +			 * sg_tables that still carry struct page
> +			 */
> +			size =3D sg->length;
> +			phys =3D sg_phys(sg);
> +		} else {
> +			/*
> +			 * Page-less entry, e.g. the sg_table wrapper
> +			 * that dma_buf_map_attachment() hands out when
> +			 * CONFIG_DMABUF_DEBUG=3Dy (page pointers stripped,
> +			 * sg->length zeroed, only the DMA fields carried
> +			 * over).  Recover the physical address by
> +			 * translating the DMA address through the drm
> +			 * device's DMA-API domain.
> +			 */
> +			size =3D sg_dma_len(sg);
> +			phys =3D msm_mmu_dma_to_phys(mmu, sg_dma_address(sg));
                        ^^^^

[Severity: Critical]
Does this assume that the entire DMA segment length mapped by the IOMMU is
physically contiguous?=20

If the IOMMU DMA API coalesces physically discontiguous pages into a single
contiguous IOVA segment, wouldn't mapping sg_dma_len(sg) using just the
starting physical address map the pages after the first page to incorrect,
adjacent physical addresses instead of their actual disjoint addresses?

> +
> +			if (!size || !phys) {
> +				dev_err(mmu->dev,
> +					"cannot map page-less sg entry: dma=3D%pad len=3D%zu\n",
> +					&sg_dma_address(sg), size);
> +				return -EINVAL;
                                ^^^^

[Severity: Medium]
If this fails after some scatterlist entries have already been successfully
mapped, does returning -EINVAL directly cause a permanent leak of the IOMMU
pagetable mappings?

Should this use a cleanup path to unmap the already-mapped pages, similar to
how ops->map_pages failures are handled with msm_iommu_pagetable_unmap()?

> +			}
> +		}
> =20
>  		if (!len)
>  			break;
[ ... ]
> @@ -697,6 +742,47 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64=
_t iova,
>  	if (iova & BIT_ULL(48))
>  		iova |=3D GENMASK_ULL(63, 49);
> =20
> +	/*
> +	 * With CONFIG_DMABUF_DEBUG=3Dy, imported sg_tables carry no struct
> +	 * page and sg->length is zeroed; iommu_map_sgtable() would consume
> +	 * zero length and silently map nothing.  Map from the (translated)
> +	 * DMA addresses instead.
> +	 */
> +	if (!sg_page(sgt->sgl)) {
> +		struct scatterlist *sg;
> +		size_t mapped =3D 0;
> +		unsigned int i;
> +
> +		for_each_sgtable_dma_sg(sgt, sg, i) {
> +			phys_addr_t phys =3D
> +				msm_mmu_dma_to_phys(mmu, sg_dma_address(sg));
> +			size_t size =3D sg_dma_len(sg);
> +
> +			if (!phys || !size) {
> +				ret =3D -EINVAL;
> +				goto err_unmap;
> +			}
> +
> +			ret =3D iommu_map(iommu->domain, iova + mapped, phys,
> +					size, prot, GFP_KERNEL);
                        ^^^^

[Severity: Critical]
Does this also incorrectly assume physical contiguity for the coalesced DMA
segment by passing the entire sg_dma_len(sg) to iommu_map() with only the
starting physical address?

> +			if (ret)
> +				goto err_unmap;
> +
> +			mapped +=3D size;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928053901.7270=
-1-liujianfeng1994@gmail.com?part=3D2
