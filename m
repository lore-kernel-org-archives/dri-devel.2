Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225C760A2600
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GeXSOlQ5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D784C112AFC;
	Fri, 20 Nov 2026 15:55:31 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0850510E91A
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 15:55:03 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so9457385e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795190101; x=1795794901; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=grKFuqlZy/vF+EZ9KT+ynP4RyPsh8Pe65v03F3LVnyg=;
 b=GeXSOlQ5UygDWUUkZEYve+p9XpJcAIasgAfrriPatbAGbsWFg03rdaWpZa/iO8Nvu/
 hnulwkBNvnRyO/JZBVwhqb5iRTM/j12AnKcVBi6ECGWDnHEshHx3+YfpYOGBB+JZh6UD
 CM7hiOoh5ybHkEOrXB6IhMHY8ih0KssLxgJsgAscciSnuBzFoisZ/87Ky364uWzSzRYy
 9coEDSA8a2mQF5kDuJPPgGogsf+S1fzOWVnfEaq7pBxX/2PGhSn12hdvyT95LWjnEQiP
 idwudziea0SWau6MiGl3FyMyD/WtfeUc0S8qHcyyi8ZelQRJNC0RpiSAszFBWd/ZNyw+
 IRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795190101; x=1795794901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=grKFuqlZy/vF+EZ9KT+ynP4RyPsh8Pe65v03F3LVnyg=;
 b=XA+yVvIv5ozaZsCHeUTqQQUkfZSRFDIsCzudKPuE9IhEVrPUIOF6Xpkxo1coy+BCyZ
 LcP0hK6xohkbS3K9qxveFcrxHxR6LswM+U+mr6PXaLCDp/xuIOuBXNX4ZikiTrPdiwth
 YFV0s3wIW7b/gMGzagrXN+PFedp3m/zo1CS8WOdiIuv9Gp3aqNPEKvvH3ug5McbGQCdC
 hfU0IY5HHn8Hfx1WMGLvLnz5L271aU8fEuyedHYwQ7tv5o1+qVg/v1ICbx0eC7dwODe8
 dYMYi6JJvrfI6QtmVblI1kxe5qN8yHnhFjWeCsHqLLmgigLa4pI0ADSILj4YeFc+Qeaz
 iyhA==
X-Forwarded-Encrypted: i=1;
 AL+hErGyttzCFaqyxWsqIQOmI1uYDRR9ZUSoKigSq386TjQhPD3OfP+s3Huxv/UZCIMb5zTIs0g83+mYJKE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z824UJnuo4JBjKUZWYxAXOgbTg5tgt8YIx9e1HYRSIWDRw2fs2D
 7Gf8rcKQBtsWnkNuDnJX2lOjGAy08/AHz0YgA1Y6+5yhka4scdoD9XA+L/Hq0pkd4+k=
X-Gm-Gg: AYBFou19EPv1AQOOwUFPcv3tkjBLSPn4Lu+YFXDVbtBqZXryne09Ahwyej0sW7PR5Ri
 qjpgq3swMquxGMdLHGoYps13oMkeL55VxKdedY11i9PJNWy2LAVUYzs6RcVhUGdxZsoDCo3ZMHy
 firNjdPOysrlClE6lsmRKl/FJmacJDFj6KhoulSouPdntxvzBzspKD+rVFidYjUoT+U85ScAOmg
 n7f0hQxUv445PnSZlj3rN9r/xCCI2gfW4XkXQBKvhm7sQhOqmIdZfsomhSvT9HjuolFrpbzozDI
 1AbCoEW31mSauxhmI9A4L0Jt6WD9CLGVAxal4TEjXt283Vn4s4cozPNMeM6Gf5U0VzfXaz/IWQ+
 gOXZs5NJATDFealtuq+PC6O/w2dZGb2hzj1fIT+lnXkeTQh1LLotIzElG4XJzYj1owP4PCcuIZT
 LlGugI5dA8ZDDI0Bops00yG5lrfFE4tANYZkMrHspVAD29HZbhm/AJSBfnI9fzg6wiKTFgBZdeF
 3g+BNGlUm8fgRrD+QlVxOqktkQEjdBxGJA+D1zERs+QkuZZrdtupdh5ayTV9L0D1c42raRlvBKC
 SwjMeJR6HabVLanIwCuHdFIPR0YtuWoGTG21IHno7JNexx0bvkiXNe1T/VpL7h9WR+8FTXlTyao
 =
X-Received: by 2002:a05:600c:3e0e:b0:4bb:6a5a:783d with SMTP id
 5b1f17b1804b1-4bb88929c63mr74999345e9.18.1795190101297; 
 Fri, 20 Nov 2026 07:55:01 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm83982635e9.9.2026.11.20.07.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:55:00 -0800 (PST)
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
Subject: [PATCH v5 09/10] arm64: dts: qcom: sm8250-lg-timelm: enable USB Type-C
Date: Fri, 20 Nov 2026 16:54:48 +0100
Message-Id: <20261120155450.7719-10-rofikcoga@gmail.com>
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

Enable the PM8150B Type-C controller in sink mode with PDO_VAR up to
9V/3A, and connect the OF graph endpoints for USB DWC3 and SuperSpeed
QMP PHY orientation switching.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index 6f00495d42467..16ed6b3871374 100644
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
@@ -555,6 +556,44 @@ volume_down_state: volume-down-state {
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
@@ -659,6 +698,10 @@ &usb_1_dwc3 {
 	dr_mode = "peripheral";
 };
 
+&usb_1_dwc3_hs_out {
+	remote-endpoint = <&pm8150b_hs_in>;
+};
+
 &usb_1_hsphy {
 	status = "okay";
 
@@ -673,3 +716,7 @@ &usb_1_qmpphy {
 	vdda-phy-supply = <&vreg_l18a_0p9>;
 	vdda-pll-supply = <&vreg_l9a_1p2>;
 };
+
+&usb_1_qmpphy_out {
+	remote-endpoint = <&pm8150b_typec_mux>;
+};
-- 
2.39.5

