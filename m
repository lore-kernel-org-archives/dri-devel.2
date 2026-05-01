Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED53CD3425
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 13:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F6210F530;
	Fri,  1 May 2026 13:53:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="sOg3GpRd";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15E3110F530
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 13:53:00 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-483487335c2so21337085e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1777643578; x=1778248378; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SprhwydFyCFNRJ6I2mJPFx1qCBc8YzyeEaam9z9ISQw=;
 b=sOg3GpRdc3PRWcrWYgP2ZijgOVbSZ0b+HLr+LS41UvbC2uKWFJE2F97+dxcw2yf0xp
 cMDny44pOVUL83NLSmWsgUpnSREqls/6BVRYQ6A6KBJLIbrsT9FIcmqdeWAvy/ipEH3f
 NciA1/9U5No+7ezxXSVhoKNAQemtIR218c47mI2npBpC79m1hVczw8ea+0JZcDzpmFxR
 rnr/gsu2kGmXDueJcj6N8ncJQbDJvY9C8fQz0eTa188XeAFjZFgmauvwlOhG9dSgI17F
 qV1a4SkLh8OzAU/238CBtlLHVQK3Rf/Kfgq05IrWrPOth+gZnsQxrfcnzbXuJiU+hK8Z
 JPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777643578; x=1778248378;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SprhwydFyCFNRJ6I2mJPFx1qCBc8YzyeEaam9z9ISQw=;
 b=Bfog6mIqlXBJjyGvhK7IyzbihYByfyv4RvFM/DhtOEYoxdJ/OITRFy1vuCaMmBLiDU
 6WYDPV/gxndRcOFDmwIXkvd8wDE8Pi//PuuJ1+NJjtz8h1J3N9E6un2bKdlHEmtuPuS7
 acXcdgcoEU8W0i+dEyIEDaS5SrnJrqKr9Z6AAAF+DhET2Xe4tdmCgkwqdSi/rVgPvOqB
 zSsxfPF2K2klVIKmUuUuy8OtKLdITDQCcm16xnbFrKHYkFRkuAkn5e9ADRJseI41zLoi
 VZM+VyixRTfSpMjdaLTLaSAEPzoLhanjZdwvfrEDPUTRUp0oLC5LNr3wJ3C3o79XdNPi
 Xvfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nOobdLH/Yfx2GnnC6xBJ5lj12lQmlPVezmspDFJ95TEe7/N/VZY3oFmeP3K4l85IOkv4VpddUKyg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDMvwd0oxf7Ft8Z0dzMcA3vuFcO1byZUUmB6Ap464dWaPLsJaZ
 VSGHGeIyLPFhWYioMQI7MtkSVryfUG2r9GmvRYTMSW5DCO9g1WAcHEDwT5adrRZwRmk=
X-Gm-Gg: AeBDieuYKIIh6UskbXKm9ozQdd6Mz6Psc2PCIZj22ib6s0znfH1fM9Ui/B6LmlySxDX
 EWegG907ufZWmL+HQZ5/c2UqjLKg255K1J8Y2s7AHsBr5KHVSJJeimWhZHwDlWlkOxg+uHlI9uq
 +8M6CNoRj96KTJlGGkSttmz/Yfqu++eNFjUuT+JjgSL6g6IqnwO9D2Eb0N2OP0vHxqFC5sJLzpg
 J/bwtDPOX1hHImeNIPt8JQluBG3R1ibI6tufFJC8ojYDJtHStUSbXXEH1Exw+kbuhTByDeRXIMu
 5BayGoLQ3pXAFAyzH0wnbp86SKN9fpPrYihm9/tA62Yco4xyvTEQteBXZQzPQ5oQEX5xKF/Rbwy
 V/IRfEsC7KLbgEPvDp+MDRnqdHc0lUUVpvmiXyqOaCqEhydGNPb0ZH5Lu2ayDtndZ+BZGNWOy35
 ku47MSqvYhCfEFvApGXEuhbJhj5ogtkFlpYIOwC3K/zYkuJKfKkJ62oOTNpucn5tTzdMMxrtr+1
 TMaVbiv
X-Received: by 2002:a05:600c:154d:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-48a8452db0fmr123395355e9.25.1777643578635; 
 Fri, 01 May 2026 06:52:58 -0700 (PDT)
Received: from [192.168.178.36] (046124199213.public.t-mobile.at.
 [46.124.199.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822bf3ffsm143934275e9.7.2026.05.01.06.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 06:52:58 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 01 May 2026 15:52:48 +0200
Subject: [PATCH 4/4] arm64: dts: qcom: milos-fairphone-fp6: Enable display
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-fp6-panel-v1-4-e09cb05651cc@fairphone.com>
References: <20260501-fp6-panel-v1-0-e09cb05651cc@fairphone.com>
In-Reply-To: <20260501-fp6-panel-v1-0-e09cb05651cc@fairphone.com>
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
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777643570; l=2182;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=4phARy2lOpcG+iFcGU8sNg9eH7L46jQjDqzNVUvYkd8=;
 b=xUdq3R4ju7VrrbMlrUU/wRM4VE4j/Gq3F++FNx2yt2ZNSkOtxB3Z6xk+BWK459qJKnyJVug62
 HKSGQscN3s/DYYGuA6wGOJHtguzdzmbEjMcO1sdhcPpAPHGR5hKvG/z
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

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 64 ++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
index 48e87bd8ec2f..a6c467a27d09 100644
--- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
+++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
@@ -690,6 +690,49 @@ vreg_l7p: ldo7 {
 	/* AW86938FCR vibrator @ 0x5a */
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
@@ -848,6 +891,20 @@ &tlmm {
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
@@ -868,6 +925,13 @@ pm8008_int_default: pm8008-int-default-state {
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
2.54.0

