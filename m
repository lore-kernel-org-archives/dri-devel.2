Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840D3C44532
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 00:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E190410E5A5;
	Thu, 23 Jul 2026 00:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LnvazlhA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E4910E5A5
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 00:02:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 62994600AD;
 Thu, 23 Jul 2026 00:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E311F000E9;
 Thu, 23 Jul 2026 00:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784764934;
 bh=YQ9ZIIPtrzgZGqsnh3L7+sr8vME3s5brO91lyENhSwI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LnvazlhARqnsy7RzKc/pvtXlHyhyU643FBlxQiwHKGH9Gw9u9Ice2SlDQEbkPT2qQ
 3lWlMT9Lg/YbFxdVzlWS4i4zkNsp7ZGgjwlInifxBWEtxlXhzig4dQVzphPZyzl64K
 q5guLQBXgkpJHz5LXs+bxzoekjlQ8oXYYz5Qa8Frl2CKqfGpJex7UoifJ+K+dhe9W5
 in7MeJ+LA8gYU7LUxxu3IO2lBLvyMXkKNZu1lLv6NoXz4UN3cj0mboG0nt8oles9SC
 sSbaGC/cTbJh99LNDmpNmPh5AjDPMgiI7SmdyG5i8Jz+F4TTFgg5RtCJM7pBrX41Rv
 Ew09SgixzlsBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk
To: dhu@x6u.co
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260722233806.3922093-1-dhu@x6u.co>
References: <20260623015459.1153884-1-xuehaohu@google.com>
 <20260722233806.3922093-1-dhu@x6u.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 00:02:13 +0000
Message-Id: <20260723000213.D6E311F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but in the error han=
dling path `err_unmap_dma`, `for_each_sgtable_dma_sg` incorrectly iterates =
over all allocated entries and calls `dma_unmap_phys` on zero-initialized m=
emory.
- [High] This problem wasn't introduced by this patch, but in the error han=
dling path `err_unmap_dma`, if mapping fails on the very first iteration (`=
i =3D=3D 0`), it skips cleaning up the IOVA state, permanently leaking the =
IOVA space.
--

--- Patch [1]: [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk =
---
commit 4626127ac68c48120c89f9454d7c72b3a29300b8
Author: David Hu <xuehaohu@google.com>

dma-buf: Split sgl by largest page-aligned chunk

This commit modifies the scatterlist splitting logic to use the largest
page-aligned chunk instead of UINT_MAX. This ensures that scatterlist
DMA lengths and addresses remain page-aligned. The change prevents
hardware DMA engine failures and addresses an edge case in
ib_umem_find_best_pgsz().

Closes: https://lore.kernel.org/all/20260609165431.778061F00893@smtp.kernel=
.org/
Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping r=
outine")
Cc: stable@vger.kernel.org

> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-=
mapping.c
> index 794acff2546a3..50ded9daf5fb3 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c

[ ... ]

While looking at this file, I noticed a couple of pre-existing issues in
dma_buf_phys_vec_to_sgt().

> err_unmap_dma:
> 	if (!i || !dma->state) {
> 		; /* Do nothing */

[Severity: High]
This isn't a bug introduced by this patch, but if mapping fails on the very
first iteration (i =3D=3D 0), will this skip cleaning up the IOVA state?

If PCI_P2PDMA_MAP_THRU_HOST_BRIDGE is used, dma_iova_try_alloc() allocates
IOVA space before the mapping loop. If the very first dma_iova_link() fails,
the error path jumps here. Since !i evaluates to true, the code skips
calling dma_iova_destroy().

Does this permanently leak the device's IOVA space?

> 	} else if (dma_use_iova(dma->state)) {
> 		dma_iova_destroy(attach->dev, dma->state, mapped_len, dir,
> 				 DMA_ATTR_MMIO);
> 	} else {
> 		for_each_sgtable_dma_sg(&dma->sgt, sgl, i)
> 			dma_unmap_phys(attach->dev, sg_dma_address(sgl),
> 				       sg_dma_len(sgl), dir, DMA_ATTR_MMIO);

[Severity: High]
This isn't a bug introduced by this patch, but does this loop over
uninitialized entries?

The for_each_sgtable_dma_sg macro shadows the outer loop variable i, which
represents the number of successfully mapped entries. Instead of bounding
the loop to the mapped entries, it resets i to 0 and unconditionally
iterates up to the total allocated entries (dma->sgt.nents).

Since sg_alloc_table zero-initializes the memory via __GFP_ZERO, the unmapp=
ed
elements will have DMA addresses and lengths of 0. Can calling dma_unmap_ph=
ys
with a 0 address and 0 length cause IOMMU translation corruption or explicit
DMA faults?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722233806.3922=
093-1-dhu@x6u.co?part=3D1
