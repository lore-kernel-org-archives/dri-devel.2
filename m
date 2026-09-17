Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2813C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE29310E740;
	Thu, 17 Sep 2026 16:54:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eyLCjGmd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F3610E740
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 16:54:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4464943F26;
 Thu, 17 Sep 2026 16:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3671F00893;
 Thu, 17 Sep 2026 16:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789664048;
 bh=soTBV+PjMnLk3CJqDep3SeaGxjjzvxEjiNUk8qBpmsU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eyLCjGmdrDwctVmdHC7BJ3p9PF7o5gpRumDdAuDAaNy8Ld2HpjE2vuKO9qOrrRHPW
 BIVGQKAcpQ8Tj0OpdswMByR6ajR3Dr82AtiefkpkLRgfILf0If9zPj9JfsJLEwzHko
 lZ+oKPguQan3LQuuXUKVNSNNMX5mooVKrg6a07th26o4uULzeIlVKJQilArdmXeR1I
 hEXdXdBvG98j1Uhq6/S7vugxw7MRbvx2aNsyq2olk+tmmGC5oeXOUXad9+03EQgA/r
 PRR7KJN5XzZUPvjgUyDNjVHsKlxnZtkUnez9B+V0y/tkfkcJzV+ScJO0Z4Cj1IA/FQ
 1fth1ZkQIXKUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/40] mm/vma: fix mmap_prepare file handling, remove
 file_doesnt_need_get
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvm@vger.kernel.org, selinux@vger.kernel.org, linux-scsi@vger.kernel.org,
 "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>,
 "Marc Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, linux-rdma@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-1-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-1-4583d8a23bca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:54:06 +0000
Message-Id: <20260917165406.DF3671F00893@smtp.kernel.org>
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
- [High] mm: NULL pointer dereference in compat_vma_mmap() error and succes=
s paths
--

commit ed2cb69a22a3cc12d20a6c5599880de22d11566c
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

mm/vma: fix mmap_prepare file handling, remove file_doesnt_need_get
   =20
The map->file_doesnt_need_get flag is confusing and the existing
implementation has holes.

[ ... ]

> diff --git a/mm/util.c b/mm/util.c
> index bf0513d1d3d08..016932780925e 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1228,8 +1228,11 @@ int __compat_vma_mmap(struct vm_area_desc *desc,
> =20
>  	/* Perform any preparatory tasks for mmap action. */
>  	err =3D mmap_action_prepare(desc);
> -	if (err)
> +	if (err) {
> +		if (desc->vm_file !=3D vma->vm_file)
> +			fput(desc->vm_file);

[Severity: High]
Is it possible for desc->vm_file to be NULL here? If a stacked driver's
mmap_prepare() hook changes the mapping to anonymous (clearing desc->vm_file
to NULL) and mmap_action_prepare() fails, this error path would call
fput(desc->vm_file) passing NULL. Because fput() does not tolerate NULL
pointers, would this lead to a NULL pointer dereference?

>  		return err;
> +	}
>  	/* Update the VMA from the descriptor. */
>  	compat_set_vma_from_desc(vma, desc);
>  	/* Complete any specified mmap actions. */

[ ... ]

> diff --git a/mm/vma.h b/mm/vma.h
> index e97bd2dfa786d..f15faa83f3d63 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -394,8 +394,10 @@ static inline void compat_set_vma_from_desc(struct v=
m_area_struct *vma,
> =20
>  	/* Mutable fields. Populated with initial state. */
>  	vma_set_pgoff(vma, desc->pgoff);
> -	if (desc->vm_file !=3D vma->vm_file)
> -		vma_set_file(vma, desc->vm_file);
> +	if (desc->vm_file !=3D vma->vm_file) {
> +		fput(vma->vm_file);

[Severity: High]
Similarly, could vma->vm_file be NULL here? If __compat_vma_mmap() is invok=
ed
on an initially anonymous VMA (where vma->vm_file is NULL) and the driver
provides a backing file, this success path calls fput(vma->vm_file) passing
NULL.

> +		vma->vm_file =3D desc->vm_file;
> +	}
>  	vma->flags =3D desc->vma_flags;
>  	vma->vm_page_prot =3D desc->page_prot;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-b4-mmap-pr=
epare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org?part=3D1
