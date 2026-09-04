Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB01C79F82
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94FEB10E561;
	Fri,  4 Sep 2026 13:43:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZSlKAbu3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5319A10E561
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:43:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3BFC742EA5;
 Fri,  4 Sep 2026 13:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7109A1F00A3E;
 Fri,  4 Sep 2026 13:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788529419;
 bh=xy9J5SyzSLbBaq2i0MqF7v9oLGW7UxvK0+0fcU9bazk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZSlKAbu3/+w2XtzlSVGDS1AZlAhLZ46LLab5B4vYpp749PrXLR+AMo/kew8EqpAVs
 3xzs1cY1UYjYkqSBF6tU61Qtr9ipiOAv6hKLF3i6QN6eY8NCK2C3Y3IV6O/7vUNraY
 tmnnMwlCEp3OvPyT9gowBhC2JhmnpE1xErIuoKIMQM0kBKcgfKNlsEaPRiq03NQPUX
 s/4W5pmmy5OuYrtTB1kuJRxWSsi1sLMUDwt+VLymqfOdduHeb/5kFT+htRUkhNsRbW
 aaO9QLJnW02xfb3tO8DFjz6h5ymTcyDrQPCyRvknGn/KRLXprmQV0KVM+7OahP41OR
 w3kjnO2dPOX/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/19] drm/bridge: inno-hdmi: Allow the register map
 to come from a parent
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: neil.armstrong@linaro.org, vkoul@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org, olteanv@gmail.com,
 devicetree@vger.kernel.org, lee@kernel.org, linux-phy@lists.infradead.org,
 robh@kernel.org, mfd@lists.linux.dev, linux-clk@vger.kernel.org
In-Reply-To: <20260904-jh7110-clean-send-v3-8-484f9ae72715@samsung.com>
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132723eucas1p14cdff81f7ccdc02ec811179c5d401d69@eucas1p1.samsung.com>
 <20260904-jh7110-clean-send-v3-8-484f9ae72715@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:43:37 +0000
Message-Id: <20260904134338.7109A1F00A3E@smtp.kernel.org>
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
- [High] Early HPD interrupt can cause a NULL pointer dereference of `hdmi-=
>bridge.dev` if it fires before `drm_bridge_attach` completes.
--

commit 1a1229643b989df67626f64f580add186cebd6ed
Author: Michal Wilczynski <m.wilczynski@samsung.com>

drm/bridge: inno-hdmi: Allow the register map to come from a parent
   =20
On some SoCs the HDMI controller does not own its register window. The
StarFive JH7110 documents one 64 KB block, u0_hdmitx, that holds both
the controller and the PHY, so the parent device maps it and owns the
regmap while the two children share it.

> diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/=
inno-hdmi.c
> index aab474740f7f5..8bd7717611804 100644
> --- a/drivers/gpu/drm/bridge/inno-hdmi.c
> +++ b/drivers/gpu/drm/bridge/inno-hdmi.c
[ ... ]
> @@ -1095,9 +1110,19 @@ struct inno_hdmi *inno_hdmi_probe(struct platform_=
device *pdev,
>  	hdmi->dev =3D dev;
>  	hdmi->plat_data =3D plat_data;
> =20
> -	hdmi->regs =3D devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(hdmi->regs))
> -		return ERR_CAST(hdmi->regs);
> +	/*
> +	 * On platforms where the controller shares a register space with
> +	 * other blocks, the parent owns the regmap. Fall back to mapping
> +	 * our own resource where it does not.
> +	 */
> +	if (dev->parent)
> +		hdmi->regmap =3D dev_get_regmap(dev->parent, NULL);
> +
> +	if (!hdmi->regmap) {
> +		hdmi->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +		if (IS_ERR(hdmi->regs))
> +			return ERR_CAST(hdmi->regs);
> +	}
> =20
>  	hdmi->pclk =3D devm_clk_get_enabled(hdmi->dev, "pclk");
>  	if (IS_ERR(hdmi->pclk)) {

[Severity: High]
This is a pre-existing issue, but could this code trigger a NULL pointer
dereference if the hotplug interrupt fires early?

Looking at the rest of inno_hdmi_probe(), the hardware interrupt is unmuted
in inno_hdmi_init_hw(), and then the handler is registered:

    inno_hdmi_init_hw(hdmi);
    ...
    ret =3D devm_request_threaded_irq(dev, irq, inno_hdmi_hardirq,
                                    inno_hdmi_irq, IRQF_SHARED,
                                    dev_name(dev), hdmi);

If a cable is already connected or plugged in at this exact moment, the
interrupt can fire immediately. The threaded handler inno_hdmi_irq() will
then execute:

    drm_helper_hpd_irq_event(hdmi->bridge.dev);

However, hdmi->bridge.dev appears to be NULL at this point, as it is only
populated later when the upstream display controller calls
drm_bridge_attach().

Is there something preventing this race condition, or should the IRQ handler
registration be deferred?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-jh7110-cle=
an-send-v3-0-484f9ae72715@samsung.com?part=3D8
