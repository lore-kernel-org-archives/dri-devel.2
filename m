Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A24CDB47C
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 03:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80BA210E159;
	Thu, 25 Jun 2026 03:13:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WRW8kEjm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6510210E159
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 03:13:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 23C2841B28;
 Thu, 25 Jun 2026 03:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41A81F000E9;
 Thu, 25 Jun 2026 03:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782357186;
 bh=7gE2gY6lf1KVYUkOUFMu+JgzR+jdtBTW6v3Awa2cxgQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WRW8kEjmgiuTha7Hdo1jmZhbDBIg8a6CdZLJRg7NcGHZw3cTq2Fx52iG8eUj6jelw
 8jGQTz74u00aqpvwaGSJcXgDiFCwE7o9SSuHlnJn4exE1X61g/F9b9h3j98S40ynq8
 Boh4xW/HuGm5NUoFM7CDia8xFpAOSfZMJ6EN9Y2HS6xvjAPCRKFGDtjytqBRTf2qVV
 FkJtII3RvgJ2/BPL075/I15vndkIoa80a2ZY4aLpyed5N7f+S6jLhEHrNMaYtHcoci
 6jSAJCmlFSK/v/4V/DUgOkYlUY0s4VYaKbDWYfZRkVRt4ioZGdGjawzPk8EfurVoAz
 iOMOQZhezmrOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: goldfishfb: fail pan display on base-update timeout
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625030102.79755-1-pengpeng@iscas.ac.cn>
References: <20260625030102.79755-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 03:13:05 +0000
Message-Id: <20260625031305.D41A81F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] Strict error check on pan display may cause probe to unconditional=
ly fail due to hardware deduplication.
- [High] State desynchronization between kernel and hardware on timeout.

Pre-existing issues:
- [High] Unhandled hardware interrupt leak causing an interrupt storm.
- [High] Hardware DMA Use-After-Free during probe error and device removal.
- [High] DMA free size mismatch due to mutable screen resolution variables.
- [Medium] Unconditional timeout delay and false-positive error during prob=
e.
- [Medium] Integer overflow in framebuffer DMA size calculation.
--

commit e61a80b8db4bb16d36d4a68c1bf1c49ae2fe7019
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

fbdev: goldfishfb: fail pan display on base-update timeout

goldfish_fb_pan_display() waits for the device to acknowledge the new
framebuffer base, but it only logs a timeout and still reports success.
The probe path also ignores the initial pan-display result before
registering the framebuffer. This patch returns -ETIMEDOUT when the
base-update acknowledgment does not arrive.

> diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldf=
ishfb.c
> index c9871281bc1da..e5d79886ea66b 100644
> --- a/drivers/video/fbdev/goldfishfb.c
> +++ b/drivers/video/fbdev/goldfishfb.c
> @@ -138,10 +138,12 @@ static int goldfish_fb_pan_display(struct fb_var_sc=
reeninfo *var,
>  	writel(fb->fb.fix.smem_start + fb->fb.var.xres * 2 * var->yoffset,
>  						fb->reg_base + FB_SET_BASE);
>  	spin_unlock_irqrestore(&fb->lock, irq_flags);
> -	wait_event_timeout(fb->wait,
> -			fb->base_update_count !=3D base_update_count, HZ / 15);
> -	if (fb->base_update_count =3D=3D base_update_count)
> +	if (!wait_event_timeout(fb->wait,
> +				fb->base_update_count !=3D base_update_count,
> +				HZ / 15)) {
>  		pr_err("%s: timeout waiting for base update\n", __func__);
> +		return -ETIMEDOUT;

[Severity: High]
Does returning an error here permanently desynchronize the kernel's fbdev
state from the actual hardware scanout state?

By returning -ETIMEDOUT, the generic fbdev core refuses to update the
xoffset and yoffset software state. However, the hardware has already
been programmed with the new offset via FB_SET_BASE and will switch
to it when it finishes.

> +	}
>  	return 0;
>  }
> =20
> @@ -251,7 +253,9 @@ static int goldfish_fb_probe(struct platform_device *=
pdev)

[Severity: Medium]
This is a pre-existing issue, but can the framesize calculation overflow?

Earlier in goldfish_fb_probe(), width and height are read directly from 32-=
bit
device registers:

        width =3D readl(fb->reg_base + FB_GET_WIDTH);
        height =3D readl(fb->reg_base + FB_GET_HEIGHT);
        ...
        framesize =3D width * height * 2 * 2;

If large dimensions are provided, the 32-bit arithmetic could wrap around,
resulting in a small allocation while the hardware attempts to scan out a
much larger region.

[Severity: Medium]
This is a pre-existing issue, but does calling fb_set_var() earlier in this
function cause an unconditional timeout delay?

In goldfish_fb_probe(), fb_set_var() is called before request_irq():

        ret =3D fb_set_var(&fb->fb, &fb->fb.var);
        if (ret)
                goto err_fb_set_var_failed;

        ret =3D request_irq(fb->irq, goldfish_fb_interrupt, ...);

fb_set_var() implicitly invokes goldfish_fb_pan_display(), which waits
for an interrupt. Because the interrupt handler is not yet registered and
interrupts are not enabled, this wait will always time out.

>  		goto err_request_irq_failed;
> =20
>  	writel(FB_INT_BASE_UPDATE_DONE, fb->reg_base + FB_INT_ENABLE);
> -	goldfish_fb_pan_display(&fb->fb.var, &fb->fb); /* updates base */
> +	ret =3D goldfish_fb_pan_display(&fb->fb.var, &fb->fb); /* updates base =
*/
> +	if (ret)
> +		goto err_pan_display_failed;

[Severity: High]
Will this strict error check cause the probe to unconditionally fail due
to hardware deduplication?

The probe path implicitly writes the base offset to FB_SET_BASE during
fb_set_var() (which currently times out). It then explicitly calls
goldfish_fb_pan_display() here with the exact same offset, writing to
FB_SET_BASE again.

If the virtual hardware deduplicates identical writes and does not assert
an interrupt for a redundant update, the wait will time out. Because this
patch now aborts on timeout, won't the probe unconditionally fail?

> =20
>  	ret =3D register_framebuffer(&fb->fb);
>  	if (ret)
> @@ -259,6 +263,7 @@ static int goldfish_fb_probe(struct platform_device *=
pdev)
>  	return 0;
> =20
>  err_register_framebuffer_failed:
> +err_pan_display_failed:
>  	free_irq(fb->irq, fb);

[Severity: High]
This is a pre-existing issue, but does this error path leave device
interrupts enabled?

The hardware interrupt is enabled just before calling
goldfish_fb_pan_display():

        writel(FB_INT_BASE_UPDATE_DONE, fb->reg_base + FB_INT_ENABLE);

If goldfish_fb_pan_display() fails, the code jumps to err_pan_display_failed
and frees the IRQ handler. However, it never writes 0 to FB_INT_ENABLE to
disable the device's interrupt generation. Can this cause an unhandled
interrupt storm that permanently disables the shared IRQ line?

>  err_request_irq_failed:
>  err_fb_set_var_failed:

[Severity: High]
This is a pre-existing issue, but does this error path cause a DMA
use-after-free by the hardware?

The hardware is programmed to scan actively from the DMA address:

goldfish_fb_pan_display() {
        ...
        writel(fb->fb.fix.smem_start + fb->fb.var.xres * 2 * var->yoffset,
                                        fb->reg_base + FB_SET_BASE);
}

If the probe fails after this point, or when goldfish_fb_remove() is
called, the driver frees the DMA memory here in the error path:

err_fb_set_var_failed:
        dma_free_coherent(&pdev->dev, framesize,
                                (void *)fb->fb.screen_base,
                                fb->fb.fix.smem_start);

Since the driver never halts the hardware scanout (e.g., by setting the
base address to 0 or writing to FB_SET_BLANK), won't the hardware continue
to read from the freed memory?

[ ... ]

[Severity: High]
This is a pre-existing issue, but does goldfish_fb_remove() use a
mismatched size when freeing DMA memory?

In goldfish_fb_probe(), memory is allocated with a fixed size:

        framesize =3D width * height * 2 * 2;
        fb->fb.screen_base =3D dma_alloc_coherent(..., framesize, ...);

However, in goldfish_fb_remove(), the size to free is dynamically
recalculated:

goldfish_fb_remove() {
        ...
        framesize =3D fb->fb.var.xres_virtual * fb->fb.var.yres_virtual * 2;
        dma_free_coherent(..., framesize, ...);
}

Since userspace can modify yres_virtual via the FBIOPUT_VSCREENINFO
ioctl, wouldn't remove() attempt to free a different size than was
allocated, violating the DMA API?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625030102.7975=
5-1-pengpeng@iscas.ac.cn?part=3D1
