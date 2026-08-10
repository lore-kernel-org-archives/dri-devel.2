Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A45C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 10:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AF6C10E757;
	Mon, 10 Aug 2026 10:03:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mik1aXe0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9F8310E757
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 10:02:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 744294077F;
 Mon, 10 Aug 2026 10:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C50A1F000E9;
 Mon, 10 Aug 2026 10:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786356179;
 bh=23mpBQ82vJzZ9wY32jC744VpjgsKwchjdfhlA914FfM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mik1aXe0bxT5d49u7y/N+Xigir5NnM1t74g9u74DU7q+kaMhV0z7/Ha+lctT3X/ZM
 Da4u3+RyO79nwVaqPM3Ycc8XdZCXedNQnXA00zl/k+Jvr65Yx4L5z7u9s18efSNo7a
 42LeOXcbafgH8x4hz+UBKIkDeSqqFtLUpbXwtECP/yik9myOPZIBVkGwXmMqrp98SX
 FHTrtIrQwI+MtfFb9OvUZlnoVbIzd9swXQ1P+wGCXhelQa1IUgR97pxoK360y6TRvn
 uiRbvH6aI8OZRTatYtLckmd4aJDGuHjWyWDuOIuD9kSgKOwYaOmBeXrsc8Irva6Rhh
 Vk6gQYbEp4W+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/panel: lg-sw43408: do not assert reset
 across unprepare
To: "David Heidelberg" <david@ixit.cz>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260810-fix-blueline-panel-v2-1-9344dfdbc3f9@ixit.cz>
References: <20260810-fix-blueline-panel-v2-0-9344dfdbc3f9@ixit.cz>
 <20260810-fix-blueline-panel-v2-1-9344dfdbc3f9@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 10:02:58 +0000
Message-Id: <20260810100259.2C50A1F000E9@smtp.kernel.org>
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
- [High] Incomplete fix for the unrecoverable hardware state. The patch rem=
oves the reset assertion from `sw43408_unprepare()` to fix a hardware locku=
p, but the exact same reset assertion remains in the error path of `sw43408=
_prepare()`.
- [High] Missing `drm_panel_remove()` in the probe error path leaves a dang=
ling panel in the global registry, leading to a Use-After-Free.
--

--- Patch [1]: [PATCH v2 1/2] drm/panel: lg-sw43408: do not assert reset ac=
ross unprepare ---
commit c7e02c477c8a5888497460cbf8b8bcfc7759b23d
Author: David Heidelberg <david@ixit.cz>

drm/panel: lg-sw43408: do not assert reset across unprepare

This patch removes the reset assertion from the unprepare() function.
Asserting the reset GPIO while the logic rail remains powered puts the DDIC
into a state it cannot recover from.

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
This isn't a bug introduced by this patch, but the same reset assertion that
causes the unrecoverable hardware state still exists in the error path of
sw43408_prepare().

If sw43408_program() fails, the driver branches to poweroff and asserts
the reset GPIO while vddi might still be powered:

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

Could this leave the DDIC in the same unrecoverable state if a DCS command
fails during initialization?

[Severity: High]
This is a pre-existing issue, but there appears to be a potential
use-after-free in the probe function.

If mipi_dsi_attach() fails in sw43408_probe(), the driver returns an error
without calling drm_panel_remove():

drivers/gpu/drm/panel/panel-lg-sw43408.c:sw43408_probe() {
    ...
	ret =3D sw43408_add(ctx);
	if (ret < 0)
		return ret;
    ...
	return mipi_dsi_attach(dsi);
}

Since sw43408_add() calls drm_panel_add() rather than devm_drm_panel_add(),
doesn't this leave the panel globally registered?

If devres then frees the panel's regulators and GPIOs upon probe failure,
could a display controller attempting to use the registered panel encounter
a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-fix-blueli=
ne-panel-v2-0-9344dfdbc3f9@ixit.cz?part=3D1
