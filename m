Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332F0C624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB9F310EDF6;
	Tue,  1 Sep 2026 17:30:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XDSSkggD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5175F10EDF6
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 17:30:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6ADE96020D;
 Tue,  1 Sep 2026 17:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE801F000E9;
 Tue,  1 Sep 2026 17:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788283809;
 bh=BR++alfaW7QLjijU+jW4Nd3dtt8RFWzyHTZGPyEdXn4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XDSSkggDpAqQsQso2ApXcZSJfABPRpqBJa2WnhjkBarlSyRREq258jmpdE+PXcidg
 dFnEZN2vtgT6xjwTnHxYqXdmkjUaJLolZVeokeFy+JpetGhZ+3qRVQP/TeY420vAzU
 XNbXpBASPsgsDVN5oEuEkXVz4QkwPOxzB5rZrQA2yMgG1jwgNeh0rzkd31Z2DdWhwH
 JL3vHlokahOU4v1SqpHuJvfFhCrDFbGrhm3uSOQlsEQTZdI1fO5OWfa/Z1jXXKZEiX
 +CSkf7ZLLkfHRZsIm3TzH2Yez6nl/UvY1jneTsO5jlkNyGVihgCLPv2hU48Cb5YEQH
 3gEZrZfSpgZig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/2] dma-buf: Split sgl by largest page-aligned chunk
To: "David Hu" <dhu@x6u.co>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260901170849.4052816-3-dhu@x6u.co>
References: <20260901170849.4052816-1-dhu@x6u.co>
 <20260901170849.4052816-3-dhu@x6u.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:30:08 +0000
Message-Id: <20260901173008.DFE801F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Deterministic NULL pointer dereference on 32-bit architectures=
 due to mismatch between scatterlist allocation and iteration count.

Pre-existing issues:
- [High] Piecewise unmapping of chunked DMA regions violates DMA API rules.
- [High] Error handling path shadows the loop counter and unmaps uninitiali=
zed scatterlist entries.
--

commit 352582e0a7698d4a99b7c620ded07fa0a65602c3
Author: David Hu <xuehaohu@google.com>

dma-buf: Split sgl by largest page-aligned chunk

This commit changes fill_sg_entry() to split scatterlists by
ALIGN_DOWN(UINT_MAX, PAGE_SIZE) rather than UINT_MAX to ensure entries
remain page-aligned. Page-aligned entries prevent failures in hardware
DMA engines that require explicit address alignment and avoid edge cases
in ib_umem_find_best_pgsz().

Link: https://lore.kernel.org/all/20260609165431.778061F00893@smtp.kernel.o=
rg/

> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-=
mapping.c
> index 80f6ab2f4809d..833be519e1e6a 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -6,16 +6,17 @@
>  #include <linux/dma-buf-mapping.h>
>  #include <linux/dma-resv.h>
>  #include <linux/overflow.h>
> +#include <linux/align.h>
> +
> +#define MAX_SG_ENT_SZ ALIGN_DOWN(UINT_MAX, PAGE_SIZE)
> =20
>  static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t=
 length,
>  					 dma_addr_t addr)
>  {
> -	unsigned int len, nents;
> -	unsigned int i;
> +	size_t len;
> =20
> -	nents =3D DIV_ROUND_UP(length, UINT_MAX);
> -	for (i =3D 0; i < nents; i++) {
> -		len =3D min_t(size_t, length, UINT_MAX);
> +	while (length) {
> +		len =3D min(length, MAX_SG_ENT_SZ);

[Severity: High]
This is a pre-existing issue, but does chunking the mapped physical region =
into
smaller pieces here cause a violation of the DMA API during teardown?

During dma_buf_free_sgt() or the err_unmap_dma path, the code iterates over=
 this
scatterlist and calls dma_unmap_phys() on each split chunk individually:

drivers/dma-buf/dma-buf-mapping.c:dma_buf_free_sgt() {
    ...
		for_each_sgtable_dma_sg(sgt, sgl, i)
			dma_unmap_phys(attach->dev, sg_dma_address(sgl),
				       sg_dma_len(sgl), dir, DMA_ATTR_MMIO);
    ...
}

The DMA API mandates that unmapping must use the exact identical start addr=
ess
and length that was originally passed to dma_map_phys().

>  		length -=3D len;
>  		/*
>  		 * DMABUF abuses scatterlist to create a scatterlist
> @@ -25,8 +26,10 @@ static struct scatterlist *fill_sg_entry(struct scatte=
rlist *sgl, size_t length,
>  		 * does not require the CPU list for mapping or unmapping.
>  		 */
>  		sg_set_page(sgl, NULL, 0, 0);

[Severity: Critical]
Since calc_sg_nents() calculates too few entries for lengths > 4096 on 32-b=
it
architectures due to integer wrapping, does this sg_set_page() unconditiona=
lly
dereference the NULL pointer returned by sg_next() when the undersized
scatterlist allocation is exhausted?

> -		sg_dma_address(sgl) =3D addr + (dma_addr_t)i * UINT_MAX;
> +		sg_dma_address(sgl) =3D addr;
>  		sg_dma_len(sgl) =3D len;
> +		addr +=3D len;
> +		/* Unconditionally advance. On last segment, this becomes NULL */
>  		sgl =3D sg_next(sgl);
>  	}
> =20
> @@ -42,7 +45,7 @@ static unsigned int calc_sg_nents(struct dma_iova_state=
 *state,
> =20
>  	if (!state || !dma_use_iova(state)) {
>  		for (i =3D 0; i < nr_ranges; i++) {
> -			unsigned int added =3D DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
> +			unsigned int added =3D DIV_ROUND_UP(phys_vec[i].len, MAX_SG_ENT_SZ);

[Severity: Critical]
Does this calculation severely under-calculate or return 0 for the number of
required SG entries on 32-bit architectures?

On 32-bit architectures, MAX_SG_ENT_SZ expands to 0xFFFFF000. For lengths
greater than 4096, DIV_ROUND_UP() expands to (len + 0xFFFFF000 - 1) / 0xFFF=
FF000,
which will wrap around the 32-bit addition and yield an artificially low or=
 zero
number of entries.

[Severity: High]
This is a pre-existing issue, but does the error handling path following th=
is
allocation unmap uninitialized scatterlist entries if dma_map_phys() fails?

When dma_map_phys() fails, the err_unmap_dma path in dma_buf_phys_vec_to_sg=
t()
attempts cleanup:

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

The for_each_sgtable_dma_sg macro internally shadows the outer failure inde=
x i
and initializes its own counter to 0. It then unconditionally iterates thro=
ugh
all sgt->nents allocated entries. Because the failure occurred early, trail=
ing
entries remain zero-initialized, causing dma_unmap_phys() to be invoked on
addresses of 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901170849.4052=
816-1-dhu@x6u.co?part=3D2
