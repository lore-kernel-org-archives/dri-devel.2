Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A794606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zEQ6IX/r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26FED10FCD4;
	Wed, 18 Nov 2026 13:47:18 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0AF510FB8E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:07:27 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4a33359c1b3so562514f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795003646; x=1795608446; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=167OHAGXM6J7PJAqZ3MLk9kxvb+fEinCgbUkehm0fFo=;
 b=zEQ6IX/rjUQGiwYzORj4BJ3Zf2OsVydBdt2HfV8UxtCRVygSn+N2CRQYLxkgmgpsW0
 3z4RtnZb7HGf1+yR/Df0ieSAFVhqaCKWIdEmEmQgRN1G2bFo+MRR32cnG4IkcYEzqLcq
 K812JGIJqsa/FBzyEsedrqGnJ80bpET7IxiXUBAxcKXkbE8Cskdui3l9fJLwEN9oUpR5
 IsUO2FbSs1e2GfBV7fDIMg7LVG9TpZnAoNHrtowSytd0g25DCqOXl/CWtjeZhDhoBJET
 LWS1ODnjcLzmQ/uZ8TYK57qQcU12fLd3Dg/ewIUp295LatiVkcVwmFmDEQi74xfaT1JT
 tNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795003646; x=1795608446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=167OHAGXM6J7PJAqZ3MLk9kxvb+fEinCgbUkehm0fFo=;
 b=nDVxWhTvSX3FOCVinyb5JRojQmuXaDiYL2g92myUvhQ2bp5tGX18afEtvqkY6VWHSk
 SR80geXdUsyhZIN8BoyEp0baCSt+VpilLrcLGf8E1Rrcy2NHiR67gGUOXCNIyO+gJkQA
 hq39JaEzrS5SigP8p/DXTpoSgJV1SNF9AR3nEzN1eM5sfgssjxkK9fMLtpHCNIrkSNvc
 vcF3Hsk2iNvypoi1Iw0dp9qbQYmQwjoaJGATeLFX8GdbVYIE3C6hHrqkJUSRGcuBvGnk
 xrjTR2tsd4plYnI9EGlF1entl0tQtBnCtIqTZVqfdCqVU8bSNqVd7+HwrbCvOIDMQQKV
 wx8A==
X-Forwarded-Encrypted: i=1;
 AL+hErEZHl1jJMv/1wFIjAKjWBbX8e6tpY45uysQObzmHjbNaV4HGT15TX5GL6lOkfmCWpWWsx7kEJ4bbX8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9pkV5YhspS5VzKf2dFgK61bi/4TDOcu9BJoZYvuA5rrXqH8fzW
 Lqa9fT/w9488ovMvgpvzJOTZHZPzSSMRVD6Y+p8WvPmyobTPK0wuo+jn
X-Gm-Gg: AZFdTZeEfN04MxjiXiB3utEYzESGbSOY3olfTNYWDBV1mVe22rsf7+RpJhd7Bsx8qOK
 4GOcErC36Pecr1APSdQEJqlWYaS7bXkLGVdXRmKfiZ656tDTWPyY53UKXUPiCpSlwHd/vmWp4HK
 Tnage99YQEGNbMbkJPOvPOP1ApvkQhX6wPFyATzy9Kv0O+WFMRUfHsoSuPs5vFDPeoCaPWj/wbY
 qzYc1rOi0PccobIKCMGjamIVGmgWLjvVP4YAxhnTGsrVCCFzGLR9ZFKYakt5BDN07SjP1QbpPfO
 ELW1ZiJlYu8hUjDRQU8wej3Co+ad/YWJcq45awlNCzyGm0x497wek8bbszEBkfk3yStCtJ5wujs
 1KrNR1tixgMFeGHPYqFlGmvE9G1pOyljbf+z0Wa5Yqk3Pyttj7GWb6p5wdKKkGVvNI5PyS4XL1B
 tPfpIQ+dGEbuui8tvmoUDu5Fvt5H6R+KCcZm/BXzOkOLNvdkVQnA11OWQv30NBxMkEZnep3BA15
 By5nO1oPe8ZRZIuC1xm4eBJj2Um6YEvZcHbJksjbuxpZmSZoA+6U1D5GDnLXpxnAdnGUS1zPAQF
 H5vs2/pEpLm5FECiGeKYsBLOcEnVKlSDFT06cuvchUWwsCjSRnPiDvGCKsXGoGQM/L9Cz0CHWja
 bZ+KIfGM5pRxm4b49OsUh
X-Received: by 2002:a05:6000:1606:b0:48e:6f84:2e8e with SMTP id
 ffacd0b85a97d-4a63e6f1a49mr3049066f8f.39.1795003646222; 
 Wed, 18 Nov 2026 04:07:26 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c37fsm4382583f8f.18.2026.11.18.04.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 04:07:25 -0800 (PST)
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
Subject: [PATCH v2 09/10] arm64: dts: qcom: sm8250-lg-timelm: enable USB Type-C
Date: Wed, 18 Nov 2026 13:07:13 +0100
Message-Id: <20261118120714.31505-10-rofikcoga@gmail.com>
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

Enable the PM8150B Type-C controller in sink mode with PDO_VAR up to
9V/3A, and connect the OF graph endpoints for USB DWC3 and SuperSpeed
QMP PHY orientation switching.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index be5b894b677bb..12ca5ea921fff 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
@@ -10,6 +10,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/usb/pd.h>
 #include "sm8250.dtsi"
 #include "pm8150.dtsi"
 #include "pm8150b.dtsi"
@@ -556,6 +557,45 @@ volume_down_state: volume-down-state {
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
+
 &pon {
 	status = "okay";
 };
@@ -684,6 +724,10 @@ &usb_1_dwc3 {
 	dr_mode = "peripheral";
 };
 
+&usb_1_dwc3_hs_out {
+	remote-endpoint = <&pm8150b_hs_in>;
+};
+
 &usb_1_hsphy {
 	status = "okay";
 
@@ -698,3 +742,7 @@ &usb_1_qmpphy {
 	vdda-phy-supply = <&vreg_l18a_0p9>;
 	vdda-pll-supply = <&vreg_l9a_1p2>;
 };
+
+&usb_1_qmpphy_out {
+	remote-endpoint = <&pm8150b_typec_mux>;
+};
-- 
2.39.5

