Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31BDC55165
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 15:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D345610EFBD;
	Thu, 30 Jul 2026 15:46:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EyLqGR+7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6138610EFBD
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 15:46:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8AA22600C8;
 Thu, 30 Jul 2026 15:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226891F000E9;
 Thu, 30 Jul 2026 15:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785426404;
 bh=K+lQrMg+stR1zzrDks+v0inRrRmvMC5jQNtOBnPL7MU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EyLqGR+7twPdGX4HTMQVpBjZ5CBGLGivqApE0wEzuuIeG+jwu0HOPsQImJOo4xB4w
 QPVVk4SYAUDqctZqziJd+N2sCY7fudL2gIezL2iHywK457BcjAaJ8F3KY2rh/JnVuM
 +IO3rAzfl90unTiQ/xL3CXXz0uQ/tqkZQoVSU+OpbkX3sPH8Oj6S6NIMe5+2/1EaIL
 S0MemG4tu/+LURLAMc6YChPYtAzigxqdezdNDKDktubpDP+UxzbXVMvmWYzKTF3uTt
 AdPEAK11+KCO9bOGSVa77087K/KDpagWo3bk3UCskeo27AEXP8lWyb4y4ryFavYfGD
 1IsY+fmeWGLbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdkfd: reject alloc_memory_of_gpu with wrapping
 va_addr/mmap_offset
To: "Hari Mishal" <harimishal1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730153555.15176-1-harimishal1@gmail.com>
References: <20260730153555.15176-1-harimishal1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 15:46:43 +0000
Message-Id: <20260730154644.226891F000E9@smtp.kernel.org>
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
- [High] The patch adds an unconditional overflow check on `args->mmap_offs=
et`, which is strictly an OUT parameter for most allocation types. This wil=
l cause perfectly valid ioctl calls to randomly fail with `-EINVAL` if user=
space leaves the output field uninitialized.
--

--- Patch [1]: [PATCH] drm/amdkfd: reject alloc_memory_of_gpu with wrapping=
 va_addr/mmap_offset ---
commit 90e63e5cacd60faaf13c89e037955751ad085487
Author: Hari Mishal <harimishal1@gmail.com>

drm/amdkfd: reject alloc_memory_of_gpu with wrapping va_addr/mmap_offset

This commit adds check_add_overflow() checks to kfd_ioctl_alloc_memory_of_g=
pu()
to prevent integer wrap-arounds when calculating the end address of va_addr
and mmap_offset.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1089,10 +1089,15 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct f=
ile *filep,
[ ... ]
>  	if (args->size =3D=3D 0)
>  		return -EINVAL;
> =20
> +	if (check_add_overflow(args->va_addr, args->size, &end) ||
> +	    check_add_overflow(args->mmap_offset, args->size, &end))
> +		return -EINVAL;
> +

[Severity: High]
Will this check cause valid allocation requests to fail if the user space
application leaves args->mmap_offset uninitialized?

According to the uAPI in kfd_ioctl.h, mmap_offset is an OUT parameter
for non-USERPTR allocations:

struct kfd_ioctl_alloc_memory_of_gpu_args {
	...
	__u64 mmap_offset;	/* to KFD (userptr), from KFD (mmap offset) */
	...
};

Since this check is unconditional, if userspace calls this ioctl without the
KFD_IOC_ALLOC_MEM_FLAGS_USERPTR flag and leaves the mmap_offset field
uninitialized on the stack, random garbage in that field could trigger this
overflow check and spuriously return -EINVAL.

Should the args->mmap_offset overflow check be restricted to only run when
(args->flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) is true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730153555.1517=
6-1-harimishal1@gmail.com?part=3D1
