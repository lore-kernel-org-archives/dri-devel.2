Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103D1606A333
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B5edhJoQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FDAD10EEE1;
	Mon,  9 Nov 2026 10:55:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF5C10EEE1
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 10:55:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B8D1C61423;
 Mon,  9 Nov 2026 10:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362091F008BC;
 Mon,  9 Nov 2026 10:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794221745;
 bh=QcooCw+Izy7CSz4rZKn79yrnwc+IMNrYWjCE+8mGqko=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B5edhJoQUbORSr2IKHckICJ2QnxnBnYoMA9s8jD+/PXw688mbFTfEoaZS89mpLUk6
 bkGSej1IudbIQgwRf5L6EiDuZ8UH4LPYJfKZPvuDbI0/XDRq0MidS8jNJeqXSJFoQ+
 wjOz+DkBKjK1ikS8tOGT+xfrXG18O84qzB8f2PmNdAk6OYdQyPBz6Vi+CVR4CqIcW0
 0Ihc9cBCF9unchMdsKMFU5/2cBfhiJjggxhPcB2vtim8dL79/PxKc5s5lYTubGz9yc
 yj27tRF/3r/03uiAL1q0Wf+3fecLJrc3R8pHW08HSCH/Uc5CLeEaKTFylz50xH61My
 cl/ysH6qImuCw==
Message-ID: <sashiko-outbox-204854@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/cix: add Sky1 DisplayPort transmitter driver
To: "Luo Liu" <Luo.Liu@cixtech.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261109103010.110911-3-Luo.Liu@cixtech.com>
References: <20261109103010.110911-1-Luo.Liu@cixtech.com>
 <20261109103010.110911-3-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 10:55:44 +0000
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
- [High] drm/cix: cix_dp_replay_deferred_hotplug() always fails with
  -ENODEV
- [High] drm/cix: sink DPCD caps not read before detect, mode_valid, and
  mode_set
- [High] drm/cix: PHY ref leak and wedged state in
  cix_dp_encoder_enable() and prepare
- [High] drm/cix: HPD work cancellation and IRQ ordering races on
  teardown and suspend
- [High] drm/cix: unclocked MMIO reads in cix_dp_aux_transfer() and HPD
  workers
- [High] drm/cix/dptx: NULL dereference in cix_dp_panel_hw_cfg() with
  NO_CONNECTOR
- [High] drm/cix/dptx: double connector cleanup and UAF in
  cix_dp_bridge_detach()
- [High] drm/cix/dptx: broken sync flags and YCbCr 4:2:0 selection in
  atomic_check
- [Medium] drm/cix: unbalanced PHY and clock teardown in
  cix_dptx_shutdown() and remove
- [Medium] drm/cix: unbalanced disable_irq() and lost force_hpd state
  across suspend
- [Medium] drm/cix: broken VSC SDP payload and stream override in
  dptx_setup_vsc_sdp()
- [Medium] drm/cix: cix_dp_aux_cmd_submit() reads FIFO and continues on
  NACK or DEFER
- [Medium] drm/cix/dptx: unchecked state allocation in
  cix_dp_connector_create()
- [Medium] drm/cix/dptx: ignored mode_set failure causes divide-by-zero
  on enable
- [Medium] drm/cix/dptx: CIX_DPTX_ENHANCED_FRAMING_ENABLE not cleared
  when disabled
- [Medium] drm/cix/dptx: unlocked access to shared state in mode_set and
  oob_hotplug
--

commit a2a34412966dc5d33f9669af4c794727d4e8b1e4
Author: Luo Liu <Luo.Liu@cixtech.com>

drm/cix: add Sky1 DisplayPort transmitter driver

This commit adds a DRM bridge driver for the CIX Sky1 DisplayPort
transmitter, implementing DP link training, AUX transfers, hotplug
handling, and connector management.

> diff --git a/drivers/gpu/drm/cix/dptx/cix_dptx.c b/drivers/gpu/drm/cix/dp=
tx/cix_dptx.c
> new file mode 100644
> index 0000000000000..8915c50bc9db3
> --- /dev/null
> +++ b/drivers/gpu/drm/cix/dptx/cix_dptx.c

[ ... ]

> @@ -0,0 +1,2086 @@
> +static int cix_dp_link_configure(struct cix_dp *dp)
> +{
> +	u8 bw_code =3D dp->mode.bw_code;
> +	u8 lane_cnt =3D dp->mode.lane_cnt;
> +	int ret;
> +
> +	cix_dp_write(dp, CIX_DPTX_LANE_COUNT_SET, lane_cnt);
> +
> +	if (dp->caps.enhanced_framing) {
> +		cix_dp_write(dp, CIX_DPTX_ENHANCED_FRAMING_ENABLE, 1);
> +		lane_cnt |=3D DP_LANE_COUNT_ENHANCED_FRAME_EN;
> +	}

[Severity: Medium]
Should CIX_DPTX_ENHANCED_FRAMING_ENABLE be cleared when
dp->caps.enhanced_framing is false?  If a sink without enhanced framing is
connected after one that enabled it, the transmitter keeps sending enhanced
framing while DP_LANE_COUNT_ENHANCED_FRAME_EN is cleared in the sink DPCD.

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
Does cix_dp_aux_cmd_submit() read from an empty CIX_DPTX_AUX_REPLY_DATA
FIFO when the sink replies with NACK or DEFER?

When value is non-zero (NACK or DEFER), the reply data count check is
skipped, but the loop still reads bytes entries from
CIX_DPTX_AUX_REPLY_DATA into buf and returns 0.  In cix_dp_aux_transfer(),
multi-chunk transfers also keep submitting subsequent chunks after a NACK
or DEFER instead of stopping and returning the reply code to the DRM AUX
helper.

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
> +
> +	switch (config->colorspace) {
> +	case DRM_MODE_COLORIMETRY_BT709_YCC:
> +		sdp->db[16] |=3D 0x1;

[ ... ]

> +	switch (config->bpc) {
> +	case 16:
> +		sdp->db[17] =3D 0x4;
> +		break;
> +	case 12:
> +		sdp->db[17] =3D 0x3;
> +		break;
> +	case 10:
> +		sdp->db[17] =3D 0x2;
> +		break;
> +	case 8:
> +	default:
> +		sdp->db[17] =3D 0x1;
> +		break;
> +	}
> +
> +	/* Dynamic Range and Component Bit Depth */
> +	if (config->dynamic_range =3D=3D DP_DYNAMIC_RANGE_CTA)
> +		sdp->db[17] |=3D 0x80; /* DB17[7] */
> +
> +	sdp->db[18] =3D config->content_type & 0x7;
> +
> +	return 0;
> +}

[Severity: Medium]
Does dptx_setup_vsc_sdp() program the wrong pixel encoding and bit depth in
the VSC SDP payload?

CIX_DP_FORMAT_YCBCR422 sets sdp->db[16] to 0x1 << 4 (YCbCr 4:4:4) instead
of 0x2 << 4 (YCbCr 4:2:2).  On the default (RGB) path, sdp->db[16] is not
cleared before ORing the colorimetry bits, leaving stale format and
colorimetry values from earlier modesets.  In addition, 6 bpc falls into
the default branch and encodes sdp->db[17] as 0x1 (8 bpc) instead of 0x0.

In cix_dp_set_misc(), the VSC SDP path also only sets the pixel format
override for CIX_DP_FORMAT_YCBCR420 (leaving override format bits as RGB
for YCbCr 4:2:2 and 4:4:4) and hardcodes config->content_type to
DP_CONTENT_TYPE_NOT_DEFINED instead of using the connector's content_type
property.

> +
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
Can cix_dp_panel_hw_cfg() and cix_dp_panel_setup_colorimetry_sdp()
dereference a NULL dp_panel->connector when the bridge is attached with
DRM_BRIDGE_ATTACH_NO_CONNECTOR?

When DRM_BRIDGE_ATTACH_NO_CONNECTOR is passed to cix_dp_bridge_attach(),
cix_dp_connector_create() is skipped and dp->dp_panel.connector remains
NULL.  Enabling the bridge then calls cix_dp_panel_hw_cfg(), which ignores
the -EINVAL return from cix_dp_set_misc() and dereferences conn in
cix_dp_panel_setup_colorimetry_sdp() and cix_dp_mode_set_transfer_unit().
In addition, cix_dp_hpd_event_work_func() returns early when
dp->dp_panel.connector is NULL, and cix_dp_bridge_funcs does not implement
the bridge detection or EDID callbacks needed when connector creation is
delegated to the display controller.

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
Does drm_dp_dpcd_readb() in cix_dp_replay_deferred_hotplug() always fail
with -ENODEV?

cix_dp_replay_deferred_hotplug() returns early if cix_dp_get_hpd_state(dp)
is true, so reaching drm_dp_dpcd_readb() guarantees cix_dp_get_hpd_state(dp)
is false.  Because dp->force_hpd is only set to connector_status_connected
after drm_dp_dpcd_readb(), cix_dp_aux_transfer() sees
!cix_dp_get_hpd_state(dp) and rejects the AUX read with -ENODEV, preventing
deferred hotplug from ever triggering.

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
Does probing the connector before cix_dp_handle_connect() leave dp->dpcd,
dp->link_config, and dp->caps uninitialized during detection and mode
validation?

cix_dp_detect() only checks the HPD pin level and never reads DPCD.  In
cix_dp_hpd_event_work_func(), drm_helper_probe_detect() runs before
cix_dp_handle_connect(), so cix_dp_connector_detect() passes zeroed or
stale dp->dpcd and dp->downstream_ports to
drm_dp_set_subconnector_property().  Likewise, when a native DP monitor is
connected before cix_dp_bridge_attach() creates the connector, or after
system resume, DRM probes the connector and validates modes before
cix_dp_handle_connect() ever runs, and cix_dp_bridge_atomic_enable() calls
cix_dp_bridge_mode_set() before encoder_enable() reads the sink's DPCD
capabilities.

Also, in cix_dp_handle_connect(), DPTX_STATE_CONNECTED is only cleared when
cix_dp_panel_read_sink_caps() fails with -ETIMEDOUT or -ENOTCONN; if it
fails with -EIO or -EBUSY, DPTX_STATE_CONNECTED remains set with zeroed
caps and blocks later retries.

> +
> +static void cix_dp_hpd_irq_work_func(struct work_struct *work)
> +{
> +	struct cix_dp *dp =3D container_of(work, struct cix_dp,
> +					 hpd_irq_work.work);
> +	u8 status[DP_LINK_STATUS_SIZE + 2];
> +	int ret;
> +
> +	if (!cix_dp_get_hpd_state(dp))
> +		return;
> +
> +	mutex_lock(&dp->session_lock);
> +
> +	if (!(dp->state & DPTX_STATE_INITIALIZED) ||
> +	    !(dp->state & DPTX_STATE_ENABLED))
> +		goto end;

[Severity: High]
Can cix_dp_get_hpd_state() and cix_dp_aux_transfer() read DPTX registers
while dp->apb_clk is gated?

As noted above cix_dp_detect(), cix_dp_read() hangs the bus if called when
DPTX_STATE_INITIALIZED is clear and dp->apb_clk is disabled.
cix_dp_hpd_irq_work_func() calls cix_dp_get_hpd_state() before locking
dp->session_lock and checking DPTX_STATE_INITIALIZED, and
cix_dp_aux_transfer() (reachable via /dev/drm_dp_aux*) and
cix_dp_hpd_event_work_func() access DPTX registers without checking
DPTX_STATE_INITIALIZED under dp->session_lock.

[ ... ]

> +static int cix_dp_pm_complete(struct cix_dp *dp)
> +{
> +	int ret =3D 0;
> +
> +	mutex_lock(&dp->session_lock);
> +
> +	if (!(dp->state & DPTX_STATE_SUSPENDED))
> +		goto end;
> +
> +	ret =3D cix_dp_host_init(dp);
> +	if (ret)
> +		goto end;
> +
> +	enable_irq(dp->irq);
> +	dp->state &=3D ~DPTX_STATE_SUSPENDED;
> +
> +	if (dp->drm && dp->drm->mode_config.poll_enabled)
> +		drm_kms_helper_poll_enable(dp->drm);
> +end:
> +	mutex_unlock(&dp->session_lock);
> +	return ret;
> +}

[Severity: Medium]
If cix_dp_host_init() fails in cix_dp_pm_complete(), does dp->irq stay
disabled while a later cix_dp_pm_prepare() or cix_dp_deinit() calls
disable_irq() a second time?

Because cix_dp_pm_prepare() and cix_dp_deinit() call disable_irq(dp->irq)
unconditionally without checking whether DPTX_STATE_SUSPENDED is already
set, a failed resume nests the IRQ disable depth.  Additionally, when
DPTX_STATE_SUSPENDED is set, cix_dp_oob_hotplug_event() overwrites
dp->force_hpd with connector_status_disconnected instead of recording
hpd_state, losing Type-C plug events that arrive during suspend.

> +
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

[Severity: High]
Does a failure in cix_dp_enable() leak PHY references and leave the
transmitter wedged with DPTX_STATE_READY set?

In cix_dp_encoder_enable(), cix_dp_prepare() calls cix_dp_core_on(), which
calls phy_init() and phy_power_on() and sets DPTX_STATE_READY |
DPTX_STATE_INIT_TRAIN.  If cix_dp_enable() then fails, DPTX_STATE_ENABLED
is not set and cix_dp_core_off() is not called.  A subsequent disable will
return early in cix_dp_unprepare() because DPTX_STATE_ENABLED is clear,
while a subsequent enable will call reset_dp_and_reinit() (leaking another
phy_init() call) and then return early in cix_dp_core_on() because
DPTX_STATE_READY is still set, skipping link training after the reset.

Also, if the display controller resumes and calls cix_dp_prepare() before
cix_dptx_pm_resume() clears DPTX_STATE_SUSPENDED, cix_dp_handle_connect()
will bail out on DPTX_STATE_SUSPENDED and leave the display disabled.

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

[Severity: High]
Can HPD delayed work items be re-queued after cancel_delayed_work_sync()
during teardown, bridge detach, or suspend?

CPU0                              CPU1
cix_dp_deinit()
  cancel_delayed_work_sync(...)
                                  cix_dp_irq_handler()
                                    queue_delayed_work(...,
                                      &dp->hpd_event_work, 0)
  disable_irq(dp->irq)
  cix_dp_host_deinit(dp)
  mutex_destroy(&dp->session_lock)
                                  cix_dp_hpd_event_work_func()
                                    <-- unclocked MMIO / UAF

In cix_dp_deinit(), disable_irq(dp->irq) is called after
cancel_delayed_work_sync().  In cix_dp_bridge_detach(), hpd_irq_work is
cancelled before sw_hpd_irq_work (which queues hpd_irq_work), while dp->irq
remains enabled and dp->dp_panel.connector is only cleared after
drm_connector_cleanup().  In cix_dp_pm_prepare(), the works are cancelled
before DPTX_STATE_SUSPENDED is set, allowing a concurrent
cix_dp_oob_hotplug_event() to schedule them right before cix_dp_host_deinit=
()
gates dp->apb_clk.

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
Does zeroing dp->active_stream_cnt in cix_dptx_shutdown() cause
cix_dp_host_deinit() to call phy_exit() while the PHY is still powered on?

When a stream is active at shutdown, forcing dp->active_stream_cnt =3D 0
without calling cix_dp_ctrl_stream_off() and cix_dp_core_off() leaves
stream_clk enabled and the PHY powered on when cix_dp_pm_prepare() ->
cix_dp_host_deinit() calls phy_exit() and disables dp->apb_clk.
Conversely, in cix_dptx_remove() -> cix_dp_deinit(), if
dp->active_stream_cnt is non-zero, cix_dp_host_deinit() returns early and
leaks the clocks and PHY references.

> diff --git a/drivers/gpu/drm/cix/dptx/cix_dptx_drm.c b/drivers/gpu/drm/ci=
x/dptx/cix_dptx_drm.c
> new file mode 100644
> index 0000000000000..0ddcd76691e03
> --- /dev/null
> +++ b/drivers/gpu/drm/cix/dptx/cix_dptx_drm.c

[ ... ]

> @@ -0,0 +1,653 @@
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
> +
> +	/* The sync polarities are inverted with respect to the source mode. */=
\n> +	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
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
> +		    !(format =3D=3D DRM_OUTPUT_COLOR_FORMAT_YCBCR420 &&
> +		      drm_mode_is_420_only(info, adjusted_mode)))
> +			continue;

[Severity: High]
Does mutating adjusted_mode->flags in cix_dp_adjust_mode() break CEA mode
matching and YCbCr 4:2:0 format selection in cix_dp_pick_format_bpc()?

cix_dp_adjust_mode() toggles DRM_MODE_FLAG_PVSYNC and DRM_MODE_FLAG_PHSYNC
without updating DRM_MODE_FLAG_NVSYNC and DRM_MODE_FLAG_NHSYNC, leaving
adjusted_mode->flags with either both positive and negative sync flags set
or neither set.  When cix_dp_pick_format_bpc() then passes adjusted_mode to
drm_mode_is_420_only(), drm_match_cea_mode() fails to match the mutated
flags (and any adjusted htotal/clock) and always returns false.

Furthermore, cix_dp_pick_format_bpc() does not skip non-4:2:0 formats when a
mode is 4:2:0-only (so RGB444 or YCbCr 4:2:2 is picked whenever link
bandwidth allows), and it does not check drm_mode_is_420() or
dp->caps.vsc_supported before picking DRM_OUTPUT_COLOR_FORMAT_YCBCR420 (nor
does cix_dp_bridge_atomic_check() validate adjusted_mode->clock against
CIX_DP_MAX_FREQ).

[ ... ]

> +static void cix_dp_bridge_mode_set(struct cix_dp *dp,
> +				   struct drm_crtc_state *crtc_state,
> +				   struct drm_connector_state *conn_state)
> +{
> +	struct drm_display_mode *adjusted_mode =3D &crtc_state->adjusted_mode;
> +	struct cix_connector *cix_conn =3D &dp->connector;
> +	int color_format;
> +	int link_rate;
> +	int bw_code;
> +	int bpc;
> +	int bpp;
> +	int ret;
> +
> +	ret =3D cix_dp_pick_config(dp, conn_state, adjusted_mode,
> +				 &color_format, &bpc, &bpp);
> +	if (ret) {
> +		dev_err(dp->dev, "no usable DP link configuration: %d\n", ret);
> +		return;
> +	}
> +
> +	cix_conn->config.format =3D cix_dp_drm_format_to_dp(color_format);
> +	cix_conn->config.colorspace =3D conn_state->colorspace;
> +	cix_conn->config.bpc =3D bpc;
> +	cix_conn->config.bpp =3D bpp;

[Severity: Medium]
Can cix_dp_bridge_mode_set() race with cix_dp_hpd_irq_work_func() and
cix_dp_handle_connect() on dp->mode, dp->connector.config, and
dp->link_config?

cix_dp_hpd_irq_work_func() holds dp->session_lock while cix_dp_train_loop()
reads dp->connector.config.bpp and updates dp->mode, and
cix_dp_handle_connect() holds dp->session_lock while updating
dp->link_config, but cix_dp_bridge_mode_set() reads dp->link_config and
writes dp->connector.config and dp->mode without holding dp->session_lock.
Similarly, cix_dp_oob_hotplug_event() reads dp->state and updates
dp->force_hpd without holding dp->session_lock.

> +	dp->pixel_per_cycle =3D cix_dp_pick_ppc(adjusted_mode,
> +					      cix_conn->config.format);
> +
> +	link_rate =3D cix_dp_pick_link_rate(dp, adjusted_mode, bpp);
> +	bw_code =3D drm_dp_link_rate_to_bw_code(link_rate);
> +
> +	dp->ops->mode_configure(dp, adjusted_mode->clock, bw_code, bpp, false);

[Severity: Medium]
If cix_dp_pick_config() or dp->ops->mode_configure() fails in
cix_dp_bridge_mode_set(), can cix_dp_bridge_atomic_enable() divide by zero?

When cix_dp_bridge_mode_set() fails before dp->mode is populated,
cix_dp_bridge_atomic_enable() still calls dp->ops->encoder_enable() with
dp->mode.lane_cnt =3D=3D 0 and dp->mode.bw_code =3D=3D 0.  Link training su=
cceeds
vacuously for 0 lanes, and cix_dp_mode_set_transfer_unit() and
cix_dp_mode_set_timing() then divide by dp->mode.lane_cnt.

[ ... ]

> +static int cix_dp_connector_create(struct cix_dp *dp,
> +				   struct drm_encoder *encoder)
> +{
> +	struct cix_connector *conn =3D &dp->connector;
> +	struct drm_connector *connector =3D &conn->base;
> +	int ret;
> +
> +	conn->dp =3D dp;
> +
> +	connector->polled =3D DRM_CONNECTOR_POLL_HPD;
> +	connector->ycbcr_420_allowed =3D true;
> +
> +	ret =3D drm_connector_init_with_ddc(encoder->dev, connector,
> +					  &cix_dp_connector_funcs,
> +					  DRM_MODE_CONNECTOR_DisplayPort,
> +					  &dp->aux.ddc);
> +	if (ret)
> +		return ret;
> +
> +	drm_connector_helper_add(connector, &cix_dp_connector_helper_funcs);
> +
> +	drm_atomic_helper_connector_reset(connector);
> +
> +	ret =3D drm_connector_attach_encoder(connector, encoder);
> +	if (ret)
> +		goto err_cleanup;
> +
> +	cix_dp_add_properties(connector);

[Severity: Medium]
Can cix_dp_add_properties() dereference a NULL connector->state if the
allocation inside drm_atomic_helper_connector_reset() fails?
drm_connector_attach_max_bpc_property() unconditionally writes to
connector->state->max_requested_bpc and connector->state->max_bpc.

[ ... ]

> +static void cix_dp_bridge_detach(struct drm_bridge *bridge)
> +{
> +	struct cix_dp *dp =3D bridge_to_dp(bridge);
> +
> +	/* The hotplug workers reach the connector, stop them first. */
> +	cancel_delayed_work_sync(&dp->hpd_event_work);
> +	cancel_delayed_work_sync(&dp->hpd_irq_work);
> +	cancel_delayed_work_sync(&dp->sw_hpd_irq_work);
> +
> +	if (dp->connector.base.dev)
> +		drm_connector_cleanup(&dp->connector.base);

[Severity: High]
Does calling drm_connector_cleanup() in cix_dp_bridge_detach() cause a
double cleanup when the DRM mode_config or an atomic state still holds a
reference to the connector?

cix_dp_connector_funcs sets .destroy =3D drm_connector_cleanup, so the
connector is reference-counted and cleaned up when its last reference is
dropped (such as during drm_mode_config_cleanup()).  Calling
drm_connector_cleanup() directly in cix_dp_bridge_detach() zeroes the
embedded struct drm_connector while references remain, leading to a
refcount underflow and a NULL connector->funcs->destroy dereference in
drm_connector_put().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109103010.1109=
11-1-Luo.Liu@cixtech.com?part=3D2
