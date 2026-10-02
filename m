Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6AACA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D264410E5DE;
	Fri,  2 Oct 2026 14:21:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="W0a731y6";
	dkim-atps=neutral
Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com
 [74.125.228.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F93410E5DE
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 14:21:57 +0000 (UTC)
Received: by mail-ej2-f43.google.com with SMTP id
 a640c23a62f3a-c2e309aeb38so337016766b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1790950915; x=1791555715; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=365rpWbQTI8r+XdiFb+KF1sTOX5DYF/iothdwDHKaSc=;
 b=W0a731y6ohXkHV7tz1ELfGa2H0C4cRRlio9mIqSmYe5LuFMUWTN9haRHxk63r6Wp0u
 NxG8c40XKhz7akAFHpzI23JTAKPjEmWhAO9N4Cat4M4qONY2gZlExr1Bmt3hcdVcg71A
 +O/Yp0c2EkJFexgRKEJz2gXsBAMv+0+Rxb9q1itDL6ctgVJnUFSRNWoND/qC1kZwMDEb
 vlUAAKt0UB/FdnQM8+uxU1Yq4WGsyHn5uznAsC/BHApZFfGw/xoayrHt6fJ+AWU8sqzL
 3hNUTXNkGLiFDywgyuRLI6QZvvN4A0EUy5Hs9nmYnG5f3aEzLGSHQdixVCkA6Zq56vuE
 7Q4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790950915; x=1791555715;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=365rpWbQTI8r+XdiFb+KF1sTOX5DYF/iothdwDHKaSc=;
 b=iCbg77Xrib/Flq+yXchy/m2GG6DdPb+5Ghofd3OcDwfd9R2uNV3RfKLdkDCTvPBSqh
 vXIyzxdd5vR+MZ744APDnohGLS/auMA/a7FHOR+78Krm9rVQRXVCQtrEhpP09SPmt+He
 8q6xYiSZYAmB5Rt0EhWNm6pvjdi2Dbw5SmMKhLl8B3audc9lF6G4QlugfaH2WkEWgHs/
 IYmLcsI04LK973XIwNYxvpqJPUFKuHknLe/f2X1ED6BZkucto0Z58wXCKQrCPokIT6QF
 YDGD/On5THyNqr4ZxLf/3S8s7eAf17vW0QA6HjzfiKf8fQyvxHCUZcpOscsBM34VewpH
 3/AA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgzBjh+AlWeOmHDrksV8Bz3hOeVMz/6NomH8E0FlaZbRFHwmMIkofoBrCk5wtE2K/s4cyYE48ayUM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n6lPyhBx7Z+dLSqja6gTIBExTlI+12uojQb3gpgJBlK0cDL+Y1
 1nSGG1GXTeUu7gdOvM+t78lJ5DWBxSQP69R4KFnWQfNlqjjwE8RN3RPOZ7d3XWX+R9w=
X-Gm-Gg: AYBFou2tkEl17AMjjYW3RB3xuu8DRN8ccsO5QHtG2YtbeOODpfaJlTKpMVpUJbChisW
 /9Jz1j5sP9663xkM2D4maiAaLWNAq8/C8r9YCcSufDQoTrzh9pq9WPU7mBD/we+uMo07jEK7TH2
 wYkPGZriB1tofZxtesjgTkts5RTLovdrR9BLy1DEV+3pCmn+9VEbbQYSdKl5mduP/2BVPKESFJt
 6Ump/NcY2SLIzByHjljvi90E9374S2qFgaLKw+LYvXRO6TloyS7hwt0AJdqIF1Izn7M8D9r8ebV
 FPBGIqtXiJWpnS6qyykItjfhLBaTCV3AdSGMq5m99XnWKuqYo1T144iV1cWe0rqp+E6mYEjLexa
 LKWVNAEm9m5msJ6fO955j3pVMEohi2zd57q0ZFT4iPBUlYjg6vuMN3ihQdS8sTV/hhywHpzxCKQ
 EYWh8o2uCdd5fJOyuCCEKNzv+kwz+aijbgGBlwbPYrNY+HEK3lyc7Ggl35Kh42hzecb7WC/Mzp/
 zgtakMlVzfIMNKSu4yyd+OOPdVf1qfLmRbLXwlD44apOkFYufBt
X-Received: by 2002:a17:907:96a2:b0:c2e:4a61:d436 with SMTP id
 a640c23a62f3a-c2e4ae24de7mr253246566b.36.1790950915541; 
 Fri, 02 Oct 2026 07:21:55 -0700 (PDT)
Received: from [172.16.240.104] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e4cf684e3sm89307166b.51.2026.10.02.07.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:21:53 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 02 Oct 2026 16:21:48 +0200
Subject: [PATCH v3 4/4] arm64: dts: qcom: milos-fairphone-fp6: Enable display
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-fp6-panel-v3-4-4b80f83bc936@fairphone.com>
References: <20261002-fp6-panel-v3-0-4b80f83bc936@fairphone.com>
In-Reply-To: <20261002-fp6-panel-v3-0-4b80f83bc936@fairphone.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790950908; l=2284;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=K/UuwAdCDzSNTdbtCp/oiK4VjRQqMyDj/QIu8/Tze7s=;
 b=0miXsdcT4VeM7yvVFtm0Wm/kXPYBFutnMKbTczS6I6lMKnzluxR7nVoKsN9W/y0nt8zJB2u6F
 MQE8ldE2YMNB7Ct6Fs5g8EPCGfsf2IZOaucOYjNGRNOcB8ACveXIb1P
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Configure the MDSS nodes for the phone and add the panel node.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 64 ++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
index 4e8777162b53..11015c3fa331 100644
--- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
+++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
@@ -709,6 +709,49 @@ &ipa {
 	status = "okay";
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l4b>;
+
+	status = "okay";
+
+	panel@0 {
+		compatible = "boe,bj631jhm-t71-d900";
+		reg = <0>;
+
+		reset-gpios = <&tlmm 12 GPIO_ACTIVE_LOW>;
+
+		vci-supply = <&vreg_l19b>;
+		vddio-supply = <&vreg_l9b>;
+		dvdd-supply = <&vreg_oled_dvdd_1p2>;
+
+		pinctrl-0 = <&disp_reset_n_active>, <&mdp_vsync>;
+		pinctrl-1 = <&disp_reset_n_suspend>, <&mdp_vsync>;
+		pinctrl-names = "default",
+				"sleep";
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
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l2b>;
+
+	status = "okay";
+};
+
 &pm8550vs_c {
 	status = "okay";
 };
@@ -872,6 +915,20 @@ &tlmm {
 			       <13 1>, /* NC */
 			       <63 2>; /* WLAN UART */
 
+	disp_reset_n_active: disp-reset-n-active-state {
+		pins = "gpio12";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	disp_reset_n_suspend: disp-reset-n-suspend-state {
+		pins = "gpio12";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
 	sdc2_card_det_n: sdc2-card-det-state {
 		pins = "gpio65";
 		function = "gpio";
@@ -906,6 +963,13 @@ pm8008_int_default: pm8008-int-default-state {
 		drive-strength = <2>;
 		bias-disable;
 	};
+
+	mdp_vsync: mdp-vsync-state {
+		pins = "gpio129";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
 };
 
 &uart5 {

-- 
2.56.0

