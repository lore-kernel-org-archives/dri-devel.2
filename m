Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40A3FEA801
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 03:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40A1510E70B;
	Wed, 25 Mar 2026 03:54:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JKXzV0Gd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gSU91ZLl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C1A810E70B
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:54:15 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJCelU989015
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=22yY2F/7WYB
 VxuHqS7ff5XwOR2N3SI2/M1bD0Dzv1m4=; b=JKXzV0GdAwtP1HFLnfadqbL44Uo
 jpkQrRAvpL17QfAkydK1MvRHMEoal0Bvg/OtXvWJI2sMN20v+LbYerma5CzqyYRO
 9hambebMcWKhct9gYpzm2NJ9VIM9CGOj+iKBv6HZ0uIY4xeIOFT/so6QASQz01Nf
 +V2bXE5UFPuo48ehswqjm4CYi1zaC7TrtffdfEeuD8GtbcnQQVvsOnR44nCjnemI
 Bta4JPG170kc8hC5MENoK+pcXs0aeDRi/krM2U0GBooJqYoEnqdU/fRAGf2EpOir
 7bFJPpjnnRJ5WTM76Hobxjj8CkG15r7N0VfWL24XXVmhpAkz+hTBizs5nwQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3u0m2xxe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:54:14 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82c2054b584so15558944b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 20:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774410854; x=1775015654;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22yY2F/7WYBVxuHqS7ff5XwOR2N3SI2/M1bD0Dzv1m4=;
 b=gSU91ZLlKgyHkqV/0ZI3S7hDT5dI02G6cLQ1LUVLCQ4ZjpP5ptO6XCE+4HJaeWB9Aj
 DMXSDJ2j7iZeTkZ2yKRfxNazRQzZL13s3B2M+cxDYerZy2Sfx6dipci/spb5Sa4+yuFg
 /Q63LWSNCpk9Y8HSB9yEzf9iIMyvLiSW9kuqCNkRwxce2l4iQhqHp/sBoT0ow/y++Hxi
 4P4y/Yav36sPjRCH84YXNPdXAEsBkc4kA4XtIXpUd6p1YMt007C4eOrDoAi41+LWCSKO
 5YKGIBvncQRWkeQSG9HHcQOAU5hA19BEYMhlIK9gFC396woi8cn5f3kPFMvPnPfNw6T1
 9I8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774410854; x=1775015654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=22yY2F/7WYBVxuHqS7ff5XwOR2N3SI2/M1bD0Dzv1m4=;
 b=YYFjRCUoO3aaPGtskYdpQlZm4GoBQriIrvCWU1dFWagrzopuZjWh+gfB/MPZ27M7+x
 eZu1ptOxYojOVNu2lUzXRbLRCYvIxtwe7hXsuKX4Gm5nGw8+9U5v7Guy9FDUBGk7ZMHY
 5bxBmNqP68cDmMgYPz9ALr23gNlF62fqkUCmMMclKQx5LLWOubvTzgHjcowvnagDGztA
 JHpn1FZRRpRi4A2qa6r5LZuP+BbwJykteTHodxy4EoKB1s4sdlgKQlJsnpOonVTPWFg6
 ACWo0s+av9/XgMyYkpjcTCF7HUi/qEy21JNSGcKWfcfbpn3svDAfWmtJpCHxifmjnkj8
 tJ0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr/n1UfIWLVN0oxZAu25ZTmDgUZrm78KCwTj4QIqPjIeBx6dngDmVKKRm1qSaLSXjn7bnUYDhfwag=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzVElsqjnuz5hErlegLORc5U0l3+EA7O0nDTkCkH0N5/Sbw+rMu
 hIshOYR7R3yfteAcWg6IsFh6EGr04LI927s2SmJwbeswS5FOV86Hhnph+p8iIjGuR4xFlxu2//Y
 A/jzGBTVBiJGmEVtmGPkeWdJCXV5gUG/k7wwwEMJq4SYDroHiSrCZH8r6QyDNMpPrGE7EJU0=
X-Gm-Gg: ATEYQzwVjb0NziL8iTj7iuG2DeHndCerNd8G9ThlBQPrkGvqPsygRh7mDu3IxtjbZQJ
 WoToeRQH/XX/49wMMMOMk6KOeyB8qJwmANH+ke6pdcCldtrM1OGRRdt6yIn1aiZQO/RhMHO3kvS
 cyJoyiwTGdTPbB3B/oSn4dFhYV64OrfTdH5eiJ/43cwXq8lYSalzGdlLppozDl9f8ac7nYgsGyf
 AyitO4D+SVmza2/CEUQVm4QSoV15Fd/FMIlPvkLspcOo3EJpmyRFOlu/tTMaaJ5ccex9JGwLqxV
 yfmCZZV3bvYNFs/7W/eA4+vNGwnDYdAnSVKpiAYL8VBph5apB04vW+orLEleFFSwlDOTn6AnNOx
 Y6HDuw8t/yQMDj2w3dA/wUyeuZ/eSiBGRff61loT1TSU5NDjWwDz1berD5V9qYRQmoxpoZW0vuX
 9MtkxevbQq1Puh48+ArTunoLjPXtlSqTEJhhkX
X-Received: by 2002:a05:6a00:8c10:b0:82c:65df:299b with SMTP id
 d2e1a72fcca58-82c6e0e508fmr1766427b3a.37.1774410853868; 
 Tue, 24 Mar 2026 20:54:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:8c10:b0:82c:65df:299b with SMTP id
 d2e1a72fcca58-82c6e0e508fmr1766414b3a.37.1774410853377; 
 Tue, 24 Mar 2026 20:54:13 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0410870csm14220689b3a.52.2026.03.24.20.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 20:54:12 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: robh@kernel.org, srini@kernel.org, amahesh@qti.qualcomm.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH V6 5/5] arm64: dts: qcom: glymur-crd: add Audio sound card node
Date: Wed, 25 Mar 2026 09:23:38 +0530
Message-Id: <20260325035338.1393287-6-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325035338.1393287-1-sibi.sankar@oss.qualcomm.com>
References: <20260325035338.1393287-1-sibi.sankar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IY6KmGqa c=1 sm=1 tr=0 ts=69c35c66 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=Q9KsY8QRZZO8mUXd1LsA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: sLB4e_QU1C13Wi-R_nmRUd40RBFvvWnO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAyMyBTYWx0ZWRfX9ix81gJ4EPwM
 iHlQdJ4GGpI98A+zbYG/5fmwmbzYVViSATc+H7CihN1uuWFW0QusuNn6DlBB4DVl0YOByEwIKhb
 cRMj5GSiVhZ1AVRjE1PbUjI00VAYwrP4QCZVX0eh2qRR104ukJO2Y/WynSHDf+jfHs1j1gBbnic
 xif5AaRg/jQ7wylQbhZ8Mt81n1Dgy30m+m0lBCQNN+Q7D2rHvPJMxy/HtiP2TdMBrEEni7iI5Xm
 W9BE8MEDXxG+0CxJEYRPQzkA8BKL9GZrdfjNyGjd9y8Ybu5qFhkE0rDqV2KPTCwTeKl4h7pRLgN
 DXe8QZ4t5YXo5CzCVPzyuIV9J55BM/un+mYwk4GECFLptqX+PmbKgOXBzi8cxfezDTmol7XpeNz
 qzi+OB56jHZTDIMMMo5CfIDCOY3Z4FLcxifvM5h/rrgnbLQcFXKIZEGnFjBYAU5iizu34a78J0B
 /OpK21/cEBsFfqmmAYA==
X-Proofpoint-GUID: sLB4e_QU1C13Wi-R_nmRUd40RBFvvWnO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250023
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Add the sound card of Glymur-crd board with the routing for speakers.

Add device nodes for the sound support with WSA884x smart speakers
and playback via speakers and recording via DMIC microphones.

Co-developed-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dtsi | 110 +++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
index 690b90e3d6ce..88a5c63e8ac2 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
@@ -118,6 +118,54 @@ vreg_wwan: regulator-wwan {
 		pinctrl-0 = <&wwan_reg_en>;
 		pinctrl-names = "default";
 	};
+
+	sound {
+		compatible = "qcom,glymur-sndcard";
+		model = "glymur-crd";
+		audio-routing = "wooferleft in", "wsa wsa_spk1 out",
+				"tweeterleft in", "wsa wsa_spk2 out",
+				"wooferright in", "wsa2 wsa_spk2 out",
+				"tweeterright in", "wsa2 wsa_spk2 out",
+				"VA DMIC0", "vdd-micb",
+				"VA DMIC1", "vdd-micb",
+				"VA DMIC2", "vdd-micb",
+				"VA DMIC3", "vdd-micb";
+
+		wsa-dai-link {
+			link-name = "WSA Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
+			};
+
+			codec {
+				sound-dai = <&left_woofer>, <&left_tweeter>,
+					    <&swr0 0>, <&lpass_wsamacro 0>,
+					    <&right_woofer>, <&right_tweeter>,
+					    <&swr3 0>, <&lpass_wsa2macro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		va-dai-link {
+			link-name = "VA Capture";
+
+			cpu {
+				sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
+			};
+
+			codec {
+				sound-dai = <&lpass_vamacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -364,6 +412,12 @@ vreg_l4h_e0_1p2: ldo4 {
 	};
 };
 
+&lpass_vamacro {
+	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
+	pinctrl-names = "default";
+	qcom,dmic-sample-rate = <4800000>;
+};
+
 &pcie3b {
 	vddpe-3v3-supply = <&vreg_nvmesec>;
 
@@ -478,6 +532,62 @@ &pon_resin {
 	status = "okay";
 };
 
+&swr0 {
+	status = "okay";
+
+	/* WSA8845, Left Woofer */
+	left_woofer: speaker@0,0 {
+		compatible = "sdw20217020400";
+		reg = <0 0>;
+		reset-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "WooferLeft";
+		vdd-1p8-supply = <&vreg_l15b_e0_1p8>;
+		vdd-io-supply = <&vreg_l18b_e0_1p2>;
+		qcom,port-mapping = <1 2 3 7 12 14>;
+	};
+
+	/* WSA8845, Left Tweeter */
+	left_tweeter: speaker@0,1 {
+		compatible = "sdw20217020400";
+		reg = <0 1>;
+		reset-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TweeterLeft";
+		vdd-1p8-supply = <&vreg_l15b_e0_1p8>;
+		vdd-io-supply = <&vreg_l18b_e0_1p2>;
+		qcom,port-mapping = <4 5 6 7 13 15>;
+	};
+};
+
+&swr3 {
+	status = "okay";
+
+	/* WSA8845, Right Woofer */
+	right_woofer: speaker@0,0 {
+		compatible = "sdw20217020400";
+		reg = <0 0>;
+		reset-gpios = <&lpass_tlmm 13 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "WooferRight";
+		vdd-1p8-supply = <&vreg_l15b_e0_1p8>;
+		vdd-io-supply = <&vreg_l18b_e0_1p2>;
+		qcom,port-mapping = <1 2 3 7 12 14>;
+	};
+
+	/* WSA8845, Right Tweeter */
+	right_tweeter: speaker@0,1 {
+		compatible = "sdw20217020400";
+		reg = <0 1>;
+		reset-gpios = <&lpass_tlmm 13 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TweeterRight";
+		vdd-1p8-supply = <&vreg_l15b_e0_1p8>;
+		vdd-io-supply = <&vreg_l18b_e0_1p2>;
+		qcom,port-mapping = <4 5 6 7 13 15>;
+	};
+};
+
 &remoteproc_adsp {
 	firmware-name = "qcom/glymur/adsp.mbn",
 			"qcom/glymur/adsp_dtb.mbn";
-- 
2.34.1

