Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CE4C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C0C910E455;
	Wed, 16 Sep 2026 13:46:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jcyziUB5";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01EB710E382
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:46:09 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id CA0C11A08E1;
 Wed, 16 Sep 2026 13:46:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 93E7660337;
 Wed, 16 Sep 2026 13:46:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 680BF11C7B03A; 
 Wed, 16 Sep 2026 15:45:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789566365; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=3E/DleiMuFSTLVuEtlsom3pL9KlwnB1jDhq/hJdTS2s=;
 b=jcyziUB5f+XKLfGg0f90awIzxC9+e4tQ7SBLyDxK0rsPfvMLTF/a2qIzDM0NZi0kGUNKne
 cbt+3Rru48IUeIruFPwUZUSISizy3iItoVOFjctwMItV1OpG03FznkKpmPBWIVom9xf+wI
 EmagRqAsvGSlWwzMPa28+1FmoP6oE36mk31CxUyiG64POfR+CsxoVfGTmuelDsBIpgXTi7
 ZYS75G+tvuFOeirSEfjvRdF0Nk3y/mEy5Q5JkFvoLefR7LzLlARB1MWqGHjEXOYlj+isor
 HZ7SOc6wQ+B02C7cASkwslK1d+3XxFFOEpdT73v/qM70wTYvxFwamny/OmVmcQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 16 Sep 2026 15:45:27 +0200
Subject: [PATCH v3 03/19] drm/panel: move to a new module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-drm-bridge-every-panel-v3-3-83afb4f1a707@bootlin.com>
References: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
In-Reply-To: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>, 
 Paul Kocialkowski <paulk@sys-base.io>, Linus Walleij <linusw@kernel.org>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Sean Paul <sean@poorly.run>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: Albert Esteve <aesteve@redhat.com>, 
 Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, asahi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, 
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

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/Makefile      | 2 +-
 drivers/gpu/drm/panel/Kconfig | 2 +-
 include/drm/drm_panel.h       | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e635fcffd379..29c9c1d90c11 100644
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
index bf15e40fd796..34fcbcdda2c8 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -336,7 +336,7 @@ void drm_panel_disable(struct drm_panel *panel);
 
 int drm_panel_get_modes(struct drm_panel *panel, struct drm_connector *connector);
 
-#if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
+#if defined(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL)
 struct drm_panel *of_drm_find_panel(const struct device_node *np);
 int drm_of_find_panel_or_bridge(const struct device_node *np,
 				int port, int endpoint,
@@ -357,7 +357,7 @@ static inline int drm_of_find_panel_or_bridge(const struct device_node *np,
 }
 #endif
 
-#if defined(CONFIG_DRM_PANEL)
+#if IS_ENABLED(CONFIG_DRM_PANEL)
 bool drm_is_panel_follower(struct device *dev);
 int drm_panel_add_follower(struct device *follower_dev,
 			   struct drm_panel_follower *follower);

-- 
2.55.0

