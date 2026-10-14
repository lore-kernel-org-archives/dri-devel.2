Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37B2C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE8510E4B4;
	Wed, 14 Oct 2026 17:48:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7435C10E4B4
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:48:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B89A60098
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281EE1F000C4;
 Wed, 14 Oct 2026 17:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792000081;
 bh=1d2ZoObeTJkxgGU3VY0cfgrZWToJBxZEb5gJ4K2zW2Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iHM57gJn0rXEqN/kG3dzJcYgtgODBkimiV69e6i0TReUr9yCxxVa0DGPOwdVPX7ku
 wccRV+Zh7l/f1dVb4PoRzBn9N2bFK4p+CUGHPgG+Litl+S8a0tgwZyY9yPVTLA82sX
 NO2cERg0NFXuU7Yj1uiOHz2J9xmJQsL45pt1OjWdrl7cd4eB2PMF1KpWigZDDpx7IM
 QUlhriYYWIffeWWjrKEOwYNAHNRo9C0Q/1kBzlGj+/Fe1vJl8J5LdUjHGX4GEHMM9R
 SgzFOzLDbUuj+VmjVYYUSygmT86zfFhJ4oT1TcMxMKT0PS4UTuDgncimElsp0do1U1
 Gh63U/63wwSmA==
Message-ID: <sashiko-outbox-171603@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/75] drm/panel: Switch to
 drm_atomic_helper_connector_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-14-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-14-586c9c026823@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 17:48:00 +0000
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
- [High] drm: Missing drm_connector_cleanup() on atomic_create_state error =
path
--

commit 4c22451169f59e38b227f793ca15ca81195bb746
Author: Maxime Ripard <mripard@kernel.org>

drm/panel: Switch to drm_atomic_helper_connector_create_state

This commit replaces the deprecated reset hook with the=20
atomic_create_state callback in the panel bridge connector implementation.

> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index c9f49e18890ad..55a1427c7a10a 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -70,9 +70,9 @@ panel_bridge_connector_helper_funcs =3D {
>  };
> =20
>  static const struct drm_connector_funcs panel_bridge_connector_funcs =3D=
 {
> -	.reset =3D drm_atomic_helper_connector_reset,
>  	.fill_modes =3D drm_helper_probe_single_connector_modes,
>  	.destroy =3D drm_connector_cleanup,
> +	.atomic_create_state =3D drm_atomic_helper_connector_create_state,

[Severity: High]
Does this change introduce a resource leak and a use-after-free in the error
path of panel_bridge_attach()?

By providing the atomic_create_state callback, panel_bridge_attach() will
now take a different branch when creating the state:

drivers/gpu/drm/drm_panel.c:panel_bridge_attach() {
    ...
	ret =3D drm_connector_init(bridge->dev, connector,
				 &panel_bridge_connector_funcs,
				 panel->connector_type);
    ...
		if (connector->funcs->atomic_create_state) {
			struct drm_connector_state *conn_state;

			conn_state =3D connector->funcs->atomic_create_state(connector);
			if (IS_ERR(conn_state))
				return PTR_ERR(conn_state);
    ...
}

If drm_atomic_helper_connector_create_state() fails, the function returns
the error directly.

Since the connector was successfully initialized by drm_connector_init()
earlier in the function, returning without calling drm_connector_cleanup()
appears to leak the connector's resources.

Could this also lead to a use-after-free when the DRM core later iterates
over dev->mode_config.connector_list containing a dangling pointer to this
uncleaned connector?

>  	.atomic_duplicate_state =3D drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-drm-no-mor=
e-connector-reset-v1-0-586c9c026823@kernel.org?part=3D14
