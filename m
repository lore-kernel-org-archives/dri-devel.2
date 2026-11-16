Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FA8606A329
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=R7UY6+Mf;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=MTzFpfxO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79FE310EE71;
	Tue, 17 Nov 2026 08:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="R7UY6+Mf";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="MTzFpfxO";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCCDE10EA2B
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 22:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794869435; bh=e52zOd8idiTOYTVhJAx/KJa
 kLcPRSskdPFGDRB39pPc=; b=R7UY6+MfjIKtW/4n+YQ6Hck2lr0hdvfnsCnsHeZ4ACSPYChWZn
 51iVNCarIH6OkiO25L3hPodNYyiDVZN3JgAA==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794869435; bh=e52zOd8idiTOYTVhJAx/KJa
 kLcPRSskdPFGDRB39pPc=; b=MTzFpfxOZrOH3jLt80PoeC3j2JZnUNtCWwMG6f1p136E+pc692
 9fGZNvBl2vf3mArSfm91RX8AnNo8hX303gQUkecjz8DcgxiDZU5yPCurMB7P0EJt0oyNMUDO7x2
 q8NmJmcBwUD/STyKe12QtEb3Z8wg6zbzLa18v1wHcRSGG6CkBy9IKTq88jsxr+uiLXqyuYY4/3T
 /ODYTNS4l87+0gT/1kEVmrQ7ibK4q8kPUKn0bFmGP7coFg8H82W/8TYV03rFTMSSZzcgTcXYyqN
 5rFrTIKOAInZS4hHWVK5TzNIs4qSk5wwcp0adqlUL7ZExH1Dw1yc2cRadRnzkwTpDdQ==;
From: erebion <erebion@erebion.eu>
Date: Mon, 16 Nov 2026 23:50:34 +0100
Subject: [PATCH v5 04/12] arm64: dts: qcom: sm6350-lena: Enable ADSP, CDSP,
 IPA & MPSS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-pdx213-upstream-3-v5-4-7318a19806eb@erebion.eu>
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
 phone-devel@vger.kernel.org, erebion <erebion@erebion.eu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794869432; l=1272;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=BBhnRQuB9kegfveG0S+7V0DZkpgL29LVtDImi9jrxk0=;
 b=GDHDgP5cCv1RNqrfg0KCwDDpBucuWg6Wqpm4Y/6zKH+mujgrlt3LDyv7M1ggUmj3xfR+1Gu6U
 ecqnqbL5IsNC9QHXGg4iTebosgHaGUySBbvBSsIZqYh/G9NF2nsEYr8
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

Enable the ADSP, CDSP, IPA and MPSS (Modem) nodes for the Xperia 10 III.

Signed-off-by: erebion <erebion@erebion.eu>
---
 .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index a393b7533ccbf..e8808865bf6fa 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -68,6 +68,12 @@ memory@fe901000 {
 	};
 };
 
+&adsp {
+	firmware-name = "qcom/sm6350/Sony/lena/adsp.mbn";
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
+	firmware-name = "qcom/sm6350/Sony/lena/cdsp.mbn";
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
+	firmware-name = "qcom/sm6350/Sony/lena/ipa_fws.mbn";
+
+	status = "okay";
+};
+
+&mpss {
+	firmware-name = "qcom/sm6350/Sony/lena/modem.mbn";
+
+	status = "okay";
+};
+
 &pm6150l_flash {
 	status = "okay";
 

-- 
2.53.0

