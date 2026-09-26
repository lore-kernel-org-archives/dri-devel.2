Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49762C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 631FE10E890;
	Mon, 28 Sep 2026 08:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="r7cBzFOA";
	dkim=pass (2048-bit key; secure) header.d=erebion.eu header.i=@erebion.eu header.b="jAQDE/3H";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24BF510E096
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 10:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1790418022; bh=Ntgs4rTq5WE2/T4imdk8hB1
 k32TtcjLvKOL5CjpFwmY=; b=r7cBzFOAqkLEXl0nRs37xOSibNRp1cYgJV58hI+Anvepw1Nv1e
 LrbfrP+WzXgYriDy5MSCvoXzw8kwjXYQ0GCg==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1790418022; bh=Ntgs4rTq5WE2/T4imdk8hB1
 k32TtcjLvKOL5CjpFwmY=; b=jAQDE/3Hi21W5WNPozApYy9llDkMpcqZ/kAawiaJB8XcH8LKi8
 ZdKsRmeP5erHpnvv01VWfdfZSg8mkbre4QlECIiF9i9pq9jdAS8LB5MoAFU4se6PLfgXKYLMN7u
 BoRzxhMhk84Mna4F6bcgj45VhxWLnRy8+RH+Dej4ROwYsjTaxRJDj3VDknLnlPabKvNH47OJK3Q
 qyUucVhuFqCZ6Izeo8FJidF4a7f9Ah66yRiZmCvZccdIHQGtfJLGNU/e2VbyXWdx1jHqBCBvcpD
 0Ihpd6hM1KLv/Im3VJBmQRz42vVrb7XvaT9CMNWjhVzdnp1ztjs8vLAtlrPTLavQn+A==;
From: erebion <erebion@erebion.eu>
Date: Sat, 26 Sep 2026 12:20:18 +0200
Subject: [PATCH 1/8] arm64: dts: qcom: sm6350-lena: Add flash LED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-pdx213-upstream-3-v1-1-1609c18b5c1d@erebion.eu>
References: <20260926-pdx213-upstream-3-v1-0-1609c18b5c1d@erebion.eu>
In-Reply-To: <20260926-pdx213-upstream-3-v1-0-1609c18b5c1d@erebion.eu>
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
 erebion <erebion@erebion.eu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790418021; l=1398;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=DJ1dxK1GELDY5ZlRiLvI8OSGqq+He7Dg4xxbJfSuF9E=;
 b=+ACwNkpZS8it7xpeNO5kjJSy1ya0FuK0NiCKN+ktI/hEFrdojWyNiWNCFaH/rnXJIvsypupKk
 GSqTwWEWFIeAPZtupRGwtUiCvHsdIemE7z9kvf0cb/TVtJY6Ti3QbHn
X-Developer-Key: i=erebion@erebion.eu; a=ed25519;
 pk=rOCVlR8khmBtCFe4ZlDcbCbIcORxdaNzPDkoIiHM7xc=
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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

Add a node for the camera flash LED found on the Xperia 10 III

Signed-off-by: erebion <erebion@erebion.eu>
---
 .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 6e2bbf4f060ac..c72ccb5544589 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -4,9 +4,11 @@
  */
 /dts-v1/;
 
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm6350.dtsi"
+#include "pm6150l.dtsi"
 #include "pm6350.dtsi"
 
 / {
@@ -302,6 +304,29 @@ touchscreen@48 {
 	};
 };
 
+&pm6150l_flash {
+	status = "okay";
+
+	led-0 {
+		function = LED_FUNCTION_FLASH;
+		color = <LED_COLOR_ID_WHITE>;
+		led-sources = <1>;
+		led-max-microamp = <180000>;
+		flash-max-microamp = <1000000>;
+		flash-max-timeout-us = <1280000>;
+	};
+};
+
+&pm6150l_gpios {
+	panel_reset_pin: panel-reset-state {
+		pins = "gpio9";
+		function = "func1";
+		power-source = <1>;
+		bias-disable;
+		output-low;
+	};
+};
+
 &pm6350_gpios {
 	vol_down_n: vol-down-n-state {
 		pins = "gpio2";

-- 
2.53.0

