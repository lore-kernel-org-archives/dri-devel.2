Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB08CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 18:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A87310F839;
	Mon,  8 Jun 2026 18:04:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U2PDHPTO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 418AC10F839
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 18:04:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7CA286001D;
 Mon,  8 Jun 2026 18:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8021F00893;
 Mon,  8 Jun 2026 18:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780941877;
 bh=fLbSq7SH27GrWuSQxpFHUksdQ0gNTqkjwr3gmS594SI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U2PDHPTOYo0Ria+0NNK4Vg38ws1vZiGlgWSBO034tUhA7rcf1JTl9IORzNALywyno
 LMYv29idKSqoIsrQQlCWHZfayFZGmr9g97npzBIC76NZruSOzPo9HvkYMVi6/zwv59
 xob/tdzqA5CRJxYaHl25OR0Z2cWAyg81voJcsJsSTOzx2W0eFs8dHmS+kWeDsEY765
 3yN8rDrT1BcYMj3uctFNTe7KPD55y6ZLy6cpRn4WMi54C437typMGUP8RO7MbHijv6
 OJYPxhl0BEwa0EIEfMmCq0yf9z6Hz+qxnH7tdOv8SNI1zr3qY3KR/w2tNc5NMpxDkP
 8QzvDAze2RaZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] accel/amdxdna: Fix VMA access race
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608175018.2756886-1-lizhi.hou@amd.com>
References: <20260608175018.2756886-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 18:04:36 +0000
Message-Id: <20260608180437.1D8021F00893@smtp.kernel.org>
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
- [High] Use-after-free on `mapp->vma` during MMU notifier invalidation.
- [High] Memory flag `AS_UNEVICTABLE` is permanently leaked on mmap error p=
aths.

Pre-existing issues:
- [High] Pre-existing use-after-free on `mapp->vma` in debug logging.
- [High] Incorrect management of `AS_UNEVICTABLE` on shared file mappings a=
nd swapped `vma->vm_file`.
--

commit 7b0235d032796ef659fe1d987ecb0649b81f544e
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Fix VMA access race

aie2_populate_range() and amdxdna_umap_release() access a saved VMA
pointer that may have already been freed, leading to a potential
use-after-free.

Remove the VMA accesses from these functions to avoid the race.

Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index 63976c3bcbe0f..80dd183ecba92 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -271,6 +271,10 @@ static bool amdxdna_hmm_invalidate(struct mmu_interv=
al_notifier *mni,
>  	if (range->event =3D=3D MMU_NOTIFY_UNMAP) {
>  		down_write(&xdna->notifier_lock);
>  		if (!mapp->unmapped) {
> +			if (is_import_bo(abo) && mapp->vma->vm_file &&
> +			    mapp->vma->vm_file->f_mapping)
> +				mapping_clear_unevictable(mapp->vma->vm_file->f_mapping);

[Severity: High]
Does this code still have a use-after-free on mapp->vma?

The mmu_interval_notifier tracks virtual address ranges, not VMA lifetimes.
If a VMA is split, merged, or partially unmapped, the original
vm_area_struct can be freed without immediately invalidating the interval
notifier. When a subsequent munmap triggers MMU_NOTIFY_UNMAP, mapp->vma
could be a dangling pointer.


[Severity: High]
Can this code permanently leak the AS_UNEVICTABLE flag on mmap error paths?

If amdxdna_insert_pages() fails during mmap, the error path calls
amdxdna_hmm_unregister(), which sets mapp->unmapped =3D true but does not
clear the flag. Consequently, the flag might never be cleared because this
invalidation handler skips the clearing when unmapped is true.


[Severity: High]
This isn't a bug introduced by this patch, but does this clear the wrong
file's mapping?

For imported dma-buf BOs, amdxdna_hmm_register() sets AS_UNEVICTABLE on
vma->vm_file->f_mapping. At this time, vma->vm_file is the XDNA device file.

Subsequently, amdxdna_insert_pages() calls dma_buf_mmap(), which swaps
vma->vm_file to the dma-buf file.

When the VMA is later unmapped, mapping_clear_unevictable() is called on the
new vma->vm_file (the dma-buf). This leaves the XDNA device file permanently
locked as unevictable, while the dma-buf file incorrectly loses its
unevictable status for all other clients.


[Severity: High]
This is a pre-existing issue, but does amdxdna_hmm_invalidate() have another
potential use-after-free on the VMA pointer earlier in the function?

Prior to this patch, amdxdna_hmm_invalidate() accesses mapp->vma->vm_start
and mapp->vma->vm_end for an XDNA_DBG log statement:

    XDNA_DBG(xdna, "Invalidating range 0x%lx, 0x%lx, type %d",
             mapp->vma->vm_start, mapp->vma->vm_end, abo->type);

Because VMAs can be freed by mprotect() or vma_merge() without triggering an
MMU notifier, mapp->vma can be a dangling pointer when an invalidation event
later occurs.

> +
>  			queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
>  			mapp->unmapped =3D true;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608175018.2756=
886-1-lizhi.hou@amd.com?part=3D1
