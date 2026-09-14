Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852B5C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C465810E208;
	Mon, 14 Sep 2026 21:48:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KXIpxKH1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1314D10E208
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 21:48:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D85AB40A61;
 Mon, 14 Sep 2026 21:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860C81F00893;
 Mon, 14 Sep 2026 21:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789422517;
 bh=ihN/kPEk2rTuvcW1A0hIRGuBUro5OK1ymsVgA+nI9sY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KXIpxKH1LDKxITA/xaRq0OJFu+//d6C9tW3xrkPc9HIP23OULqqn8GHBn3FpbpjOi
 Sk+1VGzBAygtAqx+sGgaZR2HInmBfN+rimtxlpVEiKfSVsj5LgcBVYcyd+THqB7B/f
 fQ/21cJHSg4WlkFVQEaVGKMhFID3BR43yM+HKcVCsZBTE/IXNTUZ3vkwlb20Z+F28w
 B03zkEJrPEukGTYPucRex1fUII9zv5Y+r1nxlDNhg/BBgc1VDqrrvWJ43nzEVWCyFY
 NHKrO2mnnz97MCXUKMLI3TtpPixxY8PnolpIIB+KjYJZOOzpE7dYCWBTH2gO9KZpA6
 4zlrXzo4GU3Ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] dma-buf: validate the attachment before asserting
 its reservation lock
To: "Davidlohr Bueso" <dave@stgolabs.net>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260914212258.2657788-4-dave@stgolabs.net>
References: <20260914212258.2657788-1-dave@stgolabs.net>
 <20260914212258.2657788-4-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 21:48:37 +0000
Message-Id: <20260914214837.860C81F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] dma_iova_link() is called with a hardcoded offset of 0, causin=
g all physical ranges to overlap at the start of the IOVA space.
- [High] IOVA space allocated by dma_iova_try_alloc() is leaked on multiple=
 error paths.
- [High] The fallback error path unconditionally unmaps unpopulated, zero-i=
nitialized scatterlist entries by overwriting the loop counter.
- [High] Mapping a large region as a single chunk but unmapping it in small=
er split chunks violates the DMA API.
--

commit 139d9e764ec01d51d2adf94f612620ee800a32bb
Author: Davidlohr Bueso <dave@stgolabs.net>

dma-buf: validate the attachment before asserting its reservation lock

dma_buf_phys_vec_to_sgt() asserts the reservation lock before its
NULL checks run. Validate first, then assert.

> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-=
mapping.c
> index 833be519e1e6a..12674d89b23eb 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -111,12 +111,12 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma=
_buf_attachment *attach,
>  	size_t i;
>  	int ret;
> =20
> -	dma_resv_assert_held(attach->dmabuf->resv);
> -
>  	if (WARN_ON(!attach || !attach->dmabuf || !provider))
>  		/* This function is supposed to work on MMIO memory only */
>  		return ERR_PTR(-EINVAL);
> =20
> +	dma_resv_assert_held(attach->dmabuf->resv);
> +
>  	dma =3D kzalloc_obj(*dma);
>  	if (!dma)
>  		return ERR_PTR(-ENOMEM);

[Severity: High]
This is a pre-existing issue, but does this code leak the IOVA space alloca=
ted
by dma_iova_try_alloc() on multiple error paths?

If sg_alloc_table() fails, the code jumps to err_free_state:

    ret =3D sg_alloc_table(&dma->sgt, nents, GFP_KERNEL | __GFP_ZERO);
    if (ret)
        goto err_free_state;

This frees dma->state but skips calling dma_iova_free() to release the IOVA
allocation.

Additionally, if the very first physical range fails to link (when i =3D=3D=
 0),
the error handler skips destruction:

    err_unmap_dma:
        if (!i || !dma->state) {
            ; /* Do nothing */
        } else if (dma_use_iova(dma->state)) {
            dma_iova_destroy(attach->dev, dma->state, mapped_len, dir,
                             DMA_ATTR_MMIO);

Can this exhaust device IOMMU IOVA space under memory pressure?

[Severity: Critical]
This is a pre-existing issue, but does this loop incorrectly map all
physical ranges to the exact same starting IOVA address?

    } else if (dma_use_iova(dma->state)) {
        ret =3D dma_iova_link(attach->dev, dma->state,
                            phys_vec[i].paddr, 0,
                            phys_vec[i].len, dir,
                            DMA_ATTR_MMIO);

When nr_ranges > 1, dma_iova_link() is called repeatedly with the offset
hardcoded to 0. Since the target IOVA address is computed as
(state->addr + offset), each physical range overwrites the previous mapping.

Should the offset be passed as mapped_len to ensure segments are appended
sequentially?

[Severity: High]
This is a pre-existing issue, but could this teardown logic violate the DMA
API by mapping a large region as a single chunk and unmapping it
piece-by-piece?

During mapping, a physical range might be mapped in a single contiguous blo=
ck:

    addr =3D dma_map_phys(attach->dev, phys_vec[i].paddr,
                        phys_vec[i].len, dir,
                        DMA_ATTR_MMIO);

Later during teardown, the fallback error path iterates over the individual
split SG entries and unmaps them separately:

    err_unmap_dma:
        ...
        } else {
            for_each_sgtable_dma_sg(&dma->sgt, sgl, i)
                dma_unmap_phys(attach->dev, sg_dma_address(sgl),
                               sg_dma_len(sgl), dir, DMA_ATTR_MMIO);

The same piece-by-piece unmapping also happens in dma_buf_free_sgt().

Since the DMA API requires that the size and address passed to dma_unmap_ph=
ys()
exactly match the original call to dma_map_phys(), could these partial unma=
ps
corrupt IOMMU tracking structures?

[Severity: High]
This is a pre-existing issue, but does the fallback error path unconditiona=
lly
unmap unpopulated, zero-initialized scatterlist entries?

    } else {
        for_each_sgtable_dma_sg(&dma->sgt, sgl, i)
            dma_unmap_phys(attach->dev, sg_dma_address(sgl),
                           sg_dma_len(sgl), dir, DMA_ATTR_MMIO);

The for_each_sgtable_dma_sg macro shadows and resets 'i' to 0, looping over
all allocated entries (dma->sgt.nents) rather than just the successfully
mapped ranges.

Since the table was allocated with __GFP_ZERO, the unpopulated entries will
have a length and address of 0. Could passing these to dma_unmap_phys()
trigger IOMMU faults?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914212258.2657=
788-1-dave@stgolabs.net?part=3D3
