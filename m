Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3809DCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 968A510F751;
	Mon,  8 Jun 2026 16:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hfFIO8Qe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B21C10F750
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:49:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 58F1060098;
 Mon,  8 Jun 2026 16:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83EB1F00893;
 Mon,  8 Jun 2026 16:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780937363;
 bh=s1PTTZvphbbwnAu1zwivaHaLice3xJM8yjaB+le9/as=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hfFIO8QeCPyVO6Hg66PINzp21pSUEbTdK+KeKQ4/zJ7c1RpL7jOZa3qpBjw1yHHhg
 llcjGk7Qc1Vs30xA8EHtczdv1MV9MHlcw4Z5b/iFnZCc6s1OcB3UGYldPzxwUijUET
 BEKvTeW7MiEFUF6qyyWBl0H1fb8YKWSbwMiT2uHye0ymW1TX+9M47km+WUgTrhgIEM
 etUhcCeU/xsMQK8eWJKTEue47WbCA1Qoidn9iGaEFCcsHpPcogPDczLZWL42SqciDJ
 zPmuYb9URYMOOs4g7sFgtEvFPnq4vTH+Iifji9iPTRMbdrwNJSZLmOa8ZCjMLodTC3
 NN6YycWv9x1nA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/panel: himax-hx83121a: add backlight regulator
 support
To: "Icenowy Zheng" <zhengxingda@iscas.ac.cn>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260608162622.403713-3-zhengxingda@iscas.ac.cn>
References: <20260608162622.403713-3-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:49:22 +0000
Message-Id: <20260608164922.C83EB1F00893@smtp.kernel.org>
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
- [High] Probe fails unconditionally if the optional backlight regulator is=
 not present in the device tree, breaking backward compatibility.
- [High] Skipping the DCS brightness command when brightness is 0 prevents =
the backlight from turning off on devices without an external regulator.
- [Medium] The backlight supply regulator's enable count is leaked if the d=
river is unbound while the backlight is active.
--

commit 700de7e190150a663957123f411692a25d437849
Author: Icenowy Zheng <zhengxingda@iscas.ac.cn>

drm/panel: himax-hx83121a: add backlight regulator support

This patch adds support for an external backlight regulator to the
himax-hx83121a panel driver. It turns off the regulator when brightness
is 0 and enables it when the backlight is operating.

> diff --git a/drivers/gpu/drm/panel/panel-himax-hx83121a.c b/drivers/gpu/d=
rm/panel/panel-himax-hx83121a.c
> index 1a7e0125bced8..e31e2fba0a787 100644
> --- a/drivers/gpu/drm/panel/panel-himax-hx83121a.c
> +++ b/drivers/gpu/drm/panel/panel-himax-hx83121a.c
[ ... ]
> @@ -195,7 +197,27 @@ static int himax_bl_update_status(struct backlight_d=
evice *bl)
>  {
>  	struct himax *ctx =3D bl_get_data(bl);
>  	u16 brightness =3D backlight_get_brightness(bl);
> +	int ret =3D 0;
> +
> +	if (!brightness) {
> +		if (ctx->backlight_enabled)
> +			ret =3D regulator_disable(ctx->bl_supply);
> +		if (ret)
> +			return ret;
> +
> +		ctx->backlight_enabled =3D false;
> +
> +		return 0;
> +	}

[Severity: High]
Does this early return prevent the display from turning off the backlight=20
via DCS?

For panels that do not have an external bl-supply regulator and rely entire=
ly
on DCS commands, disabling the dummy/absent regulator is a no-op, but the
early return bypasses the mipi_dsi_dcs_set_display_brightness_large() call.
Will this leave the backlight powered on at its previous level when it shou=
ld
be turned off?

> +
>  	/* TODO: brightness to raw map table */
> +	if (!ctx->backlight_enabled)
> +		ret =3D regulator_enable(ctx->bl_supply);

[Severity: Medium]
Could this leak the regulator enable count if the driver is unbound while t=
he
backlight is active?

If the panel driver is unbound or the module is removed while brightness is
greater than 0, the devres infrastructure will unregister the backlight
device without triggering an update_status to 0. Since there is no explicit
disable in a remove callback or devm_add_action teardown hook, will the
subsequent regulator_put() hit a warning for a non-zero enable count?

> +	if (ret)
> +		return ret;
> +
> +	ctx->backlight_enabled =3D true;
> +
>  	return mipi_dsi_dcs_set_display_brightness_large(to_primary_dsi(ctx),
>  							 brightness);
>  }
[ ... ]
> @@ -647,6 +669,10 @@ static int himax_probe(struct mipi_dsi_device *dsi)
>  	ctx->panel.prepare_prev_first =3D true;
> =20
>  	if (desc->has_dcs_backlight) {
> +		ctx->bl_supply =3D devm_regulator_get_optional(dev, "bl");
> +		if (IS_ERR(ctx->bl_supply))
> +			return dev_err_probe(dev, PTR_ERR(ctx->bl_supply),
> +					     "Failed to get backlight supply\n");

[Severity: High]
Will this break probe backward compatibility for existing device trees?

The devm_regulator_get_optional() function returns ERR_PTR(-ENODEV) when the
requested regulator is absent from the device tree. Because this bl-supply
property was just introduced and is optional, existing devices do not have =
it.
Should this code explicitly check for and handle -ENODEV (for example, by
setting the pointer to NULL) instead of failing the probe unconditionally?

>  		ctx->backlight =3D himax_create_backlight(ctx);
>  		if (IS_ERR(ctx->backlight))
>  			return dev_err_probe(dev, PTR_ERR(ctx->backlight),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608162622.4037=
13-1-zhengxingda@iscas.ac.cn?part=3D3
