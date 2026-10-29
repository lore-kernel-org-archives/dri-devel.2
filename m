Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E1606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HnQAs2fr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 469AE112023;
	Thu, 29 Oct 2026 08:04:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF3DC112079
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:59:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 45F4E60210
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C771F01825;
 Thu, 29 Oct 2026 07:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793260795;
 bh=OMYPIzJloJlpV5wavl8T2GALxl8rbkqVdXbsCMCsl+0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HnQAs2frpj0SubS4LNOml9BcPiFPsUL2WA31FDT52k9XGZdlAOQwGFwoK3ambC2jg
 lMuqGBpuwQJiDVgEWpPJwSmIy5RHUgXgHFCSCkXFUCfbnIqIrcjbiK5r6eaePjMDA6
 wEW1R6x0wM9ZbDytc4ed5mm73wFAs8/UYDymmvIwDAugiw/D7j4xZtyXv60btsNpdN
 t20QBFCIRBt0urvrxRYcYXyguKOHgfZz3IfY8vnsk3+fNXkOqdCjtaMBmsk/gt4bLE
 ufAdxu05EyzqSWgluAomiQYJe5ssFP/3s+ZvHxOnSEhBZZHYf71ObIT/5qUfi4LX2N
 kTEbNxip3czAg==
Message-ID: <sashiko-outbox-188933@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/34] drm/bridge: Handle bridges with hardware state
 readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-drm-state-readout-v7-15-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
 <20261029-drm-state-readout-v7-15-25e5163d75c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 07:59:54 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/bridge: spurious WARN_ON in find_connector_state_for_encoder=
()
--

commit f1fba7a56f1912874e4674dececcad53e42b5232
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: Handle bridges with hardware state readout

This commit adds hardware state readout support for DRM bridges by introduc=
ing
drm_bridge_atomic_readout_priv_state() to look up the associated connector =
and
CRTC states and forward them to the bridge's atomic_sro_readout_state hook.=
 It
also introduces a separate drm_private_state_funcs vtable so
drm_atomic_sro_device_can_readout() can distinguish bridges with and without
SRO support.

> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index b2d77824e4bed..5977157d8e679 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
[ ... ]
> @@ -561,6 +562,73 @@ drm_bridge_atomic_create_priv_state(struct drm_priva=
te_obj *obj)
>  	return &state->base;
>  }
> =20
> +static struct drm_connector_state *
> +find_connector_state_for_encoder(struct drm_atomic_sro_state *state,
> +				struct drm_encoder *encoder)
> +{
> +	struct drm_connector_list_iter conn_iter;
> +	struct drm_connector *connector;
> +
> +	drm_connector_list_iter_begin(drm_atomic_sro_state_get_device(state),
> +				      &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		struct drm_connector_state *conn_state =3D
> +			drm_atomic_sro_get_connector_state(state, connector);
> +
> +		if (WARN_ON(!conn_state))
> +			continue;

[Severity: Medium]
Can this WARN_ON(!conn_state) trigger spuriously when state readout only
populates a subset of connectors?

When drm_atomic_sro_readout_and_compare() builds an SRO state for a blocking
commit via drm_atomic_helper_sro_build_state() with a non-NULL commit, only
the connectors included in that commit have their states populated in
state->connectors[]:

include/drm/drm_modeset_helper_vtables.h:
	 * When @commit is not NULL, only the objects that have a state in
	 * @commit are read out. The caller must hold the locks of the
	 * objects in @commit through its acquire context, and the readout
	 * hooks must not access the state of any object outside of the
	 * commit, since its locks aren't held.

Similarly, connectors without readout support are skipped when atomic_reado=
ut
is set to DRM_ATOMIC_READOUT_SKIP_MISSING_READOUT.

Because find_connector_state_for_encoder() iterates over all connectors on =
the
drm_device via drm_for_each_connector_iter(), any connector on a
multi-connector device that was not part of the commit (or when a commit
disables the encoder's connector routing) will have a NULL conn_state and
trigger WARN_ON(!conn_state). By contrast, drm_bridge_atomic_readout_priv_s=
tate()
checks if (!crtc_state) without warning.

Additionally, iterating the live device connector list passes every connect=
or
to drm_atomic_sro_get_connector_state():

drivers/gpu/drm/drm_atomic_state_readout.c:drm_atomic_sro_get_connector_sta=
te() {
	unsigned int index =3D drm_connector_index(connector);

	return state->connectors[index].state;
}

Could this also read past state->connectors[] if a dynamically registered
connector has an index greater than state->max_connector_index, or should
find_connector_state_for_encoder() iterate only over the connectors populat=
ed
in struct drm_atomic_sro_state (for example via for_each_connector_in_sro_s=
tate())
without WARN_ON(!conn_state)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-drm-state-=
readout-v7-0-25e5163d75c3@kernel.org?part=3D15
