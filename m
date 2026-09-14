Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854F5C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE25010E15B;
	Mon, 14 Sep 2026 19:14:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fdyOzcNX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6621A10E15B
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 19:14:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A86F602A8;
 Mon, 14 Sep 2026 19:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601501F000FF;
 Mon, 14 Sep 2026 19:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789413248;
 bh=qqxU0Tn+w3Hq00cDDV6qBR7mESGDkdB5AXWrXBPmMYo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fdyOzcNXteGBR+HJ16HFzmf2Ocq5Jt8sfM5EH6vMJ7T+zPMdR4Dl2pc2jPpc8L+Kh
 P/KbIo7c59agqkkQ5OZMKCQbzKTfagtUUv2IpxJ29pB6ZOAzWPs4Rmh8frKdylgb5j
 j6ZcoEgypvV4fpIvRFM9yU2FJAu2Jf4hUzxgUsTBscpmLrq5X1BRYZ3biRuT67UKO6
 f1uhUuQy20b3kMZF+yxm2/yHksUQoGzX3CbwCZTR7J7onEFAr0TABQnjEF8+Jz1wL3
 0SEgHEgGUx1j6IKLOUWUlsN22yQB0oUvc0Mn7dv5aSiqh49wd75yuhb28dTQU9MkwJ
 QxO8+18KURdZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/40] mm/vma: only allow mmap to clear
 VMA_MAYWRITE_BIT if kernel-owned
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: bpf@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-scsi@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, selinux@vger.kernel.org,
 linux-s390@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Oliver Upton" <oupton@kernel.org>
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-16-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-16-7d9781ed5361@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 19:14:06 +0000
Message-Id: <20260914191407.601501F000FF@smtp.kernel.org>
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
- [Critical] VMA flags and `pgoff` modifications performed by `mmap_action_=
prepare()` are lost in `call_mmap_prepare()`, resulting in missing `VM_MIXE=
DMAP` / `VM_PFNMAP` flags on the final VMA.
--

commit 7ddd38612e8ff73188b344ec633bfe65678e0dce
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

mm/vma: only allow mmap to clear VMA_MAYWRITE_BIT if kernel-owned

For ordinary files the only way the VMA_MAYWRITE_BIT flag is cleared is if
the underlying file is itself read-only.

[ ... ]

As all drivers which clear VMA_MAYWRITE_BIT establish kernel-owned
mappings, no functional change is intended.

> diff --git a/mm/vma.c b/mm/vma.c
> index 2648fb0e19959..d71ec51255b18 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2795,6 +2795,11 @@ static int mmap_validate(unsigned long prev_start,
>  	if (WARN_ON_ONCE(!was_maywrite && is_maywrite))
>  		return -EINVAL;
> =20
> +	/* Only kernel-owned mappings may clear VMA_MAYWRITE_BIT. */
> +	if (!vma_flags_is_kernel_owned(curr_flags) &&
> +	    WARN_ON_ONCE(was_maywrite && !is_maywrite))
> +		return -EINVAL;
> +
>  	return mmap_validate_vma_flags(curr_flags);
>  }

[Severity: Critical]
This isn't a bug introduced by this patch, but while reviewing mm/vma.c,
I noticed a potential issue in call_mmap_prepare():

mm/vma.c:call_mmap_prepare() {
	/* Update fields permitted to be changed. */
	map->pgoff =3D desc->pgoff;
	if (desc->vm_file !=3D map->vm_file)
		map->vm_file =3D desc->vm_file;
	map->vma_flags =3D desc->vma_flags;
	map->page_prot =3D desc->page_prot;
	/* User-defined fields. */
	map->vm_ops =3D desc->vm_ops;
	map->vm_private_data =3D desc->private_data;

	/* It's invalid for mmap_prepare hooks to clear vm_ops. */
	if (!desc->vm_ops)
		return -EINVAL;

	err =3D call_action_prepare(map, desc);
	if (err)
		return err;
}

Are the VMA flags and pgoff modifications performed by call_action_prepare()
lost here? Since map->vma_flags and map->pgoff are initialized from desc
before calling call_action_prepare(), the updated fields in desc are never
synchronized back to map.

Could this lead to missing VM_MIXEDMAP or VM_PFNMAP flags on the final VMA?

If unprivileged userspace calls mmap() on a driver using remap_pfn_range(),
might the core memory management subsystem treat hardware/PFN mapped pages
as normal anonymous or file-backed RAM pages?=20

This could result in the kernel attempting to manage page reference counts =
on
arbitrary physical I/O memory PFNs when the VMA is later unmapped or
accessed, potentially leading to immediate crashes or silent corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-b4-mmap-pr=
epare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org?part=3D16
