Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EFCC88E5C
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 02:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4755E10E02D;
	Mon, 14 Sep 2026 02:27:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aUnbJVGl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A381110E02D
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 02:27:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DD0CB61099;
 Mon, 14 Sep 2026 02:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C811F000FF;
 Mon, 14 Sep 2026 02:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789352826;
 bh=5Bg9szKOjNPSXXaBf/27I6geW9PRhvqPGT5HzTdylUg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aUnbJVGlTUWp7rN8g8vUp3dzF4gSdGl1jSXHKDuU6Y2Fdk2rN+o6a75+dJPz47Ih0
 CAwSNUFZHVnLDxmYhRQiSFGauvQH8yRdmwEfNmqXxm1531vo/5cN5KFNZJRJyyA2ZD
 aM5zSaLgVBBz/PETJaH99exT/vTLc5OQcuV4+VLvw4+Ki+6+/DRkNjyL37ZZI8zarJ
 4fGOPZ2+21k0FWlDW3HlZPD/aNuy1PoaQytjMDdBnNUqrHeJXCj/05YwCTawGPY+C1
 vU44PJFuBKPdXKX/b8XriPCxcqvcIQDMaXkpmrJq34KJVSfeE8UxTnQhmfywpX6LyP
 1SqXSDIzdbf5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] drm/imagination: unplug the device before
 tearing it down in pvr_remove()
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-2-674b907d0652@gmail.com>
References: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-0-674b907d0652@gmail.com>
 <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-2-674b907d0652@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 02:27:05 +0000
Message-Id: <20260914022706.68C811F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] TOCTOU race on `pvr_dev->lost` in `pvr_remove()` allows a double `=
drm_dev_unplug()` execution, causing a kernel oops.

Pre-existing issues:
- [Critical] Deadlock caused by calling `drm_dev_unplug()` from within a `d=
rm_dev_enter()` SRCU read critical section via `pvr_device_lost()`.
- [Critical] Incorrect teardown ordering in `pvr_remove()` destroys firmwar=
e memory before stopping asynchronous workers (DRM schedulers), leading to =
Use-After-Free.
- [High] Missing `drm_dev_enter()` guards in teardown ioctls invalidate the=
 commit's core synchronization assumption.
--

commit 3adf692930871afc287c13c7680a8b09a7c0ad9e
Author: Ryan Brue <ryanbrue.dev@gmail.com>

drm/imagination: unplug the device before tearing it down in pvr_remove()

This commit reorders the teardown sequence in pvr_remove() to call
drm_dev_unplug() before destroying the job and free list xarrays, powering
down the GPU, and running pvr_device_fini(). It skips the unplug if
pvr_device_lost() has already performed it.

Fixes: 1f88f017e649 ("drm/imagination: Get GPU resources")
Fixes: 727538a4bbff ("drm/imagination: Implement power management")
Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imag=
ination/pvr_drv.c
> index 5c965ef0274ff..fc92a82a72084 100644
> --- a/drivers/gpu/drm/imagination/pvr_drv.c
> +++ b/drivers/gpu/drm/imagination/pvr_drv.c
> @@ -1469,15 +1469,23 @@ static void pvr_remove(struct platform_device *pl=
at_dev)
>  	struct drm_device *drm_dev =3D platform_get_drvdata(plat_dev);
>  	struct pvr_device *pvr_dev =3D to_pvr_device(drm_dev);
> =20
> +	/*
> +	 * Unplug before freeing anything, so no ioctl is still inside
> +	 * drm_dev_enter(). pvr_device_lost() may already have done it, and

[Severity: Critical]
This is a pre-existing issue, but does calling drm_dev_unplug() from
pvr_device_lost() introduce a potential self-deadlock when triggered from
an MMU flush?

Looking at pvr_mmu_flush_exec(), it acquires the SRCU read lock via
drm_dev_enter(). If the flush times out, it attempts recovery and calls
pvr_device_lost(), which subsequently triggers drm_dev_unplug() and its
internal synchronize_srcu():

drivers/gpu/drm/imagination/pvr_mmu.c:pvr_mmu_flush_exec() {
        if (!drm_dev_enter(from_pvr_device(pvr_dev), &idx))
                return -EIO;
        ...
        /* On timeout calls pvr_power_reset() or pvr_device_lost() */
}

Since synchronize_srcu() waits indefinitely for all SRCU readers to exit, a=
nd
the calling thread itself holds the read lock, won't it hang forever waiting
for its own completion?

> +	 * drm_dev_unplug() is not idempotent.
> +	 */
> +	if (!pvr_dev->lost)
> +		drm_dev_unplug(drm_dev);

[Severity: High]
Is this vulnerable to a time-of-check to time-of-use race with
pvr_power_reset() and pvr_device_lost()?

If pvr_remove() runs on the unbind path and evaluates !pvr_dev->lost as tru=
e,
could it be preempted before calling drm_dev_unplug()?

Concurrently, if an asynchronous context like a DRM scheduler timeout trigg=
ers
pvr_power_reset(), it would call pvr_device_lost(). Because the flag isn't =
set
yet, pvr_device_lost() would also evaluate !pvr_dev->lost as true, set the
flag, and execute drm_dev_unplug():

drivers/gpu/drm/imagination/pvr_power.c:pvr_device_lost() {
        if (!pvr_dev->lost) {
                pvr_dev->lost =3D true;
                drm_dev_unplug(from_pvr_device(pvr_dev));
        }
}

When pvr_remove() resumes, wouldn't it execute drm_dev_unplug() a second ti=
me,
causing a kernel oops inside drm_client_sysrq_unregister() since
drm_dev_unplug() is not idempotent?

[Severity: High]
This is a pre-existing issue, but does this unplug actually synchronize with
all ioctls as intended?

While this patch relies on drm_dev_unplug() to wait for in-flight ioctls via
drm_dev_enter() and drm_dev_exit(), some teardown ioctls appear to lack the=
se
guards entirely.

For example, in pvr_ioctl_destroy_context():

drivers/gpu/drm/imagination/pvr_drv.c:pvr_ioctl_destroy_context() {
        ...
        return pvr_context_destroy(pvr_file, args->handle);
}

And in pvr_ioctl_vm_unmap():

drivers/gpu/drm/imagination/pvr_drv.c:pvr_ioctl_vm_unmap() {
        ...
        err =3D pvr_vm_unmap(vm_ctx, args->device_addr, args->size);
        ...
}

Since these ioctls bypass the drm_dev_enter() check, couldn't userspace
execute them concurrently during or after the unplug, interacting with
hardware queues via pvr_queue_cleanup_fw_context() after pvr_remove() has
already freed them?

[ ... ]

>  	xa_destroy(&pvr_dev->job_ids);
>  	xa_destroy(&pvr_dev->free_list_ids);
> =20
> -	pm_runtime_suspend(drm_dev->dev);
>  	pvr_device_fini(pvr_dev);
> -	drm_dev_unplug(drm_dev);
>  	pvr_watchdog_fini(pvr_dev);
>  	pvr_queue_device_fini(pvr_dev);

[Severity: Critical]
This is a pre-existing issue, but does the ordering here tear down firmware
memory before stopping asynchronous workers?

When pvr_device_fini() is called, it tears down hardware components and fre=
es
firmware memory such as pvr_dev->fw_dev. However, the DRM scheduler threads
executing on pvr_dev->sched_wq are not stopped until pvr_queue_device_fini()
is called later.

Couldn't drm_sched concurrently execute pvr_queue_run_job() while or after =
the
firmware memory is freed, leading to a use-after-free when it accesses that
memory to submit KCCB commands?

Note that while a subsequent patch in the series moves pvr_watchdog_fini(),
the DRM scheduler teardown issue appears to remain unresolved here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913-rbrue-suez=
-upstreaming-pvr-suspend-gpu-system-sleep-v3-0-674b907d0652@gmail.com?part=
=3D2
