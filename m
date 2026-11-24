Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDC5606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnbkXA77
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 788CF10F4D5;
	Tue, 24 Nov 2026 11:22:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A87610E84B;
 Tue, 24 Nov 2026 11:21:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 22F514193B;
 Tue, 24 Nov 2026 11:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0E91F000EE;
 Tue, 24 Nov 2026 11:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795519318;
 bh=ew3V/8XCiG9uNURuYpJ64riKHYPdMXjYK9KAO42vmh0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DnbkXA77/cfmaUkzWkCxa8w+wGq5ZHwF0pEBzl7OreCcGyC3DrHkSWCRyXD13JMkU
 oG5zAXt3PucWUF09+sIMHNQ4gxPTw80/K9mPFPDqj2EDysFWX9pqEzZMoWnw99C2ji
 uQOiSK/MUi2qOIkIS3TEGWs0k34qOc8EuVG7DDmOxSvrEo2FGcLAZRi8ZU0LZ5JwrA
 mw5ok6fPDgh18brpUkwgATdotG5XlvlX5foQaSsNpDSGzKipB7qUCEaRhqrDqg44cU
 BJ52p8Q9MrFvngusPWXuA+BEXSIaMGXgkb11LM0BcpQvL2UKIJeVUsidpJHpaZyMnh
 PT6QKSPvwSjQw==
Message-ID: <sashiko-outbox-231040@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] drm/i915: Implement connector atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261124-drm-i915-conversion-state-readout-v1-5-b7132f72644d@kernel.org>
References: <20261124-drm-i915-conversion-state-readout-v1-0-b7132f72644d@kernel.org>
 <20261124-drm-i915-conversion-state-readout-v1-5-b7132f72644d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 11:21:57 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/i915: uninitialized max_bpc in
  intel_digital_connector_create_state()
- [High] drm/i915: uninitialized scaling_mode in
  intel_digital_connector_create_state()
- [High] drm/i915: drm_mode_config_reset() wipes connector->state on PM
  resume
- [Medium] drm/i915: missing TV defaults in TV and SDVO
  atomic_create_state callbacks
--

commit 2bdba76f9c13d7e52d75cab97754e24fd12b8cea
Author: Maxime Ripard <mripard@kernel.org>

drm/i915: Implement connector atomic_create_state

This commit implements the .atomic_create_state hook for all i915
connectors to support DRM_MODE_ATOMIC_RESET.

> The other atomic_create_state() users don't apply to i915: it reads
> the state the firmware left behind out of the hardware at probe time,
> so it never goes through drm_mode_config_create_initial_state() nor
> the hardware state readout helpers. The atomic reset is thus the only
> user the hook enables here.

[Severity: High]
Does wiring up connector->funcs->atomic_create_state also cause
drm_mode_config_reset() to destroy and recreate connector->state on PM
resume?

drm_mode_config_reset() calls
drm_mode_config_connector_reset_with_create_state() whenever a connector
implements atomic_create_state:

drivers/gpu/drm/drm_mode_config.c:drm_mode_config_reset() {
    ...
	drm_connector_list_iter_begin(dev, &conn_iter);
	drm_for_each_connector_iter(connector, &conn_iter) {
		if (connector->funcs->atomic_create_state)
			drm_mode_config_connector_reset_with_create_state(connector);
	}
	drm_connector_list_iter_end(&conn_iter);
}

Both i915_drm_resume() and Xe's xe_display_pm_resume() and
xe_display_disable_d3cold() call drm_mode_config_reset().  On Xe runtime
PM exit from D3cold, xe_display_disable_d3cold() runs without saving or
restoring atomic state and without holding modeset locks, so every D3cold
wakeup replaces each connector->state with a fresh default state and
wipes out existing property values and routing.

[ ... ]

> diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gpu/dr=
m/i915/display/intel_atomic.c
> index b66c2d4ba2b3f..e752bbdda494c 100644
> --- a/drivers/gpu/drm/i915/display/intel_atomic.c
> +++ b/drivers/gpu/drm/i915/display/intel_atomic.c
> @@ -170,6 +170,29 @@ intel_digital_connector_duplicate_state(struct drm_c=
onnector *connector)
>  	return &state->base;
>  }
> =20
> +/**
> + * intel_digital_connector_create_state - allocate a pristine connector =
state
> + * @connector: digital connector
> + *
> + * Allocates and initializes a pristine &struct intel_digital_connector_=
state.
> + *
> + * Returns: The newly allocated connector state, or an error pointer on
> + * failure.
> + */
> +struct drm_connector_state *
> +intel_digital_connector_create_state(struct drm_connector *connector)
> +{
> +	struct intel_digital_connector_state *conn_state;
> +
> +	conn_state =3D kzalloc_obj(*conn_state);
> +	if (!conn_state)
> +		return ERR_PTR(-ENOMEM);
> +
> +	__drm_atomic_helper_connector_state_init(&conn_state->base, connector);
> +
> +	return &conn_state->base;
> +}

[Severity: High]
Does intel_digital_connector_create_state() leave
conn_state->base.max_requested_bpc and conn_state->base.max_bpc as 0 on
DP, DP MST and HDMI connectors?

At connector init, drm_connector_attach_max_bpc_property() attaches
connector->max_bpc_property and initializes max_requested_bpc and max_bpc
on the initial state, whereas __drm_atomic_helper_connector_state_init()
only sets conn_state->connector.  When DRM_MODE_ATOMIC_RESET creates a
fresh state without userspace explicitly supplying the "max bpc"
property, drm_atomic_connector_check() clamps state->max_bpc to
min(state->max_bpc, state->max_requested_bpc), which is 0.  During
modeset check, compute_sink_pipe_bpp() passes conn_state->max_bpc to
bpc_to_bpp(0), hitting MISSING_CASE(0) (a kernel WARN) and failing the
commit with -EINVAL.

[Severity: High]
Does intel_digital_connector_create_state() also leave
conn_state->base.scaling_mode at 0 (DRM_MODE_SCALE_NONE) on eDP, LVDS and
DSI panel connectors?

intel_attach_scaling_mode_property() attaches
connector->scaling_mode_property without DRM_MODE_SCALE_NONE in the
supported mask and sets the default connector->state->scaling_mode to
DRM_MODE_SCALE_ASPECT.  When DRM_MODE_ATOMIC_RESET allocates a zeroed
state, scaling_mode becomes DRM_MODE_SCALE_NONE, which forces
crtc_state->mode_changed in intel_digital_connector_atomic_check().  On a
non-native panel mode, gmch_panel_fitting() hits
MISSING_CASE(conn_state->scaling_mode) and fails with -EINVAL, while
pch_panel_fitting() triggers two WARN_ON() splats and falls through to
DRM_MODE_SCALE_FULLSCREEN instead of preserving the aspect ratio.

[ ... ]

> diff --git a/drivers/gpu/drm/i915/display/intel_sdvo.c b/drivers/gpu/drm/=
i915/display/intel_sdvo.c
> index 7b97f531acbfb..e276f00f74c58 100644
> --- a/drivers/gpu/drm/i915/display/intel_sdvo.c
> +++ b/drivers/gpu/drm/i915/display/intel_sdvo.c
> @@ -2505,6 +2505,20 @@ intel_sdvo_connector_duplicate_state(struct drm_co=
nnector *connector)
>  	return &state->base.base;
>  }
> =20
> +static struct drm_connector_state *
> +intel_sdvo_connector_create_state(struct drm_connector *connector)
> +{
> +	struct intel_sdvo_connector_state *state;
> +
> +	state =3D kzalloc_obj(*state);
> +	if (!state)
> +		return ERR_PTR(-ENOMEM);
> +
> +	__drm_atomic_helper_connector_state_init(&state->base.base, connector);
> +
> +	return &state->base.base;
> +}

[ ... ]

> diff --git a/drivers/gpu/drm/i915/display/intel_tv.c b/drivers/gpu/drm/i9=
15/display/intel_tv.c
> index 840e1dcdc2d0f..d40a8d2c41858 100644
> --- a/drivers/gpu/drm/i915/display/intel_tv.c
> +++ b/drivers/gpu/drm/i915/display/intel_tv.c
> @@ -902,6 +902,20 @@ intel_tv_connector_duplicate_state(struct drm_connec=
tor *connector)
>  	return &state->base;
>  }
> =20
> +static struct drm_connector_state *
> +intel_tv_connector_create_state(struct drm_connector *connector)
> +{
> +	struct intel_tv_connector_state *state;
> +
> +	state =3D kzalloc_obj(*state);
> +	if (!state)
> +		return ERR_PTR(-ENOMEM);
> +
> +	__drm_atomic_helper_connector_state_init(&state->base, connector);
> +
> +	return &state->base;
> +}

[Severity: Medium]
Do intel_sdvo_connector_create_state() and
intel_tv_connector_create_state() drop the connector default TV format,
enhancement and margin values populated during connector initialization?

On SDVO TV/LVDS connectors, intel_sdvo_tv_create_property() initializes
connector->state->tv.legacy_mode to
intel_sdvo_connector->tv_format_supported[0], and
intel_sdvo_create_enhance_property_tv() and
intel_sdvo_create_enhance_property_lvds() populate the default enhancement
values queried from hardware.  Leaving state->base.base.tv.legacy_mode as
0 in intel_sdvo_connector_create_state() triggers
drm_WARN_ON(connector->dev, 1) in
intel_sdvo_connector_atomic_get_property() whenever format 0 is not in
tv_format_supported[], and zeroes all hardware enhancement defaults.
Similarly, intel_tv_connector_create_state() leaves
state->base.tv.margins zeroed instead of restoring the BIOS default
margins (54, 36, 46, 37) configured in intel_tv_add_properties().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-drm-i915-c=
onversion-state-readout-v1-0-b7132f72644d@kernel.org?part=3D5
