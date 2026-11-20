Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B94606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ULmEvuGf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D7710E275;
	Fri, 20 Nov 2026 07:34:49 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDD4610E275
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:34:11 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so5014555e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 23:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795160050; x=1795764850; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kRnaLXMIjjDmMSY6mFAZa1ZXluewGJuLAGDDGmmf4rQ=;
 b=ULmEvuGfHlVIfLFehu4hOZrinkq7oBIylg9uX5UX29FPR24z5DuRCetQK7R/W/lIV9
 mMCrzUd/XJcbIL+q0e4+pICApquVp6vtGJQp8MrovCsCqY11g8qd3RaEjmoIxjnEKlo6
 ig6atK25OPo6HUVOwCXjyeK1xZ9WNv3usTqwm36/rkII+1K0uwhBrMglrVntFmVH1kDf
 dvDr3a8+rIp15KX59we5ty535CNhax5Kl20Jk9XZcJZ0VGtBM23a8eHHU6z8sfZvgUJ3
 fJ3+TUYeuUvm2vOaVxWCvOGL1QeTHnpkd2uHa9ydTFcDxsA4fbTb9aldp5Uxn7QspVv2
 3WBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795160050; x=1795764850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kRnaLXMIjjDmMSY6mFAZa1ZXluewGJuLAGDDGmmf4rQ=;
 b=WoZKSaEg+iAkMboL0RLOMfIPUHh/JPDEbJYJSN/ij+GRIdN3wzPZ01i7be9BxZhH7Q
 MBPGNwtHJWiR+9axQkenPzSvbbc6VeHHY+cJizTfeK/x/MXClnHAIndnjeymLwgfBfYk
 +M/pRoB6TJVkJ/WEif2roYSA38PH6piM1y6jo7HszzHp+XxdE/sOe2qVQgF5eDBESLQu
 cULgvBHUG9yRzy+QIyQHT4TguwUaMrYzP0v/5w7GDFmFjXe92VGHC5kmms3imNg+7BVI
 U7T/euZbSnUl+gNg7aKVxwhEzvIERP7GcbFGcX0mtpnB7yJek916rLGqatASLhHQEOAd
 hUyg==
X-Forwarded-Encrypted: i=1;
 AL+hErFwrsjXKDdSP//rakazhD0oMzquoyj5+qy2M5XxEsqjfcr0Ps5xEv2CAU67HrreMda2FTAJxM2AwPA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9neJjT7gcRFEX8I9CX4x0MY+Ll4MRFgIv+FtyRtauj9cmIKLW1
 63JKEUsbs+dk4bfkZ5Rt8vyvQ6s8OV4OlwKAKDwQ6fJYiT8gec7lGkCl
X-Gm-Gg: AYBFou3HtbwYOpV8gngi7t3ko3CIqgawxU5utfzwkuwG/PJ7KcvAmtfNVdETErpz7MP
 wWkdyVdJvibunf505o+O2m03pJ6JDYjbZAlYLsf6vKab6IBB3zRGo+SM/habJC+wYLqGti8Dc8U
 MNztuVL4f3UXTozJahrllYJtGSa0S2RSftShzU7aywDQThqz/rx/Xg7ztDyALGqscUi4XpSFOF6
 dqrcD0L+yBGK/M9HMoqD8rP+lSIn+VxUYlWJzWCVOoiJ5j5m4/s+cfjty8DGXJ6fxW+a4aIbcx6
 k2EaUd1JhieiDJ/MyM127ygH9jxu15o8qI6ToE+4mPehM9d51aTBRnNl3nvbLworqZFWQdN2OdL
 +QfX/vbmhAXkjXMLpabIBqE06xbtCqPr/jjYwQOjYKe2/ZX4WSL3JDvKbEttyHaI+tHhZOqWJV6
 aU+eJXKH/tUGSUIwNf4er77TXBpv77MbQXVeWR6eyBg9W1EUBXoKss6dMMCQafr7rLUjMaJpOwm
 m/qbDN7uXli115O2MklvR8cvLcn/vRHgxEhQ5uBl1rgkyAeYnv5V2K0C8rIYSLVfZfgHGf4uyAA
 uaRW61EAFE/4p7ictB+Xv2KnIj0M7TrsQSN75s8Ew3t2Po3ABxeLt8jKFvApkqEAiCHs7pZxccs
 =
X-Received: by 2002:a05:600c:5246:b0:4bb:6de4:2f7c with SMTP id
 5b1f17b1804b1-4bb8881c5bdmr46585025e9.20.1795160050056; 
 Thu, 19 Nov 2026 23:34:10 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a3a3dsm54154045e9.10.2026.11.19.23.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 23:34:09 -0800 (PST)
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
Subject: [PATCH v4 09/10] arm64: dts: qcom: sm8250-lg-timelm: enable USB Type-C
Date: Fri, 20 Nov 2026 08:33:57 +0100
Message-Id: <20261120073358.10267-10-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261120073358.10267-1-rofikcoga@gmail.com>
References: <20261120073358.10267-1-rofikcoga@gmail.com>
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

Enable the PM8150B Type-C controller in sink mode with PDO_VAR up to
9V/3A, and connect the OF graph endpoints for USB DWC3 and SuperSpeed
QMP PHY orientation switching.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index 16014df9c087a..2d8b06c05ecc3 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
@@ -9,6 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/usb/pd.h>
 #include "sm8250.dtsi"
 #include "pm8150.dtsi"
 #include "pm8150b.dtsi"
@@ -556,6 +557,44 @@ volume_down_state: volume-down-state {
 	};
 };
 
+&pm8150b_typec {
+	status = "okay";
+
+	vdd-pdphy-supply = <&vreg_l2a_3p1>;
+
+	connector {
+		compatible = "usb-c-connector";
+
+		power-role = "sink";
+		data-role = "device";
+		self-powered;
+
+		op-sink-microwatt = <15000000>;
+		sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+			     PDO_VAR(5000, 9000, 3000)>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				pm8150b_hs_in: endpoint {
+					remote-endpoint = <&usb_1_dwc3_hs_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				pm8150b_typec_mux: endpoint {
+					remote-endpoint = <&usb_1_qmpphy_out>;
+				};
+			};
+		};
+	};
+};
 &pon_pwrkey {
 	status = "okay";
 };
@@ -660,6 +699,10 @@ &usb_1_dwc3 {
 	dr_mode = "peripheral";
 };
 
+&usb_1_dwc3_hs_out {
+	remote-endpoint = <&pm8150b_hs_in>;
+};
+
 &usb_1_hsphy {
 	status = "okay";
 
@@ -674,3 +717,7 @@ &usb_1_qmpphy {
 	vdda-phy-supply = <&vreg_l18a_0p9>;
 	vdda-pll-supply = <&vreg_l9a_1p2>;
 };
+
+&usb_1_qmpphy_out {
+	remote-endpoint = <&pm8150b_typec_mux>;
+};
-- 
2.39.5

