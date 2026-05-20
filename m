Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCA4CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 18:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE6F410F102;
	Wed, 20 May 2026 18:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="WtF6RiyU";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDED510E437
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 18:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779302314;
 bh=S64LWx3EZnD+kZI/8SjO4W0whGpa/y+h7oV7/MH57Rg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=WtF6RiyUnxjnk2EE7ETmajAYELpAQI8RvuWRhAKgAJYNN/SuzGFjXg/2HFhdpqhUN
 34OVcVazEBRHGleBi+n3iRIinohP0eT5Xn7aiPdoMXYYfSWB2u6/6MSozgcqG043LL
 qtgQ0hGIsvhxm8qhnNEkmGOlcF6HFDOneGNsCfTGq6VA3qN5B8Q2v9kuhmtZRVg30P
 U6Wzh4rK70r1vj026LcmIfTW7srDLq80r/xwLT7cBkPXPCFnMAG9a1rbnew4EWaU/r
 dM001s4gJKZEe9udufnH9BGEf6E1l2PXHPWSveiyKcjvhyBN8Bx0OhnFAcFSn7oIdz
 8Ups72ueJYoZA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0D9A917E1449;
 Wed, 20 May 2026 20:38:34 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 20 May 2026 21:38:15 +0300
Subject: [PATCH v6 04/22] drm/display: scdc_helper: Add HDMI 2.0 scrambling
 management helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-dw-hdmi-qp-scramb-v6-4-24b74603b782@collabora.com>
References: <20260520-dw-hdmi-qp-scramb-v6-0-24b74603b782@collabora.com>
In-Reply-To: <20260520-dw-hdmi-qp-scramb-v6-0-24b74603b782@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniels@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.1
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

Add drm_scdc_start_scrambling(), drm_scdc_stop_scrambling() and
drm_scdc_sync_status() helpers to manage the full lifecycle of HDMI 2.0
SCDC scrambling on both source and sink sides.

drm_scdc_start_scrambling() configures SCDC scrambling and high TMDS
clock ratio and starts a periodic work item that monitors the sink's
SCDC scrambling status, retrying setup when the sink loses state.

drm_scdc_stop_scrambling() tears down scrambling on both sides and
cancels the monitoring work.

drm_scdc_sync_status() triggers a CRTC reset on reconnection to restore
SCDC state lost during sink disconnects within an active display
pipeline.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_scdc_helper.c | 235 +++++++++++++++++++++++++++++-
 include/drm/display/drm_scdc_helper.h     |   6 +-
 2 files changed, 236 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/display/drm_scdc_helper.c
index cb6632346aad..5bacb886d373 100644
--- a/drivers/gpu/drm/display/drm_scdc_helper.c
+++ b/drivers/gpu/drm/display/drm_scdc_helper.c
@@ -21,16 +21,22 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/i2c.h>
+#include <linux/minmax.h>
 #include <linux/slab.h>
-#include <linux/delay.h>
 
-#include <drm/display/drm_scdc_helper.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge_helper.h>
 #include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
 #include <drm/drm_device.h>
 #include <drm/drm_print.h>
 
+#include <drm/display/drm_scdc_helper.h>
+
 /**
  * DOC: scdc helpers
  *
@@ -50,10 +56,14 @@
  * has to track the connector status changes using interrupts and
  * restore the SCDC status. The typical solution for this is to trigger an
  * empty modeset in drm_connector_helper_funcs.detect_ctx(), like what vc4 does
- * in vc4_hdmi_reset_link().
+ * in vc4_hdmi_reset_link(). Alternatively, use the HDMI connector framework
+ * which ensures drm_scdc_sync_status() is called in the context of
+ * drm_atomic_helper_connector_hdmi_hotplug_ctx().
  */
 
-#define SCDC_I2C_SLAVE_ADDRESS 0x54
+#define SCDC_I2C_SLAVE_ADDRESS		0x54
+#define SCDC_MAX_SOURCE_VERSION		0x1
+#define SCDC_STATUS_POLL_DELAY_MS	3000
 
 #define drm_scdc_dbg(connector, fmt, ...)					\
 	drm_dbg_kms((connector)->dev, "[CONNECTOR:%d:%s] " fmt,			\
@@ -270,3 +280,220 @@ bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector,
 	return true;
 }
 EXPORT_SYMBOL(drm_scdc_set_high_tmds_clock_ratio);
+
+static int drm_scdc_setup_scrambler(struct drm_connector *connector)
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
+	schedule_delayed_work(&connector->hdmi.scdc_work,
+			      msecs_to_jiffies(SCDC_STATUS_POLL_DELAY_MS));
+	return 0;
+}
+
+static void drm_scdc_monitor_scrambler(struct drm_connector *connector)
+{
+	if (READ_ONCE(connector->hdmi.scrambler_enabled) &&
+	    !drm_scdc_get_scrambling_status(connector))
+		drm_scdc_setup_scrambler(connector);
+}
+
+static int drm_scdc_reset_crtc(struct drm_connector *connector,
+			       struct drm_modeset_acquire_ctx *ctx)
+{
+	struct drm_crtc *crtc;
+	u8 config;
+	int ret;
+
+	if (!ctx || !connector->state)
+		return 0;
+
+	crtc = connector->state->crtc;
+	if (!crtc || !crtc->state || !crtc->state->active)
+		return 0;
+
+	ret = drm_scdc_readb(connector->ddc, SCDC_TMDS_CONFIG, &config);
+	if (ret) {
+		drm_scdc_dbg(connector, "Failed to read TMDS config: %d\n", ret);
+		return ret;
+	}
+
+	if ((config & SCDC_SCRAMBLING_ENABLE) &&
+	    (config & SCDC_TMDS_BIT_CLOCK_RATIO_BY_40))
+		return 0;
+
+	/*
+	 * Reset the CRTC to suspend TMDS transmission, conforming to HDMI 2.0
+	 * spec which requires scrambled data not to be sent before the sink is
+	 * configured, and TMDS clock to be suspended while changing the clock
+	 * ratio.  The disable/re-enable cycle triggered by the reset should
+	 * call drm_scdc_start_scrambling() during re-enable, properly
+	 * configuring the sink before data transmission resumes.
+	 */
+
+	drm_scdc_dbg(connector, "Resetting CRTC to restore SCDC status\n");
+
+	ret = drm_atomic_helper_reset_crtc(crtc, ctx);
+	if (ret && ret != -EDEADLOCK)
+		drm_scdc_dbg(connector, "Failed to reset CRTC: %d\n", ret);
+
+	return ret;
+}
+
+/**
+ * drm_scdc_start_scrambling - activate scrambling and monitor SCDC status
+ * @connector: connector
+ *
+ * Enables scrambling and high TMDS clock ratio on both source and sink sides.
+ * Additionally, use a delayed work item to monitor the scrambling status on
+ * the sink side and retry the operation, as some displays refuse to set the
+ * scrambling bit right away.
+ *
+ * Returns:
+ * Zero if scrambling is set successfully, an error code otherwise.
+ */
+int drm_scdc_start_scrambling(struct drm_connector *connector)
+{
+	struct drm_display_info *info = &connector->display_info;
+	struct drm_connector_hdmi *hdmi = &connector->hdmi;
+	int ret;
+	u8 ver;
+
+	if (!hdmi->funcs ||
+	    !hdmi->funcs->scrambler_src_enable ||
+	    !hdmi->funcs->scrambler_src_disable) {
+		drm_scdc_dbg(connector, "Function not implemented, bailing.\n");
+		return -EINVAL;
+	}
+
+	if (!info->is_hdmi ||
+	    !info->hdmi.scdc.supported ||
+	    !info->hdmi.scdc.scrambling.supported) {
+		drm_scdc_dbg(connector, "Sink doesn't support scrambling.\n");
+		return -EINVAL;
+	}
+
+	drm_scdc_dbg(connector, "Enabling scrambling\n");
+
+	ret = drm_scdc_readb(connector->ddc, SCDC_SINK_VERSION, &ver);
+	if (ret) {
+		drm_scdc_dbg(connector, "Failed to read SCDC_SINK_VERSION: %d\n", ret);
+		return ret;
+	}
+
+	ret = drm_scdc_writeb(connector->ddc, SCDC_SOURCE_VERSION,
+			      min_t(u8, ver, SCDC_MAX_SOURCE_VERSION));
+	if (ret) {
+		drm_scdc_dbg(connector, "Failed to write SCDC_SOURCE_VERSION: %d\n", ret);
+		return ret;
+	}
+
+	hdmi->scdc_cb = drm_scdc_monitor_scrambler;
+	WRITE_ONCE(hdmi->scrambler_enabled, true);
+
+	ret = drm_scdc_setup_scrambler(connector);
+	if (!ret)
+		ret = hdmi->funcs->scrambler_src_enable(connector);
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
+EXPORT_SYMBOL(drm_scdc_start_scrambling);
+
+/**
+ * drm_scdc_stop_scrambling - deactivate scrambling and SCDC status monitor
+ * @connector: connector
+ *
+ * Disables scrambling and high TMDS clock ratio on both source and sink sides.
+ * Also cancels the SCDC status monitoring work item, if it is still pending.
+ *
+ * Returns:
+ * Zero if scrambling is reset successfully, an error code otherwise.
+ */
+int drm_scdc_stop_scrambling(struct drm_connector *connector)
+{
+	struct drm_display_info *info = &connector->display_info;
+	struct drm_connector_hdmi *hdmi = &connector->hdmi;
+
+	if (!hdmi->funcs ||
+	    !hdmi->funcs->scrambler_src_disable) {
+		drm_scdc_dbg(connector, "Function not implemented, bailing.\n");
+		return -EINVAL;
+	}
+
+	if (!READ_ONCE(hdmi->scrambler_enabled))
+		return 0;
+
+	drm_scdc_dbg(connector, "Disabling scrambling\n");
+
+	WRITE_ONCE(hdmi->scrambler_enabled, false);
+	cancel_delayed_work_sync(&hdmi->scdc_work);
+	hdmi->scdc_cb = NULL;
+
+	if (connector->status == connector_status_connected &&
+	    info->is_hdmi && info->hdmi.scdc.supported &&
+	    info->hdmi.scdc.scrambling.supported) {
+		drm_scdc_set_scrambling(connector, false);
+		drm_scdc_set_high_tmds_clock_ratio(connector, false);
+	}
+
+	return hdmi->funcs->scrambler_src_disable(connector);
+}
+EXPORT_SYMBOL(drm_scdc_stop_scrambling);
+
+/**
+ * drm_scdc_sync_status - resync the sink-side SCDC upon reconnect
+ * @connector: connector
+ * @plugged: connector plugged status event
+ * @ctx: lock acquisition context
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
+ * triggered via drm_atomic_helper_connector_hdmi_hotplug_ctx().
+ *
+ * Returns:
+ * Zero on success, an error code otherwise, including -EDEADLOCK.
+ */
+int drm_scdc_sync_status(struct drm_connector *connector, bool plugged,
+			 struct drm_modeset_acquire_ctx *ctx)
+{
+	struct drm_connector_hdmi *hdmi = &connector->hdmi;
+
+	if (!hdmi->funcs)
+		return 0;
+
+	if (plugged && READ_ONCE(hdmi->scrambler_enabled)) {
+		if (!hdmi->funcs->scrambler_src_enable ||
+		    !hdmi->funcs->scrambler_src_disable)
+			return 0;
+
+		return drm_scdc_reset_crtc(connector, ctx);
+	}
+
+	// TODO: Also handle HDMI 2.1 FRL link training
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_scdc_sync_status);
diff --git a/include/drm/display/drm_scdc_helper.h b/include/drm/display/drm_scdc_helper.h
index 34600476a1b9..5d9a37bbb362 100644
--- a/include/drm/display/drm_scdc_helper.h
+++ b/include/drm/display/drm_scdc_helper.h
@@ -29,6 +29,7 @@
 #include <drm/display/drm_scdc.h>
 
 struct drm_connector;
+struct drm_modeset_acquire_ctx;
 struct i2c_adapter;
 
 ssize_t drm_scdc_read(struct i2c_adapter *adapter, u8 offset, void *buffer,
@@ -76,5 +77,8 @@ bool drm_scdc_get_scrambling_status(struct drm_connector *connector);
 
 bool drm_scdc_set_scrambling(struct drm_connector *connector, bool enable);
 bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector, bool set);
-
+int drm_scdc_start_scrambling(struct drm_connector *connector);
+int drm_scdc_stop_scrambling(struct drm_connector *connector);
+int drm_scdc_sync_status(struct drm_connector *connector, bool plugged,
+			 struct drm_modeset_acquire_ctx *ctx);
 #endif

-- 
2.53.0

