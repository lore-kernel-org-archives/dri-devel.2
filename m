Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D3BC982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3E2B10F3B6;
	Fri, 18 Sep 2026 14:40:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="ZhNHRlUe";
	dkim-atps=neutral
Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com
 [74.125.228.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B343D10F16F
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 14:40:13 +0000 (UTC)
Received: by mail-ed2-f35.google.com with SMTP id
 4fb4d7f45d1cf-6a6056ac81fso1309557a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 07:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1789742412; x=1790347212; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DBZrkz/d6rH1GgwzTo9HcGaBMgfKERMXTNzWP9DGQww=;
 b=ZhNHRlUerEIWi35VFeH5D1813UTTDClxdFo9nUdqmTZTOaVt42HDhBCvi5kFReBENv
 jHkQZyTXqvX8sR4aSUQwWDjgejbK8QEcX8ZdYbBWK3G+LN+nJTkanpk5fAZkTnaC5toA
 3KIdFilwwONNtBq6wSXzuu6aeXJHWAdMYKmNDo0wdWQ+8euAAvQKeWy1aU4KHwLcAtPU
 SGsoRcA4ri3EgkcleZ9kl1FTyqVIsVTVUrtnpyV5Dsj5WvHnVvsBTt8z+Sq3QyWRihn7
 zbJ04rJIEQSeECWsehUglQUBhn1HbL8WJhg91QUMDUEqMLhAgCMQ2GDagBpsHxAiiOUE
 0HYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789742412; x=1790347212;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DBZrkz/d6rH1GgwzTo9HcGaBMgfKERMXTNzWP9DGQww=;
 b=c5LNWMXTxWe8gxu+Q6uwly9Fdx1TDFWAnCS0dY9W27HFMkGowK6H4yXNCl5CDbQTxZ
 ivc9xVvMQRJausEDUKDB3qFeTKQucFNLYFbMxnWt5qjuQroCLQYdnRPtNMsmXEiZ+Y05
 A5wHKEDjAzhUbeqw6zD0ph93qrWttOeqDE/giQ/CxYrAm4gjtjg0DYacb0o8Qg7htQf1
 Y2hTe4fwGPi314KzNIBNRsRjlZGf/KWUxXCKFHM0yB9U2lPAZwkyts9AdNnkfFVURwv/
 +rFSMOkG6BHN95KjogoM4lvtCymkaWzngS1BQK/53prpJ6p/EJNbRihQaPOCcmrehQfv
 cNhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwk5pU9rn/9Vekgr3/m/1XG7jwbPgynOihg42YMS4CfqAPpR4mXoORU94Eq3LvehH+xi3iUNcEJBf0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kkJkFGE63rnbbiYWOzkb4/YO4LfL+hPZbPMMonfGFo9TBqhBjx
 1WBoINEce3788rsLQCA8xEXEZnxprIvvu/gftmWkH7ja3/RoxHoxdtWnBj8f7ieV+Zo=
X-Gm-Gg: AYBFou0cc69rDZpIuqpErZ9q5qrscsuDxnzntirlISq7oipXBxwYJFgiqLXwQpIekjw
 ISnGouSbnMVDFI8hS6tjYAWYH47yv0JYoBqC1LfAoRP4l9bb3UQ+IbZJKTo9PATM2eBqgmQxm7z
 W7crom/6LR/ilqTNThpXSpiwf+mlwDR/F8b7dk7UH91pUVyan1PaeTwrygGlRkVLGofu0J+DVfb
 awuwFFtxBFH3GTYjnR8eb3mp5Ky4QTXn9zHDcETYo+c0Wbglm/6JLHQCyFQfd9/sZ9BYxaCuI5B
 BXgPflJe2Dt+ZY314Le0DOM6qLDaqFEiwYg6eK5rozSLJ6RhK2VrDNM+OS83nlqXsu+9CJx2oGB
 DMObDYCxEqJZE652K9rlJ8I5j2tYmFvHrq8WW+F8I1YkHB7+MKoMugLb+3r67IDQggOfUE3gl/y
 yNFkp72ALh5APYLYecLmtQm4tjRk4Ndc8JX6jNrmCNx0TOuMKVqMXfA0JHfGLAw0H+me91TNed3
 5TZJIVVK2LEWNfbWk8mnTa1H9pu9ihBKSiS36CpefBk0P6dvYgU
X-Received: by 2002:a17:906:9c95:b0:c29:3c97:c994 with SMTP id
 a640c23a62f3a-c2a158269a8mr262337166b.35.1789742412068; 
 Fri, 18 Sep 2026 07:40:12 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a1b7a369esm64244966b.9.2026.09.18.07.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 07:40:11 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 18 Sep 2026 16:40:07 +0200
Subject: [PATCH v2 4/4] arm64: dts: qcom: milos-fairphone-fp6: Enable display
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-fp6-panel-v2-4-6695c4008920@fairphone.com>
References: <20260918-fp6-panel-v2-0-6695c4008920@fairphone.com>
In-Reply-To: <20260918-fp6-panel-v2-0-6695c4008920@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789742407; l=2284;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=rOIM11VEoZADWcbRxJB4CDrlUSZEECHpM7XwHlAs5pk=;
 b=5nrVe28d0+ILTAO21B6rnbOXqb369AcBA5MBYd6C1/4tJwe3W4233FgK8LXQ5jFlzlGaDbLNM
 +zuTWxGcU6aCgO5/FWz5kICtxX7zmlmf7rBCkpqypmiwXLGPoDKBW/M
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
2.55.0

