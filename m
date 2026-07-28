Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DFBC53209
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 01:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C24EE10E394;
	Tue, 28 Jul 2026 01:50:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OlHumQiY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31DD510E394
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 01:50:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 29382600FC;
 Tue, 28 Jul 2026 01:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FA71F000E9;
 Tue, 28 Jul 2026 01:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785203451;
 bh=Hve1um3Y0f2BaZbOb/Og7aroG2HQ+7tQqtvFeHbF6xE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OlHumQiYbJVXglexUC8mFkaolKguvDe+1n3OkM/GOR0oMJ2TkMZ+5ejDaxvPcDB4T
 gxxnE0U8ujlV1koU7FcC8hy91QwpjWgIBltXgO66WOXEVrrktT5A65TwCXDOuxpnTT
 EAu1Z8dHp0f8RR1OaVIr/xKH9N63Chw2OxY/MHTDLee50SR65x4IcE1ElIAjf8TlYa
 KR3HvsilJLVnIIWxF6RkmJ9WVj7p6zfqp76b0LQy7mD/wlvu+ZGGvsVxzzdVSRH5g+
 9skLCtRBsvaPX7avaiklf+Ha4GurpgaLqwmzXeLMYUEq+uPCm4hGfTuSM2iicW3goa
 LNYWXMeI1ZlVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/panel: tdo-tl070wsh30: Use mipi_dsi_*_multi()
 functions
To: "Akash Sukhavasi" <akash.sukhavasi@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260727-mipi-dsi-tl070wsh30-multi-v2-1-f47b937631d3@gmail.com>
References: <20260727-mipi-dsi-tl070wsh30-multi-v2-1-f47b937631d3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 01:50:51 +0000
Message-Id: <20260728015051.97FA71F000E9@smtp.kernel.org>
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
- [Medium] Unintended short-circuiting of the panel power-down sequence on =
error.
--

--- Patch [1]: [PATCH v2] drm/panel: tdo-tl070wsh30: Use mipi_dsi_*_multi()=
 functions ---
commit dccc547d72f30cdc8106a575cdc689ca0fbc4142
Author: Akash Sukhavasi <akash.sukhavasi@gmail.com>

drm/panel: tdo-tl070wsh30: Use mipi_dsi_*_multi() functions

This commit converts the tdo-tl070wsh30 panel driver to use the
mipi_dsi_*_multi() API. It also updates unprepare() to disable the
regulator unconditionally and return 0.

Link: https://lore.kernel.org/r/20260725-mipi-dsi-tl070wsh30-multi-v1-1-691=
60b83982e@gmail.com

> diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/d=
rm/panel/panel-tdo-tl070wsh30.c
> index 13cfe252a838d..cd846e5ab2e7e 100644
> --- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
> +++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c

[ ... ]

>  static int tdo_tl070wsh30_panel_unprepare(struct drm_panel *panel)
>  {
>  	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 =3D to_tdo_tl070wsh30_panel=
(panel);
> -	int err;
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D tdo_tl070wsh30->li=
nk };
> =20
> -	err =3D mipi_dsi_dcs_set_display_off(tdo_tl070wsh30->link);
> -	if (err < 0)
> -		dev_err(panel->dev, "failed to set display off: %d\n", err);
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> =20
> -	usleep_range(10000, 11000);
> +	mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
> =20
> -	err =3D mipi_dsi_dcs_enter_sleep_mode(tdo_tl070wsh30->link);
> -	if (err < 0) {
> -		dev_err(panel->dev, "failed to enter sleep mode: %d\n", err);
> -		return err;
> -	}
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> =20
> -	usleep_range(10000, 11000);
> +	mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
> =20
>  	regulator_disable(tdo_tl070wsh30->supply);

[Severity: Medium]
Does this unintentionally short-circuit the panel power-down sequence on er=
ror?

In the original code, if mipi_dsi_dcs_set_display_off fails, the error is
logged but execution continues. This ensures the 10ms delays and the
enter_sleep_mode command are still processed before disabling the regulator.

With the multi API, if mipi_dsi_dcs_set_display_off_multi fails, it sets
dsi_ctx.accum_err. The subsequent mipi_dsi_usleep_range and
mipi_dsi_dcs_enter_sleep_mode_multi calls will check this accumulated error
and skip their execution entirely.

Could this immediate jump to regulator_disable violate the panel's
power-down timing requirements by skipping the mandatory delays?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-mipi-dsi-t=
l070wsh30-multi-v2-1-f47b937631d3@gmail.com?part=3D1
