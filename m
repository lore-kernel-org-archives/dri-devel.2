Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C38CD6E61
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 22:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47AB710FE8D;
	Mon,  1 Jun 2026 22:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="qZz1vVDC";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B36410F817
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 22:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780353914;
 bh=qd5KmmczyZ6wEzeipbZ7XdsJaimi0OgdnkXBt1vaPbw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=qZz1vVDCrHWuuwThR8nqtR1sCRtHFi1Ix37vgaWBRPc5g17f8243PY+U2njtBEpS9
 4bI6B3G9f4oDcuqY6BDR9vnrvrBeQMOTzXKJ6ZaxfZGXZ4lwUeO1rMqRa7poBeahZR
 mjbFDUHEpljJOBR78QkPS6gHhZzrfYeOx4KX/4RzU77PX+gkSJ7Z0IfKpWfcoJRb6r
 HrhH63oflUMUFX8bcxMdVBYpH/suYraYBPdNsESoASBOYycNT3sQy3WNhp3QdEsaiu
 WdtXcRoHie+x5IOONXeTH5Vnaeh6hwENhUlzSHPGIUe2uUgUKDqs5AzvpJp8uJLran
 8gVzUuuU2xz4w==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0F4A517E0B69;
 Tue,  2 Jun 2026 00:45:14 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Jun 2026 01:44:05 +0300
Subject: [PATCH v7 05/30] drm/display: hdmi_state_helper: Add ctx-aware
 hotplug helper for SCDC sync
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dw-hdmi-qp-scramb-v7-5-445eb54ee1ed@collabora.com>
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

Introduce drm_atomic_helper_connector_hdmi_hotplug_ctx(), a variant of
drm_atomic_helper_connector_hdmi_hotplug() that accepts a
drm_modeset_acquire_ctx.

This enables SCDC status synchronization on hotplug events, which
requires lock acquisition context for performing the CRTC reset
triggered by drm_scdc_sync_status().

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 40 ++++++++++++++++++++-----
 include/drm/display/drm_hdmi_state_helper.h     |  4 +++
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index a331ebdd65af..a96d81cbf94f 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -12,6 +12,7 @@
 #include <drm/display/drm_hdmi_cec_helper.h>
 #include <drm/display/drm_hdmi_helper.h>
 #include <drm/display/drm_hdmi_state_helper.h>
+#include <drm/display/drm_scdc_helper.h>
 
 /**
  * DOC: hdmi helpers
@@ -1150,18 +1151,20 @@ drm_atomic_helper_connector_hdmi_clear_audio_infoframe(struct drm_connector *con
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_clear_audio_infoframe);
 
-static void
+static int
 drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
-					enum drm_connector_status status)
+					enum drm_connector_status status,
+					struct drm_modeset_acquire_ctx *ctx)
 {
 	const struct drm_edid *drm_edid;
+	int ret = 0;
 
 	if (status == connector_status_disconnected) {
-		// TODO: also handle scramber, HDMI sink disconnected.
+		ret = drm_scdc_sync_status(connector, false, ctx);
 		drm_connector_hdmi_audio_plugged_notify(connector, false);
 		drm_edid_connector_update(connector, NULL);
 		drm_connector_cec_phys_addr_invalidate(connector);
-		return;
+		return ret;
 	}
 
 	if (connector->hdmi.funcs->read_edid)
@@ -1174,10 +1177,12 @@ drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
 	drm_edid_free(drm_edid);
 
 	if (status == connector_status_connected) {
-		// TODO: also handle scramber, HDMI sink is now connected.
+		ret = drm_scdc_sync_status(connector, true, ctx);
 		drm_connector_hdmi_audio_plugged_notify(connector, true);
 		drm_connector_cec_phys_addr_set(connector);
 	}
+
+	return ret;
 }
 
 /**
@@ -1191,10 +1196,31 @@ drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
 void drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
 					      enum drm_connector_status status)
 {
-	drm_atomic_helper_connector_hdmi_update(connector, status);
+	drm_atomic_helper_connector_hdmi_update(connector, status, NULL);
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_hotplug);
 
+/**
+ * drm_atomic_helper_connector_hdmi_hotplug_ctx - Handle the hotplug event for the HDMI connector
+ * @connector: A pointer to the HDMI connector
+ * @status: Connection status
+ * @ctx: Lock acquisition context to be used for resetting CRTC
+ *
+ * This function should be called as a part of the .detect() / .detect_ctx()
+ * callbacks for all status changes.
+ *
+ * Returns:
+ * Zero on success, error code on failure.
+ * If @ctx is set, it might also return -EDEADLK.
+ */
+int drm_atomic_helper_connector_hdmi_hotplug_ctx(struct drm_connector *connector,
+						 enum drm_connector_status status,
+						 struct drm_modeset_acquire_ctx *ctx)
+{
+	return drm_atomic_helper_connector_hdmi_update(connector, status, ctx);
+}
+EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_hotplug_ctx);
+
 /**
  * drm_atomic_helper_connector_hdmi_force - HDMI Connector implementation of the force callback
  * @connector: A pointer to the HDMI connector
@@ -1206,6 +1232,6 @@ EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_hotplug);
  */
 void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connector)
 {
-	drm_atomic_helper_connector_hdmi_update(connector, connector->status);
+	drm_atomic_helper_connector_hdmi_update(connector, connector->status, NULL);
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_force);
diff --git a/include/drm/display/drm_hdmi_state_helper.h b/include/drm/display/drm_hdmi_state_helper.h
index 13375bd0f4ae..75fedd4a3ba8 100644
--- a/include/drm/display/drm_hdmi_state_helper.h
+++ b/include/drm/display/drm_hdmi_state_helper.h
@@ -7,6 +7,7 @@ struct drm_atomic_commit;
 struct drm_connector;
 struct drm_connector_state;
 struct drm_display_mode;
+struct drm_modeset_acquire_ctx;
 struct hdmi_audio_infoframe;
 
 enum drm_connector_status;
@@ -24,6 +25,9 @@ int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connector *con
 						       struct drm_atomic_commit *state);
 void drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
 					      enum drm_connector_status status);
+int drm_atomic_helper_connector_hdmi_hotplug_ctx(struct drm_connector *connector,
+						 enum drm_connector_status status,
+						 struct drm_modeset_acquire_ctx *ctx);
 void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connector);
 
 enum drm_mode_status

-- 
2.54.0

