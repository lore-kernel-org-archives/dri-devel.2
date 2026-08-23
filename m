Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C7CC5DF8C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 13:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F54F10E197;
	Sun, 23 Aug 2026 13:28:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TXlzy9ED";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C62C10E197
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 13:28:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E761D42B21;
 Sun, 23 Aug 2026 13:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11361F000E9;
 Sun, 23 Aug 2026 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787491720;
 bh=9SXANThxa6eIX/66bfANaZ63TNp6TUs65MlrWludUOQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TXlzy9ED/bt4LH0szqHmNASGSQexHV6m1/oomKiLZ0QlW5h05LFJyO3BaELwgkS65
 Gi3k5Z0dnW8YrJNwN3OA7N4oFMypaQRxwakJtO5AW+GyDsjLzNaW0AcrjJVSz35gmi
 ydT/1V8EgW7wTBUUqph+AQFTEoCdG7cZZr5ooo24lcIaOlZ6bg/w+T2tnOFO7Ez2xw
 z3ruerye/ym45Jyk69ey7bDUFUFlMmlZQDHZLbB+PO2gEdP4N6qvm4y7eHx3wB0U11
 A9Pz5tHS18+A3yu29Kx7CSCvcwUV3vWz3hubiJEokx6AkBqA36XiI8XosWVApC2LaD
 OvvC98GPIMlvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/ingenic: fix bridge allocation
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <5db9a2ad762f1515431fff714fc7d6d93363ccb2.1787491144.git.hns@goldelico.com>
References: <5db9a2ad762f1515431fff714fc7d6d93363ccb2.1787491144.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 13:28:40 +0000
Message-Id: <20260823132840.A11361F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Syntax error due to a malformed diff leaving an incomplete fun=
ction call.
- [High] Use-After-Free due to lifecycle mismatch between drmm-allocated en=
coder and devm-allocated bridge.

Pre-existing issues:
- [High] Missing IS_ERR check on devm_drm_panel_bridge_add_typed results in=
 potential ERR_PTR dereference.
--

--- Patch [1]: [PATCH v2] drm/ingenic: fix bridge allocation ---
commit b8ae6c3aa521f256f398e75faabccc79e7491a95
Author: H. Nikolaus Schaller <hns@goldelico.com>

drm/ingenic: fix bridge allocation

This commit modifies the Ingenic DRM driver to use the devm bridge allocati=
on
API to fix a registration warning.

> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
[ ... ]
> @@ -1316,10 +1316,26 @@ static int ingenic_drm_bind(struct device *dev, b=
ool has_components)
> =20
>  		drm_encoder_helper_add(encoder, &ingenic_drm_encoder_helper_funcs);
> =20
> -		ib->bridge.funcs =3D &ingenic_drm_bridge_funcs;
> +		ib->bridge =3D devm_drm_bridge_alloc(priv->dev, struct drm_bridge,
> +						   base, &ingenic_drm_bridge_funcs);

[Severity: High]
Does this code introduce a lifecycle mismatch?

The encoder wrapper `ib` is allocated via drmm (tied to the DRM device's
lifecycle) earlier in this function:

		ib =3D drmm_encoder_alloc(drm, struct ingenic_drm_bridge, encoder,
					NULL, DRM_MODE_ENCODER_DPI, NULL);

However, the bridge is allocated here via devm (tied to the platform device=
).
If the platform device is unbound while the DRM device is still held open by
userspace, the devm infrastructure will free the bridge while the drmm-mana=
ged
encoder continues to exist.

Could this lead to a use-after-free when the DRM device is later cleaned
up and iterates over the encoder's bridge chain containing the freed bridge
pointer?

> +		if (IS_ERR(ib->bridge)) {
> +			ret =3D PTR_ERR(ib->bridge);
> +			goto err_drvdata;
> +		}
> +
> +		ib->bridge->of_node =3D priv->dev->of_node;
>  		ib->next_bridge =3D bridge;

[Severity: High]
This is a pre-existing issue, but does `bridge` need an error check before
we assign it here?

Earlier in this function, `devm_drm_panel_bridge_add_typed()` is called:

		if (panel) {
			bridge =3D devm_drm_panel_bridge_add_typed(dev, panel,
								 DRM_MODE_CONNECTOR_DPI);
			drm_panel_put(panel);
		}

If `devm_drm_panel_bridge_add_typed()` fails, it returns an ERR_PTR. If this
unvalidated pointer is stored in `ib->next_bridge`, it will eventually be
passed to `drm_bridge_attach()`, which could attempt to dereference the
error pointer.

> =20
>  		ret =3D drm_bridge_attach(encoder, &ib->bridge, NULL,
> +		ib->bridge->interlace_allowed =3D true;

[Severity: Critical]
Does this result in a syntax error?

It looks like the `ret =3D drm_bridge_attach(...)` call from the original c=
ode
was partially left behind, leaving an unclosed function call and a trailing
comma. Will the compiler fail when trying to parse this?

> +
> +		ret =3D devm_drm_bridge_add(priv->dev, ib->bridge);
> +		if (ret) {
> +			dev_err(dev, "Failed to register DRM bridge: %d\n", ret);
> +			goto err_drvdata;
> +		}
> +
> +		ret =3D drm_bridge_attach(encoder, ib->bridge, NULL,
>  					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>  		if (ret) {
>  			dev_err(dev, "Unable to attach bridge\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/5db9a2ad762f1515431=
fff714fc7d6d93363ccb2.1787491144.git.hns@goldelico.com?part=3D1
