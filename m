Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B919FC9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFFB310E856;
	Mon, 28 Sep 2026 08:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="D0vsH8hq";
	dkim=pass (2048-bit key; secure) header.d=erebion.eu header.i=@erebion.eu header.b="kZ1rCOTN";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E21F10E009
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 14:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1790431255; bh=FpsgjhkiEWhZHw10mbH5ePH
 QdMnxCIKabE/Zrf5angU=; b=D0vsH8hqFizwiuM3AtF3qE6T2YWdukFuX47KRNX9uS4J/Wlj4g
 P7ciAmNgUBM7RmF6ibH8kCgjRQ7UnJlR2sCg==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1790431255; bh=FpsgjhkiEWhZHw10mbH5ePH
 QdMnxCIKabE/Zrf5angU=; b=kZ1rCOTNCOWWq3TnOmrnV8oP26y1C9jxp68Y0oVcSHuJ6AdUFX
 zHun5WF43QhoyoQEpLw5X71nRaUgR5NWxagWCeqhSrI0qIEPyTNKii1vJtUkWPsk3Mn28KzUf+k
 yjy8Y/LxZi9lIyQqlf/mXjtSial6UWq3At/tvsV/W0u7RJRhllE33W0f6a5MdtbB+UuRBZOqaaJ
 eFMG3MXKSqh7pt9fWxI33wIw5MEexS3HCFLIQLs9aqEAD075bWcCJEVo3AA0MU+aEFfkDhZa7rq
 dKTP2oJ2L26ZfLomCg0SDPkKwI438hTEbXIRxzQX8EDMVvl0OKUS2k27/Pk8YNx1N0g==;
From: erebion <erebion@erebion.eu>
Date: Sat, 26 Sep 2026 16:00:51 +0200
Subject: [PATCH v2 2/8] arm64: dts: qcom: sm6350-lena: Add qcom,rmtfs-mem node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-pdx213-upstream-3-v2-2-b4612e3eb536@erebion.eu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790431254; l=1334;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=SAh/u9rqLjnMP9ySwBKTGM10EJ+3cf/9qk6pK5KDfE8=;
 b=HhwUyvpaLxbAOvvKgi65/+HHIgzvDvGzqCuXYdSaVFAO4dZ0jsKwdVNyBRxSI9YpQBdUqIWex
 uo4TfMAupELCb6AMB4DR6dlNPPYq/bymKNeefMCanf8vDdKWziYHjU3
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

Adds the qcom,rmtfs-mem node required for the modem

Signed-off-by: erebion <erebion@erebion.eu>
---
 .../boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 79aa2521aed40..0ef3e9e239786 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -4,6 +4,7 @@
  */
 /dts-v1/;
 
+#include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
@@ -54,6 +55,22 @@ touch_en_vreg: touch-en-regulator {
 
 		vin-supply = <&pm6350_l6>;
 	};
+
+	reserved-memory {
+		/*
+		 * The rmtfs memory region in downstream is 'dynamically allocated'
+		 * but given the same address every time. Hard code it as this address is
+		 * where the modem firmware expects it to be.
+		 */
+		rmtfs@fe901000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0xfe901000 0x0 0x280000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
+		};
+	};
 };
 
 &apps_rsc {

-- 
2.53.0

