Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9BC606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oOemx5/p;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VqWYkR8e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 674D510FFB1;
	Thu, 12 Nov 2026 10:16:28 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 996E010FFE3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:16:16 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC98RYj903602
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f/vqb8PA2sl+yvwHUhatXU1JfNn9aoq20K9NdlI8gD8=; b=oOemx5/pJjYUay72
 hfj7X6LkHgDIpnme5CV2dWK5/KtlAV3k1n5LiAt+VRBv66jaCqlEyXxHzAYMFUoM
 a5b7oHzzTZyEwWsubbsrWf/fTSlIT7SdWqC/zi9QLF8d1vV6STFWVcIeAcZdxcSx
 /5ZGTbreUIS24EAtPxJkwjJf2JaQSf03WvR79k6DgN3+VpFPIBhP8WHo5dHcx+hf
 8MoCYl2Wgt+sMVScwiWXwi2w3k7PH4wydI/0Did5L7s0Iz4ZhmCG45N9iUGdTi0c
 i7B02f2Zy9D8nuDJzVSKpgh1G/75+mvBuPt79nxifJ1z9yB9S6/iZYuIlpaLinYC
 8haHQw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt1uc42j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:16:16 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8b8cef34b43so5424701b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 02:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794478575; x=1795083375;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f/vqb8PA2sl+yvwHUhatXU1JfNn9aoq20K9NdlI8gD8=;
 b=VqWYkR8eC5iDPOgms7uP7bKUuj/rBXbJYNUMQAMxmLBNw3emyEOpOsUnn1PIVeT1b8
 ZPX3H5z+jxMkwvUfMiJvqVG+Ju59doN+ZFOawB21qni/kbNWRJ9H/NptZno0ayn3EeVB
 DW3HW/079OpsH1Y/Q5UhAatxZuznbT2oLYrOZ0qEq2124rUYgQn6ZN0kqtNl6BNCaTyQ
 k8snPQhUttE0hBcNdDgNDrXE8EaaoByYqZn3+BJ+4iw1vDMc/Rvdy17RZ1zOoC/3eZPZ
 tkG5kvLYjCSPH9D1kRlZ/+8FGX5lPS9yqqpfzGYk8bEL6ApWfUK372D1TrloZWBmWxq0
 XZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794478575; x=1795083375;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f/vqb8PA2sl+yvwHUhatXU1JfNn9aoq20K9NdlI8gD8=;
 b=NHuW2WkJgo4DQPFcbrEYJeBKI4QvQsVGE7Zb/ntzxo209TXyhqUoTh02xQ3v3oL/jX
 RV7a9z4Z1UXUlo+fW5MBXGkj0CuMz0hayFzfgdgECH5VwAgYt5M8dFryUi57uK+PnNEv
 8eSnIZbyVMG19XCRw5k9KNnQXdwlE077AfRg+9fmnu4k1ZZdT6wE3I/pOGnULWF8lERr
 GkawbEpqg0N94QJsXS6TNl5nnXYxAeM1s8b6tBHo8CYdinBl6FpScZkqrnUqPMfCFKDO
 X7Y+K4c/JiYQe+FFiqe5QIRXiLoujxBYPHSxz1Q1rfl8iUYJ/6b2gckLhQpsCAuyYqmj
 hq3w==
X-Gm-Message-State: APuU4Z9ZLg7LIr43TIWH0uaiUApbhkQ9pek1kh1mfHgNbTMID0ay8oPX
 NAxAKeyg48rba1KR4WLXaEuA6V9FFJDrLGk4aQRUIF975dWhAPxvBSLS3Rj1lmNW9ng8iuqkH31
 Cfyu5KQssGnKQXOK52UuVZi5vB+BfM50IAHuSSFdGySWGloMQ8tgMZIlWv/BjkRNQ8ZUp1hM=
X-Gm-Gg: AYBFou0ec3VNQVvnODVrhi3Fwz1dVl4+qXhUxnWnIlmmsKG/KrCE1EGTxH3k2f4IKe3
 Q9JrJdtOWCKmt1bsjd7NBp/TdKAOC7giPVhf7x2zFBMbw/ebjGcwXfIgHc+3NFAouAiRFeI8jLz
 tpb9Ym72eMs9UNno5MaSTAcIWRwlcCzGij9SO/yi7zAmreX5HiN64B8wQcjrmI8wZMP1uA+QJBN
 DGfoIkAKlg0vwhJF3QTrFeOPFbV7d7TwlNsIoAP+X9+nEDAIIdStYlVfQvbcWkikXdXnZyWxWH/
 zvyPzG8Yfs8L/XtjNkNut0Bh/lFHBpQgARRzDaCsUz/w7Uw9jLNAz3/oPByMYkShr1nJ5taH5FL
 boErHcnonwHhVW1k7mRP8I89JGoArX9cEzTy7D0WBLvG0W71Q84Y/6I8c5BDkHPZNS2KmtZ0s1M
 Rb
X-Received: by 2002:a05:6a00:1817:b0:899:74d0:8a58 with SMTP id
 d2e1a72fcca58-8bc1d81d5e4mr5126505b3a.55.1794478575341; 
 Thu, 12 Nov 2026 02:16:15 -0800 (PST)
X-Received: by 2002:a05:6a00:1817:b0:899:74d0:8a58 with SMTP id
 d2e1a72fcca58-8bc1d81d5e4mr5126492b3a.55.1794478574878; 
 Thu, 12 Nov 2026 02:16:14 -0800 (PST)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baaae3e110sm3185872b3a.36.2026.11.12.02.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 02:16:14 -0800 (PST)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 15:45:37 +0530
Subject: [PATCH 4/4] arm64: dts: qcom: glymur-crd: Enable HDMI output via PS195
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-mahua-hdmi-v1-4-b463d7b1dd7e@oss.qualcomm.com>
References: <20261112-mahua-hdmi-v1-0-b463d7b1dd7e@oss.qualcomm.com>
In-Reply-To: <20261112-mahua-hdmi-v1-0-b463d7b1dd7e@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794478537; l=5057;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=9Z++agaaiuF5ovhrauBFDrmdWH3F4YobMbzvMcWaug8=;
 b=of6Rs2zo5YZBrdpywh4p1Gqo5OfdMOsX1fpxY3NSkVR+MhVD9+c6ZT4F9UV/Ct7SxJ3m2crTl
 MbptMIaVM+qAAvUmJv4CSsd5v9Udqrmi8U+h2JFq/HU645MVqicBy0C
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfXw3lp4v2R27fr
 jd8JOBzpqZHB5OFc5ATzOqMb71Lk2n09BgTY23jYUptp2Q33uHT6ZfJJABfJ7uzWl8aOWvf0XDO
 rYDWlWbfbWcu03r3G/SHqfMLEZvVOMI=
X-Proofpoint-GUID: J8l6k767xMrna01JtSiLxCu6KtBeyT7j
X-Proofpoint-ORIG-GUID: J8l6k767xMrna01JtSiLxCu6KtBeyT7j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfX/AnUSse4OhpR
 R7j3GBPcDOt1mvkjwkXapdUDopbcrKEXndCHjUsr97e+l7HC46uF0emF5Klzm8r/sK/l+fzUz+4
 dIVaMruL2QtV/uluY8q8pP+ABgtVTIrWfyP5xaIcPleZdAoyoajxqXFjduBWUCfoiKgUFZrrBvr
 E3VWlc6NcP3t1NA2u0WT/XCzrYZ6daQKRBv6D/BZ4y8NZXzNznVRMuZgYf7osbzsAj840UErlFt
 EU/6kSHQLdSi9t92x9uCCK6dwYQE1Xn5aVq0t3vLdQ+/UVR8XTxS/w7Htyiz1257bN2dm3k67Nd
 tYvxRDonU5qacxLz3aGWXbdI2Qh48hB11aggiHBv0Mcc2IEtVYxomchq8CnZlcew7l82KJQnjnR
 1EEK5lhSna2xaRPNgDDgJ2mQ6IyAQZw0NHh98zQfgnGJG9pgrM6H/E6e+Yiee7rWKBeCLxJZQDi
 K5qwwqQg26/v4kFKkVQ==
X-Authority-Analysis: v=2.4 cv=LvcHWXdc c=1 sm=1 tr=0 ts=6af591f0 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=hoTDXIFaVgMer3lSMjIA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120040
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

From: Mahadevan P <mahadevan.p@oss.qualcomm.com>

Enable the PS195 HDMI path on Glymur CoB/SiP, Mahua and Kalambo CRDs
through their shared glymur-crd.dtsi.

Describe the bridge, connector, supplies and four-lane DP2 connection
through the USB2 QMP combo PHY. Add the GPIO126 HPD state to glymur.dtsi.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dtsi | 142 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/glymur.dtsi     |   6 ++
 2 files changed, 148 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
index 2ec62423ad79..87adeccaffc6 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
@@ -20,6 +20,35 @@ aliases {
 		spi0 = &spi18;
 	};
 
+	hdmi-bridge {
+		compatible = "parade,ps195";
+
+		vdd09-supply = <&vreg_hdmi_0p95>;
+		vdd12-supply = <&vreg_hdmi_1p2>;
+		vdd33-supply = <&vreg_hdmi_3p3>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				hdmi_bridge_in: endpoint {
+					remote-endpoint = <&usb_2_qmpphy_out_dp>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				hdmi_bridge_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -63,6 +92,17 @@ switch-lid {
 		};
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&hdmi_bridge_out>;
+			};
+		};
+	};
+
 	pmic-glink {
 		compatible = "qcom,glymur-pmic-glink",
 			     "qcom,pmic-glink";
@@ -142,6 +182,53 @@ vreg_edp_3p3: regulator-edp-3p3 {
 		regulator-boot-on;
 	};
 
+	vreg_hdmi_0p95: regulator-hdmi-0p95 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_HDMI_0P95";
+		regulator-min-microvolt = <950000>;
+		regulator-max-microvolt = <950000>;
+
+		gpio = <&tlmm 55 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		startup-delay-us = <1000>;
+
+		pinctrl-0 = <&hdmi_0p95_reg_en>;
+		pinctrl-names = "default";
+	};
+
+	vreg_hdmi_1p2: regulator-hdmi-1p2 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_HDMI_1P2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+
+		vin-supply = <&vreg_l18b0>;
+
+		gpio = <&tlmm 54 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		startup-delay-us = <2000>;
+
+		pinctrl-0 = <&hdmi_1p2_reg_en>;
+		pinctrl-names = "default";
+	};
+
+	vreg_hdmi_3p3: regulator-hdmi-3p3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_HDMI_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 170 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		startup-delay-us = <2000>;
+
+		pinctrl-0 = <&hdmi_3p3_reg_en>;
+		pinctrl-names = "default";
+	};
+
 	vreg_misc_3p3: regulator-misc-3p3 {
 		compatible = "regulator-fixed";
 
@@ -545,6 +632,17 @@ &mdss_dp1_out {
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
+&mdss_dp2 {
+	pinctrl-0 = <&usb2_dp_hot_plug_detect>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&mdss_dp2_out {
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+};
+
 &mdss_dp3 {
 	/delete-property/ #sound-dai-cells;
 
@@ -826,6 +924,27 @@ ec_int_n_default: ec-int-n-state {
 		bias-disable;
 	};
 
+	hdmi_0p95_reg_en: hdmi-0p95-reg-en-state {
+		pins = "gpio55";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	hdmi_1p2_reg_en: hdmi-1p2-reg-en-state {
+		pins = "gpio54";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	hdmi_3p3_reg_en: hdmi-3p3-reg-en-state {
+		pins = "gpio170";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	kybd_default: kybd-default-state {
 		pins = "gpio67";
 		function = "gpio";
@@ -1035,6 +1154,29 @@ &usb_1_qmpphy_out {
 	remote-endpoint = <&pmic_glink_ss_in1>;
 };
 
+&usb_2_qmpphy {
+	/delete-property/ mode-switch;
+	/delete-property/ orientation-switch;
+
+	status = "okay";
+
+	ports {
+		port@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/delete-node/ endpoint;
+
+			usb_2_qmpphy_out_dp: endpoint@0 {
+				reg = <0>;
+
+				data-lanes = <3 2 1 0>;
+				remote-endpoint = <&hdmi_bridge_in>;
+			};
+		};
+	};
+};
+
 &usb_hs {
 	dr_mode = "host";
 
diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index 65a398c0a992..2d3f8fe2cf5d 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -6793,6 +6793,12 @@ data-pins {
 					bias-pull-up;
 				};
 			};
+
+			usb2_dp_hot_plug_detect: usb2-dp-hot-plug-detect-state {
+				pins = "gpio126";
+				function = "usb2_dp";
+				bias-disable;
+			};
 		};
 
 		ctcu@10001000 {

-- 
2.34.1

