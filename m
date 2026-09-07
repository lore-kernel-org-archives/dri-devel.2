Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC322C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0506610E4DC;
	Mon,  7 Sep 2026 11:36:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="o1Rau0JF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B0B610E4DC
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:36:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EF08D40F36;
 Mon,  7 Sep 2026 11:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62CF1F00A3A;
 Mon,  7 Sep 2026 11:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788780963;
 bh=klRAW7F9npYk/itC630aN3W6Xu3KTTPTc/cDJLGotGI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=o1Rau0JF7No3hbFDe+fAlXL7oHdWP0txu678DAHgB1GtbiGsoUE7xmS7uyeIkLCRH
 z4+U9Om09rY1vwT1iSPPHm18+9LyGgYGlknPeITRewwW9Kakj2oV9LWX+T7TBLfzq8
 nPXScwcYfTg9WRdLbi69rKjIuOg7MbuKdeusSAOTgbp7sbktK7BAcNyh4Cc8Fm0iZy
 KjRA0FpiSxMxtRt5v0Q+As0wXXR7PBboieZYxAd/bS/lEazMNglJjigxfc5PB7qYBR
 9/8lwkIJkU5Iy9UDZhszC/D/Jto9Gw1qdYNcifTbP3UFncN/8Nx42N4xytBOr01J/L
 K7WQSYuYQOqbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/13] drm/bridge: tc358762: Improve DPI enable handling
To: "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907-tc358762-fixes-v4-6-e3fc3ab5cd83@ideasonboard.com>
References: <20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com>
 <20260907-tc358762-fixes-v4-6-e3fc3ab5cd83@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 11:36:03 +0000
Message-Id: <20260907113603.A62CF1F00A3A@smtp.kernel.org>
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
- [High] Unhandled error in tc358762_post_disable() poisons the accumulated=
 error state, silently breaking subsequent bridge initialization.
--

commit 28214859a6b5c3e5c579f3076ec1cf46dc47e5c5
Author: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

drm/bridge: tc358762: Improve DPI enable handling

This commit clears the DPIENABLE bit early during the display enable
sequence to avoid a temporary DPI output with incorrect timings. It also
disables the DPI output during the bridge disable phase.

> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/t=
c358762.c
> index ee72978cd8d80..7654d4039a9d7 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c
> @@ -134,6 +134,12 @@ static int tc358762_init(struct tc358762 *ctx)
>  {
>  	u32 lcdctrl;
> =20
> +	/*
> +	 * DPIENABLE has reset default of 1. Make sure we don't output on
> +	 * DPI until we have finished the coniguration.
> +	 */
> +	tc358762_write(ctx, LCDCTRL, 0);

[Severity: High]
If ctx->error is already set from a previous failure, will this write and a=
ll
subsequent configuration writes in tc358762_init() be silently skipped?

[ ... ]

> @@ -185,6 +191,9 @@ static void tc358762_post_disable(struct drm_bridge *=
bridge,
> =20
>  	ctx->pre_enabled =3D false;
> =20
> +	/* Turn off the DPI output */
> +	tc358762_write(ctx, LCDCTRL, 0);

[Severity: High]
Does this write need a corresponding tc358762_clear_error() call to clean up
the accumulated error state?

If this DSI write fails during tc358762_post_disable() (e.g., during a DPMS
off cycle or modeset), ctx->error is set. Since it is not cleared in the
teardown path, the error state persists into the next DPMS on cycle.

When the display is later enabled via tc358762_init() or tc358762_enable(),
the lingering ctx->error would cause every tc358762_write() to return
immediately without touching the hardware.

Could this transient failure prevent the hardware from being correctly
configured during the next DPMS on cycle?

> +
>  	if (ctx->reset_gpio)
>  		gpiod_set_value_cansleep(ctx->reset_gpio, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-tc358762-f=
ixes-v4-0-e3fc3ab5cd83@ideasonboard.com?part=3D6
