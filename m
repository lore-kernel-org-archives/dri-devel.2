Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1DD1094486
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 15:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF30110E234;
	Sat, 21 Mar 2026 15:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nqHDiny5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7755410E23F
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 15:23:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D958060132;
 Sat, 21 Mar 2026 15:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75B54C2BCC6;
 Sat, 21 Mar 2026 15:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774106591;
 bh=SsbCfS4QCvwhdAO5K8XNABoWORODfiw1Z9sqj0nbl5k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=nqHDiny5MBBwUOvK1gscDzwCUJKylWqh4nXfnL15FCStMSISOhd76nNJxAlmscWJj
 1I6A3ogMHIvTgEtg8VI74/Pv/f924S+6T6SUX6xgkDhRVQi9cuZRX7zrjKEJ8g/O80
 taGuZA4Dhkp+w7SdFdYC8xToZZyt3g1JOuLrTL8YWbtvgSqI2Py6ne7bnqxtWpsDDt
 y/hUhFgv0/dqWRxTkffooMJbgslWwWeFDuNovDblLYGf1nqMDY/enKz/PSlhaTlDFq
 p75ipzUqPUWwbThpsy0ZONj4YXqgJcXRafk4JmIuYZXZw/yYblG0uBrJbjHfuEltjo
 pbPWhgJFI2HLg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4EE1094488;
 Sat, 21 Mar 2026 15:23:11 +0000 (UTC)
From: Cristian Cozzolino via B4 Relay
 <devnull+cristian_ci.protonmail.com@kernel.org>
Date: Sat, 21 Mar 2026 17:23:24 +0100
Subject: [PATCH v3 5/6] arm64: dts: qcom: msm8953-flipkart-rimob: Enable
 touchscreen
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260321-rimob-new-features-v3-5-d4b8ee867de7@protonmail.com>
References: <20260321-rimob-new-features-v3-0-d4b8ee867de7@protonmail.com>
In-Reply-To: <20260321-rimob-new-features-v3-0-d4b8ee867de7@protonmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Cristian Cozzolino <cristian_ci@protonmail.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774110230; l=1582;
 i=cristian_ci@protonmail.com; s=20250620; h=from:subject:message-id;
 bh=3bKin1PZP9GVSsW6glNJDP7CuB4rn0CKi/qbCyBa+rA=;
 b=B5If5K0fLvQgoogkrILzqhKx8UKibbWWQJM4uBFDmy5w5f4Dl1frWx50cUatUU/MScjJQZMfh
 3tGpS/NLFzVDlUN6jK79oxJ22HAmUQorELLANOUSlWMa+ULjKwyBWX9
X-Developer-Key: i=cristian_ci@protonmail.com; a=ed25519;
 pk=xH5IvIPUNHV1Q8R0/pq2CfuVFR/wTiAyuyi6IwedjZY=
X-Endpoint-Received: by B4 Relay for cristian_ci@protonmail.com/20250620
 with auth_id=438
X-Original-From: Cristian Cozzolino <cristian_ci@protonmail.com>
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
Reply-To: cristian_ci@protonmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Cristian Cozzolino <cristian_ci@protonmail.com>

This device uses a Goodix GT5688 touch controller, connected to i2c_3.
Add it to the device tree.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
---
 .../arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts b/arch/arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts
index eab310ffa07b..ddbbbc1eb5b2 100644
--- a/arch/arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts
+++ b/arch/arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts
@@ -94,6 +94,31 @@ &hsusb_phy {
 	status = "okay";
 };
 
+&i2c_3 {
+	status = "okay";
+
+	touchscreen@5d {
+		compatible = "goodix,gt5688";
+		reg = <0x5d>;
+
+		interrupts-extended = <&tlmm 65 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&tsp_int_rst_default>;
+		pinctrl-names = "default";
+
+		irq-gpios = <&tlmm 65 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
+
+		VDDIO-supply = <&pm8953_l6>;
+		AVDD28-supply = <&pm8953_l10>;
+
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <1920>;
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
+};
+
 &ibb {
 	qcom,discharge-resistor-kohms = <32>;
 };
@@ -318,6 +343,13 @@ panel_default: panel-default-state {
 		bias-disable;
 		output-high;
 	};
+
+	tsp_int_rst_default: tsp-int-rst-default-state {
+		pins = "gpio64", "gpio65";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
 };
 
 &usb3 {

-- 
2.53.0


