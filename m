Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CBCCCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C79610E9C8;
	Mon, 19 Oct 2026 10:34:06 +0000 (UTC)
Received: from mail-m205210164253.xmail.ntesmail.com
 (mail-m205210164253.xmail.ntesmail.com [205.210.164.253])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B17A110EA1E
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:33:56 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 518d3ddb4;
 Mon, 19 Oct 2026 18:28:49 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dave Jones <s.dave.jones@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v2 6/6] arm64: dts: rockchip: rk356x: Add eDP controller and
 phy nodes
Date: Mon, 19 Oct 2026 18:28:24 +0800
Message-Id: <20261019102824.3157044-7-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019102824.3157044-1-damon.ding@rock-chips.com>
References: <20261019102824.3157044-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa153b4f0f103a8kunme348c01b2f6c59
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGUpJVklLSkNKH0odTkMeS1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=Knnwf9OeJchsgWsBAold0rtvUsMcikqn3N7Tstzi0RF78LiKL+0hcUNzU3r66POuNBTKSc6aCQNh5ya64BLf4RfzI5tvu6iSx2UT0321l0g6IsDWW0wOw/4aIZw7VUk0LsLvVA+lqVUHpHaB+uYvsxtVEdloGDUjX85pRvm1NSs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=u0DlQ/xf40TjrEq/cqhW2BlOW/2RL9CDbLOchel23Qo=;
 h=date:mime-version:subject:message-id:from;
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

Add the eDP PHY GRF (with the eDP PHY child node) and the eDP
controller nodes for the RK3568/RK3566 SoCs.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index a5832895bd39..3b60e4355ad8 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -403,6 +403,20 @@ usb2phy1_grf: syscon@fdca8000 {
 		reg = <0x0 0xfdca8000 0x0 0x8000>;
 	};
 
+	edp_phy_grf: syscon@fdcb0000 {
+		compatible = "rockchip,rk3568-edp-phy-grf", "syscon", "simple-mfd";
+		reg = <0x0 0xfdcb0000 0x0 0x100>;
+		clocks = <&cru PCLK_EDPPHY_GRF>;
+
+		edp_phy: edp-phy {
+			compatible = "rockchip,rk3568-edp-phy";
+			clocks = <&pmucru XIN_OSC0_EDPPHY_G>;
+			clock-names = "refclk";
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+	};
+
 	pmucru: clock-controller@fdd00000 {
 		compatible = "rockchip,rk3568-pmucru";
 		reg = <0x0 0xfdd00000 0x0 0x1000>;
@@ -879,6 +893,33 @@ hdmi_out: port@1 {
 		};
 	};
 
+	edp: edp@fe0c0000 {
+		compatible = "rockchip,rk3568-edp";
+		reg = <0x0 0xfe0c0000 0x0 0x10000>;
+		clocks = <&pmucru XIN_OSC0_EDPPHY_G>, <&cru PCLK_EDP_CTRL>, <&cru HCLK_VO>;
+		clock-names = "dp", "pclk", "hclk";
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+		phys = <&edp_phy>;
+		phy-names = "dp";
+		power-domains = <&power RK3568_PD_VO>;
+		resets = <&cru SRST_EDP_24M>, <&cru SRST_P_EDP_CTRL>;
+		reset-names = "dp", "apb";
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			edp_in: port@0 {
+				reg = <0>;
+			};
+
+			edp_out: port@1 {
+				reg = <1>;
+			};
+		};
+	};
+
 	qos_gpu: qos@fe128000 {
 		compatible = "rockchip,rk3568-qos", "syscon";
 		reg = <0x0 0xfe128000 0x0 0x20>;
-- 
2.34.1

