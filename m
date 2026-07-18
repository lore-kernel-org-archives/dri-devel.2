Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1916C4451B
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 09:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 084F810E557;
	Sat, 18 Jul 2026 09:19:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ky+Mc3cq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE52110E557
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 09:19:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 76CB141A00;
 Sat, 18 Jul 2026 09:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F871F000E9;
 Sat, 18 Jul 2026 09:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784366379;
 bh=qFqYyrBdcq0ibDmYiLePTSZIXE8UPQe0qPMs8Yh4Fjs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ky+Mc3cqgME+CpDV66ALB8bWjdv1Wlc2Lu5EuMnfEJAgQBp6xdsj0tHCf12AMb91L
 x36J/rvRYZv0EK7xLu2jvzJPohmnobtSYL0BKHKxnswkA7S41qMP4UpkvkgaWOQe/R
 eFupOc8i7YdQq2yl86aF6nQ7O6YtuiH5UewnHQiUmSKYhnAdPAHcLNUwOGQ74DAYQQ
 7CvJHKzf3BUAQ7ha+wgyi1i5Nj9UrqOkZZyb66hucf0TaMW9Y4LM29gPyY51Io72xV
 WzaOnAj4EYMjVBLhz8Cs98U9QthRtOebtT4eFrE3zeLfXvEtMPBum9KsjgvLokyTwk
 34s7980Ix0qBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/meson: constrain the DW-HDMI regmap range
To: "Zinan Zhou" <zinan@mieulab.com>
Cc: dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
 linux-amlogic@lists.infradead.org
In-Reply-To: <20260718090710.70534-1-zinan@mieulab.com>
References: <20260718090710.70534-1-zinan@mieulab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 09:19:38 +0000
Message-Id: <20260718091939.14F871F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The threaded IRQ handler `dw_hdmi_top_thread_irq` can execute befo=
re the `hdmi` and `bridge` pointers are initialized, leading to a NULL poin=
ter dereference.
--

--- Patch [1]: [PATCH] drm/meson: constrain the DW-HDMI regmap range ---
commit f8ff68e6f372ddb9f5ca83893e7f1b1b21342d72
Author: Zinan Zhou <zinan@mieulab.com>

drm/meson: constrain the DW-HDMI regmap range

The DesignWare HDMI regmap declares 0x10000 as its inclusive maximum
register. A regmap traversal can consequently read one byte past the
directly mapped G12A 64 KiB resource. It also treats the Meson TOP window
from offset 0x8000 as DWC registers. On the older indirect interface, the
address is truncated to 16 bits and aliases register zero.

Limit the regmap to 0x7e12, the last register defined by the supported
Synopsys HDMI controller. This also keeps register iteration below the
Meson TOP register window at offset 0x8000.

> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meso=
n/meson_dw_hdmi.c
> index fef1702acb145..1004108fb7ca2 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c

[ ... ]

> @@ -564,7 +566,7 @@ static const struct regmap_config meson_dw_hdmi_regma=
p_config =3D {
>  	.val_bits =3D 8,
>  	.reg_read =3D meson_dw_hdmi_reg_read,
>  	.reg_write =3D meson_dw_hdmi_reg_write,
> -	.max_register =3D 0x10000,
> +	.max_register =3D HDMITX_DWC_MAX_REGISTER,
>  	.fast_io =3D true,
>  };

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this file I
noticed a potential race condition during initialization.

In meson_dw_hdmi_bind(), the IRQ handler is registered via
devm_request_threaded_irq() before dw_hdmi->hdmi and dw_hdmi->bridge are
initialized:

drivers/gpu/drm/meson/meson_dw_hdmi.c:meson_dw_hdmi_bind() {
    ...
    ret =3D devm_request_threaded_irq(dev, irq, dw_hdmi_top_irq,
                                    dw_hdmi_top_thread_irq, IRQF_SHARED,
                                    "dw_hdmi_top_irq", meson_dw_hdmi);
    ...
    meson_dw_hdmi->hdmi =3D dw_hdmi_probe(pdev, &meson_dw_hdmi->dw_plat_dat=
a);
    ...
    meson_dw_hdmi->bridge =3D of_drm_find_and_get_bridge(pdev->dev.of_node);
    ...
}

The driver then calls dw_hdmi_probe(), which unmasks the HPD interrupts at
the hardware level.

If an HPD interrupt fires immediately (e.g., if a cable is already connected
or the line bounces), can dw_hdmi_top_thread_irq() execute concurrently and
cause a NULL pointer dereference?

drivers/gpu/drm/meson/meson_dw_hdmi.c:dw_hdmi_top_thread_irq() {
    ...
    dw_hdmi_setup_rx_sense(dw_hdmi->hdmi, hpd_connected,
                           hpd_connected);

    drm_helper_hpd_irq_event(dw_hdmi->bridge->dev);
    ...
}

Since dw_hdmi_probe() has not yet returned, wouldn't dw_hdmi->hdmi and
dw_hdmi->bridge still be NULL at this point, causing a crash when
dereferencing them?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718090710.7053=
4-1-zinan@mieulab.com?part=3D1
