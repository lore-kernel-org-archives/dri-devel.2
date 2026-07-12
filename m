Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6767C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 15:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 068B010E4BD;
	Sun, 12 Jul 2026 15:32:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VdfxQIws";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3789E10E430
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 15:32:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CAA6F413EB;
 Sun, 12 Jul 2026 15:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879E41F000E9;
 Sun, 12 Jul 2026 15:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783870372;
 bh=zcPHkN7YRoSFIShAJM721c3FMKA93RMN6qUaYsRmlrw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VdfxQIwsrzdX46QXRNyMFFRsMBBiyQGu219210a74AlOGIZcgjDbDa0guQCII/FWa
 zbZOPpQD7/IELCJtZbz2E3EN/mdoHNAnjho/THe7hmUYk4Rn+nokRuRk4Do3voLeVd
 Tkh5NZIjSA9Y3UfnAZs2sIHzmhHyKcvMBCaegpTEthyuXxyl6XimI9fj/B7qjjqQvp
 iQfxlxB+F0qckiOGH9E1mXXMbL/8KwI1ko03D4qI6zhFEsCaE/O+L4ZSW43GhV0SZK
 2eQ8Z5zNXfg/9AkB20z6QEGzM/fcxyS61uGXU//b22igQY/aOWh5ibYL5swxHaqxfK
 eZIjkBAn+FeVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/8] drm/vc4: Add DRM GPU scheduler infrastructure
 and job structures
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260712-vc4-drm-scheduler-v3-3-ed6dc4defa53@igalia.com>
References: <20260712-vc4-drm-scheduler-v3-0-ed6dc4defa53@igalia.com>
 <20260712-vc4-drm-scheduler-v3-3-ed6dc4defa53@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 15:32:52 +0000
Message-Id: <20260712153252.879E41F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:

New issues:
- [Critical] `vc4_sched_init()` is never called, leading to a zero-initiali=
zed scheduler and a kernel panic.
- [High] Unsigned enum used as a reverse loop counter causes an infinite lo=
op and out-of-bounds access.
- [High] Dereferencing `bin->render` without checking for NULL causes a ker=
nel panic.
- [High] Race condition between concurrent multi-queue timeout handlers cau=
ses Use-After-Free.
- [High] Missing `dma_fence_put()` for `irq_fence` causes a steady memory l=
eak.
- [High] GFP_KERNEL memory allocations during GPU reset recovery cause dead=
locks.
- [Low] Missing definition of `vc4_job_cleanup` causing build failure.

Pre-existing issues:
- [High] Infinite loop in a command list extends the GPU timeout indefinite=
ly (DoS).
- [High] Hardware registers are accessed without guaranteeing the device is=
 successfully powered on.
--

--- Patch [3]: [PATCH v3 3/8] drm/vc4: Add DRM GPU scheduler infrastructure=
 and job structures ---
commit 823d1127ab669811483f871897f29bae5ea3a18f
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/vc4: Add DRM GPU scheduler infrastructure and job structures

Introduce struct vc4_job as the new base structure for GPU jobs, embedding
struct drm_sched_job for use with the DRM GPU scheduler. Add core scheduler
infrastructure in vc4_sched.c, implementing queue operations, timeout
handling, and job cleanup.

> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> --- a/drivers/gpu/drm/vc4/vc4_drv.c
> +++ b/drivers/gpu/drm/vc4/vc4_drv.c

[ ... ]

> @@ -155,15 +158,33 @@ static int vc4_open(struct drm_device *dev, struct =
drm_file *file)
>  		return -ENOMEM;
>  	vc4file->dev =3D vc4;
> =20
> +	for (q =3D 0; q < VC4_MAX_QUEUES; q++) {
> +		sched =3D &vc4->queue[q].sched;
> +		ret =3D drm_sched_entity_init(&vc4file->sched_entity[q],
> +					    DRM_SCHED_PRIORITY_NORMAL, &sched,
> +					    1, NULL);

[Severity: Critical]
Is it intentional that the DRM schedulers are initialized against a
zero-initialized structure?

I see vc4_sched_init() is implemented in vc4_sched.c but it never seems to
be called during driver setup. If vc4->queue[q].sched is completely
zero-initialized, doesn't opening and then closing a file trigger a NULL
pointer dereference in vc4_close() when calling
drm_sched_entity_destroy() due to the uninitialized wait queues?

> +		if (ret)
> +			goto err_sched;
> +	}
> +
>  	vc4_perfmon_open_file(vc4file);
>  	file->driver_priv =3D vc4file;
> +
>  	return 0;
> +
> +err_sched:
> +	for (q--; q >=3D 0; q--)
> +		drm_sched_entity_destroy(&vc4file->sched_entity[q]);

[Severity: High]
Will this loop ever terminate on failure?

Since q is of type enum vc4_queue, the compiler will likely treat it as
an unsigned integer type. If the first allocation fails (q =3D 0), wouldn't
q-- underflow to the maximum unsigned value, making q >=3D 0 always true
and leading to an out-of-bounds access and infinite loop?

> diff --git a/drivers/gpu/drm/vc4/vc4_fence.c b/drivers/gpu/drm/vc4/vc4_fe=
nce.c
> --- a/drivers/gpu/drm/vc4/vc4_fence.c
> +++ b/drivers/gpu/drm/vc4/vc4_fence.c
> @@ -23,6 +23,24 @@
> =20
>  #include "vc4_drv.h"
> =20
> +struct dma_fence *vc4_fence_create(struct vc4_dev *vc4, enum vc4_queue q)
> +{
> +	struct vc4_queue_state *queue =3D &vc4->queue[q];
> +	struct vc4_fence *fence;
> +
> +	fence =3D kzalloc_obj(*fence);

[Severity: High]
Can this memory allocation cause a deadlock during GPU reset?

When the GPU hangs, the timeout handler calls drm_sched_resubmit_jobs()
which invokes the run_job callbacks. If vc4_fence_create() is called in
this path and implicitly uses GFP_KERNEL (via kzalloc_obj), memory
reclaim might block waiting for fences from the already hung GPU,
preventing the reset from ever completing.

> diff --git a/drivers/gpu/drm/vc4/vc4_sched.c b/drivers/gpu/drm/vc4/vc4_sc=
hed.c
> --- /dev/null
> +++ b/drivers/gpu/drm/vc4/vc4_sched.c

[ ... ]

> +static void
> +vc4_sched_job_free(struct drm_sched_job *sched_job)
> +{
> +	struct vc4_job *job =3D to_vc4_job(sched_job);
> +
> +	vc4_job_cleanup(job);
> +}

[Severity: Low]
Will this compile successfully?

The function vc4_job_cleanup() is called here but it does not appear to
be defined anywhere in this patch or the surrounding code.

[ ... ]

> +static struct dma_fence *vc4_bin_job_run(struct drm_sched_job *sched_job)
> +{

[ ... ]

> +	/* Release the previous fence if the scheduler is resubmitting this
> +	 * job after a GPU reset.
> +	 */
> +	if (job->base.irq_fence)
> +		dma_fence_put(job->base.irq_fence);
> +	job->base.irq_fence =3D dma_fence_get(fence);

[Severity: High]
Does this code leak the extra dma_fence reference?

We acquire an extra reference here with dma_fence_get() in both the bin
and render job paths, but I don't see a corresponding dma_fence_put() in
the job teardown paths. Doesn't this mean every executed job permanently
leaks a fence?

[ ... ]

> +static void
> +vc4_reset(struct drm_device *dev)
> +{
> +	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
> +
> +	drm_err(dev, "Resetting GPU.\n");
> +
> +	mutex_lock(&vc4->power_lock);
> +	if (vc4->power_refcount) {
> +		/* Power the device off and back on the by dropping the
> +		 * reference on runtime PM.
> +		 */
> +		pm_runtime_put_sync_suspend(&vc4->v3d->pdev->dev);
> +		pm_runtime_get_sync(&vc4->v3d->pdev->dev);

[Severity: High]
This is a pre-existing issue, but shouldn't we check the return value of
pm_runtime_get_sync() here?

If the device fails to resume, it remains powered off. The function then
proceeds to call vc4_irq_reset() which performs MMIO writes to V3D_INTCTL
and V3D_INTENA. Writing to unclocked hardware typically triggers bus
errors and a kernel crash.

> +	}
> +	mutex_unlock(&vc4->power_lock);
> +
> +	vc4_irq_reset(dev);
> +}
> +
> +static enum drm_gpu_sched_stat
> +vc4_gpu_reset_for_timeout(struct vc4_dev *vc4, struct drm_sched_job *sch=
ed_job)
> +{
> +	struct vc4_job *job =3D to_vc4_job(sched_job);
> +	enum vc4_queue q;
> +
> +	mutex_lock(&vc4->reset_lock);

[Severity: High]
Can this mutex_lock() race with a concurrent timeout handler?

VC4 has separate schedulers for the BIN and RENDER queues. If jobs on
both queues time out simultaneously, Thread A might acquire the lock,
reset the GPU, restart both schedulers, and unlock.

Thread B would block here. Once Thread A releases the lock, Thread B
wakes up and proceeds to use sched_job. However, since Thread A already
restarted the schedulers, the RENDER scheduler could immediately execute
and complete Thread B's job, freeing it.

Wouldn't this cause a use-after-free when Thread B finally acquires the
lock and dereferences sched_job below?

> +
> +	/* block scheduler */
> +	for (q =3D 0; q < VC4_MAX_QUEUES; q++)
> +		drm_sched_stop(&vc4->queue[q].sched, sched_job);
> +
> +	if (sched_job) {
> +		drm_sched_increase_karma(sched_job);
> +
> +		/* If the guilty job is a BIN job, also increase the karma
> +		 * of its paired render job. Otherwise, the RENDER job would
> +		 * be submitted to the GPU without binner output.
> +		 */
> +		if (sched_job->sched =3D=3D &vc4->queue[VC4_BIN].sched) {
> +			struct vc4_bin_job *bin =3D to_bin_job(sched_job);
> +
> +			drm_sched_increase_karma(&bin->render->base.base);

[Severity: High]
Can bin->render be NULL here?

If userspace submits a job that only has a BIN component, or if the
RENDER job allocation failed prior to submission, won't dereferencing
bin->render->base.base result in a kernel panic?

[ ... ]

> +static enum drm_gpu_sched_stat
> +vc4_cl_job_timedout(struct drm_sched_job *sched_job, enum vc4_queue q)
> +{
> +	struct vc4_job *job =3D to_vc4_job(sched_job);
> +	struct vc4_dev *vc4 =3D job->vc4;
> +	u32 ctca =3D V3D_READ(V3D_CTNCA(q));
> +	u32 ctra =3D V3D_READ(V3D_CTNRA0(q));
> +
> +	/* If the current address or return address have changed, then the GPU
> +	 * has probably made progress and we should delay the reset. This could
> +	 * fail if the GPU got in an infinite loop in the CL, but that is pretty
> +	 * unlikely outside of an i-g-t testcase.
> +	 */
> +	if (job->timedout_ctca !=3D ctca || job->timedout_ctra !=3D ctra) {

[Severity: High]
This is a pre-existing issue, but does this logic safely handle infinite
loops in command lists?

It assumes any change in the execution address means forward progress. If
an unprivileged user submits a command list with a backward branch, the
execution address will constantly change. Won't this cause the timeout
handler to infinitely defer the reset, resulting in a permanent GPU
lockup and a denial of service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-vc4-drm-sc=
heduler-v3-0-ed6dc4defa53@igalia.com?part=3D3
