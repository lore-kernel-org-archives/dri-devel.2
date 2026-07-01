Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD53C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A48710E65F;
	Wed,  1 Jul 2026 12:11:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Md19TPP3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k04bK3Td";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Md19TPP3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k04bK3Td";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C18010E65F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:11:07 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 248C776013;
 Wed,  1 Jul 2026 12:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782907862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eUeZcwjNbf8rJAMAoW6B/bSmTtWrp+UCqx+uQF/fH8=;
 b=Md19TPP3+C2qWMS7DcCJOhUFTyrrqp5ywBsXEJil1oz8b+MMIrHk36JRzNviRsLxHeLHlj
 C8xLG70i3mcVJpO6VyVG9EDpLWCef/liKVfV08EtAtABsX+FM5spOoH39DZV5y72vLsBC2
 J/+m2TU43AFezDgsF2t08rPw+SKTZ1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782907862;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eUeZcwjNbf8rJAMAoW6B/bSmTtWrp+UCqx+uQF/fH8=;
 b=k04bK3TdeI2RQ/gU26h0UW0D5vn9W/vjaL/uI2GW/vjfi3XZDkO02E56mD1BatCdG90XGi
 6DQ8/CHGYeA5IpBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Md19TPP3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=k04bK3Td
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782907862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eUeZcwjNbf8rJAMAoW6B/bSmTtWrp+UCqx+uQF/fH8=;
 b=Md19TPP3+C2qWMS7DcCJOhUFTyrrqp5ywBsXEJil1oz8b+MMIrHk36JRzNviRsLxHeLHlj
 C8xLG70i3mcVJpO6VyVG9EDpLWCef/liKVfV08EtAtABsX+FM5spOoH39DZV5y72vLsBC2
 J/+m2TU43AFezDgsF2t08rPw+SKTZ1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782907862;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eUeZcwjNbf8rJAMAoW6B/bSmTtWrp+UCqx+uQF/fH8=;
 b=k04bK3TdeI2RQ/gU26h0UW0D5vn9W/vjaL/uI2GW/vjfi3XZDkO02E56mD1BatCdG90XGi
 6DQ8/CHGYeA5IpBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1402779AC;
 Wed,  1 Jul 2026 12:11:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MCEkJtUDRWozOQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 01 Jul 2026 12:11:01 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: treding@nvidia.com, javierm@redhat.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, dianders@chromium.org, megi@xff.cz,
 igor@reznichenko.net, mwalle@kernel.org,
 dario.binacchi@amarulasolutions.com, jagan@edgeble.ai,
 laurent.pinchart@ideasonboard.com, lujianhua000@gmail.com, agx@sigxcpu.org,
 kernel@puri.sm, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 1/3] drm/of: Implement drm_of_get_panel_orientation()
Date: Wed,  1 Jul 2026 14:03:18 +0200
Message-ID: <20260701121055.192475-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701121055.192475-1-tzimmermann@suse.de>
References: <20260701121055.192475-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 248C776013
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[21];
 FREEMAIL_TO(0.00)[nvidia.com,redhat.com,linaro.org,gmail.com,chromium.org,xff.cz,reznichenko.net,kernel.org,amarulasolutions.com,edgeble.ai,ideasonboard.com,sigxcpu.org,puri.sm,linux.intel.com,ffwll.ch];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RL579wqeubg1zrmib5eo1wpfcd)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
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

