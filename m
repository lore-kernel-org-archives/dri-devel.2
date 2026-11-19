Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08AE606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xRzXSAXX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F85112650;
	Thu, 19 Nov 2026 16:54:48 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB1211256C
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:54:34 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so23650055e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795107273; x=1795712073; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8HAdjmJFS/vSTReOhqoIJm4R7O9SEUoXAZM3wxNxKGg=;
 b=xRzXSAXXCAyyd0hcDBRDzcKNgO8tLY98Fb7hthTUpjM2PSOcB21vEcNMhnFaCOtN01
 W/PVcTMnGScwvUsZdymZ0sywGA4EQlZV1Q0TBIoIlwkVkjRW0w+EYjIwdJ4+Tdye0hwl
 atmJyoDTDK5mbRo5K9gOVt/HSsR3bne4aGn7nIieCSAu2q7rsa564OQylzZq25RFUT2Q
 yAFeaQJ2G6cRc0+dDj1wE2+n8/ntMOEdlMl4aaAIyzsnRRc3FJgEPW4lFM888AdIPgLA
 5NywWY+4AnL5iHcrhYkrIwjU5oUEo7N47HIja1K/+veRoAmUVt1j/v497Sv6bmF3Id4B
 pPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795107273; x=1795712073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8HAdjmJFS/vSTReOhqoIJm4R7O9SEUoXAZM3wxNxKGg=;
 b=ygarj5Ts4PY3uS5W7tk8XFsZftFyp/fbKFJhh5nqXpI67EaDLUV1yCGKJRBUxArViS
 3+YqVG3prYppvQM3sau7yIbYGHpq8rzvabo963F+cQoMoSBGYLakE8Rkpdss+/ZOl0XR
 y25IAur4ViJx8Agr05jHpBj484qWLGirHZW7AMKuSh001089DNsu81An2iW8rI3Nnzi8
 NYg0qRv5m9lF63xUNyJhJsq9W+4U7xTbuFKbdcJj5Z0FXm/UdvQx2EEWO4pT50WAIyOU
 qZ4SrdJbOdOE6tJ9G3nKzqNiG5V31r/hoJ22QiC6uqj8mAbKaC/T73CWrSZmxeCGaZgl
 qezQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEwIVCui82LPpw9W78qo0tRcVz+YmvxI482st+KIPXUu6F25a+aIRMApsOeAJkDHfWq2wYGNGz3xac=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+6W65yxLsoKtXzhxKsCS3SLeBT/wYKB/4xLIkf/KsHkKGVnRw7
 55fGWtWj1RTWd09SFD1pp39Znr0AQbVlz09izQTYxl2ZA4SvPfxfCUUj
X-Gm-Gg: AYBFou0zzTeM3FPB6Txj8o2xZi7GhEWjdkgyDTPIpcN/Rnu/r4j+5Stju8SWv7U7PYf
 BApBleZ3SGH3rxkkrp5BA35rWV67Iigo55WKyXl8ofWUN/WoYqkWFCDzqc2D2Mn7oD9dK/sEKiv
 +oF+PmPcJURxHlc2ern2+zoaAHGWFYWAl57rixJRfdEysclQxKeJHXvUO+CNESJ0CH5hJB+A2u8
 JuO2wFYVHMaVCqg2ovZVxHGmtGs3KrjNOOdXVi/h31HDSEXC1qzCZsrRALw7Gi+FiB8dVTdJB8H
 bx0umtG4VvsM87JhFkdbiE7MS0xh9o0JJkD920ykrqJHQBwmCsSO3/NaPXpfV6s/rjiGY/FlR4P
 ez0qSSuN1QFxZO6OgcZIn09D5Jpx4L4knmrtHnAr8RMgdXIqY+26BZLuxT6vGkKPcoRap6duzsI
 ikX8IGwrO3DcBRj9zUARZjjP3AjQ8yzmzIg8qW+BAo/+zDu8jN6iIRGvvLa4uG/69kCuOZC3kW2
 Fwiov90emqvA/ZfqbacSzvWhx10ixdaPsjAQotLAu9YUrPSJ7m6Eusfir/d3FOEtHw8rFnidfif
 TQTLxU2Pjo1npI7pMHK0xpTA/RXT2a3+/dE1obuvbUJd6082a5CLevbwFSn7aHsPLtbhWNCYC20
 8
X-Received: by 2002:a05:600c:8b11:b0:4a1:dda8:eb73 with SMTP id
 5b1f17b1804b1-4bb8881c630mr1984605e9.27.1795107272825; 
 Thu, 19 Nov 2026 08:54:32 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88402ce9sm9894555e9.0.2026.11.19.08.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:54:32 -0800 (PST)
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
Subject: [PATCH v3 09/10] arm64: dts: qcom: sm8250-lg-timelm: enable USB Type-C
Date: Thu, 19 Nov 2026 17:54:19 +0100
Message-Id: <20261119165420.24466-10-rofikcoga@gmail.com>
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

Enable the PM8150B Type-C controller in sink mode with PDO_VAR up to
9V/3A, and connect the OF graph endpoints for USB DWC3 and SuperSpeed
QMP PHY orientation switching.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index 160b6f4c98b17..3ce8161574a95 100644
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

