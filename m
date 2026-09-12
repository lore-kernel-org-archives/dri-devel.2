Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA538C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 07:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD5B10E430;
	Sat, 12 Sep 2026 07:04:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ug3q2qJi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8DA210E430
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 07:04:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AEBF640B0F;
 Sat, 12 Sep 2026 07:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CE11F000FF;
 Sat, 12 Sep 2026 07:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789196652;
 bh=WGTEOOmjMhhqUxUPp/CNVoqJhWrkiEwPPBA+ZB9u8kw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ug3q2qJiGNL6sLhqlyMbasXfLN5ZatmeLRGZrbdWF74M1+o1KRMYWWL4d5V/rppLi
 5FBAa2Fy19jV8u9PMCXSEtUuUGPbj89tz0XbVp/61z2r6IsOG0K6zaqGwHNOcyQA01
 Jm+q/Jh8klaiLYK08un5G9dRCK5hLkOstgmEs8dlA+jKcZ6FaRS0U4atpmhWUIBm2V
 ihAnahjT1nnL5zHY7ja9ALbsme2QLBTKoTm3eGYpBvKiFZ2kaPnN5OWtJdGRAd9E96
 sHz6OzzEaNuxVDZ7kop4ebooUiIFfPHFKD2VBHZQ95XcMuAs3wJwZSggE6mJAZokmA
 Q0eE18p3ar8gQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 02/14] accel/rocket: take the completion register
 writes under job_lock
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260912065053.1519165-3-gahing@gahingwoo.com>
References: <20260912065053.1519165-1-gahing@gahingwoo.com>
 <20260912065053.1519165-3-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 07:04:11 +0000
Message-Id: <20260912070412.44CE11F000FF@smtp.kernel.org>
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

Pre-existing issues:
- [High] The shared hardirq handler accesses hardware registers without che=
cking if the device is active via pm_runtime_get_if_active(), causing spuri=
ous interrupts and potential bus faults when suspended.
- [High] The runtime suspend callback disables hardware clocks without firs=
t calling `synchronize_irq()`, leading to potential race conditions and har=
dware lockups with the shared IRQ handler.
- [Medium] Leak of IOMMU group kobject reference in `rocket_job_handle_irq(=
)`.
- [Medium] The module removal path calls `pm_runtime_disable()` which can c=
ancel a pending asynchronous autosuspend, leaving the hardware clocks perma=
nently enabled.
--

commit 628f481e9ee69f13147956ea2124dd232b5d1c38
Author: Jiaxing Hu <gahing@gahingwoo.com>

accel/rocket: take the completion register writes under job_lock

This patch fixes a race condition by moving the OPERATION_ENABLE and
INTERRUPT_CLEAR register writes inside the job_lock scoped_guard. This ensu=
res
that stopping the block and deciding what to start next are performed as a
single atomic step.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index f404355058185..575945015ca3b 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -345,10 +345,15 @@ static void rocket_job_handle_irq(struct rocket_cor=
e *core)
>  {
>  	pm_runtime_mark_last_busy(core->dev);
> =20
> -	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
> -	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
> +	scoped_guard(mutex, &core->job_lock) {
> +		/*
> +		 * Stopping the block belongs under the lock. hw_submit() writes
> +		 * OPERATION_ENABLE too, and outside the lock this zero can land
> +		 * after that one and stop a task that has only just started.
> +		 */
> +		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
> +		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
> =20
> -	scoped_guard(mutex, &core->job_lock)
>  		if (core->in_flight_job) {
>  			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_co=
unt) {
>  				rocket_job_hw_submit(core, core->in_flight_job);

[Severity: Medium]
This is a pre-existing issue, but does this code leak a kobject
reference every time a job completes?

Just below this hunk in rocket_job_handle_irq(), the completion path has:

			iommu_detach_group(NULL, iommu_group_get(core->dev));

Calling iommu_group_get(core->dev) retrieves the group and increments its
reference count.

However, iommu_detach_group() does not consume this reference, and there is
no matching iommu_group_put() in this path.

Could this be fixed by using the pre-cached core->iommu_group instead?

[ ... ]


[Severity: High]
This is a pre-existing issue, but can the shared IRQ handler cause an
asynchronous bus fault or spurious handling when the device is suspended?

The interrupt is registered as IRQF_SHARED in rocket_job_init():

drivers/accel/rocket/rocket_job.c:rocket_job_init() {
    ...
	ret =3D devm_request_threaded_irq(core->dev, core->irq,
					rocket_job_irq_handler,
					rocket_job_irq_handler_thread,
					IRQF_SHARED, dev_name(core->dev), core);
    ...
}

If another device on the same shared line triggers an interrupt while the
rocket device is runtime-suspended, the handler blindly reads from the hard=
ware:

drivers/accel/rocket/rocket_job.c:rocket_job_irq_handler() {
	struct rocket_core *core =3D data;
	u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
    ...
}

This unprotected read will typically return 0xffffffff when clocks are
disabled, which satisfies the bitmask checks and causes the handler to wake
the IRQ thread. The thread then executes on powered-off hardware.

Per subsystem guidelines, should we check if the device is active using
pm_runtime_get_if_active() before accessing registers here?


[Severity: High]
This is a pre-existing issue, but does the runtime suspend callback disable
clocks while the shared IRQ handler might still be executing?

drivers/accel/rocket/rocket_drv.c:rocket_device_runtime_suspend() {
	...
	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks),
				   rdev->cores[core].clks);

	return 0;
}

Since the interrupt is registered as IRQF_SHARED, the handler could be runn=
ing
concurrently on another CPU.

If clocks are disabled exactly while the in-flight handler attempts to acce=
ss
hardware registers, it will cause a hardware lockup.

Per subsystem guidelines, drivers using IRQF_SHARED must call
synchronize_irq() in their runtime suspend callback before powering down.

Should a synchronize_irq() call be added here?


[Severity: Medium]
This is a pre-existing issue, but can unloading the module leave the hardwa=
re
powered on permanently?

At the end of rocket_core_init() and during job completions, an autosuspend
is scheduled using pm_runtime_put_autosuspend(). However, the removal path
calls pm_runtime_disable() directly:

drivers/accel/rocket/rocket_core.c:rocket_core_fini() {
	pm_runtime_dont_use_autosuspend(core->dev);
	pm_runtime_disable(core->dev);
	iommu_group_put(core->iommu_group);
    ...
}

Calling pm_runtime_disable() cancels any pending asynchronous autosuspend w=
ork.

If the module is removed while an autosuspend is pending, the device is left
powered on with clocks enabled.

Should we ensure the device is fully suspended (e.g., using
pm_runtime_put_sync()) before disabling runtime PM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912065053.1519=
165-1-gahing@gahingwoo.com?part=3D2
