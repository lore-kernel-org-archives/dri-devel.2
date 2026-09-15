Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6507DC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC7C010E08E;
	Tue, 15 Sep 2026 18:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VoYPMZoX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECDE810E08E
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 18:34:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B416543D7D;
 Tue, 15 Sep 2026 18:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1CC1F00893;
 Tue, 15 Sep 2026 18:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789497273;
 bh=eELp8ums8QqZ8J4s+mPiGbqZuKh/YbZF3tcpjDwE5C8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VoYPMZoXrECziDS621vUgkZxjB8n2WDzK0P/b0U/bSeIliftjh/IBog0DZ9oZ4mw+
 lRn3KRf+X/wVtauhO8OrSHCyjwjTnr6RGWqjAHjp7pM1ru5c51RNr2rx4P+Y/kA1Ee
 lCUUe+tG9V4SFM8U/tb5woXCI2ToZQZucgyiU7EUu4SG3LV4quBX+YfFd+wopiHqeZ
 Mlf1TRGwxX1l67jWnAYk6wKK5726vtcxP24+VJUXmaOGu2exL+HhSJ9khsHfnhZIML
 UZANsW8aBJ2FUTpnlBch+6H4+Vwm6511Swaak2YDYGWoAuBR0WDdjYj+pznCL4xUDl
 hWZl4IJAi/oxg==
Date: Tue, 15 Sep 2026 13:34:31 -0500
From: Rob Herring <robh@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 01/22] accel: ethosu: Suspend after initialization
Message-ID: <20260915183431.GC1926857-robh@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
 <20260908-ethosu-fixes-v3-1-490fe215286f@kernel.org>
 <20260908221807.330411F00A3A@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908221807.330411F00A3A@smtp.kernel.org>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Sep 08, 2026 at 10:18:06PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Hardware Access in IRQ Handler
> - [High] TOCTOU race on `dev->in_flight_job` between the IRQ handler and the timeout worker causes job tracking corruption
> - [Medium] Missing pm_runtime_mark_last_busy() defeats autosuspend functionality
> --
> 
> commit 70e7c7d4b9e3f59284be594e6021ace41a2927aa
> Author: Rob Herring (Arm) <robh@kernel.org>
> 
> accel: ethosu: Suspend after initialization
> 
> The initial runtime-PM reference is held only while initializing the
> NPU. Release it synchronously from ethosu_init() after the final
> hardware access, before registering the DRM device.
> 
> > diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
> > index 8108622de258f..df76253d01a64 100644
> > --- a/drivers/accel/ethosu/ethosu_drv.c
> > +++ b/drivers/accel/ethosu/ethosu_drv.c
> > @@ -338,6 +338,8 @@ static int ethosu_init(struct ethosu_device *ethosudev)
> >  		 ethosudev->npu_info.sram_size / 1024,
> >  		 ethosudev->npu_info.pmu_counters);
> >  
> > +	pm_runtime_put_sync_suspend(ethosudev->base.dev);
> > +
> >  	return 0;
> >  }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does explicitly disabling the
> NPU clocks here expose a risk of crashing in the IRQ handler?
> 
> If a spurious interrupt occurs while the device is suspended, the IRQ handler
> will unconditionally read from the unclocked NPU registers:
> 
> drivers/accel/ethosu/ethosu_job.c:ethosu_job_irq_handler() {
> 	struct ethosu_device *dev = data;
> 	u32 status = readl_relaxed(dev->regs + NPU_REG_STATUS);
> 
> 	if (!(status & STATUS_IRQ_RAISED))
> 		return IRQ_NONE;
> 	...
> }
> 
> Subsystem guidelines mandate that IRQ handlers use pm_runtime_get_if_active()
> to verify the device is powered on before accessing any registers. Accessing
> memory-mapped registers of an unclocked device typically triggers a
> synchronous bus fault or asynchronous external abort, resulting in a system
> crash.


Not an issue as explained before.

> 
> [ ... ]
> 
> [Severity: High]
> This is a pre-existing issue, but can the timeout worker and IRQ handler race
> and corrupt the job tracking?
> 
> ethosu_job_handle_irq() reads dev->in_flight_job without locking:
> 
> drivers/accel/ethosu/ethosu_job.c:ethosu_job_handle_irq() {
> 	...
> 	job = READ_ONCE(dev->in_flight_job);
> 	if (job) {
> 		WRITE_ONCE(dev->in_flight_job, NULL);
> 		dma_fence_signal(job->done_fence);
> 	}
> }
> 
> Concurrently, ethosu_job_timedout() can run in a workqueue, stop the scheduler,
> and modify the state without locking:
> 
> drivers/accel/ethosu/ethosu_job.c:ethosu_job_timedout() {
> 	...
> 	drm_sched_stop(&dev->sched, bad);
> 
> 	WRITE_ONCE(dev->in_flight_job, NULL);
> 
> 	/* Proceed with reset now. */
> 	pm_runtime_force_suspend(dev->base.dev);
> 	pm_runtime_force_resume(dev->base.dev);
> 
> 	/* Restart the scheduler */
> 	drm_sched_start(&dev->sched, 0);
> 	...
> }
> 
> If the scheduler immediately pushes a new job, updating dev->in_flight_job,
> could the preempted IRQ thread resume and blindly execute
> WRITE_ONCE(dev->in_flight_job, NULL), overwriting the new job's tracking?
> 
> When the new job completes, the IRQ handler would read NULL and fail to signal
> its fence, causing a perfectly valid job to falsely time out and trigger an
> unnecessary hardware reset loop.

This may be an issue, but isn't related at all to this patch. Will 
investigate more.

> 
> [Severity: Medium]
> This is a pre-existing issue, but does this autosuspend implementation actually
> delay powering down the NPU?
> 
> In ethosu_job_cleanup(), the driver drops the runtime PM reference:
> 
> drivers/accel/ethosu/ethosu_job.c:ethosu_job_cleanup() {
> 	struct ethosu_job *job = container_of(ref, struct ethosu_job,
> 						refcount);
> 
> 	pm_runtime_put_autosuspend(job->dev->base.dev);
> 	...
> }
> 
> Since pm_runtime_mark_last_busy() is never called, the autosuspend timer
> evaluates from the beginning of the active PM transition rather than its
> completion.
> 
> Will the old last_busy timestamp cause the autosuspend delay to evaluate as
> already expired, defeating the autosuspend mechanism and leading to excessive
> hardware power cycling?

No, according to the documentation:

Documentation/power/runtime_pm.rst:  `int pm_runtime_put_autosuspend(struct device *dev);`
Documentation/power/runtime_pm.rst-    - set the power.last_busy field to the current time and decrement the
Documentation/power/runtime_pm.rst-      device's usage counter; if the result is 0 then run
Documentation/power/runtime_pm.rst-      pm_request_autosuspend(dev) and return its result

pm_runtime_put_autosuspend() will update last_busy, so no issue here.

Rob

