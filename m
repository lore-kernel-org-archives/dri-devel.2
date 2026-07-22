Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587F9C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 23:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 944A310E504;
	Wed, 22 Jul 2026 23:59:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kRMbIcp/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAC3210E504
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 23:59:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4507D4146A;
 Wed, 22 Jul 2026 23:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EFC1F000E9;
 Wed, 22 Jul 2026 23:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784764784;
 bh=kpe59quPSeU6bV9Bc2TVzWIhqwk1ek0xbuoTW1AiQCU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kRMbIcp/blFT7pj3gX0MUrKVOO88UdLZOChgzPEiUMkn3pLjCU2gsnhKhv6oY9Ddw
 UTKoTUFSzjQ7+IRLp5GygFs9mksHlvUAQK1g9pC0nqUr4TQ2Q15L7IkzsLyJWe7QBA
 yBa2KUZtDk/WaDJGttH/O8BVTJXOsnoh2EJMZ0GB1zK8sKhaJoeX9EVQYwUq0BzlhO
 YHwCHLi1/DR/N/1acgC7W1SGZbSoP7lbeCn+CX3n5wV9YLmOJYLBA91b6ogQTkFvOz
 +1fNg8bRcVTFCo6pc6pG5l81hvLmNCp5wnpYIuSAxOQOoBL8OEfCQT4xK3eja/Cy8K
 R9DxOySnnIwyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk
To: dhu@x6u.co
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260722233932.3997681-1-dhu@x6u.co>
References: <20260623015459.1153884-1-xuehaohu@google.com>
 <20260722233932.3997681-1-dhu@x6u.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:59:43 +0000
Message-Id: <20260722235943.E7EFC1F000E9@smtp.kernel.org>
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

New issues:
- [High] Integer Overflow / NULL Pointer Dereference in sg mapping calculat=
ion

Pre-existing issues:
- [High] 32-bit Integer Overflow causing incomplete DMA mappings
- [High] DMA API Violation (Mismatched Map/Unmap Size)
- [High] IOVA Resource Leak on Error Paths
--

--- Patch [1]: [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk =
---
commit 6c6b736bcfe57779f8dd4452cee1c6738c03f76d
Author: David Hu <xuehaohu@google.com>

dma-buf: Split sgl by largest page-aligned chunk

This commit updates scatterlist chunking in dma-buf to use=20
ALIGN_DOWN(UINT_MAX, PAGE_SIZE) instead of UINT_MAX. This ensures that=20
scatterlist DMA addresses and lengths remain strictly page-aligned, which=20
avoids truncation on hardware engines and fixes a fallback issue in=20
ib_umem_find_best_pgsz().

Closes: https://lore.kernel.org/all/20260609165431.778061F00893@smtp.kernel=
.org/
Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping r=
outine")

> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-=
mapping.c
> index 794acff2546a3..50ded9daf5fb3 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
[ ... ]
> @@ -24,8 +25,10 @@ static struct scatterlist *fill_sg_entry(struct scatte=
rlist *sgl, size_t length,
>  		 * does not require the CPU list for mapping or unmapping.
>  		 */
>  		sg_set_page(sgl, NULL, 0, 0);

[Severity: High]
Does this new while loop correctly handle an undersized scatterlist?

If calc_sg_nents() returns 0 due to the 32-bit overflow mentioned below,
this while loop still processes the full length. It will exhaust the
SGL entries, receive a NULL from sg_next(), and dereference it during
the next call to sg_set_page().

> -		sg_dma_address(sgl) =3D addr + (dma_addr_t)i * UINT_MAX;
> +		sg_dma_address(sgl) =3D addr;
>  		sg_dma_len(sgl) =3D len;
> +		addr +=3D len;
> +		/* Unconditionally advance. On last segment, this becomes NULL */
>  		sgl =3D sg_next(sgl);
>  	}
> =20
> @@ -41,14 +44,14 @@ static unsigned int calc_sg_nents(struct dma_iova_sta=
te *state,
> =20
>  	if (!state || !dma_use_iova(state)) {
>  		for (i =3D 0; i < nr_ranges; i++)
> -			nents +=3D DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
> +			nents +=3D DIV_ROUND_UP(phys_vec[i].len, MAX_SG_ENT_SZ);
                           ^^^^

[Severity: High]
Can this DIV_ROUND_UP() overflow on 32-bit platforms?

MAX_SG_ENT_SZ is ALIGN_DOWN(0xFFFFFFFF, PAGE_SIZE), which is 0xFFFFF000.
The DIV_ROUND_UP(len, MAX_SG_ENT_SZ) expands to
(len + 0xFFFFF000 - 1) / 0xFFFFF000. If len is 4097 or greater, this
addition overflows a 32-bit integer and wraps around, yielding 0. This
allocates 0 scatterlist entries for that chunk.

>  	} else {
>  		/*
>  		 * In IOVA case, there is only one SG entry which spans
>  		 * for whole IOVA address space, but we need to make sure
>  		 * that it fits sg->length, maybe we need more.
>  		 */
> -		nents =3D DIV_ROUND_UP(size, UINT_MAX);
> +		nents =3D DIV_ROUND_UP(size, MAX_SG_ENT_SZ);

[Severity: High]
Similarly, can this calculation overflow in the IOVA case when processing
sizes >=3D 4097 bytes on a 32-bit platform?

>  	}
> =20
>  	return nents;

[ ... ]

While reviewing this code, I noticed a few pre-existing issues in the same
file that you might want to address:

[Severity: High]
This isn't a bug introduced by this patch, but does mapped_len silently wrap
around on 64-bit platforms?

drivers/dma-buf/dma-buf-mapping.c:dma_buf_phys_vec_to_sgt() {
    unsigned int nents, mapped_len =3D 0;

    [ ... ]

    for (i =3D 0; i < nr_ranges; i++) {

        [ ... ]

        mapped_len +=3D phys_vec[i].len;
    }
}

Because mapped_len is a 32-bit unsigned int and phys_vec[i].len is a 64-bit
size_t, calculating a total mapping size larger than 4GB overflows mapped_l=
en.


[Severity: High]
This isn't a bug introduced by this patch, but does the error path leak the
IOVA allocation?

drivers/dma-buf/dma-buf-mapping.c:dma_buf_phys_vec_to_sgt() {

    [ ... ]

    dma_iova_try_alloc(attach->dev, dma->state, 0, size);

    [ ... ]

    ret =3D sg_alloc_table(&dma->sgt, nents, GFP_KERNEL | __GFP_ZERO);
    if (ret)
        goto err_free_state;

    [ ... ]

err_unmap_dma:
    if (!i || !dma->state) {
        ; /* Do nothing */
    } else if (dma_use_iova(dma->state)) {
        dma_iova_destroy(attach->dev, dma->state, mapped_len, dir,
                 DMA_ATTR_MMIO);

    [ ... ]

}

If sg_alloc_table() fails, the code branches to err_free_state, returning
without calling dma_iova_destroy(). Additionally, if mapping the first range
fails (i =3D=3D 0), the err_unmap_dma path executes the empty if-block and =
skips
cleanup.


[Severity: High]
This isn't a bug introduced by this patch, but does this unmap sequence
violate the requirement to match map and unmap sizes?

drivers/dma-buf/dma-buf-mapping.c:dma_buf_phys_vec_to_sgt() {

    [ ... ]

    addr =3D dma_map_phys(attach->dev, phys_vec[i].paddr,
                phys_vec[i].len, dir, DMA_ATTR_MMIO);

    [ ... ]

}

drivers/dma-buf/dma-buf-mapping.c:dma_buf_free_sgt() {

    [ ... ]

    for_each_sgtable_dma_sg(sgt, sgl, i)
        dma_unmap_phys(attach->dev, sg_dma_address(sgl),
                   sg_dma_len(sgl), dir, DMA_ATTR_MMIO);

    [ ... ]

}

The physical memory regions are mapped as single, contiguous blocks using
phys_vec[i].len, but the teardown path unmaps them in smaller chunks
iterating over the split scatterlist.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722233932.3997=
681-1-dhu@x6u.co?part=3D1
