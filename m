Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2FC606A329
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=R/Er9F7g;
	dkim=pass (2048-bit key, unprotected) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=OeqsczqF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7384A10EBE0;
	Mon,  2 Nov 2026 08:04:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="R/Er9F7g";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="OeqsczqF";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A17A10E3B6
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1793575934; bh=2GtmFZ7xWwQq6dRQZhCqbwo
 +SpVMLcGB28JetKkGRSc=; b=R/Er9F7ga2WmJE38cc39HlXBT9SoFF43jahOiS0hXtXdTo9qVP
 clx0SvqS08Oc5LwbjPJgW65Y6IpZmhAu5cAw==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1793575934; bh=2GtmFZ7xWwQq6dRQZhCqbwo
 +SpVMLcGB28JetKkGRSc=; b=OeqsczqFZAisTCrTBexaNGNcc+leXrlRSmw7YnowX0yiQHdVju
 zAT+Kb/3huQwGhuWrYuSJWNZNgdKx9ZvsTblQfN1N0sbVqu1D032DiO/e09xoI5n+i2OjbLaYwS
 UR35FPkdOfvUIltRZJe/5Cifg/yqrk+AFBQTNfaFoTJfKm3GC4+4yftaoo2hh9zOpwV++RnB7mb
 FlX6STMegqqrRUMSXvs6ZYYZQXk+5mz/CooTTElGT/q4vCm+iwgtJdTdv20Wd9Cb2Gebx/rCTv8
 eWsVRt/AYoUaSgaQF7Ijniq7Z/QJ4jUTtaP4djZK7n923WGz++1CpxFrrQnQZaGrpaA==;
From: erebion <erebion@erebion.eu>
Date: Mon, 02 Nov 2026 00:32:12 +0100
Subject: [PATCH v3 08/12] arm64: dts: qcom: sm6350-lena: Enable PMK8350
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-pdx213-upstream-3-v3-8-cdc3be96d257@erebion.eu>
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
In-Reply-To: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
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
 erebion <erebion@erebion.eu>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793575929; l=1771;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=q8CHITpuG6dimI2YJFcYYf/S+Li18m5ZX944pKg4gus=;
 b=DRIodFQq77fmzNnyzVgRanHwwDSThUoy0N8XBwzXK2NF21K3kqR+yAFP60RoYf11J1t5kb9JX
 gl5mA7+UO+xBebHE1cDweQZySOyK/LhVcFp39bOEDhvGbe6hVP57+rz
X-Developer-Key: i=erebion@erebion.eu; a=ed25519;
 pk=rOCVlR8khmBtCFe4ZlDcbCbIcORxdaNzPDkoIiHM7xc=
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
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

Configure and enable nodes for PMK8350 on the Xperia 10 III.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: erebion <erebion@erebion.eu>
---
 .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 61e191133cb4f..246a290e44f77 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -8,7 +8,11 @@
 #define PM7250B_SID 2
 #define PM7250B_SID1 3
 
+/* PMK8350 (in reality a PMK8003) is configured to use SID6 instead of 0 */
+#define PMK8350_SID 6
+
 #include <dt-bindings/firmware/qcom,scm.h>
+#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
@@ -16,6 +20,7 @@
 #include "pm6150l.dtsi"
 #include "pm6350.dtsi"
 #include "pm7250b.dtsi"
+#include "pmk8350.dtsi"
 
 / {
 	model = "Sony Xperia 10 III";
@@ -431,6 +436,31 @@ &pm7250b_vbus {
 	status = "okay";
 };
 
+&pmk8350_adc_tm {
+	status = "okay";
+
+	xo-therm@0 {
+		reg = <0>;
+		io-channels = <&pmk8350_vadc PMK8350_ADC7_AMUX_THM1_100K_PU>;
+		qcom,hw-settle-time-us = <200>;
+		qcom,ratiometric;
+	};
+};
+
+&pmk8350_rtc {
+	status = "okay";
+};
+
+&pmk8350_vadc {
+	channel@644 {
+		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
+		label = "xo_therm";
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };

-- 
2.53.0

