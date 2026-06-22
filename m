Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA46CDB466
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2099B10E844;
	Mon, 22 Jun 2026 19:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q9+6/JXB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1F8C10E844
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 19:58:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D5B643874;
 Mon, 22 Jun 2026 19:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9BF1F000E9;
 Mon, 22 Jun 2026 19:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782158335;
 bh=t2jWJVLGbMeZuw5g05GSEshHfmBNSTOCLrmTrMdg0WI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q9+6/JXBB5WnXK1MtwqeWaMna6WSEYo0bgVhwojrOAy0OtyfmIGRexp7PP/h9NHPk
 qzAouXjcDZa8vTKDdjsBHkqP19PCV4gTvHFtVbyi9yahJrhYJ0jOuWIfy3kgdd75mi
 K3vxSYvDFtT6d/0X2wRLyFYQGYQYUG0VhhxrJV8xdoNvwVLWoW11voV5mWeR3MvicJ
 wv/JqeKipZ8IP8t04yhwItil6RZTwb/CRB48dK8he63sStTQkbEiZnbA3e8nhwipH+
 6QWYWC+piUxUMkypIczihcRljA6++9FacGBGQ0RDpSbd9uUwM6BXpRKpyIfLGT7BTd
 EkgKE5J307Nrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] GPU: drm: meson: inline call to drm_simple_encoder_init()
To: "Liam Zuiderhoek" <zuiderhoekl@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622194649.218419-1-zuiderhoekl@gmail.com>
References: <20260622194649.218419-1-zuiderhoekl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 19:58:54 +0000
Message-Id: <20260622195855.1C9BF1F000E9@smtp.kernel.org>
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
- [High] The DRM bridge is added to the global bridge list but is not remov=
ed on subsequent error paths, leading to a Use-After-Free.
- [High] The devm-managed encoder is registered to the DRM device, causing =
a Use-After-Free on unbind if the DRM device outlives the platform device.
--

commit 38b3bb11e881972fb31cc13c9266c01adfa5805b
Author: Liam Zuiderhoek <zuiderhoekl@gmail.com>

GPU: drm: meson: inline call to drm_simple_encoder_init()

This commit inlines the function drm_simple_encoder_init for the meson
driver. It replaces the simple encoder init call with drm_encoder_init
and a custom cleanup struct.

> diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm=
/meson/meson_encoder_hdmi.c
> index 55c0601df3c62..0dd3a76ad959e 100644
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
This isn't a bug introduced by this patch, but does registering a devres
managed encoder with the DRM device cause a use-after-free during unbind?

The encoder structure is allocated earlier using devres:

	meson_encoder_hdmi =3D devm_drm_bridge_alloc(priv->dev, ...);

It is then initialized and registered into the DRM device's mode config list
here. If the driver is unbound and the platform device is destroyed, devres
will free the encoder memory. However, if userspace holds an open DRM file
descriptor, the DRM device outlives the platform device.

When the file descriptor is later closed and the DRM device is finally
destroyed, drm_mode_config_cleanup() will attempt to call the .destroy
callback on the freed encoder memory.

>  	if (ret) {
>  		dev_err_probe(priv->dev, ret, "Failed to init HDMI encoder\n");
>  		goto err_put_node;

[Severity: High]
This is a pre-existing issue, but does this error path lead to a
use-after-free?

Earlier in meson_encoder_hdmi_probe(), the bridge is added to the global
bridge list:

	drm_bridge_add(&meson_encoder_hdmi->bridge);

If drm_encoder_init() fails, we jump to err_put_node, which returns without
calling drm_bridge_remove(). The devres cleanup will then free
meson_encoder_hdmi, leaving a dangling pointer in the DRM core's global
bridge list.

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622194649.2184=
19-1-zuiderhoekl@gmail.com?part=3D1
