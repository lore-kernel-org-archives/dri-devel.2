Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6199CDB466
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 02:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F2E10E6BD;
	Tue, 23 Jun 2026 02:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ALuGzQu6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D01AB10E75D
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 02:08:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 97B6D40226;
 Tue, 23 Jun 2026 02:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2F31F000E9;
 Tue, 23 Jun 2026 02:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782180535;
 bh=E9tQOGhQWozl1UAi9+rgQ6HzZzadpmyecw5nImXti58=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ALuGzQu6V0gd1Pmdm82qS5HqMTf7dtqbiNRFPhDX+RlAoMEPl5xC4WpJnFYAL8cwY
 QrU1gIopU+N8yipSenqSCRR4uaHjuZx3D3lxfa8adTeIRCPduNuDhAwo9/9yLJZyKD
 nSJ0FiMYShmqERfDyokq+zNdraCMX3jvN10ioY95xrLixz5jGBkCq78qAyHlMo/Aej
 WVZzT/zonhwyg5Vc2EyL9knnFh1DJ7lXIZZc+uxUgfcgMcODn4PWfhNyWvhKG9Hst0
 EobWQc+BkGRnzOLPPEt4VZv3pCk9kHqCHs9WtDsQAFsytQf06RttMCJyroRvxX7P9B
 ukZ2IxDC8t7vA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
To: "David Hu" <xuehaohu@google.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623015459.1153884-1-xuehaohu@google.com>
References: <20260621222130.1667453-1-xuehaohu@google.com>
 <20260623015459.1153884-1-xuehaohu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 02:08:55 +0000
Message-Id: <20260623020855.5D2F31F000E9@smtp.kernel.org>
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

New issues:
- [Critical] Arithmetic overflow in `calc_sg_nents` on 32-bit systems cause=
s an under-allocation of scatterlist entries, leading to a NULL pointer der=
eference in `fill_sg_entry`.

Pre-existing issues:
- [High] Incorrect DMA unmapping of split scatterlist chunks and unpopulate=
d entries violates the DMA API and corrupts IOMMU state.
--

commit f3f35bb73743f61d1b46175517c947331e0902f1
Author: David Hu <xuehaohu@google.com>

dma-buf: Split sgl into page-aligned 2G chunks

Currently, fill_sg_entry() splits the scatterlist using UINT_MAX. This patch
changes the split to 2G chunks to satisfy page alignment and natural hardwa=
re
boundaries for DMA engines.

Link: https://lore.kernel.org/all/20260609165431.778061F00893@smtp.kernel.o=
rg/

> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-=
mapping.c
> index 794acff2546a3..2d88e08c5ebf9 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -5,16 +5,17 @@
>   */
>  #include <linux/dma-buf-mapping.h>
>  #include <linux/dma-resv.h>
> +#include <linux/sizes.h>
> +
> +#define MAX_SG_ENT_SZ ((size_t)SZ_2G)
> =20
>  static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t=
 length,
>  					 dma_addr_t addr)
>  {
> -	unsigned int len, nents;
> -	int i;
> +	size_t len;
> =20
> -	nents =3D DIV_ROUND_UP(length, UINT_MAX);
> -	for (i =3D 0; i < nents; i++) {
> -		len =3D min_t(size_t, length, UINT_MAX);
> +	while (length) {
> +		len =3D min(length, MAX_SG_ENT_SZ);
>  		length -=3D len;
>  		/*
>  		 * DMABUF abuses scatterlist to create a scatterlist
> @@ -24,11 +25,12 @@ static struct scatterlist *fill_sg_entry(struct scatt=
erlist *sgl, size_t length,
>  		 * does not require the CPU list for mapping or unmapping.
>  		 */
>  		sg_set_page(sgl, NULL, 0, 0);

[Severity: Critical]
Will this lead to a NULL pointer dereference on 32-bit systems?

If phys_vec[i].len is greater than 2GB (e.g. 0x80000001), the DIV_ROUND_UP
macro in calc_sg_nents() will overflow because size_t is 32-bit and
MAX_SG_ENT_SZ is 0x80000000:

    (0x80000001 + 0x80000000 - 1) / 0x80000000 =3D=3D 0

This means no SGL entries are calculated or allocated for this region. Howe=
ver,
the while loop in fill_sg_entry() will still iterate to process the remaini=
ng
length. It will eventually advance past the end of the undersized scatterli=
st
table via:

    sgl =3D sg_next(sgl);

which becomes NULL, and then dereference it on the next iteration via
sg_set_page(sgl, ...).

> -		sg_dma_address(sgl) =3D addr + (dma_addr_t)i * UINT_MAX;
> +		sg_dma_address(sgl) =3D addr;
>  		sg_dma_len(sgl) =3D len;
> +		addr +=3D len;
> +		/* Unconditionally advance. On last segment, this becomes NULL */
>  		sgl =3D sg_next(sgl);
>  	}
> -
>  	return sgl;
>  }
> =20
> @@ -41,14 +43,14 @@ static unsigned int calc_sg_nents(struct dma_iova_sta=
te *state,
> =20
>  	if (!state || !dma_use_iova(state)) {
>  		for (i =3D 0; i < nr_ranges; i++)
> -			nents +=3D DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
> +			nents +=3D DIV_ROUND_UP(phys_vec[i].len, MAX_SG_ENT_SZ);
>  	} else {
>  		/*
>  		 * In IOVA case, there is only one SG entry which spans
>  		 * for whole IOVA address space, but we need to make sure
>  		 * that it fits sg->length, maybe we need more.
>  		 */
> -		nents =3D DIV_ROUND_UP(size, UINT_MAX);
> +		nents =3D DIV_ROUND_UP(size, MAX_SG_ENT_SZ);
>  	}
> =20
>  	return nents;

[Severity: High]
This isn't a bug introduced by this patch, but does iterating over the SGL =
to
unmap chunked entries violate the DMA API?

In dma_buf_phys_vec_to_sgt(), dma_map_phys() maps the full, contiguous orig=
inal
length of phys_vec[i].len. However, fill_sg_entry() splits this mapped regi=
on
into smaller chunks.

When unmapping, both the error path in dma_buf_phys_vec_to_sgt() and the
teardown in dma_buf_free_sgt() iterate over the split SGL entries:

drivers/dma-buf/dma-buf-mapping.c:dma_buf_free_sgt() {
    ...
		for_each_sgtable_dma_sg(sgt, sgl, i)
			dma_unmap_phys(attach->dev, sg_dma_address(sgl),
				       sg_dma_len(sgl), dir, DMA_ATTR_MMIO);
    ...
}

Does the DMA API permit unmapping partial chunks instead of the exact length
and address originally mapped?

Additionally, in the error path of dma_buf_phys_vec_to_sgt():

drivers/dma-buf/dma-buf-mapping.c:dma_buf_phys_vec_to_sgt() {
    ...
err_unmap_dma:
	if (!i || !dma->state) {
		; /* Do nothing */
	...
	} else {
		for_each_sgtable_dma_sg(&dma->sgt, sgl, i)
			dma_unmap_phys(attach->dev, sg_dma_address(sgl),
				       sg_dma_len(sgl), dir, DMA_ATTR_MMIO);
	}
    ...
}

Is it safe to reuse the outer loop variable i here? Since i was tracking the
successfully mapped count, using it in for_each_sgtable_dma_sg() clobbers it
and forces iteration up to the sgt->nents capacity, which could unmap
unpopulated zero-initialized entries or page 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623015459.1153=
884-1-xuehaohu@google.com?part=3D1
