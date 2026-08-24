Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21565C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73AB410E7B8;
	Mon, 24 Aug 2026 12:57:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Iaf7ruAF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EFF110E7AF
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 12:57:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 83DC56011F;
 Mon, 24 Aug 2026 12:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B591F000E9;
 Mon, 24 Aug 2026 12:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787576256;
 bh=NHQ46OovERJXJmm9oRmhLogzceA69Q87zIW5WeSPqGE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Iaf7ruAFw21SF4UKUjHRSUq9HPNvWUaKSMkpmgiCPO5PSsTk7WR7m6xGxDtqxa/eQ
 H2F0usTURXcdFqyk4ejwLoYxV9ix6Zh13eyAcpNyvFXsfmLuMVLcMpiXBwE/rDlhHe
 9iihTZUT8MT7i747Ls918OjZJVJs9xx8l9aoB3JhgAhKX8pBnIEoHjyV/Z+u9euFrV
 B+UA3NXaF/Izmo/kLHS//rvuLQxOx7XMbwj9YUsV/HmoYFfJGcqY5MistdwaPbtzrL
 aRShIl6ygDAmrAs+wv50NA/HLaw2Oh4DoROZZi0kM027pCEOISRpBbdpLxrFmSlMjK
 GpimxbA8Ous5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/ingenic: fix bridge allocation
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <1630a544a26fac0b87187885374ebe59fc92df3b.1787575203.git.hns@goldelico.com>
References: <1630a544a26fac0b87187885374ebe59fc92df3b.1787575203.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 12:57:35 +0000
Message-Id: <20260824125736.19B591F000E9@smtp.kernel.org>
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
- [High] devm_drm_bridge_add() is called inside a component bind function, =
causing bridge list pollution and memory leaks on bind failure or component=
 unbind.
- [Medium] Invalid usage of the `devm_drm_bridge_alloc` macro by passing `b=
ase` as the member argument.

Pre-existing issues:
- [High] Missing `IS_ERR` check after calling `devm_drm_panel_bridge_add_ty=
ped()`, leading to an `ERR_PTR` dereference in `drm_bridge_attach()`.
--

--- Patch [1]: [PATCH v4] drm/ingenic: fix bridge allocation ---
commit 822678818287fd2b46d33388216c8e393643533a
Author: H. Nikolaus Schaller <hns@goldelico.com>

drm/ingenic: fix bridge allocation

Bridge allocation API has changed and ingenic/drm was broken
leading to use-after-free errors.

> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/=
ingenic/ingenic-drm-drv.c
> index 738a80b2550ff..16fefdac8ce3d 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
[ ... ]
> @@ -1316,10 +1316,23 @@ static int ingenic_drm_bind(struct device *dev, b=
ool has_components)
> =20
>  		drm_encoder_helper_add(encoder, &ingenic_drm_encoder_helper_funcs);
> =20
> -		ib->bridge.funcs =3D &ingenic_drm_bridge_funcs;
> +		ib->bridge =3D devm_drm_bridge_alloc(priv->dev, struct drm_bridge,
> +						   base, &ingenic_drm_bridge_funcs);

[Severity: Medium]
Does passing base as the member argument safely allocate the bridge?

The devm_drm_bridge_alloc() macro is designed to allocate a driver-specific
container struct that embeds a struct drm_bridge, expecting member to be
the embedded bridge. It expands to:

__devm_drm_bridge_alloc(dev, sizeof(type), offsetof(type, member), funcs)

Passing struct drm_bridge as the type and base as the member relies on
base remaining at offset 0. If the struct layout changes and base moves,
the pointer offset calculation will write out of bounds since the internal
logic only allocates sizeof(struct drm_bridge) bytes.

Could this be updated to allocate a proper embedding container instead?

> +		if (IS_ERR(ib->bridge)) {
> +			ret =3D PTR_ERR(ib->bridge);
> +			goto err_drvdata;
> +		}
> +
> +		ib->bridge->of_node =3D priv->dev->of_node;
>  		ib->next_bridge =3D bridge;

[Severity: High]
This is a pre-existing issue, but does bridge need an IS_ERR check before
being assigned here?

Earlier in ingenic_drm_bind(), devm_drm_panel_bridge_add_typed() is called
which can return an error pointer if memory allocation fails:

    if (panel) {
        bridge =3D devm_drm_panel_bridge_add_typed(...)
        drm_panel_put(panel);
    }

If this allocation fails, bridge contains an error pointer that is blindly
assigned to ib->next_bridge. When ingenic_drm_bridge_attach() later passes
this to drm_bridge_attach(), it isn't protected by a NULL check and the err=
or
pointer will be dereferenced, potentially causing a panic.

> -		ret =3D drm_bridge_attach(encoder, &ib->bridge, NULL,
> +		ret =3D devm_drm_bridge_add(priv->dev, ib->bridge);

[Severity: High]
Is it safe to use devm_drm_bridge_add() inside a component bind function?

When tied to priv->dev (the master platform device), the devm cleanup
actions are only triggered when the master device is removed.

If ingenic_drm_bind() fails in a subsequent initialization step and defers,
or if the component is manually unbound via sysfs, the master device remains
bound.

This would leave the bridge memory allocated and the bridge itself in the
global DRM bridge_list. Upon retry or rebind, a new bridge will be
allocated and added, leaking memory and polluting the global list with
ghost entries.

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1630a544a26fac0b871=
87885374ebe59fc92df3b.1787575203.git.hns@goldelico.com?part=3D1
