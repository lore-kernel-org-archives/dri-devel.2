Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C74F606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gudNDYEC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5586810E3CB;
	Sat, 21 Nov 2026 08:08:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A4410E3CB
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 08:08:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0756C60DA8;
 Sat, 21 Nov 2026 08:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E811F000C6;
 Sat, 21 Nov 2026 08:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795248513;
 bh=3raE7u8WA73CEKC1arPbGq0UbR1DaFv/0W8Yfa/NNSg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gudNDYEClDBoqYsVwrw2cKPLBtfyUB9Kw6TPnG8C4WNAtnurIlAZ60nHmIbKGyjAl
 HRgm6cVFA/eqj7OAKt/lUn9GKb+mFFO0cucR2kC4HBSzsEeEnsWKbk4St6xI4tsPkm
 w+y+9zwMalKOLObRvEg0oa7acowA0xGylBpzzivCCgJnpNxUDoQFo+QXa1q1BnMunG
 HPIAWKUxeR6TdTMl6SIQnc28taFYEybm+/R6M6chObxmwj6lTmtsUfVS7QwotatJjU
 5XE3meqtYWm60CJDuVUE45eKHPkvvxoLsfNbrnHMk/0ApM7WLfFpneX3NqXPDWk1w+
 8OOO5vb/FZYLQ==
Message-ID: <sashiko-outbox-226820@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/17] drm/spacemit: add Innosilicon DP/eDP
 controller bridge driver
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org,
 olteanv@gmail.com
In-Reply-To: <20261121-k3-display-v3-12-ec419e8e96b8@gmail.com>
References: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
 <20261121-k3-display-v3-12-ec419e8e96b8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 08:08:32 +0000
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

Thank you for your contribution! Sashiko AI review found 13 potential
issues to consider:
- [High] drm/spacemit: missing pre-emphasis shift in
  spacemit_dp_link_apply_adjust()
- [High] drm/spacemit: reset in spacemit_dp_dev_init() desyncs cached
  PREPLL clk rate
- [Medium] drm/spacemit: broken HPD IRQ notify in
  spacemit_dp_hotplug_event_handler()
- [Medium] drm/spacemit: fallback caps in
  spacemit_dp_hw_read_sink_caps() block retry
- [Medium] drm/spacemit: missing hw disable in spacemit_dp_unregister()
  and bind()
- [Medium] drm/spacemit: missing spacemit_dp_hw_disable() on bind init
  failure
- [Medium] drm/spacemit: pixel clock truncation to MHz in TU and HBLANK
  calculation
- [Medium] drm/spacemit: unacknowledged level-high HPD IRQ in
  spacemit_dp_irq_handler()
- [Medium] drm/spacemit: unlocked dp->link and dp->dpcd reads in
  mode_valid and check
- [Medium] drm/spacemit: AUX registered before init and MPLL reset
  without hw_mutex
- [Medium] drm/spacemit: pixel PLL left powered down on untrained link
  in atomic_enable
- [Medium] drm/spacemit: nested AUX retries and fallback in
  spacemit_dp_aux_transfer()
- [Medium] drm/spacemit: spacemit_dp_remove() runs before devm AUX bus
  depopulation
--

commit a1a5915e82d2de32d9e2fe7095172a35686df3b2
Author: Cody Kang <codykang@vsit.ai>

drm/spacemit: add Innosilicon DP/eDP controller bridge driver

This commit adds the DRM bridge driver for the Innosilicon DisplayPort and
embedded DisplayPort controller downstream of the SpacemiT Saturn DPU.

> diff --git a/drivers/gpu/drm/spacemit/spacemit_inno_dp.c b/drivers/gpu/dr=
m/spacemit/spacemit_inno_dp.c
> new file mode 100644
> index 0000000000000..436e5f15b4039
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_inno_dp.c
[ ... ]
> +	ret =3D regmap_read_poll_timeout(dp->regs, DP_GENERAL_INTERRUPT, val,
> +				       val & DP_AUX_REPLY_EVENT_INT_STA,
> +				       SPACEMIT_DP_AUX_POLL_US,
> +				       SPACEMIT_DP_AUX_TIMEOUT_US);
> +	if (ret) {
> +		if (retries < SPACEMIT_DP_AUX_MAX_RETRIES) {
> +			retries++;
> +			spacemit_dp_aux_hw_reset(dp);
> +			dev_dbg(dp->dev,
> +				"AUX timeout, cmd=3D0x%x addr=3D0x%x size=3D%zu retry %d/%d\n",
> +				cmd, msg->address, msg->size, retries, SPACEMIT_DP_AUX_MAX_RETRIES);
> +			goto retry_eio;
> +		}
> +
> +		dev_err_ratelimited(dp->dev,
> +				    "AUX transfer timeout, req: 0x%x, cmd: 0x%x, addr: 0x%x, size %z=
u\n",
> +				    msg->request, cmd, msg->address, msg->size);
> +		return ret;
> +	}

[Severity: Medium]
Does retrying timed-out transfers inside spacemit_dp_aux_transfer() compound
with the DRM DP helpers and spacemit_dp_hw_read_sink_caps() to stall for
over two minutes under dp->mode_lock?

Each timed-out spacemit_dp_aux_transfer() call waits 4 * 200 ms (~813 ms).
drm_dp_dpcd_access() retries negative errors 32 times,
drm_dp_dpcd_read_data() falls back to a second 32-retry probe via
drm_dp_dpcd_readb(), and spacemit_dp_hw_read_sink_caps() loops
SPACEMIT_DP_SINK_READY_RETRIES (3) times, multiplying a single unresponsive
sink into 768 consecutive 200 ms timeouts (~156 seconds) while holding
dp->mode_lock or component bind locks.

This is also reachable on eDP during spacemit_dp_bind(), which checks
spacemit_dp_hw_detect_hpd() and calls spacemit_dp_hw_read_sink_caps() even
though DP_HPD_IN_STATUS is not meaningful on eDP and the panel is powered
off until atomic_pre_enable; when that read fails, the non-zero fallback
limits set by spacemit_dp_hw_read_sink_caps() prevent
spacemit_dp_bridge_atomic_enable() from re-reading DPCD once the panel is
powered.

[ ... ]

> +static void spacemit_dp_hw_read_sink_caps(struct spacemit_dp_dev *dp)
> +{
[ ... ]
> +	if (ret < 0) {
> +		drm_warn_ratelimited(dp->drm,
> +				     "failed to read DPCD after %d retries: %zd\n",
> +				     SPACEMIT_DP_SINK_READY_RETRIES, ret);
> +		dp->link.revision =3D DP_DPCD_REV_14;
> +		dp->link.max_rate =3D SPACEMIT_DP_LINK_RATE_5_40;
> +		dp->link.max_num_lanes =3D SPACEMIT_DP_LANE_2;
> +		dp->link.enhanced_framing =3D 1;
> +		return;
> +	}

[Severity: Medium]
Does populating non-zero fallback values in dp->link.max_rate and
dp->link.max_num_lanes when spacemit_dp_hw_read_sink_caps() fails prevent
spacemit_dp_bridge_atomic_enable() from retrying the DPCD read?

spacemit_dp_bridge_atomic_enable() only retries spacemit_dp_hw_read_sink_ca=
ps()
when !dp->link.max_rate || !dp->link.max_num_lanes.  If an earlier DPCD read
at bind or detect time fails (for example, on eDP during spacemit_dp_bind()
when noisy DP_HPD_IN_STATUS reads high before the panel is powered, or on a
slow-waking monitor), max_rate and max_num_lanes are set to 5.4 Gbps and 2
lanes while dp->dpcd remains zeroed or stale.  The enable-time retry is then
skipped, clamping 4-lane panels or monitors to 2 lanes and running link
training without valid dp->dpcd capability bytes (such as TPS3 support).

[ ... ]

> +static int spacemit_dp_link_apply_adjust(struct spacemit_dp_dev *dp,
> +					 const u8 *link_status,
> +				    enum spacemit_dp_lane_count lanes,
> +				    u8 *training_set)
> +{
> +	union phy_configure_opts opts =3D {
> +		.dp =3D {
> +			.lanes =3D lanes,
> +			.set_voltages =3D true,
> +		},
> +	};
> +	int i, ret;
> +
> +	for (i =3D 0; i < lanes; i++) {
> +		u8 v =3D drm_dp_get_adjust_request_voltage(link_status, i);
> +		u8 p =3D drm_dp_get_adjust_request_pre_emphasis(link_status, i);
> +		u8 v_bits;
> +
> +		if (v >=3D SPACEMIT_DP_SWING_MAX)
> +			v =3D SPACEMIT_DP_SWING_MAX;
> +		if (p >=3D SPACEMIT_DP_PREEMP_MAX)
> +			p =3D SPACEMIT_DP_PREEMP_MAX;
> +
> +		opts.dp.voltage[i] =3D v;
> +		opts.dp.pre[i] =3D p;
> +
> +		v_bits =3D v;
> +		if (v =3D=3D SPACEMIT_DP_SWING_MAX)
> +			v_bits |=3D DP_TRAIN_MAX_SWING_REACHED;
> +		if (p =3D=3D SPACEMIT_DP_PREEMP_MAX)
> +			v_bits |=3D DP_TRAIN_MAX_PRE_EMPHASIS_REACHED;
> +
> +		training_set[i] =3D v_bits | (p << DP_TRAIN_PRE_EMPHASIS_SHIFT);
> +	}

[Severity: High]
Isn't the return value of drm_dp_get_adjust_request_pre_emphasis() already
shifted left by DP_TRAIN_PRE_EMPHASIS_SHIFT (3)?

For pre-emphasis levels 1, 2 and 3, drm_dp_get_adjust_request_pre_emphasis()
returns 8, 16 and 24.  Comparing p >=3D SPACEMIT_DP_PREEMP_MAX (2) without
shifting right by DP_TRAIN_PRE_EMPHASIS_SHIFT first causes any request for
pre-emphasis level 1 to be clamped to level 2, marked with
DP_TRAIN_MAX_PRE_EMPHASIS_REACHED, and shifted a second time when building
training_set[i].

[ ... ]

> +static void spacemit_dp_hw_set_msa_and_enable_video(struct spacemit_dp_d=
ev *dp,
> +						    const struct drm_display_mode *mode,
> +						    enum spacemit_dp_link_rate rate,
> +						    enum spacemit_dp_lane_count lanes)
> +{
> +	u64 hb_num;
> +	u32 link_rate;
> +	u32 fp; /* Pixel clock in MHz */
> +	u32 tu, tu_frac, tu_int, rd_thres;
> +	u32 hsync_len, hstart, vstart;
> +
> +	/* mode->clock unit is kHz, fp unit is MHz */
> +	fp =3D mode->clock / 1000;
> +
> +	if (fp =3D=3D 0)
> +		fp =3D 1; /* Prevent division by zero */
> +
> +	/*
> +	 * HBlank interval =3D (htotal - hactive) * (LinkSymbolClock / 4) /
> +	 * PixelClock, where LinkSymbolClock =3D LinkRate * 100 (1.62G -> 162MH=
z).
> +	 * rate is in kbit/s, so link_rate =3D rate / 10000 gives the 162, 270,
> +	 * 540 form used below.
> +	 */
> +	link_rate =3D rate / 10000;
> +
> +	/* Multiply before dividing: hb_num =3D hblank * (link_rate / 4) / fp */
> +	hb_num =3D (u64)(mode->htotal - mode->hdisplay) * link_rate;
> +	do_div(hb_num, 4 * fp);
> +
> +	/* Transfer unit: tu =3D fp * bpp * 640 / (8 * lanes * link_rate) */
> +	tu =3D div_u64((u64)fp * SPACEMIT_DP_BPP * 640, 8 * lanes * link_rate);

[Severity: Medium]
Does truncating mode->clock to integer MHz in fp underestimate the transfer
unit size for fractional-MHz pixel clocks?

spacemit_dp_set_plls() programs dp->pll_clk to mode->clock * 1000 Hz, so a
1080p60 mode runs at 148.5 MHz (and 720p60 at 74.25 MHz), whereas
fp =3D mode->clock / 1000 truncates those clocks to 148 MHz and 74 MHz.  For
1080p60 on 2 lanes at 2.7 Gbps, this programs a TU of 52.6 instead of 52.8,
packing fewer bytes per TU than the pixel clock delivers into the video
FIFO.  Using mode->clock in kHz and rate / 10 directly avoids the
truncation.

[ ... ]

> +static enum drm_mode_status
> +spacemit_dp_bridge_mode_valid(struct drm_bridge *bridge,
> +			      const struct drm_display_info *info,
> +			 const struct drm_display_mode *mode)
> +{
> +	struct spacemit_dp_dev *dp =3D container_of(bridge,
> +						  struct spacemit_dp_dev,
> +						  bridge);
> +	unsigned int max_link_rate, max_lanes;
> +	u64 max_bw, req_bw;
> +
> +	/*
> +	 * Prefer the link limits the driver maintains: they start as the
> +	 * sink's capabilities clamped to the PHY and are narrowed after a
> +	 * failed training. drm_dp_max_link_rate() is in 10 kbit/s.
> +	 */
> +	if (dp->link.max_rate && dp->link.max_num_lanes) {
> +		max_link_rate =3D dp->link.max_rate / 10;
> +		max_lanes =3D dp->link.max_num_lanes;
> +	} else {
> +		max_link_rate =3D min_t(unsigned int,
> +				      drm_dp_max_link_rate(dp->dpcd),
> +				      SPACEMIT_DP_SOURCE_MAX_RATE / 10);
> +		max_lanes =3D drm_dp_max_lane_count(dp->dpcd);
> +	}

[Severity: Medium]
Can spacemit_dp_bridge_mode_valid() and spacemit_dp_bridge_atomic_check()
race with concurrent updates to dp->link and dp->dpcd?

spacemit_dp_hw_read_sink_caps() and spacemit_dp_link_narrow() update
dp->dpcd, dp->link.max_rate and dp->link.max_num_lanes under dp->mode_lock
from the hotplug IRQ thread (spacemit_dp_hotplug_event_handler()) and from
non-blocking atomic commits (spacemit_dp_bridge_atomic_enable()), neither of
which holds the DRM modeset locks.  Reading those fields in
spacemit_dp_bridge_mode_valid() and spacemit_dp_bridge_atomic_check()
without dp->mode_lock can observe a torn rate/lane pair or partially read
dp->dpcd bytes.

[ ... ]

> +	for (trained =3D false, i =3D start;
> +	     i < ARRAY_SIZE(spacemit_dp_link_priority_table); i++) {
> +		u32 capacity;
> +
> +		cfg =3D &spacemit_dp_link_priority_table[i];
> +
> +		/* Source and sink limits */
> +		if (cfg->rate > dp->link.max_rate || cfg->lanes > dp->link.max_num_lan=
es)
> +			continue;
> +
> +		/* Bandwidth requirement */
> +		capacity =3D spacemit_dp_calc_link_capacity(cfg->rate,
> +							  cfg->lanes);
> +		if (capacity < req_bw)
> +			continue;
> +
> +		drm_dbg(dp->drm, "trying link config: rate %d lanes %d (capacity %d, r=
equired %d)\n",
> +			cfg->rate, cfg->lanes, capacity, req_bw);
> +
> +		spacemit_dp_link_disable(dp);
> +
> +		/* Apply Hardware Settings */
> +		if (spacemit_dp_set_plls(dp, cfg->rate, adjusted_mode->clock))
> +			continue;
> +
> +		if (spacemit_dp_phy_set_lanes(dp, cfg->lanes))
> +			continue;
> +
> +		if (spacemit_dp_phy_on(dp))
> +			continue;
[ ... ]
> +	/*
> +	 * The DPU's pixel clock comes from the PHY PLL, so scanning out into an
> +	 * untrained link never reaches CFG_RDY and wedges the CRTC on
> +	 * flip_done.
> +	 */
> +	if (!trained) {

[Severity: Medium]
Can the !trained path in spacemit_dp_bridge_atomic_enable() return with the
PHY pixel PLL powered down and stall the DPU commit?

When dp->link.max_rate or dp->link.max_num_lanes was 0 during atomic_check()
and the enable-time DPCD read yields limits below req_bw, every entry in
spacemit_dp_link_priority_table is skipped before spacemit_dp_set_plls() or
spacemit_dp_phy_on() is called, leaving the PHY powered off from
spacemit_dp_bind() or spacemit_dp_bridge_atomic_disable().  The same happens
if spacemit_dp_set_plls(), spacemit_dp_phy_set_lanes() or
spacemit_dp_phy_on() fails after spacemit_dp_link_disable().  Because the
DPU gets its pixel clock from dp->pll_clk, returning with PREPLL powered
down prevents the DPU from latching CFG_RDY and stalls
drm_atomic_helper_wait_for_flip_done() until the 3000 ms
SATURN_CFG_RDY_TIMEOUT_MS timeout expires.

[ ... ]

> +static irqreturn_t spacemit_dp_irq_handler(int irq, void *data)
> +{
> +	struct spacemit_dp_dev *dp =3D data;
> +	irqreturn_t ret =3D IRQ_NONE;
> +	int idx;
> +
> +	if (!drm_dev_enter(dp->drm, &idx))
> +		return IRQ_NONE;

[Severity: Medium]
What happens if a level-high HPD interrupt fires after drm_dev_unplug()
during master unbind?

In spacemit_drm_master_unbind(), drm_dev_unplug() runs before
drm_kms_helper_poll_fini(), drm_atomic_helper_shutdown() and
component_unbind_all().  Once drm_dev_unplug() marks the device unplugged,
drm_dev_enter() in spacemit_dp_irq_handler() returns false and the handler
exits with IRQ_NONE without calling spacemit_dp_hw_clean_hpd() to clear the
level-triggered interrupt latch, causing a hardirq storm until
spacemit_dp_unbind() calls disable_irq().

[ ... ]

> +static irqreturn_t spacemit_dp_hotplug_event_handler(int irq, void *data)
> +{
> +	struct spacemit_dp_dev *dp =3D data;
> +	enum drm_connector_status status;
> +	int idx;
> +
> +	if (!drm_dev_enter(dp->drm, &idx))
> +		return IRQ_HANDLED;
> +
> +	/*
> +	 * .detect() owns mode_lock and re-reads the sink caps on a fresh plug
> +	 */
> +	status =3D spacemit_dp_bridge_detect(&dp->bridge, dp->connector);
> +	drm_bridge_hpd_notify(&dp->bridge, status);
> +
> +	drm_dev_exit(idx);
> +	return IRQ_HANDLED;
> +}

[Severity: Medium]
Does drm_bridge_hpd_notify() ever notify DRM on external DisplayPort
hotplug interrupts?

In spacemit_dp_probe(), external DP sets dp->bridge.ops to
DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID without DRM_BRIDGE_OP_HPD.
Because drm_bridge_connector_init() only registers an HPD callback on a
bridge with DRM_BRIDGE_OP_HPD set, dp->bridge.hpd_cb is NULL and
drm_bridge_hpd_notify() is a no-op.  Moreover, calling
spacemit_dp_bridge_detect() here updates dp->connector_status without
updating dp->connector->status, so an unplug-and-replug while the pixel
clock is running between 10-second poll intervals leaves both statuses as
connector_status_connected and drops the hotplug event and EDID re-read.

[ ... ]

> +static int spacemit_dp_dev_init(struct spacemit_dp_dev *dp)
> +{
[ ... ]
> +	/* Reset Controller and PHY */
> +	regmap_write_bits(dp->regs, DP_SOFT_RESET, DP_CONTROLLER_RESET,
> +			  FIELD_PREP(DP_CONTROLLER_RESET, 0x1));
> +	regmap_write_bits(dp->regs, DP_SOFT_RESET, DP_PHY_RESET,
> +			  FIELD_PREP(DP_PHY_RESET, 0x1));
> +	regmap_write_bits(dp->regs, DP_SOFT_RESET, DP_HDCP_RESET,
> +			  FIELD_PREP(DP_HDCP_RESET, 0x1));
> +	regmap_write_bits(dp->regs, DP_SOFT_RESET, DP_AUX_RESET,
> +			  FIELD_PREP(DP_AUX_RESET, 0x1));
> +	regmap_write_bits(dp->regs, DP_SOFT_RESET, DP_VIDEO_RESET,
> +			  FIELD_PREP(DP_VIDEO_RESET, 0x1));
> +	usleep_range(5000, 8000);
[ ... ]
> +	ret =3D spacemit_dp_set_plls(dp, SPACEMIT_DP_LINK_RATE_2_70, 148500);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D spacemit_dp_phy_set_lanes(dp, SPACEMIT_DP_LANE_2);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D spacemit_dp_phy_on(dp);
> +	if (ret)
> +		return ret;

[Severity: High]
When spacemit_dp_dev_init() runs a second time in spacemit_dp_bind() on eDP
(or on component rebind), does pulsing DP_PHY_RESET wipe the PREPLL
registers while clk_set_rate(dp->pll_clk, 148500000) short-circuits in the
clock framework?

On eDP, spacemit_dp_probe() calls spacemit_dp_dev_init(), which programs
dp->pll_clk to 148.5 MHz, and the PHY clock provider caches that rate.  When
spacemit_dp_bind() calls spacemit_dp_dev_init() again, asserting
DP_PHY_RESET resets the shared PHY PREPLL registers back to hardware
defaults, but clk_set_rate(dp->pll_clk, 148500000) sees that the requested
rate matches the cached rate and returns without calling the PHY clock's
.set_rate callback.  spacemit_dp_phy_on() (and later atomic_enable() for any
148.5 MHz mode) then tries to lock an unprogrammed PREPLL.

[ ... ]

> +static int spacemit_dp_bind(struct device *dev, struct device *master,
> +			    void *data)
> +{
> +	struct spacemit_dp_dev *dp =3D dev_get_drvdata(dev);
> +	struct drm_device *drm =3D data;
> +	struct device_node *ep;
> +	int ret;
> +
> +	dp->drm =3D drm;
> +	dp->aux.drm_dev =3D drm;
> +	ret =3D drm_dp_aux_register(&dp->aux);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to register DP AUX\n");
> +		goto err_drm;
> +	}
[ ... ]
> +	ret =3D spacemit_dp_dev_init(dp);
> +	if (ret)
> +		goto err_encoder;

[Severity: Medium]
Can userspace AUX or DDC transactions race with spacemit_dp_dev_init() and
spacemit_dp_set_plls()?

spacemit_dp_bind() calls drm_dp_aux_register(&dp->aux) before
spacemit_dp_dev_init(dp), exposing /dev/drm_dp_aux* and the I2C adapter
before the controller is initialized on external DP and while
spacemit_dp_dev_init() powers down MPLL and asserts DP_CONTROLLER_RESET,
DP_PHY_RESET and DP_AUX_RESET without holding dp->aux.hw_mutex.  Similarly,
in spacemit_dp_bridge_atomic_enable(), spacemit_dp_link_disable() releases
dp->aux.hw_mutex before spacemit_dp_set_plls() power-cycles the MPLL that
supplies the 16 MHz AUX reference clock.

[Severity: Medium]
If spacemit_dp_dev_init() fails here in spacemit_dp_bind(), should the error
path call spacemit_dp_hw_disable(dp) the way spacemit_dp_probe() does?

spacemit_dp_dev_init() enables interrupt masks and powers up the MPLL and
PREPLL in spacemit_dp_set_plls() before calling spacemit_dp_phy_set_lanes()
and spacemit_dp_phy_on().  Jumping to err_encoder on failure leaves the
PLLs powered on, and because dp->component_added is true while bind failed,
a later spacemit_dp_remove() will not run spacemit_dp_unbind() or
spacemit_dp_hw_disable() either.

[ ... ]

> +/* Leave the DRM device, or power down a controller that never joined on=
e. */
> +static void spacemit_dp_unregister(struct spacemit_dp_dev *dp)
> +{
> +	if (dp->component_added)
> +		component_del(dp->dev, &spacemit_dp_ops);
> +	else
> +		spacemit_dp_hw_disable(dp);
> +}

[Severity: Medium]
Does spacemit_dp_unregister() leave the hardware powered on when
dp->component_added is true but the component master was never bound?

On eDP, spacemit_dp_probe() powers up the MPLL and analog TX blocks via
spacemit_dp_dev_init() and spacemit_dp_edp_link_panel() sets
dp->component_added =3D true.  If the driver is removed while the aggregate
DRM device is unbound (or if spacemit_dp_dev_init() failed during
spacemit_dp_bind()), component_del() does not invoke spacemit_dp_unbind(),
and the if (dp->component_added) branch skips spacemit_dp_hw_disable(dp).
Calling spacemit_dp_hw_disable(dp) unconditionally after component_del()
would ensure the PLLs and TX blocks are always powered down.

[ ... ]

> +	ret =3D devm_of_dp_aux_populate_bus(&dp->aux, spacemit_dp_edp_link_pane=
l);
> +	if (ret) {
> +		spacemit_dp_unregister(dp);
> +		return dev_err_probe(dev, ret,
> +				     "eDP: failed to populate aux-bus panel\n");
> +	}
> +
> +	return 0;
> +
> +err_disable_pxclk:
> +	clk_disable_unprepare(dp->pxclk);
> +	return ret;
> +}
> +
> +static void spacemit_dp_remove(struct platform_device *pdev)
> +{
> +	spacemit_dp_unregister(platform_get_drvdata(pdev));
> +}

[Severity: Medium]
On eDP, does spacemit_dp_remove() tear down the component and power down the
controller before devres depopulates the AUX bus?

devm_of_dp_aux_populate_bus() registers of_dp_aux_depopulate_bus_void() as a
devres action, which runs during devres_release_all() after
spacemit_dp_remove() returns.  During driver unbind, spacemit_dp_remove()
powers down the controller while the AUX-bus child panel device is still
registered, and a deferred panel probe completing in that window can still
invoke spacemit_dp_edp_link_panel() -> component_add() after
spacemit_dp_unregister() has already run:

CPU0                                  CPU1 (deferred_probe_work_func)
__device_release_driver()
  spacemit_dp_remove()
    spacemit_dp_unregister()
      /* dp->component_added is false */
      spacemit_dp_hw_disable()
                                      panel_edp_probe()
                                        spacemit_dp_edp_link_panel()
                                          component_add(dp->dev, ...)
  devres_release_all()
    of_dp_aux_depopulate_bus_void()
    /* dp freed while component remains registered */

Depopulating the AUX bus in spacemit_dp_remove() before
spacemit_dp_unregister() (or registering spacemit_dp_unregister() as a devm
action prior to devm_of_dp_aux_populate_bus()) avoids this ordering
inversion.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-k3-display=
-v3-0-ec419e8e96b8@gmail.com?part=3D12
