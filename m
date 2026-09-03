Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3764BC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61EC110F468;
	Thu,  3 Sep 2026 08:12:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="VN+AEyuh";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CC7310F468
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 08:12:54 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id E6D721A1977;
 Thu,  3 Sep 2026 08:12:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BACCD602B8;
 Thu,  3 Sep 2026 08:12:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AFC1E11C79FFE; 
 Thu,  3 Sep 2026 10:12:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788423156; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Poulp7xYghdU5yIVDl086wKufIjJdAIUgngBY1r33GE=;
 b=VN+AEyuhqoqg41NtWH8LjaeKUXM/iWDLRpJ1cwOEPs5xITqr70IeNx9V957O+IRL0M8GUq
 usV08VsEqwAtjp4tFnmAkWDQ91VukDZV/4+tbSd/U3qVpgyxkSyQXS0mUghUiF4GHGmo3m
 d5qLb/XMYOzNuRVBzm3FWQYiqzRoqbzCLDg9QeAyynrvOCb1hKkZlRTx7iyOkno6sH0nH4
 Yflr07Ybwz6EgjrqQXcwtXJnBfoD/1iy04loQCEYR7dyF0cMkyU+E4K+bUXZ2A8EHqu6Mf
 Zx7RIwFTMduaT7yUV76GM4IkgZQcspJNH7mE3KPyoF+4P3NWhcXLdkX0Z5La+g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 03 Sep 2026 10:11:15 +0200
Subject: [PATCH RFC v2 12/19] drm/bridge: samsung-dsim: don't create a
 panel_bridge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-drm-bridge-every-panel-v2-12-2ab8ee24538e@bootlin.com>
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

Now a panel_bridge is automatically created for every drm_panel, so this
code (similar to an open-coded variant of drm_of_find_panel_or_bridge())
would lead to creating a second bridge for the same panel.

Update and simplify the code by just getting a reference to the
already-existing bridge.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/Kconfig        |  1 -
 drivers/gpu/drm/bridge/samsung-dsim.c | 24 +++++-------------------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 0a1e617b3007..eb16f858459d 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -302,7 +302,6 @@ config DRM_SAMSUNG_DSIM
 	depends on OF && HAS_IOMEM
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
-	select DRM_PANEL_BRIDGE
 	select GENERIC_PHY
 	select GENERIC_PHY_MIPI_DPHY
 	help
diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 5457a7b02a33..ea2837384774 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -25,7 +25,6 @@
 #include <video/mipi_display.h>
 
 #include <drm/bridge/samsung-dsim.h>
-#include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 
 /* returns true iff both arguments logically differs */
@@ -1898,7 +1897,6 @@ static int samsung_dsim_host_attach(struct mipi_dsi_host *host,
 	struct device *dev = dsi->dev;
 	struct device_node *np = dev->of_node;
 	struct device_node *remote;
-	struct drm_panel *panel;
 	int ret = 0;
 
 	/*
@@ -1913,7 +1911,7 @@ static int samsung_dsim_host_attach(struct mipi_dsi_host *host,
 		    of_node_name_eq(remote, "ports"))
 			continue;
 
-		goto of_find_panel_or_bridge;
+		goto of_find_bridge;
 	}
 
 	/*
@@ -1927,25 +1925,13 @@ static int samsung_dsim_host_attach(struct mipi_dsi_host *host,
 
 	remote = of_graph_get_remote_node(np, 1, 0);
 
-of_find_panel_or_bridge:
+of_find_bridge:
 	if (!remote)
 		return -ENODEV;
 
-	panel = of_drm_find_panel(remote);
-	if (!IS_ERR(panel)) {
-		next_bridge = devm_drm_panel_bridge_add(dev, panel);
-		drm_panel_put(panel);
-		if (IS_ERR(next_bridge)) {
-			ret = PTR_ERR(next_bridge);
-			next_bridge = NULL; // Inhibit the cleanup action on an ERR_PTR
-		} else {
-			drm_bridge_get(next_bridge);
-		}
-	} else {
-		next_bridge = of_drm_find_and_get_bridge(remote);
-		if (!next_bridge)
-			ret = -EINVAL;
-	}
+	next_bridge = of_drm_find_and_get_bridge(remote);
+	if (!next_bridge)
+		ret = -EINVAL;
 
 	of_node_put(remote);
 

-- 
2.55.0

