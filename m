Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC53BCD8CAC
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 07:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1865610E13C;
	Tue,  9 Jun 2026 07:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iuiu3/zC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5048810E13C
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 07:44:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F14A443DCA;
 Tue,  9 Jun 2026 07:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F2E1F00893;
 Tue,  9 Jun 2026 07:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780991053;
 bh=xS0qUA41Qj5mS1Zew3XDcqPZdaMmEDfqsTedWIQVmMo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iuiu3/zC0F7qUw487EvzbfmWerhTi5NbqW1l4Py2JjBc9Z8+GgqlFA2eI2T/QC8A+
 8IazXuq9Orybb8EVPdq556MSA4hCxSxIa0fvf3oGY4zEnU/uJ+s8Jh8Kzc44a8Mcu3
 IF/yYcyd6ZD4acPBDjh8Ax2omU0y3nCPWLEJnTxj5tTMggrAWT0vyPT6kmBDFCzno6
 vV0KzSXHLfH6veN1DOyf058+UlCpRh3oI4r2AdlU3ZNmxDIF2wg4fl7g8vcjJscwft
 Q/FBWJ+ZZM+RC/BakyleJQQWmQk6ldRbL9SlklltPRiKRhQeERrsYGzYeu0+jnHb2R
 /lnTJdlgk69Rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panfrost: fix runtime PM leak on remove
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609073407.5-1-ruoyuw560@gmail.com>
References: <20260609073407.5-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 07:44:13 +0000
Message-Id: <20260609074413.A5F2E1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] panfrost_remove() and the panfrost_probe() error path unconditiona=
lly execute panfrost_device_fini() without ensuring the device is awake, le=
ading to unclocked MMIO accesses.
- [High] Shared IRQ handlers remain active during and after device teardown=
, leading to unclocked MMIO reads and Use-After-Free/NULL-dereference crash=
es.
--

commit 0beb45b6c65f2fa448d72c39c4f224fe73270c9f
Author: Ruoyu Wang <ruoyuw560@gmail.com>

drm/panfrost: fix runtime PM leak on remove

pm_runtime_get_sync() increments the runtime PM usage counter even when it
returns an error. panfrost_remove() uses it to keep the GPU active while
runtime PM is disabled and the device is finalized, but the usage counter
is not dropped afterwards.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 784e36d72c2ba..0b475ad79b83b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -1027,6 +1027,7 @@ static void panfrost_remove(struct platform_device =
*pdev)
> =20
>  	pm_runtime_get_sync(pfdev->base.dev);

[Severity: High]
This is a pre-existing issue, but is it safe to ignore the return value of
pm_runtime_get_sync() here?

If resuming the device fails (for example, due to a clock enablement failur=
e),
the device remains suspended. The driver then proceeds to call
panfrost_device_fini(), which executes hardware teardown routines that write
to registers. Accessing MMIO registers of a suspended device with disabled
clocks on ARM causes a synchronous external abort.

The exact same missing state management appears to exist in the
panfrost_probe() error path, which calls panfrost_device_fini()
without attempting to resume the device, even though it may have
autosuspended after drm_dev_register():

drivers/gpu/drm/panfrost/panfrost_drv.c:panfrost_probe() {
    ...
err_out1:
    pm_runtime_disable(pfdev->base.dev);
    panfrost_device_fini(pfdev);
    ...
}

>  	pm_runtime_disable(pfdev->base.dev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
>  	pm_runtime_set_suspended(pfdev->base.dev);

[Severity: High]
This isn't a bug introduced by this patch, but does the teardown sequence
leave a window where shared IRQ handlers can run and access unclocked MMIO
or freed memory?

During panfrost_remove(), hardware and software are torn down, but the
shared devm-managed IRQs are not synchronized or disabled. They remain
active until driver core cleanup runs after panfrost_remove() returns.

If another device triggers the shared interrupt during this window, the
Panfrost handlers will execute:

drivers/gpu/drm/panfrost/panfrost_gpu.c:panfrost_gpu_irq_handler() {
    if (test_bit(PANFROST_COMP_BIT_GPU, pfdev->is_suspended))
        return IRQ_NONE;

    fault_status =3D gpu_read(pfdev, GPU_FAULT_STATUS);
    ...
}

Because panfrost_device_fini() does not set the PANFROST_COMP_BIT_* flags to
indicate the device is suspended, the handlers will incorrectly assume the
device is active. They will attempt to read MMIO registers (causing an abort
because clocks are off) and may dereference freed pointers.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609073407.5-1-=
ruoyuw560@gmail.com?part=3D1
