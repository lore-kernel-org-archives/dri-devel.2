Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004FECD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E31510F961;
	Mon,  8 Jun 2026 19:58:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NsXA6REs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D897910F961
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 19:58:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8579041B3F;
 Mon,  8 Jun 2026 19:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B1F1F00893;
 Mon,  8 Jun 2026 19:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780948715;
 bh=7epI27h3Uel2X7IUsxelfxB2Yu8Z8sqDZz9eBijiuOw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NsXA6REsync7VsGzx1mnsZIURqQMuFmHA5RfsaePM6R9RQTX7DMu3yf6sgOgDtS9D
 f8FMK810ROgwVjlUi6uNA37EXhZO3u+B7iC41/idFPWxH1a/z0CR2DGFM+vvV3Kk4B
 t1mXjFcm4hGq8c7nxTucw+xdHHvXgqAYjnySv9fUNX5+Or8ZgrXTppV1AJ0QZ+FBYv
 QddvaCAsgKzm7/7bCBn9xGQhBXMvKrMlrG9U1oKNgYEfRX/0T+hL7hsZ6xfgtjjn2l
 I5YqDLF709ruLrcOiTW+jiCMAK/KFHtRBGZIoqdme8m+cVvbajES73uBKhm7iH4JY9
 Mo23ejTi6oDVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] dma-buf: Fix silent overflow for phys vec to sgt
To: "David Hu" <xuehaohu@google.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608194321.150838-1-xuehaohu@google.com>
References: <20260608194321.150838-1-xuehaohu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 19:58:34 +0000
Message-Id: <20260608195835.53B1F1F00893@smtp.kernel.org>
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
- [High] Allocated IOVA space is permanently leaked on failure paths.
- [High] The error path attempts to unmap uninitialized, zeroed scatterlist=
 entries.
- [High] Scatterlist array memory is permanently leaked during teardown bec=
ause `orig_nents` is explicitly set to 0.
- [High] Large physical regions are mapped as a single chunk but unmapped p=
iece-by-piece, violating the DMA API contract.
- [High] GFP_KERNEL allocations under the reclaim-reachable dma_resv lock c=
an trigger direct reclaim and deadlock.
- [High] Splitting contiguous physical chunks by UINT_MAX produces unaligne=
d segment addresses that violate hardware DMA requirements.
--

commit 97b0b96644dcfb56ce330ea289c02fcd6ac1f00c
Author: David Hu <xuehaohu@google.com>

dma-buf: Fix silent overflow for phys vec to sgt

In case MMIO size is bigger than 4G and peer2peer DMA goes
through host bridge, we trigger a code path that assigns the
total linked IOVA (which is greater than 4G) to mapped_len.

[ ... ]

> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-=
mapping.c
> index 794acff2546a3..67a8ff52fb8f8 100644
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
>  	for (i =3D 0; i < nents; i++) {

[Severity: High]
This isn't a bug introduced by this patch, but does splitting contiguous
physical chunks by UINT_MAX produce unaligned segment addresses that violate
hardware DMA requirements?

If ranges exceeding UINT_MAX are split at exactly UINT_MAX boundaries
(0xFFFFFFFF), the length of the first segment is 0xFFFFFFFF, and the next
segment begins at addr + 0xFFFFFFFF.

This subsequent address is offset by 4095 bytes relative to a 4KB page and =
is
strictly unaligned. Most hardware DMA controllers and IOMMUs require
scatterlist segment boundaries (except possibly the start of the first and
end of the last transfer) to be page-aligned.

Will this arbitrary unaligned splitting cause hardware DMA engines to fail
or stall?

[ ... ]

> @@ -133,6 +138,8 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_b=
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
This isn't a bug introduced by this patch, but can GFP_KERNEL allocations
under the reclaim-reachable dma_resv lock trigger direct reclaim and deadlo=
ck?

Earlier in dma_buf_phys_vec_to_sgt(),
dma_resv_assert_held(attach->dmabuf->resv) asserts that the dma_resv lock
is held.

Because the dma_resv ww_mutex is a known reclaim-reachable lock routinely
acquired by DRM subsystem shrinkers, triggering direct reclaim while holding
this lock risks recursing into a shrinker.

Could the shrinker attempt to acquire the same lock or another lock forming=
 a
dependency chain, leading to a deadlock? Should these allocations use
GFP_NOIO/GFP_NOFS or rely on a memalloc_noio_save() context guard?


[Severity: High]
This is a pre-existing issue, but is allocated IOVA space permanently leaked
on failure paths in dma_buf_phys_vec_to_sgt()?

When dma_iova_try_alloc() succeeds, it allocates IOVA space inside the IOMM=
U.
If the subsequent sg_alloc_table() fails, the code jumps to err_free_state:

    ret =3D sg_alloc_table(&dma->sgt, nents, GFP_KERNEL | __GFP_ZERO);
    if (ret)
        goto err_free_state;

The err_free_state label only frees the dma->state struct and bypasses
dma_iova_destroy(), which permanently leaks the IOVA space.

Additionally, if dma_iova_link() fails on the first iteration (i =3D=3D 0),
execution jumps to err_unmap_dma. The condition if (!i || !dma->state)
evaluates to true, doing nothing. It intentionally bypasses
dma_iova_destroy(..., 0, ...) (which correctly handles zero-length unmaps
by freeing the IOVA) and falls through to err_free_state, causing a second
IOVA leak.


[Severity: High]
This is a pre-existing issue, but does the error path attempt to unmap
uninitialized, zeroed scatterlist entries?

If dma_map_phys() fails partway through the loop in dma_buf_phys_vec_to_sgt=
(),
the error teardown path (err_unmap_dma) uses the iterator:

    for_each_sgtable_dma_sg(&dma->sgt, sgl, i)
        dma_unmap_phys(attach->dev, sg_dma_address(sgl), ...);

This macro resets i =3D 0 and iterates up to sgt->nents. Because
sg_alloc_table() allocated the entire array with __GFP_ZERO but
fill_sg_entry() only populated the entries up to the point of failure,
all remaining unmapped entries have sg_dma_address(sgl) =3D=3D 0 and
sg_dma_len(sgl) =3D=3D 0.

Could the loop blindly pass these zeros to dma_unmap_phys(), resulting in
invalid DMA API calls that will trigger IOMMU faults and kernel warnings?


[Severity: High]
This is a pre-existing issue, but is scatterlist array memory permanently
leaked during teardown because orig_nents is explicitly set to 0?

At the end of dma_buf_phys_vec_to_sgt(), the code sets:

    dma->sgt.orig_nents =3D 0;

to signal to importers that no CPU list is available. However, when the buf=
fer
is later unmapped, dma_buf_free_sgt() calls sg_free_table(sgt).

sg_free_table() relies on table->orig_nents to know how many entries to
iterate over when freeing the memory chunks. Because orig_nents is 0,
__sg_free_table() bypasses its inner freeing loop entirely and returns
immediately.

Does this permanently leak the sg_kmalloc allocated scatterlist arrays on
every map/unmap cycle?


[Severity: High]
This is a pre-existing issue, but are large physical regions mapped as a
single chunk but unmapped piece-by-piece, violating the DMA API contract?

When phys_vec[i].len exceeds UINT_MAX, dma_buf_phys_vec_to_sgt() calls
dma_map_phys() exactly once for the entire length. fill_sg_entry() then
splits this single mapped chunk into multiple scatterlist entries.

During teardown in dma_buf_free_sgt() (and err_unmap_dma), the code iterates
over each individual scatterlist entry and calls dma_unmap_phys()
piece-by-piece.

The DMA API contract strictly requires that dma_unmap_phys() be called with
the exact same address and size originally returned by the mapping function.
Will unmapping subsets of a mapped region cause IOMMU tracking corruption
and trigger DMA-API warnings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608194321.1508=
38-1-xuehaohu@google.com?part=3D1
