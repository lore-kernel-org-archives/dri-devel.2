Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B5EC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C56810F46E;
	Thu,  3 Sep 2026 08:13:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="wIdqqfdH";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D973A10F46E
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 08:13:49 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id A28AB4E414F8;
 Thu,  3 Sep 2026 08:13:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 75D1A602B8;
 Thu,  3 Sep 2026 08:13:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 161EB11C7A01E; 
 Thu,  3 Sep 2026 10:13:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788423227; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=LKBiroZPZQWWT2VlrBMmtMDEWl0tcjxbt1qbvxFX9Pg=;
 b=wIdqqfdHz35qrJkcyKF7fIUUeTDyX1jav3Xh77qcgo2Bb/Ydhfb5wgfGkdKD336vSVgFUI
 kmSvoVNfHci6URG3TvEJZRjf86z/ddhg0mw1sxpJmnjd1ygPKhUokvvuuT2Isln10hGzzD
 HVZKnnhDsOwDbs9QoifkAH6uHWUqb2rIhZi/8zdB1EdJcWhfKipYcBEBNVlA1pRcIq7iUQ
 wZ9RKdo7aIEDUrqK0T9UkFhpNztN8hKJO+ht+FqlMC/i0Shr4wpuqI0XoqcxGrUIKB3YLm
 BQzijNIcajb8GU6gNUb2KlwmIN3HnTFS/AShTgLzpuoZy3Qd3oWyuB1YxRg4uw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 03 Sep 2026 10:11:19 +0200
Subject: [PATCH RFC v2 16/19] drm/omap: dss: don't create a panel_bridge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-drm-bridge-every-panel-v2-16-2ab8ee24538e@bootlin.com>
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
 drivers/gpu/drm/omapdrm/dss/omapdss.h |  1 -
 drivers/gpu/drm/omapdrm/dss/output.c  | 42 ++++-------------------------------
 2 files changed, 4 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss.h b/drivers/gpu/drm/omapdrm/dss/omapdss.h
index 4c22c09c93d5..e3e685c931f1 100644
--- a/drivers/gpu/drm/omapdrm/dss/omapdss.h
+++ b/drivers/gpu/drm/omapdrm/dss/omapdss.h
@@ -204,7 +204,6 @@ struct omap_dss_device {
 	struct dss_device *dss;
 	struct drm_bridge *bridge;
 	struct drm_bridge *next_bridge;
-	struct drm_panel *panel;
 
 	struct list_head list;
 
diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
index 6e9bc605ee22..36d37deac802 100644
--- a/drivers/gpu/drm/omapdrm/dss/output.c
+++ b/drivers/gpu/drm/omapdrm/dss/output.c
@@ -12,7 +12,6 @@
 #include <linux/of_graph.h>
 
 #include <drm/drm_bridge.h>
-#include <drm/drm_panel.h>
 
 #include "dss.h"
 #include "omapdss.h"
@@ -20,40 +19,16 @@
 int omapdss_device_init_output(struct omap_dss_device *out,
 			       struct drm_bridge *local_bridge)
 {
-	struct device_node *remote_node;
+	struct drm_bridge *bridge;
 	int ret;
 
-	remote_node = of_graph_get_remote_node(out->dev->of_node,
-					       out->of_port, 0);
-	if (!remote_node) {
+	bridge = of_drm_get_bridge_by_endpoint(out->dev->of_node, out->of_port, 0);
+	if (IS_ERR(bridge)) {
 		dev_dbg(out->dev, "failed to find video sink\n");
 		return 0;
 	}
 
-	out->panel = of_drm_find_panel(remote_node);
-	if (IS_ERR(out->panel))
-		out->panel = NULL;
-
-	if (!out->panel)
-		out->bridge = of_drm_find_and_get_bridge(remote_node);
-
-	of_node_put(remote_node);
-
-	if (out->panel) {
-		struct drm_bridge *bridge;
-
-		bridge = drm_panel_bridge_add(out->panel);
-		drm_panel_put(out->panel);
-		if (IS_ERR(bridge)) {
-			dev_err(out->dev,
-				"unable to create panel bridge (%ld)\n",
-				PTR_ERR(bridge));
-			ret = PTR_ERR(bridge);
-			goto error;
-		}
-
-		out->bridge = drm_bridge_get(bridge);
-	}
+	out->bridge = bridge;
 
 	if (local_bridge) {
 		if (!out->bridge) {
@@ -65,11 +40,6 @@ int omapdss_device_init_output(struct omap_dss_device *out,
 		out->bridge = drm_bridge_get(local_bridge);
 	}
 
-	if (!out->bridge) {
-		ret = -EPROBE_DEFER;
-		goto error;
-	}
-
 	return 0;
 
 error:
@@ -79,10 +49,6 @@ int omapdss_device_init_output(struct omap_dss_device *out,
 
 void omapdss_device_cleanup_output(struct omap_dss_device *out)
 {
-	if (out->bridge && out->panel)
-		drm_panel_bridge_remove(out->next_bridge ?
-					out->next_bridge : out->bridge);
-
 	drm_bridge_put(out->next_bridge);
 	drm_bridge_put(out->bridge);
 }

-- 
2.55.0

