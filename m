Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9830AC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3E8189A77;
	Mon, 20 Jul 2026 14:04:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IGo6TohJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D2FA89A77
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 14:04:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3DB94402A1;
 Mon, 20 Jul 2026 14:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA331F000E9;
 Mon, 20 Jul 2026 14:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784556274;
 bh=42WHyCs9uxDV/qhyXm7SrTrq/aEf0JSReh6e1+zr574=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IGo6TohJOBmgEZ8CC2SPqZyY9o3SL5nY41Xy1nNWH5hNzSvcva69xDwJ2bXVbN8qL
 ByPaFIacDgQHqcWkuQyHfJUivgSbH0ot3+EDsKKILZl5BY58V+PJuRWlFoqih07Fyl
 CoNPH2I6wi6CgbydXJ0oYgiKuq2RJQ0tyKiLhuzl+SQU7kXOfwPi3TVP5CaZDWxt2T
 Hq36jFEdCah0G9cStJ4EdnRSp4/xl/aP/2N6PcanVX0JfRukDgRT+r7wcyDGVZG39/
 4YvG16shj5GqV5Eg0S9VuEmcRGOeVZAp7vLxXSLOFEyxgsFzp8ZepvVckXRvKC1txj
 o3j7/ycWLMR3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] staging: fbtft: Remove redundant dev_err_probe()
To: "Pan Chuang" <panchuang@vivo.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720134324.239391-3-panchuang@vivo.com>
References: <20260720134324.239391-1-panchuang@vivo.com>
 <20260720134324.239391-3-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 14:04:33 +0000
Message-Id: <20260720140433.EAA331F000E9@smtp.kernel.org>
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
- [High] The driver relies on static global variables (`irq_te` and `panel_=
te`) to manage device-specific IRQ and synchronization state, which breaks =
multi-device configurations and can cause Use-After-Free bugs.
- [Medium] In the display update path `write_vmem()`, the tearing effect (T=
E) interrupt is enabled before the completion structure is reinitialized, c=
reating a race window that can lead to missed TE events and unnecessary tim=
eouts.
- [Medium] The driver prematurely frees the `te` GPIO descriptor via `gpiod=
_put(te)` immediately after converting it to an IRQ, allowing the pin to be=
 reconfigured or powered down.
--

--- Patch [2]: [PATCH 2/7] staging: fbtft: Remove redundant dev_err_probe()=
 ---
commit ac4d01370b4ee0a3ff08280bd824b5b8e0c0efe6
Author: Pan Chuang <panchuang@vivo.com>

staging: fbtft: Remove redundant dev_err_probe()
   =20
Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err_probe() calls.

> diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/f=
b_st7789v.c
> index 861a154144e66..ec46ad3f6a918 100644
> --- a/drivers/staging/fbtft/fb_st7789v.c
> +++ b/drivers/staging/fbtft/fb_st7789v.c
> @@ -119,7 +119,7 @@ static int init_tearing_effect_line(struct fbtft_par =
*par)
>  	rc =3D devm_request_irq(dev, irq_te, panel_te_handler,
>  			      IRQF_TRIGGER_RISING, "TE_GPIO", par);

[Severity: High]
This isn't a bug introduced by this patch, but does using the global
variables irq_te and panel_te break multi-device configurations?

If multiple displays are probed, the global irq_te will be overwritten.
Subsequent display updates from any panel will then manipulate the irq of
the most recently probed panel.

If one panel is unbound, devres frees its irq, but irq_te retains the freed
irq number, potentially leading to an invalid enable_irq() call on a
released irq.

>  	if (rc)
> -		return dev_err_probe(dev, rc, "TE IRQ request failed.\n");
> +		return rc;
> =20
>  	disable_irq_nosync(irq_te);
> =20

[Severity: Medium]
This is a pre-existing issue, but does the driver prematurely free the te
gpio descriptor in init_tearing_effect_line() just before this?

drivers/staging/fbtft/fb_st7789v.c:init_tearing_effect_line() {
...
	irq =3D gpiod_to_irq(te);

	/* GPIO is locked as an IRQ, we may drop the reference */
	gpiod_put(te);

	if (irq < 0)
		return irq;
...
}

Calling gpiod_put() completely frees the descriptor and marks it as
unrequested in the gpiolib core. Doesn't this allow other drivers or
userspace tools to request the gpio and reconfigure its direction, which
would silently break the te interrupt line?

[Severity: Medium]
This isn't a bug introduced by this patch, but is there a race condition in
write_vmem() when enabling the tearing effect interrupt?

drivers/staging/fbtft/fb_st7789v.c:write_vmem() {
...
	if (irq_te) {
		enable_irq(irq_te);
		reinit_completion(&panel_te);
...
}

By enabling the irq before resetting the completion, could an interrupt
arrive in this tiny window?

If it does, the handler completes the event, but the main thread
immediately resets the completion state and waits, missing the event.
Could this regression lead to unnecessary timeouts and framerate drops?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720134324.2393=
91-1-panchuang@vivo.com?part=3D2
