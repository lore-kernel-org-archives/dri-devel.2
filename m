Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6703606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tcyI7SSC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FDEC112636;
	Thu, 19 Nov 2026 16:55:16 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD4B811264A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:54:33 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4a33359c1b3so1819975f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795107272; x=1795712072; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F0J2OIIkJQaAc8JC0X1XpyF+PM+4498+YyFt2tkAI9I=;
 b=tcyI7SSCsJyKgajhdM8aKTFdaAlNZSevbUF5UaM0FyFYDFrXvKLHs5hbflFtuRlaPx
 GNREwP82Kk6lL9AhyqyJJI9/cxdx2MbLa/NI6ebj6UL7I90OdxCRwW+YqpPRVbIEk+GT
 jRvjFHr91y30Xar0mZg8YNWFvQTozxwbOGVnBOK70kaVG+z2oTgeSSTBwTsca3roM49u
 nf1xjXDxE1/4TQVMTDLvkUxVvNf/FuYVlU8IlaYvxKNfDdZSBSQLI3PgIV+I/wgsn+Tk
 5KD/kdz3gKWWvzU5xhgqdbdWp0BJXdSIC0Mx6UC5KJbmb0DReMHC89kI3rxjMCQCOKfq
 IFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795107272; x=1795712072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F0J2OIIkJQaAc8JC0X1XpyF+PM+4498+YyFt2tkAI9I=;
 b=x3YteqJR5rRiZDXO4KDrmMFZLaRvZ2yFy/CUzL8Jy0ACswYkRNL5SuXAWLvcRS3GtE
 l9zlMQIe5ZTro4DkEj++0L0K0T7YCe+J7RD7zetp5xPjMev4kWbRai/olMpEBex4z45C
 OponB+YzGdnvb5xOanRXTYw+TCQtLHahhKjBK7jMdt02YbrOvCN3AIdrD6W0wKBYGBrx
 +48jDO0NKuDTl8d7tu9rhiscstjooJDukf9/UWfukdgr3H4CK3OGyyvHhgrr6a3bQXQn
 thzWIPl9r3YvrnSUDeiSZxNwGlIDk9SM/7Ct2uC2NmYVEe43k2lxs19DdHEUk0OrUuze
 Q4Qg==
X-Forwarded-Encrypted: i=1;
 AL+hErGZuMU9AjN77StCSs2x1UL9QNzAI+zCn1UmkSN+QXnlDV0coOJ83Fqias2hgEDFjwgu2IbRZB0ovjs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/l+2/kzL3K8+gJKEwAIBumoYWSh0gFoPqgbd+C6iQLgfs/hSGZ
 WByxY94HPr6Y9exraIe+9Bu99TdoOzuzrV8Fk5I0eEgIO3jd60G63TdB
X-Gm-Gg: AYBFou2UuGj9XyxdQ5Ck25fJsBB+eFO8Y3ZHIsCXYJUQm1vJxYLfNfloRvDslZJizrL
 AABdWBfvWIWR9VctbVSNuhx7Os8hb2oeCd5Te80nHF8wziztSWngxY06sJMQyyus7TwRPqmBonp
 gw6ZTNpvMr/VKjk2vXwijEwKgoo/t8f2tQ32fdboDAWQjwMVf9wHAu3DvctdSBUiWRKWITHt0s5
 AYy2UihGmxQqLeW70q//49948m/q+9n8bCpxhzsJP97VJoeA62bxgzU9asV4i6CPsEEz061NPOj
 40PLxIUrbcZgkizq6mXwvif9E5J3qacC1IIb6CwVHX6QR1kq4oBhEswKM+JK1OE1rzZmp+L47bm
 IQp+sg+0SyISbk0epIgEgBpZhEBVhvuAobUskornas5ybK9Ex8zS84ss6ZAzZm/r96TfXzVFxCw
 6n+xyraa0FjerChrkOy9m14uoJTgK11RJ79tpgs5PI8AfaFnomGhfi/OPCeqS9bKKC16t/nYrJV
 qjEaR1fWrIB9BSwRzG71patY13IUxKUd9YYjlFSrhmhs8yjl7J6VZ+eA3GQWWJ5sUZddG/tYX3b
 Yxsgi06H/X0JQIsmpVOgWB6tffYuSEKlgPK9Nyys+gQofjX0ecnLnX/juj/QPlWzTD9kYi1E8dA
 =
X-Received: by 2002:a05:600c:5303:b0:4ba:495c:2f5d with SMTP id
 5b1f17b1804b1-4bb8880767amr1755525e9.9.1795107271789; 
 Thu, 19 Nov 2026 08:54:31 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88402ce9sm9894555e9.0.2026.11.19.08.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:54:31 -0800 (PST)
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
Subject: [PATCH v3 08/10] arm64: dts: qcom: sm8250-lg-timelm: add SW42902
 touchscreen
Date: Thu, 19 Nov 2026 17:54:18 +0100
Message-Id: <20261119165420.24466-9-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261119165420.24466-1-rofikcoga@gmail.com>
References: <20261119165420.24466-1-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 59d6c1518a469..160b6f4c98b17 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
@@ -107,6 +107,24 @@ vph_pwr: vph-pwr-regulator {
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
@@ -461,6 +479,29 @@ &gpu_zap_shader {
 	firmware-name = "qcom/sm8250/LG/timelm/a650_zap.mbn";
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
@@ -580,6 +621,13 @@ sdc2_card_det_n: sd-card-det-n-state {
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

