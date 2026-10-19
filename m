Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDB8CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 672AB10E6D9;
	Mon, 19 Oct 2026 11:26:29 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07B2910EAA0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:26:09 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OqKY3256585
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L/iv0Hjic3D1gnEdMJH+n9iwoS1ng3NDhVKTxbtsGWw=; b=PwzgyYAQeeqsF16C
 34otn7IdrYPX/joLSwulceMORSeSywqTnQhNc95A4TOHQfcRupn9cJ38TJEmIy/H
 BTY153r06ZGw3uImg+XeIhR8DQ/BOo5zFkJlz6xjf1ZeX5YmHTesHZWzRmAk+YvJ
 PJ893shDonUtzdCLaagA/TWf0WAR0zYJg52cSdhDNeJqkMrfoWFfVAOCiT3iW9C5
 4EKi8WZHFB7qrO8HcTfwFx5Ii3/+7KhyR+4uDOOEQxKr/Z20CZrhfpY4ZSisX0oq
 eESjL+n9bahMk5Cv2on0lwBhD853xmHCaTsTU85Kor755uf2E8M9cRIV2Mrw3Rup
 BpC93Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3f8tm4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:26:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f26dd2165so704640385a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792409167; x=1793013967;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L/iv0Hjic3D1gnEdMJH+n9iwoS1ng3NDhVKTxbtsGWw=;
 b=D+EjzI2749VMnYK5BWe8zlMpgH0cC1S8Az2YWwgPKd24ES4aw79cU/0MVSO+1EtqMR
 zGQyUjCNT6GoNIzmtZ/wkmywxUETuKHNaE/CxS03n8KJbS7lI5toIKc5mIbSdei3bnnn
 B6pFmUZSwBGgj4gB23ZUHyLq9hvR/BdxC8AKgI65ntRlukuXlrfDeegZzURX/bhIAtb5
 iH2VgZg9OGdXuCf3m8BIDfQhSSbS9XOaORs1D5lKn+0ixQ5VKs3EBy3vIuBKyRL52QLV
 Ce4TvmjRs0GHOxYplPV79tFWKuVrVuSmOTctEB9dhE/yroQdWDE+QRpO0ynF08oEKTcQ
 NThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792409167; x=1793013967;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L/iv0Hjic3D1gnEdMJH+n9iwoS1ng3NDhVKTxbtsGWw=;
 b=khoGWeD0IzBCnyhgwFwNKkWn5druDdy20XalB8dAAXswSltT91Byhz0dytgMbjfSYF
 NRg3emI/dtl/x++bGM4t2EthDzX17eRhIUP3S0CjuQ0gh967FFnev2iUdlq69UeyJvms
 dS9hNslZ/ly63zpn2Hb34SRg9vzLHTyXUXBYAddYvYaeanvwv3q/1UiMHrEEvZi9kgk7
 YLaUWe8nvGF7L2dd71sSRCcMLZbWuPEKKYM6poJZIapqkdJb1cHivGCcNBffUU8opINh
 1ZyR5DhoG250WVYPoa+eRhMGPtrFLdL3RWFlBeWfiTSJTiI2T1GqFEZXSqSJhh37Y3uq
 wPAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxw9yjzkAnQem4YuUGEmJrwdEk5ZgNC3IZAZCQQ4Viny7OXAKPReJ70Gq0DeduQV2dzhz9/JSP2jfs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKwFSfwu4s8q/0iTI/smrr+PjFth0r21tIgcRn/rZviLTWTBePs
 X6oMu3r7Yx24qEBD5CiHkoa6jB6SFLbVbLQq7vEQ6pygGzpo5Y9L3rKjBIZvVzM0F77aN8H3b0e
 Oq61iBTEg/jRoQKHWXq+/E8KKxSAWQpSBC6x8jjjFfwjlZsDVbnQU17P5DxPUDiBtOzBz4pOMRU
 T6AzI=
X-Gm-Gg: AYBFou1qPbMy5WczMcRvg9LarfheYgwITKbCsnFJVzh/khcEGdJPM0cmjnS8DPBRHb2
 ZuFnPIi64vH3zjNlmMlL7Y4I/w3wdATAMFrO9onJHm0XAZw1TZNq4MIcg8G1OL51b6cukYRvbF0
 uMyS5duxkLhEGg/J1Z1yWMnnZAFP4bb9CQHPZ5pkISStAVtGvfOYm3fKWmbUKuFYhQ9XkhyeYM/
 FxvSkgp9wAGh6hXASzqGbo58LobfrOTCd7F+/5FoH5P8bT0cLdl03ezkwQFYGR9De3y+jsVOXWy
 8Pl5qj3hezZ0kxV3pGYgPukHZsGN32fZdu87szqKxpbJuOS3SRdpw8iTU33bzzrnp0MRCjHmp6K
 7Cr8uX+cOgx52rWjPN0QzUI9eqE4bYKmspR66i4vN+nBSXqY3HRVD/MTZmPhywjn31LWM9FZfIk
 OOlx4nGLfbQA6X
X-Received: by 2002:a05:620a:6f87:20b0:93f:2def:5cd5 with SMTP id
 af79cd13be357-93f2def5f1dmr706070285a.51.1792409167348; 
 Mon, 19 Oct 2026 04:26:07 -0700 (PDT)
X-Received: by 2002:a05:620a:6f87:20b0:93f:2def:5cd5 with SMTP id
 af79cd13be357-93f2def5f1dmr706067085a.51.1792409166750; 
 Mon, 19 Oct 2026 04:26:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab37ba8851sm12807621fa.22.2026.10.19.04.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 04:26:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:25:44 +0300
Subject: [PATCH v2 8/8] arm64: dts: qcom: sm8150-hdk: add display card overlay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-sm8150-display-card-v2-8-86c05068efc5@oss.qualcomm.com>
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
In-Reply-To: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3897;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=bqeeWAz+d4IHQrcnKjbogs3Jr+vUY0ij/Dq/7cvVfhY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1f47DvElBnzXYultIe4T5kpg6h6cmQXePLs8C
 oEt3lHh3k2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatX+OwAKCRCLPIo+Aiko
 1ejlCACckV4FUSqkCy6G0axjtLG15uGa0R/QYb0KshxjrPod2Tc4VvA3WNkJBvc16zeUQfc8o+Q
 M5YD4BoJVAQTOhlfS009+/7NHs30Jq2cUKP+FXe+ggo61qUC6iTSg5v050YgWg7uds9UcnY4zed
 MABGKlEjWcHUzAvBlNLAfazG5uCM2U8lp5VcQ+IydWm3tMQU8drkAEeQ3i/PYsYKpzmektp6e3d
 eRRlRxuHB2lCCnqeaEklKp42xdAHq3t1MfWrurLdj2XUuE92RfxrTbNfNfwy4+uoShpj/4tPUxi
 y8fubgeboAwcb8y/CMawbCWA5Pi0B4TNKcU/FwsFcmhqGgZY
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: iNtdm8-6UxU3fEJL_bsFHF8LD8TU69Bl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfXxY0IQAxZPD1M
 CHNq/ciF3xr0nLgKX/m5NU4MhgXFf+bJqZ7GSHNNVvMVlVCkeeE1OGS1c0J90ViAbXpOcoYFHxJ
 smnq6iPzzHuxtGUkAZZlIMUyWwsYvCOnYqkRy/39i2uNvOweAKdLPs5QegdTjSeiC429Qt6yMAn
 xSt1Y8hvmgwemKTz//8AdCxkaxh2uf7FUbw/MCMVhJrTgYvpUOvWnDlTyu+ZlZJQb3ubJZXquUT
 +1bMADbd1M/+kTk8o5k5cNdPxsHlBPj4RFw33ngJDRQSO0M+d7U3c24ewqoeoWUabAtNgPUz4qR
 KtaNz+1ii3D8Uampjy/gbzjPcUyRccpmzzuj6nV2ThQd7dh5GDRgUYiWd6c6Jfp6QBF3Xm9Ftkg
 VoHE92lCHp2eCGFkIHCqITVZ3sToCAAHpAGehm1sfGXiX4/K3VsE4zIPOc4+rVLc9Pd+r80/1Te
 VS1sEjiCiK5gaRgjJ7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfXzYErDgv/sFpF
 mwJL/Tzcf7a66CMynZqRpNZSs17CAVeEMVJu8Vtp/GU3cRYNIbGZ6t8LBuq6DCkoA6LvtKpcoM4
 YBZ1gUerTHzkJrAwnImIwJ9NqYy9N9Y=
X-Proofpoint-GUID: iNtdm8-6UxU3fEJL_bsFHF8LD8TU69Bl
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad5fe50 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=k5xu95HCNwnmwRhsQXIA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190045
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

The SM8150 HDK can be fitted with a display card carrying a Truly
NT36850 WQHD dual-DSI panel. It uses the PM8150L WLED for the backlight
and LCDB for the bias rails, and it is mutually exclusive with the
on-board LT9611 HDMI bridge.

Only two of the three WLED strings are connected on the card: the
backlight stays dark and the boost runs into the overvoltage limit if
only the third string is driven.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   4 +
 .../boot/dts/qcom/sm8150-hdk-display-card.dtso     | 113 +++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 85d06a950b4a..571bda210d63 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -409,6 +409,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm7325-nothing-spacewar.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7325-xiaomi-lisa.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7325-xiaomi-taoyao.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-hdk.dtb
+
+sm8150-hdk-display-card-dtbs	:= sm8150-hdk.dtb sm8150-hdk-display-card.dtbo
+
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-hdk-display-card.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-microsoft-surface-duo.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-sony-xperia-kumano-bahamut.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk-display-card.dtso b/arch/arm64/boot/dts/qcom/sm8150-hdk-display-card.dtso
new file mode 100644
index 000000000000..bd57459f9c86
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8150-hdk-display-card.dtso
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/*
+ * Display Card kit overlay.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/dts-v1/;
+/plugin/;
+
+/* Disable HDMI bridge related nodes (mutually exclusive with the display card) */
+&lt9611_codec {
+	status = "disabled";
+};
+
+&mdss_dsi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	panel@0 {
+		compatible = "truly,wqhd60-nt36850";
+		reg = <0>;
+
+		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
+
+		vddio-supply = <&vreg_l14a_1p8>;
+		avdd-supply = <&pm8150l_lcdb_ldo>;
+		avee-supply = <&pm8150l_lcdb_ncp>;
+
+		backlight = <&pm8150l_wled>;
+
+		pinctrl-0 = <&disp0_reset_n_active>, <&mdp_vsync>;
+		pinctrl-1 = <&disp0_reset_n_suspend>, <&mdp_vsync>;
+		pinctrl-names = "default", "sleep";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				panel0_in: endpoint {
+					remote-endpoint = <&mdss_dsi0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				panel1_in: endpoint {
+					remote-endpoint = <&mdss_dsi1_out>;
+				};
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&panel0_in>;
+};
+
+&mdss_dsi1_out {
+	remote-endpoint = <&panel1_in>;
+};
+
+&pm8150l_lcdb {
+	status = "okay";
+};
+
+&pm8150l_lcdb_ldo {
+	regulator-min-microvolt = <5500000>;
+	regulator-max-microvolt = <5500000>;
+};
+
+&pm8150l_lcdb_ncp {
+	regulator-min-microvolt = <5500000>;
+	regulator-max-microvolt = <5500000>;
+};
+
+&pm8150l_wled {
+	qcom,num-strings = <2>;
+
+	status = "okay";
+};
+
+&tlmm {
+	disp0_reset_n_active: disp0-reset-n-active-state {
+		pins = "gpio6";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	disp0_reset_n_suspend: disp0-reset-n-suspend-state {
+		pins = "gpio6";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	mdp_vsync: mdp-vsync-state {
+		pins = "gpio8";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};

-- 
2.47.3

