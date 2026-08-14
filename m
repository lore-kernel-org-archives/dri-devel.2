Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9022C5DF66
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 01:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D51910E070;
	Fri, 14 Aug 2026 01:22:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BEaFP5XZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C4BB10E070
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 01:22:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D86643223;
 Fri, 14 Aug 2026 01:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6905A1F000E9;
 Fri, 14 Aug 2026 01:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786670559;
 bh=CShUSsBLGkyUTeCK6p8Dv3iqnEPkEVwC9ifXz18Lbp4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BEaFP5XZq/iA5SOjWT4fwwvy932iVv1krzv3/FRKLdLxbdAmftHLIqCMrQVMMT6UX
 OXIXH/vhfrc39N4gsbCfq4Dk+IZS6Lxu0aijmeB08Y3leygjcdsSzn9IQdztWP8/Y8
 +TTzKwe20/d0lFgqAd7q1Gn4jSq/Kkme4fy+L9laLpvMs8Rmdt9a2MISF7+CRwWtN1
 hGsdwJpLHPe+zXAcK7cUPCODF7//6fFSJZ8E9aOB8ZzKS3iuiGWfy4SKur5Impcemv
 EVOsAG3VpbePJP2yuCJd56akAB7tU5KNpMci90/7U8AwZEd0oOdqLjzC1Z7P6OzI2I
 RPWwZnSFwxcaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 54/78] drm/meson: encoder_cvbs: Switch to
 atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 neil.armstrong@linaro.org
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-54-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-54-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:22:34 +0000
Message-Id: <20260814012235.6905A1F000E9@smtp.kernel.org>
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
- [High] Missing drm_bridge_remove() on error paths in meson_encoder_cvbs_p=
robe leads to a leaked bridge, leaked 'next_bridge' reference, and a dangli=
ng pointer in the global bridge_list.
--

--- Patch [54]: [PATCH v2 54/78] drm/meson: encoder_cvbs: Switch to atomic_=
create_state ---
commit 495782f6fcc8d5b1c7e6fd45af9f1be19848e42c
Author: Maxime Ripard <mripard@kernel.org>

drm/meson: encoder_cvbs: Switch to atomic_create_state

This commit switches the meson_encoder_cvbs bridge from the deprecated
atomic_reset callback to the atomic_create_state callback.

> diff --git a/drivers/gpu/drm/meson/meson_encoder_cvbs.c b/drivers/gpu/drm=
/meson/meson_encoder_cvbs.c
> --- a/drivers/gpu/drm/meson/meson_encoder_cvbs.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
> @@ -215,7 +215,7 @@ static const struct drm_bridge_funcs meson_encoder_cv=
bs_bridge_funcs =3D {
>  	.atomic_check =3D meson_encoder_cvbs_atomic_check,
>  	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> -	.atomic_reset =3D drm_atomic_helper_bridge_reset,
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
>  };
> =20
>  int meson_encoder_cvbs_probe(struct meson_drm *priv)
>  {

[ ... ]

>  	drm_bridge_add(&meson_encoder_cvbs->bridge);
> =20
>  	meson_encoder_cvbs->priv =3D priv;
> =20
>  	/* Encoder */
>  	ret =3D drm_simple_encoder_init(priv->drm, &meson_encoder_cvbs->encoder,
>  				      DRM_MODE_ENCODER_TVDAC);
>  	if (ret)
>  		return dev_err_probe(priv->dev, ret,
>  				     "Failed to init CVBS encoder\n");

[Severity: High]
This is a pre-existing issue, but does this error path leak the bridge?

If drm_simple_encoder_init() fails, the function returns directly without
calling drm_bridge_remove(). It looks like this leaves the bridge object
in the global bridge_list.

Could this lead to a use-after-free or kernel oops if the driver module
is unloaded and another subsystem iterates over the list? Should there
be a cleanup path here for drm_bridge_add() and the next_bridge reference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm-no-mor=
e-bridge-reset-v2-0-0a91018bf886@kernel.org?part=3D54
