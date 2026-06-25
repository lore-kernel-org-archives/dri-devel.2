Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B18CDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC6510F215;
	Thu, 25 Jun 2026 10:04:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nhW57eiV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BF8D10F215
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:04:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6AAE740B3A;
 Thu, 25 Jun 2026 10:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392811F000E9;
 Thu, 25 Jun 2026 10:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782381897;
 bh=h9ugp1HvSwXlSb6EqEXZSPHCRha1BUpRA6TDvjdsbDg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nhW57eiVKoZ8+Lqpu3mVb9tJBLkFrkqQsh2TAqPM7xYBoF7rSoZqf6ijyIC30IR1t
 THoDnwHck71du9b+NGcMWPD/fP7OVHRr92x1deSM/3Wn1oqwU+Sg3E9oyqJgbBx/xD
 YwdnuFpz/uohQbLWMH+Gn57Zj1glvNturWAUfdEw+Li7JN1a9ge1whL4NnYw9dxAI0
 xPnKvxmarfMsHEU3NQR7WeXRIV5lub15U1mRAIPFI+rZ74OJtKb7wpQQlNqJjJ/upo
 LUtH8ZEgXs4hDuG69jEyafMB5/DFZSsLQzZJrfByrVyj9N4Ps3iLLuhhZcMdh/pG6J
 oifrasca1qyVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/16] drm/panthor: Don't overrule pending immediate
 ticks in sched_resume_tick()
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625-panthor-signal-from-irq-v5-2-8836a74e0ef9@collabora.com>
References: <20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com>
 <20260625-panthor-signal-from-irq-v5-2-8836a74e0ef9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:04:56 +0000
Message-Id: <20260625100457.392811F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Dereference of ERR_PTR in panthor_heap_pool_put() during tiler OOM=
 handling.
- [High] Asynchronous cleanup of scheduling groups executes without holding=
 a DRM device reference, leading to a Use-After-Free of panthor_device.
- [High] Missing bounds check on synchronization object offset allows out-o=
f-bounds read.
--

commit eccb99f3f3029758d8c3f80d0f349c280e91b3c2
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Don't overrule pending immediate ticks in sched_resume_tick()

We schedule immediate ticks when we need to process events on CSGs,
but those immediate ticks don't change the resched_target because we
want the other groups to stay scheduled for the remaining of the GPU
timeslot they were given. Make sure these immediate ticks don't get
overruled by a sched_queue_delayed_work() that would delay the tick
execution.

Fixes: 99820b4b7e50 ("drm/panthor: Make sure we resume the tick when new jo=
bs are submitted")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v4-=
0-3d2908912afa@collabora.com?part=3D9

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 5b34032deff81..1913bc8a62977 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -2668,7 +2668,14 @@ static void sched_resume_tick(struct panthor_devic=
e *ptdev)
>  	else
>  		delay_jiffies =3D 0;
> =20
> -	sched_queue_delayed_work(sched, tick, delay_jiffies);
> +	/* We schedule immediate ticks when we need to process events on CSGs,
> +	 * but those don't change the resched_target because we want the other
> +	 * groups to stay scheduled for the remaining of the GPU timeslot they
> +	 * were given. Make sure those immediate ticks don't get overruled by
> +	 * a sched_queue_delayed_work() that would delay the tick execution.
> +	 */
> +	if (!delayed_work_pending(&sched->tick_work))
> +		sched_queue_delayed_work(sched, tick, delay_jiffies);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but we noticed a potential
out-of-bounds read nearby. In panthor_queue_get_syncwait_obj(), the
return value of panthor_gem_sync() is ignored:

drivers/gpu/drm/panthor/panthor_sched.c:panthor_queue_get_syncwait_obj() {
    ...
	panthor_gem_sync(&bo->base,
			 DRM_PANTHOR_BO_SYNC_CPU_CACHE_FLUSH_AND_INVALIDATE,
			 queue->syncwait.offset,
			 queue->syncwait.sync64 ?
			 sizeof(struct panthor_syncobj_64b) :
			 sizeof(struct panthor_syncobj_32b));

	return queue->syncwait.kmap + queue->syncwait.offset;
}

If panthor_gem_sync() detects the offset is out of bounds and returns
-EINVAL, the function ignores the error and still returns the
pointer, which points outside the buffer boundary.

Could this allow panthor_queue_eval_syncwait() to dereference an
out-of-bounds pointer when it reads syncobj->sync64.seqno?

[Severity: High]
This is a pre-existing issue, but is it safe for group_release() to queue
asynchronous cleanup work without pinning the DRM device?

drivers/gpu/drm/panthor/panthor_sched.c:group_release() {
	...
	queue_work(panthor_cleanup_wq, &group->release_work);
}

When the DRM device file is closed and panthor_postclose() executes group
destruction, it doesn't flush the panthor_cleanup_wq workqueue. If the
device is hot-unplugged, the DRM core might free the panthor_device.

When group_release_work() eventually executes later, does this lead to a
use-after-free when it accesses the freed panthor_device during cleanup
(e.g., in panthor_kernel_bo_destroy())?

[Severity: High]
This is a pre-existing issue, but we noticed a potential pointer dereference
issue in the tiler OOM handling path. In group_process_tiler_oom():

drivers/gpu/drm/panthor/panthor_sched.c:group_process_tiler_oom() {
    ...
	heaps =3D panthor_vm_get_heap_pool(group->vm, false);
    ...
	if (IS_ERR(heaps) || frag_end > vt_end || vt_end >=3D vt_start) {
		ret =3D -EINVAL;
    ...
out_put_heap_pool:
	panthor_heap_pool_put(heaps);
	return ret;
}

If heaps is an ERR_PTR (like ERR_PTR(-ENOENT)), the code correctly sets
ret =3D -EINVAL but later jumps to out_put_heap_pool and calls
panthor_heap_pool_put().

Since panthor_heap_pool_put() only checks if (pool) and doesn't check
IS_ERR(pool), wouldn't this try to dereference an invalid error pointer
in kref_put()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-panthor-si=
gnal-from-irq-v5-0-8836a74e0ef9@collabora.com?part=3D2
