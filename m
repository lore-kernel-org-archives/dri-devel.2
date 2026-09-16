Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26A8C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D681210EAF4;
	Wed, 16 Sep 2026 13:48:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="QGALR/4F";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B74F10EAF4
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:48:08 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id EC6154E40736;
 Wed, 16 Sep 2026 13:48:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B9F0660337;
 Wed, 16 Sep 2026 13:48:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8B57111C7B031; 
 Wed, 16 Sep 2026 15:47:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789566480; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=WuZX7Ld13ojOYCTY0ar+bokEZLNX0F8BwuavdUHGtR8=;
 b=QGALR/4FPgZgsJZy9ShvO3e3wFndnrRlRApyWADH7o1KovktZ6gvPgK5F3GcNw7Xi4G2vp
 jDl32gEpAtULcO8jsBkGW+p7uDlw04AuoovRFl1g/lx8/75D5MKKLRDH7kwUVFAKp6ithU
 HsjCJjTIVNmRSKBUP6bM2vX7HQXd/kqGyPzL6AO4iI+iB8TusNMlHxNFUkb36uwwAwc8uN
 SCVmLoMR/scL/Jz4EBOAuzAQD02IYoVrIYq1MNN03qOCft36nfQHBx5Wm8NopxtVSHKIC0
 +7q6jNwndNZrUZpcLnB+S5CsGCAtKzdXd2tLF5blJtYK8fz7pJolZTed0/UZHQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 16 Sep 2026 15:45:41 +0200
Subject: [PATCH v3 17/19] drm/omap: dss: don't create a panel_bridge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-drm-bridge-every-panel-v3-17-83afb4f1a707@bootlin.com>
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

Now a panel_bridge is automatically created for every drm_panel and the
panel-bridge API is just a deprecated wrapper to access it.

Update and simplify the code by just getting a reference to the
already-existing bridge using of_drm_get_bridge_by_endpoint().

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

