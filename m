Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47F606A321
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 05:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkxKBELu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5FE010EDC8;
	Tue, 10 Nov 2026 05:24:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D063710EDC8
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:24:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B2F6460AAB;
 Tue, 10 Nov 2026 05:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501BD1F0089F;
 Tue, 10 Nov 2026 05:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794288289;
 bh=wlXsOuIpJ95eBRDLZItspoHkUfqFrlSsBKj1xMf4yfg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bkxKBELu8tW3GTi0Eko/ZRMexsHDL9g68HO3IHYqQIxyW44GC+fJyvAssYHxWWA3k
 1oHSiqffKFHjQHdtkUg2PAA/RX7p6L5Zd9ntKEpJztyGoHjud+vPMwNP03k0U7xQV8
 W/2IAH8+tyJOnz9pE7ZFa1De8gMEO8HOhq7xGzTKP+AdwKtbwUbEwolNBj/+dSNaII
 hAD4R7RjHjzraETXqppBvSBE9yAtrlYNJPX5z8pfbkUccYFAYRl1THUjtp2rTK1ddu
 L9X+oG21pMqfDsj1jxy8Q1rH9hEJWmyql7OYko39HK6zi+mVtxDki9oHQZygU/AkfV
 lylsO8fp61lxQ==
Message-ID: <sashiko-outbox-206285@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/29] drm/msm/dp: add MST connector creation and
 topology callbacks
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-msm-dp-mst-v8-13-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-13-d040fb33db5f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:24:48 +0000
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

commit e6583a4899c42fcd8602aab1688349880400deb9
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: add MST connector creation and topology callbacks

This commit adds the add_connector topology callback and DRM connector
helper operations to create and manage dynamic connectors for DisplayPort
MST ports.

> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp=
/dp_mst_drm.c
> index 5d22aa34c521c..a2900ff3b0ab3 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c

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
Does returning 0 from a .mode_valid callback return MODE_OK instead of
MODE_ERROR when the connector is unregistered, accepting all modes without
checking PBN or display limits?

Also, mst_port->full_pbn is documented as protected by
drm_dp_mst_topology_mgr.base.lock, which is not held here (for example,
when connector->force is set in drm_helper_probe_single_connector_modes()
and detect_ctx is skipped).  Implementing .mode_valid_ctx instead of
.mode_valid would allow acquiring mst->mst_mgr.base.lock and setting
*status =3D MODE_ERROR when unregistered.

> +
> +	return msm_dp_display_mode_valid(dp_display, &connector->display_info, =
mode);
> +}

[Severity: Medium]
Does msm_dp_display_mode_valid() ignore the connector->display_info passed
here and use the root SST connector's display_info instead?

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_display_mode_valid() {
    ...
	is_yuv_420 =3D drm_mode_is_420_only(&dp->connector->display_info, mode);
    ...
	mode_bpp =3D dp->connector->display_info.bpc * num_components;
    ...
}

Because the MST sink's EDID updates the dynamic MST connector rather than
dp->connector, 4:2:0-only modes on MST sinks will not be recognized as
4:2:0 (skipping the vsc_sdp_supported check and failing to halve the pixel
clock, rejecting valid 4:2:0 modes) and mode_bpp will be computed from the
wrong connector's bpc.

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
Does assigning conn_state->best_encoder inside .atomic_best_encoder break
encoder stealing in update_connector_routing()?

drm_atomic_helper_check_modeset() calls .atomic_best_encoder() first in
handle_conflicting_encoders() and then again in update_connector_routing():

drivers/gpu/drm/drm_atomic_helper.c:update_connector_routing() {
    ...
	if (new_encoder =3D=3D new_connector_state->best_encoder) {
		set_best_encoder(state, new_connector_state, new_encoder);

		drm_dbg_atomic(connector->dev,
			       "[CONNECTOR:%d:%s] keeps [ENCODER:%d:%s], now on [CRTC:%d:%s]\n",
			       connector->base.id, connector->name,
			       new_encoder->base.id, new_encoder->name,
			       new_connector_state->crtc->base.id,
			       new_connector_state->crtc->name);

		return 0;
	}

	steal_encoder(state, new_encoder);
    ...
}

Because handle_conflicting_encoders() already overwrote
conn_state->best_encoder, new_encoder =3D=3D new_connector_state->best_enco=
der
is always true in update_connector_routing(), which returns early without
calling steal_encoder().  When one atomic commit disables an MST connector
with a higher connector index and enables another with a lower index on the
same CRTC, the disabled connector retains its stale best_encoder until its
own update_connector_routing() call runs set_best_encoder(..., NULL) and
clears the newly assigned encoder bit from crtc_state->encoder_mask.
Letting the atomic helpers own conn_state->best_encoder (and only returning
the chosen drm_encoder pointer from .atomic_best_encoder) avoids this.

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
second time?  drm_connector_dynamic_init() -> drm_connector_init_only()
already attaches tile_property, so attaching it again creates a duplicate
property entry on connector->base.properties.

In addition, connector->funcs->reset(connector) allocates connector->state
with kzalloc_obj(), so if that allocation fails, connector->state is NULL
when the connector is registered and later dereferenced by atomic helpers.
The error return from drm_connector_set_path_property() is also unchecked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-msm-dp-mst=
-v8-0-d040fb33db5f@oss.qualcomm.com?part=3D13
