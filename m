Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD446606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Chd+LSn8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F70A1121B1;
	Thu, 19 Nov 2026 08:49:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C699810E4BF
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:49:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B07F34508D;
 Thu, 19 Nov 2026 08:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757E11F000C5;
 Thu, 19 Nov 2026 08:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795078152;
 bh=ZVYDTfP2tEbeLEocbJ2NUbCHLNtMiqORWHuoCWJcyTc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Chd+LSn8OMSXlAwn4EKr7NmKwibj/xajrhoO3wgq7f/r+JXXM74EdRpk8wXZPVY6f
 fzO++B1elq3ajDciMmG5v3YUwx7hGfk81v1+aDXEYuA5hdnrtHeqH8XBue9xUDxoox
 vB5LrMUMTmzxS8Qx6j/JU4XXPNZXlIaFkPmlSaNC/1BHPCe/vxESI2jqJ1IosLnd0G
 VyRdnpY4lCILJEn3L/Lasxt7BfGLlCRx/F3xTeRjQslJGaTN71OcDfA87WjNJ9Ktb3
 7oV7/8fF9m7PTsOyuF/bRGBOr9HO5fI9Dvj+CyJl+X1pKWm/92PZzf/N6ejhhzhBfC
 ciNjg0UwV772g==
Message-ID: <sashiko-outbox-222718@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 13/29] drm/msm/dp: add MST connector creation and
 topology callbacks
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119-msm-dp-mst-v9-13-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
 <20261119-msm-dp-mst-v9-13-ca61be4edfc3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:49:12 +0000
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
- [High] drm/msm/dp: best_encoder mutation in
  msm_dp_mst_atomic_best_encoder()
- [Medium] drm/msm/dp: bad return and unlocked PBN in
  msm_dp_mst_connector_mode_valid()
- [Medium] drm/msm/dp: ignored display_info parameter in
  msm_dp_display_mode_valid()
- [Low] drm/msm/dp: unchecked allocs and duplicate prop in
  msm_dp_mst_add_connector()
--

commit 855fdaf041ee0928ad6a8b842de18b32e1e85391
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: add MST connector creation and topology callbacks

This commit adds DRM connector callbacks and the add_connector topology
callback to dynamically create and manage DisplayPort MST connectors.

> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp=
/dp_mst_drm.c
> index 5d22aa34c521c..a2900ff3b0ab3 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
[ ... ]
> @@ -25,6 +35,237 @@ struct msm_dp_mst {
[ ... ]
> +static enum drm_mode_status msm_dp_mst_connector_mode_valid(struct drm_c=
onnector *connector,
> +							    const struct drm_display_mode *mode)
> +{
> +	struct msm_dp_mst_connector *mst_conn;
> +	struct drm_dp_mst_port *mst_port;
> +	struct msm_dp *dp_display;
> +	int required_pbn;
> +
> +	if (drm_connector_is_unregistered(connector))
> +		return 0;
> +
> +	mst_conn =3D to_dp_mst_connector(connector);
> +	mst_port =3D mst_conn->mst_port;
> +	dp_display =3D mst_conn->dp_mst->msm_dp;
> +
> +	/* Use minimum possible bpp (6bpc RGB, 8b10b) to avoid rejecting modes
> +	 * that would be feasible at the actual link bpp. mode_valid must not
> +	 * depend on negotiated parameters.
> +	 */
> +	required_pbn =3D drm_dp_calc_pbn_mode(mode->clock, (6 * 3) << 4);
> +
> +	if (required_pbn > mst_port->full_pbn) {
> +		drm_dbg_dp(dp_display->drm_dev, "mode:%s not supported.\n", mode->name=
);
> +		return MODE_CLOCK_HIGH;
> +	}

[Severity: Medium]
Should msm_dp_mst_connector_mode_valid() be a .mode_valid_ctx callback
that returns MODE_ERROR when the connector is unregistered and takes
mst->mst_mgr.base.lock around reading mst_port->full_pbn?

Because this is wired up to .mode_valid, returning 0 returns MODE_OK and
accepts every mode on an unregistered connector without running the PBN or
display checks.  In addition, mst_port->full_pbn is documented as
protected by drm_dp_mst_topology_mgr.base.lock, which is not held here
when connector->force skips detect_ctx in
drm_helper_probe_single_connector_modes().

> +
> +	return msm_dp_display_mode_valid(dp_display, &connector->display_info, =
mode);
> +}

[Severity: Medium]
Does passing &connector->display_info to msm_dp_display_mode_valid()
validate the mode against the MST sink's EDID as intended?

msm_dp_display_mode_valid() ignores its info parameter and reads the root
SST connector (dp->connector) instead:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_display_mode_valid() {
	...
	is_yuv_420 =3D drm_mode_is_420_only(&dp->connector->display_info, mode);
	...
	mode_bpp =3D dp->connector->display_info.bpc * num_components;
	...
}

Since msm_dp_mst_connector_get_modes() populates display_info on the
dynamic MST connector rather than dp->connector, YCbCr 4:2:0-only modes on
an MST sink are not recognized as 4:2:0 and are rejected with
MODE_CLOCK_HIGH or MODE_BAD, and mode_bpp is computed from the wrong
connector's bpc.

[ ... ]

> +static struct drm_encoder *
> +msm_dp_mst_atomic_best_encoder(struct drm_connector *connector, struct d=
rm_atomic_commit *state)
> +{
> +	struct msm_dp_mst_connector *mst_conn =3D to_dp_mst_connector(connector=
);
> +	struct msm_dp_mst *mst =3D mst_conn->dp_mst;
> +	struct drm_connector_state *conn_state;
> +	struct drm_connector *iter;
> +	struct drm_connector_list_iter conn_iter;
> +	u32 stream_mask =3D 0;
> +	u32 i;
> +
> +	conn_state =3D drm_atomic_get_new_connector_state(state, connector);
> +	if (!conn_state)
> +		return NULL;
> +
> +	if (conn_state->best_encoder)
> +		return conn_state->best_encoder;
> +
> +	drm_connector_list_iter_begin(connector->dev, &conn_iter);
> +	drm_for_each_connector_iter(iter, &conn_iter) {
> +		struct drm_connector_state *peer_state;
> +		int stream_id;
> +
> +		if (iter =3D=3D connector ||
> +		    iter->funcs !=3D &msm_dp_drm_mst_connector_funcs ||
> +		    to_dp_mst_connector(iter)->dp_mst !=3D mst)
> +			continue;
> +
> +		peer_state =3D drm_atomic_get_new_connector_state(state, iter) ?: iter=
->state;
> +		if (!peer_state || !peer_state->crtc || !peer_state->best_encoder)
> +			continue;
> +
> +		stream_id =3D msm_dp_mst_encoder_stream_id(mst, peer_state->best_encod=
er);
> +		if (stream_id >=3D 0 && stream_id < mst->max_streams)
> +			stream_mask |=3D BIT(stream_id);
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +
> +	for (i =3D 0; i < mst->max_streams; i++) {
> +		if (!(stream_mask & BIT(i))) {
> +			conn_state->best_encoder =3D mst->mst_encoders[i].enc;
> +			return mst->mst_encoders[i].enc;
> +		}
> +	}
> +
> +	return NULL;
> +}

[Severity: High]
Does assigning conn_state->best_encoder directly inside
msm_dp_mst_atomic_best_encoder() break encoder routing in
update_connector_routing()?

drm_atomic_helper_check_modeset() calls .atomic_best_encoder() first from
handle_conflicting_encoders() and then again from
update_connector_routing(), which checks whether the returned encoder
differs from new_connector_state->best_encoder:

drivers/gpu/drm/drm_atomic_helper.c:update_connector_routing() {
	...
	if (new_encoder =3D=3D new_connector_state->best_encoder) {
		set_best_encoder(state, new_connector_state, new_encoder);

		drm_dbg_atomic(connector->dev,
			       "[CONNECTOR:%d:%s] keeps [ENCODER:%d:%s], now on [CRTC:%d:%s]\n",
			       ...);

		return 0;
	}

	steal_encoder(state, new_encoder);
	...
}

Because handle_conflicting_encoders() already overwrote
conn_state->best_encoder, update_connector_routing() always takes the
early return and skips steal_encoder().  When one atomic commit disables
an MST connector and enables an earlier-indexed MST connector on the same
CRTC, the new connector picks the old connector's encoder without stealing
it, and when update_connector_routing() then processes the disabled
connector, set_best_encoder(state, new_connector_state, NULL) clears that
encoder's bit from crtc_state->encoder_mask, leaving the active CRTC with
no encoder in encoder_mask.

[ ... ]

> +static struct drm_connector *
> +msm_dp_mst_add_connector(struct drm_dp_mst_topology_mgr *mgr,
> +			 struct drm_dp_mst_port *port, const char *pathprop)
> +{
> +	struct msm_dp_mst *mst =3D container_of(mgr, struct msm_dp_mst, mst_mgr=
);
> +	struct drm_device *dev =3D mst->msm_dp->drm_dev;
> +	struct msm_dp_mst_connector *mst_conn;
> +	struct drm_connector *connector;
> +	int rc, i;
> +
> +	mst_conn =3D kzalloc_obj(*mst_conn);
> +	if (!mst_conn)
> +		return NULL;
> +
> +	connector =3D &mst_conn->connector;
> +	rc =3D drm_connector_dynamic_init(dev, connector,
> +					&msm_dp_drm_mst_connector_funcs,
> +					DRM_MODE_CONNECTOR_DisplayPort, NULL);
> +	if (rc)
> +		goto err_free;
> +
> +	mst_conn->dp_mst =3D mst;
> +
> +	drm_connector_helper_add(connector, &msm_dp_drm_mst_connector_helper_fu=
ncs);
> +	connector->funcs->reset(connector);
> +
> +	/* add all encoders as possible encoders */
> +	for (i =3D 0; i < mst->max_streams; i++) {
> +		rc =3D drm_connector_attach_encoder(connector, mst->mst_encoders[i].en=
c);
> +		if (rc) {
> +			drm_err(dev, "[MST] failed to attach encoder:%u to conn:%d rc:%d\n",
> +				mst->mst_encoders[i].enc->base.id,
> +				connector->base.id, rc);
> +			goto err_connector;
> +		}
> +	}
> +
> +	mst_conn->mst_port =3D port;
> +	drm_dp_mst_get_port_malloc(port);
> +
> +	drm_object_attach_property(&connector->base,
> +				   dev->mode_config.path_property, 0);
> +	drm_object_attach_property(&connector->base,
> +				   dev->mode_config.tile_property, 0);
> +	drm_connector_set_path_property(connector, pathprop);

[Severity: Low]
Does msm_dp_mst_add_connector() attach dev->mode_config.tile_property a
second time?

drm_connector_dynamic_init() -> drm_connector_init_only() already attaches
config->tile_property, so attaching it again adds a duplicate TILE
property entry to connector->base.properties.  Also,
connector->funcs->reset(connector) can leave connector->state NULL on
allocation failure (causing a NULL pointer dereference in atomic helpers
once registered), and the error return from
drm_connector_set_path_property() is not checked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-msm-dp-mst=
-v9-0-ca61be4edfc3@oss.qualcomm.com?part=3D13
