Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDEFC531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:08:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FFBB10E535;
	Thu, 23 Jul 2026 08:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XKfNeyf2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C8C010E535
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 08:08:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 19923401FB;
 Thu, 23 Jul 2026 08:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C650D1F000E9;
 Thu, 23 Jul 2026 08:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784794101;
 bh=w6aUjxEcmdvnwcKc7n+JZpn/kZ+8OFEQv8Sx4N0opK8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XKfNeyf2gt/KxQbo57oOux6n3U7lpI6mUY4vjYbMrpDk3W6SbzNEAU2KM13MGNpXA
 lX3qX1OXAQ7noPMWd5BncCzkHuWi8rMJZiug4Ryw9W1rQl7XIjaR7XNvolRi75OGVk
 spLBAi3aCwFumVeTRW4rAMLIcpHhTWZEU1fkB0pmxJfqf0+KVZuyPsB/8afUb5+5f2
 Z8ldtNP4MfCp9DNag2OjiWa3xd2sxsE2GuwlUFIHcQFColnZ3UoaUuM9SJXQuLkRf9
 6fU3Xu7P5MI5XGLI+feLi9M8QFPH2Rw8UK3BAeCTWgGnM/IiUQnrJfkU7uLIicB4mR
 l96LJ/kT7/zhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] accel/amxdna: fix page-insertion errors in
 amdxdna_insert_pages()
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723074256.2435143-1-lizhi.hou@amd.com>
References: <20260723074256.2435143-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 08:08:20 +0000
Message-Id: <20260723080820.C650D1F000E9@smtp.kernel.org>
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
- [Critical] Incompatible VMA flags modification replaces VM_PFNMAP with VM=
_MIXEDMAP, creating a locally exploitable kernel panic via BUG_ON.
- [High] Eager page table population inside the mmap callback bypasses inte=
rval tree tracking, risking Use-After-Free.
--

--- Patch [1]: [PATCH V1] accel/amxdna: fix page-insertion errors in amdxdn=
a_insert_pages() ---
commit c41b85178d2bef0390b7acad007274b457c13742
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amxdna: fix page-insertion errors in amdxdna_insert_pages()

This commit prevents a reference count underflow when error paths in
amdxdna_insert_pages() prematurely close a VMA. It replaces hard error
returns with a deferred-fault approach that keeps the VMA alive and retries
page insertion later.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index df236a9d8a0a4..493f34473266e 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
[ ... ]
> @@ -457,8 +474,7 @@ static int amdxdna_insert_pages(struct amdxdna_gem_ob=
j *abo,
>  				      &num_pages);

[Severity: Critical]
This is a pre-existing issue, but does replacing VM_PFNMAP with VM_MIXEDMAP
create a locally exploitable kernel panic?

Just above this line, vm_flags_mod() sets VM_MIXEDMAP and clears VM_PFNMAP.

If an unprivileged userspace process mmaps a non-imported GEM object and th=
en
calls madvise(MADV_DONTNEED), the PTEs will be successfully cleared because
VM_MIXEDMAP allows this (unlike VM_PFNMAP).

When userspace subsequently accesses the memory, drm_gem_shmem_fault() hand=
les
the page fault and attempts to map the backing shmem page via vmf_insert_pf=
n()
which calls vmf_insert_pfn_prot().

Because the backing shmem page is normal system memory (pfn_valid(pfn) is
true) and the VMA now has VM_MIXEDMAP set, won't this predictably trigger t=
he
explicit assertion BUG_ON((vma->vm_flags & VM_MIXEDMAP) && pfn_valid(pfn)),
crashing the system?

[Severity: High]
This is also a pre-existing issue, but does eagerly populating PTEs inside
the mmap callback bypass interval tree tracking?

At the time the .mmap callback executes, the new VMA is not yet linked into
the backing file's interval tree (mapping->i_mmap). The core mm links it
via vma_link_file() only after the .mmap callback returns successfully.

If a dma-buf exporter concurrently evicts the memory and calls
unmap_mapping_range(), won't the invalidation miss this unlinked VMA and
fail to shoot down the eagerly populated PTEs, leading to a use-after-free?

>  		if (ret) {
>  			XDNA_ERR(xdna, "Failed insert pages %d", ret);
> -			vma->vm_ops->close(vma);
> -			return ret;
> +			amdxdna_mark_mapp_invalid(abo, vma);
>  		}
> =20
>  		return 0;
> @@ -478,9 +494,9 @@ static int amdxdna_insert_pages(struct amdxdna_gem_ob=
j *abo,
>  		fault_ret =3D handle_mm_fault(vma, vma->vm_start + offset,
>  					    FAULT_FLAG_WRITE, NULL);

[Severity: High]
This isn't a bug introduced by this patch, but does this eager population f=
or
dma-buf imports have the same interval tree tracking bypass issue?

Since the VMA is not yet linked into the interval tree during the .mmap
callback, an invalidation from the exporter might miss these eagerly
populated PTEs, resulting in a use-after-free.

>  		if (fault_ret & VM_FAULT_ERROR) {
> -			vma->vm_ops->close(vma);
>  			XDNA_ERR(xdna, "Fault in page failed");
> -			return -EFAULT;
> +			amdxdna_mark_mapp_invalid(abo, vma);
> +			break;
>  		}
> =20
>  		offset +=3D PAGE_SIZE;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723074256.2435=
143-1-lizhi.hou@amd.com?part=3D1
