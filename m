Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC3EC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5BB210EEB9;
	Wed,  9 Sep 2026 04:57:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MZtu/C+V";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0890410EEB5;
 Wed,  9 Sep 2026 04:57:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 71E3243E34;
 Wed,  9 Sep 2026 04:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206F31F00A3A;
 Wed,  9 Sep 2026 04:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788929851;
 bh=l7QmdJvR0u2LUaNob7vgqutvSjw34OpapaublkgChvk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MZtu/C+ViRjf4oAFSkBk0zcIbcLlNVLZgU9WygBKQYFn2OdlWD30XYlKnAW+20OcR
 Osfl55porKbpljogBPeqapamvWrqvqUP89vP0k6e0V7INeIfu5qdpBrLR4fwCNUJlQ
 HGJtTHcYfTB/m/M6xJoSyIaF5iG0zoIo5m4ZLzT/WHFhsOjxgqvj8ASR8Eb6Zf7BTz
 fQqnOQFPk5hDCbs2fjmtYKpXz75vrXErJlbV79p6qOELOOjxXogr9PyNQD5IlUTWCC
 KslpPkyf6S8vbeedsX86oQQ4gbQmYVcQbfgTHytjdHWDnGIgfnxKRQ9tLTDsp+g7Re
 jaEzT+eAGaqlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/3] drm/xe: Convert xe_user_fence to drm_user_fence
To: "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260909044454.399340-4-srinivasan.shanmugam@amd.com>
References: <20260909044454.399340-1-srinivasan.shanmugam@amd.com>
 <20260909044454.399340-4-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:57:30 +0000
Message-Id: <20260909045731.206F31F00A3A@smtp.kernel.org>
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

New issues:
- [Low] Unused function xe_sync_ufence_cancel() introduced.

Pre-existing issues:
- [High] User fence signaling can block the device-wide ordered workqueue, =
causing a cross-process denial of service.
- [High] Userspace can trigger kernel WARNINGs and potential DoS by concurr=
ently resetting the syncobj fence.
--

commit c30f53c58eadaed9972496eb0819631ccfe8878e
Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

drm/xe: Convert xe_user_fence to drm_user_fence

This commit replaces the open-coded user fence implementation in xe_sync.c
with the new common drm_user_fence helper. It moves the local user fence
logic into xe_ufence_ops.writeback and xe_ufence_ops.destroy callbacks.

> diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
> index 37866768d64c2..a335dd5f4478b 100644
> --- a/drivers/gpu/drm/xe/xe_sync.c
> +++ b/drivers/gpu/drm/xe/xe_sync.c
[ ... ]
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
This isn't a bug introduced by this patch, but can this copy_to_user() block
the device-wide ordered workqueue?

As noted in the comment above it, if userspace backs the fence address with
userfaultfd or FUSE, the copy_to_user() call can be intentionally stalled
indefinitely. Since this worker runs on xe->ordered_wq which has max_active=
=3D1,
a stalled copy could block all other work items on this queue, resulting in=
 a
denial of service for the device.=20

Should this use a dedicated non-blocking workqueue instead?

[ ... ]
> @@ -282,24 +281,15 @@ void xe_sync_entry_signal(struct xe_sync_entry *syn=
c, struct dma_fence *fence)
>  	} else if (sync->syncobj) {
>  		drm_syncobj_replace_fence(sync->syncobj, fence);
>  	} else if (sync->ufence) {
> -		int err;
> -
>  		drm_syncobj_add_point(sync->ufence_syncobj,
>  				      sync->ufence_chain_fence,
>  				      fence, sync->ufence_timeline_value);
>  		sync->ufence_chain_fence =3D NULL;
> =20
>  		fence =3D drm_syncobj_fence_get(sync->ufence_syncobj);
> -		user_fence_get(sync->ufence);
> -		err =3D dma_fence_add_callback(fence, &sync->ufence->cb,
> -					     user_fence_cb);
> -		if (err =3D=3D -ENOENT) {
> -			kick_ufence(sync->ufence, fence);
> -		} else if (err) {
> +		if (drm_user_fence_add_callback(&sync->ufence->base, fence))

[Severity: High]
This isn't a bug introduced by this patch, but can this sequence trigger a
kernel WARNING?

In xe_sync_entry_signal(), drm_syncobj_fence_get() retrieves a fence from t=
he
syncobj. If userspace concurrently resets the syncobj using
DRM_IOCTL_SYNCOBJ_RESET, the retrieved fence could be NULL. Passing this
NULL fence to drm_user_fence_add_callback() would trigger a WARN_ON inside
the underlying dma_fence_add_callback() function.

Is there a way to safely handle the NULL fence case here?

>  			XE_WARN_ON("failed to add user fence");
> -			user_fence_put(sync->ufence);
> -			dma_fence_put(fence);
> -		}
> +		/* fence ref consumed by drm_user_fence_add_callback */
>  	}
>  }
[ ... ]
> @@ -434,6 +424,21 @@ void xe_sync_ufence_put(struct xe_user_fence *ufence)
>  	user_fence_put(ufence);
>  }
> =20
> +/**
> + * xe_sync_ufence_cancel() - Non-blocking cancel of user fence callback
> + * @ufence: user fence reference
> + *
> + * Attempts to cancel the pending callback without waiting for the worke=
r.
> + * Safe to call while holding dma_resv_lock or vm->lock. If the callback
> + * has already fired, the worker runs independently =E2=80=94 xe_ufence_=
worker
> + * only accesses device-level and userspace resources, both safe after
> + * VMA teardown.
> + */
> +void xe_sync_ufence_cancel(struct xe_user_fence *ufence)
> +{
> +	drm_user_fence_cancel(&ufence->base);
> +}
> +

[Severity: Low]
Is this function still needed?

The commit message mentions that callers for xe_sync_ufence_cancel() were
removed in v9, but the function definition itself remains here, resulting
in unused code.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909044454.3993=
40-1-srinivasan.shanmugam@amd.com?part=3D3
