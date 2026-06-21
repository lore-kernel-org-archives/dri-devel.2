Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C580CDB466
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 22:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B21A810E3F6;
	Sun, 21 Jun 2026 22:34:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NfK7cFH4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7423D10E3F6
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 22:34:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 79DAE6001A;
 Sun, 21 Jun 2026 22:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3DA1F000E9;
 Sun, 21 Jun 2026 22:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782081290;
 bh=9R+lRVo5VoogTXQwXeooHwTAiaH31i4QlT+U4+FG2ts=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NfK7cFH4IoqgtfIsrqShOmcKEwKRvpRaEd+n+sqRLsxljDiIzq+KMx0sZuPq/O/k0
 Ukc1LzIAHRkqqS//ADY0UK4tSlIA963SADnMox7awRWsCzPvs0QdnxYXKJtHm3fn+p
 MsVGnZfzj6GEOdLJxX0pObCPM4bXj8+w+H4BvG25mpR0xslFCS3061Tz86/vHvJNYR
 1YodF+ew+T2wpS1y3PZV42dTU0gWxBFwK0ewuGOSW6nkFLSXkvhquqy+xH6vkirdP3
 ONeWkH5R3Auehi9LYaF+6jHVQYkbVoNrVRroTu4CS0MUPvtEco72L0GGFQK8939WsF
 hMDjamKVpGxwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma-buf: Split sgl by largest page-aligned chunk
To: "David Hu" <xuehaohu@google.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260621222130.1667453-1-xuehaohu@google.com>
References: <20260621222130.1667453-1-xuehaohu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 22:34:49 +0000
Message-Id: <20260621223450.0C3DA1F000E9@smtp.kernel.org>
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
- [Critical] Calling `sg_set_page` with a `NULL` page parameter triggers a =
kernel panic when `CONFIG_DEBUG_VM` and SPARSEMEM without VMEMMAP are enabl=
ed.
- [High] Calculating the number of scatterlist entries (`nents`) using `DIV=
_ROUND_UP()` overflows on 32-bit architectures, resulting in `nents =3D 0` =
and uninitialized or empty scatterlists for large buffer lengths.
- [High] dma_unmap_phys() is invoked iteratively on chunked scatterlist add=
resses and lengths rather than the exact address and size initially mapped =
by dma_map_phys().
- [High] The error path in `dma_buf_phys_vec_to_sgt` unmaps all allocated s=
catterlist entries, including unpopulated ones, leading to invalid DMA unma=
p requests.
--

commit f6cce91b1ad2e1c68270e81a3cd60cffb903c456
Author: David Hu <xuehaohu@google.com>

dma-buf: Split sgl by largest page-aligned chunk

Currently, fill_sg_entry() splits the scatterlist using UINT_MAX, resulting
in non-page-aligned DMA addresses for subsequent entries. This patch changes
the split size to the largest page-aligned chunk within UINT_MAX to satisfy
hardware DMA alignment constraints.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260609165431.778061F00893@smtp.kernel=
.org/
Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping r=
outine")
Cc: stable@vger.kernel.org
Signed-off-by: David Hu <xuehaohu@google.com>

> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-=
mapping.c
> index 794acff2546a3..f2bde38fdb1f7 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -12,9 +15,9 @@ static struct scatterlist *fill_sg_entry(struct scatter=
list *sgl, size_t length,
>  	unsigned int len, nents;
>  	int i;
> =20
> -	nents =3D DIV_ROUND_UP(length, UINT_MAX);
> +	nents =3D DIV_ROUND_UP(length, MAX_ENT_SZ);

[Severity: High]
This isn't a bug introduced by this patch, but does this DIV_ROUND_UP
calculation overflow on 32-bit architectures?

On 32-bit platforms, size_t is 32 bits and MAX_ENT_SZ evaluates to 0xFFFFF0=
00
assuming 4KB pages. The DIV_ROUND_UP macro expands to:

(length + MAX_ENT_SZ - 1) / MAX_ENT_SZ

If the length is greater than PAGE_SIZE, the numerator wraps around in 32-b=
it
arithmetic, resulting in a small value that evaluates to 0. This skips the
scatterlist setup loop entirely for large buffer lengths.

>  	for (i =3D 0; i < nents; i++) {
> -		len =3D min_t(size_t, length, UINT_MAX);
> +		len =3D min_t(size_t, length, MAX_ENT_SZ);
>  		length -=3D len;
>  		/*
>  		 * DMABUF abuses scatterlist to create a scatterlist
> @@ -24,7 +27,7 @@ static struct scatterlist *fill_sg_entry(struct scatter=
list *sgl, size_t length,
>  		 * does not require the CPU list for mapping or unmapping.
>  		 */
>  		sg_set_page(sgl, NULL, 0, 0);

[Severity: Critical]
This is a pre-existing issue, but does passing NULL to sg_set_page here
cause a kernel panic under certain configurations?

When CONFIG_DEBUG_VM and classic SPARSEMEM without VMEMMAP are enabled,
sg_set_page calls page_range_contiguous, which unconditionally calls
page_to_pfn.

On these setups, page_to_pfn determines the memory section by dereferencing
the page flags. Dereferencing a NULL page pointer here causes an immediate
kernel oops.

[ ... ]

> @@ -41,14 +44,14 @@ static unsigned int calc_sg_nents(struct dma_iova_sta=
te *state,
> =20
>  	if (!state || !dma_use_iova(state)) {
>  		for (i =3D 0; i < nr_ranges; i++)
> -			nents +=3D DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
> +			nents +=3D DIV_ROUND_UP(phys_vec[i].len, MAX_ENT_SZ);

[Severity: High]
This is a pre-existing issue, but does this calculation also suffer from the
same 32-bit overflow mentioned above, resolving to 0 for large lengths?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but looking at how the
scatterlists populated by fill_sg_entry are mapped and unmapped, are we
violating the DMA API contract in dma_buf_free_sgt?

In dma_buf_phys_vec_to_sgt, a monolithic physical range is mapped using a
single dma_map_phys call, and then fill_sg_entry splits it into chunks.

However, in dma_buf_free_sgt, dma_unmap_phys is iteratively called on each
individual scatterlist chunk:

for_each_sgtable_dma_sg(sgt, sgl, i)
    dma_unmap_phys(attach->dev, sg_dma_address(sgl),
                   sg_dma_len(sgl), dir, DMA_ATTR_MMIO);

The DMA API requires that an allocation must be unmapped using the exact
same address and size parameters passed during creation. Chunked unmapping
violates this requirement.

[Severity: High]
This is also a pre-existing issue, but does the error path in
dma_buf_phys_vec_to_sgt incorrectly handle unmapping?

If dma_map_phys fails, the code jumps to the err_unmap_dma label. The error
loop uses:

for_each_sgtable_dma_sg(&dma->sgt, sgl, i)
    dma_unmap_phys(attach->dev, sg_dma_address(sgl), ...);

Because the loop macro uses i as its internal iterator up to
dma->sgt.nents, which was initialized to the total allocated entries,
it overwrites the failure index.

This causes it to iterate over all allocated entries, including unpopulated
ones, passing 0 for the address and length to dma_unmap_phys, which leads
to invalid DMA unmap requests.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621222130.1667=
453-1-xuehaohu@google.com?part=3D1
