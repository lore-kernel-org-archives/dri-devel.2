Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BDEC98311
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AE0310F45C;
	Thu, 24 Sep 2026 10:24:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="qXKcLVrr";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xb/TW3sI";
	dkim-atps=neutral
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CF4410F470
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:24:42 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id E08541D000A7;
 Thu, 24 Sep 2026 06:24:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 24 Sep 2026 06:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1790245480; x=
 1790331880; bh=h8AuXepnzD9XaSOicrRYnsLBz/47hJApvicX3vZY0wg=; b=q
 XKcLVrrkjjgRE4Z4le52nr0lAY+x6UmVJNY/VUPywQtgrBwZIAq60fdDdLDQtJSM
 Adbbx1gP9uCQVn/1xeqvB0A57F2iqIVisUD8OYtJYCMSHD9EwwKcUQ5xa16885vX
 pGb3WVMSSx9aLWfG0KTz3HeigQouk6wyCjal6h8feGjT0rUVSaUadiTYt7qAeDCg
 ZxW4WZKKuOvbBkqDlooRRl6cAw6LouzcdxzdT03wRFEBFmhPn1mM76in2r377fj9
 O/m5wt9K3mei+jcYCp0sNJGNo/QO7sjOO7UCx82gY3T7RqWLYW4Gn3oa3uPhKKn/
 jE+kQ/yIJ+WSA0LyjdJhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1790245480; x=1790331880; bh=h
 8AuXepnzD9XaSOicrRYnsLBz/47hJApvicX3vZY0wg=; b=Xb/TW3sINDKpBOvTK
 64ILVP8UcJT/cLQgO65sRb/q7HHqNmaR1BgZh/W5KPg7cbhe3UZHlykad6YVAjyA
 j0wifg8q/0XhZvl6lqQ1oDCDKaoMHvqNkSeAE8HDllo+5OjDylPbwuvyh/jtWP5i
 8MP1edqwF3zdLm6Ce0wt76UW0TjEszstCDmgR33lQmrKDIuoH0zL1Sqk0sAHSs3k
 JLt0AWbiGfgjN3Isk0VWLk6WPihA3Q98hXv9vsIFmQHQMYQczj0utcQdNPE3d223
 AMYSl5y8cmtUcX9aiRfyxEDWP1E8ePQUaqhcD5dwS6HeE5bAREfxvvlKV1x15cI9
 YY8TA==
X-ME-Sender: <xms:aPq0aidVtH-ZSooFrerTo3X5lkYz4IwBckI0uKix_tk14yh_wzet3A>
 <xme:aPq0asUrRSRSPcgygAuU0pgD5fIj1KSEXiDnNyO_iXSMltCbmCnQhyQSNBxiR5nDo
 0nOFvZrIT5DbztVeSPalXIa6503_Vn12woLrjqnXaocA866_ofMVA>
X-ME-Received: <xmr:aPq0ahX_OMF0hpBosZ-wmHQ8Le1UfPn9GW57b-z_dnnZT85pdygttpia-uQkgdleGrngHCWJ3Q>
X-ME-Proxy-Cause: dmFkZTFsBxBnkxABgBGy+2y8oh2XcRM9qhNrQt63e9eXQe5iuApGdKOSmV7em8OherjGGN
 2UkOtHmOQJGeWvpaeiVHFgUOdWvU0GuImx3mX3r6ii00a0IpQTJjp1cfkpgG25m29J5z7+
 rNk1buhlGtDCpsLmFpRl17COSu+GXw+6L56rzVEP4tdwLkJGLabYhY6BNB4o0H87HOkC+U
 fkFpHSoZagGd9OBbhGNpV1h7cbPjRcWqI/oILvcJB6xiDiwiovlBxFwMy88BO8jJwtdy3z
 TcTfMivx0F11V30THQiKxsErjj9V/7m7iOeekydns3M5HrTYfcTxRRN6AGKc1ZzD4jZ9ZJ
 9EHo5HHuloqbxdoLuHw9T1jbR8pFu5iyYB2qYmmOZbejz3o6MWJ60cL0WJRK6wumSOBiD2
 bFu73y92SoDgJHAVWeEeIg+2A3SPLvWPujEbZiYL3mhSFP+kEQuyzwh41Yv4kdPUMsS5e2
 1jy+u64/yhEAXTm9yNvatG3foUnNsSYn7fbi0i29UjMZYBr67+7L2VnEhRkVS/AbfUtn6m
 h0ZvhySh7kCN/iqUMqkChKURGFsVvHFJRnO7+zqc7n8OQTQk5yrAUZohsmUwbmXbYmNFyt
 VW7Fsr/B1ZxFAxn3q1d9+LYh/j4LRvd/1ND7t4wof3TW6eLOd6vy8hkGfc1g
X-ME-Proxy: <xmx:aPq0akO5wmtjnGm9KpRAulh5B9VyesG678PmQbI4ZcgAAUDVZsTZNg>
 <xmx:aPq0as7BOBIu_UROQ7v8085Q-rDX8hzlg7x4uuuYh-EiHoiRMLtJTw>
 <xmx:aPq0alqMt73zmfn8D5RMM12ZKu4Wc5Hz4daODorWoHpHUq3IKRUrHg>
 <xmx:aPq0aqDEqQGW9mYZR18gdHiyZvAQzZwxWAHSXBnQJndiFXfYTn0JoQ>
 <xmx:aPq0avZ6xk-VJg7QX5bWJeso7ydkAbhZNf_YKDQoPmwxP8IkrMmIRnPh>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 06:24:32 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v14 14/15] arm64: dts: rockchip: add NPU (RKNN) nodes to rk3576
Date: Thu, 24 Sep 2026 22:21:34 +1200
Message-ID: <20260924102135.92217-15-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924102135.92217-1-gahing@gahingwoo.com>
References: <20260924102135.92217-1-gahing@gahingwoo.com>
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

Add the two RKNN cores and their IOMMUs, disabled, and label PD_NPU so a
board can give it the NPU rail. Each core lists both core domains, its own
first, as tested.

Assign CLK_RKNN_DSU0 594 MHz. Nothing in mainline sets its rate or the NPU
rail, and at the 786 MHz it comes up at, on the 750 mV a ROCK 4D boots
with, two cores running together write wrong words, 11 to 25 in each pass
of 5400 rows. 594 MHz is clean, and Rockchip's OPP table asks only 725 mV
of its 500 and 600 MHz steps.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 74 +++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 26aaf4320..e9cd11b58 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1042,7 +1042,7 @@ power: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				power-domain@RK3576_PD_NPU {
+				pd_npu: power-domain@RK3576_PD_NPU {
 					reg = <RK3576_PD_NPU>;
 					#power-domain-cells = <1>;
 					#address-cells = <1>;
@@ -1269,6 +1269,78 @@ power-domain@RK3576_PD_VO1 {
 			};
 		};
 
+		rknn_core_0: npu@27700000 {
+			compatible = "rockchip,rk3576-rknn-core";
+			reg = <0x0 0x27700000 0x0 0x1000>,
+			      <0x0 0x27701000 0x0 0x1000>,
+			      <0x0 0x27703000 0x0 0x1000>;
+			reg-names = "pc", "cna", "core";
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru ACLK_RKNN0>, <&cru HCLK_RKNN_ROOT>,
+				 <&cru CLK_RKNN_DSU0>, <&cru PCLK_NPUTOP_ROOT>,
+				 <&cru ACLK_RKNN_CBUF>, <&cru HCLK_RKNN_CBUF>;
+			clock-names = "aclk", "hclk", "npu", "pclk",
+				      "aclk_cbuf", "hclk_cbuf";
+			assigned-clocks = <&cru CLK_RKNN_DSU0>;
+			assigned-clock-rates = <594000000>;
+			resets = <&cru SRST_A_RKNN0>;
+			reset-names = "srst_a";
+			power-domains = <&power RK3576_PD_NPU0>, <&power RK3576_PD_NPU1>;
+			iommus = <&rknn_mmu_0>;
+			status = "disabled";
+		};
+
+		rknn_mmu_0: iommu@27702000 {
+			compatible = "rockchip,rk3576-npu-iommu", "rockchip,rk3568-iommu";
+			reg = <0x0 0x27702000 0x0 0x100>,
+			      <0x0 0x27702100 0x0 0x100>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru ACLK_RKNN0>, <&cru HCLK_RKNN_ROOT>,
+				 <&cru CLK_RKNN_DSU0>, <&cru ACLK_RKNN_CBUF>,
+				 <&cru HCLK_RKNN_CBUF>;
+			clock-names = "aclk", "iface", "npu",
+				      "aclk_cbuf", "hclk_cbuf";
+			#iommu-cells = <0>;
+			power-domains = <&power RK3576_PD_NPU0>;
+			status = "disabled";
+		};
+
+		rknn_core_1: npu@27708000 {
+			compatible = "rockchip,rk3576-rknn-core";
+			reg = <0x0 0x27708000 0x0 0x1000>,
+			      <0x0 0x27709000 0x0 0x1000>,
+			      <0x0 0x2770b000 0x0 0x1000>;
+			reg-names = "pc", "cna", "core";
+			interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru ACLK_RKNN1>, <&cru HCLK_RKNN_ROOT>,
+				 <&cru CLK_RKNN_DSU0>, <&cru PCLK_NPUTOP_ROOT>,
+				 <&cru ACLK_RKNN_CBUF>, <&cru HCLK_RKNN_CBUF>;
+			clock-names = "aclk", "hclk", "npu", "pclk",
+				      "aclk_cbuf", "hclk_cbuf";
+			assigned-clocks = <&cru CLK_RKNN_DSU0>;
+			assigned-clock-rates = <594000000>;
+			resets = <&cru SRST_A_RKNN1>;
+			reset-names = "srst_a";
+			power-domains = <&power RK3576_PD_NPU1>, <&power RK3576_PD_NPU0>;
+			iommus = <&rknn_mmu_1>;
+			status = "disabled";
+		};
+
+		rknn_mmu_1: iommu@2770a000 {
+			compatible = "rockchip,rk3576-npu-iommu", "rockchip,rk3568-iommu";
+			reg = <0x0 0x2770a000 0x0 0x100>,
+			      <0x0 0x2770a100 0x0 0x100>;
+			interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru ACLK_RKNN1>, <&cru HCLK_RKNN_ROOT>,
+				 <&cru CLK_RKNN_DSU0>, <&cru ACLK_RKNN_CBUF>,
+				 <&cru HCLK_RKNN_CBUF>;
+			clock-names = "aclk", "iface", "npu",
+				      "aclk_cbuf", "hclk_cbuf";
+			#iommu-cells = <0>;
+			power-domains = <&power RK3576_PD_NPU1>;
+			status = "disabled";
+		};
+
 		gpu: gpu@27800000 {
 			compatible = "rockchip,rk3576-mali", "arm,mali-bifrost";
 			reg = <0x0 0x27800000 0x0 0x20000>;
-- 
2.43.0

