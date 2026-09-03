Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9379C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 113E710F452;
	Thu,  3 Sep 2026 08:12:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="fXn6Z+tM";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D17B610F450
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 08:12:00 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 7AAED4E414EC;
 Thu,  3 Sep 2026 08:11:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4B7E9602B8;
 Thu,  3 Sep 2026 08:11:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9A9EB11C79FA7; 
 Thu,  3 Sep 2026 10:11:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788423114; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Ac6U1uxwnHyqeacioJQ51BQAAM/qss/MivOMoo/pCxg=;
 b=fXn6Z+tMM6gsvXei6kOvXN66XIeWZZvoQbXMrd/EKBqeFsiXIUNvYpiOgwVPQRH+cEovmL
 wc9lfJauwFxuWHF2y+CeyZcr5Sz9qb3qHiFzZAQHNFwKuLbCmSI6UeB+mjngpU5hJyvvPv
 Qbl9iwpvTAvHge6+6Bv49ZJeG99/KuDP7ttfhBp0ci5bOC6M95ahlcW9Uk/f/iLuKxw8Ys
 5qFoZiQcE4hF82VKYcIefC1oUftn6nDPDh+UdOObWsoCL3gupa8Wu4R9SGG3a0pzSoi/gt
 NcNVVHXXVPIO2Y2izkhhrDgZEcVVHdS4a3VHk8oJaiRfLHYEFt0Cl3jJQsThAg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 03 Sep 2026 10:11:06 +0200
Subject: [PATCH RFC v2 03/19] drm/panel: move to a new module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-drm-bridge-every-panel-v2-3-2ab8ee24538e@bootlin.com>
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

To avoid the main drm module to depend on other drm modules and create a
depepdency loop, move drm_panel.o to a new drm_panel module, so the module
dependency will be drm_panel -> drm_kms_helper instead.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/Makefile      | 2 +-
 drivers/gpu/drm/panel/Kconfig | 2 +-
 include/drm/drm_panel.h       | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index c4509e7fd248..9a8df14ef628 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -79,7 +79,6 @@ drm-$(CONFIG_DRM_CLIENT) += \
 	drm_client_modeset.o \
 	drm_client_sysrq.o
 drm-$(CONFIG_COMPAT) += drm_ioc32.o
-drm-$(CONFIG_DRM_PANEL) += drm_panel.o
 drm-$(CONFIG_OF) += drm_of.o
 drm-$(CONFIG_PCI) += drm_pci.o
 drm-$(CONFIG_DEBUG_FS) += \
@@ -96,6 +95,7 @@ drm-$(CONFIG_DRM_PANIC_SCREEN_QR_CODE) += drm_panic_qr.o
 drm-$(CONFIG_DRM_RAS) += drm_ras.o drm_ras_nl.o drm_ras_genl_family.o
 obj-$(CONFIG_DRM)	+= drm.o
 
+obj-$(CONFIG_DRM_PANEL) += drm_panel.o
 obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) += drm_panel_orientation_quirks.o
 obj-$(CONFIG_DRM_PANEL_BACKLIGHT_QUIRKS) += drm_panel_backlight_quirks.o
 
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 747f47347521..0a79a0558101 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_PANEL
-	bool
+	tristate
 	depends on DRM
 	help
 	  Panel registration and lookup framework.
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index b87323443f49..08949d41d743 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -335,7 +335,7 @@ void drm_panel_disable(struct drm_panel *panel);
 
 int drm_panel_get_modes(struct drm_panel *panel, struct drm_connector *connector);
 
-#if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
+#if defined(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL)
 struct drm_panel *of_drm_find_panel(const struct device_node *np);
 #else
 static inline struct drm_panel *of_drm_find_panel(const struct device_node *np)
@@ -344,7 +344,7 @@ static inline struct drm_panel *of_drm_find_panel(const struct device_node *np)
 }
 #endif
 
-#if defined(CONFIG_DRM_PANEL)
+#if IS_ENABLED(CONFIG_DRM_PANEL)
 bool drm_is_panel_follower(struct device *dev);
 int drm_panel_add_follower(struct device *follower_dev,
 			   struct drm_panel_follower *follower);

-- 
2.55.0

