Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3509CC5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EF4010E687;
	Mon, 10 Aug 2026 06:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iEjnHm9y";
	dkim-atps=neutral
Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 171BE10E037
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 12:51:12 +0000 (UTC)
Received: by mail-pj2-f9.google.com with SMTP id
 98e67ed59e1d1-38ed4d37526so362499a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 05:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786193471; x=1786798271; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OlRrA389d9FWYi8l3Quvar4ELxprzGoBLCcCx6MN668=;
 b=iEjnHm9yWuypE0vwIYZKc3eznlf2xvOs8jQX0VkZVC6mpe0FuYe4VSj/QwrXo+QQ4Y
 t+XVBTFml/WfSOWf475TIfWP1qTWQHmJYqVazZOQfTmFBm274aUnQTLCxbCT5UInFndW
 U9v/mrfeoiIQns+/KE819DrTZDZhKDJKH3w0o0L7krNhuHnd7+AWKz4mfVtjjkebkHkD
 KvygcaVa6otclSVvmkl0aJny7vdnekIsDv5LVe6BbPCc8JGdH/FCRgSSLVZPoJrD/1Fk
 Tinm07/ERLeRXEoGoTlCExdJjNMkIMtIKp796NxPEvDMmn48oLIzdMzyEap2Q2bwO+cI
 LkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786193471; x=1786798271;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OlRrA389d9FWYi8l3Quvar4ELxprzGoBLCcCx6MN668=;
 b=L9nXt+IsJ4ebHwtpovIMOkAfhCjqqLEyE+Xum79DXqKcsbHViGPM1SNBOxerbv1E+S
 M1BhVsb/sf4tC5tAwHhqLWIMUeyTWEGRQ5BFyKPCSSv+C8Umo6Plg3VNJkqeJjqvKSnq
 +fzMWY0b3Pf0GI9nGofYk+2NuIYetOGR0WsIQQUZG7nrWOWtxN5maNLVS3oCfUg0WGrw
 dIltX4v7DNmMmWRW1GuifV4uV9ymtfpz1SdKBQX+4s6SxnYIIdiIsjCkK//hZlwhmVaF
 Lzn9Ebz5FXly+Rts9L69eOyuF9vK3PaZkFZ1FTHwYdvDRo+S6TxNRlDwgNKi8tR+/BP4
 MNnw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqz+wtloSKZPrswbi7GISxw8Q4aVBAevPntY2zKXzO4VCxEPZ/UvHcLpyIm6YC8gw5Uqz5PlSS5szk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwX2vUzIrmYKqtjGIMVhl79uv43URslWMLuXHgWN7o1BEqbUAgB
 yFTgFG5F+xxxfBRfr2gkSs82HTAa/nmWUoimPXRNORB0xRCG3p77I+QB
X-Gm-Gg: AR+sD11KXjMXBtL6p45STSo0QxykkYpnEYRNFowQ5G4QZmdYLWHUZnaMQITbMJnLDRw
 +zfjx5eaLsU4w+RNuR00niu5M/VWkjsO5t+U024mbn9+R98mjL3QuTwfjolcDhxB8S9lTh8UGKR
 l6ZMljMcc1wX4b/tvlFuZRS52RPq83tnt4AkuSI7DHoHvo1EorBJV4R09gsKJmEEHAfIYyIozj+
 2/1oQO+7OSxYOwU66aGJMYvCqm3phYcC+03u/SSqJXk+NifoghAa4EiocKqCmmQ+/tyfZVTVJYa
 GqMEGX6JS+ovaLVz4yh24RrWvXJ0LrpXKcsGEbWjkE1vB6XxDCe1nCF4Kyj4gGBPEoAEQw8QESj
 34J+99M/DsLYjTGBQ8iU11o+OY0cjYpBTTWz5dtaJy/PJpAJTqCq7hpyoi1k09KlCgddtzodxBR
 s1nDBKir8KJwA1yNpdH1mIK0jj2ssaz71xZ4FlKmI=
X-Received: by 2002:a05:6a21:6f15:b0:3ab:2fa:756c with SMTP id
 adf61e73a8af0-3cbce6cb53bmr8991053637.1.1786193471349; 
 Sat, 08 Aug 2026 05:51:11 -0700 (PDT)
Received: from localhost ([2403:2c80:17:1e::20db])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f35b0c3sm1846702a12.15.2026.08.08.05.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 05:51:10 -0700 (PDT)
Date: Sat, 08 Aug 2026 20:51:07 +0800
Message-ID: <b0499978adf9f603e5da621f0056a139.codykang.hk@gmail.com>
From: Cody Kang <codykang.hk@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: neil.armstrong@linaro.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 robh@kernel.org, linux-phy@lists.infradead.org, olteanv@gmail.com,
 dri-devel@lists.freedesktop.org, vkoul@kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 12/17] drm/spacemit: add Innosilicon DP/eDP
 controller bridge driver
In-Reply-To: <20260725050438.302CF1F000E9@smtp.kernel.org>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-12-6de34d80e86c@gmail.com>
 <20260725050438.302CF1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sat, 25 Jul 2026 05:04:37 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 11 potential issue(s) to consider:
> - [High] Custom EDID read function bypasses DRM core and breaks I2C repeated-start (MOT) rules, corrupting EDID reads for blocks > 0 or on active adapters.
> - [High] The hardirq handler returns `IRQ_NONE` after clearing hardware interrupt flags, permanently disabling the IRQ line.
> - [High] Late attachment of the eDP panel bridge violates drm_bridge_connector architecture and breaks panel support if the panel probes asynchronously.
> - [High] DP Transfer Unit (TU) miscalculation due to pixel clock truncation.
> - [High] The IRQ handler returns `IRQ_NONE` without clearing the hardware interrupt when `drm_dev_enter()` fails, leading to an interrupt storm.
> - [High] `spacemit_dp_bridge_atomic_create_state` returns an error pointer instead of `NULL` on allocation failure, causing a kernel crash in the DRM core.
> - [High] The hardirq handler calls regmap functions which use a sleepable lock on PREEMPT_RT.
> - [Medium] The atomic_check and mode_valid callbacks access DPCD link capabilities without holding mode_lock, leading to data races with the hotplug IRQ handler.
> - [Medium] The DP IRQ handler silently drops hotplug notifications because drm_bridge_hpd_notify() is a no-op when DRM_BRIDGE_OP_HPD is omitted.
> - [Medium] Calling clk_set_parent() on an already enabled clock.
> - [Medium] Resetting the AUX controller without holding aux->hw_mutex races with concurrent AUX transfers.
> --
>
> --- Patch [12]: [PATCH RESEND 12/17] drm/spacemit: add Innosilicon DP/eDP controller bridge driver ---
> commit b7eace372254ab27e120213d38c3a656b2a195b8
> Author: Cody Kang <codykang.hk@gmail.com>
>
> drm/spacemit: add Innosilicon DP/eDP controller bridge driver
>
> Add the DP/eDP controller that sits downstream of the Saturn DPU. Two
> identical instances share one compatible; the eDP-vs-DP role is board
> wiring, so it is taken from the devicetree.
>
> > diff --git a/drivers/gpu/drm/spacemit/spacemit_inno_dp.c b/drivers/gpu/drm/spacemit/spacemit_inno_dp.c
> > index 0000000000000..e88731d9b18bf
> > --- /dev/null
> > +++ b/drivers/gpu/drm/spacemit/spacemit_inno_dp.c
> > @@ -248,16 +248,10 @@
> >  static inline struct spacemit_dp_bridge_state *
> >  to_spacemit_dp_bridge_state(struct drm_bridge_state *state)
> >  {
> >  	return container_of(state, struct spacemit_dp_bridge_state, base);
> >  }
> >
> >  static const struct regmap_config spacemit_dp_regmap_config = {
> >  	.name		= "dp",
> >  	.reg_bits	= 32,
> >  	.val_bits	= 32,
> >  	.reg_stride	= 4,
> >  	.max_register	= 0x3ffc,	/* full 0x4000 reg region from binding */
> >  };
>
> [Severity: High]
> Is it safe to omit use_raw_spinlock from the regmap configuration? Because
> this is not set to true, the regmap defaults to a sleepable lock on
> PREEMPT_RT. This causes a BUG when regmap read/write functions are called
> from the hardirq handler spacemit_dp_irq_handler().

The handler is force-threaded on PREEMPT_RT (no IRQF_NO_THREAD), so
the regmap spinlock is fine there.

> > [ ... ]
> > @@ -661,16 +661,10 @@
> >  static void spacemit_dp_link_disable(struct spacemit_dp_dev *dp)
> >  {
> >  	regmap_write_bits(dp->regs, DP_VIDEO_VSAMPLE_REG,
> >  			  DP_VIDEO_STREAM_ENABLE,
> >  			  FIELD_PREP(DP_VIDEO_STREAM_ENABLE, 0));
> >  	spacemit_dp_phy_off(dp);
> >
> >  	regmap_write_bits(dp->regs, DP_SOFT_RESET, DP_AUX_RESET,
> >  			  FIELD_PREP(DP_AUX_RESET, 0x1));
>
> [Severity: Medium]
> Could this reset corrupt concurrent AUX transfers? Modifying the AUX
> hardware in spacemit_dp_link_disable() without holding the aux->hw_mutex
> could race against a userspace or deferred transfer, potentially wedging
> the controller.

All driver-internal AUX users serialize on mode_lock; the EDID
rework below also serializes with the userspace i2c node.

> > [ ... ]
> > @@ -936,15 +936,10 @@
> >  static void spacemit_dp_hw_set_msa_and_enable_video(struct spacemit_dp_dev *dp,
> >  						    const struct drm_display_mode *mode,
> >  					       enum spacemit_dp_link_rate rate,
> >  					       enum spacemit_dp_lane_count lanes,
> >  		u32 color_format)
> >  {
> >  	u64 hb_num;
> >  	u32 link_rate;
> >  	u32 fp; /* Pixel clock in MHz */
> >  	u32 bpp, misc0;
> >  	u32 tu, tu_frac, tu_int, rd_thres;
> >  	u32 hsync_len;
> >
> >  	/* mode->clock unit is kHz, fp unit is MHz */
> >  	if (dp->use_ext_pixel_clock)
> >  		fp = dp->pixel_clock / 1000;
> >  	else
> >  		fp = mode->clock / 1000;
>
> [Severity: High]
> Can this truncation of the pixel clock to an integer MHz value cause DP
> FIFO underflows or overflows? For non-integer MHz pixel clocks like
> 148.5 MHz, this truncates to 148, introducing precision errors in the
> Transfer Unit (TU) calculations which results in corrupted video.

The values are vendor-faithful and board-proven at 4K; computing in
kHz is a possible later refinement, not a v2 change.

> > [ ... ]
> > @@ -1286,13 +1286,10 @@
> >  static int spacemit_dp_conn_get_edid_block(void *data, u8 *buf,
> >  					   unsigned int block, size_t len)
> >  {
> >  	struct spacemit_dp_dev *dp = data;
> >  	unsigned int start = block * EDID_LENGTH;
> >  	u8 segment = block >> 1;
> >  	int ret, retry;
> >  	size_t offset;
> >
> >  	if (segment) {
> >  		for (retry = 0; retry < 3; retry++) {
> >  			ret = spacemit_dp_aux_i2c_write(dp,
> >  				SPACEMIT_DP_DDC_SEGMENT_ADDR, &segment, 1);
>
> [Severity: High]
> Does this custom EDID read function bypass the Middle-Of-Transaction (MOT)
> rules for I2C repeated-start? Issuing writes and reads without the MOT flag
> resets the DDC segment pointer to 0, breaking EDID reads for displays with
> multiple EDID blocks (block >= 1) or on active adapters.

Will rework in v2: the custom reader becomes one i2c_transfer per
block on the aux I2C adapter, so the DP I2C-over-AUX core chains
segment, offset and data with MOT, and 3+ block EDIDs work.

> > [ ... ]
> > @@ -1632,15 +1632,10 @@
> >  static int spacemit_dp_bridge_atomic_check(struct drm_bridge *bridge,
> >  					   struct drm_bridge_state *bridge_state,
> >  				      struct drm_crtc_state *crtc_state,
> >  				      struct drm_connector_state *conn_state)
> >  {
> >  	struct spacemit_dp_dev *dp = container_of(bridge,
> >  						  struct spacemit_dp_dev,
> >  						  bridge);
> >  	struct spacemit_dp_bridge_state *st =
> >  			to_spacemit_dp_bridge_state(bridge_state);
> >  	const struct drm_display_mode *mode = &crtc_state->adjusted_mode;
> >  	int bpp;
> >  	u32 req_bw;
> >  	int i;
> >
> >  	/* A single output bus format, see ->atomic_get_output_bus_fmts(). */
> >  	st->color_format = SOC_VIDEO_RGB_8BIT;
> >  	bpp = spacemit_dp_get_bpp(dp, st->color_format);
> >  	req_bw = spacemit_dp_calc_required_bw(mode, bpp);
> >
> >  	/* No caps yet: leave idx unset and let ->atomic_enable() retry. */
> >  	if (!dp->link.max_rate || !dp->link.max_num_lanes) {
>
> [Severity: Medium]
> Could reading the DPCD link capabilities here race with the hotplug IRQ
> handler? Accessing the dp->link capabilities in
> spacemit_dp_bridge_atomic_check() without holding mode_lock might observe
> intermediate or torn states if a concurrent interrupt triggers a capability
> re-read, leading to transient rejections of valid modes.

detect(), enable and the EDID paths all serialize on mode_lock.

> > [ ... ]
> > @@ -1705,10 +1705,10 @@
> >  static struct drm_bridge_state *
> >  spacemit_dp_bridge_atomic_create_state(struct drm_bridge *bridge)
> >  {
> >  	struct spacemit_dp_bridge_state *new;
> >
> >  	new = kzalloc_obj(*new);
> >  	if (!new)
> >  		return ERR_PTR(-ENOMEM);
>
> [Severity: High]
> Should this return NULL on allocation failure instead of an error pointer?
> The DRM core's reset helper assigns the returned state directly without
> checking for errors. Returning an error pointer here causes a fatal page
> fault when the DRM core later dereferences it.

ERR_PTR is what the bridge core expects here;
drm_bridge_atomic_create_priv_state() checks IS_ERR().

> > [ ... ]
> > @@ -1742,16 +1742,10 @@
> >  static int spacemit_dp_edp_link_panel(struct drm_dp_aux *aux)
> >  {
> >  	struct spacemit_dp_dev *dp = container_of(aux, struct spacemit_dp_dev,
> >  						  aux);
> >  	struct drm_bridge *next;
> >  	int ret;
> >
> >  	next = devm_drm_of_get_bridge(dp->dev, dp->dev->of_node, 1, 0);
> >  	if (IS_ERR(next))
> >  		return PTR_ERR(next);
> >
> >  	dp->next_bridge = next;
> >
> >  	/*
> >  	 * A non-NULL bridge.encoder means .attach already ran: late-chain
> >  	 * panel-edp.
> >  	 */
> >  	if (dp->bridge.encoder) {
> >  		ret = drm_bridge_attach(dp->bridge.encoder, next,
> >  					&dp->bridge,
> >  					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>
> [Severity: High]
> Does dynamically attaching the panel bridge late bypass connector
> initialization? If the eDP panel defers its probe,
> drm_bridge_connector_init() builds the connector without the panel bridge.
> Attaching it here later violates the drm_bridge_connector architecture and
> breaks panel support, because the connector will lack the panel's mode or
> EDID operations.

Handled by design: the aux-bus done-probing callback late-chains
with DRM_BRIDGE_ATTACH_NO_CONNECTOR and re-fires detection; both
probe orders are exercised on hardware. See the comment above
spacemit_dp_edp_link_panel().

> > [ ... ]
> > @@ -1782,10 +1782,10 @@
> >  static irqreturn_t spacemit_dp_irq_handler(int irq, void *data)
> >  {
> >  	struct spacemit_dp_dev *dp = data;
> >  	irqreturn_t ret = IRQ_NONE;
> >  	int idx;
> >
> >  	if (!drm_dev_enter(dp->drm, &idx))
> >  		return IRQ_NONE;
>
> [Severity: High]
> Will returning IRQ_NONE here without clearing the hardware interrupt cause
> an interrupt storm? If an interrupt fires while the DRM device is
> unregistered (such as during module unload), the handler exits without
> acknowledging the hardware interrupt, causing it to continuously fire and
> stall the CPU.

Only reachable during unbind while the line is being torn down.

> > [ ... ]
> > @@ -1796,11 +1796,10 @@
> >  	/*
> >  	 * Only compare here: the authoritative connector_status update
> >  	 * happens in the thread under mode_lock, via .detect().
> >  	 */
> >  	if (spacemit_dp_hw_detect_hpd(dp) != READ_ONCE(dp->connector_status))
> >  		ret = IRQ_WAKE_THREAD; /* Call hotplug_event */
> >  	spacemit_dp_hw_clean_hpd(dp);
> >
> >  	drm_dev_exit(idx);
> >  	return ret;
> >  }
>
> [Severity: High]
> Is it safe to return IRQ_NONE after clearing the hardware interrupt flags?
> If the logical state has not changed (e.g. from a transient hardware
> glitch), returning IRQ_NONE causes the kernel's spurious interrupt detector
> to eventually disable the IRQ line, which results in all future hotplug
> events being permanently missed.

Real; will return IRQ_HANDLED in v2 when a latched HPD event was
consumed.

> > [ ... ]
> > @@ -1813,11 +1813,10 @@
> >  static irqreturn_t spacemit_dp_hotplug_event_handler(int irq, void *data)
> >  {
> >  	struct spacemit_dp_dev *dp = data;
> >  	enum drm_connector_status status;
> >  	int idx;
> >
> >  	if (!drm_dev_enter(dp->drm, &idx))
> >  		return IRQ_HANDLED;
> >
> >  	/*
> >  	 * .detect() owns mode_lock and re-reads the sink caps on a fresh plug
> >  	 */
> >  	status = spacemit_dp_bridge_detect(&dp->bridge, dp->connector);
> >  	drm_bridge_hpd_notify(&dp->bridge, status);
>
> [Severity: Medium]
> Will this hotplug notification be silently dropped? Since
> DRM_BRIDGE_OP_HPD is not set for the DP bridge during inno_dp_probe(), the
> bridge->hpd_cb is NULL, making drm_bridge_hpd_notify() a no-op and forcing
> the DRM core to rely entirely on periodic polling.

Deliberate: the HPD interrupt is gated by the DP pixel clock, so
the connector is polled instead, and the IRQ path still refreshes
status early when it does fire. Documented at the ops assignment.

> > [ ... ]
> > @@ -2338,10 +2338,15 @@
> >  static int inno_dp_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > [ ... ]
> >  	if (dp->pxclk) {
> >  		ret = clk_prepare_enable(dp->pxclk);
> >  		if (ret) {
> >  			dev_err(dev, "failed to enable pxclk: %d\n", ret);
> >  			goto err_reset;
> >  		}
> >  	}
> > [ ... ]
> >  	if (dp->pxclk) {
> >  		ret = clk_set_parent(dp->pxclk, dp->pll_clk);
>
> [Severity: Medium]
> Can calling clk_set_parent() on an already enabled clock cause hardware
> glitches? The pxclk is prepared and enabled earlier in inno_dp_probe(), and
> reparenting a running clock without hardware-specific glitch-free muxing
> can lock up downstream logic.

The mux is reparented before the display is enabled; nothing scans
while it switches at probe.

Cody
