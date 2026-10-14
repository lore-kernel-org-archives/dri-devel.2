Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4A0CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1589310EA82;
	Wed, 14 Oct 2026 17:45:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E79410EA82
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:45:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EAA9E429F9
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30921F000C4;
 Wed, 14 Oct 2026 17:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999911;
 bh=c2rNAYCsLqEGbWWK+IGQxibrCer5KRAqjWk5GzTymiY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=THvmd5pwZ0HcjXZu75+q9a+qePKZVlQVrMUGtPbItmdCWtQj0y7tRiltdqZZQ6t5K
 pa2JGCfiIOqwT/Od6H08XpF0Qa2aAnzePbiW++5pqmwEzVxMY4sG0i239Ymf7cdwwR
 vfuiskLDGuCV5ay+quZy+2adqqGtF/SxYBoRuNaUV4Qq96qeDdOrFU+9ak3sEhKPKm
 0krnaV2X6Kt/tDVFCXUoqg7hLxUu1ogcBwXLmpbPqztKKMTqGkehoWETjbw86uUeSC
 pn2aDkOlkpUfQKNS587j2y/z3pEpcNO0aEd6usOk2x/ExvjHBigUFvzG9Ry2tJ8qVC
 6EiToBlTA5l+A==
Message-ID: <sashiko-outbox-171596@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/75] drm/panel: Add atomic_create_state support
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-1-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-1-586c9c026823@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 17:45:11 +0000
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
- [High] drm: missing drm_connector_cleanup() on atomic_create_state error =
path
--

commit 0b1142b139421992608178b6e00be629b73837b5
Author: Maxime Ripard <mripard@kernel.org>

drm/panel: Add atomic_create_state support

The panel bridge attach hook calls the connector's reset function to
initialize the connector state when the device is already registered.
Now that connectors are being migrated from the reset hook to
atomic_create_state, prefer it over reset and fall back to the reset
hook if atomic_create_state is not implemented.

> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index c00529bfb706b..c9f49e18890ad 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -104,8 +104,18 @@ static int panel_bridge_attach(struct drm_bridge *br=
idge,
>  	drm_connector_attach_encoder(connector, encoder);
> =20
>  	if (bridge->dev->registered) {
> -		if (connector->funcs->reset)
> +		if (connector->funcs->atomic_create_state) {
> +			struct drm_connector_state *conn_state;
> +
> +			conn_state =3D connector->funcs->atomic_create_state(connector);
> +			if (IS_ERR(conn_state))
> +				return PTR_ERR(conn_state);

[Severity: High]
Does this early return leak the initialized connector resources?

Earlier in panel_bridge_attach(), drm_connector_init() is called:

	ret =3D drm_connector_init(bridge->dev, connector,
				 &panel_bridge_connector_funcs,
				 panel->connector_type);

This successfully initializes the connector, allocates its IDA and name str=
ing,
and adds it to the DRM device's global connector_list.

When atomic_create_state() fails and we return PTR_ERR(conn_state) early,
drm_connector_cleanup() is bypassed. Because the bridge attach failed, the
caller (drm_bridge_attach()) aborts the setup and will not call the bridge's
detach hook where drm_connector_cleanup() is typically invoked.

As a result, the connector remains in dev->mode_config.connector_list while
its enclosing struct drm_panel memory is tied to the panel driver's lifecyc=
le.
If the panel driver unbinds and frees its memory, the DRM core might traver=
se
a freed list node during drm_mode_config_cleanup() or subsequent connector
iterations, potentially leading to a use-after-free crash. Additionally, the
IDA and name string allocated by drm_connector_init() are leaked.

> +
> +			connector->state =3D conn_state;
> +		} else if (connector->funcs->reset) {
>  			connector->funcs->reset(connector);
> +		}
> +
>  		drm_connector_register(connector);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-drm-no-mor=
e-connector-reset-v1-0-586c9c026823@kernel.org?part=3D1
