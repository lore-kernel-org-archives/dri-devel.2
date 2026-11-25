Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE2F606A32E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1XeMII5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B810510FE51;
	Wed, 25 Nov 2026 18:13:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 416A010FE51
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:13:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B9D4C63387;
 Wed, 25 Nov 2026 18:13:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795630401;
 b=km/Qzj8E9GmT5p07pXYkc7Luk8PISLx+yfpg2lLwEFEJgr/rB6t1geZZ9DjDS3ZY0C17
 2bWHzgY/EN4qQr/s0D8OYSf61w+PFRRCNIeHqWBjFMTMDNA4UU0GShmlOhHpgvhSO0jGW
 8wvrYrIjWxgo8AiEVoYdH/BmxEu3nQVJmGw+xcR5KXCU8UPHK/yvZSlzbWKuxmNft3AZ6
 mRaGY9UiaPLz+NbJZi7cMLVwby1CJf6z3MX7I9prXhdsA/CTbhBqzzLdcesBJEgbJVpT2
 IPnXhE1vqKamIawW41mVME9zI+8Sl6cyopj+X7y7jx1v0Hh5qcoPl7QwNYURhGeTgAg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795630401;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=zf9Zr5En+UCqIPqNRpzp1CqfGD38nha38omPOjmNrFY=;
 b=ocqcYwLJzQpO1oKA1gX2SZnlVQmMwIu9GbhE0HIdtAf0uHLwe4OZ+MPOS0bVIjo3DCKY
 /gh15PWupejxn0PQ3kt5tPZd9o3a0aovYSHjVYu8SiwoUdrkrSS3xRoZizbENMc4F3O2w
 h+BmjYRzIYMnMwbrXkoe8WffnbQpxVBHkvwgmBGv0r6aNPAqza8+zqw1zU2EqPFvYTaKM
 drB6mPcQtJ3B+j2a86DsolYRqdtWUlygULFeTvh9iJebKYQ1Ix7rsh86L2sp9x1rUTopO
 9G8VC6YvBT5g+/rPsKuGQlNEXbkpuHoGA2CaJZERrH7CVLqo6DnLsKaQYY0BWKER8MA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 7E8A71F0156A;
 Wed, 25 Nov 2026 18:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795630401;
 bh=zf9Zr5En+UCqIPqNRpzp1CqfGD38nha38omPOjmNrFY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=P1XeMII5tm63Ft5UzX2QusbSN+EmGIXr0NG4YLs8DeKUl/CrxIpAh32UYJFWLtdw0
 286LW64cwGIsmdUdO9vtNvlMeKFKKYDBKwJpHb2ma3k+0+6zhyQ0yEHDgT2cTvoa0B
 i+VN3KFD8Oxm8X5zKqsVxWLGvGEl3sYgkS1fiOU2OkCBPaqYtNxpe2kb7GfMYgZ9ZE
 zNyHPGCo3aZwiFA4HHMhLsdxvVKYq8Yom8Uy4bbZLWeQvMnL+viuIFhKFWC5N82c0h
 wD6veZsTLzDue7GrXh5l/Wj61gzUET8CNNygF1e7ccHnNYIPdyGthwi/mKxzgRMrwt
 LzCSBgHaQHM7Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 7A29C4CFC0;
 Wed, 25 Nov 2026 18:12:49 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 25 Nov 2026 19:12:53 +0100
Subject: [PATCH v4 9/9] arm64: dts: qcom: sdm845-google-crosshatch: Add
 display panel
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-crosshatch-panel-v4-9-120adc58e737@ixit.cz>
References: <20261125-crosshatch-panel-v4-0-120adc58e737@ixit.cz>
In-Reply-To: <20261125-crosshatch-panel-v4-0-120adc58e737@ixit.cz>
To: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>, Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2357; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=A+2cpgTKZsuyPaY65ARPRtY967sq4BpFSqvnoaIMPGw=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrByUe51AB0/xnlO5MuDoBhNQVQ6rTFJH08qj84
 xflJayGh7yJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawclHgAKCRBgAj/E00kg
 crNHD/sFUXcq1AMMwnsUYItZGc7eUg+E1Qu47rIXPgA4HXXxY4PgxEvZvvq+jywnV8WTCxsGVt1
 JUkeo1HRf5nOiU0A2aAr0vtsvm4lvrS0a0xfWOw3TSJeGkoicz1z5+ZGRrba+u0wamzr6alQ2lO
 1nz3AYZbzrJuqC8obgXo8r8Bb3w3ylg9xJs//RhqHBkqiMnTH72z79S6bObZY4N4UBmWlpEuMbc
 lQoFWjd0vGs06jdqAM3LHbGTd2eA7bge+5rRwRQXc1XygeSTkfCdx7+LH+J58c0nM8HkJVaTxSc
 yVfB3N8JPwkao/+jrW+Q+VexMZlcQrqy87k0dgo+zFWx735IqC0tY1JuE8RQSmntdd99Tuv3KyK
 w1cypzsmdm0bzxkSc+gs58+9fqKEdYt/RtvqXfSw4TSfKVuJl/WPm2QEKl+dOM4MzRLH+h+sScE
 QgXs6Kx+E76KfrAhd+nILkEFD0jqODC5IQ0M2E+juKDjLPzaBLfVVvxtamyA5qHpeboC/pIrM/7
 pKj//CGYokosPlAdswNIJThs8M3cumXuF1+KtJQxfQlhwdQz9l25yenmjPA3AItAMtw52KiNagQ
 jn9zTy+QNe/w3s4gB8R0C9iZ0ZBrfzLbuT9+sByXvsMA29MBpRxaX+KzGGD0epaczvNZiOSN2ve
 FPSSa48rbITYYAg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Content-Transfer-Encoding: 7bit
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
Reply-To: david@ixit.cz
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Heidelberg <david@ixit.cz>

Wire up the Samsung AMB630QY01 AMOLED panel on the Pixel 3 XL and drop
the MDSS/DISPCC disables that kept simple-framebuffer alive.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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


