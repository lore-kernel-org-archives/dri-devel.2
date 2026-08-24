Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53043C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 17:57:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA54410E11F;
	Mon, 24 Aug 2026 17:57:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FsVUsQPG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA52210E11F
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 17:57:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6DDC140B2E;
 Mon, 24 Aug 2026 17:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3304F1F000E9;
 Mon, 24 Aug 2026 17:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787594262;
 bh=VwoA+KvCu3UgTnr+DfgieLBXmvQdV2OjBuR1Fagr3mA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FsVUsQPGVz8RaBOTqMymVHKWMp6G1aMhu1+fuv7Pt7fe05AINhLDAXRwlTZUIDLdi
 4csOlZgj4VKYNPk+/OeU9oigsvGoEVrLIMSD16lnNpe7wJw8iBiinBsHJXZXZVX8fb
 UCiBkA1vNvn0FK50p4Jpzq4/iv9D2g9zgYygWtyN51IAvyw3UDSnjJqft8fADCoiu7
 WbYyvJVxA5K+0/cSE5p898wIHz9zL0JpyWgni+uyBzxeb6XkPGUrvtHbEHoW0/bas0
 xSgK38LB3/CQYsAwc+arlz6aiycVBLSFiS51o5Jh57Fxw1zMiDXZDoqJirmP+2Qy3p
 Lf2bDpN8gLbZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] drm/ingenic: fix bridge allocation
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <f77ed4e1547e452668a6549e3966471a6b638a6b.1787593585.git.hns@goldelico.com>
References: <f77ed4e1547e452668a6549e3966471a6b638a6b.1787593585.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 17:57:41 +0000
Message-Id: <20260824175742.3304F1F000E9@smtp.kernel.org>
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
- [High] Missing drm_bridge_remove() in error paths and driver unbind leads=
 to memory leaks and dangling pointers in the global bridge_list.
--

--- Patch [1]: [PATCH v5] drm/ingenic: fix bridge allocation ---
commit 25461fe1d8c0e90d5647e8b8309dd0a052459895
Author: H. Nikolaus Schaller <hns@goldelico.com>

drm/ingenic: fix bridge allocation

This commit fixes an issue with the bridge allocation API by replacing dire=
ct
struct drm_bridge allocation with devm_drm_bridge_alloc(). It also updates =
the
bridge lifecycle by calling drm_bridge_add() prior to drm_bridge_attach().

> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/=
ingenic/ingenic-drm-drv.c
> index 738a80b2550ff..47f02d655b3c6 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
[ ... ]
> @@ -1316,13 +1321,27 @@ static int ingenic_drm_bind(struct device *dev, b=
ool has_components)
> =20
>  		drm_encoder_helper_add(encoder, &ingenic_drm_encoder_helper_funcs);
> =20
> -		ib->bridge.funcs =3D &ingenic_drm_bridge_funcs;
> +		bridge_alloc =3D devm_drm_bridge_alloc(priv->dev,
> +						     struct ingenic_drm_bridge_alloc,
> +						     bridge,
> +						     &ingenic_drm_bridge_funcs);
> +		if (IS_ERR(bridge_alloc)) {
> +			ret =3D PTR_ERR(bridge_alloc);
> +			goto err_drvdata;
> +		}
> +
> +		ib->bridge =3D &bridge_alloc->bridge;
> +		ib->bridge->of_node =3D priv->dev->of_node;
> +
>  		ib->next_bridge =3D bridge;
> =20
> -		ret =3D drm_bridge_attach(encoder, &ib->bridge, NULL,
> +		drm_bridge_add(ib->bridge);
> +
> +		ret =3D drm_bridge_attach(encoder, ib->bridge, NULL,
>  					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>  		if (ret) {
>  			dev_err(dev, "Unable to attach bridge\n");
> +			drm_bridge_remove(ib->bridge);
>  			goto err_drvdata;
>  		}

[Severity: High]
Does this code leak the bridge and leave a dangling pointer if a subsequent
initialization step fails?

Right after this drm_bridge_attach() block, ingenic_drm_bind() calls
drm_bridge_connector_init(). If that initialization fails (or if any later
loop iteration fails), the code jumps to err_drvdata:

		connector =3D drm_bridge_connector_init(drm, encoder);
		if (IS_ERR(connector)) {
			dev_err(dev, "Unable to init connector\n");
			ret =3D PTR_ERR(connector);
			goto err_drvdata;
		}

Because drm_bridge_remove() is only called when drm_bridge_attach() fails,
the bridge added via drm_bridge_add() is never removed from the global
bridge_list on these later error paths.

Additionally, does the driver leave the bridge in the global list during de=
vice
unbind? Looking at ingenic_drm_unbind(), there appears to be no matching ca=
ll
to drm_bridge_remove() for the bridges registered in the bind loop. This co=
uld
lead to a use-after-free oops if the module is unloaded, leaving bridge->fu=
ncs
pointing to unmapped memory.

Could devm_drm_bridge_add() be used here instead to ensure the bridge is
automatically removed from the global list on error paths and during unbind?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f77ed4e1547e452668a=
6549e3966471a6b638a6b.1787593585.git.hns@goldelico.com?part=3D1
