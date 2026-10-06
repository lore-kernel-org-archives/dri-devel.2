Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9671CCA5FFF
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 09:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 005B810E344;
	Tue,  6 Oct 2026 09:50:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jHDj8MCe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y/LYTe/K";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E0D310E328
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 09:50:44 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966dts1094598
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 09:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6Ha4G+1aNYP4f6YoGIgDMDgiIAhOacoRNWPdRGgoAiA=; b=jHDj8MCekZ6JfC4B
 S4mfHhn/0au93xYYbGmr69tec9NosiAuAfagL3KZy3EglhxHxiJOOBH34HXBYmqK
 nMZrmvCRU6NvvZAe5hF6J0jRtZr75f6hAx9wgH/HJEhVAfX10IYzNIAW6tCeN+d9
 UznX24ckAjMs58gCjfcfzJ1M67qm1DeZKzwEovO6IEPlG+c24PHwzcKvHsYN3w2Z
 rxxdP/Qt9oT0Qa8zJv7UyJu6jCyJWc2ncutGpYQ0V/lnyPfDYQMXdmuC6pyEKQ+K
 SpS26TqXuUjzlR+UK7jV733QSE4acxalMDAcpuA6OVAbQyvdXRv5ex4UN4l22Ti0
 UeNiSA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr3k156-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 09:50:43 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-88cd731cf24so1866952b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 02:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791280243; x=1791885043;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Ha4G+1aNYP4f6YoGIgDMDgiIAhOacoRNWPdRGgoAiA=;
 b=Y/LYTe/KGqMPpoBaKlasM4Hlrd+ZuYYkZX7N9f992bKx6VJPphIRalqsreMn4KH9lP
 04TR3fopNXbDO5DZmMcqgdRH4CCIVk9C9KMGRqOWOnAH8sLU3cjgNDJ1N84iP9ZQclI4
 mIFG5yZuPARBonlZhEF3amAvue5+7FMMRDPZb8uF8fsDjEE4BQwraNV6oWfIrgANnZ1O
 Nl8674k4jXor3WSsi4PW9Wg+DO4Etu7fnYQwdlqFKohVHeCI55ffu2WjYzK+BfJW5Pa2
 yJA5kY7Sy16GOWK0HOv1EjAB/tgUVYiAdkx81w49qcwDOnTnZxl9ri57Qp6b2Bv09MN+
 L7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791280243; x=1791885043;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Ha4G+1aNYP4f6YoGIgDMDgiIAhOacoRNWPdRGgoAiA=;
 b=hCTnfLKw+jXMlhwNVBxefW+lErSaVwB3L4R4ySeQ78AkC8IJaLh1a8QdvWjtksHZVY
 4WKSmhFv69kmHi/FAxL4zEmEf/avadF1813lbSzcXxwRLuAOzuy9qLGG6UdhzyLcUCIK
 xgCXz72RhgCcoFrMTOxHu26jjs9g26Orv/5/aawE3hnK3pmzSmNvSAy2h3XssWIWPAdi
 MkSQOESD0ijU5qX1T2aSxv4qLS5gnzYhJr9lMXG29LEiyy5HY69uu/tA6wTdwNpuMjYM
 1xaQZhNYq+civ62TEvXzh1/i5nqc0KiPm05Ndp1rA8B3qOQi0Z9PJ3W7iZm+wwE2XeQL
 J/Pg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjSTnF5qmJLFP/QtfC2+gsLrvsprtu8Jsgpl7yopozA6b6qjjSUS0WiAaq+AMPls9FeeDGYD8faxM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kvjwg2wYtu8oxU8yl78j48rFurb5B1UEpUm1xfoyrN3Un9G1j5
 I1Mlw6ONpF8Bec7rg29oWgpwJlTlG5SheY4bGr9Ib0c24rJ2p+F9VACdnxUlOmhj3U2484p2ZZz
 1U+TbBMh0uz5T8lEyjM6Hx3F7s2ZkcxVJxU3buGJhDQbWxNHxnoVRImQk8YqeDH3H8eoq9X8=
X-Gm-Gg: AYBFou2oddZnEeXbxcfijLXrqGFRpmphx0oQJbyexduJN2T8U9OrNfcgjbYA1sgbTyc
 VRhpQqwe3mTXdru8MkNwNzDMVwU15qvdstl96/hLP6Gyi9q4alT1MeY0au6xHA55sFaqTCqS6e1
 ptXbPg79UvuuEpT0U8fRdYkL4zgxp0xwiydXnBSrC2k8TloGZboLkWeMYG6nIygUOHlyOhRf5Nu
 YDu4urpTMPJzf1AnipBLmF32A2dYf/5Idx96nlcgRu12vDRo0Utw3gz/bYtS+jnxRgvh4Tsex07
 ZL10Q45s9Q/FNr0Aqqu7w66hpMyfbHioRCIWBGcZoLxLdW5vlcIR7RgBPGmEQyCbtTlbZ5zW1ut
 xfvqqIKPP86j/X4wN+68BFaPfwoCXUgP7yFqeqhrE5zpiDGn5h8Cq6ho0LfuXSmNb
X-Received: by 2002:a05:6a00:f87:b0:874:705d:f653 with SMTP id
 d2e1a72fcca58-890df4a5b05mr767276b3a.33.1791280242234; 
 Tue, 06 Oct 2026 02:50:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:f87:b0:874:705d:f653 with SMTP id
 d2e1a72fcca58-890df4a5b05mr767246b3a.33.1791280241639; 
 Tue, 06 Oct 2026 02:50:41 -0700 (PDT)
Received: from hu-ggarmidi-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-890acde961asm535523b3a.61.2026.10.06.02.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 02:50:41 -0700 (PDT)
From: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
Date: Tue, 06 Oct 2026 02:50:31 -0700
Subject: [PATCH 5/5] arm64: dts: qcom: Add Microsoft Surface Laptop 8th Edition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-mahua-surface-laptop-v1-5-406fc042162a@oss.qualcomm.com>
References: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
In-Reply-To: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791280230; l=28601;
 i=gopikrishna.garmidi@oss.qualcomm.com; s=20260102;
 h=from:subject:message-id; bh=pbfen2t1bmuwx5S6BaCEk+d3kwOfd19UuYEgd1stC14=;
 b=tyTFTrz2wcmlOiAcohqpZwI7BHyOMiMG8tNCezwmKDFfxhZ2ExnlW8orMWpVhBewQib7/eWcf
 b/+3r2WEzGwDjcZalNgC5CX8wq0VJPezfCo/lmuGAZRLbbdkOoVp/Dw
X-Developer-Key: i=gopikrishna.garmidi@oss.qualcomm.com; a=ed25519;
 pk=TkSjNEhrfsj90i3wkABTZtAjLNr2cfYsujaTvyOIDsE=
X-Proofpoint-ORIG-GUID: L9uuleyQMbJUXItYcXS66Yz7dgGeA04S
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzOSBTYWx0ZWRfX9gW2I1xL5DHG
 kggGPUlSbBM0AUczJRbabrBTJug6jY88UXVZuFSHWniC3Nm528nhaSlJEttCqyfb/7nz751Ihxc
 ht12uupyGgxreqjfcvKLp4BjIhd4+Dw=
X-Authority-Analysis: v=2.4 cv=PNWaavqC c=1 sm=1 tr=0 ts=6ac4c473 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=O5YpvohRKangM9AJkMwA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzOSBTYWx0ZWRfX0n8qXLumKaK+
 54FFc+YqgMz2upYmTnrQDrYKyHEBwjzXqqs1JffGhsqQlfYa7tkOhTYNFMLUeOqoxPrm32Q7jQK
 yhPOfFbVEaTAulvmgwRF5+iXxu2H3F+axTmjJe8SGRSzlv0fhHfKsG2ZqkfEwgUV10skiBcbvYz
 YG9LXWRncguNxjUASNExBGMfd52oLk17mlmXj0lKPS0/jRAbc8mG25zxNd5fBSnr6KgBCCoMUs1
 MUFxJjj9CibT3ffo4vRj3bmKG/3bZ/2NQw7jKDfU1JAafe2NJ0w2TLMCMlvhwdMm1MYSyHQ7jvg
 djrHe71WdwiSmT6saLy7noLLK8BuP4KOc0FNPhVh4jxge3AhLxzQ8sX2PxHC24q8yY83vkeW+Xq
 oSyLE1y9QR4m06QFkIUjgzU8xtRt02lXoxKik5RRAhx65bFh8IwypWJ9zn6MNn3Md/soiIG9Es4
 Xw97ortGRZgko9Wk8+w==
X-Proofpoint-GUID: L9uuleyQMbJUXItYcXS66Yz7dgGeA04S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060039
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

Add support for the Microsoft Surface Laptop 13.8" 8th Edition, which is
built on the Mahua SoC. Most of the board follows the Qualcomm reference
design. The keyboard, fan and platform profile sit behind the Surface
Aggregator Module on uart22, same as on the Surface Laptop 7.

What works:
- internal eDP panel (link capped at HBR, HBR2 fails channel equalization)
- both USB-C ports, host and charging
- USB multiport controller behind the two PTN3222 eUSB2 redrivers
- Wi-Fi and Bluetooth (WCN7850)
- speakers (2x WSA8845) and the two DMICs
- NVMe
- keyboard, fan and platform profile via SAM
- touchpad and touchscreen (HID over I2C)
- lid switch

The GPU and GMU remain disabled because support is not yet
functional on this platform.

Assisted-by: LLM
Signed-off-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 .../qcom/mahua-microsoft-surface-laptop-8-13in.dts | 1180 ++++++++++++++++++++
 2 files changed, 1181 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 88230c4e00ea..4e6ae446ff77 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -65,6 +65,7 @@ lemans-evk-ifp-mezzanine-dtbs	:= lemans-evk.dtb lemans-evk-ifp-mezzanine.dtbo
 dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-ifp-mezzanine.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= mahua-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= mahua-lenovo-thinkpad-t14s-gen7-lcd.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= mahua-microsoft-surface-laptop-8-13in.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= milos-fairphone-fp6.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= milos-nothing-asteroids.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= monaco-arduino-monza.dtb
diff --git a/arch/arm64/boot/dts/qcom/mahua-microsoft-surface-laptop-8-13in.dts b/arch/arm64/boot/dts/qcom/mahua-microsoft-surface-laptop-8-13in.dts
new file mode 100644
index 000000000000..2e37b6f96740
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/mahua-microsoft-surface-laptop-8-13in.dts
@@ -0,0 +1,1180 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+/dts-v1/;
+
+#include "mahua.dtsi"
+
+#include "pmcx0102.dtsi"
+#include "pmh0101.dtsi"
+#include "pmh0110-glymur.dtsi"
+#include "pmh0104-glymur.dtsi"
+#include "pmk8850.dtsi"
+#include "smb2370.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/gpio-keys.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+
+/* PMICs tied to Glymur's cluster2 are absent on Mahua. */
+/delete-node/ &pmcx0102_d_e0;
+/delete-node/ &pmcx0102_d0_thermal;
+/delete-node/ &pmh0104_i_e0;
+/delete-node/ &pmh0104_i0_thermal;
+/delete-node/ &pmh0104_j_e0;
+/delete-node/ &pmh0104_j0_thermal;
+
+/ {
+	model = "Microsoft Surface Laptop 8th Edition (13.8 inch)";
+	compatible = "microsoft,surface-laptop-8-13in", "qcom,mahua";
+
+	aliases {
+		i2c0 = &i2c0;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c8 = &i2c8;
+		i2c10 = &i2c10;
+
+		serial0 = &uart22;
+		serial1 = &uart14;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	clocks {
+		xo_board: xo-board {
+			compatible = "fixed-clock";
+			clock-frequency = <38400000>;
+			#clock-cells = <0>;
+		};
+
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <32000>;
+			#clock-cells = <0>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&hall_int_n_default>;
+		pinctrl-names = "default";
+
+		switch-lid {
+			label = "lid";
+			gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			wakeup-source;
+			wakeup-event-action = <EV_ACT_DEASSERTED>;
+		};
+	};
+
+	pmic-glink {
+		compatible = "qcom,glymur-pmic-glink",
+			     "qcom,pmic-glink";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_hs_in: endpoint {
+						remote-endpoint = <&usb_0_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss_in: endpoint {
+						remote-endpoint = <&usb_0_qmpphy_out>;
+					};
+				};
+			};
+		};
+
+		connector@1 {
+			compatible = "usb-c-connector";
+			reg = <1>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_hs_in1: endpoint {
+						remote-endpoint = <&usb_1_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss_in1: endpoint {
+						remote-endpoint = <&usb_1_qmpphy_out>;
+					};
+				};
+			};
+		};
+	};
+
+	reserved-memory {
+		linux,cma {
+			compatible = "shared-dma-pool";
+			size = <0x0 0x8000000>;
+			reusable;
+			linux,cma-default;
+		};
+	};
+
+	vreg_edp_3p3: regulator-edp-3p3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_EDP_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 70 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&edp_reg_en>;
+		pinctrl-names = "default";
+
+		regulator-boot-on;
+	};
+
+	vreg_nvme: regulator-nvme {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_NVME_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&pmh0101_gpios 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&nvme_reg_en>;
+		pinctrl-names = "default";
+
+		regulator-boot-on;
+	};
+
+	vreg_tpad: regulator-tpad {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_TPAD";
+
+		gpio = <&tlmm 102 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		startup-delay-us = <20000>;
+
+		pinctrl-0 = <&tpad_en>;
+		pinctrl-names = "default";
+	};
+
+	vreg_ts: regulator-ts {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_TS";
+
+		gpio = <&tlmm 38 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		startup-delay-us = <6000>;
+
+		pinctrl-0 = <&ts_pwr_en>;
+		pinctrl-names = "default";
+	};
+
+	vreg_wcn_0p95: regulator-wcn-0p95 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_WCN_0P95";
+		regulator-min-microvolt = <950000>;
+		regulator-max-microvolt = <950000>;
+
+		vin-supply = <&vreg_wcn_3p3>;
+	};
+
+	vreg_wcn_3p3: regulator-wcn-3p3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_WCN_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 94 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&wcn_sw_en>;
+		pinctrl-names = "default";
+
+		regulator-boot-on;
+	};
+
+	sound {
+		compatible = "qcom,glymur-sndcard";
+		model = "Microsoft-Surface-Laptop-8-13in";
+		audio-routing = "SpkrLeft IN", "WSA WSA_SPK1 OUT",
+				"SpkrRight IN", "WSA WSA_SPK2 OUT",
+				"VA DMIC0", "vdd-micb",
+				"VA DMIC1", "vdd-micb";
+
+		wsa-dai-link {
+			link-name = "WSA Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
+			};
+
+			codec {
+				sound-dai = <&left_spkr>, <&right_spkr>,
+					    <&swr0 0>, <&lpass_wsamacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		va-dai-link {
+			link-name = "VA Capture";
+
+			cpu {
+				sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
+			};
+
+			codec {
+				sound-dai = <&lpass_vamacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		displayport-0-dai-link {
+			link-name = "DisplayPort0 Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai DISPLAY_PORT_RX_0>;
+			};
+
+			codec {
+				sound-dai = <&mdss_dp0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		displayport-1-dai-link {
+			link-name = "DisplayPort1 Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai DISPLAY_PORT_RX_1>;
+			};
+
+			codec {
+				sound-dai = <&mdss_dp1>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+	};
+
+	wcn7850-pmu {
+		compatible = "qcom,wcn7850-pmu";
+
+		vdd-supply = <&vreg_wcn_0p95>;
+		vddio-supply = <&vreg_l15b_e0_1p8>;
+		vddaon-supply = <&vreg_l15b_e0_1p8>;
+		vdddig-supply = <&vreg_l15b_e0_1p8>;
+		vddrfa1p2-supply = <&vreg_l15b_e0_1p8>;
+		vddrfa1p8-supply = <&vreg_l15b_e0_1p8>;
+
+		wlan-enable-gpios = <&tlmm 117 GPIO_ACTIVE_HIGH>;
+		bt-enable-gpios = <&tlmm 116 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&wcn_wlan_bt_en>;
+		pinctrl-names = "default";
+
+		regulators {
+			vreg_pmu_rfa_cmn: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn";
+			};
+
+			vreg_pmu_aon_0p59: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p59";
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator-name = "vreg_pmu_wlcx_0p8";
+			};
+
+			vreg_pmu_wlmx_0p85: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p85";
+			};
+
+			vreg_pmu_btcmx_0p85: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p85";
+			};
+
+			vreg_pmu_rfa_0p8: ldo5 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+			};
+
+			vreg_pmu_rfa_1p2: ldo6 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+			};
+
+			vreg_pmu_rfa_1p8: ldo7 {
+				regulator-name = "vreg_pmu_rfa_1p8";
+			};
+
+			vreg_pmu_pcie_0p9: ldo8 {
+				regulator-name = "vreg_pmu_pcie_0p9";
+			};
+
+			vreg_pmu_pcie_1p8: ldo9 {
+				regulator-name = "vreg_pmu_pcie_1p8";
+			};
+		};
+	};
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pmh0101-rpmh-regulators";
+		qcom,pmic-id = "B_E0";
+
+		vreg_bob1_e0: bob1 {
+			regulator-name = "vreg_bob1_e0";
+			regulator-min-microvolt = <2200000>;
+			regulator-max-microvolt = <4224000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+		};
+
+		vreg_bob2_e0: bob2 {
+			regulator-name = "vreg_bob2_e0";
+			regulator-min-microvolt = <2540000>;
+			regulator-max-microvolt = <3600000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+		};
+
+		vreg_l1b_e0_1p8: ldo1 {
+			regulator-name = "vreg_l1b_e0_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2b_e0_2p9: ldo2 {
+			regulator-name = "vreg_l2b_e0_2p9";
+			regulator-min-microvolt = <1804000>;
+			regulator-max-microvolt = <2904000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7b_e0_2p79: ldo7 {
+			regulator-name = "vreg_l7b_e0_2p79";
+			regulator-min-microvolt = <2790000>;
+			regulator-max-microvolt = <2792000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8b_e0_3p3: ldo8 {
+			regulator-name = "vreg_l8b_e0_3p3";
+			regulator-min-microvolt = <3304000>;
+			regulator-max-microvolt = <3304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9b_e0_2p9: ldo9 {
+			regulator-name = "vreg_l9b_e0_2p9";
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10b_e0_1p8: ldo10 {
+			regulator-name = "vreg_l10b_e0_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11b_e0_1p2: ldo11 {
+			regulator-name = "vreg_l11b_e0_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12b_e0_1p14: ldo12 {
+			regulator-name = "vreg_l12b_e0_1p14";
+			regulator-min-microvolt = <1144000>;
+			regulator-max-microvolt = <1144000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l15b_e0_1p8: ldo15 {
+			regulator-name = "vreg_l15b_e0_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l17b_e0_2p4: ldo17 {
+			regulator-name = "vreg_l17b_e0_2p4";
+			regulator-min-microvolt = <2400000>;
+			regulator-max-microvolt = <2700000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l18b_e0_1p2: ldo18 {
+			regulator-name = "vreg_l18b_e0_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pmcx0102-rpmh-regulators";
+		qcom,pmic-id = "C_E1";
+
+		vreg_l1c_e1_0p82: ldo1 {
+			regulator-name = "vreg_l1c_e1_0p82";
+			regulator-min-microvolt = <832000>;
+			regulator-max-microvolt = <832000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2c_e1_1p14: ldo2 {
+			regulator-name = "vreg_l2c_e1_1p14";
+			regulator-min-microvolt = <1144000>;
+			regulator-max-microvolt = <1144000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3c_e1_0p89: ldo3 {
+			regulator-name = "vreg_l3c_e1_0p89";
+			regulator-min-microvolt = <890000>;
+			regulator-max-microvolt = <980000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4c_e1_0p72: ldo4 {
+			regulator-name = "vreg_l4c_e1_0p72";
+			regulator-min-microvolt = <720000>;
+			regulator-max-microvolt = <720000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-2 {
+		compatible = "qcom,pmh0110-rpmh-regulators";
+		qcom,pmic-id = "F_E0";
+
+		vreg_s7f_e0_1p32: smps7 {
+			regulator-name = "vreg_s7f_e0_1p32";
+			regulator-min-microvolt = <1320000>;
+			regulator-max-microvolt = <1352000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s8f_e0_0p95: smps8 {
+			regulator-name = "vreg_s8f_e0_0p95";
+			regulator-min-microvolt = <952000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s9f_e0_1p9: smps9 {
+			regulator-name = "vreg_s9f_e0_1p9";
+			regulator-min-microvolt = <1900000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2f_e0_0p82: ldo2 {
+			regulator-name = "vreg_l2f_e0_0p82";
+			regulator-min-microvolt = <832000>;
+			regulator-max-microvolt = <832000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3f_e0_0p72: ldo3 {
+			regulator-name = "vreg_l3f_e0_0p72";
+			regulator-min-microvolt = <720000>;
+			regulator-max-microvolt = <720000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4f_e0_0p3: ldo4 {
+			regulator-name = "vreg_l4f_e0_0p3";
+			regulator-min-microvolt = <1080000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-3 {
+		compatible = "qcom,pmh0110-rpmh-regulators";
+		qcom,pmic-id = "F_E1";
+
+		vreg_s7f_e1_0p3: smps7 {
+			regulator-name = "vreg_s7f_e1_0p3";
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1f_e1_0p9: ldo1 {
+			regulator-name = "vreg_l1f_e1_0p9";
+			regulator-min-microvolt = <904000>;
+			regulator-max-microvolt = <904000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2f_e1_0p88: ldo2 {
+			regulator-name = "vreg_l2f_e1_0p88";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4f_e1_1p2: ldo4 {
+			regulator-name = "vreg_l4f_e1_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-4 {
+		compatible = "qcom,pmh0110-rpmh-regulators";
+		qcom,pmic-id = "H_E0";
+
+		vreg_l1h_e0_0p89: ldo1 {
+			regulator-name = "vreg_l1h_e0_0p89";
+			regulator-min-microvolt = <832000>;
+			regulator-max-microvolt = <832000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2h_e0_0p72: ldo2 {
+			regulator-name = "vreg_l2h_e0_0p72";
+			regulator-min-microvolt = <832000>;
+			regulator-max-microvolt = <832000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3h_e0_0p32: ldo3 {
+			regulator-name = "vreg_l3h_e0_0p32";
+			regulator-min-microvolt = <320000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4h_e0_1p2: ldo4 {
+			regulator-name = "vreg_l4h_e0_1p2";
+			regulator-min-microvolt = <1080000>;
+			regulator-max-microvolt = <1320000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+/* GPU/GMU not fully functional yet on this platform. */
+&gmu {
+	status = "disabled";
+};
+
+&gpu {
+	status = "disabled";
+};
+
+&i2c0 {
+	clock-frequency = <100000>;
+
+	status = "okay";
+
+	/* Something @39, @3e, @44 */
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	/* INA4230 power monitors @40, @41, @42, @43, @44 */
+};
+
+&i2c5 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	ptn3222_1: redriver@43 {
+		compatible = "nxp,ptn3222";
+		reg = <0x43>;
+
+		reset-gpios = <&tlmm 184 GPIO_ACTIVE_LOW>;
+
+		vdd3v3-supply = <&vreg_l8b_e0_3p3>;
+		vdd1v8-supply = <&vreg_l15b_e0_1p8>;
+
+		#phy-cells = <0>;
+	};
+
+	ptn3222_0: redriver@4f {
+		compatible = "nxp,ptn3222";
+		reg = <0x4f>;
+
+		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
+
+		vdd3v3-supply = <&vreg_l8b_e0_3p3>;
+		vdd1v8-supply = <&vreg_l15b_e0_1p8>;
+
+		#phy-cells = <0>;
+	};
+};
+
+&i2c8 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	touchscreen@41 {
+		compatible = "hid-over-i2c";
+		reg = <0x41>;
+
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 43 IRQ_TYPE_LEVEL_LOW>;
+
+		vdd-supply = <&vreg_ts>;
+		post-power-on-delay-ms = <150>;
+
+		pinctrl-0 = <&ts_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&i2c10 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	touchpad@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x15>;
+
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 3 IRQ_TYPE_LEVEL_LOW>;
+
+		vdd-supply = <&vreg_tpad>;
+
+		pinctrl-0 = <&tpad_default>;
+		pinctrl-names = "default";
+
+		wakeup-source;
+	};
+};
+
+&lpass_vamacro {
+	pinctrl-0 = <&dmic01_default>;
+	pinctrl-names = "default";
+	qcom,dmic-sample-rate = <4800000>;
+	vdd-micb-supply = <&vreg_l1b_e0_1p8>;
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dp0 {
+	status = "okay";
+};
+
+&mdss_dp0_out {
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+};
+
+&mdss_dp1 {
+	status = "okay";
+};
+
+&mdss_dp1_out {
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+};
+
+&mdss_dp3 {
+	/delete-property/ #sound-dai-cells;
+
+	pinctrl-0 = <&edp0_hpd_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	aux-bus {
+		panel {
+			compatible = "edp-panel";
+			enable-gpios = <&tlmm 18 GPIO_ACTIVE_HIGH>;
+			power-supply = <&vreg_edp_3p3>;
+
+			pinctrl-0 = <&edp_bl_en>;
+			pinctrl-names = "default";
+
+			port {
+				edp_panel_in: endpoint {
+					remote-endpoint = <&mdss_dp3_out>;
+				};
+			};
+		};
+	};
+};
+
+&mdss_dp3_out {
+	data-lanes = <0 1 2 3>;
+	/* HBR2 channel equalization fails, limit the link to HBR */
+	link-frequencies = /bits/ 64 <1620000000 2700000000>;
+
+	remote-endpoint = <&edp_panel_in>;
+};
+
+&mdss_dp3_phy {
+	vdda-phy-supply = <&vreg_l2f_e1_0p88>;
+	vdda-pll-supply = <&vreg_l4f_e1_1p2>;
+
+	status = "okay";
+};
+
+&pcie4 {
+	pinctrl-0 = <&pcie4_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie4_phy {
+	vdda-phy-supply = <&vreg_l1c_e1_0p82>;
+	vdda-pll-supply = <&vreg_l4f_e1_1p2>;
+
+	status = "okay";
+};
+
+&pcie4_port0 {
+	reset-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
+
+	wifi@0 {
+		compatible = "pci17cb,1107";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
+		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
+		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
+	};
+};
+
+&pcie5 {
+	vddpe-3v3-supply = <&vreg_nvme>;
+
+	pinctrl-0 = <&pcie5_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie5_phy {
+	vdda-phy-supply = <&vreg_l2f_e0_0p82>;
+	vdda-pll-supply = <&vreg_l4h_e0_1p2>;
+
+	status = "okay";
+};
+
+&pcie5_port0 {
+	reset-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
+};
+
+&pmh0101_gpios {
+	nvme_reg_en: nvme-reg-en-state {
+		pins = "gpio14";
+		function = "normal";
+		bias-disable;
+	};
+};
+
+&pmk8850_rtc {
+	qcom,no-alarm;
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/glymur/microsoft/mahua/qcadsp8480.mbn",
+			"qcom/glymur/microsoft/mahua/adsp_dtbs.elf";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/glymur/microsoft/mahua/qccdsp8480.mbn",
+			"qcom/glymur/microsoft/mahua/cdsp_dtbs.elf";
+
+	status = "okay";
+};
+
+&smb2370_j_e2_eusb2_repeater {
+	vdd18-supply = <&vreg_l15b_e0_1p8>;
+	vdd3-supply = <&vreg_l7b_e0_2p79>;
+};
+
+&smb2370_k_e2_eusb2_repeater {
+	vdd18-supply = <&vreg_l15b_e0_1p8>;
+	vdd3-supply = <&vreg_l7b_e0_2p79>;
+};
+
+&swr0 {
+	status = "okay";
+
+	/* WSA8845, Left */
+	left_spkr: speaker@0,0 {
+		compatible = "sdw20217020400";
+		reg = <0 0>;
+		reset-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "SpkrLeft";
+		vdd-1p8-supply = <&vreg_l15b_e0_1p8>;
+		vdd-io-supply = <&vreg_l18b_e0_1p2>;
+		qcom,port-mapping = <1 2 3 7 12 14>;
+	};
+
+	/* WSA8845, Right */
+	right_spkr: speaker@0,1 {
+		compatible = "sdw20217020400";
+		reg = <0 1>;
+		reset-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "SpkrRight";
+		vdd-1p8-supply = <&vreg_l15b_e0_1p8>;
+		vdd-io-supply = <&vreg_l18b_e0_1p2>;
+		qcom,port-mapping = <4 5 6 7 13 15>;
+	};
+};
+
+&tcsr {
+	vdda-qrefrpt0-0p9-supply = <&vreg_l2f_e1_0p88>;
+	vdda-qrefrpt1-0p9-supply = <&vreg_l2f_e1_0p88>;
+	vdda-qrefrpt2-0p9-supply = <&vreg_l2f_e1_0p88>;
+	vdda-qrefrpt3-0p9-supply = <&vreg_l1f_e1_0p9>;
+	vdda-qrefrpt4-0p9-supply = <&vreg_l2h_e0_0p72>;
+	vdda-qrefrpt5-0p9-supply = <&vreg_l2h_e0_0p72>;
+	vdda-qrefrx0-0p9-supply = <&vreg_l2f_e1_0p88>;
+	vdda-qrefrx1-0p9-supply = <&vreg_l2f_e1_0p88>;
+	vdda-qrefrx2-0p9-supply = <&vreg_l2f_e1_0p88>;
+	vdda-qrefrx3-0p9-supply = <&vreg_l2h_e0_0p72>;
+	vdda-qreftx1-0p9-supply = <&vreg_l1f_e1_0p9>;
+	vdda-refgen3-0p9-supply = <&vreg_l1f_e1_0p9>;
+	vdda-refgen3-1p2-supply = <&vreg_l4f_e1_1p2>;
+};
+
+&tlmm {
+	gpio-reserved-ranges = <4 4>,  /* EC TZ Secure I3C */
+			       <10 2>, /* OOB UART */
+			       <44 4>; /* Security SPI (TPM) */
+
+	edp_bl_en: edp-bl-en-state {
+		pins = "gpio18";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	edp_reg_en: edp-reg-en-state {
+		pins = "gpio70";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
+	edp0_hpd_default: edp0-hpd-default-state {
+		pins = "gpio119";
+		function = "edp0_hot";
+		bias-disable;
+	};
+
+	hall_int_n_default: hall-int-n-state {
+		pins = "gpio2";
+		function = "gpio";
+		bias-disable;
+	};
+
+	pcie4_default: pcie4-default-state {
+		clkreq-n-pins {
+			pins = "gpio147";
+			function = "pcie4_clk_req_n";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio146";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		wake-n-pins {
+			pins = "gpio148";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	pcie5_default: pcie5-default-state {
+		clkreq-n-pins {
+			pins = "gpio153";
+			function = "pcie5_clk_req_n";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio152";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		wake-n-pins {
+			pins = "gpio154";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	ssam_state: ssam-state-state {
+		pins = "gpio71";
+		function = "gpio";
+		bias-disable;
+	};
+
+	tpad_default: tpad-default-state {
+		pins = "gpio3";
+		function = "gpio";
+		bias-disable;
+	};
+
+	tpad_en: tpad-en-state {
+		pins = "gpio102";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	ts_default: ts-default-state {
+		int-n-pins {
+			pins = "gpio43";
+			function = "gpio";
+			bias-disable;
+		};
+
+		reset-n-pins {
+			pins = "gpio48";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+			output-high;
+		};
+	};
+
+	ts_pwr_en: ts-pwr-en-state {
+		pins = "gpio38";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	wcn_sw_en: wcn-sw-en-state {
+		pins = "gpio94";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	wcn_wlan_bt_en: wcn-wlan-bt-en-state {
+		pins = "gpio116", "gpio117";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&uart14 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn7850-bt";
+		max-speed = <3200000>;
+
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
+	};
+};
+
+&uart21 {
+	status = "disabled";
+};
+
+&uart22 {
+	status = "okay";
+
+	embedded-controller {
+		compatible = "microsoft,surface-sam";
+
+		interrupts-extended = <&tlmm 71 IRQ_TYPE_EDGE_RISING>;
+
+		current-speed = <4000000>;
+
+		pinctrl-0 = <&ssam_state>;
+		pinctrl-names = "default";
+	};
+};
+
+&usb_0 {
+	dr_mode = "host";
+
+	status = "okay";
+};
+
+&usb_0_dwc3_hs {
+	remote-endpoint = <&pmic_glink_hs_in>;
+};
+
+&usb_0_hsphy {
+	vdd-supply = <&vreg_l3f_e0_0p72>;
+	vdda12-supply = <&vreg_l4h_e0_1p2>;
+
+	phys = <&smb2370_j_e2_eusb2_repeater>;
+
+	status = "okay";
+};
+
+&usb_0_qmpphy {
+	vdda-phy-supply = <&vreg_l3f_e0_0p72>;
+	vdda-pll-supply = <&vreg_l4h_e0_1p2>;
+	refgen-supply = <&vreg_l2f_e0_0p82>;
+
+	status = "okay";
+};
+
+&usb_0_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss_in>;
+};
+
+&usb_1 {
+	dr_mode = "host";
+
+	status = "okay";
+};
+
+&usb_1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_hs_in1>;
+};
+
+&usb_1_hsphy {
+	vdd-supply = <&vreg_l3f_e0_0p72>;
+	vdda12-supply = <&vreg_l4h_e0_1p2>;
+
+	phys = <&smb2370_k_e2_eusb2_repeater>;
+
+	status = "okay";
+};
+
+&usb_1_qmpphy {
+	vdda-phy-supply = <&vreg_l1h_e0_0p89>;
+	vdda-pll-supply = <&vreg_l4h_e0_1p2>;
+	refgen-supply = <&vreg_l2f_e0_0p82>;
+
+	status = "okay";
+};
+
+&usb_1_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss_in1>;
+};
+
+&usb_mp {
+	status = "okay";
+};
+
+&usb_mp_hsphy0 {
+	vdd-supply = <&vreg_l2h_e0_0p72>;
+	vdda12-supply = <&vreg_l4h_e0_1p2>;
+
+	phys = <&ptn3222_0>;
+
+	status = "okay";
+};
+
+&usb_mp_hsphy1 {
+	vdd-supply = <&vreg_l2h_e0_0p72>;
+	vdda12-supply = <&vreg_l4h_e0_1p2>;
+
+	phys = <&ptn3222_1>;
+
+	status = "okay";
+};
+
+&usb_mp_qmpphy0 {
+	vdda-phy-supply = <&vreg_l2h_e0_0p72>;
+	vdda-pll-supply = <&vreg_l4h_e0_1p2>;
+	refgen-supply = <&vreg_l4f_e1_1p2>;
+
+	status = "okay";
+};
+
+&usb_mp_qmpphy1 {
+	vdda-phy-supply = <&vreg_l2h_e0_0p72>;
+	vdda-pll-supply = <&vreg_l4h_e0_1p2>;
+	refgen-supply = <&vreg_l4f_e1_1p2>;
+
+	status = "okay";
+};

-- 
2.34.1

