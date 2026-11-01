Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5E5606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=XTyDD+Tj;
	dkim=pass (2048-bit key, unprotected) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=pFUwh24r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5214710EBE4;
	Mon,  2 Nov 2026 08:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="XTyDD+Tj";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="pFUwh24r";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08F1010E032
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1793575933; bh=GPXltLOZnrnsWMqleRNI+/G
 oCMyVYPKdu31vR8p/h6E=; b=XTyDD+TjzEx+P+NEjRBRVIEOGkCXTbcr6/ftG/Z2hxWhtSW4rO
 6GQy1/e2EXEvN2pwss0xweKu7yNJ9iCXkJCQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1793575933; bh=GPXltLOZnrnsWMqleRNI+/G
 oCMyVYPKdu31vR8p/h6E=; b=pFUwh24rdyjzLIDqbY9tpm918F9eDpnCgAbhOxjjDpvQ5hS2uH
 mUhLF3QLTTAS8SbAyuzqEcmV7YsL3NC2NkpvhCJolKHT/w8nLftl9Xoa432UEQT3S0lbd3ax3wJ
 CUrGBviL39CIFOP+XGp4PTq2EQ5bVUhhL4QJyl14fWGUJ6QASjCDEwJPwWmqy2JxVH4W8e5EyyM
 xuNYKijwN4Vme566/TkhC75NG0oZkgAESOD3Hp9vBvXqWM0DV/FTi4xXPaVMzarktySZhYO3Rz9
 oC36S3n+KfhBD/hTiBmSigqA1rLsKdf3spi1iYhwduh0PMhkcpLeXZfj4/KzgDTH6qw==;
From: erebion <erebion@erebion.eu>
Date: Mon, 02 Nov 2026 00:32:10 +0100
Subject: [PATCH v3 06/12] arm64: dts: qcom: sm6350-lena: Enable wifi
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-pdx213-upstream-3-v3-6-cdc3be96d257@erebion.eu>
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
 erebion <erebion@erebion.eu>, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793575929; l=969;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=XtTq4JnLTEWRP2w7u35ltbCzleX5q+xZyXQ+K8WGutQ=;
 b=WiqgwtBTf0VUpP6BilvAkkcO4Nwhc2GPRL5kbzz3c3BkRSaCzGQhXA+i9UhHSsTUjHQ++l+9+
 EVZPpIJvSehDgEJQWeAnP+A5fmvPE2Z1XGI3wQGwtoP8gDxDTk+oBGJ
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

Configure regulators and enable it for the Xperia 10 III

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: erebion <erebion@erebion.eu>
---
 arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index f1958f4bad05a..1b54d9869855e 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -552,3 +552,13 @@ &usb_1_qmpphy {
 
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

