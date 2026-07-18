Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D476C44521
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 23:53:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B61310E61A;
	Sat, 18 Jul 2026 23:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SqjJU6OM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D66110E61A
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 23:53:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C192C40D7B;
 Sat, 18 Jul 2026 23:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C31F1F000E9;
 Sat, 18 Jul 2026 23:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784418793;
 bh=RRB0k3IsUMHH6EVNPRN7+g/nJgeU96S9NUOTSJiwryU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SqjJU6OMQ41W0h0XmXYOFpLumZsplwHLdfAuJOQ4DRWVse5JlwS6EtZhnmd3RmpHI
 5AXMrmfdopkkqD193v5uIy7EQNpuauOM+tmFohwzecMK1S7deAIuvg+zjYgdWKYnLo
 p1+68MUcVdkyZ4PK2R0PGbp5DblGLuWT+UelWnVDbwn+UYWv4MSqP9tnltgEvv4EON
 stGK5dOXpjDARDxejikaFgQplFiG/n5zPNJX/tQnThbbYX54yaiqp5XXgcQPjuTrka
 q+UoqPfHIweYLuCur7cj9RbGylmDDZ5do9/tdMXn7ajlq784UlonVR8iCWOIcB1psd
 JROTRZAKtVuSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/15] drm/meson: remove dependency on DRM simple helpers
To: "Diogo Silva" <diogompaissilva@gmail.com>
Cc: wsa+renesas@sang-engineering.com, linux-amlogic@lists.infradead.org,
 imx@lists.linux.dev, neil.armstrong@linaro.org,
 dri-devel@lists.freedesktop.org, Frank.Li@kernel.org
In-Reply-To: <20260719-drm_simple_encoder_init-v1-13-a78c509e3062@gmail.com>
References: <20260719-drm_simple_encoder_init-v1-0-a78c509e3062@gmail.com>
 <20260719-drm_simple_encoder_init-v1-13-a78c509e3062@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 23:53:13 +0000
Message-Id: <20260718235313.5C31F1F000E9@smtp.kernel.org>
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
- [High] Devm lifecycle mismatch with DRM device leads to a Use-After-Free =
of the encoder structure if userspace holds the DRM file descriptor open af=
ter the device unbinds.
--

--- Patch [13]: [PATCH 13/15] drm/meson: remove dependency on DRM simple he=
lpers ---
commit 2b596eefd506c3e256e80a53bf84b95edfa9824a
Author: Diogo Silva <diogompaissilva@gmail.com>

drm/meson: remove dependency on DRM simple helpers

The simple KMS helpers are deprecated because they only add an intermediate
layer between drivers and atomic modesetting. Open-code
drm_simple_encoder_init() by calling drm_encoder_init() directly and
providing driver-local drm_encoder_funcs.

> diff --git a/drivers/gpu/drm/meson/meson_encoder_cvbs.c b/drivers/gpu/drm=
/meson/meson_encoder_cvbs.c
> index 22cacb1660c4f..cdb84d2283f83 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_cvbs.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
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
This is a pre-existing issue, but does this create a use-after-free risk
during device unbind?

In meson_encoder_cvbs_probe(), the encoder is embedded within
meson_encoder_cvbs, which is allocated via devm_drm_bridge_alloc() and tied
to the device lifetime. However, by using drm_encoder_init(), the encoder
is registered with the DRM device's lifecycle.

If a driver unbind occurs (e.g., via sysfs) while userspace holds an open
DRM file descriptor, devres will execute and free the bridge memory along
with the embedded encoder. Later, when the file descriptor is closed,
drm_mode_config_cleanup() iterates over the encoder_list and attempts to
call the encoder's destroy function on the already freed memory.

Could we use drmm_encoder_init() instead to safely tie the encoder's
lifetime to the DRM device?

This same devm vs DRM lifecycle mismatch is also present in
meson_encoder_dsi_probe() in drivers/gpu/drm/meson/meson_encoder_dsi.c and
meson_encoder_hdmi_probe() in drivers/gpu/drm/meson/meson_encoder_hdmi.c.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719-drm_simple=
_encoder_init-v1-0-a78c509e3062@gmail.com?part=3D13
