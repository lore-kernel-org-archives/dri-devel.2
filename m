Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE8DCC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDE8D11220E;
	Thu, 15 Oct 2026 08:59:29 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 684E611220E
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:59:09 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F3wbjE1889509
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1Bvz/kMR7NqEowR/9FJ0mOCFGWKDpq2MbUNyuR8mPjA=; b=NL0VUDjMmWLHlrnm
 KgWfhAhbuiV1UZSWpNh5WYt8fEyx3TKkYUAcAgTBeRgV4tjyJNLhxisk321x8dfn
 +2Nc5qaRX6/IS3p/1+WDRGasztTebnIGr/mO7wtgK/i94R/9qBrq+0atYiy54a8V
 MiNUPOC4VUHcUUTJUSwEabDPhR/vacKPtn3ODJ/IZWql6UIwyE6SeBFD+4r4nMxU
 LJ7ViUCVxyEElP8HSRlzmJ6iEJEb0G7z/xlnPAzBvuj2wCvjQ4DyKEIr5lLIiV4R
 E7mmsu4Z1T9EFccVOSX1yX9xaRyL9+UGxmmwNDDInI1ZCO84okWfz2V1w404X9Tm
 rFcxtw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqda14yv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:59:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb93c874bso328441885a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 01:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792054748; x=1792659548;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1Bvz/kMR7NqEowR/9FJ0mOCFGWKDpq2MbUNyuR8mPjA=;
 b=DjdENroZ+od3gs60GK76c4fSUJdBeb6ICz77vWqgJfxjJQKvsOoROI2Lc5c5e1OOCQ
 ow3GRtkStiUrLBR31frqiqJNYhVxgBeAVYNrBb8z4g5GWutzBiYNI4hJCX/amJEuN6Ur
 RZMwveKf7+Noos2lgJx59Cws/9WYGx/EZ0+9BzacNhSneRZL96h2LRniPtvZTgQT6qIQ
 ahCtXwFXnfq/PU4S/vJIasvsfCWWYT8/C+nSIUhJPnbpQ5ES0zAFAw2T2xbFzvjYtK8P
 8nVmRDu2VRefwU1gagq91fr5tuqmgJAdKpd7FZRCGLWSKciqN3Wp/LAKv2OK/rVsbdZb
 252w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792054748; x=1792659548;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1Bvz/kMR7NqEowR/9FJ0mOCFGWKDpq2MbUNyuR8mPjA=;
 b=cGhPb4zIxObxE9/kSBfpFk8H0pSwcZpgrcvVEfOSnOZIjyFnI/eZZnCWP6xP9zLQWW
 5WV1Bh9q97dMZ0mAM8Qxdqo0/KjUew9xNn+PUpN8evMzOMFo9I78TMovw+mfYHaCQIWs
 1lrGRx8zWKXOGf+SDvusxHVvJ30dOEVxJJ5ezQYwmM6wDMOu5HVwVoBPfR3UlwpgpYoH
 vmrx3BIzd45pef2Uil1UTxt5w2NXnncaOJ5ddY9/NHEzvIJGGEUOFOm/5DFktNsM42GQ
 KpyuM2aKF9QXX3JC1aEQU8FWS/b873O75nDMfO32r55z0abwUm8/miwMfB/9gDEDhpIz
 nqiA==
X-Forwarded-Encrypted: i=1;
 AKwUvByMenFLWBSbo6uJzMIuDAsS0JjxVriVf47iCFDAcW5gfRi1a1hEUdX2d/+v0IP6yjqAsdPRy3nMT+U=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ68QEuzdwWKMjidmhYJgV6TTLNxr3KmdnuHj/ISIVzNR7pWv98
 w4Sb+Y0hy4ksZHfeMkpgGFJ1/uirt06miosFa3U1nGQS/ErEtS2bhmQyXjSEPzrTjhEiDgqx2nl
 JbtRH3JVq3H+ANXhWGNPoCyT7IqqMQBSi51aV+mj3GqTiGkE79F/UEMcqBl0xIksXPNgBUK8=
X-Gm-Gg: AYBFou1eqwFlfrC3RpkxH3RtzlR3U7wR1kkuLk6Ob1LiMHCutWb/z3nmZUkXtjBMBHx
 Xph1XCrn4pnDLERaUhVQbgGA4VKHeqEQpi1zVYMDE+waY/iak89+mxpMD4CjMUjjrvkZbsUCmrA
 XNaE9I/U34+x6dQ9YWKE20S5C21EClP5H4XShF1bmXZmYjaCVoczjWRW7Sl+D3uYo8Kk4YvWbqB
 XQ0ucW2o+xSI0PGmmhRD2CDqqAiQezEUJ+U3NINs0w6AoGuwfnpTI/l5j9fug90xhyvs53LYiG7
 dNr+uzN6Dh9M7GFo/eFeWzJ5/841P9r/i8m4dlfBieJPe1/jci78LyeN3gphEp4JzanQcM297Kh
 ahwPvtcMYWUiN6+BYn3zC39i42Z1CgwTU6m9gja43hDEjYnF+FIKbKKUF0jh7YH6l66i73k+mNu
 uTQThmq+72v4D+
X-Received: by 2002:a05:620a:199a:b0:93e:cf47:eb9e with SMTP id
 af79cd13be357-93ecf47f98amr2170753085a.11.1792054747695; 
 Thu, 15 Oct 2026 01:59:07 -0700 (PDT)
X-Received: by 2002:a05:620a:199a:b0:93e:cf47:eb9e with SMTP id
 af79cd13be357-93ecf47f98amr2170750385a.11.1792054747204; 
 Thu, 15 Oct 2026 01:59:07 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be3b51fd1dsm371590e87.58.2026.10.15.01.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:59:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:58:46 +0300
Subject: [PATCH 9/9] arm64: dts: qcom: sm8150-hdk: add display card overlay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sm8150-display-card-v1-9-5c14928cef29@oss.qualcomm.com>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
In-Reply-To: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3677;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=0G8oHV7Iaf+F2rNSJejgBlOHtOGWquaiHcHxeXy4LWk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq0JXIdAlz95KI9h/Kzl+CwuERsjroHKyCSch49
 rcQmC4Iy/yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatCVyAAKCRCLPIo+Aiko
 1X8zB/sGFmKRpkZKPP3Pe4eixaHQrtRFlcQ7U4ki7V87Zh0fXkkspOXM631dB+G6qJXqXTMJQdj
 345ORGYg9pDpXIQS6ynTN95ahClYwkejpnpTQGRcG0E/5tDpcjJGlocwWiRa3gjqiSqBCkCxE8Q
 +y7Kes5WUzTfJXMNi5I2UTmlKpD9p1qTkQJGJ3e15es3r3QljyYk/YxDf/PN7sdhYIajTbBFo+B
 rIUG/8PQBerZK744GEy8/cKOZrn+tOk4GOqfg6fHyOcW4Bo2z6xhbM8wh0Z+emCrocoHyqjfIGt
 hrxz7gocQprafndfcXP7ys1CROUMrfo99VOS59r1xrS4seut
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX+h5ZH+LqCTdJ
 kS47gi0cl0YGDXnPffaI4sHb8SlPVOIq/Bjt3epoPMarsR1AcIi9LPs7c8F495q9Ni1DSnIJlmh
 C9lLH/nDlrncoP7RxubkD5VK6kN9kbE=
X-Authority-Analysis: v=2.4 cv=K9u3jCWI c=1 sm=1 tr=0 ts=6ad095dc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=k5xu95HCNwnmwRhsQXIA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: gfzvZGoF_gxsTyLhqAJbCgEQj0Xjn5e8
X-Proofpoint-ORIG-GUID: gfzvZGoF_gxsTyLhqAJbCgEQj0Xjn5e8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX7pxj84BeC+0v
 dS1uvXP8EI0EF22vq8ORzyxgsiq8/9ryck8VJzotjalRAFeldylVPugBFfxEar5MLGRCrFIp2hB
 Vi3otpqjHZDEqX8JUMfMkPeeOulWHQLpANxfZM+b80L54Nqa0SsC48z/+jT3q1rVDA/7+wRMgrH
 iIVIfzpmYfq7YdIQOsX+7bweGz7IPv5fXZrinTaklg2545YbSuDqJsVSphJ47f7lmY4k5UBbhNQ
 /2oPpCszB6RryHr1xFiA/1owJbu2UcgcyIpQVGr+0Ru83W2O0HJiVA4X4tZn+xMXDqNFlYwkRQQ
 yYBigT1J7zKrCvll8rynqCX+hmthf+l0buR4KyeZh2EPEq3yJePgWrpttX0/ZT5QI1RF93LgLTU
 epKhlXMdzidlVmnlksoeIx3+UYYJtIKsZbiosTLoHK3G3foOJ9H8h1FVjBNiacVs/TF2L07oYu5
 haJKnBpq/bpwWHAMWFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150035
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
 .../boot/dts/qcom/sm8150-hdk-display-card.dtso     | 103 +++++++++++++++++++++
 2 files changed, 107 insertions(+)

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
index 000000000000..205cd6d2cd71
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8150-hdk-display-card.dtso
@@ -0,0 +1,103 @@
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

