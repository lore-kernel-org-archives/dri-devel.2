Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A6EC5DF8C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D20B410E449;
	Sun, 23 Aug 2026 09:45:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NrsaV3N1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2430810E449
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 09:45:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D4D0D43984;
 Sun, 23 Aug 2026 09:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E96C1F000E9;
 Sun, 23 Aug 2026 09:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787478323;
 bh=BKS2wkmlDyz77Q3KhZek1Cf6YTKD61EKqoQrPvcl9PE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NrsaV3N1mG4gDzytmXJs/f1zM/OT8mBqx7fzpnfIblFjg8n+opYaZWp2p/zvGag5w
 ulUsvUdYMlXQm5ryqmnfzmiTxhlH3R+DlLVYsUbt7r/5wkxIbu2t3GG38pdmDrKHpd
 wR/pBkvmyZRYq33ChaGX7Cq1up0ugb1Tn4sO/l6k8O+92gjfu6wOW9xVdPX/mitakJ
 BnVPdtLaVR0kqjW7zyuxC//ymzrIpOf/PqsPiphQh6d/SZvXdH+znPplALwBi6ZsYe
 ABnKHCLNhA7UBnQ5ZZCQZoovzf4vuAtlJsK3spPteKxVVxrFfEm3zW+CIO6xOrblOU
 4qIeN4dF6aV6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/ingenic: fix bridge allocation
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <400ba2fe0d4f76484e929d2efaa32f67a940163a.1787477392.git.hns@goldelico.com>
References: <400ba2fe0d4f76484e929d2efaa32f67a940163a.1787477392.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 09:45:23 +0000
Message-Id: <20260823094523.8E96C1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a lifecycle mismatch and memory leak by using=
 `devm_` allocations for a DRM bridge inside a component bind function, whi=
le attaching it to a `drmm_`-managed encoder.
- [High] Falsely claiming DRM_BRIDGE_OP_EDID and DRM_BRIDGE_OP_DETECT capab=
ilities on a bridge that lacks the corresponding callback implementations c=
auses a NULL pointer dereference.

Pre-existing issues:
- [High] Unhandled error pointer from devm_drm_panel_bridge_add_typed() lea=
ds to invalid memory dereference.
- [High] atomic_check phase corrupts global driver state by directly modify=
ing ib->bus_cfg.
--

--- Patch [1]: [PATCH] drm/ingenic: fix bridge allocation ---
commit caf3be8c5a53047a7d5ddaf2c5ee3db764a2f7fb
Author: H. Nikolaus Schaller <hns@goldelico.com>

drm/ingenic: fix bridge allocation

Bridge allocation API has changed and ingenic/drm was broken leading to
a warning. This patch replaces the embedded drm_bridge structure with a
pointer and uses devm_drm_bridge_alloc() to resolve the issue.

> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/=
ingenic/ingenic-drm-drv.c
> index 738a80b2550ff..91fe0ee7ae9ad 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -802,7 +802,7 @@ static int ingenic_drm_bridge_attach(struct drm_bridg=
e *bridge,
>  	struct ingenic_drm_bridge *ib =3D to_ingenic_drm_bridge(encoder);
> =20
>  	return drm_bridge_attach(encoder, ib->next_bridge,
> -				 &ib->bridge, flags);
> +				 bridge, flags);
>  }
> =20
>  static int ingenic_drm_bridge_atomic_check(struct drm_bridge *bridge,
>  					   struct drm_bridge_state *bridge_state,
>  					   struct drm_crtc_state *crtc_state,
>  					   struct drm_connector_state *conn_state)
>  {
>  	struct drm_display_mode *mode =3D &crtc_state->adjusted_mode;
>  	struct ingenic_drm_bridge *ib =3D to_ingenic_drm_bridge(bridge->encoder=
);
> =20
>  	ib->bus_cfg =3D bridge_state->output_bus_cfg;

[Severity: High]
This is a pre-existing issue, but does modifying ib->bus_cfg here break
the atomic contract?

Since DRM atomic_check can be called for TEST_ONLY commits that are meant
to be discarded, directly overwriting the global driver state here corrupts
the display configuration if a real commit later relies on this modified
state.

[ ... ]

> @@ -1316,10 +1316,26 @@ static int ingenic_drm_bind(struct device *dev, b=
ool has_components)
> =20
>  		drm_encoder_helper_add(encoder, &ingenic_drm_encoder_helper_funcs);
> =20

[Severity: High]
This is a pre-existing issue, but earlier in this same ingenic_drm_bind()
function, what happens if the panel bridge allocation fails?

		if (panel) {
			bridge =3D devm_drm_panel_bridge_add_typed(dev, panel,
								 DRM_MODE_CONNECTOR_DPI);
			drm_panel_put(panel);
		}

If devm_drm_panel_bridge_add_typed() fails, it returns an ERR_PTR(). This
unvalidated error pointer is saved into bridge, and eventually passed into
drm_bridge_attach() as ib->next_bridge, where it will be dereferenced and
panic the kernel. Should we check this with IS_ERR() here?

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
> =20
> -		ret =3D drm_bridge_attach(encoder, &ib->bridge, NULL,
> +		ib->bridge->ops =3D DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT;

[Severity: High]
Does this bridge actually implement these operations?

Setting DRM_BRIDGE_OP_EDID and DRM_BRIDGE_OP_DETECT advertises these
capabilities to the DRM core. However, the ingenic_drm_bridge_funcs
structure lacks the corresponding .detect, .edid_read, or .get_edid
callbacks.

When the core initializes the bridge connector and queries its state,
it will unconditionally call these missing functions, leading to a NULL
pointer dereference.

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

[Severity: High]
Can these devm_ allocations cause a use-after-free or a memory leak on
unbind?

Using devm_drm_bridge_alloc() and devm_drm_bridge_add() inside a component
bind function ties the bridge's lifecycle to device removal, not component
unbind. This means each bind/unbind cycle leaks memory and leaves stale
bridges in the global DRM list.

Additionally, the parent encoder is allocated via drmm_encoder_alloc(),
tying its lifecycle to the DRM device, which can outlive the platform
device if userspace holds an open file descriptor. When the platform
device is removed, devres frees the bridge early, creating a UAF hazard
when the DRM device later attempts to clean up its encoder bridge chains.

>  		if (ret) {
>  			dev_err(dev, "Unable to attach bridge\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/400ba2fe0d4f76484e9=
29d2efaa32f67a940163a.1787477392.git.hns@goldelico.com?part=3D1
