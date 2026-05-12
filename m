Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFDDCD4F35
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 09:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A801610E577;
	Tue, 12 May 2026 09:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="TlZs2dle";
	dkim-atps=neutral
Received: from mail-m12752.qiye.163.com (mail-m12752.qiye.163.com
 [115.236.127.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 673B010E577
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 09:57:05 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3e1830329;
 Tue, 12 May 2026 17:57:01 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, nicolas.frattaroli@collabora.com,
 cristian.ciocaltea@collabora.com, sebastian.reichel@collabora.com,
 dmitry.baryshkov@oss.qualcomm.com, luca.ceresoli@bootlin.com,
 dianders@chromium.org, m.szyprowski@samsung.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v4 07/10] arm64: dts: rockchip: Add eDP node for RK3576
Date: Tue, 12 May 2026 17:56:41 +0800
Message-Id: <20260512095644.1946084-8-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512095644.1946084-1-damon.ding@rock-chips.com>
References: <20260512095644.1946084-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e1b9e539603a3kunm05d2ddd6129074
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHk8ZVk1PSRgaGB9ITUpJQlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=TlZs2dle4U/ThViWcwWNBoHkaubGkGCdTjx/mzymetU+Vf9oQSsP2cbL/y7bdjnVkNIz2WoO+YKvHxLsbb0HzSap0McaC8TjAHn/JD2ktoJdOq3H1IE38T7P5lA5rNXR6NWUNWLXFZrrxNxQOvqPfh8uvoDOQLkwCekQ8Tso1sw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=K1DLY9Im8emQ1pvFmDCS9X34Zpvqnm1ezAB2dEZJU7I=;
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

Add full device tree definition for the integrated eDP controller
on RK3576, following the existing RK3588 hardware layout.

Configure required register range, clocks, interrupt, phy, power
domain, reset and grf properties to fully describe the controller.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

---

Changes in v2:
- Add Reviewed-by tag.

Changes in v4:
- Modify the commit msg.
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 28175d8200d5..733449cb88b1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1496,6 +1496,34 @@ hdmi_out: port@1 {
 			};
 		};
 
+		edp: edp@27dc0000 {
+			compatible = "rockchip,rk3576-edp";
+			reg = <0x0 0x27dc0000 0x0 0x1000>;
+			clocks = <&cru CLK_EDP0_24M>, <&cru PCLK_EDP0>, <&cru HCLK_VO0_ROOT>;
+			clock-names = "dp", "pclk", "hclk";
+			interrupts = <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&hdptxphy>;
+			phy-names = "dp";
+			power-domains = <&power RK3576_PD_VO0>;
+			resets = <&cru SRST_EDP0_24M>, <&cru SRST_P_EDP0>;
+			reset-names = "dp", "apb";
+			rockchip,grf = <&vo0_grf>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				edp_in: port@0 {
+					reg = <0>;
+				};
+
+				edp_out: port@1 {
+					reg = <1>;
+				};
+			};
+		};
+
 		dp: dp@27e40000 {
 			compatible = "rockchip,rk3576-dp";
 			reg = <0x0 0x27e40000 0x0 0x30000>;
-- 
2.34.1

