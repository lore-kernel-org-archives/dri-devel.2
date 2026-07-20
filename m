Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4DCC44524
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E90A810E1E9;
	Mon, 20 Jul 2026 15:56:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IYYZIZnH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C12710E1E9
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:56:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E61854396B;
 Mon, 20 Jul 2026 15:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FCB1F00A3D;
 Mon, 20 Jul 2026 15:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784563011;
 bh=Q8EeV4dGpp0/VfWB9tiXvyOV2F3Tc9aWT6jOzV7G/80=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IYYZIZnHi7WqVfRSOuIM4Sdg7NIHX5hgthdAaOh039bvb/JubnaIWM5hyO7TTN+jY
 oHaADd5dQXiZQi2BLjH5sei6lLYsrsJqezzsSLviGTisK243azPxxZSnG7jIEUEZ2W
 XKiJ8Qus969ZD7k4GQeE4ykFoyMeeYx/N4qVvQHuQXN2jzDhsbqXhqOUhio7mTUFP7
 B5Hti+wgK9cD7p+erURLpG7x9y8B5wKenVDa2kTRIKfuDbYLQJ59H+ysz/nEeOQhr+
 nLam9ynx0EWTS6uUiosL9hTspeL4enJgMseSV6aSyVdX76hqZKL7xVGuxRvazrRnOA
 Y40bKOmqjjTcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/15] drm/meson: remove dependency on DRM simple
 helpers
To: "Diogo Silva" <diogompaissilva@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 Frank.Li@kernel.org, wsa+renesas@sang-engineering.com,
 neil.armstrong@linaro.org, imx@lists.linux.dev
In-Reply-To: <20260720-drm_simple_encoder_init-v2-13-5020b630668a@gmail.com>
References: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com>
 <20260720-drm_simple_encoder_init-v2-13-5020b630668a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:56:50 +0000
Message-Id: <20260720155651.66FCB1F00A3D@smtp.kernel.org>
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
- [High] Potential Use-After-Free due to mixing devres (`devm_`) allocation=
 with DRM object lifecycle.
--

--- Patch [13]: [PATCH v2 13/15] drm/meson: remove dependency on DRM simple=
 helpers ---
commit f601252d45634d954a7087cd68009adce3fbf5f7
Author: Diogo Silva <diogompaissilva@gmail.com>

drm/meson: remove dependency on DRM simple helpers

This patch replaces the deprecated simple KMS helper drm_simple_encoder_ini=
t()
with drm_encoder_init() across the CVBS, DSI, and HDMI encoders in the meson
DRM driver.

> diff --git a/drivers/gpu/drm/meson/meson_encoder_cvbs.c b/drivers/gpu/drm=
/meson/meson_encoder_cvbs.c
> index 22cacb1660c4f..cdb84d2283f83 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_cvbs.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
[ ... ]
> @@ -218,6 +218,10 @@ static const struct drm_bridge_funcs meson_encoder_c=
vbs_bridge_funcs =3D {
>  	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
>  };
> =20
> +static const struct drm_encoder_funcs meson_encoder_cvbs_funcs =3D {
> +	.destroy =3D drm_encoder_cleanup,
> +};
> +
>  int meson_encoder_cvbs_probe(struct meson_drm *priv)
>  {
[ ... ]
> @@ -257,8 +261,9 @@ int meson_encoder_cvbs_probe(struct meson_drm *priv)
>  	meson_encoder_cvbs->priv =3D priv;
> =20
>  	/* Encoder */
> -	ret =3D drm_simple_encoder_init(priv->drm, &meson_encoder_cvbs->encoder,
> -				      DRM_MODE_ENCODER_TVDAC);
> +	ret =3D drm_encoder_init(priv->drm, &meson_encoder_cvbs->encoder,
> +			       &meson_encoder_cvbs_funcs,
> +			       DRM_MODE_ENCODER_TVDAC, NULL);

[Severity: High]
This is a pre-existing issue, but does using devres for the encoder allocat=
ion
create a use-after-free risk during device unbind?

Looking earlier in meson_encoder_cvbs_probe(), the structure containing the=
 DRM
encoder is allocated with devres:

	meson_encoder_cvbs =3D devm_drm_bridge_alloc(priv->dev,
						   struct meson_encoder_cvbs,
						   bridge,
						   &meson_encoder_cvbs_bridge_funcs);

If the physical device is unbound (e.g., via sysfs) while a user application
holds a DRM file descriptor open, the devres framework will free this memor=
y,
including the embedded struct drm_encoder.

Later, when the file descriptor is closed and the DRM core tears down the
device, it will call drm_encoder_cleanup() on the already-freed encoder.

The exact same devres allocation pattern is also present in=20
meson_encoder_dsi_probe() for meson_encoder_dsi, and in
meson_encoder_hdmi_probe() for meson_encoder_hdmi.

Could these be converted to use DRM-managed allocators (like drmm_kzalloc) =
to
ensure the memory safely outlives the physical device unbind?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-drm_simple=
_encoder_init-v2-0-5020b630668a@gmail.com?part=3D13
