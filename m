Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F1ECDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:01:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45AF310F210;
	Thu, 25 Jun 2026 10:01:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qi/n/BWT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F1910F210
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:01:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EEF7B43C2B;
 Thu, 25 Jun 2026 10:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4553F1F000E9;
 Thu, 25 Jun 2026 10:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782381665;
 bh=EsE76Z4xRSFuaUsnBBypJxmuqqG+w7zMjPB5P48Qr30=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Qi/n/BWTuFVm8wnsXRkvBBwNjqwtUdYjgx9lz4U+3x6qbzmGu5ug8F7gBgXirTkyq
 JTquM+ALNCoO+35pq3rBrC+i97FWSKQM8OWLblC+6ishhCeYD6QgBbM1VNjubMew5/
 jTfRnf3WaFnn5U8iKlaKmTGJhmXr1TvXq1YW5mGJOzUjp7elGW6aQteafaAXSL0LmS
 ijcx1MOEUpFpewf2AyG2uZF3FOLFD1n5lMDIcbB4cR8hT7yQ0cyQY3e7CjTpNfxB2V
 TcDV4KgRkqTJvBpenuV/OaL7z41mka8ROuo0f3iDi2L5OwwQaezOkYRIStK99p5vE5
 3PLKKk2agZOQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/7] drm/verisilicon: make axi and ahb clocks optional
To: "Joey Lu" <a0987203069@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260625094449.708386-5-a0987203069@gmail.com>
References: <20260625094449.708386-1-a0987203069@gmail.com>
 <20260625094449.708386-5-a0987203069@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:01:04 +0000
Message-Id: <20260625100105.4553F1F000E9@smtp.kernel.org>
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
- [High] Possible NULL pointer dereference in the IRQ handler if an interru=
pt triggers before DRM initialization completes.
--

commit 2cd6077ab2fb5ed065ee2cef55004b713c80f827
Author: Joey Lu <a0987203069@gmail.com>

drm/verisilicon: make axi and ahb clocks optional

The Nuvoton MA35D1 SoC integrates a DCUltraLite display controller whose
AXI and AHB bus clocks share a single gate enable bit with the display
core clock, so the clock driver does not expose them separately. This
patch makes the axi and ahb clocks optional in the probe.

> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c b/drivers/gpu/drm/verisi=
licon/vs_dc.c
> index 9729b693d360e..fd1f5fe67a68b 100644
> --- a/drivers/gpu/drm/verisilicon/vs_dc.c
> +++ b/drivers/gpu/drm/verisilicon/vs_dc.c
[ ... ]
> @@ -90,13 +90,13 @@ static int vs_dc_probe(struct platform_device *pdev)
>  		return PTR_ERR(dc->core_clk);
>  	}
> =20
> -	dc->axi_clk =3D devm_clk_get_enabled(dev, "axi");
> +	dc->axi_clk =3D devm_clk_get_optional_enabled(dev, "axi");
>  	if (IS_ERR(dc->axi_clk)) {

[Severity: High]
This is a pre-existing issue, but is it possible for an interrupt to trigger
a NULL pointer dereference during probe if the bootloader left the display
active?

Looking further down in vs_dc_probe(), the IRQ handler is registered before
vs_drm_initialize() is called:

	ret =3D devm_request_irq(dev, irq, vs_dc_irq_handler, 0,
			       dev_name(dev), dc);
	if (ret) {
		dev_err(dev, "can't request irq\n");
		goto err_rst_assert;
	}

	dev_set_drvdata(dev, dc);

	ret =3D vs_drm_initialize(dc, pdev);

If a pending interrupt (such as VSYNC) fires immediately after
devm_request_irq() is called, vs_dc_irq_handler() will be triggered and will
eventually call vs_drm_handle_irq().

Looking at vs_drm_handle_irq() in vs_drm.c, it unconditionally dereferences
the drm_dev pointer:

	if (dc->drm_dev->crtcs[i])
		drm_crtc_handle_vblank(&dc->drm_dev->crtcs[i]->base);

Since vs_drm_initialize() hasn't allocated or assigned dc->drm_dev yet,
could this cause a kernel panic during boot on platforms where the bootload=
er
leaves interrupts enabled?

Would it be safer to request the IRQ after the DRM device is fully
initialized, or to mask interrupts in the hardware before registering the
handler?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625094449.7083=
86-1-a0987203069@gmail.com?part=3D4
