Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8656ACD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAB8510F6BB;
	Mon,  8 Jun 2026 16:17:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cizt5d1B";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A03210F6B8
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:17:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B426B60098
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457211F00893;
 Mon,  8 Jun 2026 16:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780935471;
 bh=f74z5kEAoCqUWAxFAW/1z82VkQgVAAxgCpla7hvyEwc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cizt5d1Bz02/UNbUaMoRhawcBorAdS5lFgR9enwmk4MPe4OknOICtrUjV3VNrgcQf
 lbweJH63paEJ7yfKcNJ8EgpqHmPMZCwrRDulsW36AUouwX9j301VGqZBygoCA3+9LG
 mZzNIyS7Q33NrY1PrP4gaeA9FpJC0obrZV7kgcj8m4xFAf+8rQ4IWoEltNNKjk8M0B
 B6Vk86EH02YAefL5zDAiqScYZ4klZ6tXRXPK22MRKjCsclbVpulGf9xtL2AGqwHWg1
 pM56D1Ac897BV9UEv8berAy1uaa67lcrLnAHsgbGHGuOsnZj6JnOn2I8TsYksVJnv/
 55dvlzsxBnMjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 28/78] drm/bridge: panel: Switch to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-28-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-28-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:17:50 +0000
Message-Id: <20260608161751.457211F00893@smtp.kernel.org>
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
- [High] Calling drm_connector_cleanup() directly in panel_bridge_detach() =
zeroes the connector structure while userspace references may still exist, =
leading to a NULL pointer dereference.
--

commit 0c93dfe69dc6bce062c0a90960ed927307c7202d
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: panel: Switch to atomic_create_state

This commit updates the panel bridge driver to use the atomic_create_state
callback instead of the deprecated atomic_reset callback. It switches to
the corresponding drm_atomic_helper_bridge_create_state() helper.

> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/pane=
l.c
> index 4978ec98a0828..62af499f1f5cc 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c

[ ... ]

>  static void panel_bridge_detach(struct drm_bridge *bridge)
>  {
>  	struct panel_bridge *panel_bridge =3D drm_bridge_to_panel_bridge(bridge=
);
>  	struct drm_connector *connector =3D &panel_bridge->connector;
> =20
>  	if (connector->dev)
>  		drm_connector_cleanup(connector);

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a pre-existing iss=
ue
in panel_bridge_detach() here.

Calling drm_connector_cleanup() directly zeroes the connector structure whi=
le
userspace references may still exist.

If userspace or another kernel thread still holds an active reference to th=
is
connector (refcount > 0), dropping the final reference later will invoke
drm_connector_free().

Since drm_connector_cleanup() uses memset to zero the structure,
connector->funcs becomes NULL. When drm_connector_free() attempts to call
connector->funcs->destroy(connector), it will cause a fatal NULL pointer
dereference.

Can this connector cleanup be deferred until the final reference is dropped
rather than cleaning it up synchronously during detach?

[ ... ]

> @@ -213,7 +213,7 @@ static const struct drm_bridge_funcs panel_bridge_bri=
dge_funcs =3D {
>  	.atomic_disable =3D panel_bridge_atomic_disable,
>  	.atomic_post_disable =3D panel_bridge_atomic_post_disable,
>  	.get_modes =3D panel_bridge_get_modes,
> -	.atomic_reset =3D drm_atomic_helper_bridge_reset,
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
>  	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
>  	.atomic_get_input_bus_fmts =3D drm_atomic_helper_bridge_propagate_bus_f=
mt,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm-no-mor=
e-bridge-reset-v2-0-0a91018bf886@kernel.org?part=3D28
