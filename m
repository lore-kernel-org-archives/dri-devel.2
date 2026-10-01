Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28203CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A6E10E31B;
	Thu,  1 Oct 2026 08:25:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="DxulFU/i";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E03DF10E316
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 08:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790843130;
 bh=XmnQzRPAA9UtiMcHbTgbsicWkfFAuGNu46pm6UCxaj4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=DxulFU/ifCwsNUBKjfTwKkRyJwqZO69nw694CpR206B0FIgnm5AiCYUH9ZPXQZpkS
 kjB0oZV0fv53Nl5jktJdRqHSD1zL4EyHrpqWCsN/tDXM5ijEtGYdjJ4YZq0VPNQgtt
 7lpTuQj+g+25Z+sHdpZ4S48jBe400oST+c5OBUfdCNIMaT3k6bj32a6gW7bXlVJq0U
 Z4Gxta4HCyzUpOgGlE0rTiXsLtNHKELuo/Tgm5XXXMBDtfbA8TkqXWYmaPUsrJ0124
 MCTy8MoZf78bwlG+loKxEN9tOfenlfHVBaOPcTvmUy/sBDp9hNJM0UZpfYZyrlMnks
 Yg3ATsHJqYkhw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 78C0E17E0524;
 Thu, 01 Oct 2026 10:25:30 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 01 Oct 2026 11:25:11 +0300
Subject: [PATCH 1/2] drm/rockchip: rk3066_hdmi: Convert to
 devm_drm_bridge_alloc() API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-bridge-alloc-conv-v1-1-f0a1fe040a86@collabora.com>
References: <20261001-bridge-alloc-conv-v1-0-f0a1fe040a86@collabora.com>
In-Reply-To: <20261001-bridge-alloc-conv-v1-0-f0a1fe040a86@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
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

Bridge drivers are expected to use devm_drm_bridge_alloc() instead of
devm_kzalloc() for allocating and partially initializing a private
driver struct embedding a struct drm_bridge.

Perform the API conversion and drop the now redundant manual
initialization of the drm_bridge funcs pointer, following the pattern
established by commit 9c399719cfb9 ("drm: convert many bridge drivers
from devm_kzalloc() to devm_drm_bridge_alloc() API").

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index f28d6a883e09..39c65ee07caa 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -703,7 +703,6 @@ rk3066_hdmi_register(struct drm_device *drm, struct rk3066_hdmi *hdmi)
 			 DRM_MODE_ENCODER_TMDS, NULL);
 
 	hdmi->bridge.driver_private = hdmi;
-	hdmi->bridge.funcs = &rk3066_hdmi_bridge_funcs;
 	hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT |
 			   DRM_BRIDGE_OP_EDID |
 			   DRM_BRIDGE_OP_HDMI |
@@ -747,9 +746,10 @@ static int rk3066_hdmi_bind(struct device *dev, struct device *master,
 	int irq;
 	int ret;
 
-	hdmi = devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
-	if (!hdmi)
-		return -ENOMEM;
+	hdmi = devm_drm_bridge_alloc(dev, struct rk3066_hdmi, bridge,
+				     &rk3066_hdmi_bridge_funcs);
+	if (IS_ERR(hdmi))
+		return PTR_ERR(hdmi);
 
 	hdmi->dev = dev;
 	hdmi->drm_dev = drm;

-- 
2.55.0

