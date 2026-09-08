Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1FAC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:42:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECEED10ED85;
	Tue,  8 Sep 2026 20:42:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="niXtcxlv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE07010ED83
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:42:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 875EA40B5E;
 Tue,  8 Sep 2026 20:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4BC1F00A3D;
 Tue,  8 Sep 2026 20:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788900133;
 bh=hZJHLSYuWsPGHgMsZ6wDtKv+Nmu7iCoJKynKPiE+7QY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=niXtcxlvQiNTpo+iCoXferY/ogFz6WgWQTcJwN0FBdhNy5NdE8YpL2eiELkmgv5Xp
 Y8B1/4ajJgLvZ4q6UeTnWqPc5l8dCGWOcAlo+R5PQQr9uL6uxe4wRnmBa6GhEFvQXf
 nPd6S6Jm/Xt/OyG90lsCWrwwr3c1lamReaSg7AT+hqN8C4XUMoaDoblckBcChQj9do
 ht3Acrl0DKeg00F7ecI8wS3sSvnUDKcUrFklZBA0zTt2hcEdf/tRUAKQ/1mznL9Pay
 Lx7X7zqPRnZ8hdMAIy2oVJEaT9/wOmMI0l9KxO62fOSbkbhkLkNxjvKaNUfAOUEPP5
 yTFCsYXfO7bUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/39] mm/vma: only allow mmap to clear VMA_MAYWRITE_BIT
 if kernel-owned
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvm@vger.kernel.org, selinux@vger.kernel.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 kvmarm@lists.linux.dev, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-perf-users@vger.kernel.org,
 "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, "Marc
 Zyngier" <maz@kernel.org>, bpf@vger.kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-15-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-15-dacf19cce22b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:42:12 +0000
Message-Id: <20260908204212.9A4BC1F00A3D@smtp.kernel.org>
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
- [High] Leaked struct file reference when a driver replaces desc->vm_file =
but mmap_prepare_validate() subsequently fails.
--

commit bf1e56ed42b1d9fbc6eb9edeebea26ac54edd5c4
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

mm/vma: only allow mmap to clear VMA_MAYWRITE_BIT if kernel-owned

This commit restricts the ability to clear the VMA_MAYWRITE_BIT to
kernel-owned mappings. It ensures that drivers which do not own the
mapping's contents cannot violate file system semantics by altering file
attributes. Any mmap hook attempting to do so without establishing a
kernel-owned mapping will now fail validation.

> diff --git a/mm/vma.c b/mm/vma.c
> index 9e45fc83f74c6..5264287532182 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2780,6 +2780,11 @@ static int mmap_validate(unsigned long prev_start,
>  	if (WARN_ON_ONCE(!was_maywrite && is_maywrite))
>  		return -EINVAL;
> =20
> +	/* Only kernel-owned mappings may clear VMA_MAYWRITE_BIT. */
> +	if (!vma_flags_is_kernel_owned(curr_flags) &&
> +	    WARN_ON_ONCE(was_maywrite && !is_maywrite))
> +		return -EINVAL;
> +

[Severity: High]
This isn't a bug introduced by this patch, but this new validation failure
exposes a pre-existing resource leak. Does this code leak the struct file
reference if the driver legitimately replaced desc->vm_file during the
mmap_prepare hook?

If a driver's f_op->mmap_prepare hook swaps desc->vm_file (acquiring a new
file reference via split ownership) and then fails this new validation
step (e.g., clearing VMA_MAYWRITE_BIT without being kernel-owned),
call_mmap_prepare() will return early:

mm/vma.c:call_mmap_prepare() {
        ...
        err =3D mmap_prepare_validate(&prev_desc, desc);
        if (err)
                return err;
               =20
        map->pgoff =3D desc->pgoff;
        if (desc->vm_file !=3D map->file) {
                map->file_doesnt_need_get =3D true;
                map->file =3D desc->vm_file;
        }
        ...
}

Because the early return happens before map->file and
map->file_doesnt_need_get are updated, the core cleanup path in
__mmap_region() remains unaware of the new file and fails to fput() it,
leaking the file reference and pinning the mount.

>  	return mmap_validate_vma_flags(curr_flags);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-b4-mmap-pr=
epare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org?part=3D15
