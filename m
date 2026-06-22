Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32279CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 18:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 595A810E849;
	Mon, 22 Jun 2026 18:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gx7vJsO4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0DBC10E83F
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 18:18:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C2D1601F3;
 Mon, 22 Jun 2026 18:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47491F000E9;
 Mon, 22 Jun 2026 18:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782152286;
 bh=KkfqU7tGih/L4qYhdfKSz+N5gePqcZ9t1uFEJue2v2w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gx7vJsO4TvUPk1EDct31m4rp8pWkgFM8qEluOX3g9CFvfT26T+GgBiCUgypvKeKiX
 nHzqGVdp11VBOhIZhMzf8yfMdEtcEKOBbxJdLONqFFl9fgMtnznnwNZijKgjg8vfmn
 E1orP8Lr3oJqeahaUUom/rGsx27QMWPvPxWQCvh5D3vwS/VoHdhMr5xbjBBg/esMzP
 UO3ml91T7oDoSvJwCnZaRTMHe1Q78c1gCeCemgoFzCaeIfFrFNxs8wB94//Ksvql7e
 8iNIU1I3fPz1rOThQRfImDQ/ihYF6RAvk/SiK/nWCcCgfAsVrwzyeBD1hde9UYqx7i
 GLB7PckDe6F5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] GPU: drm: meson inline drm_simple_encoder_init()
To: "Liam Zuiderhoek" <zuiderhoekl@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622180832.28143-1-zuiderhoekl@gmail.com>
References: <20260622180832.28143-1-zuiderhoekl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 18:18:06 +0000
Message-Id: <20260622181806.B47491F000E9@smtp.kernel.org>
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
- [High] Incorrect inlining of `drm_simple_encoder_init()` omits the `funcs=
` parameter, passing 4 arguments to a function expecting at least 5, result=
ing in a severe type mismatch and a missing `drm_encoder_funcs` structure.

Pre-existing issues:
- [High] Failure to remove the DRM bridge on error paths leaves a dangling =
pointer in the global bridge list and permanently leaks the bridge containe=
r memory.
--

commit cff971d423a1058d9ded86a03517245fb14f47c1
Author: Liam Zuiderhoek <zuiderhoekl@gmail.com>

GPU: drm: meson inline drm_simple_encoder_init()

This patch replaces the drm_simple_encoder_init() call in the meson HDMI
encoder with a direct call to drm_encoder_init() as part of the DRM subsyst=
em
TODO list.

> diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm=
/meson/meson_encoder_hdmi.c
> index 55c0601df3c62..48ca6874d4a01 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> @@ -407,8 +407,8 @@ int meson_encoder_hdmi_probe(struct meson_drm *priv)
>  	meson_encoder_hdmi->priv =3D priv;
> =20
>  	/* Encoder */
> -	ret =3D drm_simple_encoder_init(priv->drm, &meson_encoder_hdmi->encoder,
> -				      DRM_MODE_ENCODER_TMDS);
> +	ret =3D drm_encoder_init(priv->drm, &meson_encoder_hdmi->encoder,
> +			       DRM_MODE_ENCODER_TMDS, NULL);

[Severity: High]
Does this pass the correct number of arguments to drm_encoder_init()?

Looking at drm_encoder_init() in drm_encoder.c, it expects at least five
arguments:
drm_encoder_init(dev, encoder, funcs, encoder_type, name, ...)

With only four arguments provided here in meson_encoder_hdmi_probe(), this
appears to pass the integer DRM_MODE_ENCODER_TMDS into the const struct
drm_encoder_funcs *funcs parameter, and NULL into the encoder_type paramete=
r,
omitting the name parameter entirely.

Will this cause a build failure, or a panic when funcs->destroy is later
dereferenced?

>  	if (ret) {
>  		dev_err_probe(priv->dev, ret, "Failed to init HDMI encoder\n");
>  		goto err_put_node;

[Severity: High]
This isn't a bug introduced by this patch, but does this error path need to
call drm_bridge_remove() to prevent a memory leak?

Earlier in meson_encoder_hdmi_probe(), the bridge is added to the global
bridge list:

	drm_bridge_add(&meson_encoder_hdmi->bridge);

If drm_encoder_init() fails and takes this goto err_put_node path, the
bridge remains in the global bridge list with an elevated refcount because
drm_bridge_remove() is not called.

Could this leave an orphaned bridge that permanently breaks the display
pipeline on subsequent probe retries?

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622180832.2814=
3-1-zuiderhoekl@gmail.com?part=3D1
