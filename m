Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A890CA9EC1
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8230610EAD4;
	Fri,  9 Oct 2026 18:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BmJ8j8xw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9DDC10EAD4
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:29:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C9E3060DC6;
 Fri,  9 Oct 2026 18:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C9C1F0089A;
 Fri,  9 Oct 2026 18:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791570546;
 bh=8FHC91xOPrSk6Z4r+GYAtjhUzfxRiqLhf91xyAIp6G0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BmJ8j8xwUDwg3wj3SiBcYt7c7qESiOZRs4+MN4mqyJboSWqxRF8g97qJ2hYI3dP+K
 Q/yO+z55zdzvdLVOOqs7Pp4dpuDDSfDH0i6rJBlbzLtfiydXPwEZFpEND2r+8Wvi+8
 +z57Q5YhTiGLERCL3uIrIIiw9JXStfnozQvOQr6MvzsSPLNvIUe1M2ENFlDzG2dQiF
 JRW4Gdon820NdHCR4P5Xeb7TsIFGHYVOr0TJ9s1Bwv3oCJ4MNOwK4pZNiK/15x80It
 j9XbQyxwzpKyJ4ew9QLhJID/DS6AjGrVXBcaeFQJWeZWG3YjrKYVjeJwY9wPT/cU4V
 8Qk240dintDqw==
Message-ID: <sashiko-outbox-165947@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/38] mm: add mmap action for discontiguous kernel
 page mapping
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-usb@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>,
 linux-scsi@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, dri-devel@lists.freedesktop.org, "Heiko
 Carstens" <hca@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, selinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kvmarm@lists.linux.dev, "Marc
 Zyngier" <maz@kernel.org>, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-7-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-7-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:29:05 +0000
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
- [High] mm: missing error return after VM_WARN_ON_ONCE for VMA_PFNMAP
--

commit dfcef6542267c02a389d52c15954f3b2b60a0695
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Subject: mm: add mmap action for discontiguous kernel page mapping

This commit introduces discontig_kernel_page_ops to allow drivers to map
discontiguous arrays of page pointers into VMAs. It also updates
vm_insert_page() and vm_insert_pages() to assert that the mmap write lock
is held, converting BUG_ON checks to VM_WARN_ON_ONCE while unifying the
code paths.

> diff --git a/mm/memory.c b/mm/memory.c
> index 448342883e9da..e5c1d1c35bc70 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2599,27 +2599,34 @@ int vm_insert_pages(struct vm_area_struct *vma, u=
nsigned long addr,
> =20
>  	if (!range_in_vma(vma, addr, end))
>  		return -EFAULT;
> -	if (!(vma->vm_flags & VM_MIXEDMAP)) {
> -		VM_WARN_ON_ONCE(mmap_read_trylock(vma->vm_mm));
> -		VM_WARN_ON_ONCE(vma->vm_flags & VM_PFNMAP);
> -		vm_flags_set(vma, VM_MIXEDMAP);
> +	if (!vma_test(vma, VMA_MIXEDMAP_BIT)) {
> +		mmap_assert_write_locked(vma->vm_mm);
> +		VM_WARN_ON_ONCE(vma_test(vma, VMA_PFNMAP_BIT));

[Severity: High]
If this warning triggers, execution will fall through because there is no
error return. On production kernels where VM_WARN_ON_ONCE is a no-op, this
will silently set VMA_MIXEDMAP_BIT and insert page entries into a
PFN-mapped VMA.=20

During VMA teardown, zap_pte_range() will not decrement the reference
counts for these pages since vm_normal_page() returns NULL for VMAs with
VM_PFNMAP set.=20

Could this result in a permanent memory leak? Should this return an error
such as -EINVAL if the bit is set?

> +		vma_start_write(vma);
> +		vma_set_flags(vma, VMA_MIXEDMAP_BIT);
>  	}
>  	/* Defer page refcount checking till we're about to map that page. */
>  	return insert_pages(vma, addr, pages, num, vma->vm_page_prot);
>  }

[ ... ]

> +static void __map_kernel_pages_prepare(struct vm_area_desc *desc)
> +{
> +	if (vma_desc_test(desc, VMA_MIXEDMAP_BIT))
> +		return;
> +
> +	mmap_assert_write_locked(desc->mm);
> +	VM_WARN_ON_ONCE(vma_desc_test(desc, VMA_PFNMAP_BIT));

[Severity: High]
Similar to the check in vm_insert_pages(), this warns but does not abort
the operation if the VMA has the PFNMAP bit set. Should this function be
changed to return an int so it can propagate an error and prevent inserting
refcounted pages into a PFN-mapped VMA?

> +	vma_desc_set_flags(desc, VMA_MIXEDMAP_BIT);
> +}

[ ... ]

> @@ -2675,10 +2774,11 @@ int vm_insert_page(struct vm_area_struct *vma, un=
signed long addr,
>  {
>  	if (addr < vma->vm_start || addr >=3D vma->vm_end)
>  		return -EFAULT;
> -	if (!(vma->vm_flags & VM_MIXEDMAP)) {
> -		BUG_ON(mmap_read_trylock(vma->vm_mm));
> -		BUG_ON(vma->vm_flags & VM_PFNMAP);
> -		vm_flags_set(vma, VM_MIXEDMAP);
> +	if (!vma_test(vma, VMA_MIXEDMAP_BIT)) {
> +		mmap_assert_write_locked(vma->vm_mm);
> +		VM_WARN_ON_ONCE(vma_test(vma, VMA_PFNMAP_BIT));

[Severity: High]
This replaces a strict BUG_ON() with a warning but allows execution to
continue. Does this need an early return here as well to prevent a
potential page reference leak?

> +		vma_start_write(vma);
> +		vma_set_flags(vma, VMA_MIXEDMAP_BIT);
>  	}
>  	return insert_page(vma, addr, page, vma->vm_page_prot, false);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D7
