Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A78C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D19DB10F41B;
	Thu,  2 Jul 2026 14:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ObRxAGs6";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AF8110F418
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783003596;
 bh=T90VQ7DbYuew7+rPBY6ARdjT7iVqoZVlr4kIRf8Vyfg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ObRxAGs6ii1AUcZBLf4g/tWZFPKZwY04zxMrIJw6qfKB7dxF48Hzm5Im0ZqKFaarF
 cGlfNgBYX0X3rsgzEoxzGLIa32JC4urmBF7CVqfphMga6XukglknzaA7e9CJSd9X7E
 d+2CzPB9LzVTeKZDPpDizsR1ih2E4YaMbwic3uBDnLLKfqkwcWKym2Zdya5/FGuPB0
 jUUrpTPs4F5S+lIg5DCMDhXLi2aaOFixyo2SZMatJo8ICJrNJhMHgdrIZa1ncCFBg2
 rICINGwdVUXh7pWcX/mzClTVFCfN3C7dF3P49NOnBTS21isJVSpkRkOehOjbdVNbGt
 ljwFzUR5aMcQQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B99C217E0432;
 Thu,  2 Jul 2026 16:46:36 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 02 Jul 2026 17:46:20 +0300
Subject: [PATCH v8 07/39] drm/display: hdmi: Add HDMI 2.0 scrambling
 management helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dw-hdmi-qp-scramb-v8-7-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
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

Add helpers to manage the full lifecycle of HDMI 2.0 SCDC scrambling on
both source and sink sides:

- drm_hdmi_mode_needs_scrambling(): checks whether a mode, bits per
  component and output format combination requires scrambling, which is
  needed when the resulting TMDS character rate exceeds the HDMI 1.3
  maximum of 340 MHz

- drm_connector_hdmi_enable_scrambling(): configures SCDC scrambling and
  high TMDS clock ratio and starts a periodic work item that monitors
  the sink's SCDC scrambling status, retrying setup when the sink loses
  state

- drm_connector_hdmi_disable_scrambling(): tears down scrambling on both
  sides and cancels the monitoring work

- drm_connector_hdmi_sync_scdc(): triggers a CRTC reset on reconnection
  to restore SCDC state lost during sink disconnects within an active
  display pipeline

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_helper.c | 260 ++++++++++++++++++++++++++++++
 include/drm/display/drm_hdmi_helper.h     |  15 ++
 2 files changed, 275 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/display/drm_hdmi_helper.c
index 5cb0b033b171..7c96cccf683d 100644
--- a/drivers/gpu/drm/display/drm_hdmi_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
@@ -4,12 +4,20 @@
 #include <linux/module.h>
 
 #include <drm/display/drm_hdmi_helper.h>
+#include <drm/display/drm_scdc_helper.h>
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_modeset_lock.h>
 #include <drm/drm_print.h>
 #include <drm/drm_property.h>
 
+#define DRM_HDMI_SCDC_POLL_DELAY_MS	1000
+
 static inline bool is_eotf_supported(u8 output_eotf, u8 sink_eotf)
 {
 	return sink_eotf & BIT(output_eotf);
@@ -426,3 +434,255 @@ drm_hdmi_acr_get_n_cts(unsigned long long tmds_char_rate,
 	*out_cts = cts;
 }
 EXPORT_SYMBOL(drm_hdmi_acr_get_n_cts);
+
+/**
+ * drm_hdmi_mode_needs_scrambling() - Check if an HDMI mode requires scrambling
+ * @mode: Display mode to check
+ * @bpc: Bits per color component
+ * @fmt: Output pixel format
+ *
+ * Computes the TMDS character rate for the given mode, bits per component and
+ * output format, and checks whether it exceeds the HDMI 1.3 maximum TMDS
+ * character rate of 340 MHz.
+ *
+ * Returns:
+ * true if the mode requires scrambling, false otherwise.
+ */
+bool drm_hdmi_mode_needs_scrambling(const struct drm_display_mode *mode,
+				    unsigned int bpc,
+				    enum drm_output_color_format fmt)
+{
+	unsigned long long tmds_char_rate;
+
+	tmds_char_rate = drm_hdmi_compute_mode_clock(mode, bpc, fmt);
+
+	return tmds_char_rate > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
+}
+EXPORT_SYMBOL(drm_hdmi_mode_needs_scrambling);
+
+static int drm_scdc_try_scrambling_setup(struct drm_connector *connector)
+{
+	bool done;
+
+	done = drm_scdc_set_high_tmds_clock_ratio(connector, true);
+	if (!done)
+		return -EIO;
+
+	done = drm_scdc_set_scrambling(connector, true);
+	if (!done)
+		return -EIO;
+
+	if (READ_ONCE(connector->hdmi.scrambler_enabled))
+		schedule_delayed_work(&connector->hdmi.scdc_work,
+				      msecs_to_jiffies(DRM_HDMI_SCDC_POLL_DELAY_MS));
+
+	return 0;
+}
+
+static void drm_scdc_monitor_scrambler(struct drm_connector *connector)
+{
+	if (READ_ONCE(connector->hdmi.scrambler_enabled) &&
+	    !drm_scdc_get_scrambling_status(connector))
+		drm_scdc_try_scrambling_setup(connector);
+}
+
+static bool drm_scdc_sink_supports_scrambling(struct drm_connector *connector)
+{
+	const struct drm_display_info *info = &connector->display_info;
+
+	return info->is_hdmi &&
+	       info->hdmi.scdc.supported &&
+	       info->hdmi.scdc.scrambling.supported;
+}
+
+/**
+ * drm_connector_hdmi_enable_scrambling - enable scrambling and monitor SCDC status
+ * @connector: connector
+ * @conn_state: connector state
+ *
+ * Enables scrambling and high TMDS clock ratio on both source and sink sides.
+ * Additionally, use a delayed work item to monitor the scrambling status on
+ * the sink side and retry the operation, as some displays refuse to set the
+ * scrambling bit right away.
+ *
+ * Returns:
+ * Zero if scrambling is set successfully, an error code otherwise.
+ */
+int drm_connector_hdmi_enable_scrambling(struct drm_connector *connector,
+					 const struct drm_connector_state *conn_state)
+{
+	struct drm_connector_hdmi *hdmi = &connector->hdmi;
+	struct drm_device *dev = connector->dev;
+	int ret;
+
+	if (!conn_state)
+		return -EINVAL;
+
+	if (!conn_state->hdmi.scrambler_needed)
+		return 0;
+
+	if (!hdmi->scrambler_supported) {
+		drm_dbg_kms(dev, "Source doesn't support scrambling.\n");
+		return -EINVAL;
+	}
+
+	if (!drm_scdc_sink_supports_scrambling(connector)) {
+		drm_dbg_kms(dev, "Sink doesn't support scrambling.\n");
+		return -EINVAL;
+	}
+
+	drm_dbg_kms(dev, "Enabling scrambling\n");
+
+	hdmi->scdc_cb = drm_scdc_monitor_scrambler;
+	WRITE_ONCE(hdmi->scrambler_enabled, true);
+
+	ret = drm_scdc_try_scrambling_setup(connector);
+	if (!ret)
+		ret = hdmi->funcs->scrambler_enable(connector);
+
+	if (ret) {
+		WRITE_ONCE(hdmi->scrambler_enabled, false);
+		cancel_delayed_work_sync(&hdmi->scdc_work);
+		hdmi->scdc_cb = NULL;
+
+		drm_scdc_set_scrambling(connector, false);
+		drm_scdc_set_high_tmds_clock_ratio(connector, false);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(drm_connector_hdmi_enable_scrambling);
+
+/**
+ * drm_connector_hdmi_disable_scrambling - disable scrambling and SCDC monitoring
+ * @connector: connector
+ *
+ * Disables scrambling and high TMDS clock ratio on both source and sink sides.
+ * Also cancels the SCDC status monitoring work item, if it is still pending.
+ *
+ * Returns:
+ * Zero if scrambling is reset successfully, an error code otherwise.
+ */
+int drm_connector_hdmi_disable_scrambling(struct drm_connector *connector)
+{
+	struct drm_connector_hdmi *hdmi = &connector->hdmi;
+	struct drm_device *dev = connector->dev;
+
+	if (!READ_ONCE(hdmi->scrambler_enabled))
+		return 0;
+
+	drm_dbg_kms(dev, "Disabling scrambling\n");
+
+	WRITE_ONCE(hdmi->scrambler_enabled, false);
+	cancel_delayed_work_sync(&hdmi->scdc_work);
+	hdmi->scdc_cb = NULL;
+
+	if (connector->status == connector_status_connected &&
+	    drm_scdc_sink_supports_scrambling(connector)) {
+		drm_scdc_set_scrambling(connector, false);
+		drm_scdc_set_high_tmds_clock_ratio(connector, false);
+	}
+
+	return hdmi->funcs->scrambler_disable(connector);
+}
+EXPORT_SYMBOL(drm_connector_hdmi_disable_scrambling);
+
+/**
+ * drm_connector_hdmi_sync_scdc - resync the sink-side SCDC upon reconnect
+ * @connector: connector
+ * @plugged: connector plugged status event
+ * @ctx: initialized lock acquisition context
+ *
+ * When receiving hotplug disconnect/reconnect event, while the display is
+ * still active (CRTC enabled), the SCDC status on the sink side is reset
+ * and must be explicitly restored.
+ *
+ * The typical solution for this is to trigger an empty modeset in
+ * drm_connector_helper_funcs.detect_ctx(), which is what this helper does
+ * by triggering a CRTC reset on reconnection.
+ *
+ * When making use of the HDMI connector framework, this is automatically
+ * triggered via drm_atomic_helper_connector_hdmi_hotplug().
+ *
+ * Returns:
+ * Zero on success, an error code otherwise, including -EDEADLK.
+ */
+int drm_connector_hdmi_sync_scdc(struct drm_connector *connector, bool plugged,
+				 struct drm_modeset_acquire_ctx *ctx)
+{
+	struct drm_connector_hdmi *hdmi = &connector->hdmi;
+	struct drm_device *dev = connector->dev;
+	struct drm_connector_state *conn_state;
+	struct drm_crtc *crtc;
+	u8 config;
+	int ret;
+
+	if (!connector || !plugged || !ctx)
+		return 0;
+
+	/*
+	 * This is normally part of .detect_ctx() call path, which already holds
+	 * connection_mutex through @ctx.  However, re-acquiring it with the
+	 * same context is a no-op and makes the helper safe under any caller.
+	 */
+	ret = drm_modeset_lock(&connector->dev->mode_config.connection_mutex, ctx);
+	if (ret)
+		return ret;
+
+	/* TODO: Also handle HDMI 2.1 FRL link training */
+
+	if (!hdmi->scrambler_supported || !READ_ONCE(hdmi->scrambler_enabled))
+		return 0;
+
+	conn_state = connector->state;
+	if (!conn_state)
+		return 0;
+
+	crtc = connector->state->crtc;
+	if (!crtc)
+		return 0;
+
+	ret = drm_modeset_lock(&crtc->mutex, ctx);
+	if (ret)
+		return ret;
+
+	if (!crtc->state || !crtc->state->active)
+		return 0;
+
+	if (!drm_scdc_sink_supports_scrambling(connector))
+		return 0;
+
+	if (conn_state->commit &&
+	    !try_wait_for_completion(&conn_state->commit->hw_done))
+		return 0;
+
+	ret = drm_scdc_readb(connector->ddc, SCDC_TMDS_CONFIG, &config);
+	if (ret) {
+		drm_dbg_kms(dev, "Failed to read TMDS config: %d\n", ret);
+		return ret;
+	}
+
+	if (config & SCDC_SCRAMBLING_ENABLE)
+		return 0;
+
+	/*
+	 * HDMI 2.0 requires that one should not send scrambled data prior
+	 * to configuring the sink scrambling, and that TMDS clock/data
+	 * transmission should be suspended when changing the TMDS clock rate
+	 * in the sink.  So let's just do a full modeset here, even though some
+	 * sinks would be perfectly happy if were to just reconfigure the SCDC
+	 * settings on the fly.
+	 *
+	 * The disable/re-enable cycle triggered by the reset should call
+	 * drm_connector_hdmi_enable_scrambling() during re-enable, thus
+	 * properly configuring the sink before data transmission resumes.
+	 */
+	drm_dbg_kms(dev, "Resetting CRTC to restore SCDC status\n");
+
+	ret = drm_atomic_helper_reset_crtc(crtc, ctx);
+	if (ret && ret != -EDEADLK)
+		drm_dbg_kms(dev, "Failed to reset CRTC: %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL(drm_connector_hdmi_sync_scdc);
diff --git a/include/drm/display/drm_hdmi_helper.h b/include/drm/display/drm_hdmi_helper.h
index 9c31ed90516b..2cdd6e3bc090 100644
--- a/include/drm/display/drm_hdmi_helper.h
+++ b/include/drm/display/drm_hdmi_helper.h
@@ -8,6 +8,7 @@
 struct drm_connector;
 struct drm_connector_state;
 struct drm_display_mode;
+struct drm_modeset_acquire_ctx;
 enum drm_output_color_format;
 
 void
@@ -35,4 +36,18 @@ drm_hdmi_acr_get_n_cts(unsigned long long tmds_char_rate,
 		       unsigned int *out_n,
 		       unsigned int *out_cts);
 
+bool
+drm_hdmi_mode_needs_scrambling(const struct drm_display_mode *mode,
+			       unsigned int bpc, enum drm_output_color_format fmt);
+
+int
+drm_connector_hdmi_enable_scrambling(struct drm_connector *connector,
+				     const struct drm_connector_state *conn_state);
+int
+drm_connector_hdmi_disable_scrambling(struct drm_connector *connector);
+
+int
+drm_connector_hdmi_sync_scdc(struct drm_connector *connector, bool plugged,
+			     struct drm_modeset_acquire_ctx *ctx);
+
 #endif

-- 
2.54.0

