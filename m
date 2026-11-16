Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5281A606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=OeUibqBp;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=aDtIygVc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 780D210EFCC;
	Tue, 17 Nov 2026 08:09:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="OeUibqBp";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="aDtIygVc";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 790C010F4A1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 22:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794869433; bh=+4P4Dm+xK1c98QYgMrw5Fig
 S7aFhLx8xQAD0TH21CzY=; b=OeUibqBp1FGobU4rL1KnFUKcYmJx4d3LVzU/OvGb3/jYS/CEKv
 HakHj1M6oIc/Px39qY1XY8KfnZoJuGqs59Dw==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794869433; bh=+4P4Dm+xK1c98QYgMrw5Fig
 S7aFhLx8xQAD0TH21CzY=; b=aDtIygVcQIAOvd+YK9LifI6L+qtCGdIJS6A8CutNHhNqWRoVLS
 IVRKB3gQt0tsbud2SC9Dhc26aV4IpJe85uGdqa1Kfqh7XfOSg8rZ4RpFaT/EMDg9DRMVp8zL74g
 T7xuW1n3q1elia/5Dg79MT7hfuqg+XL77/Il4crMVIFfyI+djRN2NVDLYwBDzzSagtEc+Pd+lbb
 IoKOGXIOkLqWgAYMW3xgf7KHLmMArQPA3lOFnKdKULJzj7MJVUkueXe03gy1AIwZJzL9prBN9QS
 SZr9l/rTtK9N+IbfpoGBi6OL1yiaiW2qRmjUhDnbgHEsMWZsG1ibXLdZg5NEb8azG4A==;
From: erebion <erebion@erebion.eu>
Date: Mon, 16 Nov 2026 23:50:31 +0100
Subject: [PATCH v5 01/12] arm64: dts: qcom: sm6350-lena: Add flash LED
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-pdx213-upstream-3-v5-1-7318a19806eb@erebion.eu>
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
 phone-devel@vger.kernel.org, erebion <erebion@erebion.eu>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794869432; l=1275;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=2S3plW7dluTLpAtgNGakeiDdnyfiuLDdowoj7EPiQuQ=;
 b=J3ZxGYQkQjrLTyvO2X2AdOiZ26ckC+vzNayNwdiHXSj9p5ro8OXuCqEQsSWxxcPDzDdfzNo0T
 Ojdej78y5jbDyKCP1Cu9d2la265ke0JUR8UspGS7WrO/hSVG4VSmwzs
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

Add a node for the camera flash LED found on the Xperia 10 III

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: erebion <erebion@erebion.eu>
---
 .../boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 6e2bbf4f060ac..4d78c500d00d3 100644
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
+		led-max-microamp = <150000>;
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

