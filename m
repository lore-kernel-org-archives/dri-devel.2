Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9FAC61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 04:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5754710E5C8;
	Mon, 31 Aug 2026 04:10:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="gIMkriDS";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="O3jPMS5o";
	dkim-atps=neutral
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 787E810E5C8
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 04:10:22 +0000 (UTC)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 618F37A00F1;
 Mon, 31 Aug 2026 00:10:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Mon, 31 Aug 2026 00:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1788149421; x=
 1788235821; bh=1rtSl7F1lXnj0NSEGIt5XoDJWgiooLMidXujnASVSco=; b=g
 IMkriDSsp81lyKJ13VZbqUO0A6wYaMNox1LzjdpIACuRDf6cZbXZc4GP2SdCm7gg
 Rnmwh8U06KNWJbOeUMRgjdIgq9rI9TE5kRXqS8+U2VXlT11UvW6YPxeo+bjsddy5
 kTEobuQUPQAeR4CIT2aaiJiObEHypzVW/qtsnTfSndxRjpFA9tSBrguQ1SKZxjNR
 d1/xhea63eX475bpbSSTyRHYnzzsB0WYGrJVSvDzimTGA5NxOYQnKkL1ViHY7fMk
 BVWawg7mnJtJ5AUqiXIvoR8T/kXLjjee3Buhu4Ni9wjWjZwP3yuoU/gs7m1rTJy6
 sxFgLveN4GwPBSEWgabqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1788149421; x=1788235821; bh=1
 rtSl7F1lXnj0NSEGIt5XoDJWgiooLMidXujnASVSco=; b=O3jPMS5ofQiUP4fup
 Xpo+IvodRMnwjkNzkFL4sxhbV/J8lEvzuTJ/26pLX4JCg45W6XMaqGSLLYbgEQpr
 1YUfvq6NLwQ0Y9NIt/e1unyY0gM7EGNWSNvazWghS2K0yRzZJpPKI6ZHVw2kFidX
 NS2zTrNv8vs1yHiEmzvSlcjaPrqBq5JzB1zuJJn7n6iwxEG5hs6gCAaiIKnqMKqL
 4G788GGZ6fylSb27EqDsomcV+FirS/nGqAHJcmFz3bibhLdLurobo6yKy3FsVDql
 J5NVan6S7cOnuQ34+lehfR91n7EdPqUCLCjGKPUvFPdatPmKfDsqo0vScmomL8id
 zur6Q==
X-ME-Sender: <xms:rP6Uam5PW-bmssbwY2L9pusOvN-adBTm3MCeVx23eAND9Zs3gf7v9g>
 <xme:rP6UarasfRI48NLoE7zeFBoq_wswVYvqnXnpXdCN1fSUNiKofF2aV3IQkceWCp0zV
 YTr8U1Tb7CYKNba9jMNXUK6gDhNmbfxzi3xmWeM5BWhw0d6VDNDP84>
X-ME-Received: <xmr:rP6UarfEJrycTuFg1MyjibFJr64fQ3UkC-L1fb7ptDuzi8oYceTJRLqDMLgLQTW7dC8WyyberQ>
X-ME-Proxy-Cause: dmFkZTEx+po1mcqdLfMtSY8FvXq8T3HoBfcrJyvXx6Xw/VVRnuC+tflUomiu8xboh5GI+n
 INDm/Tx9Pw5Xi7jl+kZyKO6/rGBlLgfsCV25Si+oFVHPI66fywg/EZJ41rwcQzrOEcjqx5
 Hgwh7SixxBbIYfkHi9Fih7vbCSLQ1qEIVkW30Do5wiBn/ocGyVi4+ZkQnGubRgb7sZKjl4
 WOyH6t37Q8ejAZmvvrHCyzorQEhgu+gjIYDzKbHnLi+X0iy5lRVuKNGnD3ITp7MykDdDQw
 eYNZlspLD42ubYy6R0iijafHdevnjaSgMJMvyOr2J1yWbWHJzFBFbP+dxGVJCwNLkABYoN
 9bgOGSys4zJGRYI8O3z9Bx2Lp9RdGuOrFVtBoQ3+qnDOgsH3AIVeThatj6Bnk/WgbJQVAM
 38/jgFCa+DLS6Aj5wVmJuj5rHF+qgyO7RkHi9DnA5ULyQ3KELgmQLNzoxBB5mVXRSPd36A
 uZgbyDDChrEStROb6MFfixtQ4IH537UfmmChIXunrU8Ck6GefdvCr+lwLsH88tUqtxXM8/
 Za+wyoDnlM1FjOpL/B7SB/yZV6a0sDjtStwUcS857+jRygSxkDc6j8CLXUtT45qUDvUWQn
 gYjsXGpZ7OMJJ2EvGRoWVNjMUo96smkhZ6B8RieOVpT4knQ/ySl33qW4OXHw
X-ME-Proxy: <xmx:rP6Uag4BejJoKAM1tvIRC31Y8WLYVCd6iGVXWK63HPD27ximsHOUcA>
 <xmx:rP6UavVMp4ovzMZu9CsnOw_rUW3DELLUzVRAaxCTXFKeFSTrNPTzIA>
 <xmx:rP6UavadjN4Bqi5yF1BOtq1J740SHzoH3bSC6FqQZxYudrVMMsTUxA>
 <xmx:rP6Uamze1nTMR8zSl4vFpuNF14VQAayDbPz8ODEvFyhBBFgRqnk8Lg>
 <xmx:rf6Uaowa68t58ekmrJ1PyL6f2QEipUW5CGF-SZmJCIp1tbyghdb91ymJ>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 00:10:14 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v10 12/13] arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
Date: Mon, 31 Aug 2026 16:08:03 +1200
Message-ID: <20260831040804.24111-13-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831040804.24111-1-gahing@gahingwoo.com>
References: <20260831040804.24111-1-gahing@gahingwoo.com>
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

Add the two RKNN cores and their IOMMUs. Both cores are disabled by
default; boards enable what they wire up.

PD_NPU0 and PD_NPU1 are siblings under PD_NPUTOP and hold one core each,
but the convolution buffer and the DSU sit above them: ACLK_RKNN_CBUF,
HCLK_RKNN_CBUF and CLK_RKNN_DSU0 belong to the block rather than to
either core, and PD_NPUTOP already lists all three. Add them to both
core domains as well, so a core domain switching state has the clocks of
the path it shares running, and give each core domain the BIU reset that
the pmdomain driver now cycles once power is on.

Each core lists both core domains, its own first, so that a core in use
has the whole block powered. Whether a single core can reach the shared
path with the sibling domain off is not something this series
establishes; listing both is the description that has been tested here.
The IOMMU in front of each core lists that core's domain only.

Label the outer PD_NPU node so a board can attach the NPU rail to the
domain that gates the block.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 82 +++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index b0c0d3c8b..2d0133cdf 100644
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
@@ -1261,6 +1269,74 @@ power-domain@RK3576_PD_VO1 {
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

