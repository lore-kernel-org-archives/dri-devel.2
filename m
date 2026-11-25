Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D103A606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6OYEWOF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3304510FC26;
	Wed, 25 Nov 2026 13:09:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C93F610FC05
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 13:08:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4DC9062B45;
 Wed, 25 Nov 2026 13:08:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795612120;
 b=G4euRiEazQJqfCqNyUcxnd01IXO/tpwydroPDcplpVeyMdmnaqGd6vZ9LcUdcFiIPYwJ
 zMN00y+rx9qSN3JAmEdWPIikfcsK8AO611mtSl0mZjfJRR2EBQYl54ERNIc+OUmien/uP
 F6T8VRvvtDalPHU63rK/vRxiWpjilhjfDYlVbgGCxpPaszLFth6LCnmlpMG9E67g8+1aL
 oAepR56OkLzf8p/4daopTnibhnqBuvTSfh9Lzou+Y/P5glcH9sJPmb8ct/9qC6PePItgk
 boSSMYuXHX9Dojy7dcLpn63QwhbT+AcwV4lsnohAWR0VZ9quM63vJHuqBBf/DIjX3/A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795612120;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=bC6BOA8lkj4euco4/6Bslnj1/a+liwPShT0rQp2o0u0=;
 b=NxMMRlewSIzdqFn78OXIk3ZukxabJSqJmLgYkNg86BgK350pXxMYJrm+6dE6IG8HAqeU
 s61WvOBuWZQyzVXsqMIcFPtfnumdazuxYe2ZIFRAR3BJt6FZm7jubazLrmHy2KTgLUSAA
 /uk3LjnHRKRUyKJkU7AVtvG1IzhKCy8INC9luich0JqlRja3GABiHIe17W958VLhAH71d
 j7KNgy4D+9kMkXxWbrPkn2m8A951M8w2caLLa4R2oXfKMPKe9T++PvsB1mJxpF+uYHo3h
 yt8y9/khoRXS2b+zaxRJ0UrYnfxEOap+LACyxb8D27h6oBmcdyrrwzv3JFasknz1Q4Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 51F6C1F000E6;
 Wed, 25 Nov 2026 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795612120;
 bh=bC6BOA8lkj4euco4/6Bslnj1/a+liwPShT0rQp2o0u0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=I6OYEWOFxYvjfUY0UL5lTLq9+2Y16VdmRXx/HIcXeR7KyWvhyNY4ObG9u3o1sKYX0
 xhbsDDv4zT3djYCftuyLn8oam9pIevC5JY1j/uLdH4YJfQe1gjR+R0qnK/QWA2lO24
 Tyu6IihDjdne6ouhZajVjdwWNOqPzfpdvXSAj4IBLm3J35TeNWyk6y8g+HwsVBg9p+
 EoYPJegrJhAcTM3GX7pd54BEaQHY5/wjN22p6RvKoi0H1UnvidyhLy/DjbQQXayn3k
 GTKPUh8udWFwBP7fFAPIi6gewB3KUrpBukuNVLYkJSop8VgUesj71H+ubIT0ob2M2P
 ACCK7mbLwJXyQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 742204CEDD;
 Wed, 25 Nov 2026 13:08:19 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 25 Nov 2026 14:08:16 +0100
Subject: [PATCH v3 5/5] arm64: dts: qcom: sdm845-google: drop panel
 regulator-always-on
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-fix-blueline-panel-v3-5-914b4a30b73e@ixit.cz>
References: <20261125-fix-blueline-panel-v3-0-914b4a30b73e@ixit.cz>
In-Reply-To: <20261125-fix-blueline-panel-v3-0-914b4a30b73e@ixit.cz>
To: Abel Vesa <abelvesa@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Vinod Koul <vkoul@kernel.org>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3724; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=7MbJWcOA7VgDjyx+wISNbX3wFon6Upjhtfj1PpZjQxE=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrBt3BP5Lf1wO+j5Mx/5MSPqPEcwqPoMlGv/Zcc
 PrK11+eEfiJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawbdwQAKCRBgAj/E00kg
 clXoD/41wH4jQ2DlT9BhUtMArglYyo7sqm5aOY7yyZ5mM5eH9losiXE56sS8ihyEO/UZAN5vyDQ
 QDPdpORQ5pxnA2Mmc1pxQYCl0TeEbjsxXji3wZ0CItqXEk/wettggKnb5hlaBU1z6EiGdp2f7De
 Mx1IbciyUHEgSW9yzzuv94ZzWIkAVaKEi8gUiMSJBatJn7WFrpQrxD7aEGm2KV5vlsWKB7SqSJW
 WtS4okXZrAbEGQGFRH+hFgddp0eHGZX3WAEyBgR0NaPt0sUoFMW2QmovUFAeEScVCy+puZdKwe3
 GLE9pPCZyPRWgEdk2bl1XaxnnZJ+wa/Z724pbryOPx/XGP2Cld7DAgiQaTNYxTvK5Q0puBUoaFx
 eWFbqdupYvQ9r5fBAt6tFu+0LbK8To9ylptdOYwzFmLIFBfH/saQDQARRgI2gznL3xATV1UDMrA
 AJECdsfywp8KZqvE189QTe0NBFsktAw71L0A2LmT9dX699c0isV8Ks52dU6+xiIpECizTFSNkUI
 00CT5xZYa5XTm+WDFmyDHZWqEsV5erwrwWzHdrPAVkBvdC968m108HfBR0uJhLewZr0V5fW0x1T
 b8SspazuuKf3Ee33ppR0y8O2/uONXGz/KohqS0E8O833dylOAUCa8kRBRT5hd5w8EVAWcVwaZbv
 O8PzMa64wMKLTqA==
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

Drop the regulator-always-on workaround from vreg_l14a_1p8 (vddi) and
vreg_l28a_3p0 (vpnl/vci) now that the LG SW43408 panel driver keeps vpnl
paired with vddi, allowing both rails to power down on Pixel 3 when
neither the panel nor the touchscreen requires vddi.

Define the supplies on Pixel 3 XL's framebuffer0 node so simpledrm keeps
the panel powered once regulator late cleanup runs, while intentionally
leaving them off Pixel 3's framebuffer0 node so simpledrm handover does
not drop vpnl independently of vddi.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts   |  2 ++
 arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi    | 10 ----------
 arch/arm64/boot/dts/qcom/sdm845-google-crosshatch.dts |  3 +++
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts b/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
index a000c75494f1c..f916f4dbb89c5 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
@@ -14,16 +14,18 @@ &battery {
 	voltage-min-design-microvolt = <3600000>;
 	voltage-max-design-microvolt = <4400000>;
 };
 
 &framebuffer0 {
 	width = <1080>;
 	height = <2160>;
 	stride = <(1080 * 4)>;
+
+	/* intentionally no supplies here, see the LG SW43408 driver */
 };
 
 &i2c2 {
 	clock-frequency = <1000000>;
 
 	status = "okay";
 
 	/* ST,FTS @ 49 */
diff --git a/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
index 3c9656b88b696..c025b2df4ea25 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
@@ -246,21 +246,16 @@ vreg_l13a_2p95: ldo13 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l14a_1p8: ldo14 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-boot-on;
-			/*
-			 * We can't properly bring the panel back if it gets turned off
-			 * so keep it's regulators always on for now.
-			 */
-			regulator-always-on;
 		};
 
 		vreg_l17a_1p3: ldo17 {
 			regulator-min-microvolt = <1304000>;
 			regulator-max-microvolt = <1304000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
@@ -308,21 +303,16 @@ vreg_l26a_1p2: ldo26 {
 			regulator-boot-on;
 		};
 
 		vreg_l28a_3p0: ldo28 {
 			regulator-min-microvolt = <2856000>;
 			regulator-max-microvolt = <3008000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
 			regulator-boot-on;
-			/*
-			 * We can't properly bring the panel back if it gets turned off
-			 * so keep it's regulators always on for now.
-			 */
-			regulator-always-on;
 		};
 	};
 
 	regulators-1 {
 		compatible = "qcom,pmi8998-rpmh-regulators";
 		qcom,pmic-id = "b";
 
 		vdd-bob-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-google-crosshatch.dts b/arch/arm64/boot/dts/qcom/sdm845-google-crosshatch.dts
index 2a81ca1d00b1b..7591c6ebb1cb9 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-google-crosshatch.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-google-crosshatch.dts
@@ -19,16 +19,19 @@ &dispcc {
 	/* Disable for now so simple-framebuffer continues working */
 	status = "disabled";
 };
 
 &framebuffer0 {
 	width = <1440>;
 	height = <2960>;
 	stride = <(1440 * 4)>;
+
+	vddi-supply = <&vreg_l14a_1p8>;
+	vci-supply = <&vreg_l28a_3p0>;
 };
 
 &mdss {
 	/* Disable for now so simple-framebuffer continues working */
 	status = "disabled";
 };
 
 &wifi {

-- 
2.55.0


