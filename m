Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972F2C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 06:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0440E10F44B;
	Fri, 17 Jul 2026 06:27:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K3aFmMin";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72F3010F44B
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 06:27:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0920941310;
 Fri, 17 Jul 2026 06:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF85B1F00A3D;
 Fri, 17 Jul 2026 06:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784269647;
 bh=8ALi+EKVKm7efzMjXoP+jUbj+c+nS5S/IuBqW9fYy6w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K3aFmMinbcIxENaZIfrdFFPjYMnu5QZoeGVB2GMkyp2Bnm/sVpyUUH54JFhg0nEyV
 dus++i3CgmI/knCu43uUJcnAzIJF9P7FA6sHs2TLvic5IyUL9I/FMzIjmnMFvTPHIP
 rvjFZbamDjVvZEfsAMdLrJQpt/ELkXtuzRpELvOtkZlhxs0R3Vad3oBqzXWZLxcH7e
 pYY1/EaSpzVm+lidNVCZS2wzioDDxx3EWrQleW5vDHcFDDTaEZdYat0bVSj/M03SZM
 nX+G7y6kpGBnT/rPd0/HbMqTrcfa5P3hnkombXp/CXrjASXqMDyTtzLFp84tp2CXs2
 PWidIWhTKsl9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] accel/ethosu: clean up resources on probe failure
To: "GuoHan Zhao" <zhaoguohan@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717061145.1478139-4-zhaoguohan@kylinos.cn>
References: <20260717061145.1478139-1-zhaoguohan@kylinos.cn>
 <20260717061145.1478139-4-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 06:27:27 +0000
Message-Id: <20260717062727.BF85B1F00A3D@smtp.kernel.org>
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

Pre-existing issues:
- [High] The shared interrupt handler accesses hardware registers without v=
erifying if the device is active, risking a synchronous external abort.
- [High] Runtime suspend disables hardware clocks without calling synchroni=
ze_irq() for the shared interrupt.
- [High] Missing IS_ERR() check on the return value of devm_platform_iorema=
p_resource() causes an error pointer dereference.
- [High] The shared IRQ is requested before the hardware is powered on, ris=
king a crash if a shared interrupt fires early.
- [High] Destroying the DRM scheduler in ethosu_remove() creates a Use-Afte=
r-Free risk for open file descriptors.
- [High] An untrusted hardware register value is used as an array index wit=
hout bounds checking, potentially leaking kernel memory to the log.
--

--- Patch [3]: [PATCH v2 3/5] accel/ethosu: clean up resources on probe fai=
lure ---
commit 596a2469c9dadb88b1da94803fdbc80b578983ef
Author: GuoHan Zhao <zhaoguohan@kylinos.cn>

accel/ethosu: clean up resources on probe failure

ethosu_job_init() creates a scheduler before ethosu_init() and
drm_dev_register(). Errors from either later step return directly, leaving
the scheduler workqueue allocated. A drm_dev_register() failure also leaves
the optional SRAM allocation behind.

Unwind runtime PM, SRAM, and scheduler state in reverse order on probe
failure. Disable the clocks directly when runtime PM is unavailable or its
setup fails.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260716065219.931088-1-zhaoguohan@kyl=
inos.cn?part=3D1
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/eth=
osu_drv.c
> index f3920185389de..6b97d22444a7c 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -272,6 +272,17 @@ static int ethosu_device_suspend(struct device *dev)

[Severity: High]
This is a pre-existing issue, but ethosu_device_suspend() disables hardware
clocks without calling synchronize_irq() for the shared interrupt:

drivers/accel/ethosu/ethosu_drv.c:ethosu_device_suspend() {
	struct ethosu_device *ethosudev =3D dev_get_drvdata(dev);

	clk_bulk_disable_unprepare(ethosudev->num_clks, ethosudev->clks);
	return 0;
}

Could this cause a synchronous external abort if the device enters runtime
suspend while the interrupt handler is actively executing on another CPU?

>  	return 0;
>  }
> =20
> +static void ethosu_runtime_suspend(struct ethosu_device *ethosudev)
> +{
> +	struct device *dev =3D ethosudev->base.dev;
> +
> +	pm_runtime_dont_use_autosuspend(dev);
> +	if (pm_runtime_enabled(dev))
> +		pm_runtime_put_sync_suspend(dev);
> +	else
> +		ethosu_device_suspend(dev);
> +}
> +
>  static int ethosu_sram_init(struct ethosu_device *ethosudev)

[ ... ]

> @@ -355,13 +379,20 @@ static int ethosu_probe(struct platform_device *pde=
v)

[Severity: High]
This is a pre-existing issue, but devm_platform_ioremap_resource() returns =
an
ERR_PTR on failure, not NULL.

In ethosu_probe(), its return value is assigned directly without an IS_ERR
check:

drivers/accel/ethosu/ethosu_drv.c:ethosu_probe() {
	...
	ethosudev->regs =3D devm_platform_ioremap_resource(pdev, 0);

	ethosudev->num_clks =3D devm_clk_bulk_get_all(&pdev->dev, &ethosudev->clks=
);
	...
}

If the resource mapping fails, would a subsequent call to readl_relaxed() in
ethosu_init() dereference the error pointer?

[Severity: High]
This is a pre-existing issue, but the shared IRQ is requested before the
hardware is powered on in ethosu_probe():

drivers/accel/ethosu/ethosu_drv.c:ethosu_probe() {
	...
	ret =3D ethosu_job_init(ethosudev);
	if (ret)
		return ret;

	ret =3D ethosu_init(ethosudev);
	...
}

If another device on the same shared IRQ line triggers an interrupt between
ethosu_job_init() and ethosu_init(), could the interrupt handler attempt to
access MMIO registers while the clocks are still disabled, causing a crash?

> =20
>  	ret =3D ethosu_init(ethosudev);
>  	if (ret)
> -		return ret;
> +		goto err_job_fini;
> =20
>  	ret =3D drm_dev_register(&ethosudev->base, 0);
>  	if (ret)
> -		pm_runtime_dont_use_autosuspend(ethosudev->base.dev);
> +		goto err_runtime_suspend;
> =20
>  	pm_runtime_put_autosuspend(ethosudev->base.dev);
> +	return 0;
> +
> +err_runtime_suspend:
> +	ethosu_runtime_suspend(ethosudev);
> +	ethosu_sram_fini(ethosudev);
> +err_job_fini:
> +	ethosu_job_fini(ethosudev);
>  	return ret;
>  }
> =20
> @@ -371,9 +402,7 @@ static void ethosu_remove(struct platform_device *pde=
v)
> =20
>  	drm_dev_unregister(&ethosudev->base);
>  	ethosu_job_fini(ethosudev);

[Severity: High]
This is a pre-existing issue, but destroying the DRM scheduler here in
ethosu_remove() might create a use-after-free risk.

drm_dev_unregister() hides the device node but doesn't revoke existing open
file descriptors.=20

If a userspace process still holds an open file descriptor when the driver =
is
unbound, and subsequently submits an ioctl, will it access the destroyed
scheduler kthreads and freed SRAM?

> -	if (ethosudev->sram)
> -		gen_pool_free(ethosudev->srampool, (unsigned long)ethosudev->sram,
> -			      ethosudev->npu_info.sram_size);
> +	ethosu_sram_fini(ethosudev);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but I found a pre-existing issue
in ethosu_job_irq_handler().

The shared interrupt handler accesses hardware registers without verifying
if the device is active:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_irq_handler() {
	...
	u32 status =3D readl_relaxed(dev->regs + NPU_REG_STATUS);
	...
}

Because the handler is registered with IRQF_SHARED, couldn't another device
on the same IRQ line trigger an interrupt while the NPU is runtime-suspende=
d?
Accessing clock-gated MMIO here could trigger a synchronous external abort.

[Severity: High]
This is a pre-existing issue, but I found a potential out-of-bounds read
in ethosu_job_timedout().

An untrusted hardware register value is used as an array index without
bounds checking:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_timedout() {
	...
	cmdaddr, bocmds[cmdaddr / 4]);
	...
}

If a malformed job forces a timeout and leaves a large offset in the
NPU_REG_QREAD register, could cmdaddr exceed the bounds of the cmd_bo
buffer and leak kernel memory to the log?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717061145.1478=
139-1-zhaoguohan@kylinos.cn?part=3D3
