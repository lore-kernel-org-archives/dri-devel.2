Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BB5C4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 08:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF95810ECBB;
	Wed, 22 Jul 2026 08:07:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rf+wCcac";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9726010ECBB
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 08:07:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1993D60A65;
 Wed, 22 Jul 2026 08:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CE21F000E9;
 Wed, 22 Jul 2026 08:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784707667;
 bh=xo3IISKhtxGby/lAFNNk0qewfURkjilMzY3EFqpAYRk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rf+wCcaciU4SolSYbyszg50gEbpQBmphVkGtHXfDzlGPflRHG8yjjfdjRiSqSH2Xp
 2pMxi186QQEhzaRfFwzU9gnBmaUm3LSJ7jOoarYkv74it5S8pJlZq1ChrLQiGFekMu
 exhDooJ7ds5T1cB5JjVIH5L+bJuOhC69hSsPN2CvCNOFoclkb6BM2z1wbfG3pY/kUI
 1NdOts+o1GejCSblreR+QfcPHRRDct9tzzx++6iaNdTq7/XS+Qe+nSFkf1zHDii65p
 FeeUkPxV2dluxL6i0EJKh/Pvslaa5j1zR5z+AqkFsQqBTJDjmayW+q6pew8H3EgkeT
 q7tgkRT4sLXIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] fbdev: mmp: Remove redundant dev_err()
To: "Pan Chuang" <panchuang@vivo.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722075803.570532-2-panchuang@vivo.com>
References: <20260722075803.570532-1-panchuang@vivo.com>
 <20260722075803.570532-2-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 08:07:47 +0000
Message-Id: <20260722080747.99CE21F000E9@smtp.kernel.org>
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
- [High] The driver unconditionally overrides the error codes returned by p=
latform_get_irq() and devm_request_irq() to fixed values (-ENOENT and -ENXI=
O), breaking probe deferral.
- [High] The shared interrupt handler unconditionally returns IRQ_HANDLED w=
ithout checking if it actually serviced an interrupt.
- [High] The driver lacks a .remove callback but does not suppress sysfs un=
bind, leading to Use-After-Free and resource leaks.
--

--- Patch [1]: [PATCH 1/7] fbdev: mmp: Remove redundant dev_err() ---
commit 6ce9511a0259fe7a61c4cdd52d067da8431b2740
Author: Pan Chuang <panchuang@vivo.com>

fbdev: mmp: Remove redundant dev_err()

This commit removes a redundant dev_err() call from mmphw_probe().
The devm_request_irq() function already automatically logs detailed error
messages on failure.

> diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c b/drivers/video/fbdev/=
mmp/hw/mmp_ctrl.c
> index 75bbdc0b4aa65..2c457da67a9f1 100644
> --- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
> +++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
> @@ -505,8 +505,6 @@ static int mmphw_probe(struct platform_device *pdev)
>  	ret =3D devm_request_irq(ctrl->dev, ctrl->irq, ctrl_handle_irq,
>  		IRQF_SHARED, "lcd_controller", ctrl);

[Severity: High]
This is a pre-existing issue, but it looks like ctrl_handle_irq()
unconditionally returns IRQ_HANDLED.

If it doesn't check whether it actually serviced an interrupt, could it mask
unhandled interrupts on a shared line?

drivers/video/fbdev/mmp/hw/mmp_ctrl.c:ctrl_handle_irq() {
    ...
    return IRQ_HANDLED;
}

Can this break the kernel's spurious interrupt detection and lead to an
interrupt storm if a sharing device misbehaves?

[Severity: High]
This is a pre-existing issue, but since mmphw_driver lacks a .remove
callback and does not suppress sysfs unbind, what happens if the device is
unbound via sysfs?

When unbound, the driver core frees devm-managed resources, but the display
paths and SPI controller appear to be left registered:

static struct platform_driver mmphw_driver =3D {
        .driver         =3D {
                .name   =3D "mmp-disp",
        },
        .probe          =3D mmphw_probe,
};

Could this leave dangling pointers and unmapped memory active, leading to
use-after-free conditions?

>  	if (ret < 0) {
> -		dev_err(ctrl->dev, "%s unable to request IRQ %d\n",
> -				__func__, ctrl->irq);
>  		ret =3D -ENXIO;

[Severity: High]
This is a pre-existing issue, but overriding the return value of
devm_request_irq() to a fixed -ENXIO seems to swallow important error codes
like -EPROBE_DEFER.

Earlier in mmphw_probe(), the return value of platform_get_irq() is also
overridden to a fixed -ENOENT:

    irq =3D platform_get_irq(pdev, 0);
    if (irq < 0) {
            ret =3D -ENOENT;
            goto failed;
    }

Can this prevent proper probe deferral if dependencies like the IRQ
controller are not yet ready?

>  		goto failed;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722075803.5705=
32-1-panchuang@vivo.com?part=3D1
