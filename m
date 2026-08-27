Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BC9C61DCD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0902E10F06F;
	Thu, 27 Aug 2026 13:43:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ERKIOr0R";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 331DB10F066;
 Thu, 27 Aug 2026 13:43:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 41C89600DB;
 Thu, 27 Aug 2026 13:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61731F000E9;
 Thu, 27 Aug 2026 13:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787838210;
 bh=o8JCC3uoUYqNPd3AeWsdAvB3bKK1uStU/lcVrNXMMIg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ERKIOr0RBnS8iw2YkccuAUDcz4bMBw7vFmEq81EPFw3/DHwU1ByVmrD5/EDEAUruU
 wnUtCXQ5KFBrc5pJtBiYtQ5yVmxNUoBqeSZENFLeL74pxrvyd1+WEgwt05ebS7pURo
 c7mdyY8T+EjsL/JTCL+hWFVjBubApVCXRjacoFglJ5RW5nWE202YwSrLQy4kCkpZgl
 5sURKvSYkk5zNQgWjwtp8tOLe76k4vTTz/eE09vbUl2Xi22gEJUyGiAs1d0sdHM0NR
 ekInMz2/FMoAITGa58VThRMq1WTWC24wNvMD9coPfCcaRxcEDi6LWsfW+TqNTf2tT4
 oOLa5EEPRcn9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/xe: Convert xe_user_fence to drm_user_fence
To: "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20260827133226.4076593-3-srinivasan.shanmugam@amd.com>
References: <20260827133226.4076593-1-srinivasan.shanmugam@amd.com>
 <20260827133226.4076593-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 13:43:29 +0000
Message-Id: <20260827134329.B61731F000E9@smtp.kernel.org>
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

New issues:
- [High] Missing memory barrier between setting ufence->signalled and copy_=
to_user() allows spurious -EBUSY errors on weakly ordered architectures.

Pre-existing issues:
- [High] Userspace can trigger a kernel warning (WARN_ON) by unmapping the =
user fence memory before it signals, creating a local Denial of Service vec=
tor.
--

commit 59eae6961ce055613e8672c56bafdaedc5de05d7
Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

drm/xe: Convert xe_user_fence to drm_user_fence

This commit replaces the open-coded user fence implementation in xe_sync.c
with the new common drm_user_fence helper. It embeds the base structure
and delegates the worker logic to standard ops.

> diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
> index 37866768d64c2..7549123f84869 100644
> --- a/drivers/gpu/drm/xe/xe_sync.c
> +++ b/drivers/gpu/drm/xe/xe_sync.c

[ ... ]

> @@ -19,36 +18,51 @@
>  struct xe_user_fence {
> -	struct xe_device *xe;
> -	struct kref refcount;
> -	struct dma_fence_cb cb;
> -	struct work_struct worker;
> -	struct mm_struct *mm;
> -	u64 __user *addr;
> -	u64 value;
> -	int signalled;
> +	struct drm_user_fence base;
> +	struct xe_device     *xe;
> +	u64 __user           *addr;
> +	u64                   value;
> +	int                   signalled;
>  };
> =20
> -static void user_fence_destroy(struct kref *kref)
> +static void xe_ufence_worker(struct drm_user_fence *base, bool mm_ok)
>  {
> -	struct xe_user_fence *ufence =3D container_of(kref, struct xe_user_fenc=
e,
> -						 refcount);
> +	struct xe_user_fence *ufence =3D container_of(base, struct xe_user_fenc=
e, base);
> =20
> -	mmdrop(ufence->mm);
> -	kfree(ufence);
> -}
> +	/*
> +	 * Mark signalled before waking waiters so UMD can safely reuse
> +	 * the same ufence without hitting -EBUSY.
> +	 */
> +	WRITE_ONCE(ufence->signalled, 1);
> =20
> +	if (mm_ok) {

[Severity: High]
Does this code need a memory barrier here?=20

The xe_ufence_worker() updates the kernel state (ufence->signalled) and then
writes to user memory sequentially without a memory barrier. If the CPU
reorders these stores (which is possible on weakly ordered architectures
like ARM64), userspace can observe the user memory change via polling,
immediately issue an unmap ioctl, and the kernel's check_ufence() may
read the stale ufence->signalled =3D=3D 0 state.

This sequence could cause userspace to receive an unexpected -EBUSY error
when unmapping the VM area, causing the UMD to fail or abort. This was
introduced because the removed kthread_use_mm() call previously acted as
an implicit full memory barrier. Should an smp_wmb() be added here?

> +		if (copy_to_user(ufence->addr, &ufence->value, sizeof(ufence->value)))
> +			XE_WARN_ON("Copy to user failed");

[Severity: High]
This is a pre-existing issue, but can userspace trigger a kernel warning
here by unmapping the user fence memory before it signals?

If a user application creates a user fence pointing to valid mapped memory,
and then calls munmap() or mprotect() on the address to revoke write access
before the GPU signals the fence, the asynchronous copy_to_user() in
xe_ufence_worker() will naturally fail. This hits the unconditional
XE_WARN_ON(), which allows unprivileged userspace to spam the kernel log
and cause a kernel panic if panic_on_warn is enabled.

Could this XE_WARN_ON() be replaced with drm_dbg(), or removed entirely?

> +	} else {
> +		drm_dbg(&ufence->xe->drm,
> +			"mmget_not_zero() failed, ufence wasn't signaled\n");
> +	}
> +
> +	wake_up_all(&ufence->xe->ufence_wq);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827133226.4076=
593-1-srinivasan.shanmugam@amd.com?part=3D2
