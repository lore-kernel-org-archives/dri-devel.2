Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8572606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGIS4mGN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D34C11207F;
	Thu, 29 Oct 2026 08:05:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42D6711207C
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:04:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2903643AC7
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1E51F01825;
 Thu, 29 Oct 2026 08:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793261098;
 bh=MGkWk+3v3aJ3oEqW4VfhWXyJ1zx4hnypMhWrIxpKJo4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NGIS4mGNXwaTja7te7ZFeSr1PC1x5fwFFHGu72oOe9aQgwog6CbyB5z68LvgXeyut
 YulJ3Ja0K46sdLOWY7i1h4BWoYUGCWDeiSaYFr/ZG077ekO1eJSS63giyYo9vypBuj
 cl54UCfvv+E9AvduX6Nr7+2qtO7s19Bx+ub0fmr1uohtFJ/4+Po5dLYGGmv2N+7pBJ
 15RP2EYc9qBOU68hD3xXu7gLNxJJqRA4dQbdSu+z4+fnj7SUei4iE3+/NzYrGhKOp1
 m3ynkIW+CkoJXbl4F/p4pCphm6L5OykUfKMBp8a3XXvhqFqFVOBX0fX93IIyxzbgid
 1+7o/y6OdfBbA==
Message-ID: <sashiko-outbox-188941@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 28/34] drm/bridge_connector: Implement hw readout for
 connector
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-drm-state-readout-v7-28-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
 <20261029-drm-state-readout-v7-28-25e5163d75c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:04:57 +0000
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
- [High] drm/bridge_connector: unconditional SRO hooks with no-op readout w=
hen unsupported
--

commit b75d5f60d55bc26fbc8505149b2ac1fa7543a9a1
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge_connector: Implement hw readout for connector

This commit adds hardware state readout support to drm_bridge_connector by
introducing DRM_BRIDGE_OP_CONNECTOR_HW_READOUT and the
atomic_sro_connector_readout callback on drm_bridge_funcs.

> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> index 81f3e26f6fdf5..45806ef077081 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c

[ ... ]

> @@ -244,6 +253,26 @@ drm_bridge_connector_create_state(struct drm_connect=
or *connector)
>  	return conn_state;
>  }
> =20
> +static int
> +drm_bridge_connector_readout_state(struct drm_connector *connector,
> +				   struct drm_atomic_sro_state *state,
> +				   struct drm_connector_state *conn_state)
> +{
> +	struct drm_bridge_connector *bridge_connector =3D
> +		to_drm_bridge_connector(connector);
> +	struct drm_bridge *readout =3D
> +		bridge_connector->bridge_connector_hw_readout;
> +	int ret;
> +
> +	if (readout) {
> +		ret =3D readout->funcs->atomic_sro_connector_readout(readout, state, c=
onn_state);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static enum drm_connector_color_format
>  drm_bridge_connector_color_format(const struct drm_connector_state *conn=
_state)
>  {
> @@ -270,6 +299,8 @@ drm_bridge_connector_color_format(const struct drm_co=
nnector_state *conn_state)
>  static const struct drm_connector_funcs drm_bridge_connector_funcs =3D {
>  	.fill_modes =3D drm_helper_probe_single_connector_modes,
>  	.atomic_create_state =3D drm_bridge_connector_create_state,
> +	.atomic_sro_readout_state =3D drm_bridge_connector_readout_state,
> +	.atomic_sro_compare_state =3D drm_atomic_helper_connector_compare_state,

[Severity: High]
Does unconditionally setting .atomic_sro_readout_state and
.atomic_sro_compare_state on drm_bridge_connector_funcs while returning 0 in
drm_bridge_connector_readout_state() when bridge_connector_hw_readout is NU=
LL
cause a regression for bridge chains without DRM_BRIDGE_OP_CONNECTOR_HW_REA=
DOUT?

In drivers/gpu/drm/drm_atomic_state_readout.c, drm_atomic_sro_can_readout()
and drm_atomic_sro_can_compare() determine whether a connector supports sta=
te
readout by checking whether its callbacks are populated:

drivers/gpu/drm/drm_atomic_state_readout.c:drm_atomic_sro_can_readout() {
	...
	drm_connector_list_iter_begin(dev, &conn_iter);
	drm_for_each_connector_iter(connector, &conn_iter) {
		if (!connector->funcs->atomic_sro_readout_state) {
			drm_dbg_atomic(dev, "Connector %s missing readout callback",
				       connector->name);
			drm_connector_list_iter_end(&conn_iter);
			return false;
		}
	}
	drm_connector_list_iter_end(&conn_iter);
	...
}

Because drm_bridge_connector_funcs always defines both callbacks, every
drm_bridge_connector is treated as supporting hardware state readout even w=
hen
no bridge in the chain sets DRM_BRIDGE_OP_CONNECTOR_HW_READOUT (leaving
bridge_connector->bridge_connector_hw_readout NULL).

When state readout runs on a pipeline where bridge_connector_hw_readout is
NULL (for example, when bridges implement private state readout without any
bridge setting DRM_BRIDGE_OP_CONNECTOR_HW_READOUT, on a multi-connector dev=
ice
where only one bridge chain supports connector readout, or when
drm.atomic_readout is set to DRM_ATOMIC_READOUT_SKIP_MISSING_READOUT),
drm_bridge_connector_readout_state() silently returns 0 and leaves
conn_state->crtc and conn_state->best_encoder set to NULL.

During initial readout in drm_mode_config_create_initial_state() ->
drm_atomic_helper_sro_readout_state() -> drm_atomic_helper_sro_build_state(=
),
this causes drm_bridge_atomic_readout_priv_state() in
drivers/gpu/drm/drm_bridge.c to skip reading out all bridges on that encode=
r's
chain because find_connector_state_for_encoder() matches encoder against
conn_state->best_encoder:

drivers/gpu/drm/drm_bridge.c:drm_bridge_atomic_readout_priv_state() {
	...
	conn_state =3D find_connector_state_for_encoder(state, encoder);
	if (!conn_state)
		return 0;

	if (!conn_state->crtc)
		return 0;
	...
}

It also installs an inconsistent atomic state via
drm_atomic_sro_install_state() with an active CRTC (crtc_state->active =3D=
=3D true
and crtc_state->connector_mask =3D=3D 0) and a disconnected connector state
instead of failing readout and falling back to hw_reset(). Furthermore, dur=
ing
post-commit verification in commit_tail() ->
drm_atomic_sro_readout_and_compare(), every blocking commit enabling that
connector compares the committed active state against the unpopulated reado=
ut
state via drm_atomic_helper_connector_compare_state(),
drm_atomic_helper_crtc_compare_state(), and
drm_atomic_helper_bridge_compare_state(), triggering state mismatch errors.

Should drm_bridge_connector_init() only expose a drm_connector_funcs table
with .atomic_sro_readout_state and .atomic_sro_compare_state when
bridge_connector->bridge_connector_hw_readout is non-NULL (similar to how
drm_bridge_attach() selects between drm_bridge_priv_state_funcs and
drm_bridge_priv_state_funcs_with_sro)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-drm-state-=
readout-v7-0-25e5163d75c3@kernel.org?part=3D28
