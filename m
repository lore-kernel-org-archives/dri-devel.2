Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933A0C55838
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 03:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 753A010E275;
	Thu,  6 Aug 2026 03:54:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Os9yP7a3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 651F710E275
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 03:54:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F041141299;
 Thu,  6 Aug 2026 03:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95B81F000E9;
 Thu,  6 Aug 2026 03:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785988440;
 bh=Qdknt2BAsWgjRb0EmhnVGQIYlwiownsoqXm4Z6IpKPQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Os9yP7a3WPZ3z/KTSAJimm/441/fEXKrqmmLHrAaOwO+fE70mgpGI8DnYFBfbuP3Q
 goTvP08D9+s2tASNpkk0K6X2jZprqTq1v9DuYD8T1q0Jd1qEyfBhiHepCp48TUUGtV
 9GIue2WomZx8hWawbTegFEKCweGK36/DklH4h+bB2L3oWo0yarwAt71X5q2W9bWeqT
 H3tkPTTfK2riOgvbI5oqLFHS9Dimdwhm8SPfyhcfklKFSV3d3cQevqoK+2yXU4IZp3
 2EE7K3QeysxKZX5erw+gqweFzELMbyI7Jgc+UP4LILinvN92saz3RFENVQSQwBJ3DM
 wcJPWfnJKGwXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/gma500: bound the fbdev fault loop to the framebuffer
To: "Baul Lee" <baul.lee@xbow.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260806034343.43629-1-baul.lee@xbow.com>
References: <20260806034343.43629-1-baul.lee@xbow.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 03:54:00 +0000
Message-Id: <20260806035400.A95B81F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Modifying `vma->vm_page_prot` within the page fault handler violat=
es mm locking rules and creates a data race.
--

--- Patch [1]: [PATCH] drm/gma500: bound the fbdev fault loop to the frameb=
uffer ---
commit e85cf59eaca6225d308fd9d0f4608078a7b0c51e
Author: Baul Lee <baul.lee@xbow.com>

drm/gma500: bound the fbdev fault loop to the framebuffer

This commit limits the number of pages mapped in the page fault handler
to the actual size of the framebuffer object. It rejects faults that start
past the end of the object and clamps requested page counts, preventing
userspace from mapping physical frames beyond the framebuffer boundary.

> diff --git a/drivers/gpu/drm/gma500/fbdev.c b/drivers/gpu/drm/gma500/fbde=
v.c
> index d1e93588234f5..393a939a0c376 100644
> --- a/drivers/gpu/drm/gma500/fbdev.c
> +++ b/drivers/gpu/drm/gma500/fbdev.c
> @@ -26,9 +26,15 @@ static vm_fault_t psb_fbdev_vm_fault(struct vm_fault *=
vmf)
>  	unsigned long address =3D vmf->address - (vmf->pgoff << PAGE_SHIFT);
>  	unsigned long pfn =3D info->fix.smem_start >> PAGE_SHIFT;
>  	vm_fault_t err =3D VM_FAULT_SIGBUS;
> +	unsigned long obj_pages =3D info->fix.smem_len >> PAGE_SHIFT;
>  	unsigned long page_num =3D vma_pages(vma);
>  	unsigned long i;
> =20
> +	if (vmf->pgoff >=3D obj_pages)
> +		return VM_FAULT_SIGBUS;
> +	if (page_num > obj_pages)
> +		page_num =3D obj_pages;
> +
>  	vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);

[Severity: High]
This is a pre-existing issue, but could this concurrent modification
corrupt page protection bits?

Modifying vma->vm_page_prot dynamically in the psb_fbdev_vm_fault handler
happens under a read lock, such as mmap_read_lock or the per-VMA read lock.

On 32-bit systems with PAE where pgprot_t is 64-bit, writing to it without
exclusive locks can cause torn writes. It also appears to race with other
concurrent faults or mprotect calls, potentially reverting security
boundaries or cache attributes since mm locking guidelines require holding
mmap_write_lock when modifying vma->vm_page_prot.

Should this assignment be moved to the mmap callback where mmap_write_lock
is held, rather than modifying it directly in the fault handler?

>  	for (i =3D 0; i < page_num; ++i) {
>  		err =3D vmf_insert_mixed(vma, address, pfn);
>  		if (unlikely(err & VM_FAULT_ERROR))

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806034343.4362=
9-1-baul.lee@xbow.com?part=3D1
