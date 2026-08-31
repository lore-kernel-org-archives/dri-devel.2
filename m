Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AF3C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3426810E75A;
	Mon, 31 Aug 2026 08:49:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DiQJ30f/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60BE110E75A
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:49:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 20DAA41AAD;
 Mon, 31 Aug 2026 08:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADED01F000E9;
 Mon, 31 Aug 2026 08:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788166142;
 bh=ijAzzobdrK9v1uftPq1rk2JJGtUzAPqOY3nwGtZR9bk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DiQJ30f/TI50Bw7BCJBQPxHCpRMr1RgruBmdM4/u6cMfuEifceJPjUHTi3GXo9VR9
 vgi6WLDO9dQTGCqvraKvYQ5wwtSVmXeYtfxEPxlu6uWsb/SgetZHFWoZbEmaeO3LpG
 EArRhS7XSJnmd3LYW9PxwMEU0z3NNA/do0lGdhe7luCx23OEDQaksA01DBP+hyj7Es
 +usNI74QWp6hRIR0sNXaGPRxqsmpt9gP5hFDos3rWOMP42cBbnTnrVv08Mf4L81HVo
 i1WB58Hfls+Y31gJo/HuaD1mIrfa+Mrfn9pYbD02HyC/lZPKz/z03SSIgRC1Xngepz
 TLsZRLKqbsnxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 04/14] accel/rocket: let the core suspend after a reset
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260831081956.84871-5-gahing@gahingwoo.com>
References: <20260831081956.84871-1-gahing@gahingwoo.com>
 <20260831081956.84871-5-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 08:49:01 +0000
Message-Id: <20260831084901.ADED01F000E9@smtp.kernel.org>
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
- [High] Using asynchronous pm_runtime_put_autosuspend() instead of a synch=
ronous suspend in the reset path prevents the required power domain cycle i=
f the next job is submitted immediately.

Pre-existing issues:
- [High] The shared IRQ handler accesses hardware registers without verifyi=
ng if the device is active, and the runtime suspend callback powers down ha=
rdware without synchronizing with in-flight shared IRQs.
- [High] Reference count leak of the IOMMU group on every job completion in=
 rocket_job_next_locked().
- [High] Detaching the IOMMU before halting the hardware during reset cause=
s SMMU translation faults if the hardware is still active.
--

commit b4995381e41020bdb1af33ec4a432209b68f8226
Author: Jiaxing Hu <gahing@gahingwoo.com>

accel/rocket: let the core suspend after a reset

This patch modifies rocket_reset to drop the PM reference using
pm_runtime_put_autosuspend, allowing the core to suspend and trigger
a bus interface reset upon resuming.

Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.c=
om/

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 3c0ed46050669..a89ab49e17e52 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -406,12 +406,12 @@ rocket_reset(struct rocket_core *core, struct drm_s=
ched_job *bad)
> =20
>  	/*
>  	 * No handler is running now, but we might still have stuck jobs. Let's
> -	 * make sure the PM counters stay balanced by manually calling
> -	 * pm_runtime_put_noidle().
> +	 * make sure the PM counters stay balanced by putting the reference the
> +	 * job took, and request idle while doing it so the core can suspend.
>  	 */
>  	scoped_guard(mutex, &core->job_lock) {
>  		if (core->in_flight_job)
> -			pm_runtime_put_noidle(core->dev);
> +			pm_runtime_put_autosuspend(core->dev);

[Severity: High]
Does using the asynchronous pm_runtime_put_autosuspend() here prevent the
required power domain cycle?

If a queued job is submitted immediately after reset, couldn't the autosusp=
end
timer be canceled before the core actually suspends?

rocket_reset() finishes by restarting the scheduler:

    /* Restart the scheduler */
    drm_sched_start(&core->sched, 0);

If the scheduler restarts and the next job runs immediately, it will take a
PM reference and cancel the autosuspend timer before the suspend happens.
Would using a synchronous suspend instead guarantee the hardware ordering
constraints are met?

> =20
>  		iommu_detach_group(NULL, core->iommu_group);

[Severity: High]
This is a pre-existing issue, but does detaching the IOMMU here before halt=
ing
the hardware risk SMMU translation faults?

If a hung job leaves the hardware actively attempting DMA transactions,
detaching the IOMMU unmaps the device's DMA domain while the transactions a=
re
still in flight.

The hardware is reset and halted after the IOMMU group is already detached:

    iommu_detach_group(NULL, core->iommu_group);
    ...
    /* Proceed with reset now. */
    rocket_core_reset(core);

Should the hardware be halted prior to revoking its DMA mappings?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but does the shared IRQ handler
access hardware registers without verifying the device's PM state?

In rocket_job_irq_handler(), the handler reads a hardware register on a sha=
red
IRQ line:

    u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);

If an interrupt fires for another device sharing the same IRQ line while the
NPU is runtime suspended, won't this read unclocked hardware registers and
potentially cause an asynchronous SError panic?

Additionally, in rocket_device_runtime_suspend(), the hardware is powered d=
own
without synchronizing with in-flight shared IRQs:

    clk_bulk_disable_unprepare(rdev->cores[core].soc->num_clks,=20
                               rdev->cores[core].clks);

Could this crash the kernel if the handler is executing mid-flight while the
clocks are disabled?

[Severity: High]
This is a pre-existing issue, but does rocket_job_next_locked() leak an IOM=
MU
group reference on every normal job completion?

The group reference count is incremented but not decremented when detaching:

    iommu_detach_group(NULL, iommu_group_get(core->dev));

Because jobs execute continuously, won't this eventually saturate the refco=
unt
and permanently leak the IOMMU group object on teardown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831081956.8487=
1-1-gahing@gahingwoo.com?part=3D4
