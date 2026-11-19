Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89AC606A334
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R9+S7bIr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AEB1112651;
	Thu, 19 Nov 2026 16:54:48 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F791112636
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:54:35 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so18876965e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795107274; x=1795712074; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eWJ+9K9CujW+/eiSnl3KVXLfbSNQleY4XU8YoN4v9sc=;
 b=R9+S7bIrxmnb4oM9FSpRd21IQcmhZcDblOijdUUS0j6zQar8cB22i1Sn1a5V/K4XYZ
 Jzmh6Tw89jIU+wQvcpB2bWXsZ6uFUtY+kWVAqukPDDacbw1BEiq776XlFZWVjxkrQ1br
 +9F9lt418WVSspBm9AMNWLb2UnE4Zv47RZW2MiHlSQu1G3BMXcIvBnbOr1usSGtGkUx0
 EwKAOVqRSBjdgH4ZBaAXLGgAeLJEU1Pl09ELqBl7IxeOOcfjb8PVAScIhQgo4Niad0hp
 UP7Pl0lr7rRwc3Bxz30AFPsBsKuVHj9m5/JjXeRLzFJKEe7kDhc+Y0kxz9wOdOo2JLtO
 j8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795107274; x=1795712074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eWJ+9K9CujW+/eiSnl3KVXLfbSNQleY4XU8YoN4v9sc=;
 b=DVJDf9Nf7FTXke+t0QZnFpn1H5ieqGqHU35jNgFRy/7OChbe4eKi+mlud1FByvJghb
 bUjoUrorQN757LdqcC6VSB+oegzcWGxCoF+ojqz0tZ6ytw9Z3+uB0BWy+6gS4NHodwnc
 PbQOP8DE0SvbdVEle6eWIFPPsVYIpD3Zr1pplQoi6VZetF2apFSPM3cGErbkNkdqJpoA
 GT+ZcTqiNBkWYWGEbQijDt0jmwF2sEmWIlU0e5BNsdsAlR7wr/SgYWFoaZtSBW8S1W81
 tQcnGhJh//g2+9ghFPFYYpTEp5rwETxd87DAGRs1SYscirIVIdeGe17s/loqwY1avUBO
 Cv3Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHELHF9tHIHzSkziH7xKwfHkZoJFyep8rUcakScd4pBp8YzCKNkIfRUSC75rbEu0VkOTVVy3Ti3ChU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z92UPIW0O5iKfAhEvzc2jyt5xEuNH/t3+fYzezZn/nk4GGva0rn
 pJF8Fb8xNcpSf2Q2dEwLaS+HVAyUEeQ5QecxJeiSVUwbYHBKFZ0gxZPN
X-Gm-Gg: AYBFou04GZZUSwWVF8X+4cXj9LUbU1Hd17OFciY2UiD5DsG5SRRrMAPYpVBkIaZugyL
 +ZF8IxRKfS2jtjOlLXGBni0yk6Wtc3VwNCdSCzoJ2tGvC6+PVqqNK8zOO9YHRCp5t93ptqilQ+t
 oVLka50k/ofwsffD4bbJ1i5DBQYF3oRKjdhKeQdv+y2e+yp7eSeQUZJBpGxy+SZ9WekUVKklfbO
 xC9mfoFKrCjQh1R0oWnfAKeL0XAJCFaDF2ROur2gJuxsiZm6tGwM9qVm+A5nWammXkva4MvuEP3
 X4l2Rerf3A9SX4bgr5a1BJdMu3pKRkWliLz32Zplz8FepX63OjBaG044kmrS5REvY/MUsgV2IyM
 Ye5pSlaO+txDMHE8FscyjwCw5sDJMH7fAYl2X7yMbTuJJxIzOYYF6sC/hmbey3cxOmrrQw+rxcr
 F6ANqhGIDGYT9F+QGiifZIIIKnwHbzYsrMI8Pj292fx+9qrBtr+NCCEB1HwElpZW0ODRT3lBMeM
 2/QClKbFJlJNQhIz9J3DJNfrmiQtSRBTGi0ddHNTkzjNUM05sTfRtZ+D321CB1VxWgJLK00QPXr
 b71si1RUih7chm9Dbl1Ij0hck4mtQkFutFxSFXlNaUQhXmD5+qxR7YIL/g2HoC9aeDIUHBGlHgs
 =
X-Received: by 2002:a05:600c:3ba4:b0:4ba:493b:3401 with SMTP id
 5b1f17b1804b1-4bb8880abafmr2552105e9.9.1795107273824; 
 Thu, 19 Nov 2026 08:54:33 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88402ce9sm9894555e9.0.2026.11.19.08.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:54:33 -0800 (PST)
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
Subject: [PATCH v3 10/10] arm64: dts: qcom: sm8250-lg-timelm: add QCA6390
 Bluetooth
Date: Thu, 19 Nov 2026 17:54:20 +0100
Message-Id: <20261119165420.24466-11-rofikcoga@gmail.com>
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

Describe the QCA6390 power sequencer with properly voltaged supplies
and enable Bluetooth HCI on GENI UART6.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index 3ce8161574a95..1426ce82d3f58 100644
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
@@ -634,6 +695,14 @@ &sdhc_2 {
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
@@ -667,6 +736,29 @@ ts_int_default: ts-int-default-state {
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

