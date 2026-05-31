Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978C4CD6E5E
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 11:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C922112AF8;
	Sun, 31 May 2026 11:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iXyvi0f0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58183112AEC;
 Sun, 31 May 2026 11:49:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3FCCC44635;
 Sun, 31 May 2026 11:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CF31F00898;
 Sun, 31 May 2026 11:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780228162;
 bh=OCmzLrDf11CowVnaLX9u60t3iwYDZIlAE1pIoNvP2BY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iXyvi0f0U6r8UnczNjbKHTyDkq+BJKNuRfcMfq/Oa7isv0oJYXV4kcQgzN1pao2Az
 Wa/ENw2B/eJg8Ay0dlJPMjNAm2NGNkAFlECI2hXXnFjG1v+jheJ1mtUA2qG5ikIfzA
 BdsmlZrSn2Z7PiJu5k8ERDSGK3U63McowqQwIc7S8xI4IEwfE0zoczVIR4JR4JrvQM
 58jSK7S/bj0zxSt+rVN40E0UAVlqjE0gdiIKGmIGpK396l0IuXhvr7kzV0b9EtYIjb
 PxYpDpS5nOzsQrtzIe4lEszOq9SF+G6XnfkI5T67Mtp19oEZYh0QpxBN1Yy6LQ4FSl
 jaizrHvFKVYVA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v5 10/11] drm/bridge: auto-link panel backlight in bridge
 connector
Date: Sun, 31 May 2026 06:49:07 -0500
Message-ID: <20260531114908.1693426-11-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531114908.1693426-1-superm1@kernel.org>
References: <20260531114908.1693426-1-superm1@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The link should allow clients to change luminance property.

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> # SM8150-HDK
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v5:
 * Add tag
---
 drivers/gpu/drm/bridge/panel.c                 | 15 +++++++++++++++
 drivers/gpu/drm/display/drm_bridge_connector.c | 15 ++++++++++++++-
 include/drm/drm_bridge.h                       |  1 +
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 184a8b7049a7..1dbd3ba75903 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -233,6 +233,21 @@ bool drm_bridge_is_panel(const struct drm_bridge *bridge)
 }
 EXPORT_SYMBOL(drm_bridge_is_panel);
 
+/**
+ * drm_panel_bridge_to_panel - get the drm_panel wrapped by a panel bridge
+ * @bridge: the panel bridge
+ *
+ * Returns the &drm_panel wrapped by @bridge, or NULL if @bridge is not a
+ * panel bridge.
+ */
+struct drm_panel *drm_panel_bridge_to_panel(struct drm_bridge *bridge)
+{
+	if (!drm_bridge_is_panel(bridge))
+		return NULL;
+	return drm_bridge_to_panel_bridge(bridge)->panel;
+}
+EXPORT_SYMBOL(drm_panel_bridge_to_panel);
+
 /**
  * drm_panel_bridge_add - Creates a &drm_bridge and &drm_connector that
  * just calls the appropriate functions from &drm_panel.
diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 39cc18f78eda..a1d54f7bac6a 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -11,7 +11,9 @@
 #include <linux/slab.h>
 
 #include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_panel.h>
 #include <drm/drm_bridge_connector.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_device.h>
@@ -1048,9 +1050,20 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		connector->polled = DRM_CONNECTOR_POLL_CONNECT
 				  | DRM_CONNECTOR_POLL_DISCONNECT;
 
-	if (panel_bridge)
+	if (panel_bridge) {
+		struct drm_panel *panel;
+
 		drm_panel_bridge_set_orientation(connector, panel_bridge);
 
+		panel = drm_panel_bridge_to_panel(panel_bridge);
+		if (panel && panel->backlight) {
+			ret = drm_backlight_alloc(connector);
+			if (!ret)
+				drm_backlight_link(connector->backlight,
+						   panel->backlight);
+		}
+	}
+
 	if (support_hdcp && IS_REACHABLE(CONFIG_DRM_DISPLAY_HELPER) &&
 	    IS_ENABLED(CONFIG_DRM_DISPLAY_HDCP_HELPER))
 		drm_connector_attach_content_protection_property(connector, true);
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index a8d67bd9ee50..6cc2a22b2dec 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1558,6 +1558,7 @@ void drm_bridge_hpd_notify(struct drm_bridge *bridge,
 
 #ifdef CONFIG_DRM_PANEL_BRIDGE
 bool drm_bridge_is_panel(const struct drm_bridge *bridge);
+struct drm_panel *drm_panel_bridge_to_panel(struct drm_bridge *bridge);
 struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel);
 struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
 					      u32 connector_type);
-- 
2.54.0

