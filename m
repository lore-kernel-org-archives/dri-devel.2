Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5A606A33E
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6id6PlG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7480210EB70;
	Tue, 20 Oct 2026 10:19:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E92FC10EB70;
 Tue, 20 Oct 2026 10:19:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BD76F436D8;
 Tue, 20 Oct 2026 10:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C551F000C4;
 Tue, 20 Oct 2026 10:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792491592;
 bh=l/luWFoyZUXB/cvJs8KH7wPvpHX/GrRNRixWnXnO8wQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m6id6PlGoHX5Lj/BKg37uq03t5T33lzJkqzqECL5f8YtK6SodazeJgZa4hIM1Gfpw
 2xWoSmIw4GiQeGCbFiqixE1AQcIS7QKQc7imM1i62EEDEMYSrR1bdYVtv760WnNlMn
 G+ljRPcnibdVZo8Lm/ik+Yc/SW6pwFqdqnhc5KLzeXF+4/cTkghfVKO/BFG7tPrTZ4
 sXNZijcflUknSS8/n2uiSXVqh7Tjw29roNymtkN6totfYTwOxytrpHY49FcIvREjtV
 Uhbtv5Hd1jwomgcL/Dwgt0NxVQfwgG1NDj+25P4aau/kWA/EGeN+AjmTgvNCHr3Tq7
 9ZHs7xq3yDMyA==
Message-ID: <sashiko-outbox-178823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/3] dma-fence: use lock to protect against
 module-unload
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261020100034.759183-4-phasta@kernel.org>
References: <20261020100034.759183-2-phasta@kernel.org>
 <20261020100034.759183-4-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 10:19:52 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] dma-fence: deadlock in dma_fence_set_deadline() holding fence lock
- [High] dma-fence: recursive lock deadlock in dma_fence_is_signaled()
- [High] dma-fence: module .rodata UAF on ops in dma_fence_set_deadline()
--

commit be24351242cf77e69e189b5c2659a451b6892af0
Author: Philipp Stanner <phasta@kernel.org>

dma-fence: use lock to protect against module-unload

This commit acquires the dma_fence spinlock in dma_fence_set_deadline()
and dma_fence_is_signaled() to serialize fence->ops callback invocations
against signaling and module unload.

> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 5dab647e3f3f9..e4350bce9cf9b 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -997,9 +997,14 @@ EXPORT_SYMBOL(dma_fence_wait_any_timeout);
>  void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
>  {
>  	const struct dma_fence_ops *ops =3D fence->ops;
> +	unsigned long flags;
> +
> +	dma_fence_lock_irqsave(fence, flags);
> =20
> -	if (ops->set_deadline && !dma_fence_is_signaled(fence))
> +	if (ops->set_deadline && !dma_fence_is_signaled_locked(fence))
>  		ops->set_deadline(fence, deadline);
> +
> +	dma_fence_unlock_irqrestore(fence, flags);
>  }
>  EXPORT_SYMBOL(dma_fence_set_deadline);

[Severity: High]
Will holding the fence spinlock across ops->set_deadline() here cause
deadlocks in the existing set_deadline implementations?

The comment on struct dma_fence_ops in include/linux/dma-fence.h states:

	 * This is called without &dma_fence.lock held, it can be called
	 * multiple times and from any context.  Locking is up to the callee
	 * if it has some state to manage.

All three non-container implementations of set_deadline acquire the
fence's own spinlock inside the callback, which will self-deadlock on the
same CPU when called on an unsignaled fence (for example via the
SYNC_IOC_SET_DEADLINE ioctl or DRM atomic commit paths):

1. drivers/gpu/drm/scheduler/sched_fence.c:
   drm_sched_fence_set_deadline_finished() calls
   dma_fence_lock_irqsave(f, flags) on the same fence:

	dma_fence_lock_irqsave(f, flags);

	/* If we already have an earlier deadline, keep it: */
	if (test_bit(DRM_SCHED_FENCE_FLAG_HAS_DEADLINE_BIT, &f->flags) &&
	    ktime_before(fence->deadline, deadline)) {
		dma_fence_unlock_irqrestore(f, flags);
		return;
	}

   In addition, drm_sched_fence_set_deadline_finished() then propagates
   the deadline to the hardware parent fence:

	parent =3D smp_load_acquire(&fence->parent);
	if (parent)
		dma_fence_set_deadline(parent, deadline);

   If the outer dma_fence_set_deadline() holds s_fence->finished's lock
   across ops->set_deadline(), calling dma_fence_set_deadline(parent, ...)
   acquires parent's lock under s_fence->finished's lock. However, job
   completion in drivers/gpu/drm/scheduler/sched_main.c runs
   dma_fence_signal(parent) -> drm_sched_job_done_cb() ->
   drm_sched_job_done() -> drm_sched_fence_finished() ->
   dma_fence_signal(&s_fence->finished), which acquires
   s_fence->finished's lock while holding parent's lock, creating an
   AB-BA lock-order inversion.

2. drivers/gpu/drm/msm/msm_fence.c:
   msm_fence_set_deadline() acquires &fctx->spinlock:

	spin_lock_irqsave(&fctx->spinlock, flags);

   which is the fence's extern_lock passed to dma_fence_init() in
   msm_fence_init().

3. drivers/dma-buf/sw_sync.c:
   timeline_fence_set_deadline() acquires the fence lock directly:

	dma_fence_lock_irqsave(fence, flags);

[Severity: High]
Also in dma_fence_set_deadline() above, can this still access freed
driver memory or unmapped module .rodata when called on an already
signaled fence after module unload?

First, because there is no unlocked dma_fence_test_signaled_flag(fence)
check before dma_fence_lock_irqsave(fence, flags), calling
dma_fence_set_deadline() on a signaled fence unconditionally touches
dma_fence_spinlock(fence), which may be an extern_lock freed by the
driver after signaling.

Second, inside the lock:

	if (ops->set_deadline && !dma_fence_is_signaled_locked(fence))

evaluates ops->set_deadline before checking
!dma_fence_is_signaled_locked(fence). Since fence->ops is no longer set to
NULL on signaling (after parent commit 4607587506fc ("dma-fence: Remove
RCU protection for fence->ops")), calling dma_fence_set_deadline() on a
signaled fence after the producer module has unloaded will dereference
ops->set_deadline in the unmapped module's .rodata section.

Similarly, the commit message notes that release() and wait() are
deprecated, but even when a modular driver leaves .release and .wait as
NULL in its struct dma_fence_ops table, dma_fence_release():

	if (ops->release)
		ops->release(fence);
	else
		dma_fence_free(fence);

and dma_fence_wait_timeout():

	if (ops->wait) {
		ret =3D ops->wait(fence, intr, timeout);
	} else {
		ret =3D dma_fence_default_wait(fence, intr, timeout);
	}

still dereference the ops table in the module's .rodata to check whether
those pointers are NULL when a consumer waits on or drops the last
reference to a signaled fence after the module has unloaded.

> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index 874848a4aec46..2223d75c5a496 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -549,16 +549,29 @@ static inline bool
>  dma_fence_is_signaled(struct dma_fence *fence)
>  {
>  	const struct dma_fence_ops *ops =3D fence->ops;
> +	unsigned long flags;
> +	bool ret =3D false;
> =20
> +	/* Fast-path optimization. */
>  	if (dma_fence_test_signaled_flag(fence))
>  		return true;
> =20
> -	if (ops && ops->signaled && ops->signaled(fence)) {
> -		dma_fence_signal(fence);
> -		return true;
> +	dma_fence_lock_irqsave(fence, flags);
> +
> +	if (dma_fence_test_signaled_flag(fence)) {
> +		ret =3D true;
> +		goto out;
>  	}
> =20
> -	return false;
> +	if (ops->signaled && ops->signaled(fence)) {
> +		ret =3D true;
> +		dma_fence_signal_locked(fence);
> +	}
> +
> +out:
> +	dma_fence_unlock_irqrestore(fence, flags);
> +
> +	return ret;
>  }

[Severity: High]
Can acquiring dma_fence_lock_irqsave() unconditionally in
dma_fence_is_signaled() cause a recursive spinlock deadlock in
amdkfd_fence_enable_signaling()?

In drivers/dma-buf/dma-fence.c, __dma_fence_enable_signaling() holds the
fence spinlock and calls ops->enable_signaling(fence) when the fence is
not yet signaled:

	dma_fence_assert_held(fence);

	was_set =3D test_and_set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
				   &fence->flags);

	if (dma_fence_test_signaled_flag(fence))
		return false;

	if (!was_set && ops->enable_signaling) {
		trace_dma_fence_enable_signal(fence);

		if (!ops->enable_signaling(fence)) {

In drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c,
amdkfd_fence_enable_signaling() (where amdkfd_fence_ops.signaled is NULL)
calls dma_fence_is_signaled(f) and
kgd2kfd_schedule_evict_and_restore_process():

static bool amdkfd_fence_enable_signaling(struct dma_fence *f)
{
	struct amdgpu_amdkfd_fence *fence =3D to_amdgpu_amdkfd_fence(f);

	if (!fence)
		return false;

	if (dma_fence_is_signaled(f))
		return true;

	if (!kgd2kfd_schedule_evict_and_restore_process(fence->mm, fence->context_=
id, f))
		return true;

and kgd2kfd_schedule_evict_and_restore_process() in
drivers/gpu/drm/amd/amdkfd/kfd_device.c also checks:

	if (dma_fence_is_signaled(fence))
		return 0;

Previously, dma_fence_is_signaled(f) saw that ops->signaled was NULL and
returned false without taking the lock. With this change, when
DMA_FENCE_FLAG_SIGNALED_BIT is not set, dma_fence_is_signaled(f) attempts
to acquire f's spinlock while __dma_fence_enable_signaling(f) already
holds it on the same CPU.

!]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020100034.7591=
83-2-phasta@kernel.org?part=3D2
