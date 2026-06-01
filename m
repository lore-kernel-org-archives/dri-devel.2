Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B6FCD6E67
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 22:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 776FC113788;
	Mon,  1 Jun 2026 22:45:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Zf6NufGC";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A378113782
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 22:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780353929;
 bh=PEAv8TNwAIrTF/VpnuiW1c80xtKKv9wlhajkzBFg53M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Zf6NufGCfDkOhKmPShvvegjuh+HKO6ovD4VGo0p6burOiRm8irphoK32eY+BT8SC8
 i1UbJ/frh+MLcmBUHJknawIFWmS9vcHqYaZfR105chIYp9Tk4VeRj+7LaF3AEz6O9C
 kx/HU6YjU52ZBDZiVhnXRYPnnGhCYkrYK2AS68mDeG/oucF5lDn/UjX4YyLeXUwS77
 j5m3Uqx7hZTah1pZp1EgJ2BHWK52Q1cL6vOWxdzxmKapXMa83dD+G2pHFK0KGaP3At
 YOiD3oisl8a/pa5jJy+1N+Un46WXMdBBzX+Mk8xReWZESm56vO2okwRSJbjYliduFh
 GSe1lb5YdiStQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3307B17E0DE9;
 Tue,  2 Jun 2026 00:45:29 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Jun 2026 01:44:25 +0300
Subject: [PATCH v7 25/30] drm/vc4: hdmi: Convert to common HDMI 2.0 SCDC
 scrambling helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dw-hdmi-qp-scramb-v7-25-445eb54ee1ed@collabora.com>
References: <20260602-dw-hdmi-qp-scramb-v7-0-445eb54ee1ed@collabora.com>
In-Reply-To: <20260602-dw-hdmi-qp-scramb-v7-0-445eb54ee1ed@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.2
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

Replace the vc4-local scrambling implementation with the newly
introduced DRM common SCDC scrambling infrastructure:

- Advertise source-side scrambling support by setting
  connector->hdmi.scrambling_supported based on the variant's
  max_pixel_clock before drmm_connector_hdmi_init().

- Provide minimal .scrambler_{enable|disable} connector callbacks that
  only toggle the VC5 HDMI_SCRAMBLER_CTL register.  Sink-side SCDC
  programming and periodic status monitoring are now delegated to
  drm_scdc_{start|stop}_scrambling().

- Replace vc4_hdmi_enable_scrambling() with a conditional call to
  drm_scdc_start_scrambling() in post_crtc_enable, gated on
  conn_state->hdmi.scrambler_needed (computed by the HDMI state helper).

- Replace vc4_hdmi_disable_scrambling() with drm_scdc_stop_scrambling()
  in post_crtc_disable.

- Drop vc4_hdmi_reset_link() and vc4_hdmi_handle_hotplug(), switching
  the .detect_ctx() path to
  drm_atomic_helper_connector_hdmi_hotplug_ctx() which internally calls
  drm_scdc_sync_status() to trigger a CRTC reset on reconnection.

- Drop the local scrambling_work delayed workqueue and scdc_enabled
  flag, now tracked by the common drm_connector_hdmi layer.

- Drop vc4_hdmi_supports_scrambling() and
  vc4_hdmi_mode_needs_scrambling() helpers, inlining the remaining 4KP60
  warning with an explicit drm_hdmi_compute_mode_clock() check.

- Seed connector->hdmi.scrambler_enabled = true in connector_init() to
  ensure drm_scdc_stop_scrambling() runs at boot and disables any stale
  scrambling state left by the bootloader.

No functional change is expected for the supported modes.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 265 ++++++-----------------------------------
 drivers/gpu/drm/vc4/vc4_hdmi.h |   8 --
 2 files changed, 35 insertions(+), 238 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 046ac4f43ba8..02f6ca6ab52b 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -114,31 +114,6 @@
 #define HSM_MIN_CLOCK_FREQ	120000000
 #define CEC_CLOCK_FREQ 40000
 
-static bool vc4_hdmi_supports_scrambling(struct vc4_hdmi *vc4_hdmi)
-{
-	struct drm_display_info *display = &vc4_hdmi->connector.display_info;
-
-	lockdep_assert_held(&vc4_hdmi->mutex);
-
-	if (!display->is_hdmi)
-		return false;
-
-	if (!display->hdmi.scdc.supported ||
-	    !display->hdmi.scdc.scrambling.supported)
-		return false;
-
-	return true;
-}
-
-static bool vc4_hdmi_mode_needs_scrambling(const struct drm_display_mode *mode,
-					   unsigned int bpc,
-					   enum drm_output_color_format fmt)
-{
-	unsigned long long clock = drm_hdmi_compute_mode_clock(mode, bpc, fmt);
-
-	return clock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
-}
-
 static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
 {
 	struct drm_debugfs_entry *entry = m->private;
@@ -272,124 +247,6 @@ static void vc4_hdmi_cec_update_clk_div(struct vc4_hdmi *vc4_hdmi)
 static void vc4_hdmi_cec_update_clk_div(struct vc4_hdmi *vc4_hdmi) {}
 #endif
 
-static int vc4_hdmi_reset_link(struct drm_connector *connector,
-			       struct drm_modeset_acquire_ctx *ctx)
-{
-	struct drm_device *drm;
-	struct vc4_hdmi *vc4_hdmi;
-	struct drm_connector_state *conn_state;
-	struct drm_crtc_state *crtc_state;
-	struct drm_crtc *crtc;
-	bool scrambling_needed;
-	u8 config;
-	int ret;
-
-	if (!connector)
-		return 0;
-
-	drm = connector->dev;
-	ret = drm_modeset_lock(&drm->mode_config.connection_mutex, ctx);
-	if (ret)
-		return ret;
-
-	conn_state = connector->state;
-	crtc = conn_state->crtc;
-	if (!crtc)
-		return 0;
-
-	ret = drm_modeset_lock(&crtc->mutex, ctx);
-	if (ret)
-		return ret;
-
-	crtc_state = crtc->state;
-	if (!crtc_state->active)
-		return 0;
-
-	vc4_hdmi = connector_to_vc4_hdmi(connector);
-	mutex_lock(&vc4_hdmi->mutex);
-
-	if (!vc4_hdmi_supports_scrambling(vc4_hdmi)) {
-		mutex_unlock(&vc4_hdmi->mutex);
-		return 0;
-	}
-
-	scrambling_needed = vc4_hdmi_mode_needs_scrambling(&vc4_hdmi->saved_adjusted_mode,
-							   vc4_hdmi->output_bpc,
-							   vc4_hdmi->output_format);
-	if (!scrambling_needed) {
-		mutex_unlock(&vc4_hdmi->mutex);
-		return 0;
-	}
-
-	if (conn_state->commit &&
-	    !try_wait_for_completion(&conn_state->commit->hw_done)) {
-		mutex_unlock(&vc4_hdmi->mutex);
-		return 0;
-	}
-
-	ret = drm_scdc_readb(connector->ddc, SCDC_TMDS_CONFIG, &config);
-	if (ret < 0) {
-		drm_err(drm, "Failed to read TMDS config: %d\n", ret);
-		mutex_unlock(&vc4_hdmi->mutex);
-		return 0;
-	}
-
-	if (!!(config & SCDC_SCRAMBLING_ENABLE) == scrambling_needed) {
-		mutex_unlock(&vc4_hdmi->mutex);
-		return 0;
-	}
-
-	mutex_unlock(&vc4_hdmi->mutex);
-
-	/*
-	 * HDMI 2.0 says that one should not send scrambled data
-	 * prior to configuring the sink scrambling, and that
-	 * TMDS clock/data transmission should be suspended when
-	 * changing the TMDS clock rate in the sink. So let's
-	 * just do a full modeset here, even though some sinks
-	 * would be perfectly happy if were to just reconfigure
-	 * the SCDC settings on the fly.
-	 */
-	return drm_atomic_helper_reset_crtc(crtc, ctx);
-}
-
-static void vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
-				    struct drm_modeset_acquire_ctx *ctx,
-				    enum drm_connector_status status)
-{
-	struct drm_connector *connector = &vc4_hdmi->connector;
-	int ret;
-
-	/*
-	 * NOTE: This function should really be called with vc4_hdmi->mutex
-	 * held, but doing so results in reentrancy issues since
-	 * cec_s_phys_addr() might call .adap_enable, which leads to that
-	 * funtion being called with our mutex held.
-	 *
-	 * A similar situation occurs with vc4_hdmi_reset_link() that
-	 * will call into our KMS hooks if the scrambling was enabled.
-	 *
-	 * Concurrency isn't an issue at the moment since we don't share
-	 * any state with any of the other frameworks so we can ignore
-	 * the lock for now.
-	 */
-
-	drm_atomic_helper_connector_hdmi_hotplug(connector, status);
-
-	if (status != connector_status_connected)
-		return;
-
-	for (;;) {
-		ret = vc4_hdmi_reset_link(connector, ctx);
-		if (ret == -EDEADLK) {
-			drm_modeset_backoff(ctx);
-			continue;
-		}
-
-		break;
-	}
-}
-
 static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
 					 struct drm_modeset_acquire_ctx *ctx,
 					 bool force)
@@ -401,8 +258,8 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
 	/*
 	 * NOTE: This function should really take vc4_hdmi->mutex, but
 	 * doing so results in reentrancy issues since
-	 * vc4_hdmi_handle_hotplug() can call into other functions that
-	 * would take the mutex while it's held here.
+	 * drm_atomic_helper_connector_hdmi_hotplug_ctx() can call into other
+	 * functions that would take the mutex while it's held here.
 	 *
 	 * Concurrency isn't an issue at the moment since we don't share
 	 * any state with any of the other frameworks so we can ignore
@@ -425,10 +282,11 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
 			status = connector_status_connected;
 	}
 
-	vc4_hdmi_handle_hotplug(vc4_hdmi, ctx, status);
+	ret = drm_atomic_helper_connector_hdmi_hotplug_ctx(connector, status, ctx);
+
 	pm_runtime_put(&vc4_hdmi->pdev->dev);
 
-	return status;
+	return ret == -EDEADLK ? ret : status;
 }
 
 static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
@@ -441,9 +299,12 @@ static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
 	if (!vc4->hvs->vc5_hdmi_enable_hdmi_20) {
 		struct drm_device *drm = connector->dev;
 		const struct drm_display_mode *mode;
+		unsigned long long clock;
 
 		list_for_each_entry(mode, &connector->probed_modes, head) {
-			if (vc4_hdmi_mode_needs_scrambling(mode, 8, DRM_OUTPUT_COLOR_FORMAT_RGB444)) {
+			clock = drm_hdmi_compute_mode_clock(mode, 8,
+							    DRM_OUTPUT_COLOR_FORMAT_RGB444);
+			if (clock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ) {
 				drm_warn_once(drm, "The core clock cannot reach frequencies high enough to support 4k @ 60Hz.");
 				drm_warn_once(drm, "Please change your config.txt file to add hdmi_enable_4kp60.");
 			}
@@ -540,6 +401,9 @@ static int vc4_hdmi_connector_init(struct drm_device *dev,
 	if (vc4_hdmi->variant->supports_hdr)
 		max_bpc = 12;
 
+	connector->hdmi.scrambler_supported =
+		vc4_hdmi->variant->max_pixel_clock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
+
 	ret = drmm_connector_hdmi_init(dev, connector,
 				       "Broadcom", "Videocore",
 				       &vc4_hdmi_connector_funcs,
@@ -561,6 +425,14 @@ static int vc4_hdmi_connector_init(struct drm_device *dev,
 
 	drm_connector_helper_add(connector, &vc4_hdmi_connector_helper_funcs);
 
+	/*
+	 * Since we don't know the state of the controller and its
+	 * display (if any), let's assume it's always enabled.
+	 * drm_scdc_stop_scrambling() will thus run at boot, make
+	 * sure it's disabled, and avoid any inconsistency.
+	 */
+	connector->hdmi.scrambler_enabled = connector->hdmi.scrambler_supported;
+
 	/*
 	 * Some of the properties below require access to state, like bpc.
 	 * Allocate some default initial connector state with our reset helper.
@@ -786,93 +658,30 @@ static int vc4_hdmi_write_spd_infoframe(struct drm_connector *connector,
 					buffer, len);
 }
 
-#define SCRAMBLING_POLLING_DELAY_MS	1000
-
-static void vc4_hdmi_enable_scrambling(struct drm_encoder *encoder)
+static int vc4_hdmi_scrambler_enable(struct drm_connector *connector)
 {
-	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
-	struct drm_connector *connector = &vc4_hdmi->connector;
-	struct drm_device *drm = connector->dev;
-	const struct drm_display_mode *mode = &vc4_hdmi->saved_adjusted_mode;
+	struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
 	unsigned long flags;
-	int idx;
-
-	lockdep_assert_held(&vc4_hdmi->mutex);
-
-	if (!vc4_hdmi_supports_scrambling(vc4_hdmi))
-		return;
-
-	if (!vc4_hdmi_mode_needs_scrambling(mode,
-					    vc4_hdmi->output_bpc,
-					    vc4_hdmi->output_format))
-		return;
-
-	if (!drm_dev_enter(drm, &idx))
-		return;
-
-	drm_scdc_set_high_tmds_clock_ratio(connector, true);
-	drm_scdc_set_scrambling(connector, true);
 
 	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
 	HDMI_WRITE(HDMI_SCRAMBLER_CTL, HDMI_READ(HDMI_SCRAMBLER_CTL) |
 		   VC5_HDMI_SCRAMBLER_CTL_ENABLE);
 	spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
 
-	drm_dev_exit(idx);
-
-	vc4_hdmi->scdc_enabled = true;
-
-	queue_delayed_work(system_percpu_wq, &vc4_hdmi->scrambling_work,
-			   msecs_to_jiffies(SCRAMBLING_POLLING_DELAY_MS));
+	return 0;
 }
 
-static void vc4_hdmi_disable_scrambling(struct drm_encoder *encoder)
+static int vc4_hdmi_scrambler_disable(struct drm_connector *connector)
 {
-	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
-	struct drm_connector *connector = &vc4_hdmi->connector;
-	struct drm_device *drm = connector->dev;
+	struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
 	unsigned long flags;
-	int idx;
-
-	lockdep_assert_held(&vc4_hdmi->mutex);
-
-	if (!vc4_hdmi->scdc_enabled)
-		return;
-
-	vc4_hdmi->scdc_enabled = false;
-
-	if (delayed_work_pending(&vc4_hdmi->scrambling_work))
-		cancel_delayed_work_sync(&vc4_hdmi->scrambling_work);
-
-	if (!drm_dev_enter(drm, &idx))
-		return;
 
 	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
 	HDMI_WRITE(HDMI_SCRAMBLER_CTL, HDMI_READ(HDMI_SCRAMBLER_CTL) &
 		   ~VC5_HDMI_SCRAMBLER_CTL_ENABLE);
 	spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
 
-	drm_scdc_set_scrambling(connector, false);
-	drm_scdc_set_high_tmds_clock_ratio(connector, false);
-
-	drm_dev_exit(idx);
-}
-
-static void vc4_hdmi_scrambling_wq(struct work_struct *work)
-{
-	struct vc4_hdmi *vc4_hdmi = container_of(to_delayed_work(work),
-						 struct vc4_hdmi,
-						 scrambling_work);
-	struct drm_connector *connector = &vc4_hdmi->connector;
-
-	if (drm_scdc_get_scrambling_status(connector))
-		return;
-
-	drm_scdc_set_high_tmds_clock_ratio(connector, true);
-	drm_scdc_set_scrambling(connector, true);
-
-	queue_delayed_work(system_percpu_wq, &vc4_hdmi->scrambling_work,
-			   msecs_to_jiffies(SCRAMBLING_POLLING_DELAY_MS));
+	return 0;
 }
 
 static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encoder,
@@ -917,7 +726,7 @@ static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encoder,
 		spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
 	}
 
-	vc4_hdmi_disable_scrambling(encoder);
+	drm_scdc_stop_scrambling(&vc4_hdmi->connector);
 
 	drm_dev_exit(idx);
 
@@ -1625,6 +1434,7 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
 	struct drm_display_info *display = &vc4_hdmi->connector.display_info;
 	bool hsync_pos = mode->flags & DRM_MODE_FLAG_PHSYNC;
 	bool vsync_pos = mode->flags & DRM_MODE_FLAG_PVSYNC;
+	struct drm_connector_state *conn_state;
 	unsigned long flags;
 	int ret;
 	int idx;
@@ -1693,7 +1503,10 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
 	}
 
 	vc4_hdmi_recenter_fifo(vc4_hdmi);
-	vc4_hdmi_enable_scrambling(encoder);
+
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	if (conn_state && conn_state->hdmi.scrambler_needed)
+		drm_scdc_start_scrambling(connector);
 
 	drm_dev_exit(idx);
 
@@ -1739,7 +1552,9 @@ vc4_hdmi_connector_clock_valid(const struct drm_connector *connector,
 }
 
 static const struct drm_connector_hdmi_funcs vc4_hdmi_hdmi_connector_funcs = {
-	.tmds_char_rate_valid	= vc4_hdmi_connector_clock_valid,
+	.tmds_char_rate_valid	 = vc4_hdmi_connector_clock_valid,
+	.scrambler_enable	 = vc4_hdmi_scrambler_enable,
+	.scrambler_disable	 = vc4_hdmi_scrambler_disable,
 	.avi = {
 		.clear_infoframe = vc4_hdmi_clear_avi_infoframe,
 		.write_infoframe = vc4_hdmi_write_avi_infoframe,
@@ -3233,7 +3048,6 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 
 	spin_lock_init(&vc4_hdmi->hw_lock);
-	INIT_DELAYED_WORK(&vc4_hdmi->scrambling_work, vc4_hdmi_scrambling_wq);
 
 	dev_set_drvdata(dev, vc4_hdmi);
 	encoder = &vc4_hdmi->encoder.base;
@@ -3246,15 +3060,6 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	vc4_hdmi->pdev = pdev;
 	vc4_hdmi->variant = variant;
 
-	/*
-	 * Since we don't know the state of the controller and its
-	 * display (if any), let's assume it's always enabled.
-	 * vc4_hdmi_disable_scrambling() will thus run at boot, make
-	 * sure it's disabled, and avoid any inconsistency.
-	 */
-	if (variant->max_pixel_clock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ)
-		vc4_hdmi->scdc_enabled = true;
-
 	ret = variant->init_resources(drm, vc4_hdmi);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 29d461d4ee49..58c92ebc2677 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -118,8 +118,6 @@ struct vc4_hdmi {
 	struct vc4_encoder encoder;
 	struct drm_connector connector;
 
-	struct delayed_work scrambling_work;
-
 	struct i2c_adapter *ddc;
 	void __iomem *hdmicore_regs;
 	void __iomem *hd_regs;
@@ -193,12 +191,6 @@ struct vc4_hdmi {
 	 */
 	bool packet_ram_enabled;
 
-	/**
-	 * @scdc_enabled: Is the HDMI controller currently running with
-	 * the scrambler on? Protected by @mutex.
-	 */
-	bool scdc_enabled;
-
 	/**
 	 * @output_bpc: Copy of @drm_connector_state.hdmi.output_bpc for
 	 * use outside of KMS hooks. Protected by @mutex.

-- 
2.54.0

