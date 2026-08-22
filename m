Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC657C5DF97
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 17:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C72A710E345;
	Sat, 22 Aug 2026 17:15:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YKNROOAn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 101F510E345
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 17:15:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A3417409E4;
 Sat, 22 Aug 2026 17:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3391F000E9;
 Sat, 22 Aug 2026 17:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787418912;
 bh=kEUVsBZhh0aCsVVskuCXTb01oWnHTHmPMiPIBpBsImw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YKNROOAnS1ln4fIhZOAvpElpbI0kOi51x9q7mtZIXqOS08Y9s9MflbWxheU4vrO/t
 VFa+1dZ/HbGKclQsGbTBWOjy6e4PnGNuY9MwIA7rGnSm5nDi3nonxtrCamcAXIYmXt
 6tnbKNS1tiFt4uxMXSy5Ws2i9X1LbC5kE2zLq7Zu73wZwSk5GIyZcPH6T2JgpkiWFu
 Lor996KNKQ16m5uwwKARxnx3d6Uexf37vLXTW5j0BYhx3FYG4XUmp2ErI8GOK1zyEw
 yRorePNifQx35JmFchzrCCUIHwQRz4kUdxsVJ25CSVzYs4zRuDtcK6gsLwH+LJVbDI
 8XoIfB14n5c9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] drm/bridge: add support for lontium lt9211c bridge
To: vishnu.saini@oss.qualcomm.com
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260822-add-lt9211c-bridge-v7-2-7dcf567d57c4@oss.qualcomm.com>
References: <20260822-add-lt9211c-bridge-v7-0-7dcf567d57c4@oss.qualcomm.com>
 <20260822-add-lt9211c-bridge-v7-2-7dcf567d57c4@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 17:15:11 +0000
Message-Id: <20260822171512.3A3391F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Deferring LT9211C bridge configuration to an asynchronous workqueu=
e breaks the DRM display pipeline enablement sequence and introduces race c=
onditions.
- [High] Signed integer overflow in pixel clock calculations leads to undef=
ined behavior.
- [High] Unchecked division by `mode->clock` can cause a kernel panic (divi=
de-by-zero).
- [Medium] Chip ID detection succeeds for either hardware variant but ignor=
es device tree mismatch, leading to incorrect hardware initialization.

Pre-existing issues:
- [High] Unbinding the device via sysfs frees the bridge context while it i=
s still referenced by the DRM pipeline (Use-After-Free).
--

--- Patch [2]: [PATCH v7 2/2] drm/bridge: add support for lontium lt9211c b=
ridge ---
commit 8d2ec0de9ed01158cbba906a0bfbb93f7fab90c7
Author: Yi Zhang <zhanyi@qti.qualcomm.com>
Subject: drm/bridge: add support for lontium lt9211c bridge

This commit extends the lontium-lt9211 driver to support DSI-to-LVDS
bridge configuration for both LT9211 and LT9211C variants. It detects
chip IDs, provides per-chip configuration, and implements an asynchronous
initialization sequence for the LT9211C.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/br=
idge/lontium-lt9211.c
> --- a/drivers/gpu/drm/bridge/lontium-lt9211.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
[ ... ]
> @@ -120,14 +209,23 @@ static int lt9211_read_chipid(struct lt9211 *ctx)
>  		return ret;
>  	}
> =20
> -	/* Test for known Chip ID. */
> -	if (chipid[0] !=3D REG_CHIPID0_VALUE || chipid[1] !=3D REG_CHIPID1_VALU=
E) {
> -		dev_err(ctx->dev, "Unknown Chip ID: 0x%02x 0x%02x 0x%02x\n",
> -			chipid[0], chipid[1], chipid[2]);
> -		return -EINVAL;
> +	/* Test for LT9211 Chip ID. */
> +	if (chipid[0] =3D=3D REG_CHIPID0_VALUE && chipid[1] =3D=3D REG_CHIPID1_=
VALUE) {
> +		dev_dbg(ctx->dev, "Detected LT9211 chip\n");
> +		return 0;
>  	}
> =20
> -	return 0;
> +	/* Test for LT9211C Chip ID. */
> +	if (chipid[0] =3D=3D REG_CHIPID0_LT9211C_VALUE &&
> +	    chipid[1] =3D=3D REG_CHIPID1_LT9211C_VALUE &&
> +	    chipid[2] =3D=3D REG_CHIPID2_LT9211C_VALUE) {
> +		dev_dbg(ctx->dev, "Detected LT9211C chip\n");
> +		return 0;
> +	}

[Severity: Medium]
Does this chip ID validation check the physically detected chip against the
expected configuration? Since it returns 0 for both variants without checki=
ng
ctx->chip_data->chip_type (which comes from the device tree compatible
string), could an incorrectly configured device tree allow the driver to
proceed with the wrong initialization sequence?

[ ... ]
> @@ -454,6 +552,657 @@ static int lt9211_configure_tx(struct lt9211 *ctx, =
bool jeida,
[ ... ]
> +static int lt9211c_configure_tx(struct lt9211 *ctx, bool jeida, bool bpp=
24,
> +				bool de, const struct drm_display_mode *mode)
> +{
[ ... ]
> +	if (ctx->lvds_dual_link)
> +		phy_clk =3D (u32)(mode->clock * 7 / 2);
> +	else
> +		phy_clk =3D (u32)(mode->clock * 7);

[Severity: High]
Could this pixel clock calculation overflow? Since mode->clock is a signed
32-bit integer, multiplying it by 7 could overflow INT_MAX for high pixel
clocks (like a 4K resolution at ~594,000 kHz) before the result is cast to
u32.

Without a mode_valid or atomic_check callback to restrict the maximum
supported pixel clock, could this cause incorrect hardware initialization or
undefined behavior?

[ ... ]
> +	/*
> +	 * 0x8233: pix_mux sel & pix_div sel
> +	 * To avoid floating point operations, The pixclk_div is enlarged by 10=
 times
> +	 */
> +	if (mode->clock > 150000) {
> +		val =3D 0x04;
> +		pixclk_div =3D 35;
> +	} else {
> +		pixclk_div =3D
> +			(u8)((phy_clk * sericlk_div * 10) / (mode->clock * 7));

[Severity: High]
Does this division need to ensure mode->clock is non-zero? If userspace
provides a malformed mode with a clock of 0, could this trigger a
divide-by-zero exception and kernel panic?=20

Given the driver doesn't implement mode_valid or atomic_check callbacks,
there appears to be no filtering of custom modes before this calculation,
or the similar division below at:
div_set =3D (u8)(phy_clk * sericlk_div / mode->clock / pre_div)

[ ... ]
> @@ -523,6 +1272,21 @@ static void lt9211_atomic_enable(struct drm_bridge =
*bridge,
>  	if (ret)
>  		return;
> =20
> +	if (ctx->chip_data->chip_type =3D=3D LT9211C) {
> +		drm_mode_copy(&ctx->lt9211c_mode, mode);
> +		ctx->lt9211c_bpp24 =3D lvds_format_24bpp;
> +		ctx->lt9211c_jeida =3D lvds_format_jeida;
> +		ctx->lt9211c_de_high =3D !!(bus_flags & DRM_BUS_FLAG_DE_HIGH);
> +		ctx->lt9211c_crtc =3D crtc;
> +
> +		/*
> +		 * Needs a live DSI stream to auto-detect RX resolution/format;
> +		 * defer bridge configuration until after vblank.
> +		 */
> +		queue_delayed_work(ctx->wq, &ctx->lt9211_dw, 0);
> +		return;
> +	}

[Severity: High]
Does deferring the bridge configuration to an asynchronous workqueue break =
the
DRM atomic enablement sequence?=20

By returning immediately from atomic_enable(), downstream bridges like the
panel might be activated before the LT9211C has configured its RX, PLLs, and
TX output.

Additionally, if the CRTC relies on the bridge being active to generate
vblanks, could drm_crtc_wait_one_vblank() in lt9211_delayed_work_func()
cause a deadlock? If the pipeline is disabled while the work is running,
could cancel_delayed_work_sync() block indefinitely or cause a
use-after-free?

[ ... ]
> @@ -748,45 +1517,48 @@ static int lt9211_probe(struct i2c_client *client)
[ ... ]
> -	ctx->bridge.of_node =3D dev->of_node;
> -	drm_bridge_add(&ctx->bridge);
> -
> -	ret =3D lt9211_host_attach(ctx);
> +	ctx->bridge.of_node =3D dev->of_node;
> +	ret =3D devm_drm_bridge_add(dev, &ctx->bridge);
>  	if (ret)
> -		drm_bridge_remove(&ctx->bridge);
> -
> -	return ret;
> -}
> -
> -static void lt9211_remove(struct i2c_client *client)
> -{
> -	struct lt9211 *ctx =3D i2c_get_clientdata(client);
> +		return ret;
> =20
> -	drm_bridge_remove(&ctx->bridge);
> +	return lt9211_host_attach(ctx);
>  }

[Severity: High]
This is a pre-existing issue, but does tying the bridge context to the devi=
ce
lifetime (via devm_drm_bridge_alloc and devm_drm_bridge_add) instead of the
DRM object lifetime leave the module vulnerable?

If the device is unbound via sysfs while the display is active, the devres
cleanup frees the context memory. Since the DRM core doesn't synchronously
tear down active displays on bridge removal, would subsequent calls by the =
DRM
core to functions like lt9211_atomic_disable() on the freed pointer result =
in
a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822-add-lt9211=
c-bridge-v7-0-7dcf567d57c4@oss.qualcomm.com?part=3D2
