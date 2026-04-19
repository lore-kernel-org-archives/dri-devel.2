Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D27DEA718A
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 12:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 943AF10E205;
	Sun, 19 Apr 2026 12:21:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gT7iqvyM";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3646C10E205
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 12:21:56 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-82f8892d4d6so897800b3a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 05:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776601316; x=1777206116; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pmWG7OM2EB7RxxwskQ0/zeTI1Kmre4JByGl1ksiUCqU=;
 b=gT7iqvyMAcAs+TFiIgQeMVCU90Axqvjgx3SeqCvS6ejgZHGsFMwD8a2Lm/uMnjs7qU
 eG5ZoZrjqCRNlEnEtkULlCRTk68XzNcV2LeR7V58ZohV7oUx4o2hN0FNWK9QZu0JOgs4
 lPuQsZCHL5brb6f10ZgL8+m4eF+AkRKABSMva7vHpH3XZA890uRTgx0TMxH18oQWHMtv
 bu7za4YF1GG+5M1BDqHmebZqU7QYDNP5avNP9tJ7ecZ4lpLVcW8ZMAd6zlVE4JjQ4CIr
 i/c3jnq9KXJV02TQx5vG2JZ3BOvPgKVLpRED/jz76vIiLoBPaQmecB/uHH5vlggPXW2a
 Lomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776601316; x=1777206116;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmWG7OM2EB7RxxwskQ0/zeTI1Kmre4JByGl1ksiUCqU=;
 b=Oco9rov8ZvsN2+zgUwS43XB20aJg2crUp7BAz2DK85GIv38AYGzrKUUCPekFGiKNK9
 IoOAnDsx9oHrkkvMHCZ6QB7ARwTxx5NPS6PAVjRJhblZBdr1aRTyZnnsc7HcboT9mak/
 dNolKaao43MHSJT383mFeKdPdTUDtozSINvbQlaQqSQ06Q149p6KmXVkzj/iMLUtJPrc
 FDEM+VyfuMKC1mgytfu1eJ1/RMWtnXKj0V5xXi3+MPxvoKhhFziC0i29Mk1DpvwE2bpS
 skNydcQ/178OTzd/DTkQzcx7pu+MgnaFyOC+VCKdTu5W73e67NK2o4UIpZamb/36nlXa
 m4jQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lH476xhFMkPwaGuZEeLcTb1KZPitdwI/1vOZTQDP9g9ERF5Ri81rEC6U52aqpcaP7MjO9pgkadS4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxpCNUvnv8EeUJIsyc63IAMCv95X64P/0gx+6TSJvBU1aYFXc1Z
 /GOnRgTv2l/P76XJBMC4e4/Ha+tD/ayS2mJEc8QWG7PcCntAGjM+3p32
X-Gm-Gg: AeBDietYI+Ht36Amf2yR5GNArrj0mTl2up05S8HfeduNRROJcWp4brM5RIkgKOVu47Q
 uvqvPfVDOb6vz27fnEyPB8ZKU2KViQg471Bt68w8UxrpeDMSAJTP58Vely0Su5mmbmDyhPH81Aa
 vOX9qFxc2sLQin0JgRQPnUtuDvi0jTDqjsoeH6dTvhz0Cu3y8J2tUZ/TdinOilkkL8piwZkaYdE
 VFFBA+dilukrsTq/Zwv4ZBKWTWCqfqgxFn6oPh5igtccp+2lRvvJsgiM0nqFj7vwNkMpaagbYQD
 nNXR8TycnR2KWv9v6Qch4vwO09m7lruWG9WQLUG2lX2qUDsTw6T9kxEryda2pKh8Jmu/+zDR1NL
 vM81X0E86fTsq0namqebemSUsAPrTDXjq33lm9QR88vPH4zNm4HnsiSmftiICOj9vzcFLIfBGF2
 OZfGtUrDhj4XknYuZf+VLVN/7ihCCn6d3S
X-Received: by 2002:a05:6a00:2d8d:b0:82f:1d38:f68f with SMTP id
 d2e1a72fcca58-82f8c8bee86mr10893475b3a.31.1776601315542; 
 Sun, 19 Apr 2026 05:21:55 -0700 (PDT)
Received: from lgs.. ([2408:8417:d50:4775:fc0:88de:ed15:556b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9d2fa9sm7700034b3a.16.2026.04.19.05.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 05:21:55 -0700 (PDT)
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
Subject: [PATCH] drm/bridge: imx8qxp-pxl2dpi: avoid of_node_put() on ERR_PTR()
Date: Sun, 19 Apr 2026 20:21:34 +0800
Message-ID: <20260419122134.97529-1-lgs201920130244@gmail.com>
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

imx8qxp_pxl2dpi_get_available_ep_from_port() may return ERR_PTR(-ENODEV)
or ERR_PTR(-EINVAL). imx8qxp_pxl2dpi_find_next_bridge() stores that
value in a __free(device_node) variable and then immediately checks
IS_ERR(ep).

On the error path, returning from the function triggers the cleanup
handler for __free(device_node). Since the device_node cleanup helper
only checks for NULL before calling of_node_put(), this results in
of_node_put(ERR_PTR(...)), which may lead to an invalid kobject_put()
dereference and crash the kernel.

Fix it by avoiding __free(device_node) for the endpoint pointer and
releasing it explicitly after obtaining the remote port parent.

This issue was found by a custom static analysis tool.

Fixes: ceea3f7806a10 ("drm/bridge: imx8qxp-pxl2dpi: simplify put of device_node pointers")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
index 441fd32dc91c..3610ca94a8e6 100644
--- a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
+++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
@@ -264,12 +264,15 @@ imx8qxp_pxl2dpi_get_available_ep_from_port(struct imx8qxp_pxl2dpi *p2d,
 
 static int imx8qxp_pxl2dpi_find_next_bridge(struct imx8qxp_pxl2dpi *p2d)
 {
-	struct device_node *ep __free(device_node) =
-		imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 1);
+	struct device_node *ep;
+
+	ep = imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 1);
 	if (IS_ERR(ep))
 		return PTR_ERR(ep);
 
 	struct device_node *remote __free(device_node) = of_graph_get_remote_port_parent(ep);
+	of_node_put(ep);
+
 	if (!remote || !of_device_is_available(remote)) {
 		DRM_DEV_ERROR(p2d->dev, "no available remote\n");
 		return -ENODEV;
-- 
2.43.0

