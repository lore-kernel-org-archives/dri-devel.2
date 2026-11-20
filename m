Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D0C606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObZY7a/O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C051B112A4F;
	Fri, 20 Nov 2026 13:18:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84F3A112A4B
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:18:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6EB6746B72
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C101F00A00;
 Fri, 20 Nov 2026 13:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795180691;
 bh=drJr6MP3Du51raYogO6YDqlOyGMjr6z6O3zsics7AN8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ObZY7a/OgbuVetr7Qso05kr4rbGNgZ9+c1+wCgjm5mA0lCYZ9phui4HYOCqK6hKOF
 WFspOkBj+rzOqeHLQS8ufMUXELbwSHFm96wxgQ01EWPKszF3TBE8xIelyO+PwPwFUT
 tO5RzIk6sK5VPsOiaqa9Ukj3YmbYxiaiGDFjDZ6ZWsPVFSE3T4ZmLrhUUMqZlahSVZ
 M0vBC881qY7iiuly40VHU+gJwqaJngBjOTa6bo7va2/U/Qdjt1nawwtk+P1z6ULuPg
 D6Fvq5xAHxNHL+vj3UTVh36f4TDrRXI8gH2/vRsS5ftACumO0mcu/KCwfDT9GFTenj
 Bjbc7kAlsK3VA==
Message-ID: <sashiko-outbox-225218@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 17/42] drm/bridge: Handle bridges with hardware state
 readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261120-drm-state-readout-v9-17-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
 <20261120-drm-state-readout-v9-17-a67c2b45b8ec@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:18:10 +0000
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
- [Medium] drm/bridge: check crtc_state->active in
  drm_bridge_atomic_readout_priv_state()
--

commit f5a0fcf4814d5306f865f770861315035338896e
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: Handle bridges with hardware state readout

This commit adds hardware state readout and installation wrappers for DRM
bridges, looking up the corresponding connector and CRTC states for the
bridge's pipeline before invoking the bridge hooks.

> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index b6cdbc172f689..868558a09f951 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c

[ ... ]

> +static int
> +drm_bridge_atomic_readout_priv_state(struct drm_private_obj *obj,
> +				     struct drm_atomic_sro_state *state,
> +				     struct drm_private_state *priv_state)
> +{
> +	struct drm_bridge *bridge =3D drm_priv_to_bridge(obj);
> +	struct drm_encoder *encoder =3D bridge->encoder;
> +	const struct drm_bridge_funcs *bridge_funcs =3D bridge->funcs;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_bridge_state *bridge_state;
> +	struct drm_connector_state *conn_state;
> +	int ret;
> +
> +	/*
> +	 * If the bridge's encoder has no routed connector or no
> +	 * active CRTC, the pipeline is disabled and there is nothing
> +	 * to read out. Keep the pristine default state created by
> +	 * &drm_mode_config_helper_funcs.atomic_sro_build_state.
> +	 */
> +	conn_state =3D find_connector_state_for_encoder(state, encoder);
> +	if (!conn_state)
> +		return 0;
> +
> +	if (!conn_state->crtc)
> +		return 0;
> +
> +	crtc_state =3D drm_atomic_sro_get_crtc_state(state, conn_state->crtc);
> +	if (!crtc_state)
> +		return 0;

[Severity: Medium]
Should this check !crtc_state->active as well, matching the comment above
and drm_bridge_atomic_install_priv_state() below?

drm_atomic_helper_sro_readout_crtcs_state() populates a non-NULL
crtc_state in the readout container even when the CRTC is inactive, so
checking only !crtc_state will still invoke atomic_sro_readout_state() on
a disabled pipeline if conn_state->crtc is set while crtc_state->active is
false.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-drm-state-=
readout-v9-0-a67c2b45b8ec@kernel.org?part=3D17
