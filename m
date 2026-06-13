Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC0ACD8CA8
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 07:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B915510ECBF;
	Sat, 13 Jun 2026 07:10:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cGwQd5y/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F25210ECBF
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 07:10:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0173844333;
 Sat, 13 Jun 2026 07:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1C31F000E9;
 Sat, 13 Jun 2026 07:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781334642;
 bh=QelHcp/KafwD0g3DUeu6MitiuKE6H602dDAL65piGN0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cGwQd5y/VW8kZlzfi6MWIvhR1G0HB77bJCzTNiwDe9pXeXwOEq2woi/a019Ov7gRE
 HiTyZCRizfIcI5eq/ico9lnnRvWAqFilMUABqKZ/XmRi+aiPASBXA2VZqvbZAJGCui
 ZQEYih00SO+8zEHy1sX4W5YO+b5uMkvWhgHiUiXJVCwClGBkcuLhuFhyZEVrRpza2I
 2i2UZBsmPuYCrE/8wSoRGLEo7pwnslvSCnJXIUlu7FhJgfkiRW5kJBSmBlCKUySBSV
 9tLDTV+PwRe/4j1I2xELxAXheQbx6Uof3/sAdqhzDF97szMMXEUfkUFY6QYdio/coK
 jDNqBjpxjc54w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 1/9] accel: rocket: Introduce per-SoC
 rocket_soc_data
To: MidG971 <midgy971@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260613070116.438906-2-midgy971@gmail.com>
References: <20260613070116.438906-2-midgy971@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 07:10:42 +0000
Message-Id: <20260613071042.AA1C31F000E9@smtp.kernel.org>
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
- [High] The shared IRQ handler accesses hardware registers without checkin=
g if the device is active.
- [High] The runtime suspend callback disables hardware clocks without sync=
hronizing the shared IRQ.
- [High] The global `rdev` pointer is not reset to NULL when initialization=
 fails, causing a kernel panic on subsequent probes.
- [High] Hardware registers are read during probe without ensuring the devi=
ce resets are explicitly deasserted.
--

commit e068c6d40922642be56ef8ce61fd76a8d5727d7c
Author: Midgy BALON <midgy971@gmail.com>

accel: rocket: Introduce per-SoC rocket_soc_data

Add a per-SoC data structure carried in the OF match table, currently
holding only the NPU AXI address width, and use it for the per-core DMA
mask instead of a hardcoded 40-bit value.

> diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/ro=
cket_core.c
> index b3b2fa9ba645a..09c445af7de73 100644
> --- a/drivers/accel/rocket/rocket_core.c
> +++ b/drivers/accel/rocket/rocket_core.c
> @@ -21,6 +22,10 @@ int rocket_core_init(struct rocket_core *core)
>  	u32 version;
>  	int err =3D 0;
> =20
> +	core->soc_data =3D of_device_get_match_data(dev);
> +	if (!core->soc_data)
> +		return dev_err_probe(dev, -EINVAL, "missing SoC match data\n");
> +
>  	core->resets[0].id =3D "srst_a";
>  	core->resets[1].id =3D "srst_h";
>  	err =3D devm_reset_control_bulk_get_exclusive(&pdev->dev, ARRAY_SIZE(co=
re->resets),

[Severity: High]
This isn't a bug introduced by this patch, but I noticed hardware registers=
 are
read during probe without ensuring the device resets are explicitly deasser=
ted.

Later in rocket_core_init():

	version =3D rocket_pc_readl(core, VERSION);

If the bootloader leaves the NPU in an asserted reset state, attempting to
read its registers will cause a synchronous external abort. Would it make
sense to deassert the resets before accessing registers here?

[ ... ]

> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> index 8bbbce594883e..384c38e13acce 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
[ ... ]
> @@ -213,8 +213,12 @@ static void rocket_remove(struct platform_device *pd=
ev)
>  	}
>  }

[Severity: High]
This is a pre-existing issue, but I noticed the global rdev pointer is not
reset to NULL when initialization fails in rocket_probe() in this file:

	rdev =3D rocket_device_init(drm_dev, &rocket_drm_driver, soc_data);
	if (IS_ERR(rdev)) {
		...
		return PTR_ERR(rdev);
	}

If this fails during the first core's probe, an error pointer is assigned to
the global rdev pointer without being cleared. On the next core's probe, the
check for NULL will fail and it will blindly dereference the error pointer.
Could this be addressed by clearing the global pointer on the error path?

[Severity: High]
This is a pre-existing issue, but the runtime suspend callback in this driv=
er
disables hardware clocks without synchronizing the shared IRQ:

rocket_device_runtime_suspend() {
	...
	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks), ...);
	...
}

Should this call synchronize_irq() first to avoid a race condition where the
IRQ handler might be executing mid-flight on another CPU while the hardware
is powered down?

[Severity: High]
This is a pre-existing issue, but in drivers/accel/rocket/rocket_job.c, the
shared IRQ handler accesses hardware registers without checking if the devi=
ce
is active:

rocket_job_irq_handler() {
	...
	u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
	...
}

Because the IRQ is registered with IRQF_SHARED, if the handler is invoked by
another device while the NPU is runtime suspended, reading the registers can
result in invalid data (~0u) and spurious interrupts. Should it use
pm_runtime_get_if_active() before reading the status register?

[ ... ]

>  static const struct of_device_id dt_match[] =3D {
> -	{ .compatible =3D "rockchip,rk3588-rknn-core" },
> +	{ .compatible =3D "rockchip,rk3588-rknn-core", .data =3D &rk3588_soc_da=
ta },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, dt_match);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613070116.4389=
06-1-midgy971@gmail.com?part=3D1
