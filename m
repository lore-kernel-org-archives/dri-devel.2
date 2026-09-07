Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4811CC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 20:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1D2F10E91A;
	Mon,  7 Sep 2026 20:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FcsTh49E";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1964A10E91A
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 20:38:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6283F601FB;
 Mon,  7 Sep 2026 20:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1F31F00A3A;
 Mon,  7 Sep 2026 20:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788813496;
 bh=AldDiPkTsFx8ua/fkLxO4DzObp/Q9txUR7bLFJqqHSU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FcsTh49EOM4tCUfaiaw5AmsUo+6X3XWQyZyuNJG8KWb/VconAwToVjXGna0C313Ma
 XeUrJK3FwPl7QvXfo7PE3Pj9vhaSjBvo7bmXClLXRv8NJv9uIOhjj2S6h6aRe1Q5ux
 zDg+4Sb1bSDV3dZYtojS+v18+jTegn3/mXG1JB8ryuglx+UPXF9zDWF247MVJkKhA2
 GreM9f7WIqYuMlMhplD/aMmElRmqfvUqVIOwHBieD3oqwdjXL4Z+Mhnh6PZbSrD6mi
 dT3xeT1PbxmO5sxl7lec1KNZsEb+B0A11PiRSEuMdwdrhrOn7NSRxpxuummMG5CF+i
 DMyWHOB7/hhJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/16] drm/panfrost: Introduce a reset lock
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907-claude-fixes-v8-14-c2bcb5e82184@collabora.com>
References: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
 <20260907-claude-fixes-v8-14-c2bcb5e82184@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 20:38:15 +0000
Message-Id: <20260907203815.EB1F31F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Scheduler teardown races with pending reset work in panfrost_jm_fi=
ni().
- [High] panfrost_reset() drops PM references prematurely, allowing concurr=
ent autosuspend to power off the GPU before reset.
--

commit 41ac0c5362c3dc2a1e03fb9d2659c68f74cd414d
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Introduce a reset lock

This commit adds a read/write semaphore to the panfrost device reset struct=
ure.
It protects hardware register access during an ongoing reset sequence,
specifically preventing the timestamp query ioctl from racing with the reset
process.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index f171abe26f80d..e90efcff5ce7e 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -466,6 +466,8 @@ bool panfrost_exception_needs_reset(const struct panf=
rost_device *pfdev,
> =20
>  void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_jo=
b_int)
>  {
> +	guard(rwsem_write)(&pfdev->reset.lock);
> +
>  	panfrost_gpu_soft_reset(pfdev);
> =20
>  	panfrost_gpu_power_on(pfdev);

[Severity: High]
This isn't a bug introduced by this patch, but looking at how
panfrost_device_reset() is called from panfrost_reset() in
drivers/gpu/drm/panfrost/panfrost_job.c, is there a race with GPU
autosuspend?

In panfrost_reset(), the PM references for stuck jobs are dropped right
before calling panfrost_device_reset():

	pm_runtime_put_noidle(pfdev->base.dev);
	panfrost_devfreq_record_idle(&pfdev->pfdevfreq);
	...
	/* Proceed with reset now. */
	panfrost_device_reset(pfdev, false);

If an autosuspend timer expires in this small window, could
panfrost_device_runtime_suspend() execute and power off the GPU? If so,
the subsequent register accesses inside panfrost_device_reset() (like writi=
ng
to GPU_INT_MASK in panfrost_gpu_soft_reset()) might hit powered-off hardwar=
e,
potentially causing a bus fault.

[ ... ]
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index 00fb36c577df7..c2b1f1087e21e 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -877,6 +877,7 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
>  	INIT_WORK(&pfdev->reset.work, panfrost_reset_work);
>  	spin_lock_init(&js->job_lock);
>  	mutex_init(&pfdev->sched_lock);
> +	init_rwsem(&pfdev->reset.lock);
> =20
>  	js->irq =3D platform_get_irq_byname(to_platform_device(pfdev->base.dev)=
, "job");
>  	if (js->irq < 0)

[Severity: High]
This is a pre-existing issue, but while we are setting up the reset worker
and its locks here, does the teardown order in panfrost_jm_fini() race with
the reset work?

Looking at panfrost_jm_fini() in drivers/gpu/drm/panfrost/panfrost_job.c, it
destroys the schedulers before cancelling the pending reset work:

	for (j =3D 0; j < NUM_JOB_SLOTS; j++) {
		drm_sched_fini(&js->queue[j].sched);
	}

	cancel_work_sync(&pfdev->reset.work);

If a user triggers a GPU reset via debugfs or a delayed reset work is queued
just as the module is unloaded, could panfrost_reset_work() execute
concurrently? Since panfrost_reset() calls drm_sched_stop() and
drm_sched_start() on the torn-down schedulers, this sequence could lead to
accessing freed scheduler memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-claude-fix=
es-v8-0-c2bcb5e82184@collabora.com?part=3D14
