Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF1EC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 339D010E504;
	Tue,  7 Jul 2026 15:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JHVT7NHb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CED8010E504
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:29:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B96A9401BD
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAD21F000E9;
 Tue,  7 Jul 2026 15:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783438182;
 bh=7pn7D40w8l/O5dnZbpTuoxERZ0nx0R0r3mOKVvrowHk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JHVT7NHbkRpGZ1sM4wBoSEZp20HckBjnaCrLdHGWNcsQxdb89tsLybVWzmMHWq0iT
 vTnaZtW3JtFJdxBer/Cyb2HwogTb3+2NZZojwhMx6If+qBHJSBFy7TL+ap81FvNoW+
 KeDHlQTfhkB9XyfxO7EbdGuBdG3n1D24EUk2oQExyvqqTPK961bx3+g2biaFa/HI2y
 b5YqBEkApVCNeHwSm9atzWdLHghgoQCP/TvV4YcHbu9afzXSS//gPPvxpMhkh1eAPG
 RCACy5CUMVLpAXPomXrG1gbZMhQISHOkN000UglaDHPvbFfM/7gbIkdTPjkek+kB2w
 vz07bWCsWd2Fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/37] drm/adp: mipi: Add atomic bridge state handlers
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-1-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-1-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:29:42 +0000
Message-Id: <20260707152942.7DAD21F000E9@smtp.kernel.org>
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
- [High] Repeatedly binding and unbinding the DSI panel driver causes a `de=
vres` memory leak and leaves a stale, UAF-prone bridge in the global bridge=
 list.
--

--- Patch [1]: [PATCH v2 01/37] drm/adp: mipi: Add atomic bridge state hand=
lers ---
commit b7611e75cc83200ed90d21e397cf46cc1f10033a
Author: Maxime Ripard <mripard@kernel.org>

drm/adp: mipi: Add atomic bridge state handlers

The mipi bridge doesn't implement any enable or disable callbacks, but
is still missing the atomic state handlers. In order to remove the
legacy bridge callback support from the DRM bridge core, add them.

> diff --git a/drivers/gpu/drm/adp/adp-mipi.c b/drivers/gpu/drm/adp/adp-mip=
i.c
> index cba7d32150a98..232bb95394237 100644
> --- a/drivers/gpu/drm/adp/adp-mipi.c
> +++ b/drivers/gpu/drm/adp/adp-mipi.c
[ ... ]
> @@ -222,6 +223,9 @@ static int adp_dsi_bridge_attach(struct drm_bridge *b=
ridge,
>  }
> =20
>  static const struct drm_bridge_funcs adp_dsi_bridge_funcs =3D {
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
> +	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> +	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.attach	=3D adp_dsi_bridge_attach,
>  };
> =20

[Severity: High]
This is a pre-existing issue, but while reviewing these bridge changes, I
noticed a resource management issue in adp_dsi_host_detach() in the same
file.

When a user unbinds the DSI panel driver, adp_dsi_host_detach() executes:

drivers/gpu/drm/adp/adp-mipi.c:adp_dsi_host_detach() {
    ...
    component_del(host->dev, &adp_dsi_component_ops);
    drm_bridge_remove(&adp->bridge);
    return 0;
}

However, during panel probe, adp_dsi_host_attach() allocates a panel bridge
using devm_drm_of_get_bridge(), tying the allocation to the host device
(adp->dsi.dev) rather than the panel device:

drivers/gpu/drm/adp/adp-mipi.c:adp_dsi_host_attach() {
    ...
    next =3D devm_drm_of_get_bridge(adp->dsi.dev, adp->dsi.dev->of_node, 1,=
 0);
    ...
}

Because the devres action is tied to the host device, unbinding the panel
does not free the bridge allocation. The drm_panel_bridge remains in the
global bridge list but points to the freed drm_panel.

If the panel is repeatedly unbound and bound, does this cause a devres memo=
ry
leak of bridge allocations?

Furthermore, if the DRM driver probes the bridge list later, could it
encounter this stale bridge and dereference the freed panel, leading to a
use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D1
