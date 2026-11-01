Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85449606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FT1cM/BV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB4710E16D;
	Sun,  1 Nov 2026 08:55:33 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 829F310E16D
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 08:55:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 423AC60234;
 Sun,  1 Nov 2026 08:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB651F000C1;
 Sun,  1 Nov 2026 08:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793523326;
 bh=eE788gI861gE25/RiB5yUbwdO89a2sP4vgp4wdOzjis=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FT1cM/BVLnIQFSFEQdMBC/irZpgZ8I9cgbokrXMmLfuRm0QXZ7yJn1mhBm0We8I+F
 mZLhTI61skR1nxtr6w0knLj6uQCvn0QCUJedxSMCaGV5Nh6G92Ywah1hvl80CfdPXt
 4nc3MylBp7bs5ms+G9zTI3+Q5HgkUuAM2fRSd33nPnVGOXCBxI7Du6YZhagRwyoyhO
 +AeVN6/m1PCwq3Z8F9ZqqOJrdFqW8Kaa17E6cafjFJuTnYy+HwDKfOP7VGZAwZDBIa
 Sf7xjM3wUy8P9zzalJC7J38WvtgJHhp1PunAtXzeVonABpUM0tkKaWoJGecVRTNJ6H
 YagCn0JYp2Psw==
Message-ID: <sashiko-outbox-192342@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 03/15] accel/rocket: wait for a running IRQ handler
 before resetting a core
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261101082307.151957-4-gahing@gahingwoo.com>
References: <20261101082307.151957-1-gahing@gahingwoo.com>
 <20261101082307.151957-4-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 08:55:25 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] accel/rocket: raw IRQ status can re-latch before reset in rocket_r=
eset()
- [High] accel/rocket: race with pm_runtime_force_suspend() in rocket_reset=
()
--

commit 678645d3ffb5af090f4c6f7400dc95c3975b295a
Author: Jiaxing Hu <gahing@gahingwoo.com>

accel/rocket: wait for a running IRQ handler before resetting a core

This commit masks and clears the NPU core's interrupts under job_lock when
pm_runtime_get_if_active() succeeds, then calls synchronize_irq() outside
job_lock in rocket_reset() after drm_sched_stop().

Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.c=
om/
Link: https://lore.kernel.org/all/CAEWPSH5mxTbUkNouxm6yecMZYvDowquhvYvhaXQ8=
HoMtHD5U1g@mail.gmail.com/
Link: https://lore.kernel.org/all/20260912113717.6819-1-royalnet026@gmail.c=
om/
Link: https://lore.kernel.org/all/20260916132824.13527-1-royalnet026@gmail.=
com/
Link: https://lore.kernel.org/all/20260919103422.148834-1-royalnet026@gmail=
.com/

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 03e5f094f60bf..5b2abf40b618c 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -401,9 +401,74 @@ rocket_reset(struct rocket_core *core, struct drm_sc=
hed_job *bad)
>  	drm_sched_stop(&core->sched, bad);

[ ... ]

> +	scoped_guard(mutex, &core->job_lock) {
> +		if (pm_runtime_get_if_active(core->dev) > 0) {
> +			rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
> +			rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
> +			pm_runtime_put_autosuspend(core->dev);
> +		}
> +	}

[Severity: High]
As reported by Igor Paunovic on v8 [1], can rocket_reset() still race with
pm_runtime_force_suspend() or rocket_core_fini() here?

When rocket_job_timedout() runs rocket_reset() on core->reset.wq (which is
allocated via alloc_ordered_workqueue() without WQ_FREEZABLE),
drm_sched_stop() subtracts the pending jobs' credits from
core->sched.credit_count. Because rocket_job_is_idle() in
drivers/accel/rocket/rocket_job.c only checks credit_count:

int rocket_job_is_idle(struct rocket_core *core)
{
	/* If there are any jobs in this HW queue, we're not idle */
	if (atomic_read(&core->sched.credit_count))
		return false;

	return true;
}

and rocket_device_runtime_suspend() in drivers/accel/rocket/rocket_drv.c on=
ly
checks rocket_job_is_idle() without taking core->job_lock:

	if (!rocket_job_is_idle(&rdev->cores[core]))
		return -EBUSY;

	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores=
[core].clks);

what prevents a concurrent pm_runtime_force_suspend() from disabling the co=
re
clocks after pm_runtime_get_if_active(core->dev) returns 1? Unlike normal
runtime suspend, pm_runtime_force_suspend() does not check
dev->power.usage_count, and __pm_runtime_disable() only waits in
__pm_runtime_barrier() for RPM_SUSPENDING or RPM_RESUMING transitions rather
than usage_count reaching zero, so clk_bulk_disable_unprepare() and
pm_clk_suspend() can turn off the clocks while rocket_reset() is executing
rocket_pc_writel() on INTERRUPT_MASK and INTERRUPT_CLEAR.

Conversely, in rocket_core_fini() in drivers/accel/rocket/rocket_core.c:

void rocket_core_fini(struct rocket_core *core)
{
	pm_runtime_dont_use_autosuspend(core->dev);
	pm_runtime_disable(core->dev);
	iommu_group_put(core->iommu_group);
	core->iommu_group =3D NULL;
	rocket_job_fini(core);
}

if core->in_flight_job is still non-NULL when rocket_core_fini() runs, its
runtime PM reference keeps usage_count >=3D 1 until after synchronize_irq()=
 in
rocket_reset(). Doesn't pm_runtime_dont_use_autosuspend() then leave the co=
re
powered on while pm_runtime_disable() increments disable_depth, causing
pm_runtime_get_if_active(core->dev) in rocket_reset() to return -EINVAL and
skip masking INTERRUPT_MASK and clearing INTERRUPT_CLEAR on an active core?

> +
> +	/*
> +	 * drm_sched_stop() returns without waiting for a threaded handler that
> +	 * is already running, so wait for one here. This has to stay outside
> +	 * job_lock: the handler takes that lock, so waiting for it while
> +	 * holding it would deadlock instead of fencing anything.
> +	 */
> +	synchronize_irq(core->irq);
> +
> +	/*
> +	 * No handler is running now, but we might still have stuck jobs. Let's
> +	 * make sure the PM counters stay balanced by manually calling
> +	 * pm_runtime_put_noidle().
> +	 */
>  	scoped_guard(mutex, &core->job_lock) {

[Severity: High]
Can an active NPU task complete after INTERRUPT_CLEAR is written in
rocket_reset(), re-latching INTERRUPT_RAW_STATUS before rocket_core_reset()
stops the hardware?

In rocket_job_handle_irq() in drivers/accel/rocket/rocket_job.c, the
completion path clears OPERATION_ENABLE before writing INTERRUPT_CLEAR:

	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);

However, rocket_reset() only writes INTERRUPT_MASK and INTERRUPT_CLEAR while
the NPU core is still running, and does not call rocket_core_reset(core) un=
til
after synchronize_irq(core->irq) and iommu_detach_group(NULL,
core->iommu_group) have already run:

	synchronize_irq(core->irq);

	scoped_guard(mutex, &core->job_lock) {
		if (core->in_flight_job)
			pm_runtime_put_noidle(core->dev);

		iommu_detach_group(NULL, core->iommu_group);

		core->in_flight_job =3D NULL;
	}

	/* Proceed with reset now. */
	rocket_core_reset(core);

If an in-flight DPU task finishes between the INTERRUPT_CLEAR write and
rocket_core_reset(), won't the hardware set PC_INTERRUPT_RAW_STATUS_DPU_0 or
PC_INTERRUPT_RAW_STATUS_DPU_1 in the unmasked INTERRUPT_RAW_STATUS register?
Because rocket_job_irq_handler() checks INTERRUPT_RAW_STATUS rather than the
masked INTERRUPT_STATUS register on the shared IRQ line:

	u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
	...
	if (!(raw_status & PC_INTERRUPT_RAW_STATUS_DPU_0 ||
	      raw_status & PC_INTERRUPT_RAW_STATUS_DPU_1))
		return IRQ_NONE;

	rocket_pc_writel(core, INTERRUPT_MASK, 0x0);

	return IRQ_WAKE_THREAD;

couldn't a shared IOMMU interrupt (such as a fault triggered when
iommu_detach_group() detaches the IOMMU while the NPU core is still perform=
ing
DMA prior to rocket_core_reset()) wake rocket_job_irq_handler_thread() after
synchronize_irq() has already returned?

[1] https://lore.kernel.org/r/CAEWPSH7tM9WQUJ0H13ghkiHGzDcdycC1syTuO5B8DpC6=
cUSnfg@mail.gmail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101082307.1519=
57-1-gahing@gahingwoo.com?part=3D3
