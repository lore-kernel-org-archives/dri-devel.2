Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDD9CDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:45:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B504610F203;
	Thu, 25 Jun 2026 09:45:44 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60C4A10F204
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:45:31 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2E10771A05;
 Thu, 25 Jun 2026 09:45:20 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4625779AB;
 Thu, 25 Jun 2026 09:45:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qLalMq/4PGqaBQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 25 Jun 2026 09:45:19 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, treding@nvidia.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 neil.armstrong@linaro.org, jesszhan0024@gmail.com, rayyan@ansari.sh
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 6/7] drm/of: Implement drm_of_get_panel_orientation()
Date: Thu, 25 Jun 2026 11:39:38 +0200
Message-ID: <20260625094509.157581-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625094509.157581-1-tzimmermann@suse.de>
References: <20260625094509.157581-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 2E10771A05
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
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

Implement drm_of_get_panel_orientation() to retrieve a panel's
rotation property as enum drm_panel_orientation. The code has
been taken from of_drm_get_panel_orientation(), so convert that
helper over. Callers of the old helper can be converted as well.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_of.c    | 44 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_panel.c | 26 ++--------------------
 include/drm/drm_of.h        | 11 ++++++++++
 3 files changed, 57 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index d03ada82eac9..96eef327bf7e 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -7,6 +7,7 @@
 #include <linux/of_graph.h>
 
 #include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_device.h>
 #include <drm/drm_encoder.h>
@@ -220,6 +221,49 @@ int drm_of_encoder_active_endpoint(struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(drm_of_encoder_active_endpoint);
 
+/**
+ * drm_of_get_panel_orientation - look up the orientation of the panel through
+ * the "rotation" binding from a device tree node
+ * @np: device tree node of the panel
+ * @orientation: orientation enum to be filled in
+ *
+ * Looks up the rotation of a panel in the device tree. The orientation of the
+ * panel is expressed as a property name "rotation" in the device tree. The
+ * rotation in the device tree is counter clockwise.
+ *
+ * Return: 0 when a valid rotation value (0, 90, 180, or 270) is read or the
+ * rotation property doesn't exist. Return a negative error code on failure.
+ */
+int drm_of_get_panel_orientation(const struct device_node *np,
+				 enum drm_panel_orientation *orientation)
+{
+	int rotation, ret;
+
+	ret = of_property_read_u32(np, "rotation", &rotation);
+	if (ret == -EINVAL) {
+		/* Don't return an error if there's no rotation property. */
+		*orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
+		return 0;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	if (rotation == 0)
+		*orientation = DRM_MODE_PANEL_ORIENTATION_NORMAL;
+	else if (rotation == 90)
+		*orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP;
+	else if (rotation == 180)
+		*orientation = DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP;
+	else if (rotation == 270)
+		*orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(drm_of_get_panel_orientation);
+
 /**
  * drm_of_find_panel_or_bridge - return connected panel or bridge device
  * @np: device tree node containing encoder output ports
diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 2c5649e433df..eddd13a34c03 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -28,6 +28,7 @@
 #include <linux/of.h>
 
 #include <drm/drm_crtc.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 
@@ -508,30 +509,7 @@ EXPORT_SYMBOL(of_drm_find_panel);
 int of_drm_get_panel_orientation(const struct device_node *np,
 				 enum drm_panel_orientation *orientation)
 {
-	int rotation, ret;
-
-	ret = of_property_read_u32(np, "rotation", &rotation);
-	if (ret == -EINVAL) {
-		/* Don't return an error if there's no rotation property. */
-		*orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
-		return 0;
-	}
-
-	if (ret < 0)
-		return ret;
-
-	if (rotation == 0)
-		*orientation = DRM_MODE_PANEL_ORIENTATION_NORMAL;
-	else if (rotation == 90)
-		*orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP;
-	else if (rotation == 180)
-		*orientation = DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP;
-	else if (rotation == 270)
-		*orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP;
-	else
-		return -EINVAL;
-
-	return 0;
+	return drm_of_get_panel_orientation(np, orientation);
 }
 EXPORT_SYMBOL(of_drm_get_panel_orientation);
 #endif
diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index 7bcc0ccfe0f4..ebebed14c611 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -20,6 +20,8 @@ struct device_node;
 struct mipi_dsi_device_info;
 struct mipi_dsi_host;
 
+enum drm_panel_orientation;
+
 /**
  * enum drm_lvds_dual_link_pixels - Pixel order of an LVDS dual-link connection
  * @DRM_LVDS_DUAL_LINK_EVEN_ODD_PIXELS: Even pixels are expected to be generated
@@ -47,6 +49,8 @@ int drm_of_component_probe(struct device *dev,
 int drm_of_encoder_active_endpoint(struct device_node *node,
 				   struct drm_encoder *encoder,
 				   struct of_endpoint *endpoint);
+int drm_of_get_panel_orientation(const struct device_node *np,
+				 enum drm_panel_orientation *orientation);
 int drm_of_find_panel_or_bridge(const struct device_node *np,
 				int port, int endpoint,
 				struct drm_panel **panel,
@@ -101,6 +105,13 @@ static inline int drm_of_encoder_active_endpoint(struct device_node *node,
 {
 	return -EINVAL;
 }
+
+static inline int drm_of_get_panel_orientation(const struct device_node *np,
+					       enum drm_panel_orientation *orientation)
+{
+	return -EINVAL;
+}
+
 static inline int drm_of_find_panel_or_bridge(const struct device_node *np,
 					      int port, int endpoint,
 					      struct drm_panel **panel,
-- 
2.54.0

