Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF528606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uXPEHVTN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BE2710FCCD;
	Wed, 18 Nov 2026 13:47:15 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E988510FB85
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:07:26 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so557284f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795003645; x=1795608445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wOO7pl4T1V2FI+1ZhOhvGDpiZBHJDeIfIIIzY8CL3HM=;
 b=uXPEHVTNoHblUOJ2SuChqHDrQTJMiAs+ydct8CZD+xrjsZnFxp1ISFURH1roW07phi
 CmgtGghv490dKuFGPZbjqMJw/xy65FlChRdLW0Z+9bTGMnaJUbQcJGuyNOOF4FGyC9Lp
 D4eAOuvhJh94gaTMz4NxsGf2b28j8nZmIANGp6aZemHdhRDhhow5xOsMkuSn5mMaiPh9
 Eh5wsai3QBqAqGSLA2LdPPxX+btja8SOrYNq0a8spyFTf1Lf/ekGbkzAAxj5PVfI/yqU
 +2xMNJ3ll63u9xBMH4uSrfclBGHCXwZoTlxlXonAI8v1r3rZO9X6Hvoviaw4U+zdhcjL
 v4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795003645; x=1795608445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wOO7pl4T1V2FI+1ZhOhvGDpiZBHJDeIfIIIzY8CL3HM=;
 b=L13imiHbPuk6X1tjCTl9S5B07nzZY7zKck1DqZzo8q7gLbWcuCQpck6y71AtZAPdjP
 /3Z0tFPctwOrMemjsJe3yQxvrDzGlSDAs2OkPYlBqewmNDeMm68GOYF9f2bYohTRIq1s
 D85VsnpDqtJnK10lptRq401aB3uZtNBv6dGq0xxHPz7TwnG0pLeBIeIkWaD0xUpwcJhn
 UERmG3RwPD7T+eo8EopXx0Ng+ZFc7S9VNZWytDopMBO6rJnWyIdWH4NfvH6IflekLBuv
 pG4tap1t5rRLGmIc4k7J2Q3PbJvdda18nFbPDiGHyALxdbX7pVj0fzxs25QUaZDH9tMf
 r95Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHW3CaQE6sj/IrGvdT201ssUELNVwXqvduQQGluT/AgGG6FRF/egOGtAcM6+0Bp5HmO4wcdqMBjBmE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9giPlwJjN7yGY4E1wqV3gyzq2xh1t2qPXtayK/o7oMdqUL646F
 02Dc5E83cd2r1dnedxcfugFszD/8CHXVqtqMkuMO9vDsKBoJ7zpVfXgP
X-Gm-Gg: AYBFou2LwkkdnGF79jkKx+EGkfYdFfBALPTZJJ9t9M+JjRHRNe+xpiePgh2CyRBqqP6
 2nEP/8be5KZUCQaU48quCnqx5ogjB/ayeJMD3DdUwjWobFmF0G6kEP9G1Rt6fRkL2DptXfHBUrp
 6KkussaEEpK+1HkJbTx2crX/dy3YfLgkL6kzkaV0/8FqmYaiqk0HW7kAX4CMdsdOshGjkXCqRL2
 WtnwISnJKDcJWMkvd6zz9hTDQBCBnR2/CiuqKZQhTm7bWjHEu8Eh241sDNs52b1Efe9VzWUTH1q
 tW2vgW8CtRZjvxJMhRfhCQBG/kV3IBCbGzq0H7wCe6kezWsPmh1gjY/+McO0lYStZWzpVjXAe27
 TwQjDUGmqozalWjKXnPCIgq4K3nNG2sLJ2sRNjif9pFWcssLvoqbabPYA9IIgTIslNGEAdasC16
 3ChPMORjxeFrCMU8bgTzuuop4j0PQG/hXjK5ggc4IYsiK8E1kh5pxWBeS9QWRnHZnWfVuldnbs7
 g28kDKbdlmGZsvZgAKtNucuDoT+scXUcWEw+i3eOp+JKo4Kx5+7OErcc1T2963Zt/kd5sxiiCWG
 XLP42zgSrTIKLSTE32ktnQDHacOC69LG5B0UshnhuHf3o2WttsO2T8gmPfFclergFmbZ/Njo/Oc
 =
X-Received: by 2002:a05:600c:4e93:b0:4bb:5c92:ce12 with SMTP id
 5b1f17b1804b1-4bb7da12f06mr44646025e9.17.1795003645203; 
 Wed, 18 Nov 2026 04:07:25 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c37fsm4382583f8f.18.2026.11.18.04.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 04:07:24 -0800 (PST)
From: Abdur Rofik <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Ivon Argel <ivonargel13@gmail.com>, Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v2 08/10] arm64: dts: qcom: sm8250-lg-timelm: add SW42902
 touchscreen
Date: Wed, 18 Nov 2026 13:07:12 +0100
Message-Id: <20261118120714.31505-9-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261118120714.31505-1-rofikcoga@gmail.com>
References: <20261118120714.31505-1-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 13:47:08 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Describe the SW42902 touchscreen on GENI I2C13 with its interrupt,
reset, regulator supplies, pinctrl, and native 1080x2460 touch area.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index d307a52cd0e62..be5b894b677bb 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
@@ -101,6 +101,24 @@ vph_pwr: vph-pwr-regulator {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	reg_ts_vcl: regulator-ts-vcl {
+		compatible = "regulator-fixed";
+		regulator-name = "reg_ts_vcl";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pm8150_gpios 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_ts_vdd: regulator-ts-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "reg_ts_vdd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&pm8150_gpios 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &apps_rsc {
@@ -461,6 +479,29 @@ zap-shader {
 	};
 };
 
+&i2c13 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	touchscreen@48 {
+		compatible = "lg,sw42902";
+		reg = <0x48>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <39 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_default>;
+
+		reset-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+		vcl-supply = <&reg_ts_vcl>;
+		vdd-supply = <&reg_ts_vdd>;
+
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <2460>;
+	};
+};
+
 &mdss {
 	status = "okay";
 };
@@ -604,6 +645,13 @@ sdc2_card_det_n: sd-card-det-n-state {
 		drive-strength = <2>;
 		bias-pull-up;
 	};
+
+	ts_int_default: ts-int-default-state {
+		pins = "gpio39";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
 };
 
 &uart12 {
-- 
2.39.5

