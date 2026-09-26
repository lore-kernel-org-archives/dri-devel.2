Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F12CA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F72110E8AB;
	Mon, 28 Sep 2026 08:43:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="rb3Qn0Ah";
	dkim=pass (2048-bit key; secure) header.d=erebion.eu header.i=@erebion.eu header.b="HpiUrq3Z";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 435DB10E009
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 14:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1790431257; bh=b3sZd1ykxk9GXbHiEiBdMWw
 9RTheY88Isn5UVJrCHKs=; b=rb3Qn0AhRtwAED2T0FwoAfx2Lci40ICI4nRvhF7qc3n5fYEx9N
 33vIPhJ7OIpYJ+qt0ymYMdl5prWnpvIfC0Bg==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1790431257; bh=b3sZd1ykxk9GXbHiEiBdMWw
 9RTheY88Isn5UVJrCHKs=; b=HpiUrq3Zzrjuw0j7+jQaSo4U0atmOY7rv1AtAQBTvnTaGz1Y15
 o4z+azxZSYJDuNW+sLTTciDsKW039NwkWtdkyZk/s/M4SjuEtccqxFSWJEsSLtzhja7vCRv5uDa
 VI34haC6EskvbxD+6guNJO9pz6wOGhMairU4L6Ex5YzDPfyHqeyFxuZd311s/GqfSB3cnWaazaD
 G0Eev6ygYkCCaMWTsWFgJ4IIBPRORirRJq6b9dTPIpwE/d8kMMAH9BxnMJPsCDAH6fJ7I9pcPJb
 xJ/LyNQtCBlDMtoIjgjeG0xLG/RqJm9fqhnSvuuY36Jcdg/MX7wejxPgpB3xNQpgQRQ==;
From: erebion <erebion@erebion.eu>
Date: Sat, 26 Sep 2026 16:00:57 +0200
Subject: [PATCH v2 8/8] arm64: dts: qcom: sm6350-lena: Enable PMK8350
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-pdx213-upstream-3-v2-8-b4612e3eb536@erebion.eu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790431254; l=1710;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=vk2GPq7qsEA/L4uDnPpI1cOC2gwiuDW0uR2knzJ9WXg=;
 b=p5vx5luSVUdetoA1RwAY5SSZ71F94UGiyTAtTyOBwzlzA4w/ZC2gti5s/Vr4tg1e3Agc+/6Qq
 NBrgICP9mnNDvNWgZbvyTsyVG+BOyz3QIvb61TSy1HfdQmpd4lZW2QB
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

Configure and enable nodes for PMK8350 on the Xperia 10 III.

Signed-off-by: erebion <erebion@erebion.eu>
---
 .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 08ad5613cb6de..0f0e81683f2e5 100644
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
@@ -425,6 +430,31 @@ &pm7250b_vbus {
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
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "xo_therm";
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };

-- 
2.53.0

