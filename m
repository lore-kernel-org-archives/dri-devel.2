Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B164C88E5A
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 12:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D1E10E0E2;
	Sun, 13 Sep 2026 12:18:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZLDDq0m8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 042D110E0E2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 12:18:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F1C1D60E01;
 Sun, 13 Sep 2026 12:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EAC1F000FF;
 Sun, 13 Sep 2026 12:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789301889;
 bh=om6l/+Hhi+bIf8N89Gucw2aVPv+5PoGR5HQkRFg4B94=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZLDDq0m8zAF0nnln9paiur5z1HqF2I2aGefFX0BErV909ZwkmuUFgbz/M5+CY+Biq
 +pf/nzq/+QrU+wbi0gZl/c0NkeyrAB9o2BeJBHwWgdb4f0ZhNoVQJZaj3a0F2gs6N8
 9Pg91pDhgRybJmzhCcwiUIoQqalReWD4/UyUxpxB6ll7IO64I2kz5oQSxTXHfppjDz
 cJewmWcrdnLKs17XZ1CWkUcK4JICfJLt1atMTKv5AgUTsRloxgKcIalKPG1Qin2/sv
 oD6zqnzxZQLCPKFFGATZwqjcOletQ+H/+bFaGvSoZkXHqGPyw+lvBNVYkSpNmDEbYh
 K9diW3X0h55Ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] gpu: host1x: fix runtime PM reference leak on remove
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913120227.1559129-1-lgs201920130244@gmail.com>
References: <20260913120227.1559129-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 12:18:09 +0000
Message-Id: <20260913121809.93EAC1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Shared IRQ handler accesses hardware registers without PM checks, =
and runtime suspend powers down hardware without `synchronize_irq()`, riski=
ng system crashes.
- [High] `host1x_remove()` leaves the device in an invalid PM state (RPM_AC=
TIVE with hardware off) if children exist, causing bus hangs on driver rebi=
nd.
- [High] Resource leak (clocks left permanently on) in `host1x_probe` error=
 path if child devices exist.
- [High] Use-After-Free risk due to allocating `struct device` objects as a=
n array and freeing them synchronously in `host1x_memory_context_list_free`.
- [High] Use-After-Free risk due to missing `cancel_work_sync()` for `cdma-=
>update_work` during CDMA de-initialization.
--

commit ee98077bd8be81a3568fe9ef94599ff2844511f0
Author: Guangshuo Li <lgs201920130244@gmail.com>

gpu: host1x: fix runtime PM reference leak on remove

The commit fixes a runtime PM reference leak in host1x_remove() by calling
pm_runtime_put_sync_suspend() before forcing the device into suspend. This
balances the reference acquired during host1x_probe().

> diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
> index d2c64728f8043..bb6a1647e4db9 100644
> --- a/drivers/gpu/host1x/dev.c
> +++ b/drivers/gpu/host1x/dev.c
> @@ -729,6 +729,7 @@ static void host1x_remove(struct platform_device *pde=
v)
>  	host1x_unregister(host);
>  	host1x_debug_deinit(host);
> =20
> +	pm_runtime_put_sync_suspend(&pdev->dev);
>  	pm_runtime_force_suspend(&pdev->dev);

[Severity: High]
This isn't a bug introduced by this patch, but does this leave the device in
an invalid PM state (RPM_ACTIVE with hardware off) if children exist?

In host1x_remove(), pm_runtime_put_sync_suspend() drops the usage counter
but fails to suspend because devm-managed children might exist
(child_count > 0). pm_runtime_force_suspend() is then called, which powers
down the hardware.=20

However, because child_count > 0, pm_runtime_need_not_resume() returns fals=
e,
causing pm_runtime_force_suspend() to leave the runtime state as RPM_ACTIVE.

When the driver is unbound and rebound, host1x_probe() calls
pm_runtime_resume_and_get(), which sees RPM_ACTIVE, skips the resume
callback, and accesses the powered-off hardware. Can this cause bus hangs on
driver rebind?

While reviewing the PM changes, I noticed a few other pre-existing issues in
the driver:

[Severity: High]
In drivers/gpu/host1x/dev.c:host1x_probe(), is there a resource leak in the
error path if child devices exist?

pm_put:
	pm_runtime_put_sync_suspend(&pdev->dev);
pm_disable:
	pm_runtime_disable(&pdev->dev);

This is a pre-existing issue, but if an error occurs in host1x_probe() after
devm_of_platform_populate() adds children, pm_runtime_put_sync_suspend()
fails to suspend with -EBUSY due to child_count > 0.=20

The driver exits probe, and devm cleans up the children, but the device is
left in RPM_ACTIVE with PM disabled, leaving hardware clocks permanently
enabled.

[Severity: High]
In drivers/gpu/host1x/intr.c:host1x_intr_init(), the interrupt handler is
registered as a shared interrupt:

	err =3D devm_request_irq(host->dev, host->syncpt_irqs[i],
			       host->intr_op->isr, IRQF_SHARED,
			       "host1x_syncpt", &irq_data[i]);

This isn't a bug introduced by this patch, but doesn't this risk system
crashes?

If the device is runtime suspended and another device sharing the same IRQ
line triggers an interrupt, syncpt_thresh_isr() will execute and access
host1x registers without checking PM status:

	reg =3D host1x_sync_readl(host,
		HOST1X_SYNC_SYNCPT_THRESH_CPU0_INT_STATUS(i));

Additionally, host1x_runtime_suspend() powers down the hardware without
waiting for mid-flight IRQs via synchronize_irq().

[Severity: High]
This is a pre-existing issue, but does host1x_memory_context_list_free() in
drivers/gpu/host1x/context.c have a use-after-free risk?

	for (i =3D 0; i < cdl->len; i++)
		device_unregister(&cdl->devs[i].dev);

	kfree(cdl->devs);

The device array is synchronously freed immediately after device_unregister=
().

If userspace holds a reference (e.g., via an open sysfs file), the memory is
freed while in use, and when the final reference is dropped, the driver core
will operate on freed memory.

[Severity: High]
This is a pre-existing issue, but does host1x_cdma_deinit() in
drivers/gpu/host1x/cdma.c risk a use-after-free by missing a work cleanup?

	host1x_pushbuffer_destroy(pb);
	host1x_hw_cdma_timeout_destroy(host1x, cdma);

	return 0;

The function destroys CDMA resources and the channel memory is freed, but it
omits calling cancel_work_sync(&cdma->update_work).=20

If the work executes after the resources are freed, cdma_update_work() will
dereference freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913120227.1559=
129-1-lgs201920130244@gmail.com?part=3D1
