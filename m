Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FCAC79FB7
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 04:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21D8110E08B;
	Thu, 10 Sep 2026 04:31:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IEt7rf6r";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A80A910E08B
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 04:31:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A3E6C600CB;
 Thu, 10 Sep 2026 04:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A141F000FF;
 Thu, 10 Sep 2026 04:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789014687;
 bh=fXIWvu01dNMuisalwTIAqMJKI/k5cYOAK8SW4sXCqgM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IEt7rf6rZL3LM6Z2QTj2H5YyxnFtGnvRu+9DEwXnZqBqidbH3s4s+SDXweAOY4nrv
 SxDjwKYM0yxlGiugXRds8KA9NmLPEuREr+iYBS56QB67z+TnV/ovHac+SwqDYoflX9
 HndPvRFvx31PYvwlTeuO4es/un/Wv82Ckh4WjZzWaha8/3ljHp7lK2guSVAEgSGpnk
 j+boqCLfywkw+YE2aROUTxZeuv38WMnK9agn0IsMfhAGiGaHOk1pJJJndiYs0c4vz+
 cGdTntB8SfY2ExHoEagRUiFBeF/3DWDSFfYwekSgvCH2QfkpbzfmMghsbYb2pt+Ox0
 xu9r0YgZ1CEaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/imagination: suspend the GPU for system sleep,
 not just runtime PM
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260909-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v2-1-66a938e92b87@gmail.com>
References: <20260909-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v2-1-66a938e92b87@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:31:26 +0000
Message-Id: <20260910043126.E6A141F000FF@smtp.kernel.org>
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
- [Critical] System suspend introduces an AB-BA deadlock between the SRCU r=
ead lock and the watchdog synchronization.
- [High] TOCTOU race in `pvr_power_system_suspend()` allows a concurrent un=
plug to cause a spurious system suspend failure.

Pre-existing issues:
- [High] Error path in `pvr_power_fw_disable()` fails to requeue watchdog w=
ork, permanently breaking watchdog monitoring.
- [High] Device structures are destroyed before `drm_dev_unplug()`, creatin=
g a Use-After-Free for concurrent ioctls.
--

commit dc6377c63d9f22c52f5a09300ba23dc0ca1af753
Author: Ryan Brue <ryanbrue.dev@gmail.com>

    drm/imagination: suspend the GPU for system sleep, not just runtime PM

    pvr_pm_ops has only RUNTIME_PM_OPS, so the GPU gets no callback for
    system suspend at all. This patch adds SYSTEM_SLEEP_PM_OPS to map
    system suspend and resume to pm_runtime_force_suspend and
    pm_runtime_force_resume, wrapped to prevent system suspend failures if
    the GPU is already unplugged.

> ...
> And pvr_power_fw_disable() cancels the watchdog work before it can fail,
> and does not restart it on the error path, so a suspend that fails
> part-way leaves the watchdog dead until the next successful resume --
> pre-existing, but system sleep is a new way to reach it.
> ...

[Severity: High]
This isn't a bug introduced by this patch, but since system sleep now
provides a reachable path for this to happen, could this leave the GPU
permanently dead on subsequent hangs?

If pvr_power_fw_disable() cancels the work, and then bails out early
before requeuing it:

drivers/gpu/drm/imagination/pvr_power.c:pvr_power_fw_disable() {
    cancel_delayed_work_sync(&pvr_dev->watchdog.work);

    err =3D pvr_power_request_idle(pvr_dev);
    if (err)
        return err;
    ...
}

Will the watchdog remain permanently disabled without a subsequent
successful resume to restart it?

> diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imag=
ination/pvr_drv.c
> index 5c965ef0274ff..09eb162353aac 100644
> --- a/drivers/gpu/drm/imagination/pvr_drv.c
> +++ b/drivers/gpu/drm/imagination/pvr_drv.c
> @@ -1517,6 +1517,7 @@ MODULE_DEVICE_TABLE(of, dt_match);
> =20
>  static const struct dev_pm_ops pvr_pm_ops =3D {
>  	RUNTIME_PM_OPS(pvr_power_device_suspend, pvr_power_device_resume, pvr_p=
ower_device_idle)
> +	SYSTEM_SLEEP_PM_OPS(pvr_power_system_suspend, pvr_power_system_resume)
>  };
> =20
>  static struct platform_driver pvr_driver =3D {
>  	.probe =3D pvr_probe,
>  	.remove =3D pvr_remove,

[Severity: High]
This is a pre-existing issue, but does pvr_remove() create a
use-after-free condition for concurrent ioctls?

Looking at drivers/gpu/drm/imagination/pvr_drv.c:pvr_remove():

    xa_destroy(&pvr_dev->job_ids);
    xa_destroy(&pvr_dev->free_list_ids);

    pm_runtime_suspend(drm_dev->dev);
    pvr_device_fini(pvr_dev);
    drm_dev_unplug(drm_dev);

Since drm_dev_unplug() is called after destroying the xarrays, could a
concurrent ioctl still successfully call drm_dev_enter() and access the
freed data structures? Should drm_dev_unplug() be called before tearing
down the internal data structures?

> diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/im=
agination/pvr_power.c
> index eb4b6ecdf4f4d..55a47bc4e925e 100644
> --- a/drivers/gpu/drm/imagination/pvr_power.c
> +++ b/drivers/gpu/drm/imagination/pvr_power.c
[ ... ]
> @@ -427,6 +427,37 @@ pvr_power_device_resume(struct device *dev)
>  	return err;
>  }
> =20
> +int
> +pvr_power_system_suspend(struct device *dev)
> +{
> +	struct platform_device *plat_dev =3D to_platform_device(dev);
> +	struct drm_device *drm_dev =3D platform_get_drvdata(plat_dev);
> +
> +	/*
> +	 * A device that has been lost cannot be talked to, and there is
> +	 * nothing left to power down. pvr_power_device_suspend() answers
> +	 * -EIO for it, which the PM core turns into a failed system suspend
> +	 * for the whole machine -- and because nothing clears the condition,
> +	 * it would fail that way on every subsequent attempt.
> +	 */
> +	if (drm_dev_is_unplugged(drm_dev))
> +		return 0;
> +
> +	return pm_runtime_force_suspend(dev);

[Severity: High]
Does this create a TOCTOU race window?

Because drm_dev_is_unplugged() acquires and then drops the lock, and
pvr_dev->sched_wq is not allocated with WQ_FREEZABLE, can the watchdog
worker run concurrently and unplug the device between the check and
the call to pm_runtime_force_suspend(dev)?

If pm_runtime_force_suspend() is called on a device that was lost in that
window, wouldn't it result in a spurious system suspend failure?


[Severity: Critical]
Does this bypass runtime PM usage counts and introduce an AB-BA deadlock
during system suspend?

pm_runtime_force_suspend() calls pvr_power_device_suspend(), which
acquires the SRCU read lock via drm_dev_enter():

drivers/gpu/drm/imagination/pvr_power.c:pvr_power_device_suspend() {
    if (!drm_dev_enter(drm_dev, &idx))
        return -EIO;
    ...
    if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
        err =3D pvr_power_fw_disable(pvr_dev, true);

It then blocks waiting for the watchdog to complete while holding the lock:

drivers/gpu/drm/imagination/pvr_power.c:pvr_power_fw_disable() {
    cancel_delayed_work_sync(&pvr_dev->watchdog.work);

If the watchdog worker is concurrently executing and triggers a reset that
fails, it calls drm_dev_unplug():

drivers/gpu/drm/imagination/pvr_power.c:pvr_device_lost() {
    drm_dev_unplug(from_pvr_device(pvr_dev));

drm_dev_unplug() will block on synchronize_srcu() waiting for the read
lock held by the suspend path, causing a complete system freeze. Can we
avoid holding the SRCU read lock while synchronizing with the watchdog?

> +}
> +
> +int
> +pvr_power_system_resume(struct device *dev)
> +{
> +	struct platform_device *plat_dev =3D to_platform_device(dev);
> +	struct drm_device *drm_dev =3D platform_get_drvdata(plat_dev);
> +
> +	if (drm_dev_is_unplugged(drm_dev))
> +		return 0;
> +
> +	return pm_runtime_force_resume(dev);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-rbrue-suez=
-upstreaming-pvr-suspend-gpu-system-sleep-v2-1-66a938e92b87@gmail.com?part=
=3D1
