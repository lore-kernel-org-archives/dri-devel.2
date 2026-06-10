Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4870ACD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9525710E787;
	Wed, 10 Jun 2026 07:24:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aEbg9u4s";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C2F210E786
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 07:24:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6ED0D602CC;
 Wed, 10 Jun 2026 07:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DEB1F00893;
 Wed, 10 Jun 2026 07:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781076295;
 bh=OR9YiHFTMqfz/UlYE227FUGVYjeC94KEIOJ0d+Lo5LI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aEbg9u4srZKl3zNrwGPv0WQrP3XA4+mNMLZDPlkEOaRyWI8oxkASUc9pJc2x3/Vl/
 LTyQDPQGJydL1LNGFb8pYAPYr8faBwOFXngkK7mN5ZSCWI6tAwP3+F0i2bBXKCWGj+
 kOpQ+KNeAohARYA/Dm0Zsalmrpk2f95iwcK2ixqW9PoF4sMI0pjQdnx60VT1EBx393
 NKCO11r4rYTBk0RNwdNKGvWPUBBpwvCi/ZUNoc3knKVDbZW/qJ0OpnKAQZ0gShV+G1
 PFpshYQa04kYfpAYHaqI2Og137JWLN04d4bXzT+/M0KldlP5W+zhkfjav8ScZTq2sC
 dHbjAN73nb1aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] accel/rocket: Fix iommu_group leak and unsafe
 IRQ register access
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260610071045.3414828-2-zhaojinming@uniontech.com>
References: <20260610071045.3414828-2-zhaojinming@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 07:24:54 +0000
Message-Id: <20260610072454.F2DEB1F00893@smtp.kernel.org>
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
- [High] Mismatched and strict return value checks for `pm_runtime_get_if_a=
ctive()` break IRQ handling when Runtime PM is disabled, causing job hangs.

Pre-existing issues:
- [High] The runtime suspend callback powers down hardware without calling =
`synchronize_irq()`, violating shared IRQ rules.
- [High] Unhandled hardware DMA errors result in an unacknowledged interrup=
t, causing an immediate IRQ storm.
- [High] Calling `iommu_detach_group()` and `iommu_attach_group()` with a N=
ULL group pointer causes a kernel panic if the device is not bound to an IO=
MMU.
--

commit 1a0ceb9d138ab6f44b71efac6f2c376438bd8d22
Author: ZhaoJinming <zhaojinming@uniontech.com>

accel/rocket: Fix iommu_group leak and unsafe IRQ register access

This commit fixes a reference leak of the iommu_group in the IRQ handler
by reusing the cached core->iommu_group. It also fixes unsafe hardware regi=
ster
accesses in the shared IRQ handler by adding runtime PM checks to verify the
device is active before reading registers.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index cf9f61682dd8b..81b222198dac9 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -349,7 +349,7 @@ static void rocket_job_handle_irq(struct rocket_core =
*core)
>  				return;
>  			}
> =20
> -			iommu_detach_group(NULL, iommu_group_get(core->dev));
> +			iommu_detach_group(NULL, core->iommu_group);

[Severity: High]
This is a pre-existing issue, but calling iommu_detach_group() and
iommu_attach_group() with a NULL group pointer causes a kernel panic if
the device is not bound to an IOMMU.

If the device is not behind an IOMMU, iommu_group_get() returns NULL
during initialization.

If CONFIG_IOMMU_API is enabled, both functions unconditionally
dereference the group pointer to acquire its lock, which triggers a NULL
pointer dereference crash.

Does this path also need to ensure core->iommu_group is not NULL before
detaching, and similarly during job submission?

>  			dma_fence_signal(core->in_flight_job->done_fence);
>  			pm_runtime_put_autosuspend(core->dev);
>  			core->in_flight_job =3D NULL;

[ ... ]

> @@ -420,7 +420,10 @@ static irqreturn_t rocket_job_irq_handler_thread(int=
 irq, void *data)
>  {
>  	struct rocket_core *core =3D data;
> =20
> -	rocket_job_handle_irq(core);
> +	if (pm_runtime_get_if_active(core->dev) =3D=3D 1) {
> +		rocket_job_handle_irq(core);
> +		pm_runtime_put(core->dev);
> +	}

[Severity: High]
When CONFIG_PM is disabled or runtime PM is globally disabled for the
device, pm_runtime_get_if_active() returns -EINVAL.

Because -EINVAL !=3D 1, the condition evaluates to false, silently
skipping rocket_job_handle_irq() entirely.

Since the threaded handler skips execution, the completed job is never
processed, the IOMMU group is not detached, the DMA fence is never
signaled, and waiting user processes hang permanently.

Could this strict check cause a regression in IRQ handling when Runtime
PM is disabled?

> =20
>  	return IRQ_HANDLED;
>  }
> @@ -428,16 +431,28 @@ static irqreturn_t rocket_job_irq_handler_thread(in=
t irq, void *data)
>  static irqreturn_t rocket_job_irq_handler(int irq, void *data)
>  {
>  	struct rocket_core *core =3D data;
> -	u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
> +	u32 raw_status;
> +	int ret;
> +
> +	ret =3D pm_runtime_get_if_active(core->dev);
> +	if (ret =3D=3D 0)
> +		return IRQ_NONE;
> +
> +	raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
> =20
>  	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_READ_ERROR);
>  	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_WRITE_ERROR);
> =20
>  	if (!(raw_status & PC_INTERRUPT_RAW_STATUS_DPU_0 ||
> -	      raw_status & PC_INTERRUPT_RAW_STATUS_DPU_1))
> +	      raw_status & PC_INTERRUPT_RAW_STATUS_DPU_1)) {
> +		if (ret > 0)
> +			pm_runtime_put(core->dev);
>  		return IRQ_NONE;
> +	}

[Severity: High]
This is a pre-existing issue, but unhandled hardware DMA errors result
in an unacknowledged interrupt, causing an immediate IRQ storm.

If the hardware triggers an interrupt with
PC_INTERRUPT_RAW_STATUS_DMA_READ_ERROR set, but the DPU completion bits
are not set, the condition !(raw_status & DPU) evaluates as true.

It executes the WARN_ON() and immediately returns IRQ_NONE without
writing to INTERRUPT_CLEAR or INTERRUPT_MASK.

Because the shared IRQ line is level-triggered and the hardware is still
asserting the unacknowledged error, the interrupt controller will
immediately re-invoke the handler as soon as it returns.

Will this create an infinite IRQ storm that permanently hogs the CPU
core until the kernel's spurious interrupt detector forcibly disables
the shared IRQ line?

> =20
>  	rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
> +	if (ret > 0)
> +		pm_runtime_put(core->dev);
> =20
>  	return IRQ_WAKE_THREAD;
>  }

[Severity: High]
This is a pre-existing issue, but the runtime suspend callback powers
down hardware without calling synchronize_irq(), violating shared IRQ
rules.

The global subsystem guide explicitly states: "When devices use shared
IRQs (IRQF_SHARED), the runtime suspend callback must call
synchronize_irq() before powering down hardware to ensure no IRQ handler
is executing mid-flight."

The device requests its interrupt with IRQF_SHARED, but its runtime
suspend callback disables the device's clocks without waiting for
executing IRQ handlers to finish:

drivers/accel/rocket/rocket_drv.c:rocket_device_runtime_suspend() {
    ...
    clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks),
                               rdev->cores[core].clks);
    ...
}

Might this lead to mid-flight handlers reading powered-down hardware
registers, causing bus faults?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610061915.1CA2=
81F00893@smtp.kernel.org?part=3D2
