Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF959606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qmfx4HqB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42A0B1129DE;
	Fri, 27 Nov 2026 10:23:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF4A1129E3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:23:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 398BD60CD7
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F761F000C1;
 Fri, 27 Nov 2026 10:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795775019;
 bh=PUz37hEv51Fhlp/rsxB9UrW82PTHtMArZaXUi7eTzTQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Qmfx4HqB/8S0U8yjwCpBWw6rLECiR8E8SC/85A1Ok699DyQMSR1lG04Y4nJnURUk9
 SuVAaQHpSgprVgGmIPZTerq9AGjNczux9k4R0zUN6XYqrL5BsVHu8JSX17LNDm7kRr
 Afju9Yy8NU5c3euNlPBpUbmtgdolMLAHo+8mmQ9MtUU8rYFVU8RoKmwAm4kwLVP0+Q
 1ng6tPoo+2kBe2jvguwrsUT2C0oe8McikKVh/wbV6K0jHpy/HW8ALb8fHnnIxhgoRH
 AsXdtILytBD/sie27g4WLQ3+THf1kZfo5ogxcClWy9qBdUInex7cTNIjXpidoqhgMk
 C4IIYCuNbFRew==
Message-ID: <sashiko-outbox-237117@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 22/36] drm/bridge: display-connector: Implement
 readout support
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127-drm-state-readout-v10-22-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
 <20261127-drm-state-readout-v10-22-0259582d45a8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:23:39 +0000
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
- [Medium] drm/bridge: wrong readout check in
  display_connector_readout_state()
--

commit 39d422e25df5bd318f93970d46127f68b613b515
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: display-connector: Implement readout support

This commit implements the atomic_sro_readout_state hook for the
display-connector bridge to reconstruct its bus configuration and wires up
drm_atomic_helper_bridge_compare_state() as its state comparison hook.

> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm=
/bridge/display-connector.c
> index eb3412ec30a07..be375f86e0388 100644
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c
[ ... ]
> @@ -213,6 +216,76 @@ static u32 *display_connector_get_input_bus_fmts(str=
uct drm_bridge *bridge,
>  							     num_input_fmts);
>  }
> =20
> +/*
> + * Reconstruct the bridge bus configuration from the previous bridge's
> + * readout state and the connector's display_info.
> + *
[ ... ]
> + */
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
> +	/*
> +	 * A previous bridge without readout support still gets a
> +	 * pristine state in the SRO state, which doesn't hold any
> +	 * meaningful bus configuration. Only use the state of bridges
> +	 * that were actually read out.
> +	 */
> +	if (prev_bridge && prev_bridge->base.funcs->atomic_sro_readout_state) {
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

[Severity: Medium]
Should this check prev_bridge->funcs->atomic_sro_readout_state instead of
prev_bridge->base.funcs->atomic_sro_readout_state?

When readout runs with DRM_ATOMIC_SRO_SKIP_MISSING_READOUT
(drm.atomic_readout=3D3), drm_bridge_attach() initializes prev_bridge->base
with drm_bridge_priv_state_funcs_with_sro even if the bridge driver has no
atomic_sro_readout_state callback:

drivers/gpu/drm/drm_bridge.c:drm_bridge_attach() {
    ...
	if (bridge->funcs &&
	    (bridge->funcs->atomic_sro_readout_state ||
	     (drm_atomic_sro_status >=3D DRM_ATOMIC_SRO_SKIP_MISSING_READOUT)) &&
	    (bridge->funcs->atomic_sro_compare_state ||
	     (drm_atomic_sro_status >=3D DRM_ATOMIC_SRO_SKIP_MISSING_COMPARE)))
		ret =3D drm_atomic_private_obj_init(bridge->dev, &bridge->base,
						  bridge->name,
						  &drm_bridge_priv_state_funcs_with_sro);
    ...
}

Because drm_bridge_priv_state_funcs_with_sro always sets
base.funcs->atomic_sro_readout_state to drm_bridge_atomic_readout_priv_stat=
e,
this condition evaluates to true for an unimplemented previous bridge and
copies zeroed format and flags from its pristine state instead of falling
back to MEDIA_BUS_FMT_FIXED and di->bus_flags, causing false state comparis=
on
mismatches in drm_atomic_helper_bridge_compare_state().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-drm-state-=
readout-v10-0-0259582d45a8@kernel.org?part=3D22
