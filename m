Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DB7C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 16:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB85910E1E3;
	Wed,  9 Sep 2026 16:49:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iiXSEP5G";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F0D510E1E3
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 16:49:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D8EFF41496;
 Wed,  9 Sep 2026 16:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F811F000FF;
 Wed,  9 Sep 2026 16:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788972551;
 bh=ZuDGALqa/JtpWg/yFYbwcac9fK3ThOHmY3rtX5BgMJg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iiXSEP5GoUjFgJQeMbI2+mGy3h9w/pwvhZmhUJpZy1XPWoS77p3403Vk5dEQzOTFO
 Ci0P3ZxOpi6ao4TYUQukKnJqqfef7P7x24MlXl6o0FNnjrOttUFjhFWST+OQiRDUKb
 rcegkTKcJdbxZcJeNeRAqiuYiYerA0evXtfQOmCn7DSN/qjz4h69s42HfP1CH+5chW
 sVa1eiXPp/PUwh9YrjwsUSX291jbJ4SspLtEH1Yq4aYouUEVSF7DbSL9HYa3cEgCwu
 autvTMroKY41NgtsXi0ycT3kF7EPNdR2KYVRl0OzMFAJeEctv2QMPBfoKa82C3dS9A
 h/MPXKp4Gg55g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 1/1] accel/amdxdna: Fix unsafe use of handle_mm_fault()
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260909163211.950709-1-lizhi.hou@amd.com>
References: <20260909163211.950709-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 16:49:11 +0000
Message-Id: <20260909164911.91F811F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using remap_pfn_range() to map normal refcounted shmem folios crea=
tes special PTEs, violating MM invariants.
--

commit 2da717e72d7319305e74d66b3b963f132ff12737
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Fix unsafe use of handle_mm_fault()

This commit removes the unsafe use of handle_mm_fault() from the mmap
callback since the VMA is not yet linked. For shmem BOs, it replaces the
faulting loop with direct calls to remap_pfn_range(), and for imported BOs
it marks the mapping as invalid to be faulted in later.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index 3f05fa8811af1..7a5b0ad3235fd 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c

[ ... ]

> @@ -490,16 +491,10 @@ static int amdxdna_insert_pages(struct amdxdna_gem_=
obj *abo,

[ ... ]

> +	ret =3D drm_gem_shmem_mmap(&abo->base, vma);
> +	if (ret) {
> +		XDNA_ERR(xdna, "Failed shmem mmap %d", ret);
> +		return ret;
>  	}
> =20
> -	do {
> -		vm_fault_t fault_ret;
> +	for (i =3D 0; i < num_pages; i++) {
> =20
> -		fault_ret =3D handle_mm_fault(vma, vma->vm_start + offset,
> -					    FAULT_FLAG_WRITE, NULL);
> -		if (fault_ret & VM_FAULT_ERROR) {
> -			XDNA_ERR(xdna, "Fault in page failed");
> -			amdxdna_mark_mapp_invalid(abo, vma);
> -			break;
> +		ret =3D remap_pfn_range(vma, vma->vm_start + (i << PAGE_SHIFT),
> +				      page_to_pfn(abo->base.pages[vma->vm_pgoff + i]),
> +				      PAGE_SIZE, vma->vm_page_prot);

[Severity: High]
Does using remap_pfn_range() here to map normal refcounted shmem folios
create special PTEs?

Since remap_pfn_range() is designed for raw PFN mappings, it sets the
special bit on the resulting page table entries. If this is applied to
normal refcounted folios from the shmem BO, it violates the memory
management invariant that normal folios must not have special PTEs.

When the special bit is set, vm_normal_page() returns NULL, which hides
these pages from page table walkers, GUP (get_user_pages), and
mapcount-based refcount management. Can this break reverse mapping (rmap)
and lead to memory management corruption?

> +		if (ret) {
> +			if (i > 0)
> +				zap_special_vma_range(vma, vma->vm_start, i << PAGE_SHIFT);
> +			dma_resv_lock(to_gobj(abo)->resv, NULL);
> +			drm_gem_shmem_put_pages_locked(&abo->base);
> +			dma_resv_unlock(to_gobj(abo)->resv);
> +			return ret;
>  		}
> -
> -		offset +=3D PAGE_SIZE;
> -	} while (--num_pages);
> +	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909163211.9507=
09-1-lizhi.hou@amd.com?part=3D1
