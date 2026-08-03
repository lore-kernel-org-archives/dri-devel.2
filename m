Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C2EC5518E
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4C9310E571;
	Mon,  3 Aug 2026 09:42:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="HhuS5De7";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="msoteRdq";
	dkim-atps=neutral
Received: from flow-a8-smtp.messagingengine.com
 (flow-a8-smtp.messagingengine.com [103.168.172.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 154A610E571
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 09:42:34 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailflow.phl.internal (Postfix) with ESMTP id 754A8138007E;
 Mon,  3 Aug 2026 05:42:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 03 Aug 2026 05:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1785750153; x=
 1785753753; bh=9rVvREo+IB67dNS/dnT90XlXCvimHsqUqxQVruTv8JE=; b=H
 huS5De7FZbPOkFmo9U/WW3xpEbgKCI2B4f8hpVqlAUPzzM9IrPtmOVzAcgvdqCSd
 fg2fOzJKXnTNjGH4nkMeaMTlhD3Gf96Fohmr2ersboNXjVFQJm1sp/PaZjgQZykA
 APWvjw1BYM4jynlgV9Qxh68E2hERkTCS60wQTozOR4m+UMGDqy9R1dA/Z3/MCJvz
 m8/DFrP24wQ9G7lWlWZX+ULLqc49aU8nx5k3Ifn5P3BLdzgzHnYrZ/02F/vmHR3C
 uN/cDJcswbHxFEG5n7qCM55WIeMWIs698Y67rIQcGZsU7hqFwcZj9KthHB5fLLTv
 9QDn7q5kuIhzNy01e/DWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1785750153; x=1785753753; bh=9
 rVvREo+IB67dNS/dnT90XlXCvimHsqUqxQVruTv8JE=; b=msoteRdqPk1A0yEQA
 x2lIhsUZ4fTbJNT5eiiL+/L50WWvlo2oEutV6cxpCY8XsYwJtCdnK9STTNOGywnF
 JRCqsw47Zo3NSr4LHZ5EBf/Sj5Uk960Bou16FvXIZtsYtMawB6HtvA/oPFLMMGNA
 lcVgdeYwYcjAc0ozttxxoKEhRZkvDTfDhfqKfsRkiGdcQCe4L+ERApm312jx/rsm
 BOL+E/k1WokKqEjHlZw84mCMNvC/1j4v0GAnF/DQf6WuLhzTwb4oP5AzJTlJ6sNg
 vcjsdQaz+b2zuY4MMKFqMkjLJjE1WxPla94/Gv65xbiH0oCY2oFIXe1s80FB2T3+
 /FnJA==
X-ME-Sender: <xms:iWJwalExaaqVBL3VRpRUOq3iebapW_ftYW9ipID8VM595gLGK6nKhg>
 <xme:iWJwagznjs8eJD6kZn6hiRCqdB2rQqLDV7OvZDx9vMM4eN6aT0pFogC83As0brvRp
 0BQeYBJoFRXYW-tZJ4bm1z6dRXQrl_l43HRFeCO48U2hDw-HeJfOw>
X-ME-Received: <xmr:iWJwakrci_SkU0F5Fy0_oRJcJLlRK0N5rQJrqaz5rBaX0IrSmH2MvI58KBVA4hWUx5rVpZU6QQ>
X-ME-Proxy-Cause: dmFkZTFjY2LyPb/9LfXn4QCibSWxeeRWJF58tfvFoO1JpUYwl/f8fQT4gNNHDkwtzTG3mW
 QB9Z5E2ZaiRLdwTk7Bf1cP6j2q2LuyYXAyG5SuQy6DwnGU1S0GzExnzN4TJrhwhfA2voA2
 n2K0qQ7ZhvGfjI6tOvBvuW8sUUpow6OyrJ4H8Jm+8CF5bCgHVQ4I3VQwTEXeIHlOg0F+vh
 Iqy32CoHpA615dyPNJOIbTr8Kos0tW88p1VITCDcWhI1Pkk+5LOtOBwFm8TmwIOzW5PsEo
 tPufk9ICYRNR6HPn77DziTnrKAnrLZzqwRBloqTdNsqFLZVnL8NzKJLgMxCkSg4QeWk1Rk
 RIl/iYbPSYuTRJxSFAIrPdbVVPR8cNfSzoS7TJnonXo/16AFb+lZFwipDpvnqc2iWQDci5
 FjMVbyLZJtHSYXxs18rLpcUDnVlW9lH76TprAAMoeYrAcjdZUpWn4Z3eSxDf1eBThNADcz
 qgZEDwscRKQM4uChRR724/vYUEWhEiF4gTCNDGd5UWZlOwvDnskcDGCvAP2lEXwF0lFzk2
 fLi5rFKYyKijZk8Y3zOFpFiNPgub5txjlY/+TFX/Hng4xOmlB6KmQ+YvERcTA10DMOiMqo
 VRWUJLPDlHLfphUyFwkP0MU82vZ/qZLVfGc8BAs7EuOWi5uLvgW6uAxFbwJg
X-ME-Proxy: <xmx:iWJwajdVaYbMSP5H8xMEqiXjGz2bKtvv1yJ9ufP_m42mnR1-KNEq6Q>
 <xmx:iWJwaqhj7ru2nDxsTOSACkiF-GJpnEQKSAsDM6hbFOTuLdfMvdL64A>
 <xmx:iWJwahJjGFxqICxXnkwlqPo37Nl2TZxvSMAbb_pHpzvuxxCp7m7EFw>
 <xmx:iWJwanoCuLpMobJdhATE0mdwxR7kvR0-1fvIEGYm2ntkiumh4LhraA>
 <xmx:iWJwamet7NQvaGhGeUXDk4iJ4jnGT-rhZxvFG7KRpDcppcGqfoVeme3x>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 05:42:25 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, ulfh@kernel.org,
 p.zabel@pengutronix.de, ogabbay@kernel.org
Cc: royalnet026@gmail.com, alchark@flipper.net, chaoyi.chen@rock-chips.com,
 krzk@kernel.org, will@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v4 5/6] arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
Date: Mon,  3 Aug 2026 21:41:24 +1200
Message-ID: <20260803094125.3285895-6-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803094125.3285895-1-gahing@gahingwoo.com>
References: <20260803094125.3285895-1-gahing@gahingwoo.com>
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

Add the two RKNN cores and their IOMMUs, plus the NPU power-domain
resets the pmdomain driver now cycles on power-on. Both cores are
disabled by default; boards enable what they wire up.

Each core lists both NPU power domains, its own first. The compute path
needs NPU1 powered even when only core 0 runs, and a node with a single
domain would be auto-attached by the driver core before the driver can
attach the list itself. The IOMMUs keep one domain each, since they rely
on that same auto-attach.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 76 +++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index b0c0d3c8b..6baed2579 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1070,14 +1070,22 @@ power-domain@RK3576_PD_NPUTOP {
 						power-domain@RK3576_PD_NPU0 {
 							reg = <RK3576_PD_NPU0>;
 							clocks = <&cru HCLK_RKNN_ROOT>,
-								 <&cru ACLK_RKNN0>;
+								 <&cru ACLK_RKNN0>,
+								 <&cru CLK_RKNN_DSU0>,
+								 <&cru ACLK_RKNN_CBUF>,
+								 <&cru HCLK_RKNN_CBUF>;
+							resets = <&cru SRST_A_RKNN0_BIU>;
 							pm_qos = <&qos_npu_m0>;
 							#power-domain-cells = <0>;
 						};
 						power-domain@RK3576_PD_NPU1 {
 							reg = <RK3576_PD_NPU1>;
 							clocks = <&cru HCLK_RKNN_ROOT>,
-								 <&cru ACLK_RKNN1>;
+								 <&cru ACLK_RKNN1>,
+								 <&cru CLK_RKNN_DSU0>,
+								 <&cru ACLK_RKNN_CBUF>,
+								 <&cru HCLK_RKNN_CBUF>;
+							resets = <&cru SRST_A_RKNN1_BIU>;
 							pm_qos = <&qos_npu_m1>;
 							#power-domain-cells = <0>;
 						};
@@ -1832,6 +1840,70 @@ qos_npu_m1ro: qos@27f22100 {
 			reg = <0x0 0x27f22100 0x0 0x20>;
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
+			resets = <&cru SRST_A_RKNN0>;
+			reset-names = "srst_a";
+			power-domains = <&power RK3576_PD_NPU0>, <&power RK3576_PD_NPU1>;
+			iommus = <&rknn_mmu_0>;
+			status = "disabled";
+		};
+
+		rknn_mmu_0: iommu@27702000 {
+			compatible = "rockchip,rk3576-iommu", "rockchip,rk3568-iommu";
+			reg = <0x0 0x27702000 0x0 0x100>,
+			      <0x0 0x27702100 0x0 0x100>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru ACLK_RKNN0>, <&cru HCLK_RKNN_ROOT>,
+				 <&cru CLK_RKNN_DSU0>, <&cru ACLK_RKNN_CBUF>,
+				 <&cru HCLK_RKNN_CBUF>;
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
+			resets = <&cru SRST_A_RKNN1>;
+			reset-names = "srst_a";
+			power-domains = <&power RK3576_PD_NPU1>, <&power RK3576_PD_NPU0>;
+			iommus = <&rknn_mmu_1>;
+			status = "disabled";
+		};
+
+		rknn_mmu_1: iommu@2770a000 {
+			compatible = "rockchip,rk3576-iommu", "rockchip,rk3568-iommu";
+			reg = <0x0 0x2770a000 0x0 0x100>,
+			      <0x0 0x2770a100 0x0 0x100>;
+			interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru ACLK_RKNN1>, <&cru HCLK_RKNN_ROOT>,
+				 <&cru CLK_RKNN_DSU0>, <&cru ACLK_RKNN_CBUF>,
+				 <&cru HCLK_RKNN_CBUF>;
+			#iommu-cells = <0>;
+			power-domains = <&power RK3576_PD_NPU1>;
+			status = "disabled";
+		};
+
 		gmac0: ethernet@2a220000 {
 			compatible = "rockchip,rk3576-gmac", "snps,dwmac-4.20a";
 			reg = <0x0 0x2a220000 0x0 0x10000>;
-- 
2.43.0

