Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028A8606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTo5uL35
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 675FE112341;
	Thu, 29 Oct 2026 14:25:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA74F112341
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:25:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2DED160210
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFED91F01825;
 Thu, 29 Oct 2026 14:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793283930;
 bh=79+rVxRtxlsemPcTzS1JEmywOExrPF2tczxAROLLj4g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fTo5uL35B/sE4i1cB/vGiTY1gn9yNHTa//XbKt2Xsa5gC3FQWsrKBhtDgnm0thEUm
 HHuaN+Gz1LYt7PDSX9RVLK93Run8zjWTw+I14ZP+jlVbcfh26Es6moRKr3Jy56PK32
 JV/hbLCsSefgAX5tLOeggLGpFEtNfzRBXQnnDHpAUE4XAv36R2BkWwd4AT+3c7SaLa
 zYuR28JKWze7kHIWSAH1LUy3UgxdjxJ+3jascFNqZus2HKAV2BKaMdl3cV0QN25U4G
 dmirA3SYXXBsVum8lr7XI9UGy53M3FIDuYKI4CVL4ULugY1TtZkIPvbmIzvJ7hLpiS
 D1tR+eyd1NkQQ==
Message-ID: <sashiko-outbox-189511@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/31] accel: ethosu: Serialize job completion
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-ethosu-fixes-v4-8-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
 <20261029-ethosu-fixes-v4-8-4aa25e22578e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:25:30 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] accel: ethosu: broken reset error path in ethosu_job_timedout()
- [High] accel: ethosu: synchronize_irq() after clock disable in ethosu_job=
_timedout()
- [Medium] accel: ethosu: race in ethosu_job_timedout() clears next job in_=
flight_job
- [Low] accel: ethosu: missing job_lock member in struct ethosu_device
--

commit a2791ceca00bb04bd66b56abb41eced27fba55c3
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Serialize job completion

This commit adds spinlock helpers around in_flight_job updates and drains
pending completion IRQs during timeout recovery so a late completion cannot
overwrite the tracking pointer of a newly scheduled job.

> diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/=
ethosu_device.h
> index 1eca8590e68d4..51d5bc5d6137d 100644
> --- a/drivers/accel/ethosu/ethosu_device.h
> +++ b/drivers/accel/ethosu/ethosu_device.h
> @@ -7,6 +7,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
>  #include <linux/mutex.h>
> +#include <linux/spinlock.h>
>  #include <linux/types.h>
> =20
>  #include <drm/drm_device.h>

[Severity: Low]
Does this commit fail to build when CONFIG_DRM_ACCEL_ARM_ETHOSU is enabled?

This patch includes linux/spinlock.h in drivers/accel/ethosu/ethosu_device.h
and uses dev->job_lock in ethosu_job_set_in_flight(),
ethosu_job_clear_in_flight(), and ethosu_job_init(), but struct ethosu_devi=
ce
does not declare job_lock yet:

drivers/accel/ethosu/ethosu_device.h:
	struct ethosu_job *in_flight_job;

	/* For dma_fence */
	spinlock_t fence_lock;

The spinlock_t job_lock member declaration appears to have been placed in a
later commit in the series, commit b4de18ee902b ("accel: ethosu: Keep
scheduler after unplug"), which breaks compilation and git bisectability at
this commit. Should the job_lock declaration in struct ethosu_device be mov=
ed
into this patch?

> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/eth=
osu_job.c
> index d418ae7961cff..f22cacb19e3dc 100644
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c
> @@ -42,6 +42,25 @@ static const struct dma_fence_ops ethosu_fence_ops =3D=
 {
>  	.get_timeline_name =3D ethosu_fence_get_timeline_name,
>  };
> =20
> +static void ethosu_job_set_in_flight(struct ethosu_device *dev,
> +				     struct ethosu_job *job)
> +{
> +	guard(spinlock)(&dev->job_lock);
> +	dev->in_flight_job =3D job;
> +}
> +
> +static struct ethosu_job *
> +ethosu_job_clear_in_flight(struct ethosu_device *dev)
> +{
> +	struct ethosu_job *job;
> +
> +	guard(spinlock)(&dev->job_lock);
> +	job =3D dev->in_flight_job;
> +	dev->in_flight_job =3D NULL;
> +
> +	return job;
> +}

[ ... ]

> @@ -311,11 +329,19 @@ static enum drm_gpu_sched_stat ethosu_job_timedout(=
struct drm_sched_job *bad)
> =20
>  	drm_sched_stop(&dev->sched, bad);
> =20
> -	WRITE_ONCE(dev->in_flight_job, NULL);
> +	ethosu_job_clear_in_flight(dev);

[Severity: Medium]
Can ethosu_job_timedout() still clear the next job's in_flight_job pointer
and reset the NPU while a newly submitted job is running?

When work_tdr calls drm_sched_job_timedout(), the timed-out job (bad) is
removed from sched->pending_list before ethosu_job_timedout(bad) is invoked,
while sched->submit_wq remains active until drm_sched_stop() is called:

ethosu_job_timedout()
  cmdaddr =3D readl_relaxed(dev->regs + NPU_REG_QREAD);
  running =3D FIELD_GET(STATUS_STATE_RUNNING, ...);
  if (running)
    readl_relaxed_poll_timeout(...);
  dev_err(...);
  drm_sched_stop(&dev->sched, bad);
  ethosu_job_clear_in_flight(dev);

If bad completes just before NPU_REG_STATUS is read (so running is false) or
right after readl_relaxed_poll_timeout() expires while dev_err() is running,
ethosu_job_irq_handler_thread()->ethosu_job_handle_irq() clears
dev->in_flight_job and signals bad->done_fence.

Signaling bad->done_fence runs drm_sched_job_done_cb()->drm_sched_job_done(=
),
which decrements sched->credit_count and queues work_free_job and
drm_sched_run_job_work(). Because drm_sched_stop() has not been called yet,
drm_sched_run_job_work()->ethosu_job_run() can set dev->in_flight_job to the
next job and submit it to the hardware.

When ethosu_job_timedout() then calls drm_sched_stop(&dev->sched, bad) and
ethosu_job_clear_in_flight(dev), wouldn't it unconditionally clear the new
job's dev->in_flight_job pointer, reset the NPU underneath it, and cancel t=
he
new job during drm_sched_start(&dev->sched, 0)?

>  	/* Proceed with reset now. */
> -	pm_runtime_force_suspend(dev->base.dev);
> -	pm_runtime_force_resume(dev->base.dev);
> +	ret =3D pm_runtime_force_suspend(dev->base.dev);
> +	if (!ret)
> +		ret =3D pm_runtime_force_resume(dev->base.dev);
> +	if (ret) {
> +		dev_err(dev->base.dev, "Failed to recover NPU: %d\n", ret);
> +		return DRM_GPU_SCHED_STAT_ENODEV;
> +	}

[Severity: High]
What happens on this error path if CONFIG_PM_SLEEP is disabled, or if
pm_runtime_force_suspend() or pm_runtime_force_resume() fails?

First, DRM_ACCEL_ARM_ETHOSU does not depend on CONFIG_PM_SLEEP. When
CONFIG_PM_SLEEP is disabled, pm_runtime_force_resume() in
include/linux/pm_runtime.h is a stub that unconditionally returns -ENXIO:

static inline int pm_runtime_force_suspend(struct device *dev) { return 0; }
static inline int pm_runtime_force_resume(struct device *dev) { return -ENX=
IO; }

When CONFIG_PM=3Dy and CONFIG_PM_SLEEP=3Dn, pm_runtime_force_suspend() disa=
bles
runtime PM and calls ethosu_device_suspend() to turn off the clocks, and th=
en
pm_runtime_force_resume() returns -ENXIO, causing every timeout recovery to
fail with the NPU left suspended.

Second, before this check, ethosu_job_timedout() calls
drm_sched_stop(&dev->sched, bad), which removes &bad->cb from
bad->s_fence->parent (job->done_fence) and sets bad->s_fence->parent =3D NU=
LL.
Returning DRM_GPU_SCHED_STAT_ENODEV here skips drm_sched_start(&dev->sched,=
 0),
which would otherwise see s_job->s_fence->parent =3D=3D NULL and call
drm_sched_job_done(s_job, -ECANCELED) to signal bad->s_fence->finished
(job->inference_done_fence).

Even during subsequent teardown in ethosu_job_fini()->drm_sched_fini(),
ethosu_job_cancel() only signals job->done_fence:

static void ethosu_job_cancel(struct drm_sched_job *sched_job)
{
	struct ethosu_job *job =3D to_ethosu_job(sched_job);

	if (dma_fence_was_initialized(job->done_fence) &&
	    !dma_fence_is_signaled(job->done_fence)) {
		dma_fence_set_error(job->done_fence, -ECANCELED);
		dma_fence_signal(job->done_fence);
	}
}

Because drm_sched_stop() already detached &bad->cb from job->done_fence,
signaling job->done_fence will not signal bad->s_fence->finished. Wouldn't
that leave bad->s_fence->finished permanently unsignaled, hanging callers in
ethosu_ioctl_bo_wait() and drm_sched_entity_kill() and triggering a warning=
 in
dma_fence_release() when ethosu_job_free() frees the job?

> +
> +	/* Drain a pending completion IRQ before a replacement job can run. */
> +	synchronize_irq(dev->irq);

[Severity: High]
Is calling synchronize_irq(dev->irq) after pm_runtime_force_suspend() safe =
if
an IRQ is already in flight?

Both ethosu_job_irq_handler() and
ethosu_job_irq_handler_thread()->ethosu_job_handle_irq() read NPU_REG_STATUS
from dev->regs:

static void ethosu_job_handle_irq(struct ethosu_device *dev)
{
	u32 status =3D readl_relaxed(dev->regs + NPU_REG_STATUS);
	struct ethosu_job *job;

	if (status & (STATUS_BUS_STATUS | STATUS_CMD_PARSE_ERR)) {
		dev_err(dev->base.dev, "Error IRQ - %x\n", status);
		drm_sched_fault(&dev->sched);
		return;
	}

In ethosu_job_timedout(), pm_runtime_force_suspend(dev->base.dev) runs
ethosu_device_suspend()->clk_bulk_disable_unprepare() before
synchronize_irq(dev->irq) is called (and synchronize_irq() is skipped entir=
ely
if the suspend/resume check returns early).

If an interrupt fires concurrently with ethosu_job_timedout(), could
ethosu_job_irq_handler() or ethosu_job_handle_irq() read NPU_REG_STATUS whi=
le
the NPU clocks are disabled during the window between
pm_runtime_force_suspend() and pm_runtime_force_resume(), or call
drm_sched_fault(&dev->sched) after drm_sched_stop() cancelled sched->work_t=
dr?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-ethosu-fix=
es-v4-0-4aa25e22578e@kernel.org?part=3D8
