Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D71C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED29810E50D;
	Tue,  7 Jul 2026 15:53:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MWy4qrfu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D9A010E50D
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:53:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DD49542A63
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961B41F000E9;
 Tue,  7 Jul 2026 15:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783439628;
 bh=QU2MCf4rhHrvc3h7KqC2oPsXgvOIKVbPhEJPkP+ncdM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MWy4qrfujo/3qL3JzbXYBUrCWNwzuOlWNYsU2bz3dzNb1PsLZNoRsabQOqalJS3hH
 R12HJ/YBTGEs/wjs8Uthtrspv7kFhKfwC+n3uTIpV7BI9iTgebEE1r3b26kQoXCCWw
 Hf4AXwVD9IdXc5iGA/vn+K9rpjrM/I2/4kFN+tgeOYr5Tt3SrY7Z2v98roYgJ0uEV8
 bUn11LSN07LT24XnYcVwlYepDgSJJmqotPzs7JDVOAD1K8O6/iCXVm1fuih6yFA7c1
 etoKHddUDPzI9vvhjqBaDt87BZEAseyD3NnQvryMix5wZwDwWBhs70HA/HmyUaJV7t
 igwpAjhlRSIgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 27/37] drm/mcde: dsi: Add atomic bridge state handlers
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-27-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-27-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:53:47 +0000
Message-Id: <20260707155348.961B41F000E9@smtp.kernel.org>
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
- [High] Missing `drm_bridge_remove()` in driver unbind leads to memory lea=
k and Use-After-Free via dangling global list pointer.
--

--- Patch [27]: [PATCH v2 27/37] drm/mcde: dsi: Add atomic bridge state han=
dlers ---
commit 6ab8c58e40b6724f223de55f6cba1eb9cd4b73eb
Author: Maxime Ripard <mripard@kernel.org>

    drm/mcde: dsi: Add atomic bridge state handlers

This commit adds atomic bridge state handlers (atomic_create_state,
atomic_destroy_state, atomic_duplicate_state) to the mcde_dsi bridge. This
helps facilitate the removal of legacy bridge callback support from the DRM
bridge core.

> diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_=
dsi.c
> index 47d45897ed069..5cf44ccb02cf9 100644
> --- a/drivers/gpu/drm/mcde/mcde_dsi.c
> +++ b/drivers/gpu/drm/mcde/mcde_dsi.c
> @@ -1063,6 +1063,9 @@ static int mcde_dsi_bridge_attach(struct drm_bridge=
 *bridge,
>  }
> =20
>  static const struct drm_bridge_funcs mcde_dsi_bridge_funcs =3D {
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
> +	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> +	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.attach =3D mcde_dsi_bridge_attach,
>  	.mode_set =3D mcde_dsi_bridge_mode_set,
>  };

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the bridge
operations I noticed a pre-existing issue with how the bridge is removed.

In mcde_dsi_bind(), the bridge is registered and added to the global bridge
list:

drivers/gpu/drm/mcde/mcde_dsi.c:mcde_dsi_bind() {
	...
	/* Create a bridge for this DSI channel */
	d->bridge.of_node =3D dev->of_node;
	drm_bridge_add(&d->bridge);
	...
}

However, in mcde_dsi_unbind(), there is no corresponding call to
drm_bridge_remove():

drivers/gpu/drm/mcde/mcde_dsi.c:mcde_dsi_unbind() {
	struct mcde_dsi *d =3D dev_get_drvdata(dev);

	if (d->panel)
		drm_panel_bridge_remove(d->bridge.next_bridge);
	regmap_update_bits(d->prcmu, PRCM_DSI_SW_RESET,
			   PRCM_DSI_SW_RESET_DSI0_SW_RESETN, 0);
}

Does this leave the bridge in the global bridge_list, leading to a memory
leak when unbinding the driver?

Furthermore, if another driver traverses the global DRM bridge list after t=
his
driver is unloaded, could it dereference the dangling pointers (like
bridge->dev and bridge->funcs) and cause a Use-After-Free kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D27
