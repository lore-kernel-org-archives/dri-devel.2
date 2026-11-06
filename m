Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CEC606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FgOniWGu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B75112DA8;
	Fri,  6 Nov 2026 13:46:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E508B112DA8
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:45:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B71EB4356B
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8861F00901;
 Fri,  6 Nov 2026 13:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793972754;
 bh=hNAxrwgdwaJXS1l+n2mdn3/1tbkOoWS69SCdaJz3yKQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FgOniWGuqVdOd4i/AwhlkaIfNQXvcq/hZy9ZuoYkZ3b+EwzoyeXgOLKMKmIfmWmOu
 qcL4tbClHP+klRuawPE2t/WDaLu8vIpfjaqL6e/pweawbqpFGlmfqxQ5AxP9hKKfB6
 LLVs1eGRFSU106ITRV2/MId4StF8QrnAT17pjcg/AUSv2ebRRNWtXrARQ/dBs5QYNr
 /Fflgi7VmPQzn0Wz+CwtLymUbxWgUdIxLan79fGIQiLmPNqGHHVsW3srn6wAWAzMo2
 IPAnrqfmuNvYumLSmua+b7jN2HJpfLGvp5hMpfxQbZqMqaF8EWShHmLCfiNAS6YfiS
 ruH2wosUKh/cw==
Message-ID: <sashiko-outbox-201494@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 38/39] drm/panel: Implement state readout support
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-state-readout-v8-38-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-38-cbe78624e1bc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:45:54 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/panel: active readout in panel_bridge_connector_readout()
  desyncs drm_panel
- [Medium] drm/panel: panel_bridge_connector_readout() returns -ENODEV
  on inactive CRTC
--

commit 64e424167a6978d4eae36faa89c4949c44fe1a60
Author: Maxime Ripard <mripard@kernel.org>

drm/panel: Implement state readout support

This commit implements atomic state readout callbacks for the panel bridge,
reconstructing the negotiated bus configuration and binding the connector
to the encoder's active CRTC when no earlier bridge provides connector
readout.

> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index 560ea57591bd7..bef0e6af73ba5 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c

[ ... ]

> @@ -226,6 +252,100 @@ static void panel_bridge_debugfs_init(struct drm_br=
idge *bridge,
>  		panel->funcs->debugfs_init(panel, root);
>  }
> =20

[ ... ]

> +/*
> + * A panel bridge has no way to read the panel state out of the
> + * hardware: assume the panel is enabled whenever its pipeline is.
> + */
> +static int
> +panel_bridge_connector_readout(struct drm_bridge *bridge,
> +			       struct drm_atomic_sro_state *state,
> +			       struct drm_connector_state *conn_state)
> +{
> +	struct drm_connector *connector =3D conn_state->connector;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_encoder *encoder;
> +	struct drm_crtc *crtc;
> +
> +	encoder =3D bridge->encoder;
> +	if (!encoder->funcs || !encoder->funcs->atomic_sro_get_current_crtc)
> +		return -ENODEV;
> +
> +	crtc =3D encoder->funcs->atomic_sro_get_current_crtc(encoder);
> +	if (!crtc)
> +		return -ENODEV;
> +
> +	crtc_state =3D drm_atomic_sro_get_crtc_state(state, crtc);
> +	if (!crtc_state)
> +		return -ENODEV;

[Severity: Medium]
Should panel_bridge_connector_readout() return 0 instead of -ENODEV when
crtc or crtc_state is NULL?

In include/drm/drm_encoder.h, atomic_sro_get_current_crtc() is documented
to return NULL when the encoder is disabled.  In addition, during a
commit-scoped readout in drm_atomic_sro_readout_and_compare() that touches
a disabled connector without including its CRTC in the commit,
drm_atomic_sro_get_crtc_state() returns NULL.  Returning -ENODEV in these
cases causes drm_atomic_helper_sro_build_state() to fail readout when the
pipeline is off.

> +
> +	/* The pipeline is off, there is nothing to read out. */
> +	if (!crtc_state->active)
> +		return 0;
> +
> +	crtc_state->encoder_mask |=3D drm_encoder_mask(encoder);
> +	crtc_state->connector_mask |=3D drm_connector_mask(connector);
> +
> +	/*
> +	 * drm_atomic_set_crtc_for_connector() takes a connector
> +	 * reference when setting the crtc pointer, which is later
> +	 * released by __drm_atomic_helper_connector_destroy_state().
> +	 * The readout bypasses that path, so take the reference
> +	 * explicitly.
> +	 */
> +	drm_connector_get(connector);
> +	conn_state->crtc =3D crtc;
> +	conn_state->best_encoder =3D encoder;
> +
> +	return 0;
> +}

[Severity: High]
When a pipeline is read out as active, does binding conn_state to the CRTC
without preparing or enabling the underlying struct drm_panel leave
panel->prepared and panel->enabled out of sync with the atomic state?

Nothing in the state installation path calls drm_panel_prepare() or
drm_panel_enable().  On a subsequent fastboot commit where
drm_atomic_crtc_needs_modeset() is false, panel_bridge_atomic_pre_enable()
and panel_bridge_atomic_enable() are skipped, so the panel's regulators,
clocks, backlight and followers are never enabled in the kernel.  When a
later commit disables the pipeline, panel_bridge_atomic_disable() and
panel_bridge_atomic_post_disable() call drm_panel_disable() and
drm_panel_unprepare(), which hit the !panel->enabled and !panel->prepared
guards, log a warning and skip hardware teardown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-state-=
readout-v8-0-cbe78624e1bc@kernel.org?part=3D38
