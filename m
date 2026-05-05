Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4011EFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 08:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ACA410E0DA;
	Tue,  5 May 2026 08:22:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a2YUFtga";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBA1310E0DA
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 08:22:11 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-36520a83186so1795732a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 01:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777969331; x=1778574131; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DoyB8695OKHFJLVaXhyFdUBCqi4FGLL4BEcb0wuk4uw=;
 b=a2YUFtgaNOEOyJGCLEShnOUtc3ti1I8X7ia738JNqIX5nAbEOV3loeYKVZzhaY+UrC
 DcbZT+prM7mCgqchYsIxcAGrd2sNYubxu7MTKSQ+7rQLEjsWV2wNg1ZrwXYrwY4HQ54G
 hmoinhiyHAPAzkelqk0f92pKEKwD0kegL2JxxqmpNDvj3FRMTIU2bmiOCFZbKcyB5tfl
 kX1R+pJy7q+gOXkxDDRWtoGJ7rLHsl9HMPykAV9jh58Pmx/XcuIpgo8Ss2BzEWEn+Dan
 /GXkdd9vEt3TlF4tnrWshjwb/M2SufHS6HMWBNnIfzHAJ+OwADSBSIr1sTklXILrp9Y/
 QhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777969331; x=1778574131;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DoyB8695OKHFJLVaXhyFdUBCqi4FGLL4BEcb0wuk4uw=;
 b=CDjOf+Snxv93YqXfc63RyQ+qO8Aw0crMk2yhddzxzCMU2gbfbqc++oV0FcUC30QInI
 4LY2sFPWT0bELfn4SrRJ4uNE0HUBJZ9aoD/gYKyxKJYW5LeDV0z0hzIzUB/ooCIAUmwt
 1o4AepNFkgv9OwrKaK482Z4bdsWA/U4S2cVO3Wwtd2/CeCCKkF4OdhIxH1O/q5iHucgq
 OMoR+MBZHQyra0ZIs6DujSN8XtwMB2Pmlezy0G/02JOFpQOVpAVUjxrW2BUGPX+e7JMq
 uxIhCNI7sJhZhomV5il9qqxq+U9KmOQl7dEgXubjNu8xVYdrKkO0SRXderAm51bPY4b4
 vJ/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ntZ661BznofW8mmrhVK7Zo6rrVl+3uSDKCk8Aj7VFimbpcsvTLtNXG/qg4v5/px1WHxSCAtWutrE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDPdjKcYvakKuaTApUFXDZbBf7IN/cIbyy1YAQaiQKs1XuKgyo
 9fuFcq5sQeCLh4d4B4xQp9ko3gzExPvemXGJdDKqo/4NA/EdGCeJvsqi
X-Gm-Gg: AeBDiesunDKzCMIdCa9GHrgEykpsPxnvBfUBIw2uRRvPt5GHuA9+Rbi6WN5cRNSL5/r
 6aWPJITtH5wTvIBdpe+UFA7eonMnnyNCCGkGmW1fU5gwMrEfkvjN4uPtpDpoN+QbOqNOjI3Kz3G
 WSvlTHxYB4TAW96jqHsCGRklH6aawp95lU9kOXXXjDLUXUYXaqMlkyqPzpBLKIMm1goE89TSXh9
 3KTljykudnQNiLNFlIln1aMD6c8zLG7nbEpru6HSpw9hNZPv8FRhpSEhDDgswtzyLTsq8rCdh0J
 G0FdL+7FRC9ZCkWFdptDEbh48FDikrLSt0e8gBBZiCagzU5HnjxBb7aPnrehK2mhn+/GdTf/TIC
 TNbTTx46f1bFyj76DblsaxhoHYPZhlFnBAGKKTDJfPyPyeqZCSbKABP5vm2bMWUZ78xwkDGJ8A5
 mpWscCXps/67k/bWA4ZUzgnVqG
X-Received: by 2002:a17:90b:3807:b0:35d:95eb:879a with SMTP id
 98e67ed59e1d1-36577487bccmr2309864a91.13.1777969331396; 
 Tue, 05 May 2026 01:22:11 -0700 (PDT)
Received: from lgs.. ([152.32.133.247]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3650e94126dsm11439814a91.5.2026.05.05.01.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 01:22:10 -0700 (PDT)
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
Subject: [PATCH v4] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
 device_node cleanup
Date: Tue,  5 May 2026 16:21:45 +0800
Message-ID: <20260505082145.603262-1-lgs201920130244@gmail.com>
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

Fixes: ceea3f7806a10 ("drm/bridge: imx8qxp-pxl2dpi: simplify put of device_node pointers")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v4:
  - Drop the sentence mentioning the custom static analysis tool.
  - Add Frank's Reviewed-by tag.
  - No functional code changes.

v3:
  - Do not change DEFINE_FREE(device_node, ...).
  - Fix the driver pattern by making
    imx8qxp_pxl2dpi_get_available_ep_from_port() return an int and
    pass the endpoint via an output argument.
  - Update both callers so __free(device_node) never holds ERR_PTR().

v2:
  - Fix DEFINE_FREE(device_node, ...) directly.

 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c | 54 ++++++++++----------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
index 441fd32dc91c..881ebb811eb3 100644
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
@@ -287,26 +287,24 @@ static int imx8qxp_pxl2dpi_find_next_bridge(struct imx8qxp_pxl2dpi *p2d)
 
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
 
-	return ret;
+	return 0;
 }
 
 static int imx8qxp_pxl2dpi_parse_dt_companion(struct imx8qxp_pxl2dpi *p2d)
-- 
2.43.0

