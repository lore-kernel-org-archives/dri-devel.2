Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D752606A332
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=Nzy/hUrf;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=BOTuAZcT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B86D11253E;
	Fri, 13 Nov 2026 13:43:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="Nzy/hUrf";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="BOTuAZcT";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C12D210E716
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794533096; bh=TVsGbGFloA0ewuyDVfaBKr+
 1x045CdcDbj7hxIb4bVo=; b=Nzy/hUrf6LNM42FXJ7fs9Wo3F+rut3R9GmzDX/Bl7xOIfF9b16
 tFfKyYntaFbzsfrH742vGEjaJA6+Fv7q8UAQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794533096; bh=TVsGbGFloA0ewuyDVfaBKr+
 1x045CdcDbj7hxIb4bVo=; b=BOTuAZcTtaJaSZL8f/h6UJZrUYqjfL5H7Wh5AnJbMakXG62brn
 XljM14i5uCftmLvBeXVLhzDR3bW6jM3RLG7Wv350OaNThZcghwDGVFhTHquDoTkYeaHIEvCIL6t
 2CA7StRLiLRx4IXrKMvsduY+wz0bHb+SvGpCd9t+iX9crTmeEX+VIhlUQ8KQiHBZ3F25b7xEOJG
 C13IN+n8LgHgIo0ElO6hsnV9i3QOlMJcchyE1nWaRd/6XjKqL13uNj4xXHIMA6EDbT/kty78tmg
 lTlgGkp8sLhsDcPDRuqmsg0X4upqHLF9O6UHrGPsTSdVCxWfPmqm4lIayDcdr0SjgwA==;
From: erebion <erebion@erebion.eu>
Date: Fri, 13 Nov 2026 02:24:50 +0100
Subject: [PATCH v4 06/12] arm64: dts: qcom: sm6350-lena: Enable wifi
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-pdx213-upstream-3-v4-6-4b01c50a821c@erebion.eu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794533093; l=969;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=8BOhwwcexPTIilXalqobSMw1TD9eB+fAJDqTb8Sq+L0=;
 b=wQ0FSrDjcEuCfCgtPmz8GZXvTcNtKxLfZpjqev1NclU6P7RdhRgWNxcHZW65ROazKmknF9TyB
 zXTsn5j4EnGBCNwU7ZOKvWHkC2LbOP842NhaNbYsMgG3cNcuhoDdIeF
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

Configure regulators and enable it for the Xperia 10 III

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: erebion <erebion@erebion.eu>
---
 arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index ff07810c3a6a6..becaf226af88c 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -541,3 +541,13 @@ &usb_1_qmpphy {
 
 	status = "okay";
 };
+
+&wifi {
+	vdd-0.8-cx-mx-supply = <&pm6350_l4>;
+	vdd-1.8-xo-supply = <&pm6350_l7>;
+	vdd-1.3-rfa-supply = <&pm6150l_l2>;
+	vdd-3.3-ch0-supply = <&pm6150l_l10>;
+	vdd-3.3-ch1-supply = <&pm6150l_l11>;
+
+	status = "okay";
+};

-- 
2.53.0

