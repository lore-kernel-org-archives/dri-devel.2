Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFA0C55ABA
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 03:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 447F810E278;
	Thu,  6 Aug 2026 03:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rj17Yw0L";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4329510E278
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 03:54:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B9A0412C8;
 Thu,  6 Aug 2026 03:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2711F000E9;
 Thu,  6 Aug 2026 03:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785988463;
 bh=7Gtup731kU42PCo8O5yjHt+tDg8o9Q0e0XjKRTK1tQ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rj17Yw0Lkl0rJgDmX7tDjVxNLF2hlrC2e8B5+xmh2rAeMnnPKKlcg3v7sDxJSHMtL
 PB4hszjFIG1jtFTrsd6vmePTgLQ32sZTfDGcXh4dkX1xcFkm5K0v4eFH2boq/a6+py
 G7LffRqA0ftpTmfVFPK73amrG2qx5SmfXSV5Rt0I+ASyhATtrPZatzT6PUp7bD2Bnp
 e1L0JBD/Cfus8LFEmHMO3GTAP3beqjKBjurS24g1Udv3ceIuMxBv9p6TrFqGzuIALl
 n5Aw2xkL3dY/UfXjTc4vGxOpSWnr9AGcbVXyGot8j2+1r9CjvWOmmjtJxmq33A6fKT
 JQ4oVPZs3+AjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/ttm: clamp the prefault window to the buffer object
To: "Baul Lee" <baul.lee@xbow.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260806034356.43681-1-baul.lee@xbow.com>
References: <20260806034356.43681-1-baul.lee@xbow.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 03:54:21 +0000
Message-Id: <20260806035422.9B2711F000E9@smtp.kernel.org>
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
- [High] The error handling in the speculative prefault loop is inverted, h=
iding errors on the primary faulting page and propagating errors on prefaul=
ted pages.
- [High] Unbounded kernel memory leak via repeated dummy page allocations w=
hen the DRM device is unplugged.
--

--- Patch [1]: [PATCH] drm/ttm: clamp the prefault window to the buffer obj=
ect ---
commit 9b271449ffc1a09950a3de8a10df5f54125914a6
Author: Baul Lee <baul.lee@xbow.com>

drm/ttm: clamp the prefault window to the buffer object

ttm_bo_vm_fault_reserved() derives two page indices from the caller's
mmap(2) arguments and bounds only one of them:

[ ... ]

Fixes: ba4e7d973dd0 ("drm: Add the TTM GPU memory manager subsystem.")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>

> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo=
_vm.c
> index a80510489c456..14ebf6ee3c47e 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -212,6 +212,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *=
vmf,
>  		vma->vm_pgoff - drm_vma_node_start(&bo->base.vma_node);
>  	page_last =3D vma_pages(vma) + vma->vm_pgoff -
>  		drm_vma_node_start(&bo->base.vma_node);
> +	page_last =3D min_t(unsigned long, page_last, PFN_UP(bo->base.size));
> =20
>  	if (unlikely(page_offset >=3D PFN_UP(bo->base.size)))
>  		return VM_FAULT_SIGBUS;

[ ... ]

>  		ret =3D vmf_insert_pfn_prot(vma, address, pfn, prot);
> =20
>  		/* Never error on prefaulted PTEs */
>  		if (unlikely((ret & VM_FAULT_ERROR))) {
>  			if (i =3D=3D 0)
>  				return VM_FAULT_NOPAGE;
>  			else
>  				break;
>  		}

[Severity: High]
This is a pre-existing issue, but does this error handling logic invert the
intended behavior? The comment states "Never error on prefaulted PTEs", but
if vmf_insert_pfn_prot() returns an error for the primary faulting page
(i =3D=3D 0), it returns VM_FAULT_NOPAGE. This signals the MM core that the
fault was handled without a page, which can cause the CPU to retry the
instruction and immediately fault again, potentially leading to a local
soft lockup.

Conversely, if an error occurs on a prefaulted page (i > 0), it breaks the
loop and returns the error code, which might inappropriately force a
SIGBUS or SIGKILL on the application even though the primary fault succeede=
d.
Could this logic be backwards?

[ ... ]

> static vm_fault_t ttm_bo_vm_dummy_page(struct vm_fault *vmf, pgprot_t pro=
t)
> {
[ ... ]
> 	/* Allocate new dummy page to map all the VA range in this VMA to it*/
> 	page =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
> 	if (!page)
> 		return VM_FAULT_OOM;
>=20
> 	/* Set the page to be freed using drmm release action */
> 	if (drmm_add_action_or_reset(bo->base.dev, ttm_bo_release_dummy_page,
> 				     page))

[Severity: High]
This is a pre-existing issue, but does this code cause an unbounded kernel
memory leak when the DRM device is unplugged?

When a device is hot-unplugged, the fault handler falls back to this
function, which allocates a new dummy page and attaches it to the
drm_device lifecycle via drmm_add_action_or_reset().

If userspace holds the device file descriptor open (keeping the drm_device
alive) and repeatedly calls madvise(MADV_DONTNEED) followed by a memory
read on the mapping, each read triggers a new page fault. This could alloca=
te
a new page and a new drmm action on every fault, which are never freed
until the device is completely destroyed. Could this lead to an
Out-Of-Memory (OOM) condition?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806034356.4368=
1-1-baul.lee@xbow.com?part=3D1
