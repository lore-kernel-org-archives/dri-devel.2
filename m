Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A18F606A331
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KAPvzsSb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4805810E567;
	Mon,  9 Nov 2026 20:30:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA95610E567
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 20:30:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 93AE3438C6;
 Mon,  9 Nov 2026 20:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391131F0089F;
 Mon,  9 Nov 2026 20:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794256206;
 bh=XRNiKKma8aLf/Kcnp1WxhD74s/XAIcgcZ6h9+KoKyPg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KAPvzsSbuJTKabCGEyApHgjcSUq6kycBlg7xbwONoTA8hsLZMYvlWZnrTCNVQyOu5
 rsaZI/VEac3YJl7Vj8vdKKkRQInPGcgRLDkeZe2atMkAgBqoLE3EmJstkMVsOvK0z0
 HR1cVzsGO59ySVTBNYXu3JrOKbABJOMUAlzQIOwzxKAh/0O7UtEYkwkevSt5cGQbnL
 2haYE8mJ6vhSn74TAvoz7/J2kFHvkcs9yQkDBsE/byly+RgbA+m25//R+Gdy4fy0O8
 ySqWlM7pAtNB19oIocvVwCpUHfjBv9Qahy2tzIOF7g6xkH9OycKQy6tmHOgVCd+nyI
 2siuXke/UkXqA==
Message-ID: <sashiko-outbox-205583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/cix: add Sky1 DisplayPort transmitter driver
To: "Luo Liu" <Luo.Liu@cixtech.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
Cc: robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261109092623.102291-3-Luo.Liu@cixtech.com>
References: <20261109092623.102291-1-Luo.Liu@cixtech.com>
 <20261109092623.102291-3-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 20:30:05 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 16 potential
issues to consider:
- [High] drm/cix: unread sink DPCD caps and status race on boot, resume,
  and HPD
- [High] drm/cix: AUX probe in cix_dp_replay_deferred_hotplug() always
  fails with -ENODEV
- [High] drm/cix: broken VSC SDP packing, stream override, and YCbCr420
  validation
- [High] drm/cix: unclocked MMIO register accesses when apb_clk is gated
- [High] drm/cix: NULL pointer dereference when
  DRM_BRIDGE_ATTACH_NO_CONNECTOR is set
- [High] drm/cix: broken YCbCr 4:2:0 mode matching, format selection,
  and VSC SDP
- [Medium] drm/cix: PHY refcount leak and state desync when
  cix_dp_enable() or resume fails
- [Medium] drm/cix: HPD workqueue and IRQ teardown races in deinit,
  detach, and suspend
- [Medium] drm/cix: active streams and PHY power left enabled in
  shutdown and remove
- [Medium] drm/cix: display stays off if cix_dp_prepare() runs before
  cix_dp_pm_complete()
- [Medium] drm/cix: missing stream TU/timing update and unchecked mode
  config on retrain
- [Medium] drm/cix: broken BT.2020 bpc fallback in cix_dp_cal_bpc() and
  6 bpc default
- [Medium] drm/cix: unlocked mode state update in
  cix_dp_bridge_mode_set() before prepare
- [Medium] drm/cix: FIFO underflow read on AUX NACK/DEFER in
  cix_dp_aux_cmd_submit()
- [Medium] drm/cix: plain 64-bit division in cix_dp_adjust_mode() breaks
  32-bit builds
- [Low] drm/cix: cix_dp_aux_cmd_submit() reads reply FIFO on AUX/I2C
  NACK or DEFER
--

commit 002cf156569e15175af86684eb3509dc08da82b1
Author: Luo Liu <Luo.Liu@cixtech.com>

drm/cix: add Sky1 DisplayPort transmitter driver

This commit adds a DRM bridge and connector driver for the CIX Sky1
DisplayPort transmitter, driving the DisplayPort PHY via the generic PHY
API and supporting link training, EDID probing, YCbCr 4:2:0, and hotplug.

> diff --git a/drivers/gpu/drm/cix/dptx/cix_dptx.c b/drivers/gpu/drm/cix/dp=
tx/cix_dptx.c
> new file mode 100644
> index 0000000000000..8915c50bc9db3
> --- /dev/null
> +++ b/drivers/gpu/drm/cix/dptx/cix_dptx.c
[ ... ]
> +static int cix_dp_train_loop(struct cix_dp *dp)
> +{
> +	struct cix_dp_mode *mode =3D &dp->mode;
> +	u8 bpp =3D dp->connector.config.bpp;
> +	u8 bw_code =3D mode->bw_code;
> +	int i;
> +	int j;
> +	int ret;
> +
> +	for (i =3D 0; i < DP_MAX_TRAINING_LOOP; i++) {
> +		for (j =3D 0; j <=3D 3; j++) {
> +			if (!(dp->state & DPTX_STATE_READY))
> +				return 0;
> +
> +			ret =3D cix_dp_train(dp);
> +			if (!ret)
> +				return 0;
> +
> +			ret =3D cix_dp_mode_configure(dp, mode->pclock, bw_code,
> +						    bpp, true);
> +			if (ret < 0)
> +				break;
> +
> +			bw_code =3D dp->mode.bw_code;
> +		}
> +
> +		cix_dp_mode_configure(dp, mode->pclock, 0, bpp, true);
> +		bw_code =3D dp->mode.bw_code;
> +	}
> +
> +	return -EIO;
> +}

[Severity: Medium]
When cix_dp_hpd_irq_work_func() calls cix_dp_train_loop() while a stream is
enabled and link training downshifts dp->mode.bw_code or changes
dp->mode.lane_cnt, does anything reprogram the active stream's transfer unit
and timing registers?  cix_dp_mode_set_transfer_unit() and
cix_dp_mode_set_timing() depend on bw_code, link_rate, and lane_cnt, so
leaving CIX_DPTX_TU_CONFIG, CIX_DPTX_USER_DATA_COUNT,
CIX_DPTX_SECONDARY_DATA_WINDOW, and CIX_DPTX_DATA_CONTROL at their old valu=
es
corrupts the running video stream.  Also, the fallback
cix_dp_mode_configure() call at the end of the outer loop ignores its return
value.

> +
> +static int cix_dp_aux_cmd_submit(struct cix_dp *dp, u32 cmd, u32 addr,
> +				 u8 *buf, u32 bytes, u8 *reply)
> +{
[ ... ]
> +	value =3D cix_dp_read(dp, CIX_DPTX_AUX_REPLY_CODE);
> +	if (reply)
> +		*reply =3D value;
> +
> +	if (is_read) {
> +		if (value =3D=3D CIX_DPTX_AUX_REPLY_CODE_AUX_ACK ||
> +		    value =3D=3D CIX_DPTX_AUX_REPLY_CODE_I2C_ACK) {
> +			value =3D cix_dp_read(dp, CIX_DPTX_AUX_REPLY_DATA_COUNT);
> +			if ((value & CIX_DPTX_REPLY_DATA_COUNT_MASK) !=3D bytes)
> +				return -EIO;
> +		}
> +		for (i =3D 0; i < bytes; i++)
> +			buf[i] =3D cix_dp_read(dp, CIX_DPTX_AUX_REPLY_DATA);
> +	}
> +
> +	return 0;
> +}

[Severity: Low]
Should the CIX_DPTX_AUX_REPLY_DATA read loop be inside the ACK check?  When=
 a
sink responds to a read with NACK or DEFER, the loop still runs and overwri=
tes
buf with stale or empty FIFO reads before drm_dp_aux retries.

> +
> +static ssize_t cix_dp_aux_transfer(struct drm_dp_aux *aux,
> +				   struct drm_dp_aux_msg *msg)
> +{
> +	struct cix_dp *dp =3D container_of(aux, struct cix_dp, aux);
> +	size_t to_access =3D 0;
> +	size_t accessed_bytes =3D 0;
> +	int ret;
> +
> +	if (!cix_dp_get_hpd_state(dp))
> +		return -ENODEV;
> +
> +	do {
> +		to_access =3D min_t(size_t, DP_AUX_MAX_PAYLOAD_BYTES,
> +				  msg->size - accessed_bytes);
> +		ret =3D cix_dp_aux_cmd_submit(dp, msg->request,
> +					    msg->address + accessed_bytes,
> +					    msg->buffer + accessed_bytes,
> +					    to_access, &msg->reply);
> +		if (ret)
> +			return accessed_bytes ? (ssize_t)accessed_bytes : ret;
> +
> +		accessed_bytes +=3D to_access;
> +	} while (accessed_bytes < msg->size);
> +
> +	return msg->size;
> +}

[Severity: Medium]
In addition to cix_dp_aux_cmd_submit() reading from the empty
CIX_DPTX_AUX_REPLY_DATA FIFO when the sink replies with NACK or DEFER, does
cix_dp_aux_transfer() keep submitting later 16-byte chunks after a non-ACK
reply?  cix_dp_aux_cmd_submit() returns 0 on NACK and DEFER, so a multi-chu=
nk
transfer continues looping and overwrites msg->reply instead of stopping and
returning to the caller.

[ ... ]

> +static int cix_dp_set_misc(struct cix_dp *dp,
> +			   struct cix_dp_panel *dp_panel)
> +{
> +	struct cix_dp_config *config;
> +
> +	if (!dp_panel || !dp_panel->connector)
> +		return -EINVAL;
> +
> +	config =3D &dp_panel->connector->config;
> +
> +	config->misc0 &=3D ~CIX_DPTX_STREAM_MISC0_SYNC_LOCK;
> +	config->misc1 &=3D ~CIX_DPTX_VSC_COLORIMETRY_EN;
> +	config->override =3D 0;
> +
> +	if (dp->caps.vsc_supported &&
> +	    cix_dp_needs_vsc_sdp(config->format, config->colorspace)) {
> +		config->misc1 |=3D CIX_DPTX_VSC_COLORIMETRY_EN;
> +
> +		switch (config->bpc) {
> +		case 6:
> +			config->override =3D CIX_DPTX_STREAM_OVERRIDE_BPC_6;
> +			break;
[ ... ]
> +		default:
> +			config->override =3D CIX_DPTX_STREAM_OVERRIDE_BPC_8;
> +			break;
> +		}
> +
> +		if (config->format =3D=3D CIX_DP_FORMAT_YCBCR420)
> +			config->override |=3D CIX_DPTX_STREAM_OVERRIDE_YCbCR_420;
> +
> +		config->override |=3D CIX_DPTX_STREAM_OVERRIDE_ENABLE;
> +		config->dynamic_range =3D DP_DYNAMIC_RANGE_CTA;
> +		config->content_type =3D DP_CONTENT_TYPE_NOT_DEFINED;
> +
> +		goto end;
> +	}
[ ... ]
> +static int dptx_setup_vsc_sdp(struct dp_sdp *sdp,
> +			      struct cix_dp_config *config)
> +{
> +	sdp->sdp_header.HB0 =3D 0;
> +	sdp->sdp_header.HB1 =3D 0x7;
> +	sdp->sdp_header.HB2 =3D 0x5;
> +	sdp->sdp_header.HB3 =3D 0x13;
> +
> +	switch (config->format) {
> +	case CIX_DP_FORMAT_YCBCR444:
> +		sdp->db[16] =3D 0x1 << 4;
> +		break;
> +	case CIX_DP_FORMAT_YCBCR422:
> +		sdp->db[16] =3D 0x1 << 4;
> +		break;
> +	case CIX_DP_FORMAT_YCBCR420:
> +		sdp->db[16] =3D 0x3 << 4;
> +		break;
> +	default:
> +		break;
> +	}

[Severity: High]
Does dptx_setup_vsc_sdp() program the wrong VSC SDP payload for YCbCr 4:2:2,
RGB, and 6 bpc?

CIX_DP_FORMAT_YCBCR422 sets sdp->db[16] to 0x1 << 4 (YCbCr 4:4:4) instead of
0x2 << 4 (YCbCr 4:2:2).  In the default (RGB) branch, sdp->db[16] is not
cleared before the colorspace switch ORs in the colorimetry bits, leaving
stale format and colorimetry bits from earlier modesets in
conn->sdp[CIX_VSC_SDP].  Further down in dptx_setup_vsc_sdp(), switch
(config->bpc) has no case 6, so 6 bpc RGB falls into default and encodes
0x1 (8 bpc) instead of 0x0 in sdp->db[17].

In cix_dp_set_misc() above, the VSC path only sets the pixel format bits in
config->override for CIX_DP_FORMAT_YCBCR420 (leaving YCbCr 4:2:2 and 4:4:4
as 0/RGB in the override register) and overwrites config->content_type with
DP_CONTENT_TYPE_NOT_DEFINED instead of using conn_state->content_type.  Als=
o,
cix_dp_pick_format_bpc() and cix_dp_connector_mode_valid() select
DRM_OUTPUT_COLOR_FORMAT_YCBCR420 without checking dp->caps.vsc_supported;
when vsc_supported is false, cix_dp_set_misc() falls through and returns
-EINVAL (which cix_dp_panel_hw_cfg() ignores), leaving MISC0, MISC1,
OVERRIDE, and the VSC SDP unconfigured while the RCSU adapter is set to
YCbCr 4:2:0.

[ ... ]

> +static int cix_dp_panel_setup_colorimetry_sdp(struct cix_dp *dp,
> +					      struct cix_dp_panel *dp_panel)
> +{
> +	struct cix_connector *conn =3D dp_panel->connector;
> +
> +	if (conn->config.override & CIX_DPTX_STREAM_OVERRIDE_ENABLE) {
> +		dptx_setup_vsc_sdp(&conn->sdp[CIX_VSC_SDP], &conn->config);
> +		infoframe_write_packet(dp, dp_panel->source_id, CIX_VSC_SDP,
> +				       &conn->sdp[CIX_VSC_SDP], 1);
> +	}
> +
> +	return 0;
> +}
[ ... ]
> +static int cix_dp_panel_hw_cfg(struct cix_dp *dp, int stream_id)
> +{
> +	struct cix_dp_panel *dp_panel =3D dp->active_panels[stream_id];
> +	struct drm_display_mode *mode =3D cix_dp_get_mode(dp, stream_id);
> +	struct cix_connector *conn;
> +
> +	if (!mode)
> +		return -EINVAL;
> +
> +	conn =3D dp_panel->connector;
> +
> +	cix_dp_cfg_adapter(dp, stream_id);
> +
> +	cix_dp_set_misc(dp, dp_panel);
> +	cix_dp_panel_setup_colorimetry_sdp(dp, dp_panel);
> +
> +	cix_dp_mode_set_transfer_unit(dp, dp_panel->source_id, mode,
> +				      conn->config.bpp);
> +	cix_dp_mode_set_timing(dp, dp_panel->source_id, mode, conn->config.bpp);
> +	return 0;
> +}

[Severity: High]
Does enabling the bridge when attached with DRM_BRIDGE_ATTACH_NO_CONNECTOR
cause a NULL pointer dereference on dp_panel->connector?

When DRM_BRIDGE_ATTACH_NO_CONNECTOR is passed to cix_dp_bridge_attach(), it
returns 0 without calling cix_dp_connector_create(), leaving
dp->dp_panel.connector NULL.  On modeset enable, cix_dp_panel_hw_cfg()
ignores the -EINVAL return from cix_dp_set_misc() and calls
cix_dp_panel_setup_colorimetry_sdp(), which dereferences
conn->config.override, followed by cix_dp_panel_hw_cfg() dereferencing
conn->config.bpp.  In addition, cix_dp_hpd_event_work_func() exits early wh=
en
!dp->dp_panel.connector and cix_dp_bridge_funcs does not implement the brid=
ge
detect, EDID, or HPD callbacks needed without an internal connector.

[ ... ]

> +/*
> + * Pure probe: report the current HPD level without touching the session=
 state
> + * or the hardware.  This runs on every DRM probe, poll and hotplug, so
> + * DPTX_STATE_CONNECTED is advanced from the HPD event work and the enco=
der
> + * prepare path instead.
> + *
> + * The host is initialized by probe, resume and cix_dp_prepare().  Bail =
out
> + * loudly if we are ever called before that: cix_dp_read() is a plain re=
adl()
> + * and would hang on a gated APB clock.
> + */
> +static int cix_dp_detect(struct cix_dp *dp)
> +{
> +	int ret =3D 0;
> +
> +	mutex_lock(&dp->session_lock);
> +
> +	if (dp->state & DPTX_STATE_SUSPENDED) {
> +		ret =3D -EBUSY;
> +	} else if (!(dp->state & DPTX_STATE_INITIALIZED)) {
> +		dev_warn_once(dp->dev, "detect with uninitialized host\n");
> +		ret =3D -ENODEV;
> +	}
> +
> +	mutex_unlock(&dp->session_lock);
> +
> +	if (ret)
> +		return ret;
> +
> +	return cix_dp_get_hpd_state(dp) ? 0 : -ENODEV;
> +}

[Severity: High]
Can MMIO registers be read while dp->apb_clk is gated, hanging the bus?

As noted in the comment above cix_dp_detect(), reading DPTX registers while
the host is uninitialized and apb_clk is gated hangs the bus:

- cix_dp_aux_transfer() calls cix_dp_get_hpd_state() and
  cix_dp_aux_cmd_submit() without acquiring dp->session_lock or checking
  DPTX_STATE_INITIALIZED / DPTX_STATE_SUSPENDED, so /dev/drm_dp_aux* or I2C
  transfers during suspend read unclocked MMIO registers.
- cix_dp_hpd_irq_work_func() and cix_dp_hpd_event_work_func() call
  cix_dp_get_hpd_state() before acquiring dp->session_lock and checking
  DPTX_STATE_INITIALIZED.
- cix_dp_detect() drops dp->session_lock before calling
  cix_dp_get_hpd_state(), and cix_dp_prepare() drops and re-acquires
  dp->session_lock around cix_dp_handle_connect() without rechecking
  DPTX_STATE_INITIALIZED, allowing a concurrent cix_dp_pm_prepare() to gate
  apb_clk in between.

[ ... ]

> +static void cix_dp_replay_deferred_hotplug(struct cix_dp *dp)
> +{
> +	struct phy *phy =3D dp->phy;
> +	union phy_configure_opts opts =3D { 0 };
> +	u8 dpcd_rev;
> +
> +	if (!(dp->state & DPTX_STATE_INITIALIZED))
> +		return;
> +	if (dp->force_hpd !=3D connector_status_unknown)
> +		return;
> +	if (cix_dp_get_hpd_state(dp))
> +		return;
> +
> +	phy_validate(phy, PHY_MODE_DP, 0, &opts);
> +	if (phy_get_mode(phy) !=3D PHY_MODE_DP)
> +		return;
> +
> +	/*
> +	 * The combo PHY is already muxed to DP, so the sink may have been
> +	 * plugged in before the connector existed. Probe the AUX channel to
> +	 * make sure one is really there before forcing a hotplug event.
> +	 */
> +	if (drm_dp_dpcd_readb(&dp->aux, DP_DPCD_REV, &dpcd_rev) < 0)
> +		return;
> +
> +	dp->force_hpd =3D connector_status_connected;
> +	dp->status =3D connector_status_unknown;
> +	schedule_delayed_work(&dp->hpd_event_work, 0);
> +}

[Severity: High]
Won't drm_dp_dpcd_readb() in cix_dp_replay_deferred_hotplug() always fail
with -ENODEV?

cix_dp_replay_deferred_hotplug() only reaches drm_dp_dpcd_readb() when
cix_dp_get_hpd_state(dp) is false, and it does not set
dp->force_hpd =3D connector_status_connected until after the read succeeds.
However, drm_dp_dpcd_readb() calls cix_dp_aux_transfer(), which immediately
checks if (!cix_dp_get_hpd_state(dp)) and returns -ENODEV, so a USB-C displ=
ay
plugged in before bridge attach is never detected.

> +
> +static void cix_dp_hpd_event_work_func(struct work_struct *work)
> +{
> +	struct cix_dp *dp =3D container_of(work, struct cix_dp,
> +					 hpd_event_work.work);
> +	struct phy *phy =3D dp->phy;
> +	union phy_configure_opts opts =3D { 0 };
> +	enum drm_connector_status old_status;
> +	enum phy_mode mode;
> +	int i;
> +
> +	if (!dp->dp_panel.connector)
> +		return;
> +
> +	/*
> +	 * On a USB-C DP alt-mode PHY the hotplug only becomes valid once the
> +	 * PHY has been switched to DP mode, so wait for the mode change.
> +	 * A native DP PHY has no ->set_mode() operation, which leaves the
> +	 * mode at PHY_MODE_INVALID forever; there is nothing to wait for.
> +	 */
> +	if (cix_dp_get_hpd_state(dp) &&
> +	    phy_get_mode(phy) !=3D PHY_MODE_INVALID) {
> +		for (i =3D 0; i < DP_HPD_MAX_TRIES; i++) {
> +			phy_validate(phy, PHY_MODE_DP, 0, &opts);
> +			mode =3D phy_get_mode(phy);
> +			if (mode =3D=3D PHY_MODE_DP)
> +				break;
> +			msleep(100);
> +		}
> +	}
> +
> +	old_status =3D dp->status;
> +	drm_helper_probe_detect(&dp->connector.base, NULL, false);
> +
> +	if (dp->status =3D=3D connector_status_connected)
> +		cix_dp_handle_connect(dp);
> +	else
> +		cix_dp_handle_disconnect(dp);
> +
> +	if (old_status !=3D dp->status && dp->drm)
> +		drm_helper_hpd_irq_event(dp->drm);
> +}

[Severity: High]
Can sink DPCD capabilities remain unread across boot, resume, and hotplug,
and can concurrent connector probes suppress hotplug events?

If a native DP/eDP sink is already connected at boot, the HPD interrupt fir=
es
in cix_dp_init() before cix_dp_bridge_attach() sets dp->dp_panel.connector,
so cix_dp_hpd_event_work_func() returns early; later,
cix_dp_replay_deferred_hotplug() also returns early because
cix_dp_get_hpd_state(dp) is true.  Likewise, cix_dp_pm_prepare() clears
DPTX_STATE_CONNECTED on suspend without cix_dp_pm_complete() re-probing DPCD
on resume.  Because cix_dp_connector_detect() only checks HPD level without
calling cix_dp_handle_connect(), dp->dpcd, dp->downstream_ports, dp->caps,
and dp->link_config remain unpopulated during mode validation, atomic_check,
and cix_dp_bridge_mode_set() (which runs before encoder_enable() ->
cix_dp_prepare() calls cix_dp_handle_connect()).

Even when cix_dp_hpd_event_work_func() runs, it calls
drm_helper_probe_detect() before cix_dp_handle_connect(), so
cix_dp_connector_detect() passes stale dp->dpcd and dp->downstream_ports to
drm_dp_set_subconnector_property(), and any concurrent DRM connector probe
updates dp->status before old_status =3D dp->status is read:

CPU0 (kworker)                        CPU1 (userspace probe)
cix_dp_hpd_event_work_func()
  msleep(100) waiting for PHY
                                      cix_dp_connector_detect()
                                        dp->status =3D connected
  old_status =3D dp->status (connected)
  drm_helper_probe_detect()
  if (old_status !=3D dp->status)       <-- false, HPD event dropped

Finally, cix_dp_handle_connect() only clears DPTX_STATE_CONNECTED when
cix_dp_panel_read_sink_caps() returns -ETIMEDOUT or -ENOTCONN; if it fails
with -EIO, -EPROTO, -EBUSY, or -ENODEV, DPTX_STATE_CONNECTED stays set and
prevents later cix_dp_handle_connect() calls from reading the DPCD.

[ ... ]

> +static int cix_dp_prepare(struct cix_dp *dp)
> +{
> +	int ret;
> +
> +	mutex_lock(&dp->session_lock);
> +
> +	if (dp->state & (DPTX_STATE_ENABLED)) {
> +		ret =3D 0;
> +		goto end;
> +	}
> +
> +	if (!(dp->state & DPTX_STATE_INITIALIZED)) {
> +		ret =3D cix_dp_host_init(dp);
> +		if (ret)
> +			goto end;
> +	} else if (dp->state & DPTX_STATE_INIT_TRAIN) {
> +		reset_dp_and_reinit(dp);
> +		usleep_range(100, 200);
> +	}
> +
> +	if (cix_dp_get_hpd_state(dp) &&
> +	    !(dp->state & DPTX_STATE_CONNECTED)) {
> +		mutex_unlock(&dp->session_lock);
> +		cix_dp_handle_connect(dp);
> +		mutex_lock(&dp->session_lock);
> +	}
> +
> +	if (!(cix_dp_get_hpd_state(dp) && (dp->state & DPTX_STATE_CONNECTED))) {
> +		ret =3D 0;
> +		goto end;
> +	}
> +
> +	ret =3D cix_dp_core_on(dp, true);
> +
> +end:
> +	mutex_unlock(&dp->session_lock);
> +	return ret;
> +}

[Severity: Medium]
If the display controller resumes and calls cix_dp_bridge_atomic_enable() ->
cix_dp_prepare() before cix_dptx_pm_resume() -> cix_dp_pm_complete() clears
DPTX_STATE_SUSPENDED, will the display stay blank?

cix_dp_prepare() handles !(dp->state & DPTX_STATE_INITIALIZED) by calling
cix_dp_host_init(), and then calls cix_dp_handle_connect() to restore
DPTX_STATE_CONNECTED (which cix_dp_pm_prepare() cleared).  However,
cix_dp_handle_connect() bails out immediately when DPTX_STATE_SUSPENDED is
still set, leaving DPTX_STATE_CONNECTED clear so cix_dp_prepare() skips
cix_dp_core_on() and cix_dp_enable() skips enabling the stream.

[ ... ]

> +static int cix_dp_encoder_enable(struct cix_dp *dp, int stream_id, int e=
nable)
> +{
> +	int ret;
> +
> +	if (enable) {
> +		ret =3D cix_dp_prepare(dp);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D cix_dp_enable(dp, stream_id);
> +	} else {
> +		if (!(dp->state & DPTX_STATE_INITIALIZED))
> +			return 0;
> +
> +		ret =3D cix_dp_disable(dp, stream_id);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D cix_dp_unprepare(dp);
> +	}
> +
> +	return ret;
> +}

[Severity: Medium]
Does a failure in cix_dp_enable() leak PHY init/power references and leave
dp->state inconsistent?

cix_dp_prepare() -> cix_dp_core_on() calls phy_init() and phy_power_on() and
sets DPTX_STATE_READY | DPTX_STATE_INIT_TRAIN.  If cix_dp_enable() then fai=
ls,
DPTX_STATE_ENABLED is not set, cix_dp_encoder_enable() does not roll back v=
ia
cix_dp_core_off(), and a later disable also skips cix_dp_core_off() because
cix_dp_unprepare() returns early when !(dp->state & DPTX_STATE_ENABLED).  On
the next cix_dp_prepare() call, the else if (dp->state &
DPTX_STATE_INIT_TRAIN) branch calls reset_dp_and_reinit(), which resets the
controller and calls phy_init() again without a matching phy_exit(), while
cix_dp_core_on() sees DPTX_STATE_READY still set and returns 0 without
retraining the link.

Similarly, in cix_dp_pm_complete(), if cix_dp_host_init() fails on resume,
enable_irq(dp->irq) is skipped and DPTX_STATE_SUSPENDED stays set, while the
next cix_dp_pm_prepare() or cix_dp_deinit() calls disable_irq(dp->irq)
unconditionally.

[ ... ]

> +static void cix_dp_deinit(struct cix_dp *dp)
> +{
> +	cancel_delayed_work_sync(&dp->sw_hpd_irq_work);
> +	cancel_delayed_work_sync(&dp->hpd_irq_work);
> +	cancel_delayed_work_sync(&dp->hpd_event_work);
> +	disable_irq(dp->irq);
> +
> +	mutex_lock(&dp->session_lock);
> +	cix_dp_host_deinit(dp);
> +	dp->state &=3D ~(DPTX_STATE_CONFIGURED);
> +	mutex_unlock(&dp->session_lock);
> +
> +	mutex_destroy(&dp->session_lock);
> +}

[Severity: Medium]
Can HPD delayed works be re-queued while cix_dp_deinit(),
cix_dp_bridge_detach(), or cix_dp_pm_prepare() is tearing down the driver?

In cix_dp_deinit(), cancel_delayed_work_sync() runs before
disable_irq(dp->irq):

CPU0                                  CPU1 (irq/kworker)
cix_dp_deinit()
  cancel_delayed_work_sync(...)
                                      cix_dp_irq_handler()
                                        queue_delayed_work(...,
                                          &dp->hpd_event_work, 0)
  disable_irq(dp->irq)
  cix_dp_host_deinit()
  mutex_destroy(&dp->session_lock)
  (devm frees dp)
                                      cix_dp_hpd_event_work_func()
                                        <-- use-after-free / gated APB read

Two related races exist in the other teardown paths:
- cix_dp_bridge_detach() cancels hpd_irq_work before sw_hpd_irq_work (even
  though cix_dp_sw_hpd_irq_work_func() queues hpd_irq_work) and leaves
  dp->irq enabled and dp->dp_panel.connector non-NULL while calling
  drm_connector_cleanup(&dp->connector.base).
- cix_dp_pm_prepare() cancels the delayed works before setting
  DPTX_STATE_SUSPENDED, while cix_dp_oob_hotplug_event() checks
  DPTX_STATE_SUSPENDED unlocked and can schedule hpd_event_work and
  sw_hpd_irq_work after the cancel calls.

[ ... ]

> +static void cix_dptx_remove(struct platform_device *pdev)
> +{
> +	struct cix_dp *dp =3D dev_get_drvdata(&pdev->dev);
> +
> +	if (!dp)
> +		return;
> +
> +	drm_bridge_remove(&dp->bridge);
> +	cix_dp_deinit(dp);
> +}
[ ... ]
> +static void cix_dptx_shutdown(struct platform_device *pdev)
> +{
> +	struct cix_dp *dp =3D platform_get_drvdata(pdev);
> +
> +	if (dp) {
> +		mutex_lock(&dp->session_lock);
> +		dp->active_stream_cnt =3D 0;
> +		mutex_unlock(&dp->session_lock);
> +		cix_dp_pm_prepare(dp);
> +	}
> +}

[Severity: Medium]
What happens to active streams and PHY power if cix_dptx_shutdown() or
cix_dptx_remove() runs while a display stream is enabled?

In cix_dptx_shutdown(), zeroing dp->active_stream_cnt without calling
cix_dp_ctrl_stream_off() or cix_dp_core_off() causes cix_dp_pm_prepare() ->
cix_dp_host_deinit() to call phy_exit(dp->phy) while the PHY is still power=
ed
on (and with the second phy_init() reference from cix_dp_core_on() and
stream_clk still active).  In cix_dptx_remove(), dp->active_stream_cnt is n=
ot
cleared and streams are not stopped, so cix_dp_host_deinit() returns early =
at
if (dp->active_stream_cnt) and leaves the transmitter, clocks, and PHY
enabled.

> diff --git a/drivers/gpu/drm/cix/dptx/cix_dptx_drm.c b/drivers/gpu/drm/ci=
x/dptx/cix_dptx_drm.c
> new file mode 100644
> index 0000000000000..0ddcd76691e03
> --- /dev/null
> +++ b/drivers/gpu/drm/cix/dptx/cix_dptx_drm.c
[ ... ]
> +static int cix_dp_cal_bpc(struct cix_dp *dp,
> +			  struct drm_connector_state *connector_state, int bpc)
> +{
> +	struct drm_display_info *info =3D
> +		&connector_state->connector->display_info;
> +
> +	if (connector_state->colorspace >=3D DRM_MODE_COLORIMETRY_BT2020_CYCC &&
> +	    connector_state->colorspace <=3D DRM_MODE_COLORIMETRY_BT2020_YCC)
> +		bpc =3D 10;
> +
> +	if (info->bpc && bpc > info->bpc)
> +		bpc =3D info->bpc;
> +
> +	if (connector_state->max_requested_bpc &&
> +	    bpc > connector_state->max_requested_bpc)
> +		bpc =3D connector_state->max_requested_bpc;
> +
> +	return bpc;
> +}

[Severity: Medium]
When a BT.2020 colorspace is set, doesn't overwriting bpc =3D 10 in
cix_dp_cal_bpc() prevent cix_dp_pick_format_bpc() from stepping down to 8 or
6 bpc when link bandwidth cannot fit 10 bpc?  Each fallback call to
compute_available_clock_rate() with curr_bpc =3D 8 or 6 gets forced back to=
 10.
Also, in cix_dp_pick_config(), passing max(info->bpc, 6) as suggest_bpc
selects 6 bpc instead of 8 bpc whenever an EDID leaves info->bpc as 0.

[ ... ]

> +static void cix_dp_adjust_mode(struct drm_display_mode *mode,
> +			       struct drm_display_mode *adjusted_mode)
> +{
> +	int diff =3D mode->htotal - mode->hsync_end;
> +
> +	/*
> +	 * Cix DP requires horizontal backporch to be greater than 12.
> +	 * This limitation may not be compatible with the sink device.
> +	 *
> +	 * Everything below is derived from @mode instead of accumulating on
> +	 * @adjusted_mode, so that repeated atomic checks of the same state
> +	 * produce the same result.
> +	 */
> +	if (diff < CIX_DPTX_MIN_H_BACKPORCH) {
> +		adjusted_mode->htotal =3D mode->htotal +
> +					CIX_DPTX_MIN_H_BACKPORCH - diff;
> +		adjusted_mode->clock =3D (int64_t)mode->clock *
> +				       adjusted_mode->htotal / mode->htotal;
> +	}

[Severity: Medium]
Will the plain 64-bit division in (int64_t)mode->clock *
adjusted_mode->htotal / mode->htotal fail to link with an undefined referen=
ce
to __divdi3 / __aeabi_ldivmod on 32-bit architectures?  DRM_CIX_DP does not
depend on 64BIT, so this needs div_s64() or mul_u32_u32() with div_u64().

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
[ ... ]
> +static int cix_dp_pick_format_bpc(struct cix_dp *dp,
> +				  struct drm_connector_state *conn_state,
> +				  struct drm_display_mode *adjusted_mode,
> +				  int info_formats, int suggest_bpc,
> +				  int *color_format, int *bpc, int *bpp)
> +{
> +	struct drm_display_info *info =3D
> +		&conn_state->connector->display_info;
> +	int curr_bpc;
> +	int format;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(fmt_prio); i++) {
> +		format =3D fmt_prio[i].format;
> +		curr_bpc =3D fmt_prio[i].bpc ? fmt_prio[i].bpc : suggest_bpc;
> +
> +		/* Only use 420_only flag for YUV420 format */
> +		if (!(info_formats & BIT(format)) &&
> +		    !(format =3D=3D DRM_OUTPUT_COLOR_FORMAT_YCBCR420 &&\n+		      drm_=
mode_is_420_only(info, adjusted_mode)))
> +			continue;

[Severity: High]
Does inverting the sync polarity flags on adjusted_mode in
cix_dp_adjust_mode() break drm_mode_is_420_only(info, adjusted_mode) and
YCbCr 4:2:0 format selection?

cix_dp_bridge_atomic_check() calls cix_dp_adjust_mode() before
cix_dp_pick_config().  Because cix_dp_adjust_mode() flips
DRM_MODE_FLAG_PVSYNC and DRM_MODE_FLAG_PHSYNC on adjusted_mode (and may alt=
er
htotal and clock), drm_match_cea_mode(adjusted_mode) inside
drm_mode_is_420_only() fails to match the CEA mode table and returns 0.

Even when a mode is 4:2:0-only, cix_dp_pick_format_bpc() iterates fmt_prio[]
from RGB444 and YCBCR422 without checking drm_mode_is_420_only() first, so =
any
4:2:0-only mode whose clock fits on the link at RGB or YCbCr 4:2:2 picks a
non-4:2:0 format.  Conversely, when info->color_formats has
DRM_OUTPUT_COLOR_FORMAT_YCBCR420 set, fmt_prio[4] can pick YCBCR420 on modes
where the sink does not support 4:2:0, and without checking that
adjusted_mode->clock <=3D CIX_DP_MAX_FREQ (since YCbCr 4:2:0 forces 1 pixel=
 per
cycle).

[ ... ]

> +static void cix_dp_bridge_mode_set(struct cix_dp *dp,
> +				   struct drm_crtc_state *crtc_state,
> +				   struct drm_connector_state *conn_state)
> +{
[ ... ]
> +	cix_conn->config.format =3D cix_dp_drm_format_to_dp(color_format);
> +	cix_conn->config.colorspace =3D conn_state->colorspace;
> +	cix_conn->config.bpc =3D bpc;
> +	cix_conn->config.bpp =3D bpp;
> +	dp->pixel_per_cycle =3D cix_dp_pick_ppc(adjusted_mode,
> +					      cix_conn->config.format);
> +
> +	link_rate =3D cix_dp_pick_link_rate(dp, adjusted_mode, bpp);
> +	bw_code =3D drm_dp_link_rate_to_bw_code(link_rate);
> +
> +	dp->ops->mode_configure(dp, adjusted_mode->clock, bw_code, bpp, false);
[ ... ]
> +}
[ ... ]
> +static void
> +cix_dp_bridge_atomic_enable(struct drm_bridge *bridge,
> +			    struct drm_atomic_commit *state)
> +{
[ ... ]
> +	cix_dp_bridge_mode_set(dp, crtc_state, conn_state);
> +
> +	ret =3D dp->ops->encoder_enable(dp, dp->dp_panel.source_id, true);
> +	if (ret)
> +		dev_err(dp->dev, "failed to enable DP output: %d\n", ret);
> +}

[Severity: Medium]
Should cix_dp_bridge_mode_set() run under dp->session_lock and after
cix_dp_prepare() has read the sink's DPCD?

cix_dp_bridge_atomic_enable() calls cix_dp_bridge_mode_set() unlocked before
dp->ops->encoder_enable() -> cix_dp_prepare().  This mutates
dp->connector.config, dp->pixel_per_cycle, and dp->mode without holding
dp->session_lock (racing with cix_dp_hpd_irq_work_func() ->
cix_dp_train_loop()), and computes link_rate and lane_cnt from
dp->link_config before cix_dp_prepare() -> cix_dp_handle_connect() /
cix_dp_core_on() updates dp->link_config from the sink's DPCD.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109092623.1022=
91-1-Luo.Liu@cixtech.com?part=3D2
