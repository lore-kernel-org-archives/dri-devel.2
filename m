Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1772E606A336
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=0CHx4QDf;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=qEVlxNvA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4B7E112558;
	Fri, 13 Nov 2026 13:43:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="0CHx4QDf";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="qEVlxNvA";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 833C410E717
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794533095; bh=tudgFORN5TyG6PTCZqP+6im
 VHwqL/7Btvlf2shsmRlo=; b=0CHx4QDfnFRmuZJmBXW9Y6KXtFuh9CGPo/2KoN5GrdMwj0RfwX
 oeD1OWHHUHegHWXITLv3Kh6GA2UmXivP45Dg==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794533095; bh=tudgFORN5TyG6PTCZqP+6im
 VHwqL/7Btvlf2shsmRlo=; b=qEVlxNvAjt0qwQFhhiq2Cuyxhxjwr9oe79KBSVGdhAViXEroq6
 wZfSHBLl7l1zxmeP9iv8KdPRvpoD6eMidDG3MNHHAcf4gVZFWj2sB0HBRsrwsjwC0nrxhHUVdPW
 Ntu6fNQ0wIosPP3Q014nKMMQBCxmJVHHm9ZtwSCaSB/BvpAuotVw+iNhKwQPaoFVIRUz6SqWJcL
 NG+bGupPDRSN2my+tnFdw3zCroPsmwesyAM1K+RY91jxg65D6Hzorv+xarjTYQhBqcCQNdx+AjY
 Sqp1vbb1z2iA4ShWRFTiMMSqnYCZLVysPzi8uaYFayASzv+EjZWNQQMhzyp258YRdiw==;
From: erebion <erebion@erebion.eu>
Date: Fri, 13 Nov 2026 02:24:47 +0100
Subject: [PATCH v4 03/12] arm64: dts: qcom: sm6350-lena: Add qcom,rmtfs-mem
 node
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-pdx213-upstream-3-v4-3-4b01c50a821c@erebion.eu>
References: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
In-Reply-To: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
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
 erebion <erebion@erebion.eu>, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794533093; l=1232;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=6EhZPvz7qL2tkP58jiJGNmInEJYuo+/5G6TBp1uqCio=;
 b=4iafPFGARMEhy8AG/fFPhlHdIRT8VjAcR9J/vnSuZjFuLuSr7O6AKhaanHLGjAOiMfCnDq9hr
 oFMDB+SL8LJA0ZWJFumgnbg97HAv9kLi/vbuNHa/ynQmb8y4L0Peuy1
X-Developer-Key: i=erebion@erebion.eu; a=ed25519;
 pk=rOCVlR8khmBtCFe4ZlDcbCbIcORxdaNzPDkoIiHM7xc=
X-Mailman-Approved-At: Fri, 13 Nov 2026 13:43:28 +0000
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

Adds the qcom,rmtfs-mem node required for the modem

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: erebion <erebion@erebion.eu>
---
 arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index ca44219e1a67d..a393b7533ccbf 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -4,6 +4,7 @@
  */
 /dts-v1/;
 
+#include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
@@ -54,6 +55,17 @@ touch_en_vreg: regulator-touch-en {
 
 		vin-supply = <&pm6350_l6>;
 	};
+
+	reserved-memory {
+		memory@fe901000 {
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

