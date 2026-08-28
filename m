Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F141C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 21:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4924610E528;
	Fri, 28 Aug 2026 21:16:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AJ2qkeYK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C031A10E528
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 21:16:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 601E742DCF;
 Fri, 28 Aug 2026 21:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B2A1F000E9;
 Fri, 28 Aug 2026 21:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787951763;
 bh=N0/44Xac5HHpil4gla1sbF+KXC4uaSrAy0t5Bj37HqQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AJ2qkeYKFKqN+higVTo/djjYQkXgfA5H+USd+zeLcDDc+L5A6nyVsLvy/rZzsLMLc
 2t9EfE2C2WR5uHW8tmsWRgaOTQsb5bmIFAdXhHO2Znxwq8RIWDE9elEF7ipE0DvDNc
 mnugFq/WNRGcqh0MCMCpiyaJ+tEv/8A7ZvVVC1oSpxEp5R/bvxBJwNBiPh1UX017Q7
 YCqfB0jzdIarxF6k30bgFZcJtr2MTCgyImzggEwVTjcHRQdmdng6vz6jn38ORDqR9z
 hzGd4Motxib16Aj2Cde7xrWo4/nbJUPvgJO/bDpmgdEBEtCWOTKSht6OBWBAB7qzC1
 1jxV7GxpKukyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/17] drm/panfrost: Stop all jobs before commencing
 device teardown
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828-claude-fixes-v7-7-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-7-72a13b2c125d@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 21:16:02 +0000
Message-Id: <20260828211603.22B2A1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] panfrost_stop_jobs() unintentionally commands the hardware to =
restart pending jobs during device teardown, leading to GPU execution with =
freed memory and unmapped page tables.
- [High] Jobs aborted during device teardown are never signaled or properly=
 freed, causing a memory leak and permanently hanging userspace waiters.
- [High] Scheduler timeout handler (work_tdr) is not canceled when schedule=
rs are stopped during teardown, allowing a concurrent TDR to resuscitate th=
e device mid-teardown.

Pre-existing issues:
- [High] Concurrent executions of panfrost_reset() from multiple scheduler =
timeouts corrupt the scheduler pending list.
- [High] Sleeping functions called from DMA fence signalling path during pa=
nfrost_reset.
--

commit bbe9e4a95112d42e26f093db1d29071e85c60996
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
Subject: drm/panfrost: Stop all jobs before commencing device teardown

This patch ensures that no jobs are inflight at the time the driver finishes
its structures and synchronizes IRQs. To achieve this, it halts submissions
from existing scheduler entities and forces the hardware to soft-stop all
running jobs during device teardown.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 9549ddb7854a3..9e02fb5f73c82 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -341,6 +341,8 @@ void panfrost_device_fini(struct panfrost_device *pfd=
ev)
>  	pm_runtime_get_sync(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
> =20
> +	panfrost_jm_stop_sched_jobs(pfdev);
> +

[Severity: High]
Does this code leak the job structures and GEM references while permanently
hanging userspace waiters?

This adds a call to soft-stop inflight jobs during device teardown without
providing a mechanism to signal their fences. The interrupt handler skips
signaling the fence for soft-stopped jobs (signal_fence =3D false), expecti=
ng
a reset. Stuck jobs are erased from driver state via memset, but panfrost
does not implement the cancel_job callback in drm_sched_backend_ops.

Since they are abandoned on the scheduler's pending_list without being freed
or having their fences signaled, any teardown of the device while jobs are
in flight will trigger this leak and hang.

>  	panfrost_gem_fini(pfdev);
>  	panfrost_perfcnt_fini(pfdev);

[ ... ]

> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index 5016d2d53da26..630298b7ea8a5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c

[ ... ]

> +void panfrost_jm_stop_sched_jobs(struct panfrost_device *pfdev)
> +{
> +	for (u32 i =3D 0; i < NUM_JOB_SLOTS; i++)
> +		drm_sched_wqueue_stop(&pfdev->js->queue[i].sched);
> +

[Severity: High]
Does this create a race window where the timeout handler can execute
concurrently mid-teardown?

The stop logic uses drm_sched_wqueue_stop() which pauses submit queues, but
fails to cancel the delayed timeout work (work_tdr). If the timeout expires
before teardown reaches panfrost_jm_fini(), panfrost_job_timedout() executes
concurrently and triggers a GPU reset. The reset sequence unconditionally
invokes drm_sched_start() and re-enables hardware interrupts, forcing the
GPU and schedulers to resume execution while panfrost_device_fini() destroys
underlying memory and structures.

> +	panfrost_stop_jobs(pfdev);
> +}
> +

[Severity: Critical]
Does panfrost_stop_jobs() unintentionally command the hardware to restart
pending jobs during device teardown?

This new teardown function reuses the reset path's soft-stop mechanism
without setting reset.pending. During teardown, the resulting IRQ is handled
by panfrost_jm_handle_irq(). Because this is a teardown and not a GPU reset,
pfdev->reset.pending is 0.=20

The handler logic unconditionally sees !atomic_read(&pfdev->reset.pending)
and writes JS_COMMAND_START to launch the next queued job. The GPU hardware
resumes executing jobs while panfrost_device_fini() concurrently frees all
backing structures, leading to GPU execution with freed memory and unmapped
page tables.

> +static void
> +panfrost_reset(struct panfrost_device *pfdev,
> +	       struct drm_sched_job *bad)
> +{
> +	unsigned int i;
> +	bool cookie;
> +
> +	if (!atomic_read(&pfdev->reset.pending))
> +		return;
> +
> +	/* Stop the schedulers.
> +	 *
> +	 * FIXME: We temporarily get out of the dma_fence_signalling section
> +	 * because the cleanup path generate lockdep splats when taking locks
> +	 * to release job resources. We should rework the code to follow this
> +	 * pattern:
> +	 *
> +	 *	try_lock
> +	 *	if (locked)
> +	 *		release
> +	 *	else
> +	 *		schedule_work_to_release_later
> +	 */
> +	for (i =3D 0; i < NUM_JOB_SLOTS; i++)
> +		drm_sched_stop(&pfdev->js->queue[i].sched, bad);
> +

[Severity: High]
This is a pre-existing issue, but can concurrent executions of
panfrost_reset() from multiple scheduler timeouts corrupt the scheduler
pending list?

Panfrost uses multiple independent DRM schedulers (one per job slot). If
multiple slots timeout simultaneously (e.g. due to a global GPU hang),
multiple work_tdr works fire concurrently. They enter panfrost_job_timedout=
()
which calls atomic_set(&pfdev->reset.pending, 1) rather than an atomic
exchange.

Both threads bypass the !atomic_read() exclusion check here and concurrently
invoke drm_sched_stop(). Since drm_sched_stop() manipulates
sched->pending_list without internal locks for list_add, the concurrent
modifications corrupt the list.

> +	cookie =3D dma_fence_begin_signalling();
> +
> +	if (bad)
> +		drm_sched_increase_karma(bad);
> +
> +	panfrost_stop_jobs(pfdev);

[Severity: High]
This isn't a bug introduced by this patch (the code was simply refactored
into a helper), but does this invoke sleeping functions from the DMA fence
signalling path?

dma_fence_begin_signalling() enters a critical section where sleeping is
strictly forbidden. Immediately afterward, panfrost_stop_jobs() is called,
which invokes synchronize_irq() (which can block waiting for IRQ handlers)
and readl_poll_timeout() (which sleeps via usleep_range()).

> =20
>  	/* Proceed with reset now. */
>  	panfrost_device_reset(pfdev, false);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-claude-fix=
es-v7-0-72a13b2c125d@collabora.com?part=3D7
