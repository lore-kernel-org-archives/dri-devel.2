Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A02606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=xfb7VfCh;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=b856NOS0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1405011254A;
	Fri, 13 Nov 2026 13:43:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="xfb7VfCh";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="b856NOS0";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3D310E6F8
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794533095; bh=u4p5bylx/tgUz5l7NLz60TH
 e1CpAntXjpezc0SG+fuo=; b=xfb7VfCheXgQIiXGwDsPEpLN1sgejBCDyrsD3HEUqIh8TD1xOh
 VHxwZorv/aVV5qWxoGBSkDjrfkLbLqLVp6AA==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794533095; bh=u4p5bylx/tgUz5l7NLz60TH
 e1CpAntXjpezc0SG+fuo=; b=b856NOS0clylANjqUfXdUBeDRzAKYo3WOnlMluJv+XhZSLxLat
 BfjTZIYlItZEgix8nVuYzoyZoKAAoqu7ksYNJ5ZXhueQQ5PgPTin2qWwcAEXu1lWN24V5GXOAzn
 O3Wig7yv9y9hDGuqfJadpqqBe6Wi62C5Bq8qQWGE/X+ppJxq0VCDeV1GFw0ZJFyjPbusGvwSIp5
 C1LkXfSqEppEbpmH3wqhwD8Km0N3ueFrttr0h4nKTaO275K7gT853y6l9UVDsf189Nne6Eiak5+
 ml4ownTN5jS7dnXCqTzFbO9OyfcpAEEeoJLfWhZwkr2v7VUMBdqYQ1wlgb83dLQvJgQ==;
From: erebion <erebion@erebion.eu>
Date: Fri, 13 Nov 2026 02:24:48 +0100
Subject: [PATCH v4 04/12] arm64: dts: qcom: sm6350-lena: Enable ADSP, CDSP,
 IPA & MPSS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-pdx213-upstream-3-v4-4-4b01c50a821c@erebion.eu>
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
 erebion <erebion@erebion.eu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794533093; l=1280;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=p7IGpE4GSfbTPqOkJvsD/WcIlRbHfevxeKq472wglug=;
 b=2nog4EF91YRxMCs4cp3SMBPgnEmm0xA8qos/X5KbynLLY+wxr3RgDslj/vxX6N8yAcgmULUid
 /cYUftSqFyJAnyACNxskI04VhJY4NwY+YKeV2UGc2vVhZVh77s8rg24
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

Enable the ADSP, CDSP, IPA and MPSS (Modem) nodes for the Xperia 10 III.

Signed-off-by: erebion <erebion@erebion.eu>
---
 .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index a393b7533ccbf..4066de20ea23a 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -68,6 +68,12 @@ memory@fe901000 {
 	};
 };
 
+&adsp {
+	firmware-name = "qcom/sm6350/Sony/pdx213/adsp.mbn";
+
+	status = "okay";
+};
+
 &apps_rsc {
 	regulators-0 {
 		compatible = "qcom,pm6350-rpmh-regulators";
@@ -291,6 +297,12 @@ pm6150l_bob: bob {
 	};
 };
 
+&cdsp {
+	firmware-name = "qcom/sm6350/Sony/pdx213/cdsp.mbn";
+
+	status = "okay";
+};
+
 &gpi_dma0 {
 	status = "okay";
 };
@@ -316,6 +328,18 @@ touchscreen@48 {
 	};
 };
 
+&ipa {
+	firmware-name = "qcom/sm6350/Sony/pdx213/ipa_fws.mbn";
+
+	status = "okay";
+};
+
+&mpss {
+	firmware-name = "qcom/sm6350/Sony/pdx213/modem.mbn";
+
+	status = "okay";
+};
+
 &pm6150l_flash {
 	status = "okay";
 

-- 
2.53.0

