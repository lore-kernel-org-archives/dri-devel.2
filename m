Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FBE606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=FgAvYrKm;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=n6ktw75V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B265112515;
	Fri, 13 Nov 2026 13:43:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="FgAvYrKm";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="n6ktw75V";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B801B10E71C
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794533099; bh=2Vkfw8XKbs4O/VkWTn7XpjM
 DTX66E2JNivGs7e0rmts=; b=FgAvYrKm0oZIdGHbhWA1aw3xY3vduXO1JyN4meEdGNqskxYDvK
 4fqSI6oHMBl7yNaVvPQaIJzQ6YvGCMO6ulAA==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794533099; bh=2Vkfw8XKbs4O/VkWTn7XpjM
 DTX66E2JNivGs7e0rmts=; b=n6ktw75V8R3HlS2swweusD5AivDQvuP8OcAKOjrcKrLSWbGcfg
 mQFYewQjH52ashJ4asDAyHun1yHkwxr3awKXS+9GWgdRsvqXxgj5xcQYZzFYIqTbVbMoucqWoqu
 jq+X2NTT2e4fKq7C/GHl2S1AquKbx3Q+3fvgvecpe8hZIHIyk5vTpQagL6K8q7W+qiSQn1Fyihh
 w+4JTayRGaZRoUiPPtdBBNnycFBzmPdb5+PtbCbdlUxIfnE/om5g0IY28eIKyE7ZQZvlnPvaMMF
 mQoJ2rDDRDp+QJxLiuxT4QE6d38QVFmY7N3gzJTwt/+RZOG/CPJdrWTtfNg/dYcwVsw==;
From: erebion <erebion@erebion.eu>
Date: Fri, 13 Nov 2026 02:24:56 +0100
Subject: [PATCH v4 12/12] arm64: dts: qcom: sm6350-lena: enable remaining
 i2c busses
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-pdx213-upstream-3-v4-12-4b01c50a821c@erebion.eu>
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
 erebion <erebion@erebion.eu>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794533093; l=1290;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=RynL+EGz+2JwbN0w3K8viBDEql+ZK9B5wQU+WbsKsc8=;
 b=vWKVCN5eZINn8g3nEW9BQ7xReRmsCppyI2YOleuRx0MmVyha37mAbI3J7CIqutEF5JEuOzdEF
 QP3RuKyznMLBDcWgBrHftz4Dza6lXtnVEpDF+bV/eVxgrFP9KD54ZCL
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

Enable all i2c busses where something is connected on this phone. Add
comments as placeholders for which components are still missing.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: erebion <erebion@erebion.eu>
---
 .../boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index d7a5df04a296c..ee65110f2c847 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -438,6 +438,13 @@ &gpi_dma1 {
 	status = "okay";
 };
 
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
@@ -455,6 +462,17 @@ touchscreen@48 {
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
 	firmware-name = "qcom/sm6350/Sony/pdx213/ipa_fws.mbn";
 

-- 
2.53.0

