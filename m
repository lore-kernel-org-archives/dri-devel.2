Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AB1606A331
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=NOdUCWXf;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=liaGC5tB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5490D10EA4F;
	Tue, 17 Nov 2026 08:08:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="NOdUCWXf";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="liaGC5tB";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB7B110F4B0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 22:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794869435; bh=HdzBusJ2m2oIJwvG8r/gIEs
 WxjBy4zz4R3lKt0q2ErQ=; b=NOdUCWXfzdCJHm+7KNssXMRDeL/Xk4GG8IXcnK7CDSNcnETx0B
 gpon7j+UT5saKCKqeNrAy0pSNH5hyYysUbAQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794869435; bh=HdzBusJ2m2oIJwvG8r/gIEs
 WxjBy4zz4R3lKt0q2ErQ=; b=liaGC5tBTg7Kpfieyi9cLjekgvF4EFXZarGiWSGo26nhb460Ky
 SDkAIl6aZJZxNw+TmkUVnoDST1hMMFX7NgGzSHQU5AEh1EFeSu4RdF2PgTnOg2jPAldU9Ej+Q+S
 3abfjTEF+XRT4HjxAdbrEtiXf4cCaR1m2UXzb6ECJ+blNUqxK/fwXShm5I5o3Ii47oNOsowVKTG
 QiLCUYZpRgg1FBkCqaNMSGzTMjUjFobdHuy5JW3ylLe9I7qUsb1temtIVEsIZ5wbXDCo7jh7jV4
 hdKM9leOQp5IuyO0qMd17DZa+fb67hrYVI5UfKrdvUZaJxf5EUujMLQGDQdkzf6aYIQ==;
From: erebion <erebion@erebion.eu>
Date: Mon, 16 Nov 2026 23:50:35 +0100
Subject: [PATCH v5 05/12] arm64: dts: qcom: sm6350-lena: Enable Bluetooth
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-pdx213-upstream-3-v5-5-7318a19806eb@erebion.eu>
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
In-Reply-To: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 phone-devel@vger.kernel.org, erebion <erebion@erebion.eu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794869432; l=3560;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=9i1AK5BOSgoKjgzyzIvOIdNUt//20/4Ya8X1h1Kh+Tc=;
 b=1G2aGckki85dghvVOGe/Y0Ra2AWsT9XQpp1oUQoKqnS1q93uzSxgcutgbSHDIwVdrg3lZ1Vm/
 hv63uXDxbpzD7riDzvlUZ3gHf+Yk+2grjSI+MxMRUGr1sYbcAjhKyct
X-Developer-Key: i=erebion@erebion.eu; a=ed25519;
 pk=rOCVlR8khmBtCFe4ZlDcbCbIcORxdaNzPDkoIiHM7xc=
X-Mailman-Approved-At: Tue, 17 Nov 2026 08:07:18 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Configure the required regulators for Bluetooth and enable it on the
Xperia 10 III.

Signed-off-by: erebion <erebion@erebion.eu>
---
 .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index e8808865bf6fa..12bf5420530d3 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -19,6 +19,10 @@ / {
 	qcom,msm-id = <434 0x10000>, <459 0x10000>;
 	qcom,board-id = <0x1000b 0>;
 
+	aliases {
+		serial1 = &uart1;
+	};
+
 	chosen {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -376,6 +380,32 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+/* UART1: HS UART for Bluetooth */
+&qup_uart1_rts {
+	/* We'll drive RTS, so no pull */
+	drive-strength = <2>;
+	/delete-property/ bias-pull-down;
+	bias-disable;
+};
+
+&qup_uart1_rx {
+	/*
+	 * Configure a pull-up on RX. This is needed to avoid
+	 * garbage data when the TX pin of the Bluetooth module is
+	 * in tri-state (module powered off or not driving the
+	 * signal yet).
+	 */
+	/delete-property/ bias-disable;
+	bias-pull-up;
+};
+
+&qup_uart1_tx {
+	/* We'll drive TX, so no pull */
+	drive-strength = <2>;
+	/delete-property/ bias-pull-up;
+	bias-disable;
+};
+
 &sdc2_off_state {
 	sd-cd-pins {
 		pins = "gpio94";
@@ -419,6 +449,72 @@ ts_int_default: ts-int-default-state {
 		drive-strength = <2>;
 		bias-disable;
 	};
+
+	qup_uart1_sleep_cts: qup-uart1-sleep-cts-state {
+		pins = "gpio61";
+		function = "gpio";
+		/*
+		 * Configure a bias-bus-hold on CTS to lower power
+		 * usage when Bluetooth is turned off. Bus hold will
+		 * maintain a low power state regardless of whether
+		 * the Bluetooth module drives the pin in either
+		 * direction or leaves the pin fully unpowered.
+		 */
+		bias-bus-hold;
+	};
+
+	qup_uart1_sleep_rts: qup-uart1-sleep-rts-state {
+		pins = "gpio62";
+		function = "gpio";
+		/*
+		 * Configure pull-down on RTS. As RTS is active low
+		 * signal, pull it low to indicate the BT SoC that it
+		 * can wakeup the system anytime from suspend state by
+		 * pulling RX low (by sending wakeup bytes).
+		 */
+		bias-pull-down;
+	};
+
+	qup_uart1_sleep_rx: qup-uart1-sleep-rx-state {
+		pins = "gpio64";
+		function = "gpio";
+		/*
+		 * Configure a pull-up on RX. This is needed to avoid
+		 * garbage data when the TX pin of the Bluetooth module
+		 * is floating which may cause spurious wakeups.
+		 */
+		bias-pull-up;
+	};
+
+	qup_uart1_sleep_tx: qup-uart1-sleep-tx-state {
+		pins = "gpio63";
+		function = "gpio";
+		/*
+		 * Configure pull-up on TX when it isn't actively driven
+		 * to prevent BT SoC from receiving garbage during sleep.
+		 */
+		bias-pull-up;
+	};
+};
+
+&uart1 {
+	/delete-property/ interrupts;
+	interrupts-extended = <&intc GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>,
+			     <&tlmm 64 IRQ_TYPE_EDGE_FALLING>;
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-1 = <&qup_uart1_sleep_cts>, <&qup_uart1_sleep_rts>, <&qup_uart1_sleep_tx>, <&qup_uart1_sleep_rx>;
+
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3991-bt";
+		vddio-supply = <&pm6350_l11>;
+		vddxo-supply = <&pm6350_l7>;
+		vddrf-supply = <&pm6150l_l2>;
+		vddch0-supply = <&pm6150l_l10>;
+		firmware-name = "crnv32u.bin";
+	};
 };
 
 &usb_1 {

-- 
2.53.0

