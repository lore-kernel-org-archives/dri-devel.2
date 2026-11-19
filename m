Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70394606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebugXVXa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D25C61121BE;
	Thu, 19 Nov 2026 09:01:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 642221121BE
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:01:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1FE3047A37;
 Thu, 19 Nov 2026 09:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA35C1F000C4;
 Thu, 19 Nov 2026 09:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795078876;
 bh=wnWD7y+aIxjNRa5LAP2+NhnLk9HlQ8VRVZFqcUmxiDw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ebugXVXadwdBavfywFsydx6f6q5izhCP2LUPXaT9ONVFJI+GwpSpArbTFdObAEoOI
 7zfviwMIEaWVzH3iajaibqC9IYX+umGtJ3EWkb8FtHrrp9Z0jkHJiKdgIJgGVbI38l
 Gxrrij0Dli9RmO39T1e13nFGpv2xc2GZHI71ZUXARbJNc8Mia6I1BC1flulp3q+8jo
 SVZvuiRK4rQpkAQOQQRAqe5A2t1va3rQ8jEe3z8QfmKy5MMFWz9K+qaoP1HZSbHvRc
 1b+v022CN1Dbs6BxAsHutF1ghmkYxsfU2ok9KrWerkdWm4Ma5TruCZBLlZePMeWaO8
 pWiyiZZmPKSRw==
Message-ID: <sashiko-outbox-222773@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 18/29] drm/msm/dp: add atomic stream handling for MST
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119-msm-dp-mst-v9-18-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
 <20261119-msm-dp-mst-v9-18-ca61be4edfc3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:01:15 +0000
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
- [High] drm/msm/dp: broken DPMS payload tracking in
  msm_dp_mst_stream_atomic_check()
- [High] drm/msm/dp: MST payload state corruption on
  msm_dp_mst_stream_enable() error
- [High] drm/msm/dp: link and runtime PM leak in
  msm_dp_mst_stream_post_disable()
- [Medium] drm/msm/dp: zero pbn_div in msm_dp_mst_stream_atomic_check()
  causes div-by-zero
- [Medium] drm/msm/dp: SST panel and connector queried in
  dpu_encoder_mst_atomic_enable()
--

commit 3b57ce88885b473a2748e491b3e969f409d8d170
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: add atomic stream handling for MST

This commit adds atomic check, enable, and disable helpers for DisplayPort
MST streams, reserving VC payload bandwidth and updating MST payloads.

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
Does dpu_encoder_virt_atomic_enable() query the SST panel and connector
instead of the MST stream's panel and connector when configuring widebus
and peripheral flush?

msm_dp_mst_stream_enable() binds the per-stream MST panel to the MST
connector and configures dp->ctrl->wide_bus_en from that panel.
dpu_encoder_virt_atomic_enable() then calls msm_dp_wide_bus_available() and
msm_dp_needs_periph_flush(), which inspect the SST dp->panel and
msm_dp_display->connector:

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

When a YUV420 mode is enabled on an MST connector (or if the SST panel
retained out_fmt_is_yuv_420 from an earlier SST session), the DPU INTF and
DP controller end up with mismatched widebus settings, and YUV420 MST
streams halve horizontal timings twice while skipping peripheral flush.

> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp=
/dp_mst_drm.c
> index ef5fb70863b81..eae82e857c849 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
[ ... ]
> @@ -147,6 +186,158 @@ static int msm_dp_mst_encoder_stream_id(struct msm_=
dp_mst *mst,
>  	return -1;
>  }
> =20
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
Can an early return in msm_dp_mst_stream_enable() before
drm_dp_add_payload_part1() corrupt the MST payload state on the subsequent
disable?

If msm_dp_display_set_mode_helper() or msm_dp_display_prepare_link() fails
(for example, on a link training failure), drm_dp_add_payload_part1() is
skipped, so payload->vc_start_slot stays -1 and mst_mgr.payload_count is
not incremented.  When the stream is later disabled,
msm_dp_mst_stream_disable() still calls drm_dp_remove_payload_part2(),
which sees new_payload->vc_start_slot =3D=3D -1, subtracts
old_payload->time_slots from the vc_start_slot of every active payload with
vc_start_slot >=3D 1, and underflows mst_mgr.payload_count and
mst_mgr.next_start_slot.

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
link state and runtime PM reference when the last MST stream is disabled?

mst_active stays true while an MST branch device is connected, and
msm_dp_display_unprepare() already returns early when
active_stream_mask !=3D 0.  Skipping msm_dp_display_unprepare() when
mst_active is true leaves mainlink clocks and the PHY enabled, leaks the
runtime PM reference from msm_dp_display_prepare_link(), and leaves
link_ready set to true so later connections skip link training.

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
Does skipping time slot allocation when !crtc_state->active break MST
payload tracking across inactive modesets and DPMS transitions?

drm_dp_atomic_release_time_slots() in msm_dp_mst_connector_atomic_check()
tracks payloads by conn_state->crtc (crtc_state->enable), not
crtc_state->active.  If a CRTC is enabled with active =3D false, no payload
is allocated here, so a later disable or mode change hits WARN_ON(!payload)
in drm_dp_atomic_release_time_slots() and fails with -EINVAL.  Conversely,
if an active MST stream goes to DPMS OFF (enable =3D true, active =3D false)
and is later disabled (enable =3D false), drm_dp_remove_payload_part2() runs
during the DPMS OFF commit while new_payload->delete is still false and
does not run on the final disable when old_crtc_state->active is already
false, leaking the port's malloc_kref reference.

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
Can mst_state->pbn_div.full be zero here and cause a division by zero in
drm_dp_atomic_find_time_slots()?

msm_dp_panel_read_dpcd() zeroes mst->link->link_caps with memset() before
reading DPCD over AUX, and mst->link->link_caps is read here without locks
or a check that pbn_div.full > 0.  If an atomic check runs concurrently
with an HPD replug or after a failed DPCD read while the MST connector is
still registered, drm_dp_get_vc_payload_bw() returns 0 and
drm_dp_atomic_find_time_slots() divides by topology_state->pbn_div.full.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-msm-dp-mst=
-v9-0-ca61be4edfc3@oss.qualcomm.com?part=3D18
