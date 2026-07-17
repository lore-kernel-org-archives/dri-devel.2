Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1335C44517
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 07:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F5B610F471;
	Fri, 17 Jul 2026 07:26:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="OsCyxxBo";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B10F10F46E
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 07:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1784273027;
 bh=E2l8SC5Yz3l3RQ8kfLiWXU6wvt0RqrCjSGXwLiFhpCg=;
 h=From:To:Subject:Date:Message-Id;
 b=OsCyxxBo8/is5WFmzs280ZyS3PKB1If6TwSQ7fNAd1xFIwm1keiHuZfCsYo0vMvCm
 z8rvmVRkdKkW/yu09DlTsKU8kMQlkFxqrnf+R+KBOmhSlqb7vLotw8RmIRWqaM2TE9
 XsMKxo3RfxGgz2nsNF81Xvjfbxr1SGzOh3AuAgHc=
X-QQ-mid: esmtpsz21t1784273025t3c480ea3
X-QQ-Originating-IP: NunsL3AmaX5/YohLrjzcmQgzMxqBfZtsaBbae5D+VuY=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 17 Jul 2026 15:23:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13698718535468355926
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
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-phy@lists.infradead.org
Subject: [PATCH v3 3/5] phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge
Date: Fri, 17 Jul 2026 15:23:21 +0800
Message-Id: <20260717072323.96-4-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260717072323.96-1-kernel@airkyi.com>
References: <20260717072323.96-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MB78LT3tbKTe20unaeEpA7bJ2qdDKCKD901Y4i5OgIl90Q8sVdUpGscb
 KTn8rVYIwJTwvYh2zKsPIBpoXTH/PCLNjSpb72jRH7wZ55wr84Ncd3lt+fA4VA1eOo4rdJ/
 IN1zc7Y8XunKsfePJKqlxfu0ApeBH9CCrJ5wR6rcgCHiD3gnoJTHdvF2sz/OwZuT3nC/X+P
 6ZDndd697scH/Cq+U8s05etGYIEvk65p5QgwbeU3TDWB5Zr3l++owD3lQmshWlLoRKJFt08
 oWlIxfEfp3zCe/IUT0lR1EDcG5/Q067q4UMGtgvy4qV3iOlnzRmCXHmrDhYPq6Nt5fs3Aih
 dPAbeNIynNR0elLnvoCj5My5EvfIe9vLu9ZTgSQ7gw146s96s0LZ/sutAoN6rpPo3Nc0aiB
 Py6oLzbtVcTY0wwum5B/zm6mMmO03CZMyrpln5MRHuwjefBzvkkpvUtzPmNV9GgGgE4Cgyu
 LtGMYIz3VLOMdNJ/RfL2TG0xrei2YmIHIqU6bw497niDp5OKMMVYV6y52o/5O8JDbV6by9k
 Fmo278Lpb6JZgm2emEAp5fX59EqwZ14IZ8AqC4x+2BD3hazqeoahsIRALzzBlRVrXByP2tq
 2Xyrb6WHBN5WyUs5m3dpivA3OjfAJBeHw/NH6O31Ldbonkb1Qy2iEKCMDRf3IYEDD3jDLpO
 HGIETrnYO8DgGHCZtVKJGNt3WiA+SyLR4lBxiZnDmEO6+TCIMH8+txIXEgIg0MVyE0MaXUa
 p1xTtCZ57Zsz7CqDCbiZfFCrvPl8wuCyDFndcQ/tFqNOckIxxrwKedmm4kbBh7Af3JvFsLB
 sAZpDKEQWGyXUOI2144y+x7Ci7RgBPgTp3eiyxvGmCwVaL8TebMaVhl7FiAvId2gFKfYWIG
 lfWdzlb/Zj2BUbrLDP7M1AqmwKbjpS75q0ZffZLdvHfTYNDC7ZpYw2H5FVzhLGImEgBDOsi
 QrExCp8HT01K7fsVlUiptYWvaS6tW69HK4MZ0UCT3go6oEMvzOUW+Ahd+WOP8jO2YZKijRG
 TZf4tD1qiMiQohPn0K
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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

