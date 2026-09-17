Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE96C982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F08BE10F041;
	Thu, 17 Sep 2026 17:38:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H9vrHm8v";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0631110F03F
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:38:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E372F43C5D;
 Thu, 17 Sep 2026 17:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB85A1F00899;
 Thu, 17 Sep 2026 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789666703;
 bh=5kjOJDRquVLkcsCifjUaIGVqXBrsdJTHF0heZHA5Ct0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H9vrHm8vmTYs7fk9aPZssmoCEh/8IIU7AQ11/U4ZsR7VDEKH7zWk1LSrlePcnwSdH
 0ORi2m4lCAeqT1CQf8b9a8vIj/uUU3sdXeruqUyHdVtLJR/14cobigp78p/+jlpGHF
 GWSEgda2fPE/s/1ikNv/UCw0/l/DXT65l61JeCi/vpVkqMjfHTbYVDr3RyA2sljShF
 48PpsjhFBYuSo87+Qlb8JHT8LyKKko/f6PscfpOVLSq7Jtcgm/LjBuFe9Be/tDhnar
 UokTFPhMgBdHDK/mi1ApDDbL5Ovdpw82jMEdExhNVnAoaEJPdKdWmtbYrwsZ1yVmTT
 YYLDfTVjnPtKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/40] mm: consistently validate VMA state after
 mmap[_prepare] hooks
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, selinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>,
 kvmarm@lists.linux.dev, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-perf-users@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, linux-scsi@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-rdma@vger.kernel.org
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-4-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-4-4583d8a23bca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:38:22 +0000
Message-Id: <20260917173822.CB85A1F00899@smtp.kernel.org>
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
- [High] mm: UAF window caused by premature vma_close() before unmap_region=
()
- [Medium] mm: resource leak on mmap_prepare validation failure
- [Medium] mm: file reference leak when validation fails after mmap hook fi=
le swap
--

commit e5484b6aabe21d13a57f4db7fafb6d19bb0c0c97
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Subject: mm: consistently validate VMA state after mmap[_prepare] hooks

This commit centralises and extends validation of VMA state after executing
a driver's f_op->mmap or f_op->mmap_prepare hooks. It enforces restrictions
such as immutable VMA boundaries and prevents upgrading mappings to writable
if previously read-only.

> diff --git a/mm/internal.h b/mm/internal.h
> --- a/mm/internal.h
> +++ b/mm/internal.h
[ ... ]
> @@ -225,8 +243,12 @@ static inline int mmap_file(struct file *file, struc=
t vm_area_struct *vma)
>  {
[ ... ]
> +	err =3D mmap_hook_validate(prev_start, prev_end, &prev_flags, vma);
> +	if (unlikely(err)) {
> +		vma->vm_start =3D prev_start;
> +		vma->vm_end =3D prev_end;
> +		vma_close(vma);
>  	}

[Severity: High]
Could calling vma_close() here create a use-after-free window?

If a driver's f_op->mmap hook succeeds and populates PTEs (for example, via
remap_pfn_range()), but mmap_hook_validate() subsequently fails, the
driver's .close hook will free its backing resources immediately.

However, the PTEs are not cleared until __mmap_new_file_vma() later handles
the error:

mm/vma.c:__mmap_new_file_vma() {
    ...
    error =3D mmap_file(vma->vm_file, vma);
    map->vm_file =3D vma->vm_file;

    if (error) {
        ...
        /* Undo any partial mapping done by a device driver. */
        unmap_region(&unmap);
        return error;
    }
    ...
}

Does this leave the freed memory accessible to concurrent threads or lockle=
ss
GUP_fast walks through the stale PTEs until unmap_region() is reached?


[Severity: Medium]
Does this error path also leak the new file reference if a driver swaps the
file but then fails validation?

If a driver's mmap hook successfully replaces vma->vm_file (transferring a
new reference), mmap_file() updates map->vm_file. If mmap_hook_validate()
then fails, the error path in __mmap_new_file_vma() has this logic:

mm/vma.c:__mmap_new_file_vma() {
    ...
    if (error) {
        ...
        if (map_same_file(map))
            fput(map->vm_file);
           =20
        vma->vm_file =3D NULL;
        ...
    }
}

Because map->vm_file was updated to the newly swapped file, map_same_file()
will evaluate to false. This skips fput(map->vm_file) and clears
vma->vm_file to NULL, which appears to leak the new file reference.

> diff --git a/mm/util.c b/mm/util.c
> --- a/mm/util.c
> +++ b/mm/util.c
[ ... ]
> @@ -1224,19 +1224,28 @@ EXPORT_SYMBOL(compat_set_desc_from_vma);
>  int __compat_vma_mmap(struct vm_area_desc *desc,
>  		      struct vm_area_struct *vma)
>  {
[ ... ]
> +	/* Perform any preparatory tasks for mmap action. */
>  	err =3D mmap_action_prepare(desc);
> -	if (err) {
> -		if (desc->vm_file !=3D vma->vm_file)
> -			fput(desc->vm_file);
> -		return err;
> -	}
> +	if (err)
> +		goto err_put;
> +	/* Check the caller did nothing crazy. */
> +	err =3D mmap_prepare_validate(&prev_desc, desc);
> +	if (err)
> +		goto err_put;

[Severity: Medium]
If mmap_prepare_validate() fails here, does this skip tearing down the
driver's prepared state?

The driver successfully executed its mmap_prepare hook prior to this check.
By jumping directly to err_put, the function returns an error without
invoking the descriptor's vm_ops->close hook, which might permanently leak
any resources or hardware state allocated during vfs_mmap_prepare().

> diff --git a/mm/vma.c b/mm/vma.c
> --- a/mm/vma.c
> +++ b/mm/vma.c
[ ... ]
> @@ -2862,6 +2882,11 @@ static int call_mmap_prepare(struct mmap_state *ma=
p,
>  		struct vm_area_desc *desc)
>  {
[ ... ]
> +	/* Check the caller did nothing crazy. */
> +	err =3D mmap_prepare_validate(&prev_desc, desc);
> +	if (err)
> +		return err;

[Severity: Medium]
Similar to the compatibility layer above, does returning directly on
validation failure leak the resources allocated by vfs_mmap_prepare()?

Without calling the driver's close hook, it seems the driver has no way to
clean up its established state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-b4-mmap-pr=
epare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org?part=3D4
