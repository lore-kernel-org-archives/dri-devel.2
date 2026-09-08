Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F50C79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7B5B10E545;
	Tue,  8 Sep 2026 22:18:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SalXP7lN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67DA910E545
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:18:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7263B601F9
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25721F00A3A;
 Tue,  8 Sep 2026 22:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788905898;
 bh=PBrIP2DJBT88HSlRiXtLS4awhCcSQfSKt0kBQOARubg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SalXP7lNgsGJgQ/OwtvxY4chRAmhOeNDxNl3Ua8timC4XK+EkCQl+SpfcwijPCO7n
 JWp9AgT3AZGH9YS8Z0DkVKkESkkHisvyu3icNrpizQnxZ6LOcknsqj+AS7FAro0jkt
 xf3RaXhEn0r7sfVIA/c0xaSrpmAg48FHS1HCkcY+5fCWyni1uF4t1hxfPUjsZazgq9
 Q/iHgM6u27WLl/IPWZBwxG79b5d5XqalBEk62ExZ/hi10hrXth6cKzEcIlkLQYIKyV
 N1Zn6HNpuY/T7z+IrgkueDFMcOI5p3jvvt5TpwleLWaNgQKjc+CGvI0bXZAt80wI5O
 1LRNz+QkLL01A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/22] accel: ethosu: Disable clocks on PM setup failure
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-ethosu-fixes-v3-4-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
 <20260908-ethosu-fixes-v3-4-490fe215286f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 22:18:17 +0000
Message-Id: <20260908221817.F25721F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] The IRQ handler accesses hardware registers unconditionally withou=
t verifying if the device is active via pm_runtime_get_if_active(), risking=
 a system crash on spurious interrupts.
- [High] DRM scheduler is finalized before its file-bound entities are dest=
royed, resulting in a Use-After-Free.
- [High] NPU SRAM is not cleared between consecutive jobs from different pr=
ocesses, leading to data leakage.
- [High] Missing upper bound check against UAPI array size leads to out-of-=
bounds read/write in `ethosu_ioctl_perfmon_create`.
- [High] Unvalidated hardware register `QREAD` used as an array index cause=
s out-of-bounds memory read in `ethosu_job_timedout`.
--

commit 9bfcf97ff7178db9d34db7f9533d5df371a4f57c
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Disable clocks on PM setup failure

ethosu_init() enables the clocks directly to reset and query the NPU
before runtime PM takes over. If runtime-PM setup fails, the error path
returns while those clocks remain enabled. Disable the clocks before
returning the setup error to balance the initial direct resume.

> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/eth=
osu_drv.c
> index 2c8d735767b2a..9d063daa1aa7d 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -311,8 +311,10 @@ static int ethosu_init(struct ethosu_device *ethosud=
ev)
>  	pm_runtime_set_autosuspend_delay(ethosudev->base.dev, 50);
>  	pm_runtime_use_autosuspend(ethosudev->base.dev);
>  	ret =3D devm_pm_runtime_set_active_enabled(ethosudev->base.dev);
> -	if (ret)
> +	if (ret) {
> +		ethosu_device_suspend(ethosudev->base.dev);
>  		return ret;
> +	}
>  	pm_runtime_get_noresume(ethosudev->base.dev);
> =20
>  	ethosudev->npu_info.id =3D id =3D readl_relaxed(ethosudev->regs + NPU_R=
EG_ID);


> drivers/accel/ethosu/ethosu_job.c:ethosu_job_irq_handler()
> {
> 	struct ethosu_device *dev =3D data;
> 	u32 status =3D readl_relaxed(dev->regs + NPU_REG_STATUS);
>=20
> 	if (!(status & STATUS_IRQ_RAISED))
> 		return IRQ_NONE;

[Severity: High]
This is a pre-existing issue, but does this IRQ handler need to verify if
the device is active?

If a spurious interrupt occurs while the device is in the RPM_SUSPENDED
state with clocks disabled, will this unclocked register access result in a
synchronous external abort and a kernel panic?

Should this check pm_runtime_get_if_active() before accessing the register?


> drivers/accel/ethosu/ethosu_job.c:ethosu_job_fini()
> {
> 	drm_sched_fini(&dev->sched);
> }
>=20
> [ ... ]
>=20
> drivers/accel/ethosu/ethosu_job.c:ethosu_job_close()
> {
> 	struct drm_sched_entity *entity =3D &ethosu_priv->sched_entity;
>=20
> 	drm_sched_entity_destroy(entity);
> }

[Severity: High]
This is a pre-existing issue, but does this lead to a use-after-free when
closing file descriptors?

When the device is unbound, ethosu_remove() tears down the scheduler.
However, if a userspace process holds a file descriptor open, its
sched_entity remains active.

When the file descriptor is later closed, ethosu_job_close() calls
drm_sched_entity_destroy().

Will drm_sched_entity_destroy() attempt to access the already destroyed
and freed scheduler via entity->rq->sched, causing a panic?


> drivers/accel/ethosu/ethosu_job.c:ethosu_job_hw_submit()
> {
> 	[ ... ]
>=20
> 	if (job->sram_size) {
> 		writel_relaxed(lower_32_bits(dev->sramphys),
> 			       dev->regs + NPU_REG_BASEP(ETHOSU_SRAM_REGION));

[Severity: High]
This is a pre-existing issue, but is there a data leakage risk here?

The NPU SRAM is shared globally across jobs. It appears it is only cleared
during ethosu_device_reset() when runtime PM resumes. Because the driver
uses a 50ms autosuspend delay, consecutive jobs submitted within 50ms do
not trigger a suspend/resume cycle and the SRAM is not cleared.

Can a malicious process submit a job immediately after another process's
job and craft a command stream to DMA the contents of the
ETHOSU_SRAM_REGION to its own memory, exfiltrating the previous process's
weights or intermediate activations?


> drivers/accel/ethosu/ethosu_perfmon.c:ethosu_ioctl_perfmon_create()
> {
> 	/* Number of monitored counters cannot exceed HW limits. */
> 	if (req->ncounters > ethosu->npu_info.pmu_counters)
> 		return -EINVAL;
>=20
> 	[ ... ]
>=20
> 	perfmon =3D kzalloc_flex(*perfmon, values, req->ncounters);
> 	if (!perfmon)
> 		return -ENOMEM;
>=20
> 	for (i =3D 0; i < req->ncounters - 1; i++)
> 		perfmon->counters[i] =3D req->counters[i];

[Severity: High]
This is a pre-existing issue, but does this lack an upper bound check on
the UAPI array size?

The function validates req->ncounters against the hardware-reported count
rather than the static UAPI array size limit
(DRM_ETHOSU_MAX_PERF_EVENT_COUNTERS, which is 8).

If the hardware reports more than 8 counters, and userspace passes
req->ncounters > 8, will this loop read past the end of the req->counters
array and write past the end of the perfmon->counters array, corrupting the
dynamically allocated values array?


> drivers/accel/ethosu/ethosu_job.c:ethosu_job_timedout()
> {
> 	[ ... ]
>=20
> 	cmdaddr =3D readl_relaxed(dev->regs + NPU_REG_QREAD);
>=20
> 	[ ... ]
>=20
> 	dev_err(dev->base.dev, "NPU sched timed out: NPU %s, cmdstream offset 0x=
%x: 0x%x\n",
> 		running ? "running" : "stopped",
> 		cmdaddr, bocmds[cmdaddr / 4]);

[Severity: High]
This is a pre-existing issue, but can this cause an out-of-bounds memory
read?

Since cmdaddr is read directly from the hardware and entirely unvalidated,
if userspace crafts a malformed command stream that hangs the NPU and
leaves QREAD with a large value, will cmdaddr / 4 exceed the bounds of the
mapped bocmds buffer and cause an invalid memory access?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-ethosu-fix=
es-v3-0-490fe215286f@kernel.org?part=3D4
