Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE907606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fGTpC7AN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64AF110E77B;
	Wed, 18 Nov 2026 08:23:12 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48AE510E5C4
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:40:02 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso52102695e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 04:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794919201; x=1795524001; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eH7GNmtkSKP2fzAXhmpuBWSGX/FXkIALtIPPfHtDiis=;
 b=fGTpC7ANc9z9U0j9oNWFHmMQz8hoJQ1feBuJp+8MIQT9aDMH8rwdPxOlvAwIap+WRu
 HQRdxlYbK4Q2Z8NQBX5+tltrJlwK8GjyEofgg+YgV8s9tamoI6dP3CcKBO5Ggy/ANCKx
 BualFDvT8uLLRr+lQq97P2K51qE4fPgsvkb+RKjvla6zfFYerdmKbbGwqkWDNY27mCQF
 3UAp7ZwlKPMvuy/NoTEy9cjpQthpyVSJlaouqT2c3FrIkYY/mrWzpdQkGwgDX2vAmul6
 pS6+mVETzVI8m7vVuCV0w0e3YcsN+vT4Js7/lQbopATTrD1PEJtakEOIQCLLF8uY2sqp
 NqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794919201; x=1795524001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eH7GNmtkSKP2fzAXhmpuBWSGX/FXkIALtIPPfHtDiis=;
 b=YdJZkHNOmFASFmHU95Cb8MS94eXAl7Ng4iJ4+Xv5PSZlQt1Hn130MnicLUv/iSU4X4
 jfNY8EbdDwNupoqC6S2b1t2jxs/oOXHwSt0h0RBweCAmXXFha8NztYifLHIJ7aB6bGsH
 DiMjBUYqDcl5dRvwSveRrZe9Nb/Wi5+xSr1TG7wY6C/sycjmqyjSLRqZGP0EDXtTH3r7
 MBH3J3OyTjAKPBZl/sTe4HhHfz30dQ992v6xnnKi3YqRc/Eakanij1MpkCy8yehfd3u0
 /95CG5xqvuyYaiXQa8CXSoxZ7/HPpSyVPpa9fF2KOOGFzpvaPthf1O7FCFgJV8pKwEE6
 unnQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE7SRlhOM6YZXb1ZFrOTFRXE9rK++nMg8ilW/WwC3p5sTGleszD9RENnwNRun9RIZmRiAJ8sp5JTBY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/1dnHf5ViVIv7R42RoXSlPFBlEFBv/DFeX1DXlnwhLN8bzUF6+
 VSZ6kG9hcBCQGxX2mnV+zTluGtK3N1GsAwj/SctetTKiPQ331m3SwYLQ
X-Gm-Gg: AYBFou2lsGIZXCwd5sxBK3rGoCKKIpoCm21xVFabN390/W+n9jJ7wCSPDSLvUYMGlur
 T7+9pe3311zax1KjM748MThUpqRoHUjT0TWj7PrZURhGOGm7WWsh/OyOtUePb8kd83TjFxAnqdl
 0Qm9z6mcvI3QA/kIsQk89LouX9CYvbe4VDPgTk1udMednNgGruMFmfVNIFqtDN4HLdaYAFmWSXe
 CnOH1FqtG1TS9yV3H7SydzCUko9LbydYeBrlyZfuwy7C57Zli3GRCrZVmIKtDJg1uKNJc80yoEy
 2arW25aWvo4x90N8VNtwMlt/LAffgrc8VrPnaR4b2ExmFH7CKysckvrugTGsbvHZhm1Q/EgJzT2
 1j9+SNFcvkhn1ft5+SXIQ1Bpu2iU8msEtOf6NFDkZFczjKUGgyfH2eBbsnquO+NWFJYzlPSAjj5
 dbo96wD8pD0KqRFEGFvnDbL/entJG1pU9vuQDJbdEZ8LplH+BD4k+WbojT8OhmPXqZ7n84z8tCR
 U16MVe6ldkEdGiPRQ2mRob+BHXfGBpujK6OgVTOat3Fg6bMQns4dxqeyufB62NIahLY/MMzqbrY
 NXwrvr/po9HaD7xVdjY07hm6Uxu1FGTSpyu1BoOqbD6MEb8PHWK3iRfS9fLa53eGIpixtw==
X-Received: by 2002:a05:600c:8189:b0:4a3:598e:e7a8 with SMTP id
 5b1f17b1804b1-4bb559f72b1mr298144455e9.4.1794919200559; 
 Tue, 17 Nov 2026 04:40:00 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu.
 [94.21.223.203]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:40:00 -0800 (PST)
From: rofikkerneldev <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 rofikkerneldev <rofikcoga@gmail.com>
Subject: [PATCH v1 11/11] arm64: dts: qcom: sm8250-lge-timelm: add QCA6390
 Bluetooth
Date: Tue, 17 Nov 2026 13:39:46 +0100
Message-Id: <20261117123946.668557-12-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117123946.668557-1-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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

Describe the QCA6390 power sequencer and its PMU regulators. Enable the
Bluetooth HCI controller on GENI UART6 with the supplies provided by the
PMU.

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
---
 .../arm64/boot/dts/qcom/sm8250-lge-timelm.dts | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
index 6b57c658cf918..38816268fcf53 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
@@ -95,6 +95,67 @@ key-assistant {
 		};
 	};
 
+	qca6390-pmu {
+		compatible = "qcom,qca6390-pmu";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_en_state>, <&wlan_en_state>;
+
+		vddaon-supply = <&vreg_s6a_0p6>;
+		vddpmu-supply = <&vreg_s6a_0p6>;
+		vddrfa0p95-supply = <&vreg_s6a_0p6>;
+		vddrfa1p3-supply = <&vreg_s8c_1p2>;
+		vddrfa1p9-supply = <&vreg_s5a_1p9>;
+		vddpcie1p3-supply = <&vreg_s8c_1p2>;
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
 		ramoops: ramoops@b0000000 {
 			compatible = "ramoops";
@@ -506,6 +567,21 @@ &uart12 {
 	status = "okay";
 };
 
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
+};
+
 &ufs_mem_hc {
 	status = "okay";
 
@@ -636,6 +712,22 @@ touchscreen@28 {
 };
 
 &tlmm {
+	bt_en_state: bt-enable-state {
+		pins = "gpio21";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
+	wlan_en_state: wlan-enable-state {
+		pins = "gpio20";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-pull-up;
+		output-low;
+	};
+
 	touch_reset_default: touch-reset-default-state {
 		pins = "gpio38";
 		function = "gpio";
-- 
2.39.5

