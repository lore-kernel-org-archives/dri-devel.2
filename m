Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF70CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 14:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 077E610EDC5;
	Wed,  6 May 2026 14:25:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PlDzGu0A";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 431BA10EDC4
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 14:25:27 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-364f7c42c62so3556749a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 07:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778077527; x=1778682327; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZYpMO9UsirEzCSyLpg3GfIDUOtIlMUjHtSOkANbDsUc=;
 b=PlDzGu0A6iHREN1oOYkTSf8DNayHztkjX2mAYwdyFuHB8YpPU0NfDs22BnKXUxrzed
 ucM/aa62iR2yFw7uZ1WP6q13nmeWFwcTrL/cw4kMvB7F21c04qg9mwzhRDLi9njRxqut
 +nDZlOJjOyZhQIRpKvDr2HEjzU5fed5Gl2mDP/k8mjZGNEkTH0L0jstofWVY2Hzvwo0g
 P3X+Q4rR/O0poI055mU/Pa4ZYu1EGnnD441C7iQyTBLaxYZKQAYx4vtjIaqV23HkLiEI
 30LRQaiVaiPoDeR9t94bACAQlUDO/O0ACMUdv7Pz/fpcHZzn79VUbE+QhSik3/XKtZFa
 PLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778077527; x=1778682327;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZYpMO9UsirEzCSyLpg3GfIDUOtIlMUjHtSOkANbDsUc=;
 b=Sp+Qra0EFr7R3eFG3LLE/+DHpyagPUK8Ct8c+0zwk63x3OKJFkjwlsxawf71Z4EqJ3
 xllp7PYBV+KaFwFrRT5D4RWo2hNZ9H8xXOl+4DT0PIswxvx6QZhejCYz1SLfF7GIDrD8
 E/3aJzVrH+vEwOxRcFNTUoXuhj7TbjZm/3vt8OcOUtenj7lT+jkWXXAj9uYRvVn4c23Q
 0a0PALq9lS1WJ1HbFtyoggNvhhD1G0CjEcO+0i5DHHkvYssQaeFeXcKrn1E13j2eWFmF
 J38mDCJPB7cVE8YV5MrU4F0BENutnQRoMTLPhycYwPSN2ZoJj6OKzPjaJ3lOFh2wEoGf
 mVrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/X3y0n/P/eABqxaYj3yCLJ9s+qC+xm6bUrTXb+peQlQXfJkdIRFWgOah1UgXoQLU/UT5veMB39GoE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxROg08HeeBfwJxkCdlZ1q9/lKib1Zyirb80lqMDlAmPHXysJ9P
 5IHviQaJGtGi1IFZaQ9Ot9xxSOJtCwspbRAwgNst7ghJQhMzeDxUlzyZ
X-Gm-Gg: AeBDiet2OpFvW0wLZDpR1m5mb/CaYlOgoI0CsV/+Nk0L6gIfsukTvAIF5HZ5p9qvNZS
 1intlixxBrlgKAb5wAuV9tkJSjuiA3Vt21FKXaK11FFLaKXp2Wwe/dS5bIFs3uVyn7ImzLYBDjV
 n3JQ+PoqyiayYX6IyQw0dfRbdIgI/VbtQh97xZol5+21Uhlmq+g9NNJS6nF4CUGJU2qXz2BaZTa
 ITODH77k5wgob0wv0ZZ4GNtplF9vGEjuBsKtve5qyQsAoikq5RkekYBn1hV7OHiA58VNwgsmtgK
 /CjOaZSQ2q2nteXwhIWn3ZdnXffWTVWBKPcjgZzwVYuwFddVaQKVRbgNK2ctRC3x4Up4vqmUUKL
 iJ5XLXT7+RIrK128DPrA9euIzahh/PNoeuhtXSjseIDJCpJEsM6/XXo0IwMU+0q/0KQS6gzc0X1
 3JZpBMbR2XBSZ4gz+5H1qhcvCX
X-Received: by 2002:a17:90b:4d90:b0:365:b93a:1ebc with SMTP id
 98e67ed59e1d1-365b93a1fe0mr2522723a91.3.1778077526592; 
 Wed, 06 May 2026 07:25:26 -0700 (PDT)
Received: from lgs.. ([152.32.214.178]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-365b08fb3fdsm1118066a91.8.2026.05.06.07.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 07:25:26 -0700 (PDT)
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
Subject: [PATCH v6] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
 device_node cleanup
Date: Wed,  6 May 2026 22:24:34 +0800
Message-ID: <20260506142434.643523-1-lgs201920130244@gmail.com>
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
argument to NULL so callers using cleanup variables hold either NULL or
a valid device_node pointer on error paths.

Keep explicit of_node_put() usage in the helper and in
imx8qxp_pxl2dpi_set_pixel_link_sel() so the fix avoids adding more
cleanup action usage there.

Fixes: ceea3f7806a10 ("drm/bridge: imx8qxp-pxl2dpi: simplify put of device_node pointers")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
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

