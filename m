Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC213C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 06:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F00910EFD6;
	Wed,  8 Jul 2026 06:45:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GJk3eK6i";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3405810EFD6
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 06:45:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DEB02404AB;
 Wed,  8 Jul 2026 06:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B2F1F000E9;
 Wed,  8 Jul 2026 06:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783493144;
 bh=sobHpVSNTVQS9X37r5ybfXkW590MKYC+5PvGGdTF/+E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GJk3eK6iti0GC9AN3LKk5qkj2PJWB3K2OdFd1FqsdBaOqWKNn1k1lpjD4ESKbIB+l
 3ChqpqoL74qLQ0RLrZJJpJ/3RiyjlxnwQFGL5jktAA8iNUMeoS8netVAq4dpWwviiz
 DWb0EBU5TGtv6zDiDabvuh9W07a7Nyd/J1vSypryL1xQllmNvzngGD2tueGV2x9t5S
 CsNkETDMJQ+M9QsKmwtTwgHi1VEA3CA94XLZMpwbJES2K/wOH0YeAB9osPYTYUP6Cx
 RrOcdtMnx51lvzBuIjKnH/PYKbVDrm8DUyWrmEwse4yyiiEMkr9KaERwFDJFaKjtQy
 r4ONySnIAv7eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/rocket: clear rdev on device init failure
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260708062845.716487-1-lgs201920130244@gmail.com>
References: <20260708062845.716487-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 06:45:43 +0000
Message-Id: <20260708064543.C8B2F1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] NULL pointer dereference when opening the DRM device before co=
re initialization completes.
- [Critical] Use-After-Free due to deferred DRM device unregistration durin=
g individual core teardown.
- [High] Massive memory and resource leak due to devres allocations on a pe=
rmanent platform device.
- [High] Out-of-bounds access and data corruption due to missing array comp=
action on core removal.
- [High] Race condition and data races on global state during concurrent co=
re probes.
- [High] Memory leak of IOMMU domain reference in `rocket_ioctl_create_bo` =
error path.
- [High] Use-After-Free and NULL pointer dereference in concurrent timeout =
handler during teardown.
- [High] Missing clock IDs in `clk_bulk_data` causes failure to properly re=
quest and enable hardware clocks.
--

--- Patch [1]: [PATCH] accel/rocket: clear rdev on device init failure ---
commit 17e3337636f75d45b7220a5f2dd42ebed6a265c7
Author: Guangshuo Li <lgs201920130244@gmail.com>

accel/rocket: clear rdev on device init failure

This patch updates rocket_probe() to clear the file-scoped rdev pointer and
return the saved error code if rocket_device_init() fails. This prevents a
later probe from seeing a non-NULL rdev and dereferencing an error pointer.

> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> index 8bbbce594883e..67e7f543fe4c7 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
> @@ -165,8 +165,11 @@ static int rocket_probe(struct platform_device *pdev)
>  		/* First core probing, initialize DRM device. */
>  		rdev =3D rocket_device_init(drm_dev, &rocket_drm_driver);
>  		if (IS_ERR(rdev)) {
> +			int err =3D PTR_ERR(rdev);
> +
>  			dev_err(&pdev->dev, "failed to initialize rocket device\n");
> -			return PTR_ERR(rdev);
> +			rdev =3D NULL;

[Severity: High]
This is a pre-existing issue, but does this error path permanently leak
memory?

In drivers/accel/rocket/rocket_device.c:rocket_device_init(), allocations
are made using devres bound to the persistent drm_dev:

    rdev =3D devm_drm_dev_alloc(dev, rocket_drm_driver, struct rocket_devic=
e,
                              ddev);

Since drm_dev is a static platform device that persists until module unload,
these devres allocations are never freed. If rocket_probe() fails here,
abandoning the devm-managed allocations without freeing them, will successi=
ve
probe failures or unbind/bind cycles continuously stack unbounded memory le=
aks?

> +			return err;
>  		}
>  	}
> =20

[Severity: Critical]
This isn't a bug introduced by this patch, but could this cause a NULL
pointer dereference when opening the DRM device?

In drivers/accel/rocket/rocket_device.c:rocket_device_init(), the device is
registered and exposed to userspace prematurely:

    err =3D drm_dev_register(ddev, 0);

If an unprivileged user opens the DRM device right after registration, befo=
re
rocket_probe() finishes initializing the hardware cores, rocket_open() is
called:

    rocket_priv->domain =3D rocket_iommu_domain_create(rdev->cores[0].dev);

Since cores[0].dev is still NULL, this passes a NULL device pointer to
iommu_paging_domain_alloc(), which would cause a kernel panic when it
dereferences dev->iommu.

[Severity: Critical]
This is a pre-existing issue, but does deferred DRM device unregistration
lead to a use-after-free during individual core teardown?

When an individual core is unbound,
drivers/accel/rocket/rocket_drv.c:rocket_remove() destroys that core's
drm_gpu_scheduler:

    rocket_core_fini(&rdev->cores[core]);

However, drm_dev_unregister() is deferred until the very last core is
removed. Open file descriptors can still access the device, and
drivers/accel/rocket/rocket_job.c:rocket_job_open() will initialize a
drm_sched_entity pointing to the destroyed scheduler:

    scheds[core] =3D &rdev->cores[core].sched;

Could subsequent user ioctls to submit jobs push them to a destroyed
scheduler, causing a use-after-free crash?

[Severity: High]
This isn't a bug introduced by this patch, but is there an out-of-bounds
access due to missing array compaction on core removal?

Removing a core decrements the count without compacting the array:

    rdev->num_cores--;

As a result, find_core_for_dev() iterations will truncate and fail to locate
active cores at higher indices. Furthermore, if a new core is probed,
drivers/accel/rocket/rocket_drv.c:rocket_probe() uses the artificially
lowered num_cores as the index:

    rdev->cores[core].rdev =3D rdev;

Would this overwrite an existing active core slot, destroying its state and
corrupting the array mapping?

[Severity: High]
This is a pre-existing issue, but is there a data race on global state
during concurrent core probes?

The global rdev pointer and rdev->num_cores counter are accessed and
modified without synchronization. Concurrent probes for different device
tree nodes could race here in
drivers/accel/rocket/rocket_drv.c:rocket_probe():

    if (rdev =3D=3D NULL) {

and later increment without synchronization:

    rdev->num_cores++;

Could multiple threads simultaneously pass the NULL check, leading to
duplicate memory allocations, corrupting the rdev->cores array, and losing
core registrations?

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
rocket_ioctl_create_bo leak the IOMMU domain reference?

If BO creation fails, the error path directly calls:

    drm_gem_shmem_object_free(gem_obj);

This frees the GEM object but completely bypasses the driver's custom
rocket_gem_bo_free() callback. As a result, the IOMMU domain reference
acquired earlier is never released:

    rkt_obj->domain =3D rocket_iommu_domain_get(rocket_priv);

Could a malicious userspace program exploit this to cause an out of memory
condition by repeatedly triggering mapping failures?

[Severity: High]
This is a pre-existing issue, but could this lead to a use-after-free and
NULL pointer dereference in a concurrent timeout handler?

During unbind, drivers/accel/rocket/rocket_core.c:rocket_core_fini() drops
the IOMMU group reference and clears the pointer before tearing down the
scheduler:

    core->iommu_group =3D NULL;

If a job timeout triggers concurrently,
drivers/accel/rocket/rocket_job.c:rocket_reset() is scheduled and calls:

    iommu_detach_group(NULL, core->iommu_group);

Does this dereference the now-NULL core->iommu_group pointer inside
iommu_detach_group?

[Severity: High]
This isn't a bug introduced by this patch, but does the lack of clock IDs
cause a failure to properly request and enable hardware clocks?

In drivers/accel/rocket/rocket_core.c:rocket_core_init(), clocks are fetched
using an uninitialized array where the .id fields are NULL:

    err =3D devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);

When .id is NULL, the clock subsystem falls back to fetching the very first
clock listed in the device tree for the device. Does this result in the
driver obtaining four references to the exact same clock instead of the four
distinct required clocks, causing hardware functional failure during power
management?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708062845.7164=
87-1-lgs201920130244@gmail.com?part=3D1
