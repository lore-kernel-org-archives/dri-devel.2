Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA90606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VJ7b1/a6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E162010E1A8;
	Thu, 29 Oct 2026 19:25:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B9651124C0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 19:24:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0591843DF5;
 Thu, 29 Oct 2026 19:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3CF1F01824;
 Thu, 29 Oct 2026 19:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793301898;
 bh=b4aM4kfc5wiWGRlYkBvbs1a/3djn4LaRQSBPGk2pptc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VJ7b1/a6nZkhgj0fwNDOZZk9ZJwds+BPZY8BOUMQcnf1VfUFLsX8J6lH9QPKg8yzJ
 Gjon3TT22E7YSfJrbv4rBfRZAwoKVuTJbHKrJcpjIRZjFWdDDOlpTEfNID5UgKtDnP
 /duQ1/EwWkwS6IFsk409iKHJ/Xrz96ufmNuelZJmMua/IPveyN3i6nYjKoTWadpNbh
 vWQNpBzol+1o4zgvzpQijW0anPC7DZX8pMuh2PX4TIQWDyzUE9f2GdduTJqQf6rSmt
 SO2hws3bMqT93QHZ5fxUsK7QcUErzK3+bNVLh4eIJkj1n7rfC4aS2g29dq6+Z0rEaf
 y2lmBisAoQ7Kg==
Message-ID: <sashiko-outbox-189875@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/msm: preemption aware hangcheck
To: "Anna Maniscalco" <anna.maniscalco2000@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-preemption_aware_hangcheck-v2-1-be0056e1f02d@gmail.com>
References: <20261029-preemption_aware_hangcheck-v2-1-be0056e1f02d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 19:24:58 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:
- [High] drm/msm/a6xx: IFPC vote leak on early return in a6xx_get_ctx_times=
tamp()
- [High] drm/msm/a6xx: wrong ring and skipped sysprof update in a6xx_preemp=
t_trigger()
- [High] drm/msm/adreno: wrong CP_ALWAYS_ON_CONTEXT register for A8xx in a7=
xx_submit()
- [High] drm/msm/a6xx: missing last_job_start_ctx update in a6xx_submit()
- [High] drm/msm/a6xx: uninitialized eval_lock in a6xx_get_ctx_timestamp()
- [High] drm/msm/a8xx: uninitialized gpu->hangcheck_timer used in A8xx IRQ =
handlers
- [High] drm/msm: missing hangcheck_timer and hangcheck_work teardown on cl=
eanup
- [High] drm/msm: stale context timestamps in check_ring_timeout() cause fa=
lse hangs
- [High] drm/msm: unclocked register read in a6xx_get_ctx_timestamp() when =
suspended
- [Medium] drm/msm/a6xx: uninitialized variable in preempt_prepare_postambl=
e()
- [Medium] drm/msm: wrong clock multiplier and 32-bit overflow in hangcheck=
_worker()
- [Low] drm/msm: unused variables in a6xx_preempt_timer() and check_ring_ti=
meout()
--

commit ca7e03133676b7e2984c48917b8dc917a117cdfe
Author: Anna Maniscalco <anna.maniscalco2000@gmail.com>

drm/msm: preemption aware hangcheck

This commit reworks the hangcheck logic to be preemption-aware by moving the
hangcheck timer and worker to each ringbuffer and tracking the per-ring time
spent on the GPU using the CP_ALWAYS_ON_CONTEXT register.

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 92e8c8abb86da..bcb177a99c677 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -519,6 +519,9 @@ static void a7xx_submit(struct msm_gpu *gpu, struct m=
sm_gem_submit *submit)
>  	get_stats_counter(ring, rbbm_perfctr_cp0, rbmemptr_stats(ring, index, c=
pcycles_start));
>  	get_stats_counter(ring, cp_always_on_context, rbmemptr_stats(ring, inde=
x, alwayson_start));
> =20
> +	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_CONTEXT,
> +		rbmemptr(ring, last_job_start_ctx));

[Severity: High]
Since a7xx_submit() is shared between A7xx and A8xx GPUs and selects
cp_always_on_context just above:

	if (adreno_is_a8xx(adreno_gpu)) {
		rbbm_perfctr_cp0 =3D REG_A8XX_RBBM_PERFCTR_CP(0);
		cp_always_on_context =3D REG_A8XX_CP_ALWAYS_ON_CONTEXT;
	} else {
		rbbm_perfctr_cp0 =3D REG_A7XX_RBBM_PERFCTR_CP(0);
		cp_always_on_context =3D REG_A6XX_CP_ALWAYS_ON_CONTEXT;
	}

will passing REG_A6XX_CP_ALWAYS_ON_CONTEXT (0x0982) instead of
cp_always_on_context here trigger a CP register protection fault on A8xx,
where 0x0982 falls inside the NORDWR protected range (0x08ec..0x09af) in
a830_protect_regs and a850_protect_regs?

[ ... ]

> @@ -2297,6 +2294,43 @@ static u64 a6xx_get_timestamp(struct msm_gpu *gpu)
>  	return gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_COUNTER);
>  }
> =20
> +static int a6xx_get_ctx_timestamp(struct msm_ringbuffer *ring, uint64_t =
*value)
> +{
> +	struct msm_gpu *gpu =3D ring->gpu;
> +	struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> +	int ret =3D 0;
> +
> +	/* Inhibit IFPC while accessing registers: */
> +	if (gpu->funcs->sysprof_setup)
> +		gpu->funcs->sysprof_setup(gpu, true);
> +
> +	/*
> +	 * a6xx_gmu_set_oob cannot be called while holding a spinlock.
> +	 * Limit the scope.
> +	 */
> +	{
> +		guard(spinlock_irqsave)(&a6xx_gpu->eval_lock);
> +
> +		/*
> +		 * Make sure the GMU keeps the GPU on while we read the register
> +		 *
> +		 * This should normally not be waking up the gpu since the
> +		 * hangcheck timer shouldn't fire when the gpu is idle.
> +		 */
> +		if (a6xx_in_preempt(a6xx_gpu) || ring !=3D a6xx_gpu->cur_ring)
> +			return -EBUSY;
> +
> +		*value =3D gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_CONTEXT);
> +	}
> +
> +	/* Re-enable IFPC: */
> +	if (gpu->funcs->sysprof_setup)
> +		gpu->funcs->sysprof_setup(gpu, false);
> +
> +	return ret;
> +}

[Severity: High]
Does returning -EBUSY directly from inside the guarded block leak the
GMU_OOB_PERFCOUNTER_SET vote and GMU_STATUS_OOB_PERF_SET status bit?

When a6xx_in_preempt(a6xx_gpu) is true or ring !=3D a6xx_gpu->cur_ring, the
early return skips the paired gpu->funcs->sysprof_setup(gpu, false) call at
the end of a6xx_get_ctx_timestamp(), leaving IFPC permanently inhibited.

Also, is a6xx_gpu->eval_lock guaranteed to be initialized when
a6xx_get_ctx_timestamp() acquires it? In a6xx_preempt_hw_init():

	/* No preemption if we only have one ring */
	if (gpu->nr_rings =3D=3D 1)
		return;
	...
	spin_lock_init(&a6xx_gpu->eval_lock);

eval_lock is never initialized when gpu->nr_rings =3D=3D 1 (such as on A6xx=
 GPUs
or single-ring A7xx GPUs), and when gpu->nr_rings > 1, a6xx_preempt_hw_init=
()
re-initializes eval_lock on every hw_init while hangcheck_worker() can acqu=
ire
it without holding gpu->lock.

Finally, can a6xx_get_ctx_timestamp() perform an unclocked register read of
REG_A6XX_CP_ALWAYS_ON_CONTEXT when the GPU is runtime-suspended or mid-resu=
me?

hangcheck_worker() runs without holding gpu->lock or a runtime PM reference.
When a job is retired, ring->hangcheck_timer remains armed, and in
msm_job_run(), msm_fence_init() increments fctx->last_fence before acquiring
gpu->lock and before msm_gpu_submit() calls pm_runtime_get_sync(). In
a6xx_gmu_sysprof_setup():

	if (!pm_runtime_get_if_active(&gpu->pdev->dev))
		return;
	...
	pm_runtime_put(&gpu->pdev->dev);

if the GPU is suspended, sysprof_setup() silently returns without waking the
hardware (and on a6xx_gmuwrapper_funcs, sysprof_setup is NULL), allowing
gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_CONTEXT) to execute while GX is power=
ed
off.

[ ... ]

> @@ -2825,6 +2859,7 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs =3D {
>  		.progress =3D a6xx_progress,
>  		.sysprof_setup =3D a6xx_gmu_sysprof_setup,
>  		.perfcntr_configure =3D a6xx_perfcntr_configure,
> +		.get_ctx_timestamp =3D a6xx_get_ctx_timestamp,
>  	},
>  	.init =3D a6xx_gpu_init,
>  	.get_timestamp =3D a6xx_gmu_get_timestamp,
> @@ -2859,6 +2894,7 @@ const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs=
 =3D {
>  		.get_rptr =3D a6xx_get_rptr,
>  		.progress =3D a6xx_progress,
>  		.perfcntr_configure =3D a6xx_perfcntr_configure,
> +		.get_ctx_timestamp =3D a6xx_get_ctx_timestamp,
>  	},

[Severity: High]
Both a6xx_gpu_funcs and a6xx_gmuwrapper_funcs wire up
.get_ctx_timestamp =3D a6xx_get_ctx_timestamp while using .submit =3D a6xx_=
submit.

Since a6xx_submit() was not updated to emit get_stats_counter() for
last_job_start_ctx, won't ring->memptrs->last_job_start_ctx remain 0 on all
A6xx GPUs, causing check_ring_timeout() to compare cumulative context cycles
since power-on against 0 and falsely trigger hang recovery?

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/=
msm/adreno/a6xx_preempt.c
> index 1e599d4ddea1c..263fec8e6e9bf 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
> @@ -20,15 +20,18 @@ static void a6xx_preempt_timer(struct timer_list *t)
>  	if (!try_preempt_state(a6xx_gpu, PREEMPT_TRIGGERED, PREEMPT_FAULTED))
>  		return;
> =20
> -	dev_err(dev->dev, "%s: preemption timed out\n", gpu->name);
> -	kthread_queue_work(gpu->worker, &gpu->recover_work);
> +	msm_trigger_recovery(gpu);
>  }

[Severity: Low]
Removing dev_err() from a6xx_preempt_timer() leaves local variable dev unus=
ed:

	struct msm_gpu *gpu =3D &a6xx_gpu->base.base;
	struct drm_device *dev =3D gpu->dev;

Was the preemption timeout error log removed intentionally, or should dev_e=
rr()
be kept (or dev removed to avoid an unused-variable warning)?

> -static void preempt_prepare_postamble(struct a6xx_gpu *a6xx_gpu)
> +static void preempt_prepare_postamble(struct a6xx_gpu *a6xx_gpu, struct =
msm_ringbuffer *ring)
>  {
>  	u32 *postamble =3D a6xx_gpu->preempt_postamble_ptr;
> +	uint64_t last_active_ctxcycles;
>  	u32 count =3D 0;
> =20
> +	if (ring)
> +		last_active_ctxcycles =3D rbmemptr(ring, last_active_ctxcycles);
> +
>  	postamble[count++] =3D PKT7(CP_REG_RMW, 3);
>  	postamble[count++] =3D REG_A6XX_RBBM_PERFCTR_SRAM_INIT_CMD;
>  	postamble[count++] =3D 0;
> @@ -43,6 +46,15 @@ static void preempt_prepare_postamble(struct a6xx_gpu =
*a6xx_gpu)
>  	postamble[count++] =3D CP_WAIT_REG_MEM_4_MASK(0x1);
>  	postamble[count++] =3D CP_WAIT_REG_MEM_5_DELAY_LOOP_CYCLES(0);
> =20
> +	a6xx_gpu->preempt_postamble_cntreset_end =3D count;
> +
> +	postamble[count++] =3D PKT7(ring ? CP_REG_TO_MEM : CP_NOP, 3);
> +	postamble[count++] =3D CP_REG_TO_MEM_0_REG(REG_A6XX_CP_ALWAYS_ON_CONTEX=
T) |
> +		CP_REG_TO_MEM_0_CNT(2) |
> +		CP_REG_TO_MEM_0_IS_64B;
> +	postamble[count++] =3D lower_32_bits(last_active_ctxcycles);
> +	postamble[count++] =3D upper_32_bits(last_active_ctxcycles);

[Severity: Medium]
When a6xx_preempt_init() calls preempt_prepare_postamble(a6xx_gpu, NULL),
ring is NULL, so last_active_ctxcycles is never initialized before
lower_32_bits(last_active_ctxcycles) and upper_32_bits(last_active_ctxcycle=
s)
are evaluated and written to postamble[]. Should last_active_ctxcycles be
initialized to 0?

>  	a6xx_gpu->preempt_postamble_len =3D count;
> =20
>  	a6xx_gpu->postamble_enabled =3D true;
> @@ -54,9 +66,9 @@ static void preempt_disable_postamble(struct a6xx_gpu *=
a6xx_gpu)
> =20
>  	/*
>  	 * Disable the postamble by replacing the first packet header with a NOP
> -	 * that covers the whole buffer.
> +	 * that skips the counters reset part.
>  	 */
> -	*postamble =3D PKT7(CP_NOP, (a6xx_gpu->preempt_postamble_len - 1));
> +	*postamble =3D PKT7(CP_NOP, (a6xx_gpu->preempt_postamble_cntreset_end -=
 1));
> =20
>  	a6xx_gpu->postamble_enabled =3D false;
>  }
> @@ -263,8 +275,8 @@ void a6xx_preempt_trigger(struct msm_gpu *gpu)
>  	/* Enable or disable postamble as needed */
>  	sysprof =3D msm_gpu_sysprof_no_perfcntr_zap(gpu);
> =20
> -	if (!sysprof && !a6xx_gpu->postamble_enabled)
> -		preempt_prepare_postamble(a6xx_gpu);
> +	if (!sysprof)
> +		preempt_prepare_postamble(a6xx_gpu, ring);
> =20
>  	if (sysprof && a6xx_gpu->postamble_enabled)
>  		preempt_disable_postamble(a6xx_gpu);

[Severity: High]
In a6xx_preempt_trigger(), ring is the incoming ring returned by
get_next_ring(gpu) (assigned to a6xx_gpu->next_ring), while a6xx_gpu->cur_r=
ing
is the outgoing ring being preempted out.

Since the postamble runs before switching away from the outgoing ring, does=
n't
passing ring instead of a6xx_gpu->cur_ring cause the postamble's CP_REG_TO_=
MEM
packet to write the outgoing ring's CP_ALWAYS_ON_CONTEXT value into the
incoming ring's last_active_ctxcycles, leaving the outgoing ring's
last_active_ctxcycles unupdated?

Furthermore, when sysprof is true, preempt_disable_postamble() only NOPs out
up to preempt_postamble_cntreset_end so that the CP_REG_TO_MEM packet still
runs, but preempt_prepare_postamble() is skipped when sysprof is true. Won't
that leave the postamble writing to a stale ring's last_active_ctxcycles (or
executing the initial CP_NOP from a6xx_preempt_init()) while sysprof is act=
ive?

> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 0c2c356362518..6417bef187b5e 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c

[ ... ]

> @@ -651,11 +653,32 @@ static bool made_progress(struct msm_gpu *gpu, stru=
ct msm_ringbuffer *ring)
>  	return true;
>  }
> =20
> -static void hangcheck_handler(struct timer_list *t)
> +static bool check_ring_timeout(struct msm_ringbuffer *ring, unsigned lon=
g timeout)
>  {
> -	struct msm_gpu *gpu =3D timer_container_of(gpu, t, hangcheck_timer);
> +	struct msm_gpu *gpu =3D ring->gpu;
> +	u64 start, end;
> +	int ret;

[Severity: Low]
In check_ring_timeout(), local variable ret is declared but never used. Can=
 it
be removed?

> +
> +	if (!gpu->funcs->get_ctx_timestamp)
> +		return !made_progress(gpu, ring);
> +
> +	start =3D ring->memptrs->last_job_start_ctx;
> +
> +	if (gpu->funcs->get_ctx_timestamp(ring, &end))
> +		end =3D ring->memptrs->last_active_ctxcycles;
> +
> +	if (end >=3D start)
> +		return (end - start) > timeout;
> +	else
> +		return false;
> +}
> +
> +static void hangcheck_worker(struct kthread_work *work)
> +{
> +	struct msm_ringbuffer *ring =3D container_of(work, struct msm_ringbuffe=
r, hangcheck_work);
> +	struct msm_gpu *gpu =3D ring->gpu;
> +	struct msm_drm_private *priv =3D gpu->dev->dev_private;
>  	struct drm_device *dev =3D gpu->dev;
> -	struct msm_ringbuffer *ring =3D gpu->funcs->active_ring(gpu);
>  	uint32_t fence =3D ring->memptrs->fence;
> =20
>  	if (fence !=3D ring->hangcheck_fence) {
> @@ -663,7 +686,7 @@ static void hangcheck_handler(struct timer_list *t)
>  		ring->hangcheck_fence =3D fence;
>  		ring->hangcheck_progress_retries =3D 0;
>  	} else if (fence_before(fence, ring->fctx->last_fence) &&
> -			!made_progress(gpu, ring)) {
> +			check_ring_timeout(ring, priv->hangcheck_period * 192000)) {

[Severity: Medium]
Since the always-on context counter ticks at 19.2 MHz (19,200 ticks per
millisecond), doesn't multiplying priv->hangcheck_period (in ms) by 192000
instead of 19200 make the timeout 10x longer than intended?

Also, since priv->hangcheck_period is an unsigned int and timeout is an
unsigned long, can priv->hangcheck_period * 192000 overflow 32-bit arithmet=
ic
when hangcheck_period is large or on 32-bit architectures?

>  		/* no progress and not done.. hung! */
>  		ring->hangcheck_fence =3D fence;
>  		ring->hangcheck_progress_retries =3D 0;
> @@ -674,17 +697,26 @@ static void hangcheck_handler(struct timer_list *t)
>  		DRM_DEV_ERROR(dev->dev, "%s:     submitted fence: %u\n",
>  				gpu->name, ring->fctx->last_fence);
> =20
> +		gpu->hung_ring =3D ring;
>  		kthread_queue_work(gpu->worker, &gpu->recover_work);
>  	}
> =20
>  	/* if still more pending work, reset the hangcheck timer: */
>  	if (fence_after(ring->fctx->last_fence, ring->hangcheck_fence))
> -		hangcheck_timer_reset(gpu);
> +		hangcheck_ring_timer_reset(gpu, ring);

[Severity: High]
Can check_ring_timeout() falsely declare a newly submitted job on a backgro=
und
ring hung before the GPU has switched to that ring?

msm_gpu_submit() arms ring->hangcheck_timer immediately on the CPU, whereas
ring->memptrs->last_job_start_ctx is only updated by the GPU when it execut=
es
the ring's command stream. If a higher-priority ring keeps the GPU busy whi=
le a
new submit is queued on a lower-priority ring, ring->hangcheck_timer will f=
ire
before the new submit's CP_REG_TO_MEM executes. check_ring_timeout() will t=
hen
read the stale last_job_start_ctx and last_active_ctxcycles left over from
previous work on that ring (or across a GPU suspend/reset where
last_active_ctxcycles was not cleared), and if their difference exceeded
timeout, trigger a false recovery.

In addition, when a hang is detected above, ring->hangcheck_fence is set to
fence (which is before ring->fctx->last_fence), so
fence_after(ring->fctx->last_fence, ring->hangcheck_fence) is true and
immediately re-arms ring->hangcheck_timer while recover_work is pending, an=
d a
 single gpu->hung_ring pointer can be overwritten if another ring's hangche=
ck
fires before recover_worker() runs.

[ ... ]

> @@ -923,8 +955,6 @@ int msm_gpu_init(struct drm_device *drm, struct platf=
orm_device *pdev,
>  	if (funcs->progress)
>  		priv->hangcheck_period /=3D 2;
> =20
> -	timer_setup(&gpu->hangcheck_timer, hangcheck_handler, 0);
> -

[Severity: High]
Removing timer_setup(&gpu->hangcheck_timer, ...) from msm_gpu_init() leaves
gpu->hangcheck_timer uninitialized in struct msm_gpu, but
a8xx_fault_detect_irq() and a8xx_sw_fuse_violation_irq() in
drivers/gpu/drm/msm/adreno/a8xx_gpu.c still call:

	timer_delete(&gpu->hangcheck_timer);
	kthread_queue_work(gpu->worker, &gpu->recover_work);

Won't triggering a fault or SW fuse violation on A8xx call timer_delete() o=
n an
uninitialized timer and fail to stop the per-ring hangcheck timers? Should
those A8xx handlers call msm_trigger_recovery(gpu) and struct msm_gpu drop =
the
unused hangcheck_timer field?

[ ... ]

> @@ -1006,6 +1036,9 @@ int msm_gpu_init(struct drm_device *drm, struct pla=
tform_device *pdev,
>  			goto fail;
>  		}
> =20
> +		timer_setup(&gpu->rb[i]->hangcheck_timer, hangcheck_handler, 0);
> +		kthread_init_work(&gpu->rb[i]->hangcheck_work, hangcheck_worker);
> +
>  		memptrs +=3D sizeof(struct msm_rbmemptrs);
>  		memptrs_iova +=3D sizeof(struct msm_rbmemptrs);
>  	}

[Severity: High]
Where are gpu->rb[i]->hangcheck_timer and gpu->rb[i]->hangcheck_work cancel=
led
during teardown?

In msm_gpu_cleanup() (and the fail path of msm_gpu_init()),
msm_ringbuffer_destroy(gpu->rb[i]) frees ring->fctx and schedules
kfree_rcu(ring, rcu), and msm_gem_kernel_put(gpu->memptrs_bo, gpu->vm) unma=
ps
and frees ring->memptrs before kthread_destroy_worker(gpu->worker) is calle=
d:

	for (i =3D 0; i < ARRAY_SIZE(gpu->rb); i++) {
		msm_ringbuffer_destroy(gpu->rb[i]);
		gpu->rb[i] =3D NULL;
	}

	msm_gem_kernel_put(gpu->memptrs_bo, gpu->vm);
	...
	if (gpu->worker) {
		kthread_destroy_worker(gpu->worker);
	}

If a ring's hangcheck_timer is still armed when the driver is unbound or
cleaned up, can hangcheck_handler() and hangcheck_worker() fire during or a=
fter
msm_ringbuffer_destroy() and cause a use-after-free on ring, ring->fctx, and
ring->memptrs (as well as a NULL pointer dereference on gpu->rb[i] in
msm_gpu_retire())?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-preemption=
_aware_hangcheck-v2-1-be0056e1f02d@gmail.com?part=3D1
