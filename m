Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C91CA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFC3310EA11;
	Sat, 10 Oct 2026 11:56:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c39lyplR";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7BEB10EA18
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 11:56:18 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso6731795e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 04:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791633377; x=1792238177; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XawY6rGwERNjw0CFRz+0ONBwu0wfWrlBMNsKmysKmec=;
 b=c39lyplRNk6epjo5tkRsdzEtx3eSOK8YNMLesOsuwWvre3k9UNObzd3BHhRFEe3ODl
 UD7GNKCBXyL0FFtTG7BBYCBuDC6wh4ThPqVCZi/LgbNYz/dM/0iNUwOcgTiYh1Uc+Hps
 2Mpm6AfMZaGQ2QpRB/AQZSduDJj/t670ls6A0RGcFlzVcMAPLz4XXnHMlhTOfc2xhopx
 FDHInvHRjWFJIFo0OYOohPw3a2odrzYv4isIsynSNgJEm80FryNUZmlgyjGuNlE+QnHw
 BF4P9rIRUbrRw48TAx49lF+FCtj/9993He79Pw3Yu3/xyVSAzm66L6jp4fiSQNfGvTnE
 +QFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791633377; x=1792238177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XawY6rGwERNjw0CFRz+0ONBwu0wfWrlBMNsKmysKmec=;
 b=1LxEOIIG1M3Fw9X+uGmtR/+aH1xgDG+O/LYwQjnin0SalOQTaEt+bQtgR6B/7qmxXc
 upPjVV14lIlX2vqTltwBcmCa54/tj+EY5Vk589g3Ylp4+EtqKEvP7howe0t9U2hQlSyu
 iytM8V/SGtQ27jBUtxJDeRRsBmNI2xwAVG26dDNq5ERTgpEMIu29toCsL0WXCQx6Uj2A
 1zbIh6G52Mfo+awBta7GX9CHD48vTXgrbcr4ieK7FCjd9EwpNUSDuPAt5hDduOkGKl/X
 wO5wkmpRCZ++4ckFfExVjfipVthWmtjgio1xURPES4rw9H6zNE9UPx2J+DVV4gEx99lk
 EXkg==
X-Forwarded-Encrypted: i=1;
 AKwUvByjKWMGyeVDpiI1Y4AvfzUU32dmqEccuFsUKHDqglx7JftubBuTWKJP/Vv5qyFcsKWPoXkW/Q5JoRc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLsAu7r/Po/+hHdkzoFSeMF+TQU4sz5Pjr7zSigXjZyDs6AL+kt
 g7JrAJlTuoTLx7HIJC+kO/77atWTuJUZufvwm49wNwM+hW0a96sQ0ETC
X-Gm-Gg: AYBFou3hKSSm9i2vUElP8d+eQwljeA3hK/axTWbaz2uPtzFSa0tk4FcCh91TiuS+YdU
 Mgwdy8krIAmnFRr3fyuiuZA98bslk0AD271V/5xqO+K1YRaOk7UXRpHn4pYcYMp57cCKTUYdqRe
 WILumMt3x6cuT4m0sEq42GunWf5d17++2RMxHDAa3QdtK/dnZQeU+2aTY2dAirorU8KvFOqn3Gk
 VAOSq8EZ2TbbMihsUHcfXPGDDi0ca3WJkK1HZ8SxBVkvy2/I4s6mXC+4wtzVrMcXt3I47hoiCbV
 eMCX2MbpbMjX9eaxW/KE4GJHIzCmWIFIDGCx9mlQkS2K2ONoc7UDCeac6wa4j1oi13AMNtAtQ9+
 uGkI15kIbJTFFXLk6VlhGIyn7t9I3UajFsDYmw9G/I9MRmoDyBsTMp6mWSmTImVO9QMCnEos0Gq
 Oqqp6fCl8UyCw0CRRPGKrJ6YRBYvd1wTgrSxBenJmysQaVoBhocllkq3vZR2Gd84E/HQ==
X-Received: by 2002:a05:600c:820a:b0:4a0:98c:e082 with SMTP id
 5b1f17b1804b1-4a18e4a3f0dmr88323785e9.13.1791633377176; 
 Sat, 10 Oct 2026 04:56:17 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9aca657sm8746340f8f.43.2026.10.10.04.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 04:56:16 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Fabien Parent <fparent@baylibre.com>,
 chunhui dai <chunhui.dai@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 7/7] arm64: dts: mediatek: mt8167: Add HDMI display nodes
Date: Sat, 10 Oct 2026 13:54:07 +0200
Message-ID: <20261010115539.9237-8-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010115539.9237-1-l.scorcia@gmail.com>
References: <20261010115539.9237-1-l.scorcia@gmail.com>
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

Add the required nodes to drive HDMI output on the mt8167 SoC.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt8167.dtsi | 62 ++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
index 27cf32d7ae35..ab76e0637eb1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
@@ -112,6 +112,27 @@ apmixedsys: apmixedsys@10018000 {
 			#clock-cells = <1>;
 		};
 
+		hdmi_phy: hdmi-phy@10018300 {
+			compatible = "mediatek,mt8167-hdmi-phy";
+			reg = <0 0x10018300 0 0x20>;
+			clocks = <&apmixedsys CLK_APMIXED_HDMI_REF>;
+			clock-names = "pll_ref";
+			clock-output-names = "hdmtx_dig_cts";
+			mediatek,ibias = <0xa>;
+			mediatek,ibias_up = <0x1c>;
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		cec: cec@1001a000 {
+			compatible = "mediatek,mt8167-cec", "mediatek,mt8173-cec";
+			reg = <0 0x1001a000 0 0xbc>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_26M_CEC>;
+			status = "disabled";
+		};
+
 		iommu: m4u@10203000 {
 			compatible = "mediatek,mt8167-m4u";
 			reg = <0 0x10203000 0 0x1000>;
@@ -120,6 +141,15 @@ iommu: m4u@10203000 {
 			#iommu-cells = <1>;
 		};
 
+		hdmiddc: i2c@11011000 {
+			compatible = "mediatek,mt8167-hdmi-ddc", "mediatek,mt8173-hdmi-ddc";
+			reg = <0 0x11011000 0 0x10>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_26M_HDMI_SIFM>;
+			clock-names = "ddc-i2c";
+			status = "disabled";
+		};
+
 		mmsys: syscon@14000000 {
 			compatible = "mediatek,mt8167-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
@@ -145,6 +175,38 @@ smi_common: smi@14017000 {
 			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
 		};
 
+		hdmi: hdmi@1401b000 {
+			compatible = "mediatek,mt8167-hdmi";
+			reg = <0 0x1401b000 0 0x400>;
+			clocks = <&mmsys CLK_MM_HDMI_PXL>,
+				 <&mmsys CLK_MM_HDMI_PLL>,
+				 <&mmsys CLK_MM_HDMI_ADSP_BCK>,
+				 <&mmsys CLK_MM_HDMI_SPDIF>;
+			clock-names = "pixel", "pll", "bclk", "spdif";
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_LOW>;
+			phys = <&hdmi_phy>;
+			phy-names = "hdmi";
+			mediatek,syscon-hdmi = <&mmsys 0x900>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					hdmi0_in: endpoint { };
+				};
+
+				port@1 {
+					reg = <1>;
+
+					hdmi0_out: endpoint { };
+				};
+			};
+		};
+
 		imgsys: syscon@15000000 {
 			compatible = "mediatek,mt8167-imgsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;
-- 
2.43.0

