Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4657C88E53
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB5910F1D4;
	Fri, 11 Sep 2026 08:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="vIOQPc9o";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B74D710E237;
 Fri, 11 Sep 2026 08:51:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6F2DD44820;
 Fri, 11 Sep 2026 08:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44BECC2BCF4;
 Fri, 11 Sep 2026 08:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789116675;
 bh=DY3nAZEw7IwIcK7ATvLcXz2X/NgGx+ZUSaAnsbH9oD0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=vIOQPc9oHsAb5NAMCqQSY2ZC9ZWES3F1I+WL1UMX6w0fWakBt6wCJ8/BpvamaPKBA
 GztFcpozC1ZOMwR/pHj4OXDiXjuaPoY/SPUe1BVCqlaY00PsilXrVmt4qqRjLG2to+
 F2MNSekiB/ZaIfTcsueZR+hqhaQq65rIM8N+ExzP0mV1zg7kibl4/pTDICNwOcy1rp
 ABb7U8WTkS+dcJoj68T5nK/LNcfOzCTSrE3U700Vp4WwzPo660EKT3JaMWOZ+iJoSE
 KjknH85+1JDXx+v532KClu9oP+OQpplH3a+lvwqypOUY6QaI1QRaTlQQNtPgx8RvK2
 3HNXYLpAtT9rQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9C3C88E53;
 Fri, 11 Sep 2026 08:51:15 +0000 (UTC)
From: =?utf-8?q?Y=C4=B0=C4=9E=C4=B0TCAN_KAVAKLI_via_B4_Relay?=
 <devnull+kavakliyigitcan.gmail.com@kernel.org>
Date: Fri, 11 Sep 2026 11:51:07 +0300
Subject: [PATCH RFC 10/10] arm64: dts: qcom: sm6125-xiaomi-ginkgo: enable
 display, backlight and touchscreen
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-ginkgo-submission-final-v1-10-0e68e63a18d4@gmail.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
In-Reply-To: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Henrik Rydberg <rydberg@bitmath.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 =?utf-8?q?Y=C4=B0=C4=9E=C4=B0TCAN_KAVAKLI?= <kavakliyigitcan@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789116671; l=3582;
 i=kavakliyigitcan@gmail.com; s=20260911; h=from:subject:message-id;
 bh=x7HUi8j9WM0O66VRg2zaqPmBSUKqKlYUrg3o+6fVUMA=;
 b=0p7Sw0WODkPHyr6uYaCxqJhHD15HpgWvncYsEcFoTIdse3nMrsA429rybhBMBFN9lnbCG75i0
 EoyAv2U5cNvCyIAm66vhUwtwyvhJf5el9hJ1LDQvAl6pw6l7r3yALhq
X-Developer-Key: i=kavakliyigitcan@gmail.com; a=ed25519;
 pk=W2GaxVotULs2vAjRMMLheaDtMMYs4037zO1LVVfFtPI=
X-Endpoint-Received: by B4 Relay for kavakliyigitcan@gmail.com/20260911
 with auth_id=1024
X-Original-From: =?utf-8?q?Y=C4=B0=C4=9E=C4=B0TCAN_KAVAKLI?=
 <kavakliyigitcan@gmail.com>
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
Reply-To: kavakliyigitcan@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>

Enable the display subsystem (MDSS/MDP/DSI0), Kinetic KTD3136 backlight,
and Novatek NT36672A SPI touchscreen on the Xiaomi Redmi Note 8 (ginkgo).

Hardware nodes added:
- Fixed LCDB regulators (lcdb_lab and lcdb_ibb at +/- 5.5V)
- MDSS and DSI0 with Tianma 1080x2340 FHD+ video panel
- I2C1 backlight node at 0x36 with PMI632 GPIO 6 hardware enable
- SPI2 touchscreen node at CS0 with GPIO 88 interrupt and panel follower
  reference
- Touchscreen active pinctrl definition on GPIO 88

Signed-off-by: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
---
 .../boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi | 100 +++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi
index 59042a5937535c4acda064fa0f865f4f5a52d01b..f4b9e2092a814e56cdc23218025cb4166dec110a 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi
@@ -26,11 +26,30 @@ / {
 	chassis-type = "handset";
 
 	qcom,msm-id = <QCOM_ID_SM6125 0x10000>;
+	qcom,board-id = <34 0>, <34 1>, <34 2>, <34 3>, <34 4>, <0 0>;
 
 	aliases {
 		serial0 = &uart4;
 	};
 
+	lcdb_lab: regulator-lcdb-lab {
+		compatible = "regulator-fixed";
+		regulator-name = "lcdb_lab";
+		regulator-min-microvolt = <5500000>;
+		regulator-max-microvolt = <5500000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	lcdb_ibb: regulator-lcdb-ibb {
+		compatible = "regulator-fixed";
+		regulator-name = "lcdb_ibb";
+		regulator-min-microvolt = <5500000>;
+		regulator-max-microvolt = <5500000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	chosen {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -356,6 +375,13 @@ irled@1 {
 
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <30 4>;
+
+	ts_int_active: ts-int-active-state {
+		pins = "gpio88";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
 };
 
 &uart4 {
@@ -369,3 +395,77 @@ &usb3 {
 &usb_dwc3_hs {
 	remote-endpoint = <&pmi632_hs_in>;
 };
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_mdp {
+	status = "okay";
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l7a>;
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l18a>;
+	status = "okay";
+
+	panel: panel@0 {
+		compatible = "tianma,fhd-video-ginkgo", "novatek,nt36672a";
+		reg = <0>;
+
+		reset-gpios = <&tlmm 90 GPIO_ACTIVE_LOW>;
+		vddio-supply = <&vreg_l9a>;
+		vddpos-supply = <&lcdb_lab>;
+		vddneg-supply = <&lcdb_ibb>;
+		backlight = <&backlight>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&panel_in>;
+	data-lanes = <0 1 2 3>;
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	backlight: backlight@36 {
+		compatible = "kinetic,ktd3136";
+		reg = <0x36>;
+		enable-gpios = <&pmi632_gpios 6 GPIO_ACTIVE_HIGH>;
+		default-brightness = <2047>;
+		max-brightness = <2047>;
+	};
+};
+
+&spi2 {
+	status = "okay";
+
+	touchscreen@0 {
+		compatible = "novatek,nt36672a-spi", "novatek,nt36672a-ts";
+		reg = <0>;
+		spi-max-frequency = <4000000>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <88 IRQ_TYPE_EDGE_RISING>;
+		pinctrl-0 = <&ts_int_active>;
+		pinctrl-names = "default";
+		panel = <&panel>;
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <2340>;
+	};
+};

-- 
2.47.3


