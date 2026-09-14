Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8F8C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 02:34:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 735B010EAF6;
	Mon, 14 Sep 2026 02:34:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vvz6QRrZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F188510EAF6
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 02:34:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B52EF43216;
 Mon, 14 Sep 2026 02:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD581F000FF;
 Mon, 14 Sep 2026 02:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789353267;
 bh=qnrDFO7ha3ce4eIf1IynrJ8kO11XHJs+Twz3WIO8reA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vvz6QRrZLQdyyhXJIuvuAqvwAYIAZqSiYWcazOSftSwhLmAgyMVIvTmvdu0HKuM+Q
 UwVMVHTXDo80nRxllCc+5aEjvVOlOIAkRRriROhX84e1d7DpU0PURJFlH70jOya36N
 caFdySOOJh0VX9odJP1fClwlDNTF1SYY8S5y1gZcwMJhspGqznbJ2s+r1Ov+/677MM
 zDoOnE3qQy2+dsYOqylyLgZB6EMvCQ3w3ckpVptjNOEDk55JV+lJkwUTpyu+paiOf6
 tMKyOckbmaZ0GNHShSeWydE+RXmbJ8MxMisaKID+Il7Nx34ISZ9hcfVVsWPSYkwGJ6
 RXQ+ghgdIeeEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] drm/imagination: stop the watchdog before
 tearing the device down
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-3-674b907d0652@gmail.com>
References: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-0-674b907d0652@gmail.com>
 <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-3-674b907d0652@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 02:34:26 +0000
Message-Id: <20260914023427.6DD581F000FF@smtp.kernel.org>
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
- [High] Moving pvr_watchdog_fini() before drm_dev_unplug() creates a race =
where concurrent IOCTLs can trigger a PM resume and re-queue the watchdog w=
ork after it has been cancelled.

Pre-existing issues:
- [Critical] pvr_remove() ignores the return value of pm_runtime_suspend() =
and frees firmware memory while the GPU hardware may still be running.
- [Critical] Inverted teardown order in pvr_remove() destroys the scheduler=
 workqueue after firmware structures are freed, causing pending jobs to exe=
cute against freed memory.
- [High] Use-after-free of pvr_dev and sched_wq when a dma_fence outlives t=
he DRM device.
- [High] Concurrent calls to drm_dev_unplug() due to TOCTOU race on the non=
-atomic pvr_dev->lost flag.
--

commit 34ac43451671ac25507b846dc7e38412b5318f2e
Author: Ryan Brue <ryanbrue.dev@gmail.com>
drm/imagination: stop the watchdog before tearing the device down

This commit moves the watchdog finalization to the beginning of device
removal, aiming to prevent the worker from reading freed memory if it
fires during teardown.

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imag=
ination/pvr_drv.c
> index fc92a82a72084..20b27a468327b 100644
> --- a/drivers/gpu/drm/imagination/pvr_drv.c
> +++ b/drivers/gpu/drm/imagination/pvr_drv.c
> @@ -1469,6 +1469,9 @@ static void pvr_remove(struct platform_device *plat=
_dev)
>  	struct drm_device *drm_dev =3D platform_get_drvdata(plat_dev);
>  	struct pvr_device *pvr_dev =3D to_pvr_device(drm_dev);
> =20
> +	/* Stop the watchdog before anything it reads is freed. */
> +	pvr_watchdog_fini(pvr_dev);
> +

[Severity: High]
Can a concurrent ioctl re-arm the watchdog right after it is cancelled?

Since drm_dev_unplug() has not blocked ioctls yet, an incoming job
submission could call pm_runtime_resume_and_get(), triggering
pvr_power_fw_enable().

Looking at drivers/gpu/drm/imagination/pvr_power.c:pvr_power_fw_enable():

    queue_delayed_work(pvr_dev->sched_wq, &pvr_dev->watchdog.work,
                       msecs_to_jiffies(WATCHDOG_TIME_MS));

If this occurs, the work is re-queued. Later in pvr_remove(), if
pm_runtime_suspend() fails (returning -EAGAIN) due to the elevated usage
count, the watchdog is never cancelled again and could fire after
pvr_device_fini() frees the firmware memory.

>  	/*
>  	 * Unplug before freeing anything, so no ioctl is still inside
>  	 * drm_dev_enter(). pvr_device_lost() may already have done it, and
>  	 * drm_dev_unplug() is not idempotent.
>  	 */
>  	if (!pvr_dev->lost)
>  		drm_dev_unplug(drm_dev);

[Severity: High]
This is a pre-existing issue, but does checking this non-atomic flag
without locking create a race condition with pvr_device_lost()?

If a hardware timeout (e.g., from an MMU cache flush via
pvr_mmu_flush_exec) concurrently triggers pvr_device_lost() in pvr_power.c,
both threads might check !pvr_dev->lost at the exact same time, evaluate it
as true, and both call drm_dev_unplug().

Since drm_dev_unplug() is not idempotent, couldn't this result in a double
unregister kernel panic?

> =20
>  	WARN_ON(!xa_empty(&pvr_dev->job_ids));
>  	WARN_ON(!xa_empty(&pvr_dev->free_list_ids));
> =20
>  	pm_runtime_suspend(drm_dev->dev);

[Severity: Critical]
This is a pre-existing issue, but what happens if the runtime PM usage
count is elevated (e.g., due to an active job or a prior sysfs write to
power/control)?

If the usage count is elevated, pm_runtime_suspend() will return -EAGAIN
and skip the suspend callback. The hardware will remain physically powered
on and the firmware will continue to run.

Because pvr_remove() ignores this return value, it will proceed to unmap
MMIO and free firmware OS data unconditionally in pvr_device_fini(), which
might lead to IOMMU faults or memory corruption when the actively running
firmware accesses those freed structures.

> =20
>  	xa_destroy(&pvr_dev->job_ids);
>  	xa_destroy(&pvr_dev->free_list_ids);
> =20
>  	pvr_device_fini(pvr_dev);
> -	pvr_watchdog_fini(pvr_dev);
>  	pvr_queue_device_fini(pvr_dev);

[Severity: Critical]
This is a pre-existing issue, but does this teardown order cause pending
jobs to execute against freed memory?

pvr_device_fini() unmaps and frees firmware memory. Right after it,
pvr_queue_device_fini() destroys the scheduler workqueue:

drivers/gpu/drm/imagination/pvr_queue.c:pvr_queue_device_fini() {
    destroy_workqueue(pvr_dev->sched_wq);
}

Calling destroy_workqueue() flushes and drains the workqueue, which would
force pending DRM scheduler jobs to execute synchronously via
pvr_queue_run_job().

Since the firmware memory was already freed by pvr_device_fini(), won't
these executed jobs access freed memory?

[Severity: High]
This is a pre-existing issue, but is it possible for a dma_fence to outlive
the DRM device if it is exported to userspace as a sync_file FD?

If a sync_file FD outlives device unbind, closing it later triggers the
fence release callback. In drivers/gpu/drm/imagination/pvr_queue.c:

pvr_queue_fence_release() {
    queue_work(pvr_dev->sched_wq, &fence->release_work);
}

Since pvr_remove() destroys pvr_dev->sched_wq, calling queue_work() on the
destroyed workqueue (and accessing potentially freed pvr_dev) would cause a
crash.

Does pvr_queue_fence_init() need to take a reference to the drm_device
instead of just the pvr_context?

>  	pvr_context_device_fini(pvr_dev);
>  	pvr_power_domains_fini(pvr_dev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913-rbrue-suez=
-upstreaming-pvr-suspend-gpu-system-sleep-v3-0-674b907d0652@gmail.com?part=
=3D3
