Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B36CD6E79
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB8110E207;
	Tue,  9 Jun 2026 09:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kt7P3XCA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4C9810E207
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 09:47:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 08675601E1;
 Tue,  9 Jun 2026 09:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDFD1F00893;
 Tue,  9 Jun 2026 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780998476;
 bh=gbh+zvaCM98JRQokv8KCyrp6E6f4rPKAwmhsp4jWhsc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Kt7P3XCAviFIEx2Hk07Jr6WJkEH5e5A4RRBoTf/9hqq1nTdbYWHbm/VeyjY9XgaDb
 UR5Jlx/UzDuXE8GtlWrIbqbsQmv8beudPxZEQgEXU8FxT8ntBNJX5twDR6KMszPUnT
 mX4RcM+t3MdmwBPD5cehSXo01sohBP6wDItF+rdAEaKf+L2+H7Dc5wU+UlHJFxp1t+
 fHUoJ3PRinpxq33CS17+7jTXnJznYvZTNCHDMyqNe8CSzquEFqoUvU5SoziFSmbp71
 E3BMRY0JN1cw8OmahcvAen486aKyNC6VJoxZZRu2guGnXg0hLBgbsI2vIqwjJxqX+U
 bCqhDGtMourGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] accel/rocket: Fix iommu_group leak and unsafe
 IRQ register access
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609093346.380396-2-zhaojinming@uniontech.com>
References: <20260609093346.380396-2-zhaojinming@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 09:47:55 +0000
Message-Id: <20260609094756.8DDFD1F00893@smtp.kernel.org>
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
- [High] Incorrect error handling of pm_runtime_get_if_active() return valu=
e causes unbalanced pm_runtime_put() and unsafe hardware access.
- [High] PM usage count leak due to threaded IRQ coalescing on shared inter=
rupts.

Pre-existing issues:
- [High] Missing synchronize_irq() in the runtime suspend callback for a de=
vice with a shared IRQ handler.
- [High] Attacker-controlled DMA faults leave the device interrupt asserted=
 without clearing it, causing an interrupt storm and kernel log spam.
--

commit 57f30fe728d7f765520f0d3ccb419368e6f945d0
Author: ZhaoJinming <zhaojinming@uniontech.com>

accel/rocket: Fix iommu_group leak and unsafe IRQ register access

This commit fixes an iommu_group reference leak in rocket_job_handle_irq()
by using the stored iommu_group instead of getting a new reference. It also
attempts to fix unsafe hardware register accesses in the shared IRQ handler
by adding pm_runtime_get_if_active() checks to ensure the device is awake.

> 2) Unsafe hardware register access in shared IRQ handler:
>    rocket_job_irq_handler() is registered with IRQF_SHARED but accesses
>    hardware registers without checking runtime PM status.

[Severity: High]
This is a pre-existing issue, but since the device uses a shared IRQ handle=
r,
does the runtime suspend callback (rocket_device_runtime_suspend() in
rocket_drv.c) need to call synchronize_irq() before disabling clocks?=20

Without it, the IRQ handler could execute mid-flight while the hardware is
turned off, leading to invalid register accesses and spurious interrupts.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index cf9f61682dd8b..8eaa3d427a51d 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
[ ... ]
> @@ -428,14 +429,20 @@ static irqreturn_t rocket_job_irq_handler_thread(in=
t irq, void *data)
>  static irqreturn_t rocket_job_irq_handler(int irq, void *data)
>  {
>  	struct rocket_core *core =3D data;
> +
> +	if (!pm_runtime_get_if_active(core->dev))
> +		return IRQ_NONE;
> +

[Severity: High]
Does this correctly handle negative error codes?=20

pm_runtime_get_if_active() returns negative error codes (e.g., -EINVAL) when
runtime PM is disabled. The condition here only traps a return value of 0.
When it returns a negative error code, the condition evaluates to false,
allowing execution to proceed to read hardware registers on a potentially
suspended device.

Because the PM usage counter is not incremented on error, wouldn't the
subsequent unconditional pm_runtime_put() calls cause a PM usage count
underflow?

>  	u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
> =20
>  	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_READ_ERROR);
>  	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_WRITE_ERROR);
> =20

[Severity: High]
This is a pre-existing issue, but if a DMA error occurs and the DPU_0 and
DPU_1 bits are not set, the handler returns IRQ_NONE without clearing the
interrupt.

Since this is a shared level-triggered IRQ line, won't this leave the
interrupt asserted and cause an interrupt storm, permanently disabling the
shared IRQ line?

>  	if (!(raw_status & PC_INTERRUPT_RAW_STATUS_DPU_0 ||
> -	      raw_status & PC_INTERRUPT_RAW_STATUS_DPU_1))
> +	      raw_status & PC_INTERRUPT_RAW_STATUS_DPU_1)) {
> +		pm_runtime_put(core->dev);
>  		return IRQ_NONE;
> +	}
> =20
>  	rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
> =20

[Severity: High]
Does this leak the PM usage count if the IRQ subsystem coalesces the thread=
ed
interrupt?

If another device triggers an interrupt on this shared line while
rocket_job_irq_handler_thread() is already pending, this hardirq handler
will run again. It will increment the PM usage count via
pm_runtime_get_if_active() and eventually return IRQ_WAKE_THREAD.

Because the thread is already pending, the IRQ core coalesces the request
and the thread only runs once. Doesn't this mean pm_runtime_put() is only
called once, permanently leaking the extra PM reference acquired here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609093346.3803=
96-1-zhaojinming@uniontech.com?part=3D2
