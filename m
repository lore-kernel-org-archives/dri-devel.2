Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8E3C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 21:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C2010F710;
	Thu,  9 Jul 2026 21:08:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BtgllV59";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E2510F710
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 21:08:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0F2FF40676;
 Thu,  9 Jul 2026 21:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72F31F000E9;
 Thu,  9 Jul 2026 21:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783631314;
 bh=r+xZpvMgaCfFyrAKqvHAw5Gzt11rUilGyxt/GV4BNsQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BtgllV59JmLw/nsGxCnoiMDlcl2oRPiQqhXa3LUn0sJALAI/iYveLC/TkvY9Q7elt
 Wp01iWyovnKGdmwEeUvdqCZEebTcsVOXfldbboUU3XC4CiKdsO7kdpHe/dZHEzybqf
 MKZqHJ8inkkqjzRXzLYYEIy8XbqrDiOCuNiIvSk+5jtGOQacE41k1/7ONfdkIWbmq+
 buN+yZRlDFlKF4iaFQ9z8e872+HxyQht61oEF69uXIVx/R/rkeiI/SqnG+kWDcE3B6
 pAAL0RFgoWtY3vOpK/nJuAqbIEMPzMhX50+BWoq2IL/U9fEkH5lEniAFL7iNfPylRc
 iOwW86Vnav4oQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] GPU: drm: meson: inline call to drm_simple_encoder_init()
To: "Liam Zuiderhoek" <zuiderhoekl@gmail.com>
Cc: linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260709205538.73157-1-zuiderhoekl@gmail.com>
References: <20260709205538.73157-1-zuiderhoekl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 21:08:31 +0000
Message-Id: <20260709210834.A72F31F000E9@smtp.kernel.org>
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
- [Low] The commit message claims to inline `drm_simple_encoder_init()` for=
 the meson driver, but it only modifies the HDMI encoder, leaving the depre=
cated helper in use by other encoders in the same driver.

Pre-existing issues:
- [High] The `meson_encoder_hdmi` structure (which embeds `struct drm_encod=
er`) is allocated with `devm_drm_bridge_alloc()`, but the encoder is initia=
lized with `drm_encoder_init()`. This creates a mismatch in lifecycles that=
 leads to a use-after-free when the platform device is unbound but userspac=
e still holds a reference to the DRM device.
--

--- Patch [1]: [PATCH] GPU: drm: meson: inline call to drm_simple_encoder_i=
nit() ---
commit bb202202974455054588168b82acfc49ff85b23f
Author: Liam Zuiderhoek <zuiderhoekl@gmail.com>

GPU: drm: meson: inline call to drm_simple_encoder_init()

This commit inlines the function drm_simple_encoder_init for the meson
driver. It replaces the simple encoder init call with drm_encoder_init
and a custom cleanup struct.

> This commit inlines the function drm_simple_encoder_init for the meson
> driver. It replaces the simple encoder init call with drm_encoder_init
> and a custom cleanup struct.

[Severity: Low]
Does this commit miss updating other encoders in the meson driver?

The commit message implies it inlines the function for the meson driver as a
whole, but meson_encoder_cvbs_probe() in meson_encoder_cvbs.c and
meson_encoder_dsi_probe() in meson_encoder_dsi.c still use
drm_simple_encoder_init().

Additionally, is the include for <drm/drm_simple_kms_helper.h> still needed
in meson_encoder_hdmi.c now that the helper has been open-coded?

> diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm=
/meson/meson_encoder_hdmi.c
> index 0c7a72cb514ae..70a543358041f 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c

[ ... ]

> @@ -407,8 +411,9 @@ int meson_encoder_hdmi_probe(struct meson_drm *priv)
>  	meson_encoder_hdmi->priv =3D priv;
> =20
>  	/* Encoder */
> -	ret =3D drm_simple_encoder_init(priv->drm, &meson_encoder_hdmi->encoder,
> -				      DRM_MODE_ENCODER_TMDS);
> +	ret =3D drm_encoder_init(priv->drm, &meson_encoder_hdmi->encoder,
> +			       &drm_simple_encoder_funcs_cleanup,
> +			       DRM_MODE_ENCODER_TMDS, NULL);

[Severity: High]
This is a pre-existing issue, but does this allocation lifecycle mismatch
lead to a use-after-free?

Looking at meson_encoder_hdmi_probe(), the structure embedding the encoder =
is
allocated with devm_drm_bridge_alloc(), tying its lifetime to the platform
device:

meson_encoder_hdmi_probe() {
    ...
    meson_encoder_hdmi =3D devm_drm_bridge_alloc(priv->dev, ...);
    ...
}

However, the encoder is initialized here with drm_encoder_init(), tying its
cleanup to the DRM device's release.

If the platform device is unbound, devres automatically frees
meson_encoder_hdmi. If a userspace process holds an open file descriptor to
the DRM device during unbind, the DRM device outlives the platform device.

When the userspace process eventually closes the fd, drm_dev_release()
calls drm_mode_config_cleanup(), which iterates over the mode config list
and accesses the freed meson_encoder_hdmi->encoder to call its destroy
callback.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709205538.7315=
7-1-zuiderhoekl@gmail.com?part=3D1
