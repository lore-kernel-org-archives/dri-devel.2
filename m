Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CBCC44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 06:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48AED10F449;
	Fri, 17 Jul 2026 06:24:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jVLkmZuc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2178E10F449
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 06:24:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 07F7240486;
 Fri, 17 Jul 2026 06:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE77B1F000E9;
 Fri, 17 Jul 2026 06:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784269448;
 bh=MVfidWL8oaCXOexOArEqXMHeu5iQYZwv87wPWRm+j60=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jVLkmZucIRO/3dfFHPd9FpHG0y+04G7aM8edTUdLkumfUDN6RmDZPFPsgYcRgFzqg
 dw501ftgwFKasCxILfsdtixHh4XONUHEsO9FQ7klj6QeJDo8nU/AGPKB3CnMfB+7y4
 r/N3Fi3Wd9KewTuuLAnmha06Kh2LfzDdE/fAJfgrutNhddkrxWDKnWCBvhYasxBc70
 cENed+PeuXJk2hWQcKaXRuQ/uBNAREjnQsuLVYu719UFkIxvqth35UrFntmykrGpPq
 HqC73d1ldXHluMl1IWRyx+EG8yvXhKpSwzFcYSVXjG3MMTttRDgkFWr0LtdCaOT2+T
 XhxtphRkCFX/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] accel/ethosu: propagate SRAM initialization errors
To: "GuoHan Zhao" <zhaoguohan@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717061145.1478139-5-zhaoguohan@kylinos.cn>
References: <20260717061145.1478139-1-zhaoguohan@kylinos.cn>
 <20260717061145.1478139-5-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 06:24:08 +0000
Message-Id: <20260717062408.BE77B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe hardware access in shared IRQ handler without Runtime PM ch=
eck.
- [High] Missing synchronize_irq() in runtime suspend callback.
- [High] SRAM is allocated but left uninitialized during probe, leading to =
potential use of uninitialized memory.
--

--- Patch [4]: [PATCH v2 4/5] accel/ethosu: propagate SRAM initialization e=
rrors ---
commit 4382c986c5c63a85ef8db5d2db6b39f2605d7154
Author: GuoHan Zhao <zhaoguohan@kylinos.cn>

accel/ethosu: propagate SRAM initialization errors

ethosu_sram_init() returns -ENOMEM if allocation from a declared SRAM
pool fails. ethosu_init() ignores the error after recording the pool size.
Probe then registers a device with a nonzero SRAM size and a zero sramphys
address, allowing jobs to program address zero for SRAM.

Propagate the error and synchronously suspend the device before the probe
path releases the scheduler.

Link: https://sashiko.dev/#/patchset/20260716065219.931088-1-zhaoguohan@kyl=
inos.cn?part=3D1

> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/eth=
osu_drv.c
> index 6b97d22444a7c..c825b67e9cba0 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -331,7 +331,9 @@ static int ethosu_init(struct ethosu_device *ethosude=
v)
>  	ethosudev->npu_info.id =3D id =3D readl_relaxed(ethosudev->regs + NPU_R=
EG_ID);
>  	ethosudev->npu_info.config =3D config =3D readl_relaxed(ethosudev->regs=
 + NPU_REG_CONFIG);
> =20
> -	ethosu_sram_init(ethosudev);
> +	ret =3D ethosu_sram_init(ethosudev);
> +	if (ret)
> +		goto err_runtime_suspend;

[Severity: High]
This is a pre-existing issue, but is the SRAM left uninitialized during the
first active window after probe?

Earlier in ethosu_init(), we call ethosu_device_resume(), which attempts to
zero the SRAM via ethosu_reset(). However, since ethosu_sram_init() hasn't
run yet, SRAM isn't allocated and zeroing is skipped.

If a job is submitted within the 50ms autosuspend delay window after probe
finishes, pm_runtime_resume_and_get() will increment the usage counter but
skip ethosu_device_resume() since the device is already active.

Does this mean the first job could run with uninitialized garbage data in
the SRAM, leading to unpredictable hardware behavior?

> =20
>  	dev_info(ethosudev->base.dev,
>  		 "Ethos-U NPU, arch v%ld.%ld.%ld, rev r%ldp%ld, cmd stream ver%ld, %d =
MACs, %dKB SRAM\n",
[ ... ]
> @@ -346,6 +348,9 @@ static int ethosu_init(struct ethosu_device *ethosude=
v)
> =20
>  	return 0;
> =20
> +err_runtime_suspend:
> +	ethosu_runtime_suspend(ethosudev);
> +	return ret;
>  err_suspend:
>  	pm_runtime_dont_use_autosuspend(ethosudev->base.dev);
>  	ethosu_device_suspend(ethosudev->base.dev);

[Severity: High]
This is a pre-existing issue, but does ethosu_device_suspend() need to call
synchronize_irq() before disabling the clocks?

Looking at ethosu_device_suspend(), it calls clk_bulk_disable_unprepare()
directly without synchronizing with the interrupt handler:

drivers/accel/ethosu/ethosu_drv.c:ethosu_device_suspend() {
	struct ethosu_device *ethosudev =3D dev_get_drvdata(dev);

	clk_bulk_disable_unprepare(ethosudev->num_clks, ethosudev->clks);
	return 0;
}

If the autosuspend timer expires and ethosu_device_suspend() executes while
an interrupt is mid-flight on another CPU, could the clocks be disabled
while the IRQ handler is actively accessing hardware registers, resulting in
a bus fault?

[Severity: High]
This is a pre-existing issue, but is it safe for ethosu_job_irq_handler()
to access hardware registers without checking if the device is active?

When the device enters runtime suspend and its clocks are disabled, a
different device sharing the same IRQ line could trigger an interrupt.

The ethosu_job_irq_handler() unconditionally reads NPU_REG_STATUS:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_irq_handler() {
	...
	u32 status =3D readl_relaxed(dev->regs + NPU_REG_STATUS);
	...
}

Without calling pm_runtime_get_if_active() to check if the device is active
first, could this lead to a bus fault and kernel panic if the device is
suspended and unclocked?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717061145.1478=
139-1-zhaoguohan@kylinos.cn?part=3D4
