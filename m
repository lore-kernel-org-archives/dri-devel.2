Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F61C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01A4310F441;
	Thu,  3 Sep 2026 08:11:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Kv5ck8ug";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D5310F441
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 08:11:52 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id BD2E51A1987;
 Thu,  3 Sep 2026 08:11:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 880FD602B8;
 Thu,  3 Sep 2026 08:11:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1AED611C79F4D; 
 Thu,  3 Sep 2026 10:11:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788423106; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=9WQOccbPaT9UPCqLuBrVXtuan/Bg0V6ruJZaFOpIPn4=;
 b=Kv5ck8ug0QwFbHH4HaQ9Ei0/+5XB/kC56I+vVB6DBFSlTkYdCVrfmE5vkyJEr6rhjsAIW/
 MymigWh6ke5KnofiSc3Gy0M8XsMHQr1+Wma7xSZFOi47D1eWiYLnGCQIiZ8cxP9l0DFmR7
 2v4ukdYujoo+0GnGLVp46TV+543k6xvuKxMTtreZPsoCMETuLpi4M2JqWefD16w59p3zXQ
 VqctvQscWJ4nal1GLas2ERWGj0wfJeo2O/4U4Fbo0x6fJakGN2gxIOdiv1ZqM8xmIJ4Hti
 sjAr1Npv+7/VzAFZ0ave4iPrtkzhkT+I8oUJ+9300ZI7SCRynn0SlrzcNDXqxw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 03 Sep 2026 10:11:05 +0200
Subject: [PATCH RFC v2 02/19] drm/bridge: panel: move to a new module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-drm-bridge-every-panel-v2-2-2ab8ee24538e@bootlin.com>
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

Work is in progress for every drm_panel to embed a drm_bridge, which will
make the drm_panel code (currently in the drm module) depend on the
drm_kms_helper module.

However that would create a dependency loop:

 * the panel_bridge code in bridge/panel.c [drm_kms_helper module]
   already depends on the drm_panel.c code (it manipulates a drm_panel)
 * additionally, the drm_panel.c code, in order to create a drm_bridge,
   will depend on the helpers in drm_atomic_helper and drm_probe_helper
   code [drm_kms_helper module]

Prevent the loop by moving the panel bridge out to its own module.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/Makefile       | 3 ++-
 drivers/gpu/drm/bridge/Kconfig | 2 +-
 drivers/gpu/drm/bridge/panel.c | 3 +++
 include/drm/drm_bridge.h       | 4 ++--
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e635fcffd379..c4509e7fd248 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -156,10 +156,11 @@ drm_kms_helper-y := \
 	drm_self_refresh_helper.o \
 	drm_simple_kms_helper.o \
 	drm_vblank_helper.o
-drm_kms_helper-$(CONFIG_DRM_PANEL_BRIDGE) += bridge/panel.o
 drm_kms_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fb_helper.o
 obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
 
+obj-$(CONFIG_DRM_PANEL_BRIDGE) += bridge/panel.o
+
 #
 # Drivers and the rest
 #
diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 89e87460aefc..0a1689f8209d 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -6,7 +6,7 @@ config DRM_BRIDGE
 	  Bridge registration and lookup framework.
 
 config DRM_PANEL_BRIDGE
-	def_bool y
+	def_tristate y
 	depends on DRM_BRIDGE
 	select DRM_PANEL
 	help
diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 83be09641582..40e3970e8b76 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -624,3 +624,6 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 EXPORT_SYMBOL_GPL(drm_of_find_panel_or_bridge);
 
 #endif
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Panel bridge helper");
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index c5b82e6946f5..9f2294957669 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1473,7 +1473,7 @@ void drm_bridge_hpd_disable(struct drm_bridge *bridge);
 void drm_bridge_hpd_notify(struct drm_bridge *bridge,
 			   enum drm_connector_status status);
 
-#ifdef CONFIG_DRM_PANEL_BRIDGE
+#if IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
 bool drm_bridge_is_panel(const struct drm_bridge *bridge);
 struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel);
 struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
@@ -1502,7 +1502,7 @@ static inline int drm_panel_bridge_set_orientation(struct drm_connector *connect
 }
 #endif
 
-#if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE)
+#if defined(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
 struct drm_bridge *devm_drm_of_get_bridge(struct device *dev, struct device_node *node,
 					  u32 port, u32 endpoint);
 struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm, struct device_node *node,

-- 
2.55.0

