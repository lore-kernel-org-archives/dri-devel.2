Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D403CC9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0854D10E8E0;
	Mon, 28 Sep 2026 08:45:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="S3JyyhrP";
	dkim=pass (2048-bit key; secure) header.d=erebion.eu header.i=@erebion.eu header.b="MysR+efI";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E827410E063
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 10:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1790418022; bh=bIK+qvG75GMAuzzdcR5w43x
 CfaEsVmoowVxiOAmB3vY=; b=S3JyyhrPDSbJJsPwB6TQnku7rNE2De/oSi8QxqVyYTeNN6eG5B
 nE15XuttJItXpP/bMk4x3IC8FlnE7yVV7wDA==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1790418022; bh=bIK+qvG75GMAuzzdcR5w43x
 CfaEsVmoowVxiOAmB3vY=; b=MysR+efI2MsBTCeD3I696hbJSFpAhMzBd2t5OIKvdGfYNzxxww
 2oivDgwK2tj013sT5Ua8342tBzbe6fo3nfA4bgF8IGYKlmj/8DlDQDsQEgvq9su2SVIFVj+we6S
 O55ZKocOvZ+/C7I15o4Jmxvow0l2IUmf1iqvhKeIhw64YBiUFy4neg7d1eKbG6EdpzFz5nslMHu
 1hocbWF+bGta2zGe7iyX3KxUpP3g9P3We5fzkWKnMFQ4NUq+siu1k+ezfk4ELAWdc04ifA90RSs
 kzcSGBJIhZBODSifh5Xr0tw+MWhQelJprsUY+Ck1b6cNDAX5aURxHdU7DoSX5oncjYQ==;
From: erebion <erebion@erebion.eu>
Date: Sat, 26 Sep 2026 12:20:20 +0200
Subject: [PATCH 3/8] arm64: dts: qcom: sm6350-lena: Enable ADSP, CDSP &
 MPSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-pdx213-upstream-3-v1-3-1609c18b5c1d@erebion.eu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790418021; l=1213;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=F9YqDdGfTxGOSumv7kEnhrjH11pKfFwV10/6oP7m72s=;
 b=DQhpFOfLaahddcDp0JesxKxC0hU/G4hBS8tdBNbauD942WZwxCuzJoiixk84KN+6DS9aNP7cr
 RhVX9HLckv+B7ZnM/MAVlcfgGeehv3+ZVBawgMhxUsHsvl/BX10S+vz
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

Enable the ADSP, CDSP and MPSS (Modem) nodes for the Xperia 10 III.

Signed-off-by: erebion <erebion@erebion.eu>
---
 .../boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 56a863eb8e167..79854151a84ac 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -73,6 +73,12 @@ rmtfs@fe901000 {
 	};
 };
 
+&adsp {
+	firmware-name = "qcom/sm6350/sony/pdx213/adsp.mbn";
+
+	status = "okay";
+};
+
 &apps_rsc {
 	regulators-0 {
 		compatible = "qcom,pm6350-rpmh-regulators";
@@ -296,6 +302,12 @@ pm6150l_bob: bob {
 	};
 };
 
+&cdsp {
+	firmware-name = "qcom/sm6350/sony/pdx213/cdsp.mbn";
+
+	status = "okay";
+};
+
 &gpi_dma0 {
 	status = "okay";
 };
@@ -321,6 +333,13 @@ touchscreen@48 {
 	};
 };
 
+&mpss {
+	firmware-name = "qcom/sm6350/sony/pdx213/modem.mbn";
+	reg = <0x0 0x04080000 0x0 0x100>;
+
+	status = "okay";
+};
+
 &pm6150l_flash {
 	status = "okay";
 

-- 
2.53.0

