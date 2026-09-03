Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357DBC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 763D910F453;
	Thu,  3 Sep 2026 08:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="fZjUcWN2";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C913210F453
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 08:12:08 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 924234E414EF;
 Thu,  3 Sep 2026 08:12:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 63FD1602B8;
 Thu,  3 Sep 2026 08:12:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 56B6111C79B6F; 
 Thu,  3 Sep 2026 10:11:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788423121; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=3+q8zzzDphveu7bIj+tmklM+ZbtSGClka2kHOxOdEUE=;
 b=fZjUcWN2SEaG5+lt/vdkn6/7ZrRGBZ9m7nW/1FAKSqjxzAxS4eIn3QSPZGiciofBKXyw1/
 HtsDTZg8oBVZxqcTVGQtzsSwuK/lzAcKVTkkBAqqlU23frjCS6qK1OLULxaSIPAGr+pWKE
 oEN05SWtGm6AwdKRmBUcu56gZNMpYXs6XI8alp5qd43txVCZmAsPy7lbfOsSp5vDrSO71u
 BduyBPdHWksMT6YMJgPjnCFe2Z8ufY7tXDSKecqypiWJn8X13UPmwk75wwmJszKwMQrEK4
 Xkp/vWK5I5QJGlu92tqphgT4AF2D/t+qlXrAwFtx54DdqZ/UIFS/pbkhuedHwA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 03 Sep 2026 10:11:07 +0200
Subject: [PATCH RFC v2 04/19] drm/bridge: panel: rename
 drm_bridge_is_panel() -> drm_bridge_is_panel_bridge()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-drm-bridge-every-panel-v2-4-2ab8ee24538e@bootlin.com>
References: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
In-Reply-To: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Albert Esteve <aesteve@redhat.com>, 
 Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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

Work is in progress for every drm_panel to embed a drm_bridge, and for that
a function will be needed in the drm_panel API to tell whether a bridge
represents a panel or something else. The ideal name for that will be
drm_bridge_is_panel(), which however is already in use by the panel_bridge.

Rename the current function in the panel_bridge API to
drm_bridge_is_panel_bridge(), which is more precise and frees up the
drm_bridge_is_panel() for future use in the drm_panel API.

No functional changes, just renaming a function treewide.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/panel.c                 | 8 ++++----
 drivers/gpu/drm/display/drm_bridge_connector.c | 2 +-
 include/drm/drm_bridge.h                       | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 40e3970e8b76..0582c708957c 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -221,17 +221,17 @@ static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 };
 
 /**
- * drm_bridge_is_panel - Checks if a drm_bridge is a panel_bridge.
+ * drm_bridge_is_panel_bridge - Checks if a drm_bridge is a panel_bridge.
  *
  * @bridge: The drm_bridge to be checked.
  *
  * Returns true if the bridge is a panel bridge, or false otherwise.
  */
-bool drm_bridge_is_panel(const struct drm_bridge *bridge)
+bool drm_bridge_is_panel_bridge(const struct drm_bridge *bridge)
 {
 	return bridge->funcs == &panel_bridge_bridge_funcs;
 }
-EXPORT_SYMBOL(drm_bridge_is_panel);
+EXPORT_SYMBOL(drm_bridge_is_panel_bridge);
 
 /**
  * drm_panel_bridge_add - Creates a &drm_bridge and &drm_connector that
@@ -321,7 +321,7 @@ void drm_panel_bridge_remove(struct drm_bridge *bridge)
 	if (!bridge)
 		return;
 
-	if (!drm_bridge_is_panel(bridge)) {
+	if (!drm_bridge_is_panel_bridge(bridge)) {
 		drm_warn(bridge->dev, "%s: called on non-panel bridge!\n", __func__);
 		return;
 	}
diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 00feb73e63d7..5de9b76f345b 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -983,7 +983,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		if (bridge->ddc)
 			ddc = bridge->ddc;
 
-		if (drm_bridge_is_panel(bridge)) {
+		if (drm_bridge_is_panel_bridge(bridge)) {
 			drm_bridge_put(panel_bridge);
 			panel_bridge = drm_bridge_get(bridge);
 		}
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 9f2294957669..b29096d624d5 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1474,7 +1474,7 @@ void drm_bridge_hpd_notify(struct drm_bridge *bridge,
 			   enum drm_connector_status status);
 
 #if IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
-bool drm_bridge_is_panel(const struct drm_bridge *bridge);
+bool drm_bridge_is_panel_bridge(const struct drm_bridge *bridge);
 struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel);
 struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
 					      u32 connector_type);
@@ -1490,7 +1490,7 @@ struct drm_bridge *drmm_panel_bridge_add(struct drm_device *drm,
 					     struct drm_panel *panel);
 struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *bridge);
 #else
-static inline bool drm_bridge_is_panel(const struct drm_bridge *bridge)
+static inline bool drm_bridge_is_panel_bridge(const struct drm_bridge *bridge)
 {
 	return false;
 }

-- 
2.55.0

