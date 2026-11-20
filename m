Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C86606A333
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hzn+HON8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1489710E91A;
	Fri, 20 Nov 2026 15:55:31 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 044E810E93A
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 15:55:04 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so8361785e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795190102; x=1795794902; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xs8qsWr3WzXXJQ7Iw3lOFiXdEVTvIvytDHijgZN3pu0=;
 b=hzn+HON8LPmEPrEvFVMQGSxzzVfGNGeww4+gUnaXP8LzQlpMFuVp+ZDfZumplDmQuH
 ZM0aik4RTyc4pk57BOAfjrh2rehCU7C/oIkx2A7O2JDyo4STKtMDwF6LhWgTNzREUadZ
 tZr2fH6HRogRgR22Tq4xTTCjSvRFbxX9N/DnVM0vA5IdoyL1C2uDuGMzwv6KtbmRzaHH
 nQmpLungqslZ297IB18396OYKLUHF4Z1hh79vfquhZeqfX1U7pj6ynOEAZTZAhQmFHQR
 KwIazQw1IxNobIwpTsBy58hUP83IqePUVvtDuEzBX0lGZ8AELXSsk5EP6TMxmXHNPYiq
 aXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795190102; x=1795794902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xs8qsWr3WzXXJQ7Iw3lOFiXdEVTvIvytDHijgZN3pu0=;
 b=hYm5e22GuzjLtOTw3pzpO5uqAiFtER/J/Bjs0lu/IkuLVby7KG8/2eBQa3Fw7Cf+za
 fy+eJaYbf+SYsI8vcgjRpTAZaX/3skE5dFEbS8swJpy04MHGn5RrfhQ8JFHcOMqTNdY3
 Gm10NtMshBQNv+qsJflkpZyspMRuRHw0vS4NXRhVp8lug3LTjI8SgPrNakpcPZx+MsNy
 W5jNB58qTBe1SdYkTILQ3BrufhEAWAFSVHShXOfav7A/BgbBMB5aPhmkEyoPoxGkyevV
 hv0nhdpUght7LXBMsKNOKTzmndUyeBYT+UQwH4QIqAjxWWQqvjDVLyFk9wMHoq00TXTI
 YI2A==
X-Forwarded-Encrypted: i=1;
 AL+hErFnMhaIIBV/0yj0DPDekFyKEO2sCuYGWUAsdeE3q47zGvooC9vd172fSxwA8AvB51Pzr58pmFwbRtw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9fkLygKY5CFEVtUooADccOKAuKByw2guMjuROhzRqWItFd8vvV
 Qb1N0yxs1FTokv0Bru0NFmPPTLd0J9bq5o9RPTjUghtVnb6CRM/EsIeZ
X-Gm-Gg: AYBFou1AcLHt4BmQaHdve2gypOeFO6B2rz/IgEdVmy1NNnaHsarfSm1YSs6EPKtQ4W4
 RtRE3Wqu2IKzXfJ+0Dpeu9sjjohyZ5JPtB6RrMq4+ZiOTiTbxw6azgfazd+Z4Ntn2U8kFwNbfA7
 KGrqC3XXcF42U323iasA9QLbnmNAYC7+f1rXH2IRsmW8awR7H23SK1SWTkK0bQ4ERhcGkn5IZhP
 pTI8mvtcWIZMzh5EanY6DdhynZpfABI5BSwSPEs3s+Aknn3C/J6DCUnGFAvyOll5K9B7oHjUQC5
 HngoaYMT0v8ohDooYmB2lyZMFK9VcLie7PdGtjaHGYy0GT5ZwjxSMxTMcA1hGCzNLf86hmyAbQr
 sjeVCXXJYV2EcOeAP0/5lMfo+tx8DGeFVbObvh2LGcSIgbkCG/q6fhGcw2HxfHk33NP/sCx9xxS
 r9yQDx5RD+601T2+GNgOuf2rgImqp3nUe3eBvaS+ZfUUMR7VA0VbserWfP3jeUZgKPhSmf7Qb0G
 ssTv0ZktLy4SAW12iQbVVfz1ZxlROvhXSFoyrKtsa3d+ivP9Od0iwP/ud+3kfZa8Tjpvav9Qe/5
 Its28t3tYGndPLmdHK7ub1022+rCDXbx8ad7PlV3e0hbvadL4wVTTLDJ7wEVuRcZysKrYD1C+do
 =
X-Received: by 2002:a05:600c:1d8c:b0:4bb:5345:606b with SMTP id
 5b1f17b1804b1-4bb8882358dmr81647945e9.31.1795190102271; 
 Fri, 20 Nov 2026 07:55:02 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm83982635e9.9.2026.11.20.07.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:55:01 -0800 (PST)
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
Subject: [PATCH v5 10/10] arm64: dts: qcom: sm8250-lg-timelm: add QCA6390
 Bluetooth
Date: Fri, 20 Nov 2026 16:54:49 +0100
Message-Id: <20261120155450.7719-11-rofikcoga@gmail.com>
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

Describe the QCA6390 power sequencer with properly voltaged supplies
and enable Bluetooth HCI on GENI UART6.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index 16ed6b3871374..66cc2a0a57124 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
@@ -65,6 +65,67 @@ key-assistant {
 		};
 	};
 
+	qca6390-pmu {
+		compatible = "qcom,qca6390-pmu";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_en_state>, <&wlan_en_state>;
+
+		vddaon-supply = <&vreg_s6a_0p95>;
+		vddpmu-supply = <&vreg_s6a_0p95>;
+		vddrfa0p95-supply = <&vreg_s6a_0p95>;
+		vddrfa1p3-supply = <&vreg_s8c_1p35>;
+		vddrfa1p9-supply = <&vreg_s5a_1p9>;
+		vddpcie1p3-supply = <&vreg_s8c_1p35>;
+		vddpcie1p9-supply = <&vreg_s5a_1p9>;
+		vddio-supply = <&vreg_s4a_1p8>;
+
+		wlan-enable-gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
+		bt-enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
+
+		regulators {
+			vreg_pmu_rfa_cmn: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn";
+			};
+
+			vreg_pmu_aon_0p59: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p59";
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator-name = "vreg_pmu_wlcx_0p8";
+			};
+
+			vreg_pmu_wlmx_0p85: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p85";
+			};
+
+			vreg_pmu_btcmx_0p85: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p85";
+			};
+
+			vreg_pmu_rfa_0p8: ldo5 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+			};
+
+			vreg_pmu_rfa_1p2: ldo6 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+			};
+
+			vreg_pmu_rfa_1p7: ldo7 {
+				regulator-name = "vreg_pmu_rfa_1p7";
+			};
+
+			vreg_pmu_pcie_0p9: ldo8 {
+				regulator-name = "vreg_pmu_pcie_0p9";
+			};
+
+			vreg_pmu_pcie_1p8: ldo9 {
+				regulator-name = "vreg_pmu_pcie_1p8";
+			};
+		};
+	};
+
 	reserved-memory {
 		res_xbl_uefi_log_region: memory@80880000 {
 			reg = <0x0 0x80880000 0x0 0x14000>;
@@ -633,6 +694,14 @@ &sdhc_2 {
 &tlmm {
 	gpio-reserved-ranges = <40 4>, <52 4>;
 
+	bt_en_state: bt-enable-state {
+		pins = "gpio21";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
 	sdc2_default_state: sdc2-default-state {
 		clk-pins {
 			pins = "sdc2_clk";
@@ -666,6 +735,29 @@ ts_int_default: ts-int-default-state {
 		drive-strength = <8>;
 		bias-pull-up;
 	};
+
+	wlan_en_state: wlan-enable-state {
+		pins = "gpio20";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-pull-up;
+		output-low;
+	};
+};
+
+&uart6 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,qca6390-bt";
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
+	};
 };
 
 &uart12 {
-- 
2.39.5

