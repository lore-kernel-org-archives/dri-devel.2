Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3762606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKA6LJlc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3858810E0E9;
	Sun, 25 Oct 2026 13:48:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99F8110E0E9
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 13:48:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CFB93600CB;
 Sun, 25 Oct 2026 13:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AEB1F01825;
 Sun, 25 Oct 2026 13:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792936102;
 bh=u4nBrtlRd8CyKGRhGlajHs/dIr69w/JMdhoO/IZ0tKI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bKA6LJlcha62NxQSUifaUbtYxWJPLbFuq4xQOsuyaKI+X920e/hokhXLqiY72d0p+
 jm5QI+KtTmGCWmYVuM4xKLgy2DPL94L3pqqAuZOP7j3mbTGPrhzYhxvmAROmtpKHrX
 BVXPGVYWOvAiO8mAUpJbFDTdba1bqf25ruydra0WJpz3w+VQDMHWFfJ+fYNSyJYuLZ
 HQUmjotySXbQRu2sfyig9NKgKsBn0+A43ZdHmpHY6bHhVM32XmjL1KFXxUeD+Qgtpv
 r8CSyKGoEQIAJKeNpfZ0bvJnghbCrqkkHfbG7ypPKDVAceEnhWPWGkOeH1h9AKUWa5
 EFO/kKifHo+xw==
Message-ID: <sashiko-outbox-184230@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] drm/bridge: ssd2825: Fix panel enable sequence
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261025133636.253505-1-clamor95@gmail.com>
References: <20261025133636.253505-1-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 13:48:21 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/bridge: ssd2825: duplicate atomic_enable() call on next_brid=
ge
--

commit 1c5e404afec7538a0e06a870cc1167b8db336814
Author: Svyatoslav Ryhel <clamor95@gmail.com>

drm/bridge: ssd2825: Fix panel enable sequence

This commit invokes the next bridge's atomic_enable() callback directly at
the end of ssd2825_bridge_atomic_pre_enable() to restore panel output after
commit 554d36acf5e0 removed direct panel handling.

> diff --git a/drivers/gpu/drm/bridge/ssd2825.c b/drivers/gpu/drm/bridge/ss=
d2825.c
> index 71877699dfab6..9216cee09115f 100644
> --- a/drivers/gpu/drm/bridge/ssd2825.c
> +++ b/drivers/gpu/drm/bridge/ssd2825.c
> @@ -475,6 +475,7 @@ static void ssd2825_bridge_atomic_pre_enable(struct d=
rm_bridge *bridge,
>  					     struct drm_atomic_commit *state)
>  {
>  	struct ssd2825_priv *priv =3D bridge_to_ssd2825(bridge);
> +	struct drm_bridge *next_bridge =3D priv->output.bridge;
>  	struct mipi_dsi_device *dsi_dev =3D priv->output.dev;
>  	const struct drm_crtc_state *crtc_state;
>  	const struct drm_display_mode *mode;
> @@ -569,6 +570,14 @@ static void ssd2825_bridge_atomic_pre_enable(struct =
drm_bridge *bridge,
>  	/* Initial DSI configuration register set */
>  	ssd2825_write_reg(priv, SSD2825_CONFIGURATION_REG, config);
>  	ssd2825_write_reg(priv, SSD2825_VC_CTRL_REG, 0);
> +
> +	/*
> +	 * The SSD2825 requires that the next bridge be enabled first;
> +	 * otherwise, the SSD2825 cannot complete its configuration and
> +	 * there will be no output.
> +	 */
> +	if (next_bridge->funcs && next_bridge->funcs->atomic_enable)
> +		next_bridge->funcs->atomic_enable(next_bridge, state);

[Severity: Medium]
Does calling next_bridge->funcs->atomic_enable() directly in
ssd2825_bridge_atomic_pre_enable() cause next_bridge->funcs->atomic_enable()
to be invoked twice on every modeset enable?

In drivers/gpu/drm/bridge/ssd2825.c, ssd2825_bridge_attach() attaches
priv->output.bridge to the encoder's bridge chain:

	return drm_bridge_attach(bridge->encoder, priv->output.bridge, bridge,
				 flags);

During an atomic modeset enable, drm_atomic_helper_commit_modeset_enables()
runs drm_atomic_bridge_chain_pre_enable(), which calls
ssd2825_bridge_atomic_pre_enable() and now invokes
next_bridge->funcs->atomic_enable() for the first time.

Immediately afterwards, drm_atomic_helper_commit_encoder_bridge_enable()
calls drm_atomic_bridge_chain_enable() in drivers/gpu/drm/drm_bridge.c:

	drm_for_each_bridge_in_chain_from(first_bridge, bridge)
		if (bridge->funcs->atomic_enable)
			bridge->funcs->atomic_enable(bridge, state);

This calls next_bridge->funcs->atomic_enable() a second time while
drm_atomic_bridge_chain_disable() only calls atomic_disable() once.

When next_bridge is a panel bridge, panel_bridge_atomic_enable() calls
drm_panel_enable() in drivers/gpu/drm/drm_panel.c, where the second call hi=
ts
the already-enabled check and emits a warning on every modeset:

	if (panel->enabled) {
		dev_warn(panel->dev, "Skipping enable of already enabled panel\n");
		return;
	}

When next_bridge is a non-panel drm_bridge, there is no enabled-state guard
in the DRM bridge core, so next_bridge->funcs->atomic_enable() runs twice
without a matching second disable.

Additionally, if next_bridge sets pre_enable_prev_first,
drm_atomic_bridge_chain_pre_enable() runs ssd2825_bridge_atomic_pre_enable()
before next_bridge->funcs->atomic_pre_enable(), which would cause
next_bridge->funcs->atomic_enable() to run before next_bridge has been
prepared in atomic_pre_enable().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025133636.2535=
05-1-clamor95@gmail.com?part=3D1
