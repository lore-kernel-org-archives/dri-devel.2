Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CC5C4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 08:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4009510ECBA;
	Wed, 22 Jul 2026 08:06:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ke8I7FNA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8636310ECBA
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 08:06:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A452460A64;
 Wed, 22 Jul 2026 08:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4311F000E9;
 Wed, 22 Jul 2026 08:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784707616;
 bh=dykLf8VAFNe1W7EKIquUL1pIiN/chN0Jp1ZEiFJMx5w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ke8I7FNA7i1PIiuXwrhXpZc31FCThjSiejNTk1rj1RLNKqx3rV0T3p5LbGKrpEK2Q
 YLB2mmFHvF4qbndsnuZXE8tEXZGoIDSM+Q5L/GSw6XgGemM78jBgn6zJ3NHmvkdUv7
 1m/Kb3RLJ64kcQLZvq1XQkz1us5pumIM4JbCjJ5npzkin1bLhiAF/hHRQC9HSiEa0n
 3XISj+txwdfipR0KI2zsGIDZrM5DyHa4rnVAGcgrWLIedVCSTW80YU/VPbfAWVI4Mu
 zCh8AYDC1pmg1tF40/bvJhCsal8ZHFKytO0KEbHOlYwWqe6WL0U62x+0xaAhgn6t/j
 zutuRQkDn+BXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] fbdev: pxa168fb: Remove redundant dev_err()
To: "Pan Chuang" <panchuang@vivo.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722075803.570532-4-panchuang@vivo.com>
References: <20260722075803.570532-1-panchuang@vivo.com>
 <20260722075803.570532-4-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 08:06:55 +0000
Message-Id: <20260722080656.2F4311F000E9@smtp.kernel.org>
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
- [High] The driver unconditionally returns `-ENOENT` when `platform_get_ir=
q()` fails, breaking probe deferral.
- [High] The error path and remove function trigger a use-after-free and un=
clocked register access due to improper devm_request_irq() lifecycle.
- [High] Missing return value check for clk_prepare_enable() leads to possi=
ble system hang.
--

--- Patch [3]: [PATCH 3/7] fbdev: pxa168fb: Remove redundant dev_err() ---
commit 8117b479bf3e32b7a9c22b5f0311cebdedb684e8
Author: Pan Chuang <panchuang@vivo.com>

fbdev: pxa168fb: Remove redundant dev_err()

Since devm_request_irq() automatically logs detailed error messages on
failure, this commit removes the now-redundant driver-specific dev_err()
call in pxa168fb_probe().

> diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168f=
b.c
> index 6784888d93c9f..ce8a823d7128e 100644
> --- a/drivers/video/fbdev/pxa168fb.c
> +++ b/drivers/video/fbdev/pxa168fb.c
> @@ -725,7 +725,6 @@ static int pxa168fb_probe(struct platform_device *pde=
v)

[Severity: High]
This is a pre-existing issue, but does this function mishandle probe
deferral?

Looking at the earlier part of pxa168fb_probe():

pxa168fb_probe()
    ...
    irq =3D platform_get_irq(pdev, 0);
    if (irq < 0)
        return -ENOENT;

If platform_get_irq() returns -EPROBE_DEFER, this overwrites it to -ENOENT,
which will prevent the kernel from retrying the probe later. Could this
return the actual error code instead?

[Severity: High]
This is a pre-existing issue, but is there a missing check for the return
value of clk_prepare_enable()?

Just before the IRQ request in pxa168fb_probe():

pxa168fb_probe()
    ...
    /*
     * enable controller clock
     */
    clk_prepare_enable(fbi->clk);

    pxa168fb_set_par(info);

If clk_prepare_enable() fails, the clock remains disabled. The driver then
calls pxa168fb_set_par() which writes to memory-mapped registers. Could
accessing these registers without an active clock cause a synchronous
external bus abort?

>  	ret =3D devm_request_irq(&pdev->dev, irq, pxa168fb_handle_irq,
>  			       IRQF_SHARED, info->fix.id, fbi);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "unable to request IRQ\n");
>  		ret =3D -ENXIO;
>  		goto failed_free_cmap;
>  	}

[Severity: High]
This is a pre-existing issue, but does using a devm-managed IRQ here
introduce a use-after-free or unclocked register access during cleanup?

Because devm_request_irq() is used with IRQF_SHARED, the IRQ handler remains
registered until the devres cleanup runs, which happens after
pxa168fb_probe() or pxa168fb_remove() returns.

However, the error path and remove function free the resources early:

failed_free_clk:
    clk_disable_unprepare(fbi->clk);
failed_free_fbmem:
    ...
failed_free_info:
    framebuffer_release(info);

If another shared device triggers an interrupt during this window,
pxa168fb_handle_irq() will dereference the freed fbi pointer and read
hardware registers without an active clock:

pxa168fb_handle_irq()
    struct pxa168fb_info *fbi =3D dev_id;
    u32 isr =3D readl(fbi->reg_base + SPU_IRQ_ISR);

Should the driver explicitly free the IRQ or use a non-devm request to avoid
this race?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722075803.5705=
32-1-panchuang@vivo.com?part=3D3
