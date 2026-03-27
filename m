Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2009410F284B
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 880F010EF0F;
	Fri, 27 Mar 2026 16:13:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="ZpYkovZW";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74A8E10EF1A
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:12:42 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-66b2f6e983bso1202881a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 09:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1774627961; x=1775232761; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n9/UsdaZM+2GPQHD2Sp+JdEWIFi7VFbfkHHFK1k1sLU=;
 b=ZpYkovZWgpM3oRlp3gFPosziVBsyyTYQ438rjVQHqx2uy0IC6Qw7Lg3Jdfx1r7JW0G
 CWH0Gc6BeAJrjZbEfBvca3aQKjiJbuZXR/WnjPX3SRN1JBJkL1KnfgNJIDusY4AmGrs2
 RzWlw22JJ6Mhj5fL1er/c1xmM6Q0pbcdU7dPSxP+ZPlIjAIAzlzByDBfV9vuWXI2hyab
 +zdsFRSEmrU+ghiGv1fpTOfxEn3Jy6NFYcjxJHZJWzdTVY+NALsCqlfIISw98YB303bQ
 bZXpLLhAR/iAlHpBcNVoaubomws8kXjagSN2+N6yBiW7kawrdimYEpy0nTmgBZqFlZxJ
 8ylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774627961; x=1775232761;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n9/UsdaZM+2GPQHD2Sp+JdEWIFi7VFbfkHHFK1k1sLU=;
 b=F6K6U7Mk+XScyb+CbPHnF4x+ExotnUy8Yo3sypZjH4X4qeuG1uYgVvV0nZbaW5LVDF
 e/k/CH2FQNWrgBIZMJb1MLSLh/x8S2FFS4yryjmzuNFXPPp0oZpPl9oeA6lSf0JLAs1D
 EDFpuXJEW68zP3Mc9m24wbCun3Sd4RLaQyQnhR+m5r7fzNCU33wdin0ojNNcNSjvGXQ1
 DNdT0i9fHihfOaQQPusW9r0e0eauyzR+aaPVJaNkRrfEr6RLOkJFcPhMgw6mJQOrzsMX
 zDnDvmbIa4kNknmVn0VkgcsKW3bTnj+RHqHRhk3YImdzNKoseUBCdhoC56biKyr7fh3A
 +0zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwb3rVkIBI1h6mOijwdhExhzs//ur2VncVQhkWVsgnB3VfKa9V7vVLXxWHILws0RfZoaLuxDiv76s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyNrIRzwQaQwYF91pyKl5NecFG32MbvBss/cJ3wAOMKmLF2QhBc
 j6MpTgSWdWRg8qhhI/qzkAr0GrCRsZ79UnsLU0I875QHAuC82l2uo3gbHfRQ0VHr0RI=
X-Gm-Gg: ATEYQzz5M5ut6lP+r/9oDXFKgfZCY8hZUQJ1huaiAxpjp5q52IP46VCBqfHWEaDN2c9
 0kyF8rRhUtbrMLMNhCb10vpUhxZ3L6lpuPAMTKco84w/ZfC+PMDmKt0R+V8FMAUqN0yvMKHNL5N
 QTVm0e5IKgtn5/qmWbMhdUROQaMXMW/3vVZukjfUVTfk9FzEtuPMvAcB6d6ok36cTwfVZBkf//7
 BDL/vlTn6yhAixTi4HTGJFpwN2FU3u9uTTXxdbjiWae0Y8Q7nkadWx6HHwRJgr3TkwdY7oJ1PCq
 PKz0eM9YFDg7HuHYd6dBpp2UTq9i67UOR1kJHJR/GT30l3ACuXrO2371dgZqw7wSc/wHYGTO5nD
 /AbtJ43x5JIT1IluNtgyFGaY7uNIYf9Z7JaYkbxnSlsWxS1Hj0K7hQDrVcBrmIhKqzFB0QVEY1b
 G9zhISxuJ2SOuhc2U/4BoKUk1cy0PYQnUl4tT7/5TP764b3w727hbp1KlZy0iKXyLYehafVoj63
 lHhdA==
X-Received: by 2002:a17:907:c297:b0:b97:e32f:7ee8 with SMTP id
 a640c23a62f3a-b9b507b10camr227429066b.37.1774627960722; 
 Fri, 27 Mar 2026 09:12:40 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b20265cc0sm273518366b.15.2026.03.27.09.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:12:40 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 27 Mar 2026 17:12:28 +0100
Subject: [PATCH v2 9/9] arm64: dts: qcom: milos: Add display (MDSS)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-milos-mdss-v2-9-bc586683f5ca@fairphone.com>
References: <20260327-milos-mdss-v2-0-bc586683f5ca@fairphone.com>
In-Reply-To: <20260327-milos-mdss-v2-0-bc586683f5ca@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Marek <jonathan@marek.ca>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexander Koskovich <akoskovich@pm.me>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774627949; l=6556;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=OuRa4QGyn4gLjseaQdBVxKJCgJKE3/e1JsoCMaIDUuc=;
 b=kR8CwCxCbJ0lmNsaT1AKtyANCK1Dy7nFNBHhR/iQxUTagFiNkuNe0HM/iqXYzgP119NX+5Pg5
 nsQ9392nUdgB3Ej/8+a3FjWzWzgNrxqEVHzTCBdhImqGnQTC8YKoLNc
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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

Add device nodes for display: MDSS, DPU, DSI and DSI PHY.

DisplayPort is not added for now.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/milos.dtsi | 211 +++++++++++++++++++++++++++++++++++-
 1 file changed, 209 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/milos.dtsi b/arch/arm64/boot/dts/qcom/milos.dtsi
index 67f8ef4d524a..c1be2f43dbb8 100644
--- a/arch/arm64/boot/dts/qcom/milos.dtsi
+++ b/arch/arm64/boot/dts/qcom/milos.dtsi
@@ -3,6 +3,7 @@
  * Copyright (c) 2025, Luca Weiss <luca.weiss@fairphone.com>
  */
 
+#include <dt-bindings/clock/qcom,dsi-phy-28nm.h>
 #include <dt-bindings/clock/qcom,milos-camcc.h>
 #include <dt-bindings/clock/qcom,milos-dispcc.h>
 #include <dt-bindings/clock/qcom,milos-gcc.h>
@@ -1860,6 +1861,212 @@ camcc: clock-controller@adb0000 {
 			#power-domain-cells = <1>;
 		};
 
+		mdss: display-subsystem@ae00000 {
+			compatible = "qcom,milos-mdss";
+			reg = <0x0 0x0ae00000 0x0 0x1000>;
+			reg-names = "mdss";
+
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+				 <&gcc GCC_DISP_HF_AXI_CLK>,
+				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
+
+			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
+
+			interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &cnoc_main SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "mdp0-mem",
+					     "cpu-cfg";
+
+			power-domains = <&dispcc DISP_CC_MDSS_CORE_GDSC>;
+
+			iommus = <&apps_smmu 0x1c00 0x2>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			status = "disabled";
+
+			mdss_mdp: display-controller@ae01000 {
+				compatible = "qcom,milos-dpu";
+				reg = <0x0 0x0ae01000 0x0 0x8f000>,
+				      <0x0 0x0aeb0000 0x0 0x3000>;
+				reg-names = "mdp",
+					    "vbif";
+
+				interrupts-extended = <&mdss 0>;
+
+				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
+					 <&dispcc DISP_CC_MDSS_MDP_CLK>,
+					 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+				clock-names = "nrt_bus",
+					      "iface",
+					      "lut",
+					      "core",
+					      "vsync";
+
+				assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+				assigned-clock-rates = <19200000>;
+
+				operating-points-v2 = <&mdp_opp_table>;
+
+				power-domains = <&rpmhpd RPMHPD_CX>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						dpu_intf1_out: endpoint {
+							remote-endpoint = <&mdss_dsi0_in>;
+						};
+					};
+				};
+
+				mdp_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-200000000 {
+						opp-hz = /bits/ 64 <200000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-342000000 {
+						opp-hz = /bits/ 64 <342000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-402000000 {
+						opp-hz = /bits/ 64 <402000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-535000000 {
+						opp-hz = /bits/ 64 <535000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+
+					opp-600000000 {
+						opp-hz = /bits/ 64 <600000000>;
+						required-opps = <&rpmhpd_opp_nom_l1>;
+					};
+
+					opp-630000000 {
+						opp-hz = /bits/ 64 <630000000>;
+						required-opps = <&rpmhpd_opp_turbo>;
+					};
+				};
+			};
+
+			mdss_dsi0: dsi@ae94000 {
+				compatible = "qcom,milos-dsi-ctrl", "qcom,mdss-dsi-ctrl";
+				reg = <0x0 0x0ae94000 0x0 0x1000>;
+				reg-names = "dsi_ctrl";
+
+				interrupts-extended = <&mdss 4>;
+
+				clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
+					 <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_PCLK0_CLK>,
+					 <&dispcc DISP_CC_MDSS_ESC0_CLK>,
+					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&gcc GCC_DISP_HF_AXI_CLK>;
+				clock-names = "byte",
+					      "byte_intf",
+					      "pixel",
+					      "core",
+					      "iface",
+					      "bus";
+
+				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
+				assigned-clock-parents = <&mdss_dsi0_phy DSI_BYTE_PLL_CLK>,
+							 <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>;
+
+				operating-points-v2 = <&mdss_dsi_opp_table>;
+
+				power-domains = <&rpmhpd RPMHPD_CX>;
+
+				phys = <&mdss_dsi0_phy>;
+				phy-names = "dsi";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						mdss_dsi0_in: endpoint {
+							remote-endpoint = <&dpu_intf1_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						mdss_dsi0_out: endpoint {
+						};
+					};
+				};
+
+				mdss_dsi_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-187500000 {
+						opp-hz = /bits/ 64 <187500000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-300000000 {
+						opp-hz = /bits/ 64 <300000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-358000000 {
+						opp-hz = /bits/ 64 <358000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+				};
+			};
+
+			mdss_dsi0_phy: phy@ae95000 {
+				compatible = "qcom,milos-dsi-phy-4nm";
+				reg = <0x0 0x0ae95000 0x0 0x200>,
+				      <0x0 0x0ae95200 0x0 0x300>,
+				      <0x0 0x0ae95500 0x0 0x400>;
+				reg-names = "dsi_phy",
+					    "dsi_phy_lane",
+					    "dsi_pll";
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&rpmhcc RPMH_CXO_CLK>;
+				clock-names = "iface",
+					      "ref";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				status = "disabled";
+			};
+		};
+
 		dispcc: clock-controller@af00000 {
 			compatible = "qcom,milos-dispcc";
 			reg = <0x0 0x0af00000 0x0 0x20000>;
@@ -1868,8 +2075,8 @@ dispcc: clock-controller@af00000 {
 				 <&sleep_clk>,
 				 <&gcc GCC_DISP_AHB_CLK>,
 				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>,
-				 <0>, /* dsi0_phy_pll_out_byteclk */
-				 <0>, /* dsi0_phy_pll_out_dsiclk */
+				 <&mdss_dsi0_phy DSI_BYTE_PLL_CLK>,
+				 <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>,
 				 <0>, /* dp0_phy_pll_link_clk */
 				 <0>; /* dp0_phy_pll_vco_div_clk */
 

-- 
2.53.0

