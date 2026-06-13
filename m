Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E115CCD98D2
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 07:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46E4210ECD1;
	Sat, 13 Jun 2026 07:15:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Czk0Pbia";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADDF610ECD1
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 07:15:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DA89860018;
 Sat, 13 Jun 2026 07:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4A11F000E9;
 Sat, 13 Jun 2026 07:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781334955;
 bh=OR9er5a0qh/SaSMqPI4wPpGfPB6L2mMsLIi2N2hTHYE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Czk0PbiavbuNGywdutZfh3aB961yzUOAFeutuvCvg91vyHMV4f0hF5LlL1v7foF5r
 3f9Px0dwutfBdcrF/SMD7tOWK906gQNa83txM/cxxIBEuezgCSrUTgEnYVUCrnh89c
 8vfJnrbiJhEtGZIeH9Xh0+V2PoCZpl4Jiy55AAcsmh/GZV99Hcq1zOf185jl2kdTKO
 qK+UcJplVNfGiy1LhKWVzbloSGJztSprz6gWTQI/sLaof2AJZMqxUiAbzAmtMlI1Mz
 uGs0qJbMcUsm0giEhgpiX/Ch1eiwjEF/tzJAdxmdet47sqJNmS+KgwLvYfVhGQSGeK
 jDup2kGB/1sNA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 4/9] accel: rocket: Reset the NPU before
 detaching the IOMMU on timeout
To: MidG971 <midgy971@gmail.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260613070116.438906-5-midgy971@gmail.com>
References: <20260613070116.438906-5-midgy971@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 07:15:54 +0000
Message-Id: <20260613071555.3E4A11F000E9@smtp.kernel.org>
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
- [Critical] Double free of `rjob->tasks` when `rocket_copy_tasks` fails.
- [High] The shared IRQ handler accesses hardware registers without checkin=
g if the device is active via pm_runtime_get_if_active().
- [High] The runtime suspend callback powers down the hardware without sync=
hronizing the shared IRQ.
- [High] Timeout recovery drops the PM usage count early via `pm_runtime_pu=
t_noidle()`, stranding the device in an active power state and introducing =
a race condition.
- [High] PM runtime usage counter leaks on error paths during job submissio=
n.
- [High] Driver removal cancels pending PM transitions without synchronous =
suspend.
- [High] Missing NULL check on `iommu_group_get()` leads to crash if device=
 lacks an IOMMU.
--

commit 54a038a17307496e6d47b23eab270cebaf07629e
Author: Midgy BALON <midgy971@gmail.com>

accel: rocket: Reset the NPU before detaching the IOMMU on timeout

This commit fixes a timeout issue where detaching the IOMMU before resettin=
g=20
the wedged NPU AXI master causes a stall. By asserting the core reset first=
,=20
the AXI master is quiesced and the IOMMU detach completes cleanly.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index ac51bff39833f..e25234261536b 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -364,14 +364,20 @@ rocket_reset(struct rocket_core *core, struct drm_s=
ched_job *bad)
>  		if (core->in_flight_job)
>  			pm_runtime_put_noidle(core->dev);

[Severity: High]
This is a pre-existing issue, but does using pm_runtime_put_noidle() here
leave the device stranded in an active power state?

Without restarting the autosuspend timer or scheduling an idle callback, the
usage counter is dropped while leaving the device active.=20

Could this also create a race condition if an idle check is triggered
concurrently (such as via a sysfs write), causing the device to begin
suspending while the subsequent rocket_core_reset() is toggling reset lines?

> =20
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
> =20
> +	iommu_detach_group(NULL, core->iommu_group);
> +
>  	/* NPU has been reset, we can clear the reset pending bit. */
>  	atomic_set(&core->reset.pending, 0);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but looking at the shared IRQ
handler:

drivers/accel/rocket/rocket_job.c:rocket_job_irq_handler() {
    ...
    u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
    ...
}

Is it possible that this accesses hardware registers without verifying if t=
he
device is active?

If the NPU is suspended and another device triggers the shared interrupt li=
ne,
could this read from powered-off hardware and return invalid data
(like 0xffffffff)?

Might this be misinterpreted as a valid interrupt, leading to spurious
threaded IRQ execution and potential bus crashes?

Is it necessary to use pm_runtime_get_if_active() to verify the power state
first?

[Severity: High]
This isn't a bug introduced by this patch, but does the runtime suspend
callback power down hardware without synchronizing the shared IRQ?

drivers/accel/rocket/rocket_drv.c:rocket_device_runtime_suspend() {
    ...
    clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks),
                               rdev->cores[core].clks);
    ...
}

Since the driver uses a shared IRQ (IRQF_SHARED), could the handler execute=
=20
mid-flight on another CPU while the hardware is actively being shut down?

Should this call synchronize_irq() before disabling hardware clocks to prev=
ent
bus errors or system crashes?

[Severity: High]
This is a pre-existing issue, but does rocket_job_run() leak the PM usage
counter on error paths?

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

If either pm_runtime_get_sync() or iommu_attach_group() fails, would return=
ing
an unsignaled fence early without balancing the usage counter via
pm_runtime_put_noidle() permanently leak the PM reference?

Might this prevent the device from ever entering runtime suspend, while also
leaving the DRM scheduler stalled on a dead fence until it times out?

[Severity: High]
This is a pre-existing issue, but does driver removal cancel pending PM
transitions without a synchronous suspend?

drivers/accel/rocket/rocket_core.c:rocket_core_fini() {
    ...
    pm_runtime_disable(core->dev);
    ...
}

Because pm_runtime_disable() cancels pending asynchronous transitions (such=
 as
the autosuspend timer), wouldn't the NPU hardware clocks be left running
indefinitely after the driver is removed and the device is unbound?

Is a call to pm_runtime_put_sync() needed before disabling runtime PM?

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing NULL chec=
k=20
when fetching the IOMMU group?

drivers/accel/rocket/rocket_core.c:rocket_core_init() {
    ...
    core->iommu_group =3D iommu_group_get(dev);
    ...
}

If the device lacks an IOMMU (for example, if it is disabled by the user or
failed to probe), will iommu_group_get() return NULL?

If so, when rocket_job_run() later executes:

drivers/accel/rocket/rocket_job.c:rocket_job_run() {
    ...
    ret =3D iommu_attach_group(job->domain->domain, core->iommu_group);
    ...
}

Would this unconditionally dereference the group pointer and cause a kernel
panic on the first job submission?

[Severity: Critical]
This is a pre-existing issue, but does a failure in rocket_copy_tasks() lea=
d=20
to a double free?

drivers/accel/rocket/rocket_job.c:rocket_copy_tasks() {
    ...
fail:
    kvfree(rjob->tasks);
    return ret;
}

If this fails (such as from an invalid pointer during copy_from_user()), the
tasks array is freed, but is rjob->tasks left as a dangling pointer?

When the caller jumps to out_cleanup_job and invokes rocket_job_put(rjob),
it reaches:

drivers/accel/rocket/rocket_job.c:rocket_job_cleanup() {
    ...
    kvfree(job->tasks);
    ...
}

Will this result in freeing the dangling pointer a second time?

Can this double free corrupt kernel memory or cause a panic, potentially
being exploitable by an unprivileged user?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613070116.4389=
06-1-midgy971@gmail.com?part=3D4
