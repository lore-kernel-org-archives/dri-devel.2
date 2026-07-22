Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8405EC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 08:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0FC189861;
	Wed, 22 Jul 2026 08:20:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RjAAXZJu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B37989861
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 08:20:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0C87243367;
 Wed, 22 Jul 2026 08:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3ECA1F000E9;
 Wed, 22 Jul 2026 08:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784708420;
 bh=MBFOXISs3CDMRLesIYZ/0xm8DQ7I34p3yGInJgPhFNs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RjAAXZJuBe4n8P/O0g+QPswaaauySMowpc7Umj11nYNV5Oq4zbmXcbaYkX/ARDk9Y
 /WKnDfNrVMG8uBZge1jyP6YMrTQTdNfsV0ucPJKni2S58nr9W7jOLleqftSxVXSXe5
 zDX1+SYGtiKLmrNEm6ae2vp4r/rypGDpLJMPG5w+KVcfn4plwRXMVN+pRRLjCehjK+
 JMH3p856VKIv2bNULL2uELGZq+/jqOHMppygR2LFy4CPEU5wL8y0EQ785TFvsDLXj2
 ucqyOhKw2/OoeTaA99i/PDd8whM/VFiQWCLCUVrsF+Ng2dLJm8Pi8z+/xWdG6EhxBn
 3vESQK3ZOFjNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] fbdev: s3c-fb: Remove redundant dev_err()
To: "Pan Chuang" <panchuang@vivo.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722075803.570532-7-panchuang@vivo.com>
References: <20260722075803.570532-1-panchuang@vivo.com>
 <20260722075803.570532-7-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 08:20:20 +0000
Message-Id: <20260722082020.C3ECA1F000E9@smtp.kernel.org>
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
- [High] Overwriting platform_get_irq() return value breaks deferred probin=
g and error reporting.
- [High] Ignored return values from clk_prepare_enable().
- [High] The error cleanup loop in s3c_fb_probe() passes a NULL pointer to =
s3c_fb_release_win(), leading to a kernel panic.
- [High] Calling unregister_framebuffer() on an unregistered framebuffer co=
rrupts the fbdev subsystem.
- [High] Repeated initialization of shared waitqueue sfb->vsync_info.wait i=
nside a loop with active IRQs and userspace exposure.
--

--- Patch [6]: [PATCH 6/7] fbdev: s3c-fb: Remove redundant dev_err() ---
commit 0bb07a380253651e3a1f2d4c656dfc05702e59ca
Author: Pan Chuang <panchuang@vivo.com>

fbdev: s3c-fb: Remove redundant dev_err()

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() call.

> diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
> index 2f4d707e2e097..82a3bc9de433c 100644
> --- a/drivers/video/fbdev/s3c-fb.c
> +++ b/drivers/video/fbdev/s3c-fb.c
> @@ -1421,10 +1421,8 @@ static int s3c_fb_probe(struct platform_device *pd=
ev)
> =20
>  	ret =3D devm_request_irq(dev, sfb->irq_no, s3c_fb_irq,
>  			  0, "s3c_fb", sfb);
> -	if (ret) {
> -		dev_err(dev, "irq request failed\n");
> +	if (ret)
>  		goto err_lcd_clk;
> -	}
> =20
>  	dev_dbg(dev, "got resources (regs %p), probing windows\n", sfb->regs);
> =20

[Severity: High]
This is a pre-existing issue, but does this code ignore the return values
from clk_prepare_enable()?

drivers/video/fbdev/s3c-fb.c:s3c_fb_probe() {
...
	clk_prepare_enable(sfb->bus_clk);

	if (!sfb->variant.has_clksel) {
		sfb->lcd_clk =3D devm_clk_get(dev, "sclk_fimd");
		if (IS_ERR(sfb->lcd_clk)) {
...
		}

		clk_prepare_enable(sfb->lcd_clk);
	}
...
}

If clk_prepare_enable() fails, the driver continues as if the clocks are
active, which can lead to a synchronous external abort when accessing
hardware registers.


[Severity: High]
This isn't a bug introduced by this patch, but looking at s3c_fb_probe(),
is it intended to discard the actual error code returned by
platform_get_irq() and replace it with -ENOENT?

drivers/video/fbdev/s3c-fb.c:s3c_fb_probe() {
...
	sfb->irq_no =3D platform_get_irq(pdev, 0);
	if (sfb->irq_no < 0) {
		ret =3D -ENOENT;
		goto err_lcd_clk;
	}
...
}

If platform_get_irq() returns -EPROBE_DEFER, returning -ENOENT breaks
deferred probing and causes the framebuffer initialization to fail
permanently.


[Severity: High]
This is a pre-existing issue, but does this error path loop lead to a NULL
pointer dereference?

drivers/video/fbdev/s3c-fb.c:s3c_fb_probe() {
...
		ret =3D s3c_fb_probe_win(sfb, win, fbdrv->win[win],
				       &sfb->windows[win]);
		if (ret < 0) {
			dev_err(dev, "failed to create window %d\n", win);
			for (; win >=3D 0; win--)
				s3c_fb_release_win(sfb, sfb->windows[win]);
...
}

If s3c_fb_probe_win() fails early (e.g. framebuffer_alloc() returns -ENOMEM=
),
sfb->windows[win] remains NULL.

Then s3c_fb_release_win() evaluates win->fbinfo without checking if win
itself is NULL:

drivers/video/fbdev/s3c-fb.c:s3c_fb_release_win() {
...
static void s3c_fb_release_win(struct s3c_fb *sfb, struct s3c_fb_win *win)
{
	u32 data;

	if (win->fbinfo) {
...
}


[Severity: High]
This is a pre-existing issue, but does s3c_fb_release_win() call
unregister_framebuffer() on a framebuffer that was never registered?

drivers/video/fbdev/s3c-fb.c:s3c_fb_release_win() {
...
	if (win->fbinfo) {
		if (sfb->variant.has_shadowcon) {
...
		}
		unregister_framebuffer(win->fbinfo);
...
}

If s3c_fb_probe_win() fails after fbinfo is allocated but before calling
register_framebuffer() (such as if s3c_fb_alloc_memory() fails), the error
path calls s3c_fb_release_win().

Calling unregister_framebuffer() on an unregistered fbinfo corrupts the
fbdev subsystem counts.


[Severity: High]
This is a pre-existing issue, but is it safe to repeatedly initialize the
shared waitqueue sfb->vsync_info.wait inside a per-window loop?

drivers/video/fbdev/s3c-fb.c:s3c_fb_probe_win() {
...
static int s3c_fb_probe_win(...)
{
...
	init_waitqueue_head(&sfb->vsync_info.wait);
...
}

s3c_fb_probe_win() is called for each window by s3c_fb_probe().

Once the first window is registered, it is exposed to userspace. If
userspace opens it and calls the FBIO_WAITFORVSYNC ioctl, a task can sleep
on the waitqueue.

When the driver probes the next window, it calls init_waitqueue_head()
again on the same shared waitqueue, which corrupts the list head while a
task is actively sleeping on it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722075803.5705=
32-1-panchuang@vivo.com?part=3D6
