Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C2B60A5BE5
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 05:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jqNYOJsU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1107410E193;
	Tue, 10 Nov 2026 05:33:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4782E10EDD1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:33:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D88C42A91;
 Tue, 10 Nov 2026 05:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C1B1F0093C;
 Tue, 10 Nov 2026 05:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794288818;
 bh=5puIhxeyfKahwLn5F70XSQ33xmwI3xxvB5cU/EMtpHQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jqNYOJsUmJpgJZuWv+FrGv4ynqo/mWgt3hl4eHmOMF9PxK7TzN77q2i73HPVc8RPG
 zgqNK9KLo1AHTBoU29orffDbxe2aEh6yWNCtZUgXeI4TN2pk8a8VRCPYqYCkMr3t+9
 HoIxIq7esmfHirAJCEw5AnT+Bg9WYIrJENJ6V0p5Qb9wlgeoNbACV1i1jOuCUcmuex
 kEMIyR2h76ah5kS6QgBoo/Ft38+OZiIuQAzBtHr6tBYbL5uHIwPWnUc6MlOGySoqRX
 HXo2+dvNOwYU9MaxQu+LzNWohD+NiueGQ8e1xHAPXb/WbRjyD1/randD4tavRQOVRb
 gmlT0u3PPaTYQ==
Message-ID: <sashiko-outbox-206306@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 18/29] drm/msm/dp: add atomic stream handling for MST
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-msm-dp-mst-v8-18-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-18-d040fb33db5f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:33:38 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] drm/msm/dp: link and runtime PM leak in
  msm_dp_mst_stream_post_disable()
- [High] drm/msm/dp: MST payload state corruption on
  msm_dp_mst_stream_enable() error
- [High] drm/msm/dp: broken DPMS payload tracking in
  msm_dp_mst_stream_atomic_check()
- [Medium] drm/msm/dp: SST panel and connector queried in
  dpu_encoder_mst_atomic_enable()
- [Medium] drm/msm/dp: zero pbn_div in msm_dp_mst_stream_atomic_check()
  causes div-by-zero
--

commit 826c29c40882a969d4c35d32504417d642b6f995
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: add atomic stream handling for MST

This commit adds atomic check, enable, and disable operations for DP MST
streams, reserving VC payload bandwidth and updating MST payloads across
stream state transitions.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/dr=
m/msm/disp/dpu1/dpu_encoder.c
> index 802cb62fc0102..edf30d7d3d169 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -2745,16 +2745,27 @@ static const struct drm_encoder_helper_funcs dpu_=
encoder_helper_funcs =3D {
>  static void dpu_encoder_mst_atomic_enable(struct drm_encoder *enc,
>  				      struct drm_atomic_commit *state)
>  {
> +	msm_dp_mst_stream_enable(enc, state);
>  	dpu_encoder_virt_atomic_enable(enc, state);
>  }

[Severity: Medium]
Does dpu_encoder_virt_atomic_enable() end up querying the SST panel and
connector instead of the active MST stream's panel and connector?

msm_dp_mst_stream_enable() configures the per-stream panel
(mst->mst_encoders[i].dp_panel) and binds it to the MST connector.
However, dpu_encoder_virt_atomic_enable() then calls
msm_dp_wide_bus_available() and msm_dp_needs_periph_flush(), which
inspect dp->panel and msm_dp_display->connector:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_needs_periph_flush() {
	return drm_mode_is_420_only(&msm_dp_display->connector->display_info, mode=
);
}

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_wide_bus_available() {
	...
	if (dp->panel->msm_dp_mode.out_fmt_is_yuv_420)
		return false;

	return dp->wide_bus_supported;
}

If a YUV420 mode is active on an MST stream (or was previously set on the
SST connector before switching to MST), the DPU encoder and DP controller
disagree on widebus enablement and peripheral flush requirements, breaking
display output.

[ ... ]

> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp=
/dp_mst_drm.c
> index ef5fb70863b81..eae82e857c849 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
[ ... ]
> +void msm_dp_mst_stream_enable(struct drm_encoder *encoder,
> +			       struct drm_atomic_commit *state)
> +{
> +	struct drm_connector *connector =3D
> +		drm_atomic_get_new_connector_for_encoder(state, encoder);
> +	struct msm_dp_mst_connector *mst_conn =3D to_dp_mst_connector(connector=
);
> +	struct msm_dp_mst *mst =3D mst_conn->dp_mst;
> +	struct msm_dp *dp_display =3D mst->msm_dp;
> +	struct msm_dp_panel *panel =3D msm_dp_mst_panel_from_encoder(mst, encod=
er);
> +	struct drm_dp_mst_port *port =3D mst_conn->mst_port;
> +	struct drm_dp_mst_topology_state *mst_state =3D
> +		drm_atomic_get_new_mst_topology_state(state, &mst->mst_mgr);
> +	struct drm_dp_mst_atomic_payload *payload =3D
> +		drm_atomic_get_mst_payload_state(mst_state, port);
> +	struct msm_dp_mst_slot_info slots[DP_STREAM_MAX] =3D {};
> +	int rc;
> +
> +	guard(mutex)(&mst->mst_lock);
> +
> +	drm_connector_get(connector);
> +	panel->connector =3D connector;
> +
> +	rc =3D msm_dp_display_set_mode_helper(dp_display, state, encoder, panel=
);
> +	if (rc) {
> +		drm_err(dp_display->drm_dev,
> +			"[MST] stream:%u set_mode failed rc=3D%d\n", panel->stream_id, rc);
> +		return;
> +	}
> +
> +	rc =3D msm_dp_display_prepare_link(dp_display);
> +	if (rc) {
> +		drm_err(dp_display->drm_dev,
> +			"[MST] stream:%u prepare_link failed rc=3D%d\n", panel->stream_id, rc=
);
> +		return;
> +	}
> +
> +	drm_dp_mst_update_slots(mst_state, DP_CAP_ANSI_8B10B);
> +
> +	rc =3D drm_dp_add_payload_part1(&mst->mst_mgr, mst_state, payload);
> +	if (rc)
> +		return;
> +
> +	msm_dp_mst_collect_slots(mst, mst_state, slots);
> +
> +	drm_dbg_kms(dp_display->drm_dev,
> +		    "[MST] stream:%u timeslots vc_start:%d slots:%d pbn:%d\n",
> +		    panel->stream_id, payload->vc_start_slot,
> +		    payload->time_slots, payload->pbn);
> +
> +	rc =3D msm_dp_display_enable_helper(dp_display, panel, slots);
> +	if (rc)
> +		return;
> +
> +	drm_dp_check_act_status(&mst->mst_mgr);
> +
> +	drm_dp_add_payload_part2(&mst->mst_mgr, payload);
> +}
> +
> +void msm_dp_mst_stream_disable(struct drm_encoder *encoder,
> +			       struct drm_atomic_commit *state)
> +{
> +	struct drm_connector *connector =3D drm_atomic_get_old_connector_for_en=
coder(state, encoder);
> +	struct msm_dp_mst_connector *mst_conn =3D to_dp_mst_connector(connector=
);
> +	struct msm_dp_mst *mst =3D mst_conn->dp_mst;
> +	struct msm_dp_panel *panel =3D msm_dp_mst_panel_from_encoder(mst, encod=
er);
> +	struct drm_dp_mst_topology_state *old_mst_state =3D
> +		drm_atomic_get_old_mst_topology_state(state, &mst->mst_mgr);
> +	struct drm_dp_mst_topology_state *new_mst_state =3D
> +		drm_atomic_get_new_mst_topology_state(state, &mst->mst_mgr);
> +	struct drm_dp_mst_atomic_payload *old_payload =3D
> +		drm_atomic_get_mst_payload_state(old_mst_state, mst_conn->mst_port);
> +	struct drm_dp_mst_atomic_payload *new_payload =3D
> +		drm_atomic_get_mst_payload_state(new_mst_state, mst_conn->mst_port);
> +	struct msm_dp_mst_slot_info slots[DP_STREAM_MAX] =3D {};
> +
> +	guard(mutex)(&mst->mst_lock);
> +
> +	drm_dp_remove_payload_part1(&mst->mst_mgr, new_mst_state, new_payload);
> +
> +	drm_dp_remove_payload_part2(&mst->mst_mgr, new_mst_state, old_payload, =
new_payload);

[Severity: High]
If msm_dp_mst_stream_enable() returns early when
msm_dp_display_set_mode_helper() or msm_dp_display_prepare_link() fails,
will msm_dp_mst_stream_disable() corrupt the MST topology payload state?

When enable returns before drm_dp_add_payload_part1(), payload->vc_start_sl=
ot
stays at -1 and mst_mgr.payload_count is not incremented.  When the stream
is later disabled, drm_dp_remove_payload_part2() sees
new_payload->vc_start_slot =3D=3D -1, subtracts old_payload->time_slots from
every active payload with vc_start_slot > -1, and underflows
mst_mgr.payload_count and mst_mgr.next_start_slot.

> +	msm_dp_mst_collect_slots(mst, new_mst_state, slots);
> +
> +	drm_dbg_kms(mst->msm_dp->drm_dev,
> +		    "[MST] stream:%u timeslots vc_start:%d slots:%d pbn:%d\n",
> +		    panel->stream_id, new_payload->vc_start_slot,
> +		    new_payload->time_slots, new_payload->pbn);
> +
> +	if (!msm_dp_display_is_plugged(mst->msm_dp))
> +		return;
> +
> +	msm_dp_display_disable_helper(mst->msm_dp, panel, slots);
> +
> +	drm_dp_check_act_status(&mst->mst_mgr);
> +}
> +
> +void msm_dp_mst_stream_post_disable(struct drm_encoder *encoder,
> +				    struct drm_atomic_commit *state)
> +{
> +	struct drm_connector *connector =3D drm_atomic_get_old_connector_for_en=
coder(state, encoder);
> +	struct msm_dp_mst_connector *mst_conn =3D to_dp_mst_connector(connector=
);
> +	struct msm_dp_mst *mst =3D mst_conn->dp_mst;
> +	struct msm_dp_panel *panel =3D msm_dp_mst_panel_from_encoder(mst, encod=
er);
> +
> +	guard(mutex)(&mst->mst_lock);
> +
> +	msm_dp_display_atomic_post_disable_helper(mst->msm_dp, panel);
> +
> +	if (!mst->msm_dp->mst_active)
> +		msm_dp_display_unprepare(mst->msm_dp);

[Severity: High]
Does gating msm_dp_display_unprepare() on !mst->msm_dp->mst_active leak the
link clocks, PHY power, and runtime PM reference when all MST streams are
disabled while the MST branch device remains connected?

mst_active stays true as long as the MST hub is plugged in, whereas
msm_dp_display_unprepare() already checks active_stream_mask before tearing
down the link:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_display_unprepare() {
	...
	if (msm_dp_display->active_stream_mask) {
		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
		return;
	}
	...
}

Skipping msm_dp_display_unprepare() when the last stream is disabled leaves
the mainlink clocks on, leaks the runtime PM reference from
msm_dp_display_prepare_link(), and leaves link_ready set to true so later
connections skip link training.  msm_dp_display_unprepare() should be called
unconditionally here (and on error in msm_dp_mst_stream_enable() after
msm_dp_display_prepare_link() succeeds).

> +
> +	panel->connector =3D NULL;
> +
> +	drm_connector_put(connector);
> +}
> +
> +int msm_dp_mst_stream_atomic_check(struct drm_encoder *enc,
> +				   struct drm_crtc_state *crtc_state,
> +				   struct drm_connector_state *conn_state)
> +{
> +	struct msm_dp_mst_connector *mst_conn =3D to_dp_mst_connector(conn_stat=
e->connector);
> +	struct msm_dp_mst *mst =3D mst_conn->dp_mst;
> +	struct drm_dp_mst_topology_state *mst_state;
> +	int bpp, pbn, slots;
> +
> +	if (!conn_state->crtc)
> +		return 0;
> +
> +	if (!drm_atomic_crtc_needs_modeset(crtc_state) || !crtc_state->active)
> +		return 0;

[Severity: High]
Does returning early when !crtc_state->active break DRM MST payload tracking
across DPMS transitions and inactive modesets?

msm_dp_mst_connector_atomic_check() calls drm_dp_atomic_release_time_slots(=
),
which tracks payloads by connector-to-CRTC attachment (conn_state->crtc)
rather than crtc_state->active.  If a CRTC is enabled with active =3D=3D fa=
lse,
msm_dp_mst_stream_atomic_check() skips drm_dp_atomic_find_time_slots(), so a
later commit that detaches the connector or changes the mode hits
WARN_ON(!payload) in drm_dp_atomic_release_time_slots() and fails with
-EINVAL.  Conversely, transitioning an active MST CRTC to DPMS OFF
(enable =3D=3D true, active =3D=3D false) and then disabling the CRTC leaks=
 the
port's malloc_kref reference because drm_dp_remove_payload_part2() runs when
new_payload->delete is still false and is not called again when the already
inactive CRTC is disabled.

> +
> +	bpp =3D (conn_state->connector->display_info.bpc * 3) ?: 24; /* fallbac=
k: assume 8bpc */
> +	pbn =3D drm_dp_calc_pbn_mode(crtc_state->mode.clock, bpp << 4);
> +
> +	mst_state =3D drm_atomic_get_mst_topology_state(crtc_state->state, &mst=
->mst_mgr);
> +	if (IS_ERR(mst_state))
> +		return PTR_ERR(mst_state);
> +
> +	if (!dfixed_trunc(mst_state->pbn_div)) {
> +		mst_state->pbn_div =3D
> +			drm_dp_get_vc_payload_bw(mst->link->link_caps.rate,
> +						 mst->link->link_caps.num_lanes);
> +	}
> +
> +	slots =3D drm_dp_atomic_find_time_slots(crtc_state->state, &mst->mst_mg=
r,
> +					      mst_conn->mst_port, pbn);

[Severity: Medium]
Can mst_state->pbn_div.full be zero here and cause a division-by-zero in
drm_dp_atomic_find_time_slots()?

msm_dp_panel_read_dpcd() zeroes mst->link->link_caps with memset() before
reading DPCD over AUX without synchronization against atomic_check:

drivers/gpu/drm/msm/dp/dp_panel.c:msm_dp_panel_read_dpcd() {
	...
	link_info =3D &link->link_caps;
	memset(link_info, 0, sizeof(*link_info));
	...
}

If an HPD event runs msm_dp_panel_read_dpcd() concurrently with
msm_dp_mst_stream_atomic_check() (or if the DPCD read fails and leaves
link_caps zeroed while an MST connector is still reachable),
drm_dp_get_vc_payload_bw() returns 0 and drm_dp_atomic_find_time_slots()
divides by topology_state->pbn_div.full =3D=3D 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-msm-dp-mst=
-v8-0-d040fb33db5f@oss.qualcomm.com?part=3D18
