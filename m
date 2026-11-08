Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF27A606D814
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J4ci0Jza
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5456610E7D8;
	Sun,  8 Nov 2026 12:32:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1559510E7D8
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 12:32:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E84204478F;
 Sun,  8 Nov 2026 12:32:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794141155;
 b=qE1cm9B6s0JinNGypvXISQ3mz/OdvDIw/UY36UR1M18rnvvjn5b+YrWgC5nsC4iaJsNI
 dw4TkTeGVqmCEwfWhqscyTJI28lF1pmdIa7uPCo9I50DFdfEzXMzr7YFVhvqDqhYyJIA5
 3cQ9zGlyjNMa+INV7nPQTWhZvBvG4p20BcGStFNZ9lE0GnKhGUGq5h8GEnwIafViQqZ+b
 OPFRg+nuRG7G+rC6P7EsGqa8IRsUZivav0gE/+4pA0PBOicjusoemMzIlqejKTjChcQwO
 aLE1K5sZlLhWlPqlSdUB8Pm1Ttx+8KeuygOA5EIWrZXfcuFPnCSiRQ74J1WOJbCf/Bw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794141155;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=PpE3OPjkv9DCsAIkITa/qVZLLjfJmnTHjrYDZvjOENE=;
 b=phy3aKas8L/kZqzLxlwCdc7JvygrChU8kW2yajt7PoDbU7RYgGBTh4W3A/a3rHNUy1Wl
 6sGL1+O6+2AVp7/SARWkWMDn2KkmnjXHZWDEk8NPbnIglYUgCB3E1uwQXGoteDMStvrLV
 7P2S6Me5kPi9DHiQ0EMRQ4+VY+h9VCHd/4l7mzFehcvvAvG28VQC9ZT6Ii4DeeMC527Rp
 F7lLkTKTWgGmLhpo8o6fmecUH2LosmOhu9R0Tpe7PrAFN8zQ+a/5/XVy92WC1WGbX6UjJ
 wkEbobjmzltohen7fEflZTq1duo/CfbNG10IKJhGdO/FzDktoHom9063oiGceJ8f1Tg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id D22871F00901;
 Sun,  8 Nov 2026 12:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794141155;
 bh=PpE3OPjkv9DCsAIkITa/qVZLLjfJmnTHjrYDZvjOENE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=J4ci0JzayRKabbnztLyQz3cteAZp7pSSfViWLEyDXZJl3qm3/wPbyPd3S/rV2PfPK
 LUOJTlsnDRzTASi1x92t67EbQPZq3IgxCR1ahH1pXKoUJ7r9m/bZN9zhG4GGBkggEH
 tyeVvoD3XLWnrpAIwIydlOnr9a7Mnp9Z3bUgADjYIKA4XjaRKNwpTmZWfr62NwhO4O
 tV/cJ+qLx1zRQECAJfr/F9RasINUq3zRPInuOhyVM7NeGyCggOvtRRDXnWYMW9VvqL
 RGHnpn4Z+JjL38qEUYqPwGTY95uuaiM22AlhE0Dtg6dKb0OM0B1uRs2nWc8FN4L5zn
 hgYpSd+yETqNQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B090947F85;
 Sun,  8 Nov 2026 12:32:32 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sun, 08 Nov 2026 12:32:30 +0000
Subject: [PATCH v3 09/10] arm64: dts: qcom: sdm845-google: Move panel pins
 into common
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261108-crosshatch-panel-v3-9-87dd4ec4f7cc@ixit.cz>
References: <20261108-crosshatch-panel-v3-0-87dd4ec4f7cc@ixit.cz>
In-Reply-To: <20261108-crosshatch-panel-v3-0-87dd4ec4f7cc@ixit.cz>
To: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2187; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=0xoSE8g8hQhjUJDUkLj1oNslYQIjrBTjTW8DNBjsTIM=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq8GvfT+vBvIhZSx7g4ypyveRa4g157FIz9bUyO
 H2SIQMe3UOJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCavBr3wAKCRBgAj/E00kg
 cq/gD/0YpTLcxsgciJ4LlTG4ERBQqJQsYwC2qyT7ubIjkK2iS5d8tOHXMqkaKkibUEHAoMhjZte
 Kb2cUIrDZbauMSSpeg1Ca61DT5WwSAhDyRn9Z7LqiGKRZciSiezkJPOZgBZNAlpfUUhXq+a2+13
 nomOP+GXwZy24+hz2itzxpMiwHrQO6PjTOAT93oAOY4jlPlTCJF+vhms0JKHJJA2giNh/+oIma+
 ryjHRtTbbsZP45WLGaAKYFH5gddSEjS+psnTvG1auVqwoNi68kdgQKsc1/nyJVo3G49eh+0BlFR
 HjjvceC/uMY6OS2TPu88bP43omcsYVSW2m7+vXhwYyOfXlEBIi/jJ5HbHy4HgfFhvKPsOvL5NiN
 bQQa1qADQUmmeHtotvd8RDkJi+P2CNrxRZmTcE+JcOv3aULZI4MiIpV38CCo8hOJUkngDSlew08
 DlYHBfp0+KMocEVWRwOKhbADKTJOOYE7zgiVRcfxHqG98Zdp1WHGTHI1vt6cUBjlx2e3ilqJVOT
 6BL7QlDre/pMo+/A98PgreHOWicfbq8M8FPue0ZuR1NxRfg2FfYVN9TdJ6f7nEnhpaMtXFAejCj
 lY0JfSjwVik/s1Z3PZnjt7k6NLorHd1b/Og7bJ4NZzwJhUKyAOSsnUjPHdh0vW0qtx0y/twLn71
 2pGskKNNEMBrKsg==
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Heidelberg <david@ixit.cz>

Both devices share the pinctrl configuration.

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts | 18 ------------------
 arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi  | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts b/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
index fa89be500fb85..a000c75494f1c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
@@ -61,29 +61,11 @@ &mdss_dsi0_out {
 };
 
 &mdss_dsi0_phy {
 	vdds-supply = <&vdda_mipi_dsi0_pll>;
 
 	status = "okay";
 };
 
-&tlmm {
-	panel_default: panel-default-state {
-		reset-pins {
-			pins = "gpio6";
-			function = "gpio";
-			drive-strength = <8>;
-			bias-disable;
-		};
-
-		te-pins {
-			pins = "gpio12";
-			function = "mdp_vsync";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
-	};
-};
-
 &wifi {
 	qcom,calibration-variant = "Google_blueline";
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
index f1379857e2742..d54cb47cdf95b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
@@ -473,16 +473,32 @@ &qup_uart9_tx {
 	drive-strength = <2>;
 	bias-disable;
 };
 
 &tlmm {
 	gpio-reserved-ranges = < 0 4>, /* SPI (Intel MNH Pixel Visual Core) */
 			       <81 4>; /* SPI (most likely Fingerprint Cards FPC1075) */
 
+	panel_default: panel-default-state {
+		reset-pins {
+			pins = "gpio6";
+			function = "gpio";
+			drive-strength = <8>;
+			bias-disable;
+		};
+
+		te-pins {
+			pins = "gpio12";
+			function = "mdp_vsync";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
+
 	nfc_default: nfc-default-state {
 		enable-pins {
 			pins = "gpio25";
 			function = "gpio";
 			drive-strength = <2>;
 			bias-pull-down;
 		};
 

-- 
2.55.0


