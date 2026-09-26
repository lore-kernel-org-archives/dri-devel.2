Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF2DCA5FA4
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4CEE10E850;
	Mon, 28 Sep 2026 08:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="CyRfwpMo";
	dkim=pass (2048-bit key; secure) header.d=erebion.eu header.i=@erebion.eu header.b="IgXwblYC";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B82610E009
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 14:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1790431254; bh=B8OXuGZFYsl/0u0iIDWh1o9
 a4vzeNq0gVlCcVDMTqAE=; b=CyRfwpMocuX1RYx7mqPzEet2wmF5L/lebJirZIhWz7d/HOnYlA
 MkW1gXM2mIQHwjKG9RSupGtaROm0VcOuPVAA==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1790431254; bh=B8OXuGZFYsl/0u0iIDWh1o9
 a4vzeNq0gVlCcVDMTqAE=; b=IgXwblYCsDkbzNEiP0BUPbNPB2hKu7VfT05k5aNI1acvFwnVdG
 pH7WlX8LhnkRdEd6NB91wjs2GyrRONwGVERwoNQ88vHRQ39wquY54RWtfmVM5o/xk8tkRClUau0
 3HoqQm1XXSmrFTbIQJpOptoxYSlTuc60ZUZgPu7shooqCXj+e7Uuml69mnaBSmaDzBof0eNe1w8
 W5dKn6o3gmHo7diFn/YnMip09rWlWeJVEHKdeTTlXZyHdMf0QUHDaaDxNGXHLiiDQXzeZNe302B
 sWXsiZID58Uphyz1e5TXcEb2N4FGsMseIgnzscbcwAmOVuD2+DLZQIbhEaUtQP84HLA==;
From: erebion <erebion@erebion.eu>
Date: Sat, 26 Sep 2026 16:00:50 +0200
Subject: [PATCH v2 1/8] arm64: dts: qcom: sm6350-lena: Add flash LED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-pdx213-upstream-3-v2-1-b4612e3eb536@erebion.eu>
References: <20260926-pdx213-upstream-3-v2-0-b4612e3eb536@erebion.eu>
In-Reply-To: <20260926-pdx213-upstream-3-v2-0-b4612e3eb536@erebion.eu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790431254; l=1223;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=3+xYgttIy7nAGxUYfdGkemOjVdFz7kvLTdidBd8rAmI=;
 b=rii/+qz5v8lbPBImtbMa3k//xu7oDVVhDqA/jj+k2Z2kswVbNlUt29o6uzJJ5aqk7EBOKmcJa
 obzrCl+LDn5DVPd5YpqJlpHY+eCQ0Jybt2IKkmsT96Qk+YSx8Dz3Hnn
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
 .../boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 6e2bbf4f060ac..79aa2521aed40 100644
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
@@ -302,6 +304,19 @@ touchscreen@48 {
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
 &pm6350_gpios {
 	vol_down_n: vol-down-n-state {
 		pins = "gpio2";

-- 
2.53.0

