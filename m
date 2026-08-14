Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9016BC5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE5B810F601;
	Fri, 14 Aug 2026 14:07:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="MA44EJQx";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EECC10F601
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:07:19 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id E655F1A163F;
 Fri, 14 Aug 2026 14:07:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B31CA6046D;
 Fri, 14 Aug 2026 14:07:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 15BA111C4EDA6; 
 Fri, 14 Aug 2026 16:07:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786716436; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=wBKbzNKqN/AUW/MwcDfWph24Igbq8cdctbKLdKXyxMI=;
 b=MA44EJQxDJD9YBscVgJPSCgKZ2FjvIFFUD99HvnMfux9U1pk8YdDXdVceO/7xENKxrCpan
 IOcjjqf61V8zrYcGBDFfv9eY+Iy68TLeixTdTHYONql2iFIR0ztFReB3PZH4e83lsSdEWX
 WbLQ3BkdAqcE3duj8pO7FPl3FoDsNHbAGHvAqMajZvg4e3CYl0n2opgaVBJp73ApcQg6qA
 hRWiBTJtwYHzh0aCaDlLW1Phqpp+I+2zrg43wIyOfKaYL7+h1xkh3heQ5mvCOovQSHN70H
 UJIaE6ZFfbxC4rviQ7SDwlJSN6UrbW6CNEXVWlQY+nGaP2eIDvAjxiOZga/NWw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 14 Aug 2026 16:05:59 +0200
Subject: [PATCH 11/11] drm/bridge: samsung-dsim: don't create a
 panel_bridge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-bridge-every-panel-v1-11-19cd5277cc8d@bootlin.com>
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

Now a panel_bridge is automatically created for every drm_panel, so this
code (similar to an open-coded variant of drm_of_find_panel_or_bridge())
would lead to creating a second panel_bridge for the same panel.

Fix and simplify the code by just getting a reference to the
already-existing bridge.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 5457a7b02a33..55d4e3aedb3d 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1898,7 +1898,6 @@ static int samsung_dsim_host_attach(struct mipi_dsi_host *host,
 	struct device *dev = dsi->dev;
 	struct device_node *np = dev->of_node;
 	struct device_node *remote;
-	struct drm_panel *panel;
 	int ret = 0;
 
 	/*
@@ -1931,21 +1930,9 @@ static int samsung_dsim_host_attach(struct mipi_dsi_host *host,
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

