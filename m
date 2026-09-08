Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4DDC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3311210EA0F;
	Tue,  8 Sep 2026 09:00:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NJQ1BAWj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77FB810EA0F;
 Tue,  8 Sep 2026 09:00:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 501FB40B15;
 Tue,  8 Sep 2026 09:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6441F00A3A;
 Tue,  8 Sep 2026 09:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788858051;
 bh=a8Ltia0GByPxgdoSJvLhktlFCPb5qC9/gzdL1/p1hgA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NJQ1BAWjrfP4ZIg1TWuQMpTWGWwiaYfwRFWKbt3DeIZc8ucbt7LKriV3qieaxLnTf
 Yp6jE9JLx+3F8qsXYzjKrDx2JoCfMsGFhlZ/gZu7GsTMkXuqYE02T2vvvc485BP6gZ
 mRm3qOVnNmsiHQ4ThSyJaAhP5Lgr4jw4Rs+UXb3f+WQUIr9YBpzdPvsZT/QvfY29iO
 P7PPDotAzvoiA6K1zPe5zfd7cQ7rJuAT0wh2o+CF0X4jdHQt6qNA14STgG1cD7Pc0T
 ych2DVgfum0nTaDb34NNmSOzkLqKsWDRonyrC9d9mDmRsZcN8D/iwArOo3VFtFcQd7
 m6QaSRaqMHL3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/3] drm/xe: Convert xe_user_fence to drm_user_fence
To: "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260908084627.352535-4-srinivasan.shanmugam@amd.com>
References: <20260908084627.352535-1-srinivasan.shanmugam@amd.com>
 <20260908084627.352535-4-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 09:00:50 +0000
Message-Id: <20260908090050.BC6441F00A3A@smtp.kernel.org>
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
- [High] Missing memory barrier allows visibility inversion between the use=
r fence value and the signalled flag.

Pre-existing issues:
- [High] Denial of Service (DoS) due to indefinitely blocking `copy_to_user=
` stalling the device-wide ordered workqueue.
--

commit a3a566db4faca9c6c8375b3c0711ddb1c2742bca
Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: drm/xe: Convert xe_user_fence to drm_user_fence

This commit replaces the open-coded user fence implementation in the xe dri=
ver
with the new common drm_user_fence helper. It wraps the new helper in
xe_user_fence and moves the worker and callback logic to the provided
writeback and destroy ops.

> diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
> index 37866768d64c2..c0e720cf579ac 100644
> --- a/drivers/gpu/drm/xe/xe_sync.c
> +++ b/drivers/gpu/drm/xe/xe_sync.c
[ ... ]
> +static void xe_ufence_worker(struct drm_user_fence *base, bool mm_ok)
>  {
> +	struct xe_user_fence *ufence =3D container_of(base, struct xe_user_fenc=
e, base);
> =20
> -	mmdrop(ufence->mm);
> -	kfree(ufence);
> -}
> +	/*
> +	 * Mark signalled before the userspace write so that if userspace
> +	 * observes the written value and immediately issues a VM unmap,
> +	 * check_ufence() will see signalled=3D1 and not return -EBUSY.
> +	 *
> +	 * NOTE: copy_to_user() may block if userspace backs the address with
> +	 * userfaultfd or FUSE. Drivers requiring non-blocking semantics should
> +	 * use a dedicated workqueue instead of xe->ordered_wq.
> +	 */
> +	WRITE_ONCE(ufence->signalled, 1);
> =20
> -static void user_fence_get(struct xe_user_fence *ufence)
> -{
> -	kref_get(&ufence->refcount);
> +	if (mm_ok) {
> +		if (copy_to_user(ufence->addr, &ufence->value,
> +				 sizeof(ufence->value)))

[Severity: High]
Does this missing memory barrier allow visibility inversion?

In xe_ufence_worker(), WRITE_ONCE(ufence->signalled, 1) is called before
copy_to_user(). If a weakly ordered CPU (like ARM64) reorders these stores,
could userspace observe the new value in memory and issue a VM unmap ioctl
before the signalled flag is globally visible?

The previous implementation relied on the implicit full memory barrier of
mmget_not_zero() between these two operations, but this refactoring moved
that check before the worker executes. Should there be an smp_wmb() between
the WRITE_ONCE() and copy_to_user() calls to prevent spurious -EBUSY
failures in the VM unmap path?

> +			drm_dbg(&ufence->xe->drm,
> +				"copy_to_user failed, user fence wasn't signaled\n");
> +	} else {
> +		drm_dbg(&ufence->xe->drm,
> +			"mmget_not_zero() failed, ufence wasn't signaled\n");
> +	}
[ ... ]
> -	ufence->xe =3D xe;
> -	kref_init(&ufence->refcount);
> -	ufence->addr =3D ptr;
> +	ufence->xe    =3D xe;
> +	ufence->addr  =3D ptr;
>  	ufence->value =3D value;
> -	ufence->mm =3D current->mm;
> -	mmgrab(ufence->mm);
> +	drm_user_fence_init(&ufence->base, xe->ordered_wq, &xe_ufence_ops);

[Severity: High]
This is a pre-existing issue, but can this indefinitely blocking userspace
memory access stall the device-wide ordered workqueue?

If an unprivileged userspace application maps a memory region with
userfaultfd, submits a user fence operation pointing to this region, and
refuses to resolve the fault, copy_to_user() will block indefinitely.

Since the worker is initialized with xe->ordered_wq, this could permanently
stall the single-threaded workqueue used for critical device-wide operations
like GT resets, TDRs, and compute mode preempt rebinds, leading to a denial
of service.

> =20
>  	return ufence;
>  }
> =20
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908084627.3525=
35-1-srinivasan.shanmugam@amd.com?part=3D3
