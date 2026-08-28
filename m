Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30733C61DCD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7253410F2F2;
	Fri, 28 Aug 2026 08:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="aUl26nl3";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8483A10F2ED
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 08:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1787906898;
 bh=ps+5/GB0NshBez8oJzJPOCqkIqmjQyVJoJgHnSj4//Y=;
 h=From:To:Subject:Date:Message-Id;
 b=aUl26nl3wQUZ4hn1CUwgBwkgnEsMmlFcFw/Aj9gO5+I84IsMaXGFLkEVT5DiEdB/t
 EyFEKRMMWFOE/mvxjTFEIovflYg95Ep6GlvmmF33XD1Vy1fNTTdQdZ9yPrvVPvKppq
 sE/1azftroo0lkbfD+x7SJz9IRkVzg0X3EBLU/VI=
X-QQ-mid: zesmtpgz6t1787906896t199af65e
X-QQ-Originating-IP: 5flTHLV541QvG+d71g7cmkxNrt7XoJywJCQVlxi+9yA=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 28 Aug 2026 16:48:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 316822618748361336
From: Chaoyi Chen <kernel@airkyi.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Vinod Koul <vkoul@kernel.org>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-phy@lists.infradead.org
Subject: [PATCH v7 5/7] phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge
Date: Fri, 28 Aug 2026 16:47:35 +0800
Message-Id: <20260828084737.565-6-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260828084737.565-1-kernel@airkyi.com>
References: <20260828084737.565-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NBUSIVIw0bNzXOl4W4KwoT7/kemWkc2d89cfamrIoo6cBhy+GgRIJWcW
 SDMMuASo6ASpJoMzH6cZSmRdk9ycX+MgvZCKdMFDuqBA5T0h9cUPxp2mW3ybl6ZakmmFore
 /Ksv1P2BuMtr1NxlSZ7VVXCG0EIBwq2cXXc5M5J13CZkF3/AJmuAdYk1d3RHrCtgC6TWwRB
 N9iNL/gWs9aOHLrg1KNPTffjNFLXLhutyM4ptjoE1AKpcAQBPdbLqzD7SFqPJxwEAYVmKvy
 jHPnihyAuyGOpuwiofbiLbd11sZLA2MiMWj++5Q9Pj8+noYLOldK1g8t+vxDHFwRPt5KD9M
 pNrSN5DzkHpc9hfFwFwJn8wbKO0UdULKgIcXJDcchYFducAIVxAJPItV1Eh/6czEPR5VWWJ
 F7BUUAFVIlkzxNLMM3aI9EiWe+jNlbM1/D4t0chzaobFHoIYyvwygG+6s38JseDpO1utnLC
 rOvuD+P2/P5iuR4PPwNtnrhhf4r3dDhAnSC4tdQsm6rQ/a+OtUP1XxBUfnE2qqzSv1Yh0X6
 oiffBGpfXLzSjybS10/oCYBz6ni+Ssy45xbdjTsUP2fTgTHQcjrSg7AojD4dku6IuEBe2wd
 Beoy2Bxn+Qurr+J66sprwKhURk4vUDnbIJYSkSWgpiMXr1avjgKiBOsMXUryRPzNRHFbgs/
 PaMXXWBOvOyemndYoXQmAGHfx7rzs2CtfIgsRmtbRzjQggcoeqajc0KelRBcz5E8g9wioCM
 a46fF0H8DdzM44rGRCQTZsNMCe9hxsB5qqWg8+B0vMtZxlQPKT6/GegeMVFtpUBrVk8k67+
 Jl8GWHeFk5P8Wi3wW70SjEXR5qK0EsnbZsXdDzGo92HoZ9KhMp7UTgIe2ECE0u1W9pKkgtN
 KKCiuozVqXZTBkrIxKT5pafyb+EbtMmefolonbZrGkAD/Yc6JuR80bkrgdXcSQ4lqy6OYSH
 o/6LA2+PQlq4UFmIHmCdLmEKnPzYShUiyvKCRElsk0XotP9Ey3f8ZUKoEnZ5Xy3XsXtDcYC
 hSRhU48OaUfRnajZB8cLhQCusTsN1925Xcg2E1zQ==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
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

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Using the DRM_AUX_BRIDGE helper to create the transparent DRM bridge
device.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
(no changes since v1)
---
 drivers/phy/rockchip/Kconfig              |  2 ++
 drivers/phy/rockchip/phy-rockchip-typec.c | 13 +++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index 14698571b607..9173d3b4fef4 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -119,6 +119,8 @@ config PHY_ROCKCHIP_SNPS_PCIE3
 config PHY_ROCKCHIP_TYPEC
 	tristate "Rockchip TYPEC PHY Driver"
 	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
+	depends on DRM || DRM=n
+	select DRM_AUX_BRIDGE if DRM_BRIDGE
 	select EXTCON
 	select GENERIC_PHY
 	select RESET_CONTROLLER
diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index d9701b6106d5..48070b50416e 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -54,6 +54,7 @@
 
 #include <linux/mfd/syscon.h>
 #include <linux/phy/phy.h>
+#include <drm/bridge/aux-bridge.h>
 
 #define CMN_SSM_BANDGAP			(0x21 << 2)
 #define CMN_SSM_BIAS			(0x22 << 2)
@@ -1162,16 +1163,24 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
 
 	for_each_available_child_of_node(np, child_np) {
 		struct phy *phy;
+		ret = 0;
 
-		if (of_node_name_eq(child_np, "dp-port"))
+		if (of_node_name_eq(child_np, "dp-port")) {
 			phy = devm_phy_create(dev, child_np,
 					      &rockchip_dp_phy_ops);
-		else if (of_node_name_eq(child_np, "usb3-port"))
+			ret = drm_aux_bridge_register_from_node(dev, child_np);
+		} else if (of_node_name_eq(child_np, "usb3-port"))
 			phy = devm_phy_create(dev, child_np,
 					      &rockchip_usb3_phy_ops);
 		else
 			continue;
 
+		if (ret) {
+			pm_runtime_disable(dev);
+			of_node_put(child_np);
+			return ret;
+		}
+
 		if (IS_ERR(phy)) {
 			dev_err(dev, "failed to create phy: %pOFn\n",
 				child_np);
-- 
2.53.0

