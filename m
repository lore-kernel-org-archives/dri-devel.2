Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13827C624D9
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C7BA10E242;
	Wed,  2 Sep 2026 15:35:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WCv+1E1/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F106310F282;
 Wed,  2 Sep 2026 15:34:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ABF5B43AB0;
 Wed,  2 Sep 2026 15:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629531F00A3A;
 Wed,  2 Sep 2026 15:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788363298;
 bh=leHJ1krmsP+1jk2Z+sOOrfddQ8CBvBEPQU7q2DE7Tk8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WCv+1E1/L5yH9HlymQICwv4QxJTZqJ4iyyHwXTWaghk+tfXiFG6q5ziKOdbf88D3/
 Xbllo+m1FK6du9FCV+yyZi4BGayxhEwYwwC1TZ5hSACmirHpodjSXAySiY0ovTRUVQ
 iJ6Z8JZXhcF/1/u0oINvGtK8Gdfylon8MhdJ+LioK3ZiSFbGWpwb0rSlEHp0LeqPc5
 6Z1edHYIkRB69THVMfDNYiO1GsF8a3E0TJWITUFbrv7xNSqzcctNJySNx991Qafx+9
 7qEcBuv1AKrkfHhELUl6MvBjw/RGk2G7ZzsCyHGLVQdHpzKOGKGeO/jDN8MG0+4Zfj
 L8UmzZtLc1rnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/4] drm/xe: Convert xe_user_fence to drm_user_fence
To: "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260902152049.183685-3-srinivasan.shanmugam@amd.com>
References: <20260831134539.112690-2-srinivasan.shanmugam@amd.com>
 <20260902152049.183685-1-srinivasan.shanmugam@amd.com>
 <20260902152049.183685-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:34:57 +0000
Message-Id: <20260902153458.629531F00A3A@smtp.kernel.org>
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
- [High] Race condition in user fence signaling causes spurious -EBUSY fail=
ures for valid VMA unmap operations.

Pre-existing issues:
- [High] Userspace can stall the global xe->ordered_wq indefinitely via use=
rfaultfd on user fence signaling, causing a Denial of Service for all compu=
te applications.
--

commit e66f332fb8f0deb8b5c5b3ca223be49da69834d3
Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
drm/xe: Convert xe_user_fence to drm_user_fence

This commit replaces the open-coded user fence implementation in xe_sync.c
with the new common drm_user_fence helper. The xe_user_fence structure now
embeds drm_user_fence and the previous local functions are replaced by
operations provided to the drm helper.

> diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
> index 37866768d64c2..05f6794af1ee2 100644
> --- a/drivers/gpu/drm/xe/xe_sync.c
> +++ b/drivers/gpu/drm/xe/xe_sync.c
[ ... ]
> @@ -19,36 +18,58 @@
>  #include "xe_macros.h"
>  #include "xe_sched_job_types.h"
> =20
> +/*
> + * xe_user_fence wraps drm_user_fence with XE-specific fields.
> + * The drm_user_fence base handles MM borrowing and work-item lifetime.
> + */
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
> +	if (mm_ok) {
> +		if (copy_to_user(ufence->addr, &ufence->value, sizeof(ufence->value)))

[Severity: High]
This is a pre-existing issue, but can this copy_to_user() call cause a
denial of service?

If a malicious unprivileged userspace process creates a user fence using
DRM_XE_SYNC_TYPE_USER_FENCE and provides a memory address backed by
userfaultfd, the page fault will block indefinitely here because userspace
can refuse to resolve it.

> +			drm_dbg(&ufence->xe->drm,
> +				"copy_to_user failed, user fence wasn't signaled\n");
> +	} else {
> +		drm_dbg(&ufence->xe->drm,
> +			"mmget_not_zero() failed, ufence wasn't signaled\n");
> +	}
> =20
> -static void user_fence_get(struct xe_user_fence *ufence)
> -{
> -	kref_get(&ufence->refcount);
> +	/*
> +	 * Ensure the fence value write is visible before signalled=3D1.
> +	 * A UMD polling signalled must see the committed fence value.
> +	 */
> +	smp_wmb();
> +
> +	/*
> +	 * Mark signalled after the user memory write so UMD can safely
> +	 * reuse the same ufence without hitting -EBUSY.
> +	 */
> +	WRITE_ONCE(ufence->signalled, 1);

[Severity: High]
Does this new ordering introduce a race condition causing spurious -EBUSY
failures for valid VMA unmap operations?

The original code updated the ufence->signalled state before calling
copy_to_user(). By inverting the order, if userspace is polling the memory
address, it will observe the memory update and immediately issue a VM unmap
ioctl.=20

If this unmap ioctl reaches the driver before the worker thread executes
WRITE_ONCE(ufence->signalled, 1), the kernel state will still read as 0 and
incorrectly fail the unmap with -EBUSY.

> +
> +	wake_up_all(&ufence->xe->ufence_wq);
>  }
[ ... ]
> @@ -63,51 +84,22 @@ static struct xe_user_fence *user_fence_create(struct=
 xe_device *xe, u64 addr,
>  	if (!ufence)
>  		return ERR_PTR(-ENOMEM);
> =20
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
This is a pre-existing issue, but does using the global device-wide
xe->ordered_wq amplify the impact of the userfaultfd block mentioned above?

Since critical tasks like vm->preempt.rebind_work are queued on this same
ordered workqueue, stalling it prevents preempt rebinds globally for all
VMs, completely hanging the GPU driver.

> =20
>  	return ufence;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902152049.1836=
85-1-srinivasan.shanmugam@amd.com?part=3D3
