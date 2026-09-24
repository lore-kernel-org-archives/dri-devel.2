Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6971DC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1E0810F5D8;
	Thu, 24 Sep 2026 14:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Le2SaUDr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D61B210E04E
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:01:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 744C9447D2;
 Thu, 24 Sep 2026 14:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55CBCC2BCFC;
 Thu, 24 Sep 2026 14:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790258496;
 bh=7lbo0tmJuCrfVNuusObRSYRQ3LhsPSY4no0HnM72Pbs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Le2SaUDr9wMCys8uzqbuUv4CQ/HoqEWVryBpHReryH3HSKdIeq/QKDQvgSFZY3bFk
 3khrKUn5PjdRPlbOhrwiu0Eaw9arTsr3O1ekQpsFcH1NyPQ67jeIt8rRx3dYU4hwTy
 29Ll3AWJ5OvIhZ04scFaUNPmLhljq4GjNR0ytaf3tpz5A+vHT/PZSwS80Tqms6OzBq
 RoNOcamkGJHA0we9r89qC2pvTmyJzL+FgWuPvqe4XvEMjYSVpAgJbw+ohJ629zuJAg
 CamfmBhIlbQzWuDCyS3ZbFF8YPT11/GntDpE6J8G8nvM9FN4mzAz9UsQNQnW2STiOP
 D+eFMSwgpOlaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 412CCC98324;
 Thu, 24 Sep 2026 14:01:36 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Thu, 24 Sep 2026 16:01:39 +0200
Subject: [PATCH v2 11/11] arm64: dts: qcom: sdm845-google-crosshatch: Add
 display panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-crosshatch-panel-v2-11-08d5c7bf72fc@ixit.cz>
References: <20260924-crosshatch-panel-v2-0-08d5c7bf72fc@ixit.cz>
In-Reply-To: <20260924-crosshatch-panel-v2-0-08d5c7bf72fc@ixit.cz>
To: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2261; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=YKxaEQ83IRvBzliLWTENjXhw/HISL/i0Wy+mkQdH9Sw=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqtS09CRw4AjnBWLNaZGzHG49mTtgKP+bP2PN+j
 BNOfZS6CaaJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCarUtPQAKCRBgAj/E00kg
 cgCQEACNSghX2ofl/jTgz22pX0CXScL5o0+ueuo3F8JyXYZfnOcjaUMF2vU8VdZ2KRA8mZozcVi
 fS50qZZ58SBVKq378CbVeB6IbkXHm9ih7CsMAYKSSpTXkErcEZqQheYNQUM0d2w3SE8e4g/lzba
 AjBRWHKOlH7vsuo7W0NsCz+ninOQ7GuDQx5m4kGmZmzcNiPJ68/YyigsDF4zTzdCpmhNzKc17GN
 H7ftgVW64HxCg2dB4NcfYetPonPB6DmU4MKT3QlVZMgTH7SHchE1kilsHSDpH1qY1xl89mRQ8Fv
 Ml/NiX5Ih17vo4uDidMCdSVRTD/7bgrwGlkxmGS3vIcebeZB9xPyZjRYfy2fDYDlQrfEHgLIX2/
 XvskJuSUmkXXLf/81zmdqsYHnrqrLYebbVH65r0MbxmuX0BDmrPvYUSGAhQpBgHtPSxUvHJXz8J
 9xYZeMgzS5G4JTQolmDDCA8Oxjr9MldfrvmrQFSjd8JboJ0IlBzCo13Y8lfz5k3xy+hQ72PaIqK
 HYcim5Sl1A5o5fZGQwg3WIGUnChhy8rHY3MyoFcnyZ6uPaKFx7U6fEgnqIe7cTkt90FCzGs6N6e
 fsU6oVe5eyucd/Ov7U74UXC6phFk6COHChE55GR8KwGq3KNpdnEUMqZLAC5avDuX41hql4hh3BL
 L/yATMYeCw1zxNA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: David Heidelberg <david@ixit.cz>

Wire up the Samsung AMB630QY01 AMOLED panel on the Pixel 3 XL and drop
the MDSS/DISPCC disables that kept simple-framebuffer alive.

Assisted-by: LLM
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../boot/dts/qcom/sdm845-google-crosshatch.dts     | 60 +++++++++++++++++++---
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-google-crosshatch.dts b/arch/arm64/boot/dts/qcom/sdm845-google-crosshatch.dts
index 2a81ca1d00b1b..3b788757b7303 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-google-crosshatch.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-google-crosshatch.dts
@@ -10,27 +10,71 @@ / {
 };
 
 &battery {
 	charge-full-design-microamp-hours = <3480000>;
 	voltage-min-design-microvolt = <3600000>;
 	voltage-max-design-microvolt = <4400000>;
 };
 
-&dispcc {
-	/* Disable for now so simple-framebuffer continues working */
-	status = "disabled";
-};
-
 &framebuffer0 {
 	width = <1440>;
 	height = <2960>;
 	stride = <(1440 * 4)>;
 };
 
-&mdss {
-	/* Disable for now so simple-framebuffer continues working */
-	status = "disabled";
+&ibb {
+	regulator-min-microvolt = <4600000>;
+	regulator-max-microvolt = <6000000>;
+	regulator-over-current-protection;
+	regulator-pull-down;
+	regulator-soft-start;
+};
+
+&lab {
+	regulator-min-microvolt = <4600000>;
+	regulator-max-microvolt = <6000000>;
+	regulator-soft-start;
+	regulator-pull-down;
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vdda_mipi_dsi0_1p2>;
+
+	status = "okay";
+
+	panel@0 {
+		compatible = "samsung,s6e3ha8-amb630qy01";
+		reg = <0>;
+
+		vdd3-supply = <&vreg_l14a_1p8>;
+		vci-supply = <&vreg_l28a_3p0>;
+		vddpos-supply = <&lab>;
+		vddneg-supply = <&ibb>;
+
+		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&panel_default>;
+		pinctrl-names = "default";
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	data-lanes = <0 1 2 3>;
+	remote-endpoint = <&panel_in>;
+	qcom,te-source = "mdp_vsync_e";
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vdda_mipi_dsi0_pll>;
+
+	status = "okay";
 };
 
 &wifi {
 	qcom,calibration-variant = "Google_crosshatch";
 };

-- 
2.55.0


