Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CAAC5AC67
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 00:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62DE510E071;
	Sun,  9 Aug 2026 00:12:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ouhjtNyZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4498710E071
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 00:12:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4273360008;
 Sun,  9 Aug 2026 00:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15A51F000E9;
 Sun,  9 Aug 2026 00:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786234333;
 bh=cybXEsccUxEpOuKpIFzchgBjXYuRDwvYhUn3OZLgY8w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ouhjtNyZh7tQnt/82EZJ7+AzUK7UeiMo7TjvGPUL0Xg7IYulSKKxoiWx673OVt/O2
 FNJqowCEfJ/hrw3VnaKqrlrMPdkAj/E+xZbgu1/0LSfrOOJnsMNp0m3bRRI3YNAvq/
 yANl694p9UQOQ++MNqDPsNXNvYAMpg5NqfLmgYOhkQgIHPJCS9zdlAG+zj0vsLtfK6
 BfeKm8V8euo06ph3//yLm0mWEtAcAGZu04iOuuEEZnfUJ1smc+vsIFkSzOS7TO2PG8
 UYbqbNyNa/LC1y/glQMya892Oxo3SaYnWcTH+duNnL+TLWg+Zd1X8NxkieSoQalgUL
 SU7ofhJGsqGZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/panel: lg-sw43408: do not assert reset across
 unprepare
To: "David Heidelberg" <david@ixit.cz>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260809-fix-blueline-panel-v1-1-e7f3a6beb1fa@ixit.cz>
References: <20260809-fix-blueline-panel-v1-0-e7f3a6beb1fa@ixit.cz>
 <20260809-fix-blueline-panel-v1-1-e7f3a6beb1fa@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 00:12:12 +0000
Message-Id: <20260809001212.C15A51F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The error path in `sw43408_prepare()` still asserts the reset GPIO=
, reintroducing the unrecoverable DDIC state that this patch intends to fix.
- [High] Missing `drm_panel_remove()` on the `mipi_dsi_attach()` error path=
 leaves a dangling panel in the global registry.
--

--- Patch [1]: [PATCH 1/2] drm/panel: lg-sw43408: do not assert reset acros=
s unprepare ---
commit 943efe5fda9e672780d0b298511b40b26e4fb79c
Author: David Heidelberg <david@ixit.cz>

    drm/panel: lg-sw43408: do not assert reset across unprepare

This commit stops asserting the reset GPIO in sw43408_unprepare(). Leaving
it asserted while the shared logic rail remains powered puts the DDIC into
an unrecoverable state where it fails to light up again.

> diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/p=
anel/panel-lg-sw43408.c
> index 293826c5006b9..0bf8e08f10b9c 100644
> --- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
> +++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> @@ -55,8 +55,14 @@ static int sw43408_unprepare(struct drm_panel *panel)
> =20
>  	mipi_dsi_msleep(&ctx, 100);
> =20
> -	gpiod_set_value(sw43408->reset_gpio, 1);
> -
> +	/*
> +	 * Keep reset deasserted: vddi may stay powered (it is shared with
> +	 * the touchscreen on Pixel 3) and holding the DDIC in reset while
> +	 * its logic rail is up puts it into a state that no init sequence
> +	 * recovers from - the panel keeps answering DCS commands and
> +	 * reports display-on, but never lights up again. The vendor stack
> +	 * only ever toggles reset as part of a powered-up init sequence.
> +	 */
>  	ret =3D regulator_bulk_disable(ARRAY_SIZE(sw43408_supplies), sw43408->s=
upplies);
> =20
>  	return ret ? : ctx.accum_err;

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
sw43408_prepare() reintroduce the exact problem this patch fixes?

If sw43408_program() fails, the code jumps to the poweroff label:

drivers/gpu/drm/panel/panel-lg-sw43408.c:sw43408_prepare() {
    ...
	ret =3D sw43408_program(panel);
	if (ret)
		goto poweroff;

	return 0;

poweroff:
	gpiod_set_value(ctx->reset_gpio, 1);
	regulator_bulk_disable(ARRAY_SIZE(sw43408_supplies), ctx->supplies);
	return ret;
}

This explicitly asserts the reset GPIO while regulators are disabled. Since
vddi is shared and remains powered, doesn't this strand the DDIC in the
unrecoverable state upon initialization failure?


[Severity: High]
This is another pre-existing issue, but does sw43408_probe() leak the panel
and leave it dangling in the global DRM panel list on attachment failure?

drivers/gpu/drm/panel/panel-lg-sw43408.c:sw43408_probe() {
    ...
	ret =3D sw43408_add(ctx);
	if (ret < 0)
		return ret;
    ...
	return mipi_dsi_attach(dsi);
}

The sw43408_add() function registers the panel with drm_panel_add(). If
mipi_dsi_attach() subsequently fails, it returns the error without calling
drm_panel_remove(). When a DRM display driver later finds this panel and
attempts to use it via the unattached DSI device, could this cause a kernel
oops?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809-fix-blueli=
ne-panel-v1-0-e7f3a6beb1fa@ixit.cz?part=3D1
