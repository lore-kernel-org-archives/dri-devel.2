Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48596CA9EBD
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 13:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8874310E043;
	Sun, 11 Oct 2026 13:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HQZdxSPM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E8E610E043
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 13:27:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1078741807;
 Sun, 11 Oct 2026 13:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA27C1F0089B;
 Sun, 11 Oct 2026 13:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791725237;
 bh=HEhNpLIjZ9ARnxJ8WdrtF5qZnhnY69jOfhDN/9UcXRo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HQZdxSPMk3NQ65MSGQFPDNeWhV3pp2aXQLM1gfAon6oHHbtqScbkP4xjhLOOr2wN3
 8G/h/iNYQOWM/TgpPwoPz8kiHfdnoSxiP1JVSjw96yPPnOSlMzOsnkx8/CQarZN9ap
 L38XbeHEBvF7cjndN7fPhjnbv2hR7Dw3+xTt92/VSLaeMAurpzk2QEZ0xwXjqkrUy2
 Ls6DAxEutZcEKq9h7oerdq+C2HIItUFDkmAox/7qr/aSqAfo43Mj+SgI9NbY9LOKlU
 BF1RSgUYfMYzeINqBaUj0fOpTRbV58w7uIXj8IS1xg5nQ40k8cZTVYUzOWU/+BvYL2
 LVKhU9s+w/AYA==
Message-ID: <sashiko-outbox-167268@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] drm/bridge: connector: Support the colorspace
 property for HDMI
To: =?utf-8?b?SmFuIENsYXXDn2Vu?= <jan.claussen10@web.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261011132024.2833-1-jan.claussen10@web.de>
References: <20261011132024.2833-1-jan.claussen10@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 13:27:17 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm: NULL pointer dereference in drm_bridge_connector_atomic_check=
() on disabled connector
- [Low] drm: mixed declarations and code in drm_bridge_connector_atomic_che=
ck()
--

commit bf56f41939cb53804040ce55667f5edb2cca09b7
Author: Jan Clau=C3=9Fen <jan.claussen10@web.de>

drm/bridge: connector: Support the colorspace property for HDMI

This commit adds support for the colorspace property to HDMI bridge
connectors, allowing userspace to signal colorimetry like BT.2020.
It attaches the property during initialization and forces a modeset
when the colorspace changes.

> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> index 81f3e26f6fdf5..0639fe094b108 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -412,6 +412,20 @@ drm_bridge_connector_mode_valid(struct drm_connector=
 *connector,
>  static int drm_bridge_connector_atomic_check(struct drm_connector *conne=
ctor,
>  					     struct drm_atomic_commit *state)
>  {
> +	struct drm_connector_state *old_state =3D
> +		drm_atomic_get_old_connector_state(state, connector);
> +	struct drm_connector_state *new_state =3D
> +		drm_atomic_get_new_connector_state(state, connector);
> +	struct drm_crtc_state *crtc_state;
> +
> +	if (old_state->colorspace !=3D new_state->colorspace) {
> +		crtc_state =3D drm_atomic_get_crtc_state(state, new_state->crtc);

[Severity: High]
Can this cause a NULL pointer dereference if the connector is disabled?

Userspace can submit an atomic commit that modifies the colorspace property
on a disconnected or disabled connector. It might also concurrently disable
the connector while modifying the property. In these scenarios,
new_state->crtc will be NULL.

If new_state->crtc is NULL, drm_atomic_get_crtc_state() immediately passes
the pointer to drm_crtc_index(), which dereferences it:

drm_atomic_get_crtc_state(state, crtc) {
    int ret, index =3D drm_crtc_index(crtc);
    ...

Should the CRTC retrieval be guarded by an if (new_state->crtc) check to
prevent crashes during such commits?

> +		if (IS_ERR(crtc_state))
> +			return PTR_ERR(crtc_state);
> +
> +		crtc_state->mode_changed =3D true;
> +	}
> +
>  	struct drm_bridge_connector *bridge_connector =3D
>  		to_drm_bridge_connector(connector);

[Severity: Low]
This isn't a bug, but does this placement mix declarations and executable
code?

The newly inserted if block pushes the declaration of bridge_connector down,
placing it after executable code. While supported in newer C standards, this
violates the Linux kernel coding style and will trigger warnings from
checkpatch.pl.

Could this declaration be moved to the top of the block?

> =20
>  	if (bridge_connector->bridge_hdmi)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011132024.2833=
-1-jan.claussen10@web.de?part=3D1
