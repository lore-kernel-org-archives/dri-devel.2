Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E17A606A33B
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=G1zr4VMZ;
	dkim=pass (2048-bit key, unprotected) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=ILCOhLUU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F052F10EBF2;
	Mon,  2 Nov 2026 08:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="G1zr4VMZ";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="ILCOhLUU";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32C6B10E4A0
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1793575936; bh=iz/yeK2fOPP8+jQttB1dzqi
 W2pcugn1b23xJp6HtfRM=; b=G1zr4VMZOQ/A29VXEPHd4Ut9KCzIIojtzKypEYhaeHld02Sw+L
 lvZ4YN/XRqVpmcHn+k68ggdAv5U4aRMdRoBg==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1793575936; bh=iz/yeK2fOPP8+jQttB1dzqi
 W2pcugn1b23xJp6HtfRM=; b=ILCOhLUUgOPKpdmblSjTYWDCgA1/PeaZBg3XIcWm8DuIfT9ukL
 PWEbPBnUn2FoIVJ4w+kaJsvnEX1qr5wLg8mtJJA/dpp7kiNBs0DxoVjmVLIouLUcfAM60q0PNZB
 X4TUN8CsH4oBlZwDp+YZgB9+MVHryGphzUTEz9T05WEjb5xaaBLk/Zwt5m9fCNwAPxfSf6jJwTQ
 +OR7M1XuGpuXkbReHMk6fUQBfykLWeQC2KRWgIf8OC3tKELSzxJ4xPApZvmsd/tF6SbuVs8Rd/8
 AL1dK6Xn6aKN8fTHyeNd/g1L1aufez41DfRiFs4nzjkim4qYDJRJyYLbwva7fORV/nw==;
From: erebion <erebion@erebion.eu>
Date: Mon, 02 Nov 2026 00:32:16 +0100
Subject: [PATCH v3 12/12] arm64: dts: qcom: sm6350-lena: enable remaining
 i2c busses
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-pdx213-upstream-3-v3-12-cdc3be96d257@erebion.eu>
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
 erebion <erebion@erebion.eu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793575929; l=1388;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=ymLKUXMTdBOYqzoQQuAQGR3AHNoKiUIhl/PVXRBCxns=;
 b=+/iLs3UKxuAi3slpEDtBfrzmi3YqszAfU7d+UkIHAV6zraCpBC/6iD8zyhe6qSLx29UX3XCuu
 DRdUQEHpZNTDgDiiKa5RtDKll06+XBi7zucpWClDD3vCHIifkDImkfd
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

Enable all i2c busses where something is connected on this phone. Add
comments as placeholders for which components are still missing.

Signed-off-by: erebion <erebion@erebion.eu>
---
 .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 487ef75f2f1de..d2b3aa6e61ab6 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -470,6 +470,21 @@ &gpi_dma1 {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/sm6350/sony/pdx213/a615_zap.mbn";
+};
+
+&i2c0 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* PN553 NFC @ 28 */
+};
+
 &i2c8 {
 	clock-frequency = <400000>;
 	status = "okay";
@@ -487,6 +502,17 @@ touchscreen@48 {
 	};
 };
 
+&i2c10 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* PM8008 PMIC @ 8 and 9 */
+	/* SMB1395 PMIC @ 34 and 35 */
+	/* AW882xx amplifier @ 34 */
+	/* Foursemi FS16xx amplifier @ 35 */
+	/* FSA4480 Analog Audio Switch @ 42 */
+};
+
 &ipa {
 	firmware-name = "qcom/sm6350/sony/pdx213/ipa_fws.mbn";
 	memory-region = <&pil_ipa_fw_mem>;

-- 
2.53.0

