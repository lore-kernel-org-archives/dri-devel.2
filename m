Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E45C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF8FC10F25B;
	Wed,  2 Sep 2026 14:58:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AIRq1QLF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3058210F25B
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 14:58:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7B2A5600C8;
 Wed,  2 Sep 2026 14:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BC81F000E9;
 Wed,  2 Sep 2026 14:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788361134;
 bh=7oPYOTDQUzczk4Uszr7IewReZAMucFeXFK37dwijIlQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AIRq1QLFUJXwU9b8vZvSXvLA+YtLtCrkA06qMFEx7e0qXkHtQOwmp244ZKCcYHwKQ
 J8dMP3XWpIrd9ZciDHDQI/UsVjNu/FkuRZ6m13PBc3Vcw9p7h+8LfnbBPXhlRmYfIB
 r8wg58151URbJ48Dds/4ByTRONg/6OnROytGHKHV0roWs8Qqm/3weYCg2ZUqvuh4Fd
 7ltCv+2fKRhludlRJGY82aryQFVNWQ/JUlrC5uFZ/vHIjFMlha5YGeqUPGzBOQ80aX
 SYXk6NvbrQdwqHp0MWvubt4YQ+6uno5xYSJ4gxVsQWSTj0nUWCmIA5VVGweydk6m9z
 JMH5RkvZzC6Cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] drm/sched: fix use-after-free of the fence
 timeline name
To: =?utf-8?b?Sm9uZ2h5dWsgS2ltKE1hbEh5dWsp?= <malhyuk97@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260902144204.1843670-2-malhyuk97@gmail.com>
References: <20260902144204.1843670-1-malhyuk97@gmail.com>
 <20260902144204.1843670-2-malhyuk97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:58:53 +0000
Message-Id: <20260902145854.08BC81F000E9@smtp.kernel.org>
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
- [Critical] Unconditional dereference of `to_drm_sched_fence()` return val=
ue causes a deterministic kernel crash for signaled finished fences in down=
stream drivers.
- [High] TOCTOU race during ops detachment causes `to_drm_sched_fence()` to=
 return NULL, leading to a NULL pointer dereference in ops callbacks.

Pre-existing issues:
- [High] The scheduled fence retains its `.release` callback, leaving it vu=
lnerable to the same use-after-free of the scheduler timeline name if it ou=
tlives the scheduler.
--

commit cbf4f1124a22fb62bedbf4d0c94b024440ce5beb
Author: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
drm/sched: fix use-after-free of the fence timeline name

This commit aims to resolve a use-after-free vulnerability involving
the fence timeline name by removing the .release callback from the
finished fence. This allows dma_fence to detach the fence operations
on signaling, while restructuring references so the scheduled fence
holds a reference to the finished fence.

> diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/sc=
heduler/sched_fence.c
> --- a/drivers/gpu/drm/scheduler/sched_fence.c
> +++ b/drivers/gpu/drm/scheduler/sched_fence.c
> @@ -95,15 +95,6 @@ static const char *drm_sched_fence_get_timeline_name(s=
truct dma_fence *f)
>  	return (const char *)fence->sched->name;

[Severity: High]
Can a time-of-check to time-of-use race occur here leading to a null
pointer dereference?

Code paths like dma_fence_timeline_name() locklessly read f->ops under RCU.
If another thread concurrently signals the fence, dma_fence_signal() will
detach the ops by setting f->ops to NULL.

If the first thread reads the valid &drm_sched_fence_ops_finished before
the detachment, but calls ops->get_timeline_name(fence) after,
to_drm_sched_fence() will re-read f->ops (which is now NULL) and return
NULL.

Since fence is unconditionally dereferenced in the return statement above,
and similarly in drm_sched_fence_set_deadline_finished() for the deadline
field, could this race window cause a regression if hit? Userspace could
potentially trigger this by invoking SYNC_IOC_FILE_INFO while a job
completes.

>  }

[ ... ]

> @@ -189,7 +171,13 @@ static const struct dma_fence_ops drm_sched_fence_op=
s_scheduled =3D {

[Severity: High]
This isn't a bug introduced by this patch, but does the scheduled fence
remain vulnerable to the same use-after-free issue?

This patch removes the .release callback from drm_sched_fence_ops_finished
to allow ops detachment on signaling. However,
drm_sched_fence_ops_scheduled retains its .release callback
(drm_sched_fence_release_scheduled).

Because it has a .release callback, dma_fence_signal() will not detach the
ops for the scheduled fence.

If a subsystem holds a reference to the scheduled fence after the scheduler
is destroyed, won't any subsequent timeline name queries dereference the
dangling fence->sched->name pointer, triggering the same
slab-use-after-free this patch addresses?

>  static const struct dma_fence_ops drm_sched_fence_ops_finished =3D {
>  	.get_driver_name =3D drm_sched_fence_get_driver_name,
>  	.get_timeline_name =3D drm_sched_fence_get_timeline_name,
> -	.release =3D drm_sched_fence_release_finished,
> +	/*
> +	 * No .release callback: dma_fence detaches ->ops on signalling for
> +	 * fences without .release/.wait, so get_timeline_name() is never called
> +	 * on a signalled finished fence and cannot dereference a freed
> +	 * scheduler. The shared allocation is freed from dma_fence_free() once
> +	 * this fence's refcount drops - it is released last, after @scheduled.
> +	 */

[Severity: Critical]
Does removing the .release callback here cause a regression in downstream
drivers, resulting in a deterministic crash?

Because the ops are now detached on signaling (setting f->ops to NULL),
to_drm_sched_fence() will return NULL for a signaled finished fence.

However, downstream drivers assume their scheduler fences are always
recognized and unconditionally dereference the result of
to_drm_sched_fence().

For example, in amdgpu_cs_p2_dependencies():

drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:amdgpu_cs_p2_dependencies() {
    ...
    s_fence =3D to_drm_sched_fence(fence);
    fence =3D dma_fence_get(&s_fence->scheduled);
    ...
}

And in amdgpu_ctx_fence_time():

drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c:amdgpu_ctx_fence_time() {
    ...
    s_fence =3D to_drm_sched_fence(fence);
    if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->scheduled.flags))
    ...
}

When an unprivileged user closes a context with completed jobs or queries
dependencies on completed jobs, won't this result in an immediate null
pointer dereference?

>  	.set_deadline =3D drm_sched_fence_set_deadline_finished,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902144204.1843=
670-1-malhyuk97@gmail.com?part=3D1
