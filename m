Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D370CA5FA4
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5E6D10E8B0;
	Mon, 28 Sep 2026 08:43:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="+/jouv0m";
	dkim=pass (2048-bit key; secure) header.d=erebion.eu header.i=@erebion.eu header.b="GdCGXe8h";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8663910E009
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 14:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1790431255; bh=4ss4Vu3NIbwTtaDQz961Ih0
 ITnPZZKKN15Y755Pj7Go=; b=+/jouv0mEsRqzpMTSgdOsu+iRD8W6pjfWh3C1lATtt3uB/5Qgm
 RnA14GtDhhrhT5THW1dXnFH3pP15STRfQ7CA==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1790431255; bh=4ss4Vu3NIbwTtaDQz961Ih0
 ITnPZZKKN15Y755Pj7Go=; b=GdCGXe8h6KV2xjtQ+ABrh6NWsjjYd8FOBK94JVyqekUkIUHfrF
 YZOII1RMx1xGyP05XeLTMU4tA07w+UZAx6ucItEVsNb6c8ybyHdTB4EXgnYiSWtBxRB3fn4zx05
 j6WmDz+/Vo6P30q0XJhUKemZp1RdYRyZjbcf4QweH1+iWRE8QfDpF2uHBwVazx/wGgjsxOUEuid
 koUqsryVjSsrkQKyb0bE0JN/eR8iv2QafRgX/f85M/RIvHz8XTDg18i0wRLkUVKFrx22c1ZH2qU
 uV0AxswDeyhVUMQ/pukuBkwrUOR6AbqIIvibiuvOFYUJ105bxh+owx0FpfmRmRIPhzg==;
From: erebion <erebion@erebion.eu>
Date: Sat, 26 Sep 2026 16:00:52 +0200
Subject: [PATCH v2 3/8] arm64: dts: qcom: sm6350-lena: Enable ADSP, CDSP & MPSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-pdx213-upstream-3-v2-3-b4612e3eb536@erebion.eu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790431254; l=1176;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=LJJELl/M9f8YmHlaJTO9RvN08jHQADEyvfNK7FNO6DY=;
 b=FxYFXS5X7RVxOxNZjemWQZu190fpTBmPnMAZTM36BLd0nBbLslz6aRazbJByudnWAe2D0VtY7
 NTPzrYxSX38Ae8FArEFkEcLdPirhTimJl229smHWxcLmyo4K6G0nIs5
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
 .../boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 0ef3e9e239786..c58047ce3291d 100644
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
@@ -321,6 +333,12 @@ touchscreen@48 {
 	};
 };
 
+&mpss {
+	firmware-name = "qcom/sm6350/sony/pdx213/modem.mbn";
+
+	status = "okay";
+};
+
 &pm6150l_flash {
 	status = "okay";
 

-- 
2.53.0

