Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F132CD6E60
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 14:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54F5511A10F;
	Thu,  4 Jun 2026 14:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mpUNTxFm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 069DD11A10F
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 14:10:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 60E9E600B0;
 Thu,  4 Jun 2026 14:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38211F00893;
 Thu,  4 Jun 2026 14:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780582251;
 bh=5TT/lYWkb0Er7E9DGPx2aoH9f3cQJSTb6G1KcVgwSoc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mpUNTxFm1JxBI0+cZxuRGR/cfycG26+bSN/oIBXgy9ypfgDAxJpXyZ/4PAK/6xeTT
 ytEo1jo2LEjZm1F0ss2gU2+L1Y0l/Ef3zdx+FndZvqX/ZXUea4Lf71CwMmnhPn/CL9
 aI6nxU96ZfX/8Afm4wGZKJ8RN/jY7IBlT7DkkGneWXc4VMuAbcrNXdxy+JtT/VFvJ1
 AqAXPwKP3+jlbbYRwbl8RRyKspuhMKr4oJV9W/vx/+3wDpDuplCHX7zm4yuGvbqcX6
 fR74vgj8uOFJDnzb5LoQtydkgu04HAnT+I1RDIEiVllWjxXHoq8zg17YSFCREJudzs
 EYoI7D1oymS+A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 4/9] accel: rocket: Reset the NPU before
 detaching the IOMMU on timeout
To: "Midgy BALON" <midgy971@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260604135255.62682-5-midgy971@gmail.com>
References: <20260604135255.62682-5-midgy971@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 14:10:50 +0000
Message-Id: <20260604141050.D38211F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Double free of rjob->tasks array when copy_from_user() fails.
- [High] The shared IRQ handler unconditionally accesses hardware registers=
 without verifying the device's PM active state.
- [High] Missing PM reference drop and unsignaled fence return on error pat=
hs in `rocket_job_run()`.
- [High] Concurrent hardware reset and IRQ handler execution can cause an e=
xternal abort.
- [High] Unbalanced teardown order in rocket_core_fini() causes UAF and dat=
a races.
- [High] NULL pointer dereference of job->domain in rocket_job_cleanup() on=
 early error paths.
- [High] Missing `synchronize_irq()` in runtime suspend callback.
- [Medium] The TDR reset path permanently leaks power by preventing the dev=
ice from entering runtime suspend.
- [Medium] The hardware reset is performed after dropping the PM runtime re=
ference, potentially targeting an unpowered device.
--

commit 323afa3b038052ef6c02ee0548658a65126910a0
Author: Midgy BALON <midgy971@gmail.com>

accel: rocket: Reset the NPU before detaching the IOMMU on timeout

On a job timeout the NPU AXI master can be left wedged with outstanding
transactions. rocket_reset() detached the IOMMU group before resetting
the hardware, causing the IOMMU core to stall. Assert the core reset
first to quiesce the master so the detach completes cleanly.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -364,14 +364,20 @@ rocket_reset(struct rocket_core *core, struct drm_s=
ched_job *bad)
>  		if (core->in_flight_job)
>  			pm_runtime_put_noidle(core->dev);

[Severity: Medium]
This is a pre-existing issue, but does this TDR reset path permanently leak
power by preventing the device from entering runtime suspend?

It appears pm_runtime_put_noidle() drops the reference without triggering an
idle power-down. If the timed-out job was the last active job, the usage co=
unt
reaches zero but the device remains in the RPM_ACTIVE state indefinitely,
staying powered on until another job is submitted and correctly triggers
autosuspend.

> -		iommu_detach_group(NULL, core->iommu_group);
> -
>  		core->in_flight_job =3D NULL;
>  	}
> =20
> -	/* Proceed with reset now. */
> +	/*
> +	 * Reset the NPU hardware before detaching the IOMMU. A timed-out job
> +	 * leaves the NPU AXI master wedged; detaching the IOMMU then issues a
> +	 * stall request that never drains and times out (warning in the IOMMU
> +	 * core). Asserting the core reset first quiesces the master so the
> +	 * detach completes cleanly.
> +	 */
>  	rocket_core_reset(core);

[Severity: High]
This isn't a bug introduced by this patch, but can a concurrent hardware re=
set
and IRQ handler execution cause an external abort?

rocket_core_reset() asserts a hardware reset without first disabling device
interrupts. If an interrupt fires just before or during the reset,
rocket_job_irq_handler() will execute and perform MMIO reads and writes to =
the
bus while the hardware is actively in reset.

[Severity: Medium]
This is also a pre-existing issue, but is it safe to perform the hardware
reset after dropping the PM runtime reference?

Dropping the PM reference via pm_runtime_put_noidle() earlier decrements the
usage count. A concurrently scheduled autosuspend timer could expire precis=
ely
in this window and power down the device before or during the reset operati=
ons.

Asserting resets on a suspended device can lead to system bus faults. Should
the PM reference be dropped after the hardware reset is complete?

> +
> +	iommu_detach_group(NULL, core->iommu_group);
> +
>  	/* NPU has been reset, we can clear the reset pending bit. */
>  	atomic_set(&core->reset.pending, 0);


[Severity: High]
This isn't a bug introduced by this patch, but does the shared IRQ handler
unconditionally access hardware registers without verifying the device's PM
active state?

drivers/accel/rocket/rocket_job.c:rocket_job_irq_handler() {
    ...
    u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
    ...
}

The driver registers rocket_job_irq_handler() with the IRQF_SHARED flag.
Without first calling pm_runtime_get_if_active(), if the NPU is runtime
suspended, this read accesses an unpowered register domain. This typically
returns 0xffffffff (causing spurious handling) or triggers a synchronous
external abort.


[Severity: High]
This is a pre-existing issue, but does rocket_job_run() leak the PM referen=
ce
and return an unsignaled fence on error paths?

drivers/accel/rocket/rocket_job.c:rocket_job_run() {
    ...
    ret =3D pm_runtime_get_sync(core->dev);
    if (ret < 0)
        return fence;
    ...
}

If pm_runtime_get_sync() or iommu_attach_group() fails, the function returns
a newly created, un-signaled fence instead of an error pointer, and leaves
the PM usage counter incremented. Because the hardware submission step is
skipped, the hardware will never signal this fence, causing the DRM schedul=
er
to hang indefinitely.


[Severity: High]
This is a pre-existing issue, but does the teardown order in rocket_core_fi=
ni()
cause a use-after-free and data races?

drivers/accel/rocket/rocket_core.c:rocket_core_fini() {
    ...
    iommu_group_put(core->iommu_group);
    core->iommu_group =3D NULL;
    rocket_job_fini(core);
    ...
}

Resources are torn down in the wrong order. The iommu_group and attached_do=
main
members are freed, and pm_runtime_disable() is called before rocket_job_fin=
i().

If a scheduled job is processed by the DRM scheduler during this window,
rocket_job_run() will concurrently access the now-NULL iommu_group without
locking. Should rocket_job_fini() be called first to stop the scheduler and
wait for jobs?


[Severity: Critical]
This isn't a bug introduced by this patch, but is there a double free of the
rjob->tasks array when copy_from_user() fails?

drivers/accel/rocket/rocket_job.c:rocket_copy_tasks() {
    ...
fail:
    kvfree(rjob->tasks);
    return ret;
}

If copy_from_user() fails, it frees rjob->tasks but leaves the dangling poi=
nter.

The function returns an error, prompting rocket_ioctl_submit_job() to jump =
to
out_cleanup_job and call rocket_job_put(rjob). This invokes
rocket_job_cleanup(), which unconditionally calls kvfree(job->tasks),
resulting in a double-free.


[Severity: High]
This is a pre-existing issue, but does rocket_job_cleanup() dereference a N=
ULL
job->domain on early error paths?

drivers/accel/rocket/rocket_job.c:rocket_job_cleanup() {
    ...
    rocket_iommu_domain_put(job->domain);
    ...
}

The job->domain structure is initially NULL and only populated late in the
function. If an earlier step fails (such as rocket_copy_tasks()), the clean=
up
unconditionally calls rocket_iommu_domain_put(job->domain).

This wrapper dereferences the domain struct to access its kref without a
NULL check:

drivers/accel/rocket/rocket_drv.c:rocket_iommu_domain_put() {
    kref_put(&domain->kref, rocket_iommu_domain_destroy);
}


[Severity: High]
This isn't a bug introduced by this patch, but is there a missing
synchronize_irq() in the runtime suspend callback?

drivers/accel/rocket/rocket_drv.c:rocket_device_runtime_suspend() {
    ...
    clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks),
                               rdev->cores[core].clks);
    ...
}

The driver registers a shared interrupt but fails to call synchronize_irq().
Disabling the clocks while the IRQ handler is executing concurrently on ano=
ther
CPU could cause an AXI bus fault or a hard system crash.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604135255.6268=
2-1-midgy971@gmail.com?part=3D4
