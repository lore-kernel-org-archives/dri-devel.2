Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563C3CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 10:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A465610E25B;
	Thu,  7 May 2026 10:08:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V+zP50Cv";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 317D110E25B
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 10:08:46 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-82f9fdfc965so232710b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 03:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778148526; x=1778753326; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Lca9GgtebxHSmlkPkYgy6Y8kn+w8BgkxfJ8muffjImk=;
 b=V+zP50CvWxfwZFkwcwK1hT4g+GrY0i0fuGrF3TiyfPnyCgo6R/FuEanMb+I3vbL9J/
 iSM0SQSP602OpE3tsQoDyV/0b30VEnO4+hgM9eODAeQMCZBsd2oVSdU/VXxwA/Z3d3Xr
 7QhMR1KlckEwaUweYDF7A/xdwspKfL2b8Kcw9t7fQMhSfKK8uNHR756gRhUAgiUMLBEB
 a7U/XNaa+ur+vSwj/rZC/del917iqNpgE53cWoCFEyBKWfF0DfDv3HuZkMdf3zuB2ne8
 vNY8eGPwWjZ65Iwp8Sm+Tfjv2FCJk2H/RXTbBxp8EKMZH/S6HEffQlQG2QpXRWxaZOkL
 eBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778148526; x=1778753326;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lca9GgtebxHSmlkPkYgy6Y8kn+w8BgkxfJ8muffjImk=;
 b=kicvKMErlZ71m6oXTUVllO4lWzUB/1HEBRjSoXpqmgAQBOAlXzNfMk0FMvaa5XGe41
 nCm2nbycTg7OrYJoW44fsTDz9JjgA5TV9smppRMnYzcGLEWMCXL/qF+gFrx7Z3RBk7gK
 Syb8R6lWRdSaUWZMNLC0gp9EcvSxd3xeqa41uTAbjN7YpG0zvG3fMpEPu9xbtWoSUImb
 +SwEssSbOhMcANI+vOV0BD9tZDu4JvJ7lrD/Ka3qG6KP2kKb2t8RMQt2bCien51pNasL
 89ePiVt3p8SusnK6BjrKQiHEjHIH9v5PBabJwFyF9TtAbGsbIDhGWjeYF0y5rwWZ9MF1
 3e1A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9l0NEKTGjOS+ocVmzK9LBL0W6t1gqnguw9rL2SVbfKkpiGErcxOKDCDaBFSK9jKlZK8TiFoCtQq2s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOwldMOIr+tdPWTMVmqU679qXdxeRgTuE+wAIrC4lurlIoYw9x
 CLLPqv9I6OZE30JxEC1JRpftsgSEY1J8j8r7guezVyrDGmfCwrIzSK06
X-Gm-Gg: AeBDievZK/EyMrG6y4pZKDIRHYNO2g+ewCQql6yUdM+mGJPPDlbl0kkqy6Dqu4bb5pD
 iPgyn9z1NsNrVeu8L6rkoeJWOS086mxDkEx1fVlNMH5lvXrb3qMh1DPVZ9xhvIGD1xAc4xEs1Gb
 u0o7SwncQyvjts8+SZswSR1gjjVCIcleQYvfQuXLJAfAa/Spp3R4sRjbevqFmCWCtCv67L8g51R
 YDn4kSsUlijPFrvxm2fG3USkvuqzzugasqcBfEmuc6ptNXe+9gFIVrK893ScymGDj6RqpBld0ps
 K/xzhHY8fiLRtZ2MmnAsIaxYA1olyG87IVLuSjyW0cMwBFzWa1x1li6WTI8nPpP6aW08ULBJXPC
 ozD4VqSCrxEUYj/ED0d7lIYTzLYgN7JBb0e1KDGgjAEo7WGumPLAQEnnk9eodbRyGOROuwoVKSD
 UNvunLyYW5sJYr63u0
X-Received: by 2002:a05:6a00:22d5:b0:82a:f02:7355 with SMTP id
 d2e1a72fcca58-83a5d387595mr7014546b3a.32.1778148525580; 
 Thu, 07 May 2026 03:08:45 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965d38ab5sm10162541b3a.26.2026.05.07.03.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 03:08:45 -0700 (PDT)
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
Subject: [PATCH v7] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
 device_node cleanup
Date: Thu,  7 May 2026 18:06:03 +0800
Message-ID: <20260507100604.667731-1-lgs201920130244@gmail.com>
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

Do not let a device_node cleanup variable hold error pointers. Change
imx8qxp_pxl2dpi_get_available_ep_from_port() to return an int and pass
the endpoint node through an output argument. Initialize the output
argument to NULL so callers hold either NULL on error paths or a valid
device_node pointer on successful path.

Fixes: ceea3f7806a10 ("drm/bridge: imx8qxp-pxl2dpi: simplify put of device_node pointers")
Cc: stable@vger.kernel.org
Reviewed-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v7:
  - Rephrase the commit message sentence about output argument
    initialization as suggested by Liu Ying.
  - Drop the unnecessary sentence about keeping explicit of_node_put()
    usage.
  - Add Liu Ying's Reviewed-by tag.
  - No code changes.

v6:
  - Change imx8qxp_pxl2dpi_get_available_ep_from_port() to return int
    and pass the endpoint through an output argument.
  - Keep using __free(device_node) in imx8qxp_pxl2dpi_find_next_bridge().
  - Keep ep initialized to NULL in imx8qxp_pxl2dpi_find_next_bridge()
    to satisfy the __free pointer initialization requirement.
  - Do not add cleanup action usage in
    imx8qxp_pxl2dpi_get_available_ep_from_port() or
    imx8qxp_pxl2dpi_set_pixel_link_sel().

v5:
  - Make the fix minimal for stable by avoiding __free(device_node)
    for the endpoint node in imx8qxp_pxl2dpi_find_next_bridge().
  - Keep imx8qxp_pxl2dpi_get_available_ep_from_port() unchanged.
  - Do not change imx8qxp_pxl2dpi_set_pixel_link_sel().
  - Drop Frank's Reviewed-by tag due to the implementation change.

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

 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c | 40 +++++++++++---------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
index 441fd32dc91c..d64e328bf542 100644
--- a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
+++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
@@ -222,52 +222,58 @@ static const struct drm_bridge_funcs imx8qxp_pxl2dpi_bridge_funcs = {
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
+	struct device_node *port;
+	int ret = 0;
 	int ep_cnt;
 
+	*ep = NULL;
+
 	port = of_graph_get_port_by_id(p2d->dev->of_node, port_id);
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
+		ret = -ENODEV;
 		goto out;
 	} else if (ep_cnt > 1) {
 		DRM_DEV_ERROR(p2d->dev,
 			      "invalid available endpoints of port@%u\n",
 			      port_id);
-		ep = ERR_PTR(-EINVAL);
+		ret = -EINVAL;
 		goto out;
 	}
 
-	ep = of_get_next_available_child(port, NULL);
-	if (!ep) {
+	*ep = of_get_next_available_child(port, NULL);
+	if (!*ep) {
 		DRM_DEV_ERROR(p2d->dev,
 			      "failed to get available endpoint of port@%u\n",
 			      port_id);
-		ep = ERR_PTR(-ENODEV);
+		ret = -ENODEV;
 		goto out;
 	}
 out:
 	of_node_put(port);
-	return ep;
+	return ret;
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
@@ -291,9 +297,9 @@ static int imx8qxp_pxl2dpi_set_pixel_link_sel(struct imx8qxp_pxl2dpi *p2d)
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
-- 
2.43.0

