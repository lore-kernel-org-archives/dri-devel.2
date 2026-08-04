Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBC4C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B84BE10E899;
	Tue,  4 Aug 2026 07:20:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="dZOc8Hy+";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDC3510E899
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 07:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1785828045;
 bh=E2l8SC5Yz3l3RQ8kfLiWXU6wvt0RqrCjSGXwLiFhpCg=;
 h=From:To:Subject:Date:Message-Id;
 b=dZOc8Hy+DdJMeEoEqg5yRfNRtzacRilN01gOnur02M65f2x8LcdgLUggzmli+7Dm6
 axFhPSnILaDpudrviIPviE/egCB5oLQkDeQFPflJyBjogU8PqXOa190VC/HFQ4UZ7u
 ZTr5f9S+3ARQm1+p3s12o/FS0YvS9KVWoK3WI50I=
X-QQ-mid: esmtpsz19t1785827296t5d5c1fbd
X-QQ-Originating-IP: 0cHwMQcP2BBEqYGFtlahXAYAHyCJF7V6tqtxURYr1Mg=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 04 Aug 2026 15:08:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9911778146744449110
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
Subject: [PATCH v6 5/7] phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge
Date: Tue,  4 Aug 2026 15:07:28 +0800
Message-Id: <20260804070730.68-6-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260804070730.68-1-kernel@airkyi.com>
References: <20260804070730.68-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MkhAA4qIuU0pOzcwnffo2wE52dP67gYYAqckmr9AtnAbOLavP4jc79h1
 sM8k5WA+J8rPRqyU0Z/prCuzyIvF0dcrsKbjIFQ8cs2Cjvilf0iJXjwH2XaUl5w+YIV/OR0
 rNCL+h2mqIXPQlKOW7+j3liglxYD83jq8eIxInPzz+kPAVGUvcTMLD3k/39XNJmFpEnRlQB
 lj2x5EOotltg2UQjV1g4lLseIVO4R3yYbpDd11Qeu7rtV6v5nAf5zoyupSlypMg9fWzVTq7
 DVYlZuWFAqwtujfbE4Fy9E3/u92CATkBFvAE1vlcVq5jlt0GbKn9md7mRS4bspEG2wkD4Lw
 lDAcSXE+IzNgqwGXB5USjh2sCTVSl7rzUTZPR1ho/eWdxQFLivpSR3RZdgxaQW4FhRmMlKc
 seVHdGz6kZ5Kg0doPCVR0hGaVvBeEAqtg58f1r+sx+VMxaltBkgTMIoEkepz3hDfyyakV4A
 tsUsfzkCOd7zM9V8gty/qCeN3JbQkEIb52N5B8LL+NHEWLYwVe9QsGsDgYwE/P07t7uVOXz
 D6S3V3DNUbH5FHiXwbnA6lPssY+6HaU9n0jZKALdzmIXYG2RvObvbMs3vdbCTKnEeEvnHpi
 /OqWiCNWSMIvf9XaRMzdU2jPRxNTSxgwoZ1tb9sHhqsqVC9DiuQzXu/3MKPf1T6B/hsiDZl
 Gaj2MPpIU8+kZ1f6dTQH02yhYJgiDzzZEm33A1KXP4h/vQwyB6d7B/qIBXbsNa4V6TcsnzR
 q0LOlVl1DKUNnmG6V5YnEEIwhy/7wcmCe4rSLO+W4vcscoT3hZga3Lu0EbTrHh2uBxmQPMI
 p+vWCJkNJ2MXeYpCkGW4X3w+PX8gInPAk4FmSCPMcGqBxJcuhqIny0PGaNl36XCeHHaR3rE
 D+6T/H9/q71VavHhvaK+VPPjc29sc1CjP9zB1BB9bDIpaPZIzTq+hATFzYiIQeX/E5N7555
 W/Gz0pcgzkTWpGTcRwvQUcOyjNW0xsLhqV3a+PU5PmjUwBEKy4RltO9j19BHYOl9ao85TVl
 I2KIMaIY1Ido2V35Jmo6wRCXj9xH+mYoK/xjBVKg==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

