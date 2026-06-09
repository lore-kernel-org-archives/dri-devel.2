Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F84DCD8CB2
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE63410E520;
	Tue,  9 Jun 2026 16:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O6Z5lnVw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C16289048
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 16:54:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B23B24396F;
 Tue,  9 Jun 2026 16:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778061F00893;
 Tue,  9 Jun 2026 16:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781024071;
 bh=2rY+836NRXqJsZySQZB8j5MmY2CsrhQx2+B9KL9cTWo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O6Z5lnVw2kNCzUft8Ta/VrgrNht0bNXZLwgNB5y7wt+mXhDciTis9/s6fPD1dngg0
 XHxfmzXOdh8P0rmCeUpwBA6ERuNi1PGR8tROrEw6z0C2HmrNVj1NOZruXz2qkhwN2v
 at2htbRkSSB9WBVs1hmiw7U5hovm3OjcTMNOfIkowNZIp9pI1hxr2nspw/BLf9vM1c
 Ny4wBZClWERUw+Q6lImR55ZThvFUwbEiT16JKY3qydj2nhyGYl8le6TRKcUSwxP4Zi
 sMYbKwLSnhfqtBb1hmxsIhEJePOdQkuA+sLe5ZuJPXtHa1QlHhHFoVPyOUqA/Agz2A
 w7h7io7Rr+rZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] dma-buf: Fix silent overflow for phys vec to sgt
To: "David Hu" <xuehaohu@google.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609164047.486227-1-xuehaohu@google.com>
References: <20260609164047.486227-1-xuehaohu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 16:54:31 +0000
Message-Id: <20260609165431.778061F00893@smtp.kernel.org>
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
- [High] DIV_ROUND_UP(length, UINT_MAX) silently evaluates to 0 on 32-bit a=
rchitectures, causing allocation failures.
- [High] Error recovery path unmaps uninitialized scatterlist entries and i=
mproperly unmaps split entries.
- [High] dma_iova_link() is consistently called with a hardcoded offset of =
0, causing overlapping IOVA mappings.
- [High] IOVA space allocated by dma_iova_try_alloc() is permanently leaked=
 on multiple error paths.
- [High] Mismatch between caller-provided size and sum of phys_vec[i].len c=
auses out-of-bounds write and NULL pointer dereference.
- [High] Splitting physical memory ranges with UINT_MAX creates unaligned s=
catterlist entries, violating IOMMU page alignment rules.
--

commit 451e93086fcd7b734bfb9aa07420089c45fd9663
Author: David Hu <xuehaohu@google.com>

dma-buf: Fix silent overflow for phys vec to sgt

This patch changes mapped_len to size_t to fix a silent wrap-around
when accumulating lengths. It also adds check_add_overflow() in
calc_sg_nents and uses unsigned int for the loop iterator in
fill_sg_entry.

Cc: stable@vger.kernel.org
Cc: iommu@lists.linux.dev

> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-=
mapping.c
> index 794acff2546a3..80f6ab2f4809d 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -5,12 +5,13 @@
>   */
>  #include <linux/dma-buf-mapping.h>
>  #include <linux/dma-resv.h>
> +#include <linux/overflow.h>
> =20
>  static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t=
 length,
>  					 dma_addr_t addr)
>  {
>  	unsigned int len, nents;
> -	int i;
> +	unsigned int i;
> =20
>  	nents =3D DIV_ROUND_UP(length, UINT_MAX);

[Severity: High]
This is a pre-existing issue, but splitting physical memory ranges using
UINT_MAX can create unaligned scatterlist entries:

drivers/dma-buf/dma-buf-mapping.c:fill_sg_entry() {
	...
	for (i =3D 0; i < nents; i++) {
		len =3D min_t(size_t, length, UINT_MAX);
		...
		sg_dma_address(sgl) =3D addr + (dma_addr_t)i * UINT_MAX;
		...
	}
	...
}

Because UINT_MAX (0xFFFFFFFF) is not page-aligned, if a physical range exce=
eds
UINT_MAX, the first segment has a non-page-aligned length, and the next seg=
ment
will start at an unaligned DMA address.

Since IOMMU mapping and DMA engine APIs require middle segments to be align=
ed
to hardware page boundaries, could passing unaligned addresses and sizes ca=
use
silent DMA corruption or explicit mapping failures? Would it be safer to al=
ign
the max length chunk to the page mask (e.g., ALIGN_DOWN(UINT_MAX, PAGE_SIZE=
))?

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
This isn't a bug introduced by this patch, but on 32-bit architectures,
size_t and unsigned int are 32 bits. The macro DIV_ROUND_UP(n, d) evaluates
as ((n) + (d) - 1) / (d).

When phys_vec[i].len <=3D UINT_MAX (e.g., 4096), the expression
4096 + 0xFFFFFFFF - 1 wraps around in 32-bit unsigned arithmetic to 4094.
Consequently, 4094 / 0xFFFFFFFF results in 0.

Does this cause calc_sg_nents() and fill_sg_entry() to compute 0 entries,
forcing sg_alloc_table() to fail with -EINVAL and permanently breaking DMA
mapping on 32-bit platforms?

> +			if (check_add_overflow(nents, added, &nents))
> +				return 0;
> +		}
>  	} else {
>  		/*
>  		 * In IOVA case, there is only one SG entry which spans

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
This isn't a bug introduced by this patch, but if there's a mismatch between
the caller-provided size and the sum of phys_vec[i].len, could it cause an
out-of-bounds write?

drivers/dma-buf/dma-buf-mapping.c:dma_buf_phys_vec_to_sgt() {
	...
	if (dma->state && dma_use_iova(dma->state)) {
		WARN_ON_ONCE(mapped_len !=3D size);
		ret =3D dma_iova_sync(attach->dev, dma->state, 0, mapped_len);
		if (ret)
			goto err_unmap_dma;

		sgl =3D fill_sg_entry(sgl, mapped_len, dma->state->addr);
	}
	...
}

If size is smaller than mapped_len, the SG table is allocated with nents
derived from size, but fill_sg_entry() is later called with mapped_len.
The loop inside fill_sg_entry() would then iterate more times than the
allocated size of the scatterlist.

Could this cause sg_next() to return NULL, leading to a NULL pointer
dereference and out-of-bounds write on the sgl object since execution proce=
eds
past the WARN_ON_ONCE?

[Severity: High]
This is a pre-existing issue, but could the IOVA space allocated by
dma_iova_try_alloc() be permanently leaked on multiple error paths?

drivers/dma-buf/dma-buf-mapping.c:dma_buf_phys_vec_to_sgt() {
	...
err_unmap_dma:
	if (!i || !dma->state) {
		; /* Do nothing */
	} else if (dma_use_iova(dma->state)) {
		dma_iova_destroy(attach->dev, dma->state, mapped_len, dir,
				 DMA_ATTR_MMIO);
	}
	...
err_free_state:
	kfree(dma->state);
err_free_dma:
	kfree(dma);
	return ERR_PTR(ret);
}

If sg_alloc_table() fails, execution jumps to err_free_state, which frees
the state memory but doesn't call dma_iova_free() or dma_iova_destroy() to
release the IOMMU address space.

Additionally, if dma_iova_link() fails on the first iteration (i =3D=3D 0),
it jumps to err_unmap_dma where (!i) is true, skipping dma_iova_destroy()
and proceeding to err_free_state, again leaking the address space. Does
this logic need adjusting to properly release the IOVA space?

[Severity: High]
This isn't a bug introduced by this patch, but dma_iova_link() appears to be
consistently called with a hardcoded offset of 0:

drivers/dma-buf/dma-buf-mapping.c:dma_buf_phys_vec_to_sgt() {
	...
		} else if (dma_use_iova(dma->state)) {
			ret =3D dma_iova_link(attach->dev, dma->state,
					    phys_vec[i].paddr, 0,
					    phys_vec[i].len, dir,
					    DMA_ATTR_MMIO);
	...
}

If there are multiple physical ranges (nr_ranges > 1), wouldn't every single
range be mapped to the exact same start address within the allocated IOVA
space? Could this overwrite previous mappings and corrupt the IOMMU page
tables? Should the offset parameter be the accumulated mapped_len instead
of 0?

[Severity: High]
This isn't a bug introduced by this patch, but could the error recovery path
improperly unmap scatterlist entries?

drivers/dma-buf/dma-buf-mapping.c:dma_buf_phys_vec_to_sgt() {
	...
err_unmap_dma:
	...
	} else {
		for_each_sgtable_dma_sg(&dma->sgt, sgl, i)
			dma_unmap_phys(attach->dev, sg_dma_address(sgl),
				       sg_dma_len(sgl), dir, DMA_ATTR_MMIO);
	}
	...
}

If dma_map_phys() fails mid-loop, for_each_sgtable_dma_sg() iterates over
all dma->sgt.nents allocated entries. Unpopulated trailing entries will have
addr=3D0 and len=3D0, leading to invalid dma_unmap_phys() calls.

Furthermore, if a range exceeded UINT_MAX, it was mapped via dma_map_phys()
as a single contiguous chunk but split into multiple SG entries by
fill_sg_entry(). Doesn't unmapping these sub-chunks piece-wise in the SG
iteration loop violate the DMA API, which requires the exact contiguous
dma_addr_t and size originally mapped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609164047.4862=
27-1-xuehaohu@google.com?part=3D1
