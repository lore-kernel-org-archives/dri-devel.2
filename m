Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A52C4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 08:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA2ED10ECB9;
	Wed, 22 Jul 2026 08:07:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="itbRawwj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD8D510ECB9
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 08:07:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5125360A65;
 Wed, 22 Jul 2026 08:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA5E1F000E9;
 Wed, 22 Jul 2026 08:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784707642;
 bh=YUnZl0gUipGTPzHFkoYWiUlJPcTJ2CM065zEak5GmqI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=itbRawwjUwrTW6uMHKWOyVZZlhxNRuLYgEWWXV+sI8uO4zol+EwM6GrKdqVXfLBiD
 rjKkHI+teBl/M4T86rnGZt3Q8PXA0YYWn1Yk/m30R9HeMy2+qMlTs2MfVeqJNpr1uQ
 z0DnxDHeVxZOADtT9SrF7hKAhN7znLTQxc42x2pOVIDpipSGYRVp4f0pwtMgEstOzv
 LrdAjTOjHhiJ2/gPXtniG6gPJgHrwFSNtfXlhacmigTl28DCXn24Cmb/V0yUC8cU1u
 mL7LaqU2rOz8DbNnD2LGbUOLsYRhGChmUyI47DyxV3kGRBCjbPom+ssH791rwdqFsg
 gSiKbnBCRSsOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] fbdev: pxa3xx-gcu: Remove redundant dev_err()
To: "Pan Chuang" <panchuang@vivo.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722075803.570532-5-panchuang@vivo.com>
References: <20260722075803.570532-1-panchuang@vivo.com>
 <20260722075803.570532-5-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 08:07:21 +0000
Message-Id: <20260722080721.DAA5E1F000E9@smtp.kernel.org>
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
- [High] Premature IRQ registration before resource allocation and hardware=
 initialization.
- [High] Use-after-free and hardware access violation due to devres teardow=
n asymmetry in remove and error paths.
- [High] Data race leading to NULL pointer dereference in `pxa3xx_gcu_write=
()`.
- [High] Premature misc device registration exposes uninitialized device to=
 userspace.
- [Medium] Missing timer cancellation in device removal leads to use-after-=
free.
--

--- Patch [4]: [PATCH 4/7] fbdev: pxa3xx-gcu: Remove redundant dev_err() ---
commit 07f66ca8434e8ab1bbe80f8c87905a7ed13a3c22
Author: Pan Chuang <panchuang@vivo.com>

fbdev: pxa3xx-gcu: Remove redundant dev_err()

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() call.

> diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3x=
x-gcu.c
> --- a/drivers/video/fbdev/pxa3xx-gcu.c
> +++ b/drivers/video/fbdev/pxa3xx-gcu.c
> @@ -615,10 +615,8 @@ static int pxa3xx_gcu_probe(struct platform_device *=
pdev)
> =20
>  	ret =3D devm_request_irq(dev, irq, pxa3xx_gcu_handle_irq,
>  			       0, DRV_NAME, priv);

[Severity: High]
This is a pre-existing issue, but is it safe to request the IRQ here before
priv->shared is allocated and the hardware clock is enabled?

If a pending or spurious interrupt fires immediately after this
devm_request_irq() call, the interrupt handler pxa3xx_gcu_handle_irq() will
execute. It attempts to access priv->shared and reads hardware registers
before the clock is enabled:

pxa3xx_gcu_handle_irq()
    struct pxa3xx_gcu_shared *shared =3D priv->shared;
    u32 status =3D gc_readl(priv, REG_GCISCR) & IE_ALL;

Could this lead to a NULL pointer dereference or bus fault during probe?

> -	if (ret < 0) {
> -		dev_err(dev, "request_irq failed\n");
> +	if (ret < 0)
>  		return ret;
> -	}
> =20
>  	/* allocate dma memory */
>  	priv->shared =3D dma_alloc_coherent(dev, SHARED_SIZE,

[Severity: High]
This isn't a bug introduced by this patch, but does the error handling and
device removal order have a use-after-free risk?

Since devm_request_irq() is used, the interrupt remains active until after
pxa3xx_gcu_remove() returns. However, in pxa3xx_gcu_remove(), priv->shared
is manually freed and the hardware clock is disabled:

pxa3xx_gcu_remove() {
    ...
    dma_free_coherent(dev, SHARED_SIZE, priv->shared, priv->shared_phys);
    clk_disable_unprepare(priv->clk);
    ...
}

If the hardware interrupt is not masked and fires between these manual=20
teardowns and the devres cleanup, pxa3xx_gcu_handle_irq() would run and
access freed memory and disabled hardware.

[Severity: High]
This is a pre-existing issue, but is there a potential data race leading to=
 a
NULL pointer dereference in pxa3xx_gcu_write()?

The list emptiness check appears to be decoupled from the lock. If multiple
threads concurrently write when only a single buffer is free, they can pass
the lockless check:

pxa3xx_gcu_write() {
    if (!priv->free) {
        ...
    }
   =20
    spin_lock_irqsave(&priv->spinlock, flags);
    buffer =3D priv->free;
    priv->free =3D buffer->next;

If the first thread removes the buffer, making priv->free NULL, would the
second thread acquire the lock, blindly assign buffer =3D priv->free, and t=
hen
cause a NULL dereference when evaluating buffer->next?

[Severity: High]
This isn't a bug introduced by this patch, but is the misc device registered
prematurely during probe?

In pxa3xx_gcu_probe(), misc_register() is called before the hardware clocks
are enabled:

pxa3xx_gcu_probe() {
    ...
    ret =3D misc_register(&priv->misc_dev);
    ...
    ret =3D clk_prepare_enable(priv->clk);
    ...
}

If userspace opens the device immediately after it appears and invokes
ioctl(PXA3XX_GCU_IOCTL_RESET), it will attempt to write to hardware registe=
rs
via gc_writel() before clk_prepare_enable() completes. Could this lead to a
system hang or external abort?

[Severity: Medium]
This is a pre-existing issue, but is there a missing timer cancellation in
the device removal path?

When optional debugging is enabled, a self-rearming debug timer is
initialized during probe. However, pxa3xx_gcu_remove() does not appear to
call del_timer_sync() to clean it up.

After the driver is unloaded and devres frees priv, will the timer fire and
access the freed priv pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722075803.5705=
32-1-panchuang@vivo.com?part=3D4
