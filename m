Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED19A606A322
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bb+C2n/Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5902610E673;
	Tue, 24 Nov 2026 12:29:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3125D10E673
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:28:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A99F9612AD;
 Tue, 24 Nov 2026 12:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D1C1F0089E;
 Tue, 24 Nov 2026 12:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795523333;
 bh=LumEDa6/S2zxUbD1wFURzVjUNLOfflqrSYBiARMAwPU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bb+C2n/YeIo+mdtJGAbfXjNMhrVrqA8tiPxsIcVWLi0HAeSqeODiiXhyfCqPPyD04
 GvmYQrDrLLq383EOulFs6FErveBjl7lbXXadrK2jpWYu9P8q8P8FZ4DI0Xb1xFqJTh
 EWncNe3X5AxyTTGae2n63lKD4dOy//tDSu2Rj++wC8o7okPOJt6vC2rrerXwrPJPJP
 nVvHvet35Dt/DISoVq4k4a/LLq0yeIM7+gkl/LL/hP5ujLCgyMsr7s1asNbpNepKxf
 e8xOZHfGugOYdM8N65+zgFo8yRAHzzYXYIgYocrYGcRdwWZb8n8TvFooDsb7mPoT3u
 I3ArIgSD0eXUg==
Message-ID: <sashiko-outbox-231137@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] drm/bridge: trilinear: add the DPTX DRM bridge
To: "Luo Liu" <Luo.Liu@cixtech.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261124120114.3273161-4-Luo.Liu@cixtech.com>
References: <20261124120114.3273161-1-Luo.Liu@cixtech.com>
 <20261124120114.3273161-4-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 12:28:52 +0000
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
- [Medium] drm/bridge: trilinear: incomplete sync polarity inversion in
  dptx_adjust_mode()
- [Medium] drm/bridge: trilinear: overly strict minbpp check in
  dptx_bridge_mode_valid()
- [Medium] drm/bridge: trilinear: invalid 6-bpc YCbCr clamping in
  dptx_cal_bpc()
- [Medium] drm/bridge: trilinear: broken force_hpd state tracking in
  dptx_hpd_notify()
- [Medium] drm/bridge: trilinear: unlocked sink cap reads in mode and
  atomic callbacks
--

commit ddc2a99abbf4b4fdf910cc9ae707fe7d7cc5ebca
Author: Luo Liu <Luo.Liu@cixtech.com>

drm/bridge: trilinear: add the DPTX DRM bridge

This commit adds the DRM bridge implementation for the Trilinear
DisplayPort transmitter, handling connector detection, EDID and downstream
mode enumeration, mode validation, format selection, and atomic modeset
callbacks.

> diff --git a/drivers/gpu/drm/bridge/trilinear/dptx_drm.c b/drivers/gpu/dr=
m/bridge/trilinear/dptx_drm.c
> new file mode 100644
> index 0000000000000..fde34bac1230a
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/trilinear/dptx_drm.c
> @@ -0,0 +1,623 @@

[ ... ]

> +static void dptx_hpd_notify(struct dptx_dev *dp,
> +			    enum drm_connector_status hpd_state)
> +{
> +	dp->ops->lock(dp);
> +	if (READ_ONCE(dp->hpd_stopped)) {
> +		dp->ops->unlock(dp);
> +		return;
> +	}
> +
> +	if (dp->state & DPTX_STATE_SUSPENDED) {
> +		dp->force_hpd =3D connector_status_disconnected;
> +		dp->ops->unlock(dp);
> +		return;
> +	}
> +
> +	if (hpd_state !=3D dp->status) {
> +		dp->force_hpd =3D hpd_state;
> +		schedule_delayed_work(&dp->hpd_event_work, 0);
> +
> +		if (hpd_state =3D=3D connector_status_connected)
> +			schedule_delayed_work(&dp->sw_hpd_irq_work, 1);
> +	}
> +	dp->ops->unlock(dp);
> +}

[Severity: Medium]
Can dptx_hpd_notify() lose or corrupt dp->force_hpd transitions?

While DPTX_STATE_SUSPENDED is set, dp->force_hpd is unconditionally
overwritten with connector_status_disconnected instead of recording
hpd_state, so a USB-C display plugged in before resume completes will be
treated as disconnected when dptx_pm_complete() runs hpd_event_work.

When not suspended, updating dp->force_hpd is gated on
hpd_state !=3D dp->status, even though dp->status is only updated later by
hpd_event_work and reflects whether AUX detection succeeded.  If AUX
detection fails after a connect event (leaving dp->status as
connector_status_disconnected), or if an unplug arrives before
hpd_event_work finishes polling the PHY, a subsequent disconnect sees
hpd_state =3D=3D dp->status and leaves dp->force_hpd stuck at
connector_status_connected.

In addition, drm_bridge_connector_detect_ctx() invokes .hpd_notify() after
.detect().  If a native DP sink is unplugged between dptx_detect_status()
and dptx_hpd_notify(), the stale connector_status_connected result now
differs from dp->status and gets latched into dp->force_hpd, overriding
the physical HPD pin.

[ ... ]

> +static enum drm_mode_status
> +dptx_bridge_mode_valid(struct drm_bridge *bridge,
> +		       const struct drm_display_info *info,
> +		       const struct drm_display_mode *mode)
> +{
> +	struct dptx_dev *dp =3D bridge_to_dp(bridge);
> +	int max_lanes =3D dp->link_max_lanes;
> +	int max_rate =3D dp->link_max_rate;
> +	int clock =3D mode->clock;
> +	u32 pixel_per_cycle =3D dptx_pick_ppc(mode, DP_PIXELFORMAT_RGB);
> +	int minbpp =3D DPTX_MIN_BPP;
> +
> +	if (drm_mode_is_420_only(info, mode)) {
> +		if (!bridge->ycbcr_420_allowed ||
> +		    !dp->hw->ops->vsc_supported(dp->hw))
> +			return MODE_NO_420;
> +
> +		minbpp =3D 8 * 3 / 2;
> +		pixel_per_cycle =3D 1;
> +	}
> +
> +	if (pixel_per_cycle =3D=3D 1 && clock > DPTX_MAX_FREQ) {
> +		drm_mode_debug_printmodeline(mode);
> +		return MODE_CLOCK_HIGH;
> +	}
> +
> +	if (clock > DPTX_MAX_RATE(max_rate, max_lanes, minbpp)) {
> +		drm_mode_debug_printmodeline(mode);
> +		return MODE_CLOCK_HIGH;
> +	}
> +
> +	return MODE_OK;
> +}

[Severity: Medium]
Does dptx_bridge_mode_valid() reject modes that fmt_prio[] would allow at
12 or 16 bpp, while accepting modes whose adjusted clock later fails
dptx_bridge_atomic_check()?

minbpp is only lowered from 18 to 12 for drm_mode_is_420_only(info, mode),
even though dptx_format_ok() and fmt_prio[] also fall back to YCbCr 4:2:0
8 bpc (12 bpp) for 4:2:0-also modes and YCbCr 4:2:2 8 bpc (16 bpp) when
the sink supports them, filtering out modes such as 4K60 over 2-lane HBR2
during mode probing.  Conversely, dptx_bridge_mode_valid() checks the
unadjusted mode->clock without applying the DPTX_MIN_H_BACKPORCH htotal
and clock expansion that dptx_adjust_mode() performs in
dptx_bridge_atomic_check().

[ ... ]

> +static int dptx_cal_bpc(struct drm_connector_state *connector_state, int=
 bpc)
> +{
> +	struct drm_display_info *info =3D
> +		&connector_state->connector->display_info;
> +
> +	if (dptx_bt2020_colorspace(connector_state))
> +		bpc =3D min(bpc, 10);
> +
> +	if (info->bpc)
> +		bpc =3D min_t(int, bpc, info->bpc);
> +
> +	if (connector_state->max_requested_bpc)
> +		bpc =3D min(bpc, connector_state->max_requested_bpc);
> +
> +	return bpc;
> +}

[Severity: Medium]
Can dptx_cal_bpc() clamp YCbCr formats down to an invalid 6 bpc?

When info->bpc or connector_state->max_requested_bpc is 6 (or info->bpc is
non-zero and below 6), dptx_cal_bpc() clamps every candidate in fmt_prio[]
down to that value without checking the format minimum.  DisplayPort only
permits 6 bpc for RGB, while YCbCr 4:2:2 and 4:2:0 require at least 8 bpc;
clamping them produces invalid 6-bpc YCbCr configurations (12 bpp and
9 bpp).  When suggest_bpc is 6, fmt_prio[0] also evaluates RGB at 6 bpc
ahead of the YCbCr 4:2:2 entries instead of deferring RGB 6 bpc to
fmt_prio[3].

[ ... ]

> +static void dptx_adjust_mode(struct drm_display_mode *mode,
> +			     struct drm_display_mode *adjusted_mode)
> +{
> +	int diff =3D mode->htotal - mode->hsync_end;
> +
> +	if (diff < DPTX_MIN_H_BACKPORCH) {
> +		adjusted_mode->htotal =3D mode->htotal +
> +					DPTX_MIN_H_BACKPORCH - diff;
> +		adjusted_mode->clock =3D
> +			div_u64(mul_u32_u32(mode->clock, adjusted_mode->htotal),
> +				mode->htotal);
> +	}
> +
> +	/* The sync polarities are inverted with respect to the source mode. */
> +	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> +		adjusted_mode->flags &=3D ~DRM_MODE_FLAG_PVSYNC;
> +	else
> +		adjusted_mode->flags |=3D DRM_MODE_FLAG_PVSYNC;
> +
> +	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> +		adjusted_mode->flags &=3D ~DRM_MODE_FLAG_PHSYNC;
> +	else
> +		adjusted_mode->flags |=3D DRM_MODE_FLAG_PHSYNC;
> +}

[Severity: Medium]
Does dptx_adjust_mode() leave DRM_MODE_FLAG_NVSYNC and
DRM_MODE_FLAG_NHSYNC in an inconsistent state on adjusted_mode->flags?

Because adjusted_mode starts as a copy of mode, toggling only
DRM_MODE_FLAG_PVSYNC and DRM_MODE_FLAG_PHSYNC leaves neither sync polarity
flag set when the source mode has positive sync, and both positive and
negative sync flags set when the source mode has negative sync.  Any
upstream CRTC or bridge inspecting DRM_MODE_FLAG_NVSYNC or
DRM_MODE_FLAG_NHSYNC on adjusted_mode will see the wrong polarity.

[ ... ]

> +static int dptx_bridge_atomic_check(struct drm_bridge *bridge,
> +				    struct drm_bridge_state *bridge_state,
> +				    struct drm_crtc_state *crtc_state,
> +				    struct drm_connector_state *conn_state)
> +{
> +	struct dptx_dev *dp =3D bridge_to_dp(bridge);
> +	int bpc;
> +	int bpp;
> +	int ret;
> +
> +	if (!conn_state->crtc)
> +		return 0;
> +
> +	dptx_adjust_mode(&crtc_state->mode, &crtc_state->adjusted_mode);
> +
> +	ret =3D dptx_pick_config(dp, conn_state, &crtc_state->mode,
> +			       &crtc_state->adjusted_mode,
> +			       NULL, &bpc, &bpp);
> +	if (ret)
> +		return ret;
> +
> +	if (dp->hw->ops->vsc_supported(dp->hw)) {
> +		const struct drm_connector_state *old_conn_state;
> +
> +		old_conn_state =3D
> +			drm_atomic_get_old_connector_state(bridge_state->base.state,
> +							   conn_state->connector);
> +		if (old_conn_state &&
> +		    old_conn_state->colorspace !=3D conn_state->colorspace)
> +			crtc_state->mode_changed =3D true;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Can dptx_bridge_atomic_check(), dptx_bridge_mode_valid(), and
dptx_bridge_get_modes() race with hpd_event_work when reading sink
capabilities without dp->ops->lock(dp)?

CPU0                                  CPU1 (kworker)
dptx_bridge_atomic_check()            dptx_hpd_event_work_func()
                                        dp->ops->lock(dp)
                                        ...
                                          dptx_hw_dpcd_sink_caps()
                                            memset(&hw->caps, 0, ...)
  dptx_pick_config()
    ...
      dptx_format_ok()
        vsc_supported(dp->hw) <-- reads 0
                                            /* DP AUX reads populate caps */
                                        dp->ops->unlock(dp)

While hpd_event_work holds dp->lock and refreshes sink capabilities across
sleeping DP AUX transfers, dptx_hw_dpcd_sink_caps() zeroes hw->caps before
repopulating hw->dpcd, hw->downstream_ports, hw->caps.vsc_supported,
dp->link_max_lanes, and dp->link_max_rate.  Unlike dptx_bridge_mode_set(),
which acquires dp->ops->lock(dp) around dptx_pick_config(),
dptx_bridge_get_modes(), dptx_bridge_mode_valid(), and
dptx_bridge_atomic_check() read these fields unlocked and can observe
partially updated or zeroed capabilities and reject valid modes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124120114.3273=
161-1-Luo.Liu@cixtech.com?part=3D3
