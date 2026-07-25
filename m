Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7733C531C9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 05:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46FB710F502;
	Sat, 25 Jul 2026 05:04:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hr9jAH+Y";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E9A210E672
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 05:04:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E87CD60A77;
 Sat, 25 Jul 2026 05:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302CF1F000E9;
 Sat, 25 Jul 2026 05:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784955878;
 bh=ScRUpYKSPgrAR31jwAZGd/CQy0c2eVCu1switjuiMik=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Hr9jAH+YvHTEq0AGIB7/3HUqt0JXUefr/Es4AhZaem2ROXOxLiRtCOXz/H2Ya9Rvf
 fPDO1tOSGXYYbPe3QRutjzViVyJBE8rqJikvVr+ejOkgF/NfU0mYiA7e3EOsS28Nrw
 Iv/LNFLxwcJ1JT8QeLSbb+WBlcHPTF3hm0n26/92bn5b/skImha7/OMYBqGvQ2nt1j
 1AC5HdKn9YpXtXi4dyTNdGhv3WKLoLN9gBgf7CC4QmTODKrePOJKKdXdDq1JJZJxbs
 VI4IivNw8nq4zPRqqEZu8zN/CBPQ9L/PW6JfxNBFJTAG7jtlggiJSOBGheTQ2VvpFb
 Z0CWTsYh1EeWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 12/17] drm/spacemit: add Innosilicon DP/eDP
 controller bridge driver
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: neil.armstrong@linaro.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 robh@kernel.org, linux-phy@lists.infradead.org, olteanv@gmail.com,
 dri-devel@lists.freedesktop.org, vkoul@kernel.org
In-Reply-To: <20260725-k3-display-v1-12-6de34d80e86c@gmail.com>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-12-6de34d80e86c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 05:04:37 +0000
Message-Id: <20260725050438.302CF1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:
- [High] Custom EDID read function bypasses DRM core and breaks I2C repeate=
d-start (MOT) rules, corrupting EDID reads for blocks > 0 or on active adap=
ters.
- [High] The hardirq handler returns `IRQ_NONE` after clearing hardware int=
errupt flags, permanently disabling the IRQ line.
- [High] Late attachment of the eDP panel bridge violates drm_bridge_connec=
tor architecture and breaks panel support if the panel probes asynchronousl=
y.
- [High] DP Transfer Unit (TU) miscalculation due to pixel clock truncation.
- [High] The IRQ handler returns `IRQ_NONE` without clearing the hardware i=
nterrupt when `drm_dev_enter()` fails, leading to an interrupt storm.
- [High] `spacemit_dp_bridge_atomic_create_state` returns an error pointer =
instead of `NULL` on allocation failure, causing a kernel crash in the DRM =
core.
- [High] The hardirq handler calls regmap functions which use a sleepable l=
ock on PREEMPT_RT.
- [Medium] The atomic_check and mode_valid callbacks access DPCD link capab=
ilities without holding mode_lock, leading to data races with the hotplug I=
RQ handler.
- [Medium] The DP IRQ handler silently drops hotplug notifications because =
drm_bridge_hpd_notify() is a no-op when DRM_BRIDGE_OP_HPD is omitted.
- [Medium] Calling clk_set_parent() on an already enabled clock.
- [Medium] Resetting the AUX controller without holding aux->hw_mutex races=
 with concurrent AUX transfers.
--

--- Patch [12]: [PATCH RESEND 12/17] drm/spacemit: add Innosilicon DP/eDP c=
ontroller bridge driver ---
commit b7eace372254ab27e120213d38c3a656b2a195b8
Author: Cody Kang <codykang.hk@gmail.com>

drm/spacemit: add Innosilicon DP/eDP controller bridge driver

Add the DP/eDP controller that sits downstream of the Saturn DPU. Two
identical instances share one compatible; the eDP-vs-DP role is board
wiring, so it is taken from the devicetree.

> diff --git a/drivers/gpu/drm/spacemit/spacemit_inno_dp.c b/drivers/gpu/dr=
m/spacemit/spacemit_inno_dp.c
> index 0000000000000..e88731d9b18bf
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_inno_dp.c
> @@ -248,16 +248,10 @@
>  static inline struct spacemit_dp_bridge_state *
>  to_spacemit_dp_bridge_state(struct drm_bridge_state *state)
>  {
>  	return container_of(state, struct spacemit_dp_bridge_state, base);
>  }
> =20
>  static const struct regmap_config spacemit_dp_regmap_config =3D {
>  	.name		=3D "dp",
>  	.reg_bits	=3D 32,
>  	.val_bits	=3D 32,
>  	.reg_stride	=3D 4,
>  	.max_register	=3D 0x3ffc,	/* full 0x4000 reg region from binding */
>  };

[Severity: High]
Is it safe to omit use_raw_spinlock from the regmap configuration? Because
this is not set to true, the regmap defaults to a sleepable lock on
PREEMPT_RT. This causes a BUG when regmap read/write functions are called
from the hardirq handler spacemit_dp_irq_handler().

> [ ... ]
> @@ -661,16 +661,10 @@
>  static void spacemit_dp_link_disable(struct spacemit_dp_dev *dp)
>  {
>  	regmap_write_bits(dp->regs, DP_VIDEO_VSAMPLE_REG,
>  			  DP_VIDEO_STREAM_ENABLE,
>  			  FIELD_PREP(DP_VIDEO_STREAM_ENABLE, 0));
>  	spacemit_dp_phy_off(dp);
> =20
>  	regmap_write_bits(dp->regs, DP_SOFT_RESET, DP_AUX_RESET,
>  			  FIELD_PREP(DP_AUX_RESET, 0x1));

[Severity: Medium]
Could this reset corrupt concurrent AUX transfers? Modifying the AUX
hardware in spacemit_dp_link_disable() without holding the aux->hw_mutex
could race against a userspace or deferred transfer, potentially wedging
the controller.

> [ ... ]
> @@ -936,15 +936,10 @@
>  static void spacemit_dp_hw_set_msa_and_enable_video(struct spacemit_dp_d=
ev *dp,
>  						    const struct drm_display_mode *mode,
>  					       enum spacemit_dp_link_rate rate,
>  					       enum spacemit_dp_lane_count lanes,
>  		u32 color_format)
>  {
>  	u64 hb_num;
>  	u32 link_rate;
>  	u32 fp; /* Pixel clock in MHz */
>  	u32 bpp, misc0;
>  	u32 tu, tu_frac, tu_int, rd_thres;
>  	u32 hsync_len;
> =20
>  	/* mode->clock unit is kHz, fp unit is MHz */
>  	if (dp->use_ext_pixel_clock)
>  		fp =3D dp->pixel_clock / 1000;
>  	else
>  		fp =3D mode->clock / 1000;

[Severity: High]
Can this truncation of the pixel clock to an integer MHz value cause DP
FIFO underflows or overflows? For non-integer MHz pixel clocks like
148.5 MHz, this truncates to 148, introducing precision errors in the
Transfer Unit (TU) calculations which results in corrupted video.

> [ ... ]
> @@ -1286,13 +1286,10 @@
>  static int spacemit_dp_conn_get_edid_block(void *data, u8 *buf,
>  					   unsigned int block, size_t len)
>  {
>  	struct spacemit_dp_dev *dp =3D data;
>  	unsigned int start =3D block * EDID_LENGTH;
>  	u8 segment =3D block >> 1;
>  	int ret, retry;
>  	size_t offset;
> =20
>  	if (segment) {
>  		for (retry =3D 0; retry < 3; retry++) {
>  			ret =3D spacemit_dp_aux_i2c_write(dp,
>  				SPACEMIT_DP_DDC_SEGMENT_ADDR, &segment, 1);

[Severity: High]
Does this custom EDID read function bypass the Middle-Of-Transaction (MOT)
rules for I2C repeated-start? Issuing writes and reads without the MOT flag
resets the DDC segment pointer to 0, breaking EDID reads for displays with
multiple EDID blocks (block >=3D 1) or on active adapters.

> [ ... ]
> @@ -1632,15 +1632,10 @@
>  static int spacemit_dp_bridge_atomic_check(struct drm_bridge *bridge,
>  					   struct drm_bridge_state *bridge_state,
>  				      struct drm_crtc_state *crtc_state,
>  				      struct drm_connector_state *conn_state)
>  {
>  	struct spacemit_dp_dev *dp =3D container_of(bridge,
>  						  struct spacemit_dp_dev,
>  						  bridge);
>  	struct spacemit_dp_bridge_state *st =3D
>  			to_spacemit_dp_bridge_state(bridge_state);
>  	const struct drm_display_mode *mode =3D &crtc_state->adjusted_mode;
>  	int bpp;
>  	u32 req_bw;
>  	int i;
> =20
>  	/* A single output bus format, see ->atomic_get_output_bus_fmts(). */
>  	st->color_format =3D SOC_VIDEO_RGB_8BIT;
>  	bpp =3D spacemit_dp_get_bpp(dp, st->color_format);
>  	req_bw =3D spacemit_dp_calc_required_bw(mode, bpp);
> =20
>  	/* No caps yet: leave idx unset and let ->atomic_enable() retry. */
>  	if (!dp->link.max_rate || !dp->link.max_num_lanes) {

[Severity: Medium]
Could reading the DPCD link capabilities here race with the hotplug IRQ
handler? Accessing the dp->link capabilities in
spacemit_dp_bridge_atomic_check() without holding mode_lock might observe
intermediate or torn states if a concurrent interrupt triggers a capability
re-read, leading to transient rejections of valid modes.

> [ ... ]
> @@ -1705,10 +1705,10 @@
>  static struct drm_bridge_state *
>  spacemit_dp_bridge_atomic_create_state(struct drm_bridge *bridge)
>  {
>  	struct spacemit_dp_bridge_state *new;
> =20
>  	new =3D kzalloc_obj(*new);
>  	if (!new)
>  		return ERR_PTR(-ENOMEM);

[Severity: High]
Should this return NULL on allocation failure instead of an error pointer?
The DRM core's reset helper assigns the returned state directly without
checking for errors. Returning an error pointer here causes a fatal page
fault when the DRM core later dereferences it.

> [ ... ]
> @@ -1742,16 +1742,10 @@
>  static int spacemit_dp_edp_link_panel(struct drm_dp_aux *aux)
>  {
>  	struct spacemit_dp_dev *dp =3D container_of(aux, struct spacemit_dp_dev,
>  						  aux);
>  	struct drm_bridge *next;
>  	int ret;
> =20
>  	next =3D devm_drm_of_get_bridge(dp->dev, dp->dev->of_node, 1, 0);
>  	if (IS_ERR(next))
>  		return PTR_ERR(next);
> =20
>  	dp->next_bridge =3D next;
> =20
>  	/*
>  	 * A non-NULL bridge.encoder means .attach already ran: late-chain
>  	 * panel-edp.
>  	 */
>  	if (dp->bridge.encoder) {
>  		ret =3D drm_bridge_attach(dp->bridge.encoder, next,
>  					&dp->bridge,
>  					DRM_BRIDGE_ATTACH_NO_CONNECTOR);

[Severity: High]
Does dynamically attaching the panel bridge late bypass connector
initialization? If the eDP panel defers its probe,
drm_bridge_connector_init() builds the connector without the panel bridge.
Attaching it here later violates the drm_bridge_connector architecture and
breaks panel support, because the connector will lack the panel's mode or
EDID operations.

> [ ... ]
> @@ -1782,10 +1782,10 @@
>  static irqreturn_t spacemit_dp_irq_handler(int irq, void *data)
>  {
>  	struct spacemit_dp_dev *dp =3D data;
>  	irqreturn_t ret =3D IRQ_NONE;
>  	int idx;
> =20
>  	if (!drm_dev_enter(dp->drm, &idx))
>  		return IRQ_NONE;

[Severity: High]
Will returning IRQ_NONE here without clearing the hardware interrupt cause
an interrupt storm? If an interrupt fires while the DRM device is
unregistered (such as during module unload), the handler exits without
acknowledging the hardware interrupt, causing it to continuously fire and
stall the CPU.

> [ ... ]
> @@ -1796,11 +1796,10 @@
>  	/*
>  	 * Only compare here: the authoritative connector_status update
>  	 * happens in the thread under mode_lock, via .detect().
>  	 */
>  	if (spacemit_dp_hw_detect_hpd(dp) !=3D READ_ONCE(dp->connector_status))
>  		ret =3D IRQ_WAKE_THREAD; /* Call hotplug_event */
>  	spacemit_dp_hw_clean_hpd(dp);
> =20
>  	drm_dev_exit(idx);
>  	return ret;
>  }

[Severity: High]
Is it safe to return IRQ_NONE after clearing the hardware interrupt flags?
If the logical state has not changed (e.g. from a transient hardware
glitch), returning IRQ_NONE causes the kernel's spurious interrupt detector
to eventually disable the IRQ line, which results in all future hotplug
events being permanently missed.

> [ ... ]
> @@ -1813,11 +1813,10 @@
>  static irqreturn_t spacemit_dp_hotplug_event_handler(int irq, void *data)
>  {
>  	struct spacemit_dp_dev *dp =3D data;
>  	enum drm_connector_status status;
>  	int idx;
> =20
>  	if (!drm_dev_enter(dp->drm, &idx))
>  		return IRQ_HANDLED;
> =20
>  	/*
>  	 * .detect() owns mode_lock and re-reads the sink caps on a fresh plug
>  	 */
>  	status =3D spacemit_dp_bridge_detect(&dp->bridge, dp->connector);
>  	drm_bridge_hpd_notify(&dp->bridge, status);

[Severity: Medium]
Will this hotplug notification be silently dropped? Since
DRM_BRIDGE_OP_HPD is not set for the DP bridge during inno_dp_probe(), the
bridge->hpd_cb is NULL, making drm_bridge_hpd_notify() a no-op and forcing
the DRM core to rely entirely on periodic polling.

> [ ... ]
> @@ -2338,10 +2338,15 @@
>  static int inno_dp_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> [ ... ]
>  	if (dp->pxclk) {
>  		ret =3D clk_prepare_enable(dp->pxclk);
>  		if (ret) {
>  			dev_err(dev, "failed to enable pxclk: %d\n", ret);
>  			goto err_reset;
>  		}
>  	}
> [ ... ]
>  	if (dp->pxclk) {
>  		ret =3D clk_set_parent(dp->pxclk, dp->pll_clk);

[Severity: Medium]
Can calling clk_set_parent() on an already enabled clock cause hardware
glitches? The pxclk is prepared and enabled earlier in inno_dp_probe(), and
reparenting a running clock without hardware-specific glitch-free muxing
can lock up downstream logic.

> [ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-k3-display=
-v1-0-6de34d80e86c@gmail.com?part=3D12
