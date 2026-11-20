Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE771606C887
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z49O4+HG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 133C4112B0D;
	Fri, 20 Nov 2026 15:55:51 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09FEC10E914
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 15:55:02 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so10655765e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795190100; x=1795794900; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Woi1KVVkXXGab1Y1GMu8DNbprDgDmJk8VMTl2ZFXeN4=;
 b=Z49O4+HGNFMW1lF5V2C8Be3rjn8ljUL5JO29Gz6UBRD6+vafgcbkVotEGmHiUyGTF3
 X9wdyGl/AmcEMnPpeZRILEVdL/Ao4iw22ahHqB7e7Y4KsipbmSJteqqOfFMJtGpn/zyr
 F7mwlHWX5m3FxCJuwSWmmn0oEwi8mynSv7z+QMF/bR4YB9gwQvX/1KQjSRwtbdutHMgS
 jQX+/DhUub5FgwEAo9wNT1eb1vcadYi0XboCPilW9p2AhtY4up0mJeX91/bHnioMXE9U
 YK7gsxsqwPeW5GtgAruLIfHYWCwzD+jlg1nr2Ed9plfxX98MXkQRlGvHliOwQowW/+f9
 6tyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795190100; x=1795794900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Woi1KVVkXXGab1Y1GMu8DNbprDgDmJk8VMTl2ZFXeN4=;
 b=bW22mdPkYfI+2wQmzABYym33taFAJxj1LDOOwophpwHRDWP2RbiJ8YoJw30jhyz1bp
 KynLcCP+P9UlIznLL+YF8dEK5stmg0SO+sPQ0Yt/zSq8vmRPuN6Ob57krxBzT3FqK3CB
 JQVsb3BPpTBQM6BDoqDjNhgep3V+6PwNOZ3nwWxsltZ9v8+5sIWalMoi833NFKR39TiQ
 jHY98Vgy4tDo0UpHc+Zd8ooSHrI+LqwngoXxXEwNzMoTbnuMO2DNNs70ZARSaxUBoB23
 d0Myv78hUgWYoNMQS74inufzH/VSi6Ne1OG9NP6C2/AX06ARwg5WSw07kIk9GI/sM+Qp
 HBGg==
X-Forwarded-Encrypted: i=1;
 AL+hErF+k3Yes3LL0IrfgFfOqg38RheNElQptcTWH/HRXUlEMwcbBEVeQbRrj6FPZAFibi1gJhWbbBnDXLk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9JtBC2PmPCYiET8H0O17KjKA8awXu9qFau11DZo1x73IXJ+YKC
 9ibD7HnwBfqdulMpepPiB4mYYMv+fybm7eexbEEBnYyuyXNQYJ6za8e9
X-Gm-Gg: AYBFou0REXIJi3IG4qJbTmJocCpSxcrBnjHR/QUErqRfcq4978BS+na5VDfBHoZviGe
 SpmyPrp7rNxTUbot2xhlypxXJ7QEyU5KzEW1RR6OEl+ZLoqV6KX3t9VwUhNiBVGWTj77nnPha7n
 gFpVwgcr3pqXtxeszvmNFb3fv9oYKVyp5Uh9MsmzJRx9ZTMyhLaGPBAM+IN4B7smz+ALfoyR0sX
 Jt8XAn0VncGQTTGTseenAzI8bP3LIr5jj2p52LNsmQRnJabtsct+3IaefgrAzxxJTMzTjtMPimf
 ympMoXGVn8UcEL9y0PkT7FEJaz/KpJA/a346O/aFNfG4wEiJVzPKp7uXJdVB42K6vNuYUpFkK41
 VMNUkGwN+4zvmYv+wsK0xbFy+jB4xifaRC1BElK/rq1EzoXAl3+HC08q1pdjmlMxH/yFFn4RhvG
 PPJQ0DsZqWXkftCEfyeaqatX52/Cl++Q1+WyBYraShU9s81urKI2ZlHsj1v1IKgvVIfOl5yopgl
 Q6yT5ObfPCv5Bka+6P5AAwNL5Lo4PIPyekPMDXQZboQ+fpTk2vl1AYB27qbCujdBcu2DIS2AF+i
 daIiozVFExCWGx1DzWnNNswxJgmT3ACEFosSmaqHdROYCM02r/WhGGCLDhPrwUEnGNhvvZ74gaE
 =
X-Received: by 2002:a05:600c:a085:b0:4a2:a9:ed87 with SMTP id
 5b1f17b1804b1-4bb88811c75mr88092485e9.19.1795190100244; 
 Fri, 20 Nov 2026 07:55:00 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm83982635e9.9.2026.11.20.07.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:54:59 -0800 (PST)
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
 Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v5 08/10] arm64: dts: qcom: sm8250-lg-timelm: add SW42902
 touchscreen
Date: Fri, 20 Nov 2026 16:54:47 +0100
Message-Id: <20261120155450.7719-9-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261120155450.7719-1-rofikcoga@gmail.com>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
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
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index 709cf9674e2d4..6f00495d42467 100644
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
@@ -461,6 +479,28 @@ &gpu_zap_shader {
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
+		interrupts-extended = <&tlmm 39 IRQ_TYPE_LEVEL_LOW>;
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
@@ -580,6 +620,13 @@ sdc2_card_det_n: sd-card-det-n-state {
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

