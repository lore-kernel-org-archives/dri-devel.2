Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8685BCD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 09:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F17FC10E18C;
	Wed,  6 May 2026 09:23:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QEdGvEuZ";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 052B110E18C
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 09:23:50 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-35f9ab079bdso5021705a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 02:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778059429; x=1778664229; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=//nou2Qb1FnpkEvM0SdcsiAXuxlLxSwwu1Tjy8/lIKE=;
 b=QEdGvEuZ9hnoiIBHcmIJMbozt53G2dqRcSOGyCGO89/ebpSW5sw25+SWQKYv21vsQp
 yDIoo7D8EFcHKVybACeh9P0v7oYvjRQUmR0saTT/SkV3AZpWqPXuIWxXhta+finIhd7P
 ua12w1BAsrHiS4e7zAA0AIeOHcQWzKDCP6S7RNF8xOBYP6ryYX5CpiQNyFkvHqFAa60A
 FP9HUcVoXbB0I+XfgjkpZhvbDpjq0zYkAP0jpi+u+gaH6HbEOJIzWpiBZ2NBe8CGTkop
 IchxFhlfe3N9trDupnHIDD7faY9MR4ngpblYQBtSa8m9U09g1wrCXfgWHDJ1yt7CqavE
 pDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778059429; x=1778664229;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=//nou2Qb1FnpkEvM0SdcsiAXuxlLxSwwu1Tjy8/lIKE=;
 b=kwGsGz9P6L/lGZ8KsI1kj0cWff17isan4qHekwDDUbLgAJJDNhgcMSMkTVJ6ANaqhN
 yckEyY/xUuVgh1UUs4EjQpFr9QStFKuCo896SgF+UxYpWLALWP6DIZ+iNi1LrIIsR1Pw
 xaq+ss5nQ0MEcxdotz5Z/r7n2Pj4h2GF5hzmbypsGRKN4JmWit458C3DVnnOAi3RUVsT
 Nxu7YWsobKcks9HpnwhKZdaqFXdmD2B1SUQx3uTZWiSxbY+AR3TSF+XgHTsSiBBKg2wZ
 yO8n8omJOorqnEiCqt178o42YhTXm2Owjmxv40VbmhQHrKbJu3/wVm0ogGVvbcMqBNUw
 GLNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/aVXu1wvaCNCZToPpAgKo9wjc09NNlmJLXsQugAfMr5ruyJydSIHxHQmw/8psxywgv+ZNG8nCHafc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEAVZ5yWxOZlqDbvTu9cjybuK/wcs5wk0J4TNMIPUbVn8Lfx/K
 kjRoqyYFJAG1Jq351b2j7KMdEfTPoEdtdXKqtcooXOI7sPkxUAY9Eksn
X-Gm-Gg: AeBDiet15gp0eO9lI+MuX3prh+F8LnlG84A2i6Mz2uMCM9Q2uJPMWRaVTQjniBqtmHF
 rKqb5Tjw9kJdNFtpFsvVLba1wnX29IMY6W0c1OFLCSO4kfZ0quth5jESbOKXeqfs5DjDwr4GKb0
 kOA6Hj27xaXUkbkNVlW+GhAeR/ntejPte3aNNINczXMfM0GgR0EwQgsxXnweYc0rKSLaDGFoafD
 cNNeLun7XOHolKEvZ0CiFTSmPaMCUwAFEo0JR0YcypEYNiSGp0IXWODsHLoCkAijMbn2SaClAsc
 s3cjoLbARkAo5iXO4oK9yBZDXud7yhtOlYThCqwraGLckyV+HNnT8tmnAfdxcrNysqhKebgoF+W
 Oy+i9DKOcvJSsKz7JFQpeMvPfXWJdaB5eKTO8I94Xarxh+0X1aQ2H8C5jM/dd20RZmQ9cJJA4re
 9qBBvuymcpFF6sh47IXa+MuIryCH2E+drmdg==
X-Received: by 2002:a17:90b:1c84:b0:35d:a3b4:2ef6 with SMTP id
 98e67ed59e1d1-365ac47f086mr2457412a91.21.1778059429387; 
 Wed, 06 May 2026 02:23:49 -0700 (PDT)
Received: from lgs.. ([118.193.33.13]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-365b06adc51sm716818a91.4.2026.05.06.02.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 02:23:48 -0700 (PDT)
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
Subject: [PATCH v5] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
 device_node cleanup
Date: Wed,  6 May 2026 17:23:24 +0800
Message-ID: <20260506092324.635014-1-lgs201920130244@gmail.com>
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

Do not store the endpoint node in a cleanup variable before checking
whether it is an error pointer. Use a regular device_node pointer for
the endpoint node, check it with IS_ERR() first, and release it
explicitly with of_node_put() after getting the remote port parent.

This keeps the fix minimal and avoids changing
imx8qxp_pxl2dpi_get_available_ep_from_port().

Fixes: ceea3f7806a10 ("drm/bridge: imx8qxp-pxl2dpi: simplify put of device_node pointers")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
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

 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
index 441fd32dc91c..f64f57a33c62 100644
--- a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
+++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
@@ -264,12 +264,13 @@ imx8qxp_pxl2dpi_get_available_ep_from_port(struct imx8qxp_pxl2dpi *p2d,
 
 static int imx8qxp_pxl2dpi_find_next_bridge(struct imx8qxp_pxl2dpi *p2d)
 {
-	struct device_node *ep __free(device_node) =
+	struct device_node *ep =
 		imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 1);
 	if (IS_ERR(ep))
 		return PTR_ERR(ep);
 
 	struct device_node *remote __free(device_node) = of_graph_get_remote_port_parent(ep);
+	of_node_put(ep);
 	if (!remote || !of_device_is_available(remote)) {
 		DRM_DEV_ERROR(p2d->dev, "no available remote\n");
 		return -ENODEV;
-- 
2.43.0

