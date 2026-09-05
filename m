Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DBFC624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 14:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC2210E097;
	Sat,  5 Sep 2026 14:09:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ALJi2yHu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EAD610E097
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 14:09:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B01F60214;
 Sat,  5 Sep 2026 14:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9247A1F00A3D;
 Sat,  5 Sep 2026 14:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788617356;
 bh=hQ1eBSByfYHz0Zy54vchaiVx8R08zLoimJPv/LaGj3w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ALJi2yHu4smmsk00TSouE6/tmZIXU2TJ1CIleGY42tY/ngq7QTsYMkBvHwo3Fu0+M
 1PropwDgvK6WYdQrJeC1JupeqtZxOPzM32jYoKF4dwjOt/b0rQmQxgwaZkEPehrE3c
 n/3EWSpKYuwP4TJN67RxTCZE00rqTlOoLsV3PxfVx2Eta1hDdMM2UxGm5yZXHxds/G
 Ccr2+fgscubCUA6/KiPYdOhJT1PO1arV4XOLhzBxhHl1ZAN03oBYaISB47PJNQlSSl
 sSj4mDSgyDgtyzIwS4eh2hUCFfyw1pJv5Df8pfP2lo+E6Ai9QO0X6Q05oVPgi1NP1v
 e6y6sAQ+w89Ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/rocket: number the cores by devicetree position,
 not bind order
To: "Igor Paunovic" <royalnet026@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260905135612.7324-1-royalnet026@gmail.com>
References: <20260905135612.7324-1-royalnet026@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 14:09:16 +0000
Message-Id: <20260905140916.9247A1F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Global `rdev` pointer is left containing an `ERR_PTR` if `rocket_d=
evice_init()` fails, leading to a kernel panic on subsequent probes.
- [High] Unbinding a core (other than the last one) breaks `rdev->cores` ar=
ray tracking, leading to resource leaks, missing remaining cores during loo=
kup, and overwriting active cores on rebind.
- [High] Memory allocated via `devm_*` on `drm_dev->dev` in `rocket_device_=
init()` permanently leaks when all cores are unbound.
- [High] Global static variable `rdev` and its state (`rdev->num_cores`) ar=
e accessed and initialized without synchronization, leading to TOCTOU races=
 during concurrent probing.
- [High] Premature `drm_dev_register()` inside `rocket_device_init()` expos=
es the device node to userspace before core initialization completes, leadi=
ng to NULL pointer dereference on open.
- [High] The `scheds` array allocated in `rocket_job_open()` leaks if there=
 is only 1 core or if `drm_sched_entity_init()` fails.
- [High] Unhandled errors in `rocket_ioctl_submit()` silently drop user job=
s, causing implicit synchronization failures.
--

commit 536d84c08923eb208c65c6e48a6e81dd4a63e6f5
Author: Igor Paunovic <royalnet026@gmail.com>

accel/rocket: number the cores by devicetree position, not bind order

rocket_job_hw_submit() programs the S_POINTER registers of a core with an
extra bit derived from core->index, the way the vendor driver derives it
from the hardware number of the core. rocket_probe() sets core->index to
the slot the core takes in rdev->cores[], which is the order the cores
bind in.

> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> index 8bbbce594883e..e2cde31443ffa 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
[ ... ]
> @@ -157,10 +157,39 @@ static const struct drm_driver rocket_drm_driver =
=3D {
[ ... ]
>  static int rocket_probe(struct platform_device *pdev)
>  {
> +	int index =3D rocket_core_hw_index(&pdev->dev);
>  	int ret;
> =20
> +	if (index < 0)
> +		return index;
> +
>  	if (rdev =3D=3D NULL) {
>  		/* First core probing, initialize DRM device. */
>  		rdev =3D rocket_device_init(drm_dev, &rocket_drm_driver);

[Severity: High]
This is a pre-existing issue, but I noticed that memory allocated via devm_=
*=20
on drm_dev->dev in rocket_device_init() might leak.=20

When the last core is unbound, rocket_remove() calls rocket_device_fini()=20
and sets rdev to NULL, but drm_dev is not unregistered, so the attached=20
devm resources are not freed.=20

Will a subsequent bind cause a permanent memory leak?

Also, another pre-existing issue: is this global rdev accessed and modified=
=20
without synchronization? Concurrent probes might evaluate rdev =3D=3D NULL =
and=20
race to double-initialize the DRM device.

> @@ -176,7 +205,7 @@ static int rocket_probe(struct platform_device *pdev)
> =20
>  	rdev->cores[core].rdev =3D rdev;
>  	rdev->cores[core].dev =3D &pdev->dev;

[Severity: High]
This is a pre-existing issue, but how does this array assignment handle=20
unbinds?=20

When rocket_remove() is called, it decrements rdev->num_cores without=20
compacting the array:

drivers/accel/rocket/rocket_drv.c:rocket_remove() {
	...
	rocket_core_fini(&rdev->cores[core]);
	rdev->num_cores--;
	...
}

If a core other than the last one is unbound, won't this overwrite an activ=
e=20
core when a new core probes and takes the slot at num_cores?

Additionally, find_core_for_dev() uses num_cores as an upper bound:

drivers/accel/rocket/rocket_drv.c:find_core_for_dev() {
	for (unsigned int core =3D 0; core < rdev->num_cores; core++) {
		if (dev =3D=3D rdev->cores[core].dev)
			return core;
	}
	...
}

Will it fail to find remaining active cores located beyond the shrunk=20
boundary?

> -	rdev->cores[core].index =3D core;
> +	rdev->cores[core].index =3D index;
> =20
>  	rdev->num_cores++;

[Severity: High]
This is a pre-existing issue, but might this unprotected increment of the=20
shared state lead to desynchronization and array bounds violations during=20
concurrent probing?

[ ... ]

Some other pre-existing issues were noticed during review:

[Severity: High]
If rocket_device_init() fails, it returns an ERR_PTR which is left in the=20
global rdev pointer:

drivers/accel/rocket/rocket_drv.c:rocket_probe() {
	...
	if (rdev =3D=3D NULL) {
		rdev =3D rocket_device_init(drm_dev, &rocket_drm_driver);
		if (IS_ERR(rdev)) {
			...
			return PTR_ERR(rdev);
		}
	}
=09
	unsigned int core =3D rdev->num_cores;
	...
}

Could this leave rdev holding a poisoned pointer instead of NULL? If rdev=20
holds a poisoned ERR_PTR from a previous probe failure, will the subsequent=
=20
access to rdev->num_cores dereference it and cause a kernel panic?


[Severity: High]
Does rocket_device_init() expose the device node to userspace prematurely?=
=20

drivers/accel/rocket/rocket_device.c:rocket_device_init() {
	...
	err =3D drm_dev_register(ddev, 0);
	if (err)
		return ERR_PTR(err);
	...
}

If userspace intercepts the registration and immediately invokes open(),=20
could rocket_open() access an uninitialized core dev pointer?

drivers/accel/rocket/rocket_drv.c:rocket_open() {
	...
	rocket_priv->domain =3D rocket_iommu_domain_create(rdev->cores[0].dev);
	...
}

Since the core properties are not assigned until later in rocket_probe(),=20
will this panic when trying to allocate a domain?


[Severity: High]
Does the scheds array allocated in rocket_job_open() leak if=20
rdev->num_cores =3D=3D 1?

drivers/accel/rocket/rocket_job.c:rocket_job_open() {
	...
	struct drm_gpu_scheduler **scheds =3D kmalloc_objs(*scheds,
							 rdev->num_cores);
	...
	ret =3D drm_sched_entity_init(&rocket_priv->sched_entity,
				    DRM_SCHED_PRIORITY_NORMAL,
				    scheds,
				    rdev->num_cores, NULL);
	...
}

If num_cores is 1, drm_sched_entity_init() intentionally sets=20
entity->sched_list to NULL instead of storing the array. Then during close:

drivers/accel/rocket/rocket_job.c:rocket_job_close() {
	...
	kfree(entity->sched_list);
	...
}

Doesn't this incorrectly assume entity->sched_list always holds the pointer=
,=20
causing a leak when num_cores =3D=3D 1 or if drm_sched_entity_init() fails?


[Severity: High]
Are job submission errors ignored in rocket_ioctl_submit()?

drivers/accel/rocket/rocket_job.c:rocket_ioctl_submit() {
	...
	for (i =3D 0; i < args->job_count; i++)
		rocket_ioctl_submit_job(dev, file, &jobs[i]);
	...
}

If rocket_ioctl_submit_job() fails, the loop blindly discards its error=20
return value. Will this silently drop user jobs and cause implicit=20
synchronization failures since the output fences are never injected?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905135612.7324=
-1-royalnet026@gmail.com?part=3D1
