Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15D3CA6018
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2991411208E;
	Fri,  9 Oct 2026 11:25:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="dHg6+OAa";
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7790A112086
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:25:11 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6af9a90e4bbso4536602a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1791545110; x=1792149910; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=365rpWbQTI8r+XdiFb+KF1sTOX5DYF/iothdwDHKaSc=;
 b=dHg6+OAaxwjaPQTJvPEduz9ktlYhF/OXQlT5n9kipztDSOjztJ7tSFmR+Q2wqEfzRD
 v2Qgkgm04yFpwllZR0w5yoFVwcofNqxl2EhPET8TVph2twjRtYglfFOv0buhsoWKfoWq
 ScC1p2XPh7s/uqdOmw1xx83ce9q7vZTtbOWZmoQnbJjpV4/MPr7ugzZCBGowZUYmNE0y
 jc0MEIdelGCWWaPitkce9vvzpGWIf9gylqgrm6GW7x/SNqd0tKqR/nJLvpBLNmTGEtB4
 LcQtQdAbuiNIEXA7+MJ1dPYMzEQcjSG68IKOaF3BlpFd9La3lL0HIZerojW4oKP0R48L
 lQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791545110; x=1792149910;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=365rpWbQTI8r+XdiFb+KF1sTOX5DYF/iothdwDHKaSc=;
 b=dJGR12TauekVdhKkD35MAhpieeMtBW82gV0QElCIHXHPgj/rQYh5Sf+PYL4Pngj0tB
 0yxS2n+EQq+lGoFfrs44J6Fl9cnJkC4K98fw3mhP+03lyM4DEgCJVYFshTgUo3yztkW6
 jDxQUhLa9fE8O2wam3RAGkRHqHfU8KBs7EHL1dnYBEZ/sriR52Hxa2lOxnQ7fx0gZuC0
 oMx7+Gb7/l83+A4S2pvzge8DGrruSGCOxjlxhhqwSR7qGmIjWxPvSrcW98TvDyqxbenQ
 lHfWIkUOFYn0OwDNKAxbbfXFCi3cczpKJXD7vDLaGn/LtHUN+Gp0b3IK5sAyydb0Fllt
 9FGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMYaUFB4TGpH7ALL3ake0F1C6RDzeTl/gqj8YI+3/G6DOWsXSesPQ1ipmUayRGqNZ4xmpNBKRzDX4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLReUzkOUv4izG8Hg9v5jwQHPhLYcGwFxtSFgmmlldh1iFjMWds
 JzLIHSv/zQl0hx+/4vhyrES7bHQjqzsSO/HQLC048lvP6Flsv8ZKzqRfNPeZPqdv4NM=
X-Gm-Gg: AYBFou3gr4w99qz3/OqnCeIy4zULG0t63Cv2ZEvIENqJb5h98PK7lrwj4Zy2Ph/ONLd
 Dsq/LCBi6KGfbWxH22Zi/PY+z54Mzd5Yj9MQFapjVIlijFU8XWeGFCanE6W4RwJzLddrjxhM97W
 7TO65hCXePluZF7OuBrAykTKFtzXwP+rA6C+zvLn0AloCTF/S2hYZoW0piKC4FCvtBAQSq4IQLF
 lsedvIAy7Cg15In/A/VbXXa6BXjWcGnckFDxSc0EdrRKa5Zk0eHSvSysSsIOj99Wr/dkuFfQaHG
 BHiSNEdeHmJFIpaZBbrdmfOf5enJVm9ubeVqBRaGrhTwS7uaJzvz19qMSrywExZo7boa9SKQyld
 gmpYivxTkf9C0xywX4ZPrLgDAeVQddMbbzTrnTEpoM3Ij2K08DGtOAPnRAKcrb4smz5dXp/r/wN
 MDzn6ma/webfEBgR4RFMRUN/ggFP9gP03XxHccfV4G2LfT1Y4tNtGq4iw67pWDjsyuzt4NbHFgY
 u9iHs5nTbZuORVVYvET3Vv8c45DbF22hY/toFHhL/g0ttSTflBs
X-Received: by 2002:a05:6402:190f:b0:6ab:6e:a8e4 with SMTP id
 4fb4d7f45d1cf-6b17c2919a2mr1279444a12.44.1791545109895; 
 Fri, 09 Oct 2026 04:25:09 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179dd3597sm985764a12.14.2026.10.09.04.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 04:25:09 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 09 Oct 2026 13:25:03 +0200
Subject: [PATCH v4 4/4] arm64: dts: qcom: milos-fairphone-fp6: Enable display
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-fp6-panel-v4-4-7c3819664778@fairphone.com>
References: <20261009-fp6-panel-v4-0-7c3819664778@fairphone.com>
In-Reply-To: <20261009-fp6-panel-v4-0-7c3819664778@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791545105; l=2284;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=K/UuwAdCDzSNTdbtCp/oiK4VjRQqMyDj/QIu8/Tze7s=;
 b=+RENV5BTwuJZenkB/tqi4Ledclqeb7XKWAMWUX+RVt0JGWYi6hJZJFY91iUXFwZmz89TsCRE7
 /oHOtl9hGpoA3+AJesVeUI7yU+ifKJovTWzz+fN4xrzyAidTMUrrqNm
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

