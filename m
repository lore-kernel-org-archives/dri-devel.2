Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F60606A32D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m9+p5TqP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AFm2NcJD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1783A88C11;
	Thu, 26 Nov 2026 06:32:39 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC2A588C11
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:32:27 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ36P771157547
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wXveSJFcQwL36raoOk+JqlDXdJhqjUXocXOXXRact5g=; b=m9+p5TqPL/EDovvt
 RUOnHsWOlRVCHu0PagWbZ33E8yfTiLX8MafDmfqCfJW6m3GkMIG06umt4qg/Jr1u
 A/FaixFcV+U23UrLN84L4HZJw4hjx/NYQti3CqbGmyEOhhzQu7/GjkneTHrI3iCg
 dmgvjsikNoh2P0ZDHcXvzao/wC5B5mbNzmxaL/ojWQY3w5lEuSy4W2ccVxqjE99d
 fp6QFjCBQqBATZtsUFkWelTgZ1aLLaQNsSsStrFXBUytvNy3OMjpGoIk9ah3WqXP
 khYfI7tQqJgWLPnxFb3YhUt8k/3OhtOEUPrROrKl95/RKFL48ulJDf3vKU+eD2EV
 gomY6A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j62aejs20-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:32:27 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2f04e19d945so50273245ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795674747; x=1796279547;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wXveSJFcQwL36raoOk+JqlDXdJhqjUXocXOXXRact5g=;
 b=AFm2NcJDlNbCAmOzed+0+Ri7xv/LS57yQw9If/6dsZDHVdwJAOtAL3qPQpd1ydPXGN
 2TWYjNYXHbr8OVjTmVnniwRdWleYxOZWBMAvuQgZ63k7TCBID4v663zvSWA6n4Ry7++P
 iHqLKuDdxushQCGqf8ysvqnB2W4XLjYsheyUDCQ8ge1jxRtOp4oMlay6pkqEWhjzZ9io
 4R0vDx0CAG2O0NBWYxzwj20gFEQ7Jk0znawX/Y0r8qQTctiZ5QOXOcUWF5ANQ0czqf/g
 mqhYCTu/OOQWzx4aiFQ5/UkU9ECnQcPgCfNwbrQaLQ8foVdu4Lx5Fa/WdmDojBkM1is1
 XNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674747; x=1796279547;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wXveSJFcQwL36raoOk+JqlDXdJhqjUXocXOXXRact5g=;
 b=gIH9GjOB0MOfWtBwKtbE3vjP8wGfQWWqxmFITA5s+A025UsEXem9Z5PVfMRGX7tdS2
 e6gQIz8FRoHKof4xm4vhYUOMeMTvlX1CYlXZ5Fxu/2kfbpE3S7XKBvhOrnpvCIovN+hL
 H2PzyzVIo5HRegz2Uvs7T4eQM19xOrfLqtqmqRimQjrc1fSsB8YihTPwGQFC56lBo3aR
 tki9DgHVG8Z3+M/69HaFg415LcJt9wdBMED8n652oC7twZHZdvsLZm/nf/Frqgtm6Uq4
 ZgJ5q7MZnNbvLPZF5+YIPOxKGwbgxJaXm//T6t9nLo4ZOetT3RwO5RJdr32EIImTTXQ0
 lb2A==
X-Forwarded-Encrypted: i=1;
 AL+hErHkB1k6vj+/je/sxPbe0xKp9OaWMgjin34mXTwKuvtOP7cCw135oPhmm+TabRKpg0mXx4ZwMujuFgw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9V58sfOLCCt1hZUpx7UYsOteUNb+qEZ9T9hc/MT9jZSr69mS1O
 v+B1knjaxZTRfPMzyo/ybwKgGkK+ltH0+jBYCJ1pNRvqANcmBBDXQ6/toZSDcblB1hwnNRUuk+S
 LmTUjr702AOdT7WFkD2Z28jN8TqdCTQ2IbTwsQ7nbxw5dQQWoXvAx21Dh0NC9Bn4mz33kQXA=
X-Gm-Gg: AZFdTZdetnPTPb/THyqlAzF4auK1g3NchoGyI2Kgs0b/7qdLjUQyhya8WJcL9XziTZd
 f6nturtDq8TM2nzydSbs6MUPuJJYW/z6y+O1QoZwzcIGah2yy3yB9jDQPqNLV+qXE4toDEuaExJ
 3mVj/CsgFAGHJbRAc5IyzfKl4uqYFV6g1JBCzdBst8obAFrNELPrmGewxigQuzMzZTQUX9fLAa4
 5W/es0VTxaeUGsa0ycQs7ERz2a0KYsKbuza6jXUiTg4WsqOBj6kU/1jckt9mYZgqiZ/s9yTj95y
 3YgqbQImFIegFyZr4JhwqG0xUsHJL1JnRkHOgw0DppYI6hWRlTXZ0IhSjJWEzBhNUBw758B/E7Y
 liW/b/JS7QtwODZJ8lKPPgg0YdTST3kd0+m3sFr1lic/MPiLibIQ+HjeGKXlCApfMN5fJda7tJN
 mpQDyFN120
X-Received: by 2002:a17:903:2407:b0:2f0:43fa:566e with SMTP id
 d9443c01a7336-2f043fa7827mr179016945ad.10.1795674746562; 
 Wed, 25 Nov 2026 22:32:26 -0800 (PST)
X-Received: by 2002:a17:903:2407:b0:2f0:43fa:566e with SMTP id
 d9443c01a7336-2f043fa7827mr179016435ad.10.1795674745945; 
 Wed, 25 Nov 2026 22:32:25 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f147a9esm97159715ad.72.2026.11.25.22.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:32:25 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:59:29 +0530
Subject: [PATCH v3 21/21] arm64: dts: qcom: hawi: Add DCP support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-jshekhar-v3-dcp-v3-21-f1e9d7505039@oss.qualcomm.com>
References: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
In-Reply-To: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674555; l=5143;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=giewpTQrZZVV20ml7CV6gG7RnmPP9xMRQcPv0COC1lE=;
 b=qU8Ttt4Szokv3b86bytlduDWEANO9b5MhZ9lnOQKHZv+ALr+8UtSQz2OrOvnBc2J7pyUmqzsp
 8RDEoYrk1LzAbuQWX0hAw+055JaZrWR50okBbCOCGEtYwmJ9IDdkLRB
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX5cNxe0vVuaxu
 hejCppNVSuk/hbXxOS2J417js8z5TPJCVVh13Y/2py2MndAdN4u2qkXLU5D2bJyYmzFA8EfmsSH
 7l+e1VMVYYKD9kt9HpHuUfTtkOIwFztaL4vtACK6P7ZIG6fRzlu4IHA5bFZbBDltSzD1XlMdbOU
 MF/rU5vyfz7f7fOG4yllnAkEKZDK/E5rqQ9IrXoj9ZPKFIVRyclyUh/Ry0arpmWFc7O5Y5OaHck
 wQDC4WZtSN7/cEpsvfyvXVfQquX57sCnxDrZIhz5uuI90PJEhWJeLlFZdNU8i3HIqODPhJK3ZdM
 DG9nak0WzU1Tu1YOLd+mW9h0oMYcwe7JS9IcyTggWpJ8XMqYyp/tuZchtl/M4GvgQFQuN3iwSBx
 4v1go36pwgv4m25fSLKAh+PAYT5FyKkT6sBmgtREwBOzTUKwnfVCEr2Vu6mYFeGL5n3lo/lNQ1w
 gfcZRF3WILR3Wi9BFEg==
X-Proofpoint-GUID: BjGSorvzEfeoYkB5cTGIIRP9sL8u5GjZ
X-Proofpoint-ORIG-GUID: BjGSorvzEfeoYkB5cTGIIRP9sL8u5GjZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfXyNwpKOERHh+1
 x0NNpdrlmquSr2uTS5S2l5K+U9rgarNVZmAGPNrxGJKaf+8KnPQKDm22ZhNs9freCaiDd2ieVJK
 aWQxHZOE+9tr+ONdvCfWY2JSL9PneDY=
X-Authority-Analysis: v=2.4 cv=PqoG/AM3 c=1 sm=1 tr=0 ts=6b07d27b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=rMwJWs0V9SWzAl7URZYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260024
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

Hawi display hardware is owned by DCP firmware, so the platform device tree
must describe the Qualcomm transport wrapper, firmware display subsystem,
power-notify channel, IOMMU contexts, and display graph used by the MSM DRM
driver.

Describe the Qualcomm DCP transport and its VirtIO-MMIO child,
the IPCC power-notify channel, IOMMU assignments, firmware-visible IOVA
range, and DSI display endpoints on Hawi. Enable the DCP display device on
the Hawi MTP platform.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hawi-mtp.dts | 108 ++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/hawi.dtsi    |  45 ++++++++++++++
 2 files changed, 153 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hawi-mtp.dts b/arch/arm64/boot/dts/qcom/hawi-mtp.dts
index c38e5fab7a2c..50484d006db6 100644
--- a/arch/arm64/boot/dts/qcom/hawi-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/hawi-mtp.dts
@@ -34,6 +34,18 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	display_panel_vdd: regulator-display-panel-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "display-panel-vdd";
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		gpio = <&pmd8028_e1_gpios 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
+		pinctrl-0 = <&sde_disp0_vdd_active>;
+		pinctrl-names = "default";
+	};
+
 	clocks {
 		bi_tcxo_ao_div2: bi-tcxo-ao-div2-clk {
 			compatible = "fixed-factor-clock";
@@ -995,3 +1007,99 @@ &usb_dp_qmpphy {
 &usb_dp_qmpphy_out {
 	remote-endpoint = <&pmic_glink_ss_in>;
 };
+
+&dcp_dsi0 {
+	panel@0 {
+		compatible = "novatek,nt37801";
+		reg = <0>;
+
+		pinctrl-0 = <&sde_te_active &sde_esync0_suspend
+			     &sde_mdp_vsync_p_1p2_active &sde_mdp_vsync_p_1p8_active
+			     &sde_disp0_rst_1p2_active &sde_disp0_rst_1p8_active>;
+		pinctrl-1 = <&sde_te_active &sde_esync0_suspend
+			     &sde_mdp_vsync_p_1p2_active &sde_mdp_vsync_p_1p8_active
+			     &sde_disp0_rst_1p2_active &sde_disp0_rst_1p8_active>;
+		pinctrl-names = "default", "sleep";
+
+		vddio-supply = <&vreg_l12b_1p8>;
+		vci-supply = <&vreg_l13b_3p0>;
+		vdd-supply = <&display_panel_vdd>;
+
+		reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
+
+		port {
+			panel_dcp_in: endpoint {
+				remote-endpoint = <&dcp_intf1_out>;
+			};
+		};
+	};
+};
+
+&dcp_intf1_out {
+	remote-endpoint = <&panel_dcp_in>;
+};
+
+&pmd8028_e1_gpios {
+	sde_disp0_vdd_active: sde_disp0_vdd_active {
+		pins = "gpio2";
+		function = "normal";
+		input-disable;
+		output-enable;
+		bias-disable;
+		power-source = <2>;
+		qcom,drive-strength = <2>;
+	};
+};
+
+&pmh0110_d_e0_gpios {
+	sde_mdp_vsync_p_1p2_active: sde-mdp-vsync-p-1p2-active-state {
+		pins = "gpio9";
+		function = "paired";
+		input-disable;
+		output-enable;
+		power-source = <2>; /* 1.2v */
+	};
+
+	sde_mdp_vsync_p_1p8_active: sde-mdp-vsync-p-1p8-active-state {
+		pins = "gpio10";
+		function = "paired";
+		input-enable;
+		output-disable;
+		power-source = <1>; /* 1.8v */
+	};
+};
+
+&pmh0110_f_e0_gpios {
+	sde_disp0_rst_1p2_active: sde-disp0-rst-1p2-active-state {
+		pins = "gpio9";
+		function = "paired";
+		input-enable;
+		output-disable;
+		power-source = <2>; /* 1.2v */
+	};
+
+	sde_disp0_rst_1p8_active: sde-disp0-rst-1p8-active-state {
+		pins = "gpio10";
+		function = "paired";
+		input-disable;
+		output-enable;
+		power-source = <1>; /* 1.8v */
+	};
+};
+
+&tlmm {
+	sde_te_active: sde-te-active-state {
+		pins = "gpio86";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	sde_esync0_suspend: sde-esync0-suspend-state {
+		pins = "gpio88";
+		function = "mdp_esync0";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+};
diff --git a/arch/arm64/boot/dts/qcom/hawi.dtsi b/arch/arm64/boot/dts/qcom/hawi.dtsi
index 77d704fa6cf7..9d22243b97d7 100644
--- a/arch/arm64/boot/dts/qcom/hawi.dtsi
+++ b/arch/arm64/boot/dts/qcom/hawi.dtsi
@@ -6854,4 +6854,49 @@ timer {
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
+
+	dcp: virtio@9be8000 {
+		compatible = "qcom,dcp-virtio";
+		reg = <0x0 0x09be8000 0x0 0x1000>;
+		interrupts-extended = <&intc GIC_ESPI 956 IRQ_TYPE_LEVEL_HIGH>,
+				      <&ipcc 13 5 IRQ_TYPE_EDGE_RISING>;
+		iommus = <&apps_smmu 0x15a3 0x0>;
+		iommu-ranges = <0x0 0x84000000 0x0 0x04000000>;
+		dma-coherent;
+		mboxes = <&ipcc 13 5>;
+		mbox-names = "dcp-power-tx";
+
+		display-subsystem {
+			compatible = "virtio,device34";
+
+			iommus = <&apps_smmu 0x400 0x2>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					reg = <1>;
+					dcp_intf1_out: endpoint {
+					};
+				};
+
+			};
+
+			interface@1 {
+				reg = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				dcp_dsi0: dsi@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+		};
+	};
 };

-- 
2.43.0

