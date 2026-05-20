Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32109CD5BAA
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 16:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2482F10F051;
	Wed, 20 May 2026 16:40:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="edaATBZ6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8139510E1F6
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:40:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3A3FF445CD;
 Wed, 20 May 2026 16:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04D6BC2BCB8;
 Wed, 20 May 2026 16:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779295242;
 bh=knTtz4F+48wvyzMOyCiKlq4avjtUX4KrcQGtpNh5T3Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=edaATBZ6OF6uEmcJOlTD8c7N+6lNTTzYAOtKsht+4ZOTSbI2BKwWBHwfNtAB/z5qL
 2/+xHtvs+pvvQ6Z8RJhEcv7g0bCPNPZVsCfRPABuMxwFIninrTrKETBGaDflxPtLtG
 xho8L4rmkJYL0XX+EqROL5apprqISl/AcmJkBj7xdd/FAj4hcJBVVScgFcooNilpJw
 eg6X321mCZiQUNeANtO2RjRH4k2TUewPryyE2S2nnuZ3xfQhSGMcEC2mXtKCxuTFR9
 F1k02R8EIUUr5txXjMmgOWu266UtaEfn36LKmUFlPsnvG2hBQdDRlrneEOJ+LKVtTg
 SNtB38nA7bWmA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E705DCD4F3D;
 Wed, 20 May 2026 16:40:41 +0000 (UTC)
From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne_via_B4_Relay?=
 <devnull+jerome.debretagne.gmail.com@kernel.org>
Date: Wed, 20 May 2026 18:40:07 +0200
Subject: [PATCH 03/11] arm64: dts: qcom: sc8280xp-arcata: Enable the eDP
 display
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260520-surface-sp9-5g-for-next-v1-3-9df52552bf87@gmail.com>
References: <20260520-surface-sp9-5g-for-next-v1-0-9df52552bf87@gmail.com>
In-Reply-To: <20260520-surface-sp9-5g-for-next-v1-0-9df52552bf87@gmail.com>
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779295238; l=5543;
 i=jerome.debretagne@gmail.com; s=20260520; h=from:subject:message-id;
 bh=ldc0TLCvhrzO6UcurjPbFyDeI/OxIDyYi6mefy873oA=;
 b=P74/w6D9vJWdNC8SZSxpTKm3NCYK6eA8VtY7KbSZ1H1bYHK9Ot79FUFIq0bevBtlsETm8/Ghr
 eB6Rk8sWlM3AqLIbTAgQYK+8i78M9/ltYac3FTrlo8W4oRQb+Zt/qz6
X-Developer-Key: i=jerome.debretagne@gmail.com; a=ed25519;
 pk=3/JYhgYjGg5V9mlFxc0A0+pFiyjsuDB/TtDlNMId9fk=
X-Endpoint-Received: by B4 Relay for jerome.debretagne@gmail.com/20260520
 with auth_id=785
X-Original-From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?=
 <jerome.debretagne@gmail.com>
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
Reply-To: jerome.debretagne@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Jérôme de Bretagne <jerome.debretagne@gmail.com>

Add the vreg_edp_3p3, edp_reg_en and mdss0_dp3 nodes to enable the
Surface Pro 9 5G eDP-based LCD display (LG LP129WT232166).

The enable GPIO 36 was found by decompiling AeoB dumps [1]:

                Package ()
                {
                    "CLOCK",
                    Package ()
                    {
                        "gcc_edp3_phy_clkref_en",
                        0x0000000000000001,
                    },
                },
                Package ()
                {
                    "FOOTSWITCH",
                    Package ()
                    {
                        "mdss_0_disp_cc_mdss_core_gdsc",
                        0x0000000000000001,
                        0x0000000000000001,
                    },
                },
                Package ()
                {
                    "PSTATE_ADJUST",
                    Package ()
                    {
                        0x0000000000000002,
                        0x0000000000000000,
                    },
                },
                Package ()
                {
                    "PSTATE_ADJUST",
                    Package ()
                    {
                        0x0000000000000003,
                        0x0000000000000001,
                    },
                },
                Package ()
                {
                    "PMICVREGVOTE",
                    Package ()
                    {
                        "PPP_RESOURCE_ID_LDO3_B",
                        0x0000000000000001,
                        0x0000000000124F80,
                        0x0000000000000001,
                        0x0000000000000007,
                        0x0000000000000000,
                        "HLOS_DRV",
                        "REQUIRED",
                    },
                },
                Package ()
                {
                    "PMICVREGVOTE",
                    Package ()
                    {
                        "PPP_RESOURCE_ID_LDO6_B",
                        0x0000000000000001,
                        0x00000000000D6D80,
                        0x0000000000000001,
                        0x0000000000000007,
                        0x0000000000000000,
                        "HLOS_DRV",
                        "REQUIRED",
                    },
                },
                Package ()
                {
                    "TLMMGPIO",
                    Package ()
                    {
                        0x0000000000000024,  <== GPIO 36
                        0x0000000000000001,
                        0x0000000000000000,
                        0x0000000000000001,
                        0x0000000000000000,
                        0x0000000000000000,
                    },
                },

[1] https://github.com/alexVinarskis/qcom-aeob-dumps/blob/master/microsoft-surface-pro-9-5G-1996/qcdxkmext8280_ARC_part2.json#L156-L168

Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
---
 .../boot/dts/qcom/sc8280xp-microsoft-arcata.dts    | 64 ++++++++++++++++++++--
 1 file changed, 59 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
index 14287092fb07ea15e527fd318f7ea2155448b26c..7f1cc1899002529b7ac7340974c99f6ed493d410 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
@@ -137,6 +137,22 @@ pmic_glink_con1_sbu: endpoint {
 		};
 	};
 
+	vreg_edp_3p3: regulator-edp-3p3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_EDP_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 36 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&edp_reg_en>;
+		pinctrl-names = "default";
+
+		regulator-boot-on;
+	};
+
 	vreg_edp_bl: regulator-edp-bl {
 		compatible = "regulator-fixed";
 
@@ -361,7 +377,6 @@ vreg_l6b: ldo6 {
 			regulator-max-microvolt = <880000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-boot-on;
-			regulator-always-on;	// FIXME: VDD_A_EDP_0_0P9
 		};
 	};
 
@@ -465,10 +480,6 @@ &dispcc0 {
 	status = "okay";
 };
 
-&dispcc1 {
-	status = "okay";
-};
-
 &gpi_dma0 {
 	status = "okay";
 };
@@ -511,6 +522,42 @@ &mdss0_dp1_out {
 	remote-endpoint = <&usb_1_qmpphy_dp_in>;
 };
 
+&mdss0_dp3 {
+	compatible = "qcom,sc8280xp-edp";
+	/delete-property/ #sound-dai-cells;
+
+	data-lanes = <0 1 2 3>;
+
+	status = "okay";
+
+	aux-bus {
+		panel {
+			compatible = "edp-panel";
+
+			backlight = <&backlight>;
+			power-supply = <&vreg_edp_3p3>;
+
+			port {
+				edp_panel_in: endpoint {
+					remote-endpoint = <&mdss0_dp3_out>;
+				};
+			};
+		};
+	};
+};
+
+&mdss0_dp3_out {
+	remote-endpoint = <&edp_panel_in>;
+};
+
+&mdss0_dp3_phy {
+	compatible = "qcom,sc8280xp-edp-phy";
+	vdda-phy-supply = <&vreg_l6b>;
+	vdda-pll-supply = <&vreg_l3b>;
+
+	status = "okay";
+};
+
 &pcie2a {
 	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
@@ -932,6 +979,13 @@ hstp-sw-ctrl-pins {
 		};
 	};
 
+	edp_reg_en: edp-reg-en-state {
+		pins = "gpio36";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	nvme_reg_en: nvme-reg-en-state {
 		pins = "gpio135";
 		function = "gpio";

-- 
2.47.3


