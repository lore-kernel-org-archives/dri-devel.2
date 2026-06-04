Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4D5CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 14:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D9C511A105;
	Thu,  4 Jun 2026 14:08:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lDMqQtG3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D39F11A10B
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 14:08:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 13A45600B0;
 Thu,  4 Jun 2026 14:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DB71F0089A;
 Thu,  4 Jun 2026 14:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780582131;
 bh=OL6JoQBOw008/x+xf8no0mvXFrPNm4+jku3PzEkFuIc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lDMqQtG3HaPNVlTM+sLFFRXWwfeP2f12L7bpG+ui0sWx34K1udsTNuHmNnh0EH+1Z
 vxh3Y5gHc4pYNp4dGd3jooRJcKiBE6C/3vuxTuQ2qK5LSWpWkv36pn6RzypnT3rWjA
 E8FHuqxgtpxwWVpGH0hqcAJv2ECKMItN5VzCNrzjN/ex/OWMoxxb59mQoICF0kTRyN
 lWjZoQnwfyhIRK0DOpZ5OgrrD4Jx+JUzKEd/lzF4XUMoIncGOOozmuFwf/cfIDaDPx
 P0C12MRwGEbhYi+Fz1Ga+pMkSsRYWzc84U0KM1sFOzKVtQVvCMWtwxMhjZ/5kLZYoA
 APkTEU08AnM4g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 1/9] accel: rocket: Introduce per-SoC
 rocket_soc_data
To: "Midgy BALON" <midgy971@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260604135255.62682-2-midgy971@gmail.com>
References: <20260604135255.62682-2-midgy971@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 14:08:51 +0000
Message-Id: <20260604140851.85DB71F0089A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:

Pre-existing issues:
- [Critical] kref_put() dereferences a NULL pointer when job initialization=
 fails early or a BO is imported.
- [High] Error path in BO creation frees an object that is already owned by=
 the handle table.
- [High] Device is permanently left in an active power state upon unbind.
- [High] Array mismanagement during core removal prevents multi-core unbind.
- [High] Memory and DRM device leak on probe failure or deferral.
- [High] Asynchronous reset work is canceled after the DRM scheduler is des=
troyed.
- [High] The DRM device is registered and exposed to userspace before the N=
PU cores are initialized.
- [High] The global `rdev` pointer and `rdev->num_cores` are accessed and m=
odified locklessly during probe and removal.
- [High] The shared interrupt handler accesses hardware registers without c=
hecking the PM state, and suspend executes without synchronizing IRQs.
- [High] A failure in `rocket_job_run` leaks the PM usage counter and retur=
ns an unsignaled hardware fence, hanging the DRM scheduler.
- [High] Registers are accessed during initialization before resets are dea=
sserted.
--

commit e6cc2e46cba8fcba41d70a8b1e9422607b444db8
Author: Midgy BALON <midgy971@gmail.com>

accel: rocket: Introduce per-SoC rocket_soc_data

Add a per-SoC data structure carried in the OF match table, currently
holding only the NPU AXI address width, and use it for the per-core DMA
mask instead of a hardcoded 40-bit value.

> diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/ro=
cket_core.c
> index b3b2fa9ba645a..09c445af7de73 100644
> --- a/drivers/accel/rocket/rocket_core.c
> +++ b/drivers/accel/rocket/rocket_core.c
> @@ -21,6 +22,10 @@ int rocket_core_init(struct rocket_core *core)
>  	u32 version;
>  	int err =3D 0;
> =20
> +	core->soc_data =3D of_device_get_match_data(dev);
> +	if (!core->soc_data)
> +		return dev_err_probe(dev, -EINVAL, "missing SoC match data\n");
> +

[Severity: High]
This is a pre-existing issue, but I noticed that later in this function,
registers are accessed before resets are deasserted:

drivers/accel/rocket/rocket_core.c:rocket_core_init() {
	...
	core->resets[0].id =3D "srst_a";
	core->resets[1].id =3D "srst_h";
	err =3D devm_reset_control_bulk_get_exclusive(&pdev->dev, ARRAY_SIZE(core-=
>resets),
						    core->resets);
	...
	version =3D rocket_pc_readl(core, VERSION);
	version +=3D rocket_pc_readl(core, VERSION_NUM) & 0xffff;
	...
}

Will this cause a bus stall and trigger an asynchronous external abort if t=
he
hardware or bootloader leaves these resets asserted?

[Severity: High]
This is a pre-existing issue, but does rocket_core_fini() leave the device
permanently powered on with its clocks running after the driver has been
detached?

drivers/accel/rocket/rocket_core.c:rocket_core_fini() {
	pm_runtime_dont_use_autosuspend(core->dev);
	pm_runtime_disable(core->dev);
	...
}

Since rocket_core_init() drops its Runtime PM reference asynchronously via
pm_runtime_put_autosuspend(dev), if the driver is unbound before the
autosuspend delay elapses, pm_runtime_disable() forcefully cancels the
pending asynchronous suspend work without first synchronously powering down
the hardware (e.g., via pm_runtime_put_sync()).

>  	core->resets[0].id =3D "srst_a";
>  	core->resets[1].id =3D "srst_h";
>  	err =3D devm_reset_control_bulk_get_exclusive(&pdev->dev, ARRAY_SIZE(co=
re->resets),
[ ... ]
> @@ -52,7 +57,7 @@ int rocket_core_init(struct rocket_core *core)
> =20
>  	dma_set_max_seg_size(dev, UINT_MAX);
> =20
> -	err =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
> +	err =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(core->soc_data->dma=
_bits));
>  	if (err)
>  		return err;
> =20
> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> index 8bbbce594883e..384c38e13acce 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
> @@ -213,8 +213,12 @@ static void rocket_remove(struct platform_device *pd=
ev)
>  	}
>  }
> =20

[Severity: High]
This is a pre-existing issue, but can this array mismanagement during core
removal prevent multi-core unbind?

drivers/accel/rocket/rocket_drv.c:rocket_remove() {
	...
	rocket_core_fini(&rdev->cores[core]);
	rdev->num_cores--;
	...
}

drivers/accel/rocket/rocket_drv.c:find_core_for_dev() {
	for (unsigned int core =3D 0; core < rdev->num_cores; core++) {
		if (dev =3D=3D rdev->cores[core].dev)
			return core;
	}
	...
}

When a core is unbound, rdev->num_cores is decremented, but the unbound cor=
e's
slot in the static rdev->cores array is left unmodified, and the remaining
elements are not shifted.

Because find_core_for_dev() unconditionally loops only rdev->num_cores time=
s,
any core residing at an array index greater than or equal to the decremented
num_cores becomes invisible.

Will subsequent attempts to unbind those remaining cores fail, silently
exiting early and completely leaking the cores' resources and power state?

[Severity: High]
This is a pre-existing issue, but could rocket_probe() leak memory and the =
DRM
device on probe failure or deferral?

drivers/accel/rocket/rocket_drv.c:rocket_probe() {
	if (rdev =3D=3D NULL) {
		/* First core probing, initialize DRM device. */
		rdev =3D rocket_device_init(drm_dev, &rocket_drm_driver, soc_data);
	...
}

drivers/accel/rocket/rocket_device.c:rocket_device_init() {
	rdev =3D devm_drm_dev_alloc(dev, rocket_drm_driver, struct rocket_device, =
ddev);
	...
	rdev->cores =3D devm_kcalloc(dev, soc_data->num_cores, sizeof(*rdev->cores=
), GFP_KERNEL);
	...
}

The global facade device rdev is dynamically initialized via rocket_device_=
init()
using the global, virtually registered drm_dev platform device. Allocations=
 like
devm_drm_dev_alloc() and devm_kcalloc() are bound to the drm_dev lifecycle
rather than the physical pdev currently being probed.

If rocket_core_init() subsequently fails (e.g., due to -EPROBE_DEFER),
rocket_probe() cleans up by calling rocket_device_fini() and resetting
rdev =3D NULL. However, rocket_device_fini() only unregisters the DRM devic=
e.

Because drm_dev remains globally alive until module unload, none of the dev=
m_
allocations are freed. On the next probe attempt, a new rdev is allocated on
drm_dev. Can this create a permanent memory leak?

[Severity: High]
This is a pre-existing issue, but might the DRM device be registered and
exposed to userspace before the NPU cores are initialized?

drivers/accel/rocket/rocket_device.c:rocket_device_init() {
	...
	err =3D drm_dev_register(ddev, 0);
	if (err)
		return ERR_PTR(err);

	return rdev;
}

drivers/accel/rocket/rocket_drv.c:rocket_probe() {
	...
		rdev =3D rocket_device_init(drm_dev, &rocket_drm_driver, soc_data);
	...
	unsigned int core =3D rdev->num_cores;
	dev_set_drvdata(&pdev->dev, rdev);

	rdev->cores[core].rdev =3D rdev;
	rdev->cores[core].dev =3D &pdev->dev;
	...
}

When the first core is probed, it calls rocket_device_init(), which ends wi=
th
drm_dev_register(). At this moment, the DRM character device becomes visible
and openable by userspace.

However, the core hardware, IRQs, and core pointers (e.g. rdev->cores[core]=
.dev)
are not assigned or initialized until immediately afterward, when
rocket_core_init() runs.

If userspace opens the device in this narrow window, will rocket_open()
evaluate the uninitialized rdev->cores[0].dev (which is NULL) and pass it to
rocket_iommu_domain_create(), causing an immediate NULL pointer dereference?

[Severity: High]
This is a pre-existing issue, but is it possible that the global rdev point=
er
and rdev->num_cores are accessed and modified locklessly during probe and
removal?

drivers/accel/rocket/rocket_drv.c:rocket_probe() {
	if (rdev =3D=3D NULL) {
		/* First core probing, initialize DRM device. */
		rdev =3D rocket_device_init(drm_dev, &rocket_drm_driver, soc_data);
	...
	rdev->num_cores++;
	...
}

If multiple cores are probed concurrently (e.g., via sysfs asynchronous
binding), multiple threads will evaluate `if (rdev =3D=3D NULL)` simultaneo=
usly
without a lock.

Can this create a data race where concurrent threads allocate redundant DRM
devices, overwrite the rdev singleton (causing memory leaks), and corrupt
the shared rdev->num_cores counter and rdev->cores array?

[Severity: Critical]
This is a pre-existing issue, but will kref_put() dereference a NULL pointer
when job initialization fails early or a BO is imported?

drivers/accel/rocket/rocket_job.c:rocket_ioctl_submit_job() {
	...
	goto out_cleanup_job;
	...
out_cleanup_job:
	if (ret)
		drm_sched_job_cleanup(&rjob->base);
out_put_job:
	rocket_job_put(rjob);
}

drivers/accel/rocket/rocket_drv.c:rocket_iommu_domain_put() {
	kref_put(&domain->kref, rocket_iommu_domain_destroy);
}

If an early failure occurs in rocket_ioctl_submit_job() (e.g., in
rocket_copy_tasks() or drm_gem_objects_lookup()), the error path calls
rocket_job_put(), which invokes rocket_job_cleanup(). At this point,
job->domain is still NULL.

rocket_job_cleanup() unconditionally passes this to rocket_iommu_domain_put=
(),
which immediately evaluates &domain->kref and causes a NULL pointer
dereference.

The same panic appears to occur when a BO is imported via PRIME
(rocket_gem_create_object() leaves domain NULL), and rocket_gem_bo_free()
subsequently accesses bo->domain->domain and bo->domain.

[Severity: High]
This is a pre-existing issue, but could the error path in BO creation free =
an
object that is already owned by the handle table?

drivers/accel/rocket/rocket_gem.c:rocket_ioctl_create_bo() {
	...
	ret =3D drm_gem_handle_create(file, gem_obj, &args->handle);
	drm_gem_object_put(gem_obj);
	if (ret)
		goto err;
	...
err:
	drm_gem_shmem_object_free(gem_obj);
}

drm_gem_handle_create() successfully exposes gem_obj to userspace and
increments its handle refcount, after which the local reference is correctly
dropped via drm_gem_object_put().

If a subsequent step fails (such as drm_gem_shmem_get_pages_sgt()), the err=
or
path jumps to err: and manually calls drm_gem_shmem_object_free(gem_obj).

This explicitly frees the backing memory while the object is still actively
referenced by the handle table. When userspace later closes the handle, will
the GEM core double-free the object?

[Severity: High]
This is a pre-existing issue, but should the asynchronous reset work be
canceled before the DRM scheduler is destroyed?

drivers/accel/rocket/rocket_job.c:rocket_job_fini() {
	drm_sched_fini(&core->sched);

	cancel_work_sync(&core->reset.work);
	destroy_workqueue(core->reset.wq);
}

drm_sched_fini(&core->sched) is called before cancel_work_sync(&core->reset=
.work).

If the background reset task rocket_reset_work() is running concurrently,
it will execute rocket_reset(), which attempts to call drm_sched_stop() and
drm_sched_start() on the core->sched instance that has already been torn do=
wn
or freed.

[Severity: High]
This is a pre-existing issue, but could the shared interrupt handler access
hardware registers without checking the PM state, and does suspend execute
without synchronizing IRQs?

drivers/accel/rocket/rocket_job.c:rocket_job_irq_handler() {
	struct rocket_core *core =3D data;
	u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
	...
}

drivers/accel/rocket/rocket_drv.c:rocket_device_runtime_suspend() {
	...
	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores=
[core].clks);

	return 0;
}

The driver requests its interrupt using IRQF_SHARED, meaning
rocket_job_irq_handler() can execute at any time if another device on the s=
ame
line interrupts the CPU.

When called, the handler immediately reads hardware registers
(INTERRUPT_RAW_STATUS) without using pm_runtime_get_if_active() to verify t=
he
device is powered. If the device was suspended, will this read return garba=
ge
or cause a bus fault?

Additionally, the rocket_device_runtime_suspend() callback disables the
device's clocks without invoking synchronize_irq(), which might allow
hardware to lose power while an interrupt handler is executing mid-flight.

[Severity: High]
This is a pre-existing issue, but can a failure in rocket_job_run() leak
the PM usage counter and return an unsignaled hardware fence, hanging the
DRM scheduler?

drivers/accel/rocket/rocket_job.c:rocket_job_run() {
	...
	ret =3D pm_runtime_get_sync(core->dev);
	if (ret < 0)
		return fence;
	...
		ret =3D iommu_attach_group(job->domain->domain, core->iommu_group);
		if (ret < 0)
			return fence;
	...
}

drivers/accel/rocket/rocket_job.c:rocket_reset() {
	scoped_guard(mutex, &core->job_lock) {
		if (core->in_flight_job)
			pm_runtime_put_noidle(core->dev);

		core->in_flight_job =3D NULL;
	}
}

If pm_runtime_get_sync() returns an error, it returns the created fence
directly. Since pm_runtime_get_sync() increments the usage counter even upon
failure, this leaks the PM reference (missing pm_runtime_put_noidle()).

Similarly, if iommu_attach_group() fails shortly after, the function again
returns the fence without dropping the successfully acquired PM reference.

Because the hardware submission is skipped in both error paths, the returned
fence is never signaled. The DRM scheduler will block indefinitely waiting =
for
it, triggering a job timeout.

Will the timeout reset logic (rocket_reset()) fail to clean up these leaked
PM references because core->in_flight_job is evaluated as NULL (it was never
assigned before the early returns)?

> +static const struct rocket_soc_data rk3588_soc_data =3D {
> +	.dma_bits =3D 40,
> +};
> +
>  static const struct of_device_id dt_match[] =3D {
> -	{ .compatible =3D "rockchip,rk3588-rknn-core" },
> +	{ .compatible =3D "rockchip,rk3588-rknn-core", .data =3D &rk3588_soc_da=
ta },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, dt_match);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604135255.6268=
2-1-midgy971@gmail.com?part=3D1
