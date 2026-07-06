Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1622FC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7632310E745;
	Mon,  6 Jul 2026 05:36:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jyXKw9QB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAACE10E745
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 05:36:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C2CC641418;
 Mon,  6 Jul 2026 05:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3381F000E9;
 Mon,  6 Jul 2026 05:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783316161;
 bh=2MTDSQkp0/s1des83Xm0zkuYq4TTkM2eer1Opoc93hU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jyXKw9QBYc335qNW/ig06i0qdfq2q0us7PyWKkAk4Oi6yZI+PBQa1+KZ2seVanKZF
 LxZJOvTRJ4ztE3JQogNovNDYHbRQ3LNZ948FtHeeI+hR4Zzn4JMqtVCM2kbvDCMHpn
 dyj6Qskqog8gqyFNoTlHHhgWANFiSM8LV7CZIOHYER61AX73UAqk6Q+qTSmnAra++8
 hFFZxQhm8+kX+bwjNHIdH+1a/FCnIV1jABr4pXn3n1IFN1KQDLXQa6BGw383dP7aSX
 sKppfVbb5cYZaH6MIBYmRDMXymnbwNvqnwIF3VxzNe41Gk9PndkplGNHK8QRYOSIw2
 q67TP23pyLH0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panel: sofef00: Fix DSI transfer errors on
 backlight update
To: =?utf-8?b?Q8OpZHJpYyBCZWxsZWdhcmRl?= <cedric.bellegarde@adishatz.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706051825.78752-1-cedric.bellegarde@adishatz.org>
References: <20260706051825.78752-1-cedric.bellegarde@adishatz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 05:36:01 +0000
Message-Id: <20260706053601.7B3381F000E9@smtp.kernel.org>
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
- [High] The lockless check of `!ctx->panel.prepared` is an incomplete fix =
that leaves a TOCTOU race condition during panel teardown, allowing DCS com=
mands to be sent to a powered-off panel.
--

commit 08b3ae9b50bea647e6675f125e2afbca849ac110
Author: C=C3=A9dric Bellegarde <cedric.bellegarde@adishatz.org>

drm/panel: sofef00: Fix DSI transfer errors on backlight update

Backlight updates via bl_update_status() could be triggered before the panel
was fully initialized. This commit guards bl_update_status() with a prepared
flag check to skip backlight updates when the panel is not yet ready.

> diff --git a/drivers/gpu/drm/panel/panel-samsung-sofef00.c b/drivers/gpu/=
drm/panel/panel-samsung-sofef00.c
> index e00a497a7c961..f07d6533ed697 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-sofef00.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
> @@ -175,9 +175,13 @@ static const struct drm_panel_funcs sofef00_panel_pa=
nel_funcs =3D {
>  static int sofef00_panel_bl_update_status(struct backlight_device *bl)
>  {
>  	struct mipi_dsi_device *dsi =3D bl_get_data(bl);
> +	struct sofef00_panel *ctx =3D mipi_dsi_get_drvdata(dsi);
>  	int err;
>  	u16 brightness =3D (u16)backlight_get_brightness(bl);
> =20
> +	if (!ctx->panel.prepared)
> +		return 0;
> +

[Severity: High]
This is a pre-existing issue, but does this lockless check create a TOCTOU
race with the unprepare sequence?

During teardown, drm_panel_unprepare() calls the driver's .unprepare callba=
ck
which powers off the panel regulators, and only sets panel->prepared =3D fa=
lse
after the callback returns. If a concurrent sysfs backlight write occurs wh=
ile
.unprepare is executing, ctx->panel.prepared would still be true.

Could this allow bl_update_status() to attempt sending DCS commands to a
powered-off panel, resulting in the same DSI transmission timeouts and clock
lockups this patch is trying to fix?

Should a driver-level mutex be used to synchronize bl_update_status() with
the teardown callbacks instead?

>  	dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> =20
>  	err =3D mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706051825.7875=
2-1-cedric.bellegarde@adishatz.org?part=3D1
