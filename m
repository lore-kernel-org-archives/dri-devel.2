Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631F1CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C419710E0D5;
	Mon, 22 Jun 2026 22:16:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JSb36wXC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A212D10E0D5
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 22:16:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4EBC44357B;
 Mon, 22 Jun 2026 22:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCE11F00ACF;
 Mon, 22 Jun 2026 22:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782166575;
 bh=KUVvfBhi6n4A2hv61iTDhcxgjTWhKtt7IPKXHmeRFLU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JSb36wXCm0rJvxKQPl+c18cMD4g0kBEUhjBVN6O/ROl3s4W71UaPMGply7FDzBXyh
 xWX39tu+ee+VKVZP6fuBB+nUYtiBn6SBhJaJEWeR8SBDDIA4XZ0a+2HQR/gDAJ+Oh5
 Ji8cU9RdfD7hcQNjnIZqhLZ0Zu4vFVUnEe9Sa4Cs0eYLBDOPWPlvfdjGnbAH4z4xqH
 RjEinuVeLCRutGTcgLvdsHbACzvetE8+V3MrWWPqnJhFSj6FuTeDoFFdoFhyQGvVfa
 OQAU6KGjG6efJHMUJbxfd1BmBH0PpdhOvgMCce9fTcz+ZeU6sEL0QjGmnvD1uSkq26
 Ga2EHCWloN54Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/shmem_helper: Check VMA boundaries for PMD mappings
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622215718.1532689-1-lk@c--e.de>
References: <20260622215718.1532689-1-lk@c--e.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 22:16:14 +0000
Message-Id: <20260622221615.0DCE11F00ACF@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Missing VMA boundary check in panthor PMD mapping insertion ca=
uses kernel panic or memory overlap.
- [High] Incorrect GEM object page offset calculation causes mapping corrup=
tion on VMA split or partial unmap.
- [High] Normal refcounted shmem folios are mapped using raw PFN helpers, i=
mproperly marking them as special.
--

commit 07cb1bde7a0031ea636a380e71bef2ca1d93de8c
Author: Christian A. Ehrhardt <lk@c--e.de>

drm/shmem_helper: Check VMA boundaries for PMD mappings

This commit adds a boundary check in the try_insert_pfn() function to ensure
that a PMD huge page mapping is not installed if it exceeds the boundaries
of the VMA.

> In the ->huge_fault handler do not install a PMD huge page
> mapping if the huge page exceeds the boundaries of the VMA.
>=20
> All other ->huge_fault handlers have similar checks and the
> resulting mapping will trigger a VM_BUG_ON_VMA() if it ever
> reaches copy_pmd_range().

[Severity: Critical]
This is a pre-existing issue, but does panthor_gem.c also need this fix?

Looking at insert_page() in drivers/gpu/drm/panthor/panthor_gem.c at line 8=
02,
it inserts a PMD mapping if the address is aligned, but it lacks the
vma->vm_start <=3D start && end <=3D vma->vm_end bounds check:

	} else if (order =3D=3D PMD_ORDER) {
		unsigned long pfn =3D page_to_pfn(page);
		unsigned long paddr =3D pfn << PAGE_SHIFT;
		bool aligned =3D (vmf->address & ~PMD_MASK) =3D=3D (paddr & ~PMD_MASK);

		if (aligned &&
		    folio_test_pmd_mappable(page_folio(page))) {
			pfn &=3D PMD_MASK >> PAGE_SHIFT;
			return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
		}

If userspace mmaps the panthor GEM object, shrinks the VMA to a
non-PMD-aligned size using munmap(), and triggers a page fault at a
PMD-aligned address near the end before calling fork(), couldn't this cause=
 a
VM_BUG_ON_VMA() in copy_pmd_range() or allow memory overlap?

> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm=
_gem_shmem_helper.c
> index c989459eb2159..00807039f8d7d 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -597,9 +597,13 @@ static vm_fault_t try_insert_pfn(struct vm_fault *vm=
f, unsigned int order,
>  #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
>  	} else if (order =3D=3D PMD_ORDER) {
>  		unsigned long paddr =3D pfn << PAGE_SHIFT;
> +		struct vm_area_struct *vma =3D vmf->vma;
> +		unsigned long start =3D ALIGN_DOWN(vmf->address, PMD_SIZE);
> +		unsigned long end =3D start + PMD_SIZE;
> +		bool in_range =3D vma->vm_start <=3D start && end <=3D vma->vm_end;
>  		bool aligned =3D (vmf->address & ~PMD_MASK) =3D=3D (paddr & ~PMD_MASK);
> =20
> -		if (aligned &&
> +		if (aligned && in_range &&
>  		    folio_test_pmd_mappable(page_folio(pfn_to_page(pfn)))) {
>  			vm_fault_t ret;
> =20
> @@ -608,8 +612,10 @@ static vm_fault_t try_insert_pfn(struct vm_fault *vm=
f, unsigned int order,
>  			 * .huge_fault(). Make sure we pass the "write" info
>  			 * along in that case.
>  			 * This also means we have to record the write fault
>  			 * here, instead of in .pfn_mkwrite().
>  			 */

[Severity: High]
This isn't a bug introduced by this patch, but are we improperly marking
normal refcounted shmem folios as special?

The try_insert_pfn() function uses raw PFN insertion helpers like
vmf_insert_pfn_pmd() and vmf_insert_pfn() to map these folios. According to
MM guidelines, this marks the folios with VM_PFNMAP and pte_special(), which
hides them from vm_normal_page() and breaks GUP (get_user_pages) and refcou=
nt
tracking.

Should this code use vmf_insert_folio() or vmf_insert_page() instead?

> -			ret =3D vmf_insert_pfn_pmd(vmf, pfn,
> -						 vmf->flags & FAULT_FLAG_WRITE);
> +			ret =3D vmf_insert_pfn_pmd(vmf, pfn,
> +						 vmf->flags & FAULT_FLAG_WRITE);
> +			if (ret =3D=3D VM_FAULT_NOPAGE && (vmf->flags & FAULT_FLAG_WRITE))
> +				drm_gem_shmem_record_mkwrite(vmf);

[Severity: High]
This is a pre-existing issue, but does drm_gem_shmem_record_mkwrite() calcu=
late
the page offset incorrectly when a VMA is split?

In drm_gem_shmem_record_mkwrite() at line 576 (and also in
drm_gem_shmem_any_fault() at line 640), the page offset is calculated relat=
ive
to the current VMA rather than the GEM object:

	pgoff_t page_offset =3D vmf->pgoff - vma->vm_pgoff;
	...
	folio_mark_dirty(page_folio(shmem->pages[page_offset]));

If userspace partially unmaps the beginning of the VMA via
munmap(vma->vm_start, PAGE_SIZE), the VMA split increments vma->vm_pgoff.
Because vmf->pgoff - vma->vm_pgoff evaluates exactly to
(vmf->address - vma->vm_start) >> PAGE_SHIFT, this completely ignores the
split offset and accesses pages[0] for the new VMA instead of the correct
shifted page.

Could this cause mapping corruption by marking the wrong page dirty or
exposing the wrong memory pages?

> =20
>  			return ret;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622215718.1532=
689-1-lk@c--e.de?part=3D1
