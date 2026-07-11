Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0BAC43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 11:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DFB710E363;
	Sat, 11 Jul 2026 11:59:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ebI3jUna";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E8D210E363
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 11:59:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EF2D2601D9;
 Sat, 11 Jul 2026 11:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776051F000E9;
 Sat, 11 Jul 2026 11:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783771141;
 bh=vW+1epFmxJNmQVmSUF1fFGWt5tCj92rd9RfzRJgbXb4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ebI3jUnaUk+qZ3xWokfosFyf2nlob4CizKxCgeV59tjrSmokKscigFnQ87GFCEeSR
 NyiNwhfxHWFMQmLWLLRwcMrA0WtLLgFYgCweGSnH0btPMa77+IFiUJJKeyWeOy5rgR
 4EhIsN1XnGaZTNjM5GqY+gs3WS42DouUVh5i7G46K3oy4whHitnKmaIYhdhtVNYTP5
 PCESPFg6xrB3d4fREaZesMl3qUSi8U8iJXsTDRJ5DiYVtv+t98UpyToL4hOM9axUcA
 bcosZbbMzLBTUilJ0nwA5FC85UYO3CMIwi0B9yFIR5yh81GIAeFjTNJY2b43HzZ+UH
 Jp2IHGJTZSgfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi83: Fix problem with
 premature PLL locking
To: "Esben Haabendal" <esben@geanix.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711-ti-sn65dsi83-fixes-v1-2-d85eb5342b98@geanix.com>
References: <20260711-ti-sn65dsi83-fixes-v1-0-d85eb5342b98@geanix.com>
 <20260711-ti-sn65dsi83-fixes-v1-2-d85eb5342b98@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 11:59:01 +0000
Message-Id: <20260711115901.776051F000E9@smtp.kernel.org>
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

New issues:
- [High] Missing SRCU read lock release in error path of sn65dsi83_atomic_e=
nable().

Pre-existing issues:
- [High] Missing SRCU read lock release in error path of sn65dsi83_reset_wo=
rk().
--

--- Patch [2]: [PATCH 2/2] drm/bridge: ti-sn65dsi83: Fix problem with prema=
ture PLL locking ---
commit 0c69248e520fff24e51d45bfab961991fbdb4267
Author: Esben Haabendal <esben@geanix.com>

drm/bridge: ti-sn65dsi83: Fix problem with premature PLL locking

This patch moves the PLL locking sequence from atomic_pre_enable to
atomic_enable. This ensures the DSI HS clock is running before attempting to
lock the PLL.

Link: https://lore.kernel.org/all/20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.c=
om/

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index 32e9eadd7452f..e87bed3a6640b 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c

[ ... ]

> @@ -712,11 +697,24 @@ static void sn65dsi83_atomic_enable(struct drm_brid=
ge *bridge,
>  {
>  	struct sn65dsi83 *ctx =3D bridge_to_sn65dsi83(bridge);
>  	unsigned int pval;
> -	int idx;
> +	int idx, ret;
> =20
>  	if (!drm_bridge_enter(bridge, &idx))
>  		return;
> =20
> +	/* Enable PLL */
> +	regmap_write(ctx->regmap, REG_RC_PLL_EN, REG_RC_PLL_EN_PLL_EN);
> +	usleep_range(3000, 4000);
> +	ret =3D regmap_read_poll_timeout(ctx->regmap, REG_RC_LVDS_PLL, pval,
> +				       pval & REG_RC_LVDS_PLL_PLL_EN_STAT,
> +				       1000, 100000);
> +	if (ret) {
> +		dev_err(ctx->dev, "failed to lock PLL, ret=3D%i\n", ret);
> +		/* On failure, disable PLL again and exit. */
> +		regmap_write(ctx->regmap, REG_RC_PLL_EN, 0x00);
> +		return;

[Severity: High]
Does this error path leak the SRCU read lock acquired by drm_bridge_enter()?

If the PLL lock fails and regmap_read_poll_timeout() returns an error, the
function returns immediately without calling drm_bridge_exit(idx).=20

This unreleased lock could cause subsequent calls to synchronize_srcu() to
hang during module unload or bridge unplug.

> +	}
> +
>  	/* Clear all errors that got asserted during initialization. */
>  	regmap_read(ctx->regmap, REG_IRQ_STAT, &pval);

[Severity: High]
This is a pre-existing issue, but I noticed a similar pattern in another
function in this file. Does sn65dsi83_reset_work() also leak the SRCU read
lock on failure?

drivers/gpu/drm/bridge/ti-sn65dsi83.c:sn65dsi83_reset_work() {
    if (!drm_bridge_enter(&ctx->bridge, &idx))
        return;
    ...
    ret =3D sn65dsi83_reset_pipe(ctx);
    if (ret) {
        dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
        return;
    }
    ...
    drm_bridge_exit(idx);
}

Like the atomic_enable path, if sn65dsi83_reset_pipe() fails, it appears to
return early without calling drm_bridge_exit(idx).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-ti-sn65dsi=
83-fixes-v1-0-d85eb5342b98@geanix.com?part=3D2
