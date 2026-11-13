Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F55606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=7TSP6Duc;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=xcqcGC2V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9981E112546;
	Fri, 13 Nov 2026 13:43:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="7TSP6Duc";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="xcqcGC2V";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1A1510E6DE
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794533099; bh=WrHgY6PwjEKI93+oJYDaAlr
 agI5QYPqtHiUztGf8TtU=; b=7TSP6Ducg+d5QiEznHhKIzX9q0cwqojSgyxJnOnCkAT1dV3doQ
 MOE+ZBD2WT5mdhKcm56fFSPXLxDwCTkRvRBg==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794533099; bh=WrHgY6PwjEKI93+oJYDaAlr
 agI5QYPqtHiUztGf8TtU=; b=xcqcGC2V8IEUWz8UtpVH0954KnlDq0Hbp7Fe5Nbt73sGXUiU5O
 JIn1XspHaJ43Leu2dhwYfHFcRkH58OaYYLg+UUOyVJObg60r4PvrXhOboeGjHMN/t6LYGSwOT5p
 RNlGSTZ3pcQD53OHzYbutDBqEGiPJtTSHO/7PmZq69UjISySeqHTSE6ylBSx46EDyo7LNryn8bD
 DP9vjM+CyJGylGt2OiTnnx12TFCGBft8zTvesevAY7A7AzaRKMtNi+zi1pd9QPX4DEIyh6g2A7I
 atlB9HhXfVgWxnwbyekQZHftCW4fNkLmCJLAFBCqyfKf+YXD2ukp0e+mFrgWCrZykGQ==;
From: erebion <erebion@erebion.eu>
Date: Fri, 13 Nov 2026 02:24:55 +0100
Subject: [PATCH v4 11/12] arm64: dts: qcom: sm6350-lena: Add PM6150L thermals
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-pdx213-upstream-3-v4-11-4b01c50a821c@erebion.eu>
References: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
In-Reply-To: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 erebion <erebion@erebion.eu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794533093; l=4675;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=aREpIIHqg2tDJ5FYbe+GEeITQimCDAQWeYqJpHofPBE=;
 b=hx01MaM5mR7wviCw7nbZyvcdn1rV88GEF+o1nmc3pmXmgXs8fBLJVSINO/sScKj+w/tWdAXmB
 vFFQqbtidJ6CjyL9rYZeauPXoTkIXOp1a+/2ZRLU1IjUhTNe89Pvcv1
X-Developer-Key: i=erebion@erebion.eu; a=ed25519;
 pk=rOCVlR8khmBtCFe4ZlDcbCbIcORxdaNzPDkoIiHM7xc=
X-Mailman-Approved-At: Fri, 13 Nov 2026 13:43:28 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Configure the thermals for the PA_THERM1, MSM_THERM, PA_THERM0,
RFC_CAM_THERM, CAM_FLASH_THERM and QUIET_THERM thermistors connected to
PM6150L.

Due to hardware constraints we can only register 4 zones with
pm6150l_adc_tm, the other 2 we can register via generic-adc-thermal.

The trip points can really only be considered as placeholders, more
configuration with cooling etc. can be added later.

Signed-off-by: erebion <erebion@erebion.eu>
---
 .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 160 +++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 79097ae409bab..d7a5df04a296c 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -61,6 +61,13 @@ key-volume-down {
 		};
 	};
 
+	msm_therm_sensor: thermal-sensor-msm {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&pm6150l_adc ADC5_AMUX_THM2_100K_PU>;
+		io-channel-names = "sensor-channel";
+	};
+
 	touch_en_vreg: regulator-touch-en {
 		compatible = "regulator-fixed";
 		regulator-name = "touch_en_vreg";
@@ -106,6 +113,74 @@ active-config0 {
 			};
 		};
 
+		pa0-thermal {
+			thermal-sensors = <&pm6150l_adc_tm 1>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		pa1-thermal {
+			thermal-sensors = <&pm6150l_adc_tm 0>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		quiet-thermal {
+			thermal-sensors = <&pm6150l_adc_tm 3>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		rfc-flash-thermal {
+			thermal-sensors = <&pm6150l_adc_tm 2>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		sdm-skin-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&msm_therm_sensor>;
+
+			trips {
+				trip0 {
+					temperature = <45000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <55000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
 		xo-thermal {
 			thermal-sensors = <&pmk8350_adc_tm 0>;
 
@@ -392,6 +467,83 @@ &mpss {
 	status = "okay";
 };
 
+&pm6150l_adc {
+	pinctrl-0 = <&pm6150l_adc_default>;
+	pinctrl-names = "default";
+
+	channel@4d {
+		reg = <ADC5_AMUX_THM1_100K_PU>;
+		label = "pa_therm1";
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		qcom,ratiometric;
+	};
+
+	channel@4e {
+		reg = <ADC5_AMUX_THM2_100K_PU>;
+		label = "msm_therm";
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		qcom,ratiometric;
+	};
+
+	channel@4f {
+		reg = <ADC5_AMUX_THM3_100K_PU>;
+		label = "pa_therm0";
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		qcom,ratiometric;
+	};
+
+	channel@54 {
+		reg = <ADC5_GPIO3_100K_PU>;
+		label = "rear_cam_flash_therm";
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		qcom,ratiometric;
+	};
+
+	channel@55 {
+		reg = <ADC5_GPIO4_100K_PU>;
+		label = "quiet_therm";
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		qcom,ratiometric;
+	};
+};
+
+&pm6150l_adc_tm {
+	status = "okay";
+
+	pa-therm1@0 {
+		reg = <0>;
+		io-channels = <&pm6150l_adc ADC5_AMUX_THM1_100K_PU>;
+		qcom,hw-settle-time-us = <200>;
+		qcom,ratiometric;
+	};
+
+	pa-therm0@1 {
+		reg = <1>;
+		io-channels = <&pm6150l_adc ADC5_AMUX_THM3_100K_PU>;
+		qcom,hw-settle-time-us = <200>;
+		qcom,ratiometric;
+	};
+
+	rear-cam-flash-therm@2 {
+		reg = <2>;
+		io-channels = <&pm6150l_adc ADC5_GPIO3_100K_PU>;
+		qcom,hw-settle-time-us = <200>;
+		qcom,ratiometric;
+	};
+
+	quiet-therm@3 {
+		reg = <3>;
+		io-channels = <&pm6150l_adc ADC5_GPIO4_100K_PU>;
+		qcom,hw-settle-time-us = <200>;
+		qcom,ratiometric;
+	};
+};
+
 &pm6150l_flash {
 	status = "okay";
 
@@ -405,6 +557,14 @@ led-0 {
 	};
 };
 
+&pm6150l_gpios {
+	pm6150l_adc_default: adc-default-state {
+		pins = "gpio6", "gpio7", "gpio10";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		bias-high-impedance;
+	};
+};
+
 &pm6350_gpios {
 	vol_down_n: vol-down-n-state {
 		pins = "gpio2";

-- 
2.53.0

