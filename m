Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0808BC5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:07:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FEFF10F5FD;
	Fri, 14 Aug 2026 14:07:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WIPS4UAV";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFAE610F5FD
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:07:08 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 7D12B4E41244;
 Fri, 14 Aug 2026 14:07:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 506F56046D;
 Fri, 14 Aug 2026 14:07:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 757E511C4EDA1; 
 Fri, 14 Aug 2026 16:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786716426; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=trlbVuPsHDRX0y+Dzwj1wjF2hFnAKucY/izeM875Oyc=;
 b=WIPS4UAVR70N55fEk0oZXnD1u6K1ADHbs8NvDuKJJ/MT5gl6IiSusvx+yjUZY4nElWBqOB
 rEzecEnra9M8T/2m5ELwj9d/5Ebbaccm0w3vW8j3/gmbZY76YFLadgviaj9trtZXpbt6eM
 A+sYI1b5HXfTFDBAL4+LnUZLlsOQesWvf2zXX/nX7BNmumJ+OWxgyXBDcdAZakXUEikLVD
 lYVgB6myrxe5fnuRVh13Fv9Dlmq9Ibxc/rTnR8MadH/yw9doDzMdZvzXfcn4sQ+8kHBFbU
 8IPfElplRrywmcyF5hTQJV0qLaeU5x4eHcm4eEuCjHqp96aGCGzUj7biFMPVnQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 14 Aug 2026 16:05:56 +0200
Subject: [PATCH 08/11] drm/mcde: dsi: simplify device_node management using
 scoped for_each variant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-bridge-every-panel-v1-8-19cd5277cc8d@bootlin.com>
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
In-Reply-To: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
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
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
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

Before further modifying this function, simpify the struct device_node
management using the scoped variat of for_each_available_child_of_node().

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/mcde/mcde_dsi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_dsi.c
index 694372581840..ce078aa3910f 100644
--- a/drivers/gpu/drm/mcde/mcde_dsi.c
+++ b/drivers/gpu/drm/mcde/mcde_dsi.c
@@ -1076,7 +1076,6 @@ static int mcde_dsi_bind(struct device *dev, struct device *master,
 	struct drm_device *drm = data;
 	struct mcde *mcde = to_mcde(drm);
 	struct mcde_dsi *d = dev_get_drvdata(dev);
-	struct device_node *child;
 	struct drm_panel *panel = NULL;
 	struct drm_bridge *bridge __free(drm_bridge_put) = NULL;
 
@@ -1104,7 +1103,7 @@ static int mcde_dsi_bind(struct device *dev, struct device *master,
 	}
 
 	/* Look for a panel as a child to this node */
-	for_each_available_child_of_node(dev->of_node, child) {
+	for_each_available_child_of_node_scoped(dev->of_node, child) {
 		panel = of_drm_find_panel(child);
 		if (IS_ERR(panel)) {
 			dev_err(dev, "failed to find panel try bridge (%ld)\n",
@@ -1114,15 +1113,12 @@ static int mcde_dsi_bind(struct device *dev, struct device *master,
 			bridge = of_drm_find_and_get_bridge(child);
 			if (!bridge) {
 				dev_err(dev, "failed to find bridge\n");
-				of_node_put(child);
 				return -EINVAL;
 			}
 		}
 
-		if (panel || bridge) {
-			of_node_put(child);
+		if (panel || bridge)
 			break;
-		}
 	}
 	if (panel) {
 		bridge = drm_panel_bridge_add_typed(panel,

-- 
2.55.0

