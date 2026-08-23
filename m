Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7429C5DF81
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 14:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E528410E14B;
	Sun, 23 Aug 2026 14:24:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XhIQJXN7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B21510E14B
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 14:24:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EF12D438B8;
 Sun, 23 Aug 2026 14:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A501F000E9;
 Sun, 23 Aug 2026 14:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787495042;
 bh=SQZcbka2+fSdVKU0BhA9F/AkDD4WCyy5ingEDZB49FA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XhIQJXN7CCwEqYZ/Wh48OkJ1Y7H68SG0i92Moccit0IGt4IOgRKlF1R0IcbWZI7EF
 Fs3E8uMYNirnclfqos3d+qOBpv77sPbpRHwkkTxQG62iPFFruU/81+XF3/qHlEzYSO
 NrIrJot6rC8ZyycU5ZHKi/5asmDG4ArGD/MbDlWTiW1vlMk9WLDdaBSx6YsIVNDXvl
 nj1PwmgqrjYFLpuhZAeZWVANG5BCaxE6AdbuKX8b3UchsZ7BZ9FQO9O44XE/bSz+Jv
 LGuWeMz6x3ZTti2JiwkvYLezDJGINys0/N8Xuy6cB/jlyU+eJJvGc1gOsxGwWUAWdH
 pxaKvpFcqo3AQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/ingenic: fix bridge allocation
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <a3b64245250cd092776cf23cddffe18318b48995.1787494377.git.hns@goldelico.com>
References: <a3b64245250cd092776cf23cddffe18318b48995.1787494377.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 14:24:02 +0000
Message-Id: <20260823142402.A7A501F000E9@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but there is a missi=
ng IS_ERR() check on the return value of devm_drm_panel_bridge_add_typed() =
which leads to an error pointer dereference.
--

--- Patch [1]: [PATCH v3] drm/ingenic: fix bridge allocation ---
commit 4187db84355de6d4a1d09fa81233bcc5ab620c4b
Author: H. Nikolaus Schaller <hns@goldelico.com>
Subject: drm/ingenic: fix bridge allocation

This patch updates the ingenic/drm driver to use the new
devm_drm_bridge_alloc() API for bridge allocation. It fixes an issue where
the bridge was corrupted or not allocated properly under the new API,
causing use-after-free warnings.

> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/=
ingenic/ingenic-drm-drv.c
> index 738a80b2550ff..d1321a9c0f0b0 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
[ ... ]
> @@ -1316,10 +1316,25 @@ static int ingenic_drm_bind(struct device *dev, b=
ool has_components)
> =20
>  		drm_encoder_helper_add(encoder, &ingenic_drm_encoder_helper_funcs);
> =20
> -		ib->bridge.funcs =3D &ingenic_drm_bridge_funcs;
> +		ib->bridge =3D devm_drm_bridge_alloc(priv->dev, struct drm_bridge,
> +						   base, &ingenic_drm_bridge_funcs);
> +		if (IS_ERR(ib->bridge)) {
> +			ret =3D PTR_ERR(ib->bridge);
> +			goto err_drvdata;
> +		}
> +
> +		ib->bridge->of_node =3D priv->dev->of_node;
>  		ib->next_bridge =3D bridge;

[Severity: High]
This isn't a bug introduced by this patch, but if
devm_drm_panel_bridge_add_typed() fails earlier in ingenic_drm_bind(), it
returns an ERR_PTR.

Does this assignment store that unvalidated error pointer into
ib->next_bridge without an IS_ERR() check?

When the bridge attach callback executes:

static int ingenic_drm_bridge_attach(...)
{
    ...
    return drm_bridge_attach(encoder, ib->next_bridge,
                             bridge, flags);
}

Would this pass the ERR_PTR as the bridge argument to drm_bridge_attach(),
which bypasses the NULL check and dereferences it?

int drm_bridge_attach(..., struct drm_bridge *bridge, ...)
{
    if (!encoder || !bridge)
        return -EINVAL;

    if (!bridge->container)
        ...
}

Could this lead to a kernel panic from an invalid memory access?

> -		ret =3D drm_bridge_attach(encoder, &ib->bridge, NULL,
> +		ib->bridge->interlace_allowed =3D true;
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/a3b64245250cd092776=
cf23cddffe18318b48995.1787494377.git.hns@goldelico.com?part=3D1
