Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86868CD343F
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 03:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B099110F1CB;
	Thu, 21 May 2026 03:39:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="Cvicnnfi";
	dkim-atps=neutral
X-Greylist: delayed 564 seconds by postgrey-1.36 at gabe;
 Thu, 21 May 2026 03:39:03 UTC
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA5C610F1CB
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 03:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1779334740;
 bh=sPcwxXMSU/erMkNaNCyJUycUJ9YzZFBvUoXZx1f7aPU=;
 h=From:To:Subject:Date:Message-Id;
 b=CvicnnfiEwbPOoBb63uQjn75PF2sV1YJMfQxhdKFDQuf3fsXNa6+7SdfZ77NgKxyi
 /i2HoHBa3rTqnl5Se136xZt/G2ZiDqTzEwdGhiXtSgPKADhvtVtegzlqXmJG1AqRqx
 O/uyVkjSWHl8Aq9fd8ixOFbh7OLlbAEJJhZSi+kE=
X-QQ-mid: zesmtpsz7t1779334170t6c882390
X-QQ-Originating-IP: GfJMTq5avx9zXlwCEn2XSvRswGjVTkoW/bW3+O1LL9k=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 21 May 2026 11:29:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11043512005840582340
From: Chaoyi Chen <kernel@airkyi.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Vinod Koul <vkoul@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH 3/5] phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge
Date: Thu, 21 May 2026 11:28:52 +0800
Message-Id: <20260521032854.103-4-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260521032854.103-1-kernel@airkyi.com>
References: <20260521032854.103-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: No4GWyI4cWt64hQhXPGTsT7suaSRXns9wSgV/Oo/DSAPj1IowM/QTduJ
 Oj1bg1Rg+UA8iwMrfYL6dzad5Td599H4u0u1TKlRxRvJHk1uWen+priRHgYKL7LXwTqA4uy
 R33EjtRvQbW9J8orYsUcAP920VoXRQFA5jFqnlKsRsAON9BCgPWMlGCtqEF1+7ehUhur4E9
 S0gun21C77/J3+c7ZYyVeEbN3scPDb5z0TCYfd2sdBcRWfLbfRmjyAZVT8BdkEhtJnwdF4R
 C75GMRxccfFfwHza8/qXxeU3m2NA8k7zjInOYlRsT+R9lo1WFL4yRWNnW415/H/wbBB8rGg
 7NIDhw726uCPmUCXwbW+qbW5bp1OvA3dZuZ+V58M4eCxcfUynurMB07+vzEABgyKIOH55lz
 UQqoWRxKSWqUVh0Lj6FdPYWw9hCk+u7pkoxFf3/bUgcInxTM0dkyvYo6XpHIC7ux/nRQsBL
 CncZ7fVVl4WSyCuJqO4t9lm+ByqafdLcj60fLn85Hb+TDzJqH4/XjDFo1vzD7ljreOOWKuW
 0wotYL2KvSHyWgbo6hnb6BzQaXLBCbMEFyxAhyCFuXtsFOXYSvwpmnueIvLBQuhDYLu2mBE
 oRgWIVPRv2xr1fZy0xWGqf12SYiq8OrHkAodN4PMJOQbGmXzwLB+OGVYViAWH56ZNfZSAk7
 fFt2GySOFKl3oaHOendqqH/OQY3rARkPsMj5HAzE0GSwUZ+qzuM+Gu335T2ZUiohvQK6H++
 wjk45SArQJ2cfBncSeVygZV8s7q9iMubRKDg3jtcfgdb1sFOtnms/wjoI230pRucTlVLrg0
 /+z0eHXdHLfeaYvowkYaynsVS0visnoacwmy7riBZQyWKBGxokvo7PzQqEwhvr+SDjAMtwy
 Nd7I5gAtJFd7NqMmP80JkEWR9pdEOtHv4IVKj4YK8Dh4s2qNQeK68Vag5kS4Ck92wgDXQc7
 dK9ST1kZN1snfIEQH1zFT9qnQO3DbQTe4r/5Gioo78hrRXS1/86mxXKj7xKO/gcd4LvwwXt
 aKXjLvMjHB2+plDx1yF2fqoO9i7wg=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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

