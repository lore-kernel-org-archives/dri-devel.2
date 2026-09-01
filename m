Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2888DC624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 441E210EDF8;
	Tue,  1 Sep 2026 17:30:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cp/EXw/t";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E205510EDF8
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 17:30:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6612F602C4;
 Tue,  1 Sep 2026 17:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F081F00A3E;
 Tue,  1 Sep 2026 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788283816;
 bh=Yirw2pKMxdvOkW1hnXJxWzXgfd4LhifB1fQ520fOC6s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Cp/EXw/tpy2Aa6v3jyrg65zksV6/PRcmxpVkwXopAKrqEGKsjXTpXZGcoWxA/NqNQ
 7M3r4MIDUcEnRC8ApLY/0/eCBHy0YW9H3v1d3Evy//lMZuWWBm3ah7+ijLS3otvmlA
 kzZ631SBaP++dpKBDSujICAxnjlwvCwxDMEVOBJ/2Z5ie9Xs82oUNOqvHmsctzXiB/
 1zT/qrreJvtSblBbsE7pb2NP1Y2EhDrJ0QptCwgbsFOgqli8K8sUaJdrP8eR4PZ5o5
 QCh1+Ob8uSldt0z78o04yrZ62Q6DJcq0o0OgS1ZSIxm7CeHu0Tex8wDODf+zZGAhby
 tPvZjtmVajvBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/2] dma-buf: Fix silent overflow for phys vec to sgt
To: "David Hu" <dhu@x6u.co>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260901170849.4052816-2-dhu@x6u.co>
References: <20260901170849.4052816-1-dhu@x6u.co>
 <20260901170849.4052816-2-dhu@x6u.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:30:15 +0000
Message-Id: <20260901173015.D9F081F00A3E@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Incorrect offset parameter passed to dma_iova_link() causes al=
l physical vectors to overwrite each other at the same IOVA address.
- [Critical] Partial unmapping of DMA mappings via segmented scatterlist en=
tries violates the DMA API.
- [High] DIV_ROUND_UP macro wraps around on 32-bit platforms, causing calc_=
sg_nents to evaluate to 0 and failing the mapping.
- [High] Setting sgt.orig_nents =3D 0 breaks sg_free_table, causing a silen=
t memory leak of the scatterlist.
- [High] Error path unmaps all uninitialized scatterlist entries due to an =
incorrect loop iterator macro shadowing the index.
- [High] IOVA space allocated by dma_iova_try_alloc() is leaked on multiple=
 error paths.
--

commit 3ea75e22b2b7ea7287fcbeb0fa39a0b99a722743
Author: David Hu <xuehaohu@google.com>

dma-buf: Fix silent overflow for phys vec to sgt
   =20
This commit changes mapped_len to a 64-bit size_t to prevent silent wrap-ar=
ound
during length accumulation for MMIO greater than 4G. It also introduces
check_add_overflow() in calc_sg_nents() for safer scatterlist entry
accumulation.

> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-=
mapping.c
> index 794acff2546a3..80f6ab2f4809d 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c

[ ... ]

> @@ -40,8 +41,12 @@ static unsigned int calc_sg_nents(struct dma_iova_stat=
e *state,
>  	size_t i;
> =20
>  	if (!state || !dma_use_iova(state)) {
> -		for (i =3D 0; i < nr_ranges; i++)
> -			nents +=3D DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
> +		for (i =3D 0; i < nr_ranges; i++) {
> +			unsigned int added =3D DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);

[Severity: High]
This is a pre-existing issue, but could DIV_ROUND_UP wrap around on 32-bit
platforms here?

Since size_t is 32-bit on those architectures, phys_vec[i].len + UINT_MAX -=
 1
wraps around the maximum 32-bit value. For any chunk length larger than a p=
age,
added will evaluate to 0, completely failing the DMA mapping.

> +
> +			if (check_add_overflow(nents, added, &nents))
> +				return 0;
> +		}

[ ... ]

> @@ -133,6 +139,8 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_b=
uf_attachment *attach,
>  	}
> =20
>  	nents =3D calc_sg_nents(dma->state, phys_vec, nr_ranges, size);
> +
> +	/* sg_alloc_table will cleanly fail and return -EINVAL if nents =3D=3D =
0 */
>  	ret =3D sg_alloc_table(&dma->sgt, nents, GFP_KERNEL | __GFP_ZERO);
>  	if (ret)
>  		goto err_free_state;

[Severity: High]
This is a pre-existing issue, but is it possible this jump leaks the alloca=
ted
IOVA space?

If sg_alloc_table fails, the jump to err_free_state frees dma->state, but
doesn't call dma_iova_destroy().

Also, since this patch updates this function, I noticed a few other
pre-existing issues further down in dma_buf_phys_vec_to_sgt():

[Severity: Critical]
This is a pre-existing issue, but will the hardcoded zero offset overwrite
mappings at the start of the IOVA space?

In the loop later in this function:

    } else if (dma_use_iova(dma->state)) {
        ret =3D dma_iova_link(attach->dev, dma->state,
                            phys_vec[i].paddr, 0,
                            phys_vec[i].len, dir,
                            DMA_ATTR_MMIO);

Passing the literal 0 as the offset for every vector causes all physical
vectors to be mapped to the exact same starting IOVA address. Should this u=
se
the accumulated mapped_len instead?

[Severity: Critical]
This is a pre-existing issue, but does this chunk-by-chunk unmap violate the
DMA API?

The code maps contiguous physical memory as a single chunk:

    addr =3D dma_map_phys(attach->dev, phys_vec[i].paddr,
                        phys_vec[i].len, dir, DMA_ATTR_MMIO);

But then in fill_sg_entry(), it splits this mapping into multiple scatterli=
st
entries. During teardown in dma_buf_free_sgt() and err_unmap_dma, it unmaps
these segmented pieces:

    for_each_sgtable_dma_sg(&dma->sgt, sgl, i)
        dma_unmap_phys(attach->dev, sg_dma_address(sgl),
                       sg_dma_len(sgl), dir, DMA_ATTR_MMIO);

Can this partial unmapping of a single mapped region corrupt IOMMU state
or cause undefined behavior?

[Severity: High]
This is a pre-existing issue, but does the error path iterate over
uninitialized scatterlist entries and leak IOVA space?

Looking at err_unmap_dma:

err_unmap_dma:
    if (!i || !dma->state) {
        ; /* Do nothing */

If an error occurs on the first loop iteration, the !i check safely returns=
 but
skips dma_iova_destroy(), leaking the IOVA space here as well.

Furthermore, the loop down in that error path shadows the index variable:

    } else {
        for_each_sgtable_dma_sg(&dma->sgt, sgl, i)
            dma_unmap_phys(...)
    }

Because for_each_sgtable_dma_sg uses i as its internal iterator (iterating
up to dma->sgt.nents), it resets i to 0 and processes all entries, including
uninitialized zero-elements, rather than stopping at the count of successfu=
lly
mapped segments.

[Severity: High]
This is a pre-existing issue, but would clearing orig_nents cause a silent
memory leak?

At the end of dma_buf_phys_vec_to_sgt():

    /*
     * No CPU list included =E2=80=94 set orig_nents =3D 0 so others can de=
tect
     * this via SG table (use nents only).
     */
    dma->sgt.orig_nents =3D 0;

When dma_buf_free_sgt() eventually calls sg_free_table(), the underlying
__sg_free_table() uses table->orig_nents to determine how many chunks to fr=
ee.
Since it is 0, won't the free loop terminate immediately and silently leak =
the
entire scatterlist memory allocation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901170849.4052=
816-1-dhu@x6u.co?part=3D1
