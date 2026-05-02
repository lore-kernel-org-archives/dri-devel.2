Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F19DCD3423
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 11:55:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36F9310E00C;
	Sat,  2 May 2026 11:55:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VlFiAv+y";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F49A10E00C
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 11:55:56 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-82d0b68837aso1462806b3a.2
 for <dri-devel@lists.freedesktop.org>; Sat, 02 May 2026 04:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777722956; x=1778327756; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xG+dopoE7tyttQuw5xxPLAnkXqhbsfbklISoHSefbCs=;
 b=VlFiAv+yD1IShA4hf5/vKKhe4IM51I7Cox2Bnq7xR6JxummmpNdfS9kdZezCFVWnqS
 SsgB1EKJvIARcYN7srK2YiB2GzQQib9WJszGvdHDewd9mN/7vh+PZc4Jezcp9sJZAMai
 H+dFCw6UxgETfov4GnXMmzwUcE0sPn1XxEeFXABvxakGIt7Gh5MMVyta1SW/hwy5sHBf
 lc+7DV6m4cex479j6/CMYpfms7GSyBT2n1FVcYcAqATHV/m6iGZyaqhHgM0XyNSwr4YY
 aafzS3tveDp4mX77CpFJConBvuzc3LZNH10WxKt4YH7fi9hgNUgBhz2XI+7N5jpf+IOn
 OK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777722956; x=1778327756;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xG+dopoE7tyttQuw5xxPLAnkXqhbsfbklISoHSefbCs=;
 b=dgvbqbVLFKrMdTMkXrOFTEzQgN89nCItQ/2clCjMQbFL7FaU25O54bAjhCQtwdIewk
 LvtoXrjFVn6ef9mNhb6CNLQ/C2dvgDjdWb2UPsFUAB9SUJm0JJW2rE/jVHN1F1D7eTJE
 R+BhGNwDlq511+tdNCGhBpvnj1hNBe+/hTtVCt8aJ6XvXmd9A9Lm0FIQIj2GIIUHiLt+
 Fo+ix1T/LLbp0LmPXeFA3JnCfJgB2+xRKcBkJOcECL1Xrbp6IN2aj0rB6L9Y3T3hG0iR
 mD5BO1XksnXW+IhkdVptI2ymXxQnm485zLOdn6mkI4na06MCzLktjisN3RoxCTiUMNLJ
 6bog==
X-Forwarded-Encrypted: i=1;
 AFNElJ98JafRpL+z3aZFnK2UoJPuRF3v15/QRmqjKTmofTWN2gkbqgmogdikM1WMfjaS7u8RI71o0Pdi6ow=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyC5Unot1UpOHbtS9VAy1cZTrF2DnOxfxmEf04Dp/Qwa5dpV6i1
 8AmgcUZad/bWZpjFd5ErEnk0YdyZ40aliPFJ/gm+KqNQrIgxo3qvq2Ut
X-Gm-Gg: AeBDietNmH2vfBPgrPrtUkUZ0dstSXtghmlYlunynXGUcY//z2CR+aDhfz0Uhn7I9xj
 HGqOWr2Bs7w4xPJbcy4wl7j3+U7cDtrqNl3fcwwH3GWagM7tu+YPupAfTGD2bRjAgP0fliqefJ9
 tOT9932bIAppZJsNvQtnZcYo5kQBfhrBTU82rW1hu1N/fZjrf0LvV4PkiJCY4WqybZnekl3MAie
 T5YWmOBrwhLZvBevifhCYVh2ekSFqJ6Cb2E24sm1jZ4FrMh0h7TL8qX+FCb3LpPLnlOhigmp320
 Ti7PCaKx/OjS8QK5YXuwdk3w8fD8m8vcmNqEQdGJ8Sk+g4Ma4eO1r7UpUO4f91kwYYpD4U0QLWW
 DdlZ8QLAwhVnB+LhcFrTlYWbY6e3AY9zgQntLLQFCPWLc5AKRoqyVtKKBKPRXq9NqJrrrbXcY6D
 Ap4scS3SasIAFbGXbUKAsVhPQW
X-Received: by 2002:a05:6a00:2d10:b0:82f:96ab:e011 with SMTP id
 d2e1a72fcca58-8352d2f802emr2803655b3a.37.1777722955971; 
 Sat, 02 May 2026 04:55:55 -0700 (PDT)
Received: from lgs.. ([101.36.109.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83515b01a4asm5307663b3a.43.2026.05.02.04.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 04:55:55 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
 device_node cleanup
Date: Sat,  2 May 2026 19:55:28 +0800
Message-ID: <20260502115528.530401-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

imx8qxp_pxl2dpi_get_available_ep_from_port() returns ERR_PTR()
on errors. imx8qxp_pxl2dpi_find_next_bridge() stores its return
value in a __free(device_node) variable before checking IS_ERR().
When the function returns on the error path, the cleanup action calls
of_node_put() on the ERR_PTR() value.

Do not let a device_node cleanup variable hold error pointers. Return
the error code from imx8qxp_pxl2dpi_get_available_ep_from_port()
directly and pass the endpoint node through an output argument. This
keeps the cleanup action operating only on NULL or a valid device_node,
while preserving the existing error codes.

This issue was found by a custom static analysis tool.

Fixes: ceea3f7806a10 ("drm/bridge: imx8qxp-pxl2dpi: simplify put of device_node pointers")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v3:
  - Do not change DEFINE_FREE(device_node, ...).
  - Fix the driver pattern by making
    imx8qxp_pxl2dpi_get_available_ep_from_port() return an int and
    pass the endpoint via an output argument.
  - Update both callers so __free(device_node) never holds ERR_PTR().

v2:
  - Fix DEFINE_FREE(device_node, ...) directly.

 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c | 55 +++++++++-----------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
index 441fd32dc91c..a82f10218707 100644
--- a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
+++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
@@ -222,52 +222,52 @@ static const struct drm_bridge_funcs imx8qxp_pxl2dpi_bridge_funcs = {
 			imx8qxp_pxl2dpi_bridge_atomic_get_output_bus_fmts,
 };
 
-static struct device_node *
+static int
 imx8qxp_pxl2dpi_get_available_ep_from_port(struct imx8qxp_pxl2dpi *p2d,
-					   u32 port_id)
+					   u32 port_id,
+					   struct device_node **ep)
 {
-	struct device_node *port, *ep;
+	struct device_node *port __free(device_node) =
+		of_graph_get_port_by_id(p2d->dev->of_node, port_id);
 	int ep_cnt;
 
-	port = of_graph_get_port_by_id(p2d->dev->of_node, port_id);
+	*ep = NULL;
 	if (!port) {
 		DRM_DEV_ERROR(p2d->dev, "failed to get port@%u\n", port_id);
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 	}
 
 	ep_cnt = of_get_available_child_count(port);
 	if (ep_cnt == 0) {
 		DRM_DEV_ERROR(p2d->dev, "no available endpoints of port@%u\n",
 			      port_id);
-		ep = ERR_PTR(-ENODEV);
-		goto out;
+		return -ENODEV;
 	} else if (ep_cnt > 1) {
 		DRM_DEV_ERROR(p2d->dev,
 			      "invalid available endpoints of port@%u\n",
 			      port_id);
-		ep = ERR_PTR(-EINVAL);
-		goto out;
+		return -EINVAL;
 	}
 
-	ep = of_get_next_available_child(port, NULL);
-	if (!ep) {
+	*ep = of_get_next_available_child(port, NULL);
+	if (!*ep) {
 		DRM_DEV_ERROR(p2d->dev,
 			      "failed to get available endpoint of port@%u\n",
 			      port_id);
-		ep = ERR_PTR(-ENODEV);
-		goto out;
+		return -ENODEV;
 	}
-out:
-	of_node_put(port);
-	return ep;
+
+	return 0;
 }
 
 static int imx8qxp_pxl2dpi_find_next_bridge(struct imx8qxp_pxl2dpi *p2d)
 {
-	struct device_node *ep __free(device_node) =
-		imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 1);
-	if (IS_ERR(ep))
-		return PTR_ERR(ep);
+	struct device_node *ep __free(device_node) = NULL;
+	int ret;
+
+	ret = imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 1, &ep);
+	if (ret)
+		return ret;
 
 	struct device_node *remote __free(device_node) = of_graph_get_remote_port_parent(ep);
 	if (!remote || !of_device_is_available(remote)) {
@@ -287,26 +287,23 @@ static int imx8qxp_pxl2dpi_find_next_bridge(struct imx8qxp_pxl2dpi *p2d)
 
 static int imx8qxp_pxl2dpi_set_pixel_link_sel(struct imx8qxp_pxl2dpi *p2d)
 {
-	struct device_node *ep;
+	struct device_node *ep __free(device_node) = NULL;
 	struct of_endpoint endpoint;
 	int ret;
 
-	ep = imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 0);
-	if (IS_ERR(ep))
-		return PTR_ERR(ep);
+	ret = imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 0, &ep);
+	if (ret)
+		return ret;
 
 	ret = of_graph_parse_endpoint(ep, &endpoint);
 	if (ret) {
 		DRM_DEV_ERROR(p2d->dev,
 			      "failed to parse endpoint of port@0: %d\n", ret);
-		goto out;
+		return ret;
 	}
 
 	p2d->pl_sel = endpoint.id;
-out:
-	of_node_put(ep);
-
-	return ret;
+	return 0;
 }
 
 static int imx8qxp_pxl2dpi_parse_dt_companion(struct imx8qxp_pxl2dpi *p2d)
-- 
2.43.0

