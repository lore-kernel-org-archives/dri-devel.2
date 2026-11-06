Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9E4606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTeUN4bp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49DAF10EA5B;
	Fri,  6 Nov 2026 13:50:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F1F9112DB9
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:50:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3877443CE9
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4321F0089F;
 Fri,  6 Nov 2026 13:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793973050;
 bh=qkAkSngZBQyQai2Zcxp61RQPJ/ihpHJguWgwQuvyd4g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MTeUN4bpl9FXvyODZQ2fma8yAnoIT4P5MXLL21zfcIEqokNksRSurKdqrc2JEzpJp
 BP07kxPVjO9UHv1xnVJHTtUeaBrfCve8ejAFu7OrdOD5NFZDzpkNtYlQBWh3hklm1u
 jVj8BVTxKAzq8VwEU4pofhIyh3C4KBM4B4dHNIjhhelblAFHrcxGECVLToKumgE+SP
 xW58ngbYRYdVPuEhz9dqRmvCUpkyuZhKxGIqThEOmwG3Nw7gxkao0HdWfZV7R25Gub
 JWYChkwATRKg6lWnoe14qTXv4YEtjLCQ5gbGUmQ2EyPl7T2kHBWDDItErlgc/jiYhq
 askqNNe3FOY6A==
Message-ID: <sashiko-outbox-201508@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 30/39] drm/bridge: display-connector: Implement
 readout support
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-state-readout-v8-30-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-30-cbe78624e1bc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:50:49 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/bridge: unreachable fallback in
  display_connector_readout_state()
--

commit d3498648d3d0edd4924c54f60279025ca800e6f7
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: display-connector: Implement readout support

This commit adds state readout support to the display-connector bridge by
implementing the atomic_sro_readout_state callback and wiring up
drm_atomic_helper_bridge_compare_state().

> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm=
/bridge/display-connector.c
> index eb3412ec30a07..781684da1da4c 100644
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c
[ ... ]
> @@ -213,6 +216,70 @@ static u32 *display_connector_get_input_bus_fmts(str=
uct drm_bridge *bridge,
[ ... ]
> +static int
> +display_connector_readout_state(struct drm_bridge *bridge,
> +				struct drm_atomic_sro_state *state,
> +				struct drm_bridge_state *bridge_state,
> +				struct drm_crtc_state *crtc_state,
> +				struct drm_connector_state *conn_state)
> +{
> +	struct drm_display_info *di =3D &conn_state->connector->display_info;
> +	struct drm_bridge *prev_bridge __free(drm_bridge_put) =3D
> +		drm_bridge_get_prev_bridge(bridge);
> +
> +	if (prev_bridge) {
> +		struct drm_private_state *prev_priv_state =3D
> +			drm_atomic_sro_get_private_obj_state(state,
> +							     &prev_bridge->base);
> +
> +		if (prev_priv_state) {
> +			struct drm_bridge_state *prev_bridge_state =3D
> +				drm_priv_to_bridge_state(prev_priv_state);
> +
> +			bridge_state->input_bus_cfg.format =3D
> +				prev_bridge_state->output_bus_cfg.format;
> +			bridge_state->input_bus_cfg.flags =3D
> +				prev_bridge_state->output_bus_cfg.flags;
> +			goto out_input;
> +		}
> +	}
> +
> +	/*
> +	 * The previous bridge might not have readout support, so we
> +	 * can't treat a missing state as an error.
> +	 */
> +	bridge_state->input_bus_cfg.format =3D MEDIA_BUS_FMT_FIXED;
> +	bridge_state->input_bus_cfg.flags =3D di->bus_flags;

[Severity: Medium]
Can this fallback ever be reached when prev_bridge is present but lacks
readout support?

When a bridge does not implement atomic_sro_readout_state,
drm_atomic_helper_sro_readout_bridge_state() still allocates a zeroed
pristine state and stores it in the SRO state container:

drivers/gpu/drm/drm_atomic_state_readout_helper.c:drm_atomic_helper_sro_rea=
dout_bridge_state() {
	if (!bridge_obj_funcs->atomic_sro_readout_state) {
		...
		bridge_obj_state =3D bridge_obj_funcs->atomic_create_state(bridge_obj);
		if (drm_WARN_ON(dev, IS_ERR(bridge_obj_state)))
			return PTR_ERR(bridge_obj_state);

		drm_atomic_sro_set_private_obj_state(state, bridge_obj,
						     bridge_obj_state);
		return 0;
	}
}

Because prev_priv_state is non-NULL, display_connector_readout_state()
copies the zeroed output_bus_cfg.format and output_bus_cfg.flags from that
pristine state instead of falling back to MEDIA_BUS_FMT_FIXED and
di->bus_flags, causing drm_atomic_helper_bridge_compare_state() to report
false input bus mismatches when drm.atomic_readout skips missing readout
implementations.  Checking prev_bridge->funcs->atomic_sro_readout_state
before using prev_priv_state would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-state-=
readout-v8-0-cbe78624e1bc@kernel.org?part=3D30
