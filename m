Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0EACD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB63410EDF4;
	Mon,  8 Jun 2026 07:09:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="D4yqfhaw";
	dkim-atps=neutral
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4186310EDF4
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1780902515;
 bh=57OXAMQqqj4xbXyszs1R+EibBlVBpUVo5uuotM2InZI=;
 h=From:To:Subject:Date:Message-Id;
 b=D4yqfhaw1nJ9J7Tkn9qy+S3c1L9sRjhDM/lRNEs4r1mPIcA6FrDBH6g/a/lSiFv2t
 lucZ37a2B1EtzlVIu6wBbiwsUyZUgi6KtL1+eJjI9Oz2XmEo6txB43CT1hl+Dzf0UF
 5/fgqnleJwWzbV4YMnbuIt7TSgR9UREnrw/EAk6M=
X-QQ-mid: esmtpsz10t1780902513t7fbbf0a9
X-QQ-Originating-IP: XF/2kaHxRqFGalrQAGZQ0zFGemSye6Cjnqw2mX0Z/Bw=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 08 Jun 2026 15:08:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2467102534402940748
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
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH 3/5] phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge
Date: Mon,  8 Jun 2026 15:08:03 +0800
Message-Id: <20260608070805.88-4-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260608070805.88-1-kernel@airkyi.com>
References: <20260608070805.88-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: ONv4FG6+I+027FK+4nHy2WCbSawcqCYuW4HOiUqL7D6Fs4udPBiCCgIG
 k+UEKrOIq9uD69MhBUgnmzuLdkV+uQOwskn/Z0gSCyUsH6pPVkTjvdhQq+XAfPPXf7RpfY1
 C26xdihzXi17ALaCFvf6SQyFif4k54Oz9vLAuzjvLyt262rwL6NBHtOcTA4TL8ewNCwlNzG
 73OWSS2/TuNLbG6h3QU7WtwqmF1IfdCrNgGsbA+tv2ce832fZsh643mAclHf8TFDkJVsyfy
 WtCTje8MX3a/lyZvsJ4AkZJ2YXI42SvODln482jbNuDjho/C0kyE8RGVcvaH4IyeA5+/FLR
 Tfg8kuUMIHJYN/z8AQT+EMJ3xcDKte8ipzwKkrwLhBCAird9pGxJQBbuo/sOJ1pmWf0Sf3B
 IZ+VzzbakC9UPq6F60LgT7E7Kx5/z9Uoo59E9EHLAXaS1Ux+GP48SHjbAQwoT8oooLaf2rq
 YilxK6gMgVjLuCoeQQGyRNF5iemZvp+Vb0DSKuu2IWaix7QGgiHwJMdaCw4odC5sC7Ignge
 6A38ul+saIVRQ4O72Aj38IIsIeBJmwyza8eeh8QXfWoBzhgGWzQ1O3/E5Ywc7ST4PseJK+k
 HjWogGQUByrEn4CkboMkIENx8nGGPPqB037eCulbhQTSY/oR9srs+TRrTWzeulHz8jBwhI9
 b4+8E6fiPN0eeg2hpOXqMNQ6xDE7VPrFwGftKjWnjfpKYNhZZGY45Tew5I+4K2cNs6Dshua
 WeELERLkYmwFLwyemOPiTWVnzaTSPyia5SCGnRnq39gEkGSaaLuqeD8b9h/TjUlM0g7G3s6
 U2t2EZpbMjC6kHq/jDkVbTbsuv5M4ZS81XRwo6xiSIVzjY1JfBSh6evu6osii6eB8DMakhn
 yPfva62pkqqXU7bZGL2FYrunh8oDoYK1/V+rB+kCMUxjHQ17bCsuAW+dsNILE0HHWYEYDU1
 DtegpK4tBQdcKe8HEoMgm0nOrsg2tqQYDJdvD8tP0UU5tSBySKhs44zL0gTTKUiFgDdQPAc
 15YDcsd4zibONa5XDut7UmuSrq44KiHjAHWvAsIg==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
2.54.0

