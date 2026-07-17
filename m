Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA68C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D445B10F4C7;
	Fri, 17 Jul 2026 09:21:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PzV0zBM3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8720C10F4C7
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 09:21:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4A1E642E86;
 Fri, 17 Jul 2026 09:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9D81F00A3A;
 Fri, 17 Jul 2026 09:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784280077;
 bh=S4q/auwqqy0D+WoSZ3ZuiAawBAhA78+cv1LPYkDHOmg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PzV0zBM3HiHaGnmLlE1UMuX5I+kmbOhcWXns0uaYOURE2GDgAu7rN7I/gTSiCRJ0S
 amb2ZPHWRHc07wO4gfhMnROu/m1cNp5DBFgUmaHtqRlqXVXXtFLcaHHk34ndRPePmh
 7UTiJXJKNmbsNVxIexNoqqMfegQLAb9DGhG/EmaL5TmdUJOiPIAWDNG/C1LfvjFxxA
 EWagFqIhOstiCACQ+msQeT7t3kxarlxNPQ8x30n1nfLwF2bGsMgZvFLIG6vCIzBAcw
 61TaDoKye+CgMDWPpjqrYop0KdFfPdvIX2HhvAcYuR6yHTNS3tbRbKV/yY7s8jR6hg
 cRCcLvScDvavw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/9] accel/rocket: add RK3576 NPU (RKNN) support
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260717085220.3212274-8-gahing@gahingwoo.com>
References: <20260717085220.3212274-1-gahing@gahingwoo.com>
 <20260717085220.3212274-8-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 09:21:16 +0000
Message-Id: <20260717092116.DC9D81F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Unconditional clock and reset requests break driver initialization=
 on RK3588.
- [High] Unhandled completion interrupts cause an interrupt storm on RK3588.
- [High] Using cancel_work() in rocket_reset() causes a race condition and =
hardware state corruption.
- [High] TOCTOU race in rocket_job_timedout() allows MMIO reads on a suspen=
ded device.
- [Medium] DPU and DPU_RDMA pre-arming logic is missing despite claims in t=
he commit message.

Pre-existing issues:
- [High] Shared IRQ handler unconditionally accesses MMIO without verifying=
 the device is active.
--

--- Patch [7]: [RFC PATCH 7/9] accel/rocket: add RK3576 NPU (RKNN) support =
---
commit 44e533d6c3c461a28b2f0fb3ee35a8a9e75c974a
Author: Jiaxing Hu <gahing@gahingwoo.com>

accel/rocket: add RK3576 NPU (RKNN) support

Add RK3576 support to the rocket DRM accelerator driver (used with the
Mesa Teflon TFLite delegate).

[ ... ]
>   - map the DPU (0x4000) and DPU_RDMA (0x5000) blocks and pre-arm them

[Severity: Medium]
The commit message mentions mapping and pre-arming the DPU and DPU_RDMA
blocks, and the accessor macros like rocket_dpu_writel are defined in
rocket_core.h. However, looking at rocket_job_hw_submit() in
rocket_job.c, there are no writes to these registers. Was the pre-arming
logic omitted by accident? Without it, might the compute path stall after
loading one slice on RK3576?

> diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/ro=
cket_core.c
> --- a/drivers/accel/rocket/rocket_core.c
> +++ b/drivers/accel/rocket/rocket_core.c
> @@ -22,12 +23,23 @@ int rocket_core_init(struct rocket_core *core)
>  	int err =3D 0;
> =20
>  	core->resets[0].id =3D "srst_a";
> -	core->resets[1].id =3D "srst_h";
>  	err =3D devm_reset_control_bulk_get_exclusive(&pdev->dev, ARRAY_SIZE(co=
re->resets),
>  						    core->resets);

[Severity: High]
Will this break initialization on RK3588? The srst_h reset line has been
removed from the array, meaning the RK3588 hardware might not be fully
reset during probe.

>  	if (err)
>  		return dev_err_probe(dev, err, "failed to get resets for core %d\n", c=
ore->index);
> =20
> +	core->clks[0].id =3D "aclk";
> +	core->clks[1].id =3D "hclk";
> +	core->clks[2].id =3D "npu";
> +	core->clks[3].id =3D "pclk";
> +	/*
> +	 * RK3576: the CBUF (convolution buffer) has its own clock domain. The =
CNA
> +	 * fills the CBUF and CORE reads from it; without these the compute path
> +	 * stalls after loading one slice (RDMA, which bypasses the CBUF, still
> +	 * runs). The vendor keeps all NPU clocks on whenever powered.
> +	 */
> +	core->clks[4].id =3D "aclk_cbuf";
> +	core->clks[5].id =3D "hclk_cbuf";
>  	err =3D devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);

[Severity: High]
Does this unconditional request for RK3576-specific clocks cause the probe
to fail on RK3588? If aclk_cbuf and hclk_cbuf do not exist in the RK3588
device tree, devm_clk_bulk_get() will return -ENOENT and break support for
the older platform.

[ ... ]
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
[ ... ]
> @@ -137,8 +148,21 @@ static void rocket_job_hw_submit(struct rocket_core =
*core, struct rocket_job *jo
>  	rocket_pc_writel(core, REGISTER_AMOUNTS,
>  			 PC_REGISTER_AMOUNTS_PC_DATA_AMOUNT((task->regcmd_count + 1) / 2 - 1)=
);
> =20
> -	rocket_pc_writel(core, INTERRUPT_MASK, PC_INTERRUPT_MASK_DPU_0 | PC_INT=
ERRUPT_MASK_DPU_1);
> -	rocket_pc_writel(core, INTERRUPT_CLEAR, PC_INTERRUPT_CLEAR_DPU_0 | PC_I=
NTERRUPT_CLEAR_DPU_1);
> +	/* Enable DMA-error interrupts; PC_DONE (bits 28-29) is polled, see abo=
ve. */
> +	rocket_pc_writel(core, INTERRUPT_MASK,
> +			 PC_INTERRUPT_MASK_DPU_0    | PC_INTERRUPT_MASK_DPU_1    |
> +			 PC_INTERRUPT_MASK_CORE_0   | PC_INTERRUPT_MASK_CORE_1   |
> +			 PC_INTERRUPT_MASK_PPU_0    | PC_INTERRUPT_MASK_PPU_1    |
> +			 PC_INTERRUPT_MASK_CNA_CSC_0 | PC_INTERRUPT_MASK_CNA_CSC_1 |
> +			 PC_INTERRUPT_MASK_DMA_READ_ERROR |
> +			 PC_INTERRUPT_MASK_DMA_WRITE_ERROR);

[Severity: High]
Could this lead to an interrupt storm on RK3588? In rocket_job_hw_submit(),
completion interrupts like DPU_0 and CORE_0 are unmasked in hardware.

However, rocket_job_irq_handler() now masks INTERRUPT_RAW_STATUS to only
check DMA errors and returns IRQ_NONE. This means the completion bits are
never cleared and the interrupt is never acknowledged.

[ ... ]
> @@ -326,56 +352,99 @@ static struct dma_fence *rocket_job_run(struct drm_=
sched_job *sched_job)
[ ... ]
>  static void
>  rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
>  {
> +	struct rocket_job *job;
> +
>  	if (!atomic_read(&core->reset.pending))
>  		return;
> =20
> +	atomic_set(&core->poll_active, 0);
> +	hrtimer_cancel(&core->poll_timer);
> +	cancel_work(&core->poll_work);

[Severity: High]
Is it safe to use the non-blocking cancel_work() here instead of
cancel_work_sync()?=20

If a job timeout occurs while poll_work is actively executing on another
CPU, it will continue running alongside the reset sequence.

Since rocket_job_handle_irq() writes to OPERATION_ENABLE outside of the
job_lock, this unguarded write could abruptly halt a newly submitted job
after the reset completes.

[ ... ]
> @@ -385,7 +454,14 @@ static enum drm_gpu_sched_stat rocket_job_timedout(s=
truct drm_sched_job *sched_j
>  	struct rocket_device *rdev =3D job->rdev;
>  	struct rocket_core *core =3D sched_to_core(rdev, sched_job->sched);
> =20
> -	dev_err(core->dev, "NPU job timed out");
> +	if (pm_runtime_active(core->dev))
> +		dev_err(core->dev,
> +			"NPU job timed out: RAW_STATUS=3D0x%08x MASK=3D0x%08x OP_EN=3D0x%08x\=
n",
> +			rocket_pc_readl(core, INTERRUPT_RAW_STATUS),
> +			rocket_pc_readl(core, INTERRUPT_MASK),
> +			rocket_pc_readl(core, OPERATION_ENABLE));
> +	else
> +		dev_err(core->dev, "NPU job timed out (device not active)\n");

[Severity: High]
Is there a race condition here that could allow MMIO reads on a suspended
device?=20

The lockless pm_runtime_active() check does not take a reference to
prevent suspension. If the device autosuspends in the narrow window between
the check and the rocket_pc_readl() calls, this might trigger a bus fault.
Would using pm_runtime_get_if_active() be safer?

[ ... ]
> @@ -420,14 +496,16 @@ static irqreturn_t rocket_job_irq_handler(int irq, =
void *data)
>  {
>  	struct rocket_core *core =3D data;
>  	u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);

[Severity: High]
This is a pre-existing issue, but since the IRQ handler is registered
with IRQF_SHARED, could reading INTERRUPT_RAW_STATUS unconditionally cause
a kernel panic if the device is runtime suspended?=20

If another device on the same IRQ line fires, reading unpowered MMIO
registers will trigger a synchronous external abort. Should this check
pm_runtime_get_if_active() first?

> +	/* Only bits 0-13 (DMA errors) can raise this IRQ; PC_DONE is polled. */
> +	u32 active =3D raw_status & 0x3fff;
> +
> +	if (!active)
> +		return IRQ_NONE;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717085220.3212=
274-1-gahing@gahingwoo.com?part=3D7
