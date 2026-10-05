Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBA3CA5FFD
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 07:25:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5087F10EBE9;
	Mon,  5 Oct 2026 07:25:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ee5kYlp+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hsZtGPug";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85BBA10EBC1
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 07:25:11 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695104WP3688193
 for <dri-devel@lists.freedesktop.org>; Mon, 5 Oct 2026 07:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /24GXEjVyFJfwdd4HTQn7zAyjrmcG6cdruCMH8XBiVo=; b=Ee5kYlp+n6owqe9k
 jdlV79cvLqzu9NGkdwR1YutTxNk63cB9nH68ng7wKa77jcUH6bKSaQDECNOY6OMO
 uW+DExtUiE1iXCSC6WiXKnXd5WZbx8j5DvEuFYntLmkqo2s55VHGOYi+QhLayFRR
 PFKGIBXdn4pvTcMFGGY7lMMWr1+seJ+YUk00oi1PdpfrNRRBy5zvK3/vOi/EEuie
 2LERWJKXjD6+INB2HQg+M0t9lzZTCCsFdHw2bf1hC8Q0K20gz31Mwb5GOINl26cw
 x5tMfCMvlFNTYfIUwd0rBwopHurwchw02gZUS+tS+n3ff2dhBnYR2Pq4IwuZLONI
 e5z8Qw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3chfjsam-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 07:25:10 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3a6d30f66c9so1681905a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 00:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791185109; x=1791789909;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/24GXEjVyFJfwdd4HTQn7zAyjrmcG6cdruCMH8XBiVo=;
 b=hsZtGPugoLXbGUCAlTBcEXkFbFjF3rm3J5sdaw3yd/19Z3UGOStR6lBEiEgbA+QHXt
 OD3FMVrZ6NA3ei1HbyMCif9aPvYraO99b2EVxJDMB6Ql+XPwhGTuMItlqn/fJBDbf7td
 CRUuaLyRy7ILPoLuvGx9m3vOqYQeGvJDHkPCY9iHDaShvmK+KMUecWfrRC2cYWhUZGOU
 +VA1kJ+p9qPMdsov+o7Bpz8wNZxlZ9De1oO0o1TwffJIRws7utiAtEADQ8bFdEU+4v8i
 T9SyoubRFj1J+fnR2IhaMahDIhiiyNq5fGrnH3L+kUyYD5T9JrRdYABFgaWjTq+ItIZb
 Aw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791185109; x=1791789909;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/24GXEjVyFJfwdd4HTQn7zAyjrmcG6cdruCMH8XBiVo=;
 b=qfPqNIFscVIExqDUqGjss0DmZj/VbF+nMPt6YFDB4Nq7eB+EmxaBGq9uFevq4uSJxa
 aVJ83Q3u4HEw4gY+AWK3Z8BRQFXXRqDLIvbzsVbaf8e35cd97wnpUF9F3wWF3OdgIDV7
 Z4s9/xOOELj6ikhZZ9lQJKU1R6EkedW1IyqiTQUMY6ZMyjgSarvIZKFX81z84VorFQ4U
 75nNQk9bIG8H5ZPhOpmhePux/PlKUUQx/EsgTRsm+DC3q70sMuuCXVxnpOR9beUvH86b
 SdBFTcEodl3Tfh3Pvvsgy2w/M+RCrGA0idnigM2qTFrVd+e6EMlYdITww84THajPijGZ
 y2EA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVqqUG17ID6/vLlmPUnMnFMVQGpgd5Bn34NxqUv8L4h3sqaHVE8VnFS0CoZsAvpfazzowELcbLdlM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIM+YreVzv+1bFt7MrkG4HsKJzUaOPIq4vBnWzm5BlHv0+UJM5A
 Ulu0PVqdTJEQFNj7WSRHX9CfSiGLvP0hMaeZ9YQwLtxqA/5TpwDMbHWt2YpggyGE9pLfUjrE8BN
 dH8yWl/8timjRuzPbJyhi9c+9OHE3/ilzy6A78dwlS1nUEH09EiJ/sqMlHHpw1cos7ZBAeLQ=
X-Gm-Gg: AYBFou0z3iWEeU5tQ3dWVgt0VF/6biWKBmcuffqgqzqaPjaO3NjzqFqWIk+tNAZIt3C
 Awvn+BI80VFih7oDRZ/FcmXzMu8QZKKm2vEqVAGT6p73BYb63xntrLQe1CLJevCdxO47I0i0sdt
 fz9xwVXwLyAWPYwWKyGNaiXJ4wFKva4oaZ50D0klSRFoz7Gm25fm+w5R6Ow7mLPk5LtFrk2iQ3C
 CBmzxLVFmnqnkI/bANKxUD1OhyFCz47ixxY995rytgOViANZvItIvQ/DFdwNzGvqOPC8mYGr3Uw
 8JD5eYGMvfQ5CooOCv1UupB6orEJMI8HxDBd23sHbevLU7rzyyVfynCHR44X3P2z5dH2t6iea2l
 VkVKnsOWWP9GL3kwirWH6jNuXIrP3knP7GkE=
X-Received: by 2002:a17:90b:1c02:b0:39e:6c68:fd91 with SMTP id
 98e67ed59e1d1-3a6cec820dcmr5703712a91.38.1791185109390; 
 Mon, 05 Oct 2026 00:25:09 -0700 (PDT)
X-Received: by 2002:a17:90b:1c02:b0:39e:6c68:fd91 with SMTP id
 98e67ed59e1d1-3a6cec820dcmr5703702a91.38.1791185108930; 
 Mon, 05 Oct 2026 00:25:08 -0700 (PDT)
Received: from hu-bkalkond-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a78e4f3911sm9901421a91.15.2026.10.05.00.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:25:08 -0700 (PDT)
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:54:29 +0530
Subject: [PATCH 4/5] arm64: dts: qcom: kaanapali-mtp: Enable USB headset
 and Type-C accessory mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-kaanapali_dp-v1-4-6faeac3a6d59@oss.qualcomm.com>
References: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
In-Reply-To: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791185070; l=2189;
 i=balaji.kalkonda@oss.qualcomm.com; s=20261001; h=from:subject:message-id;
 bh=KE5lnf3g0TLSQwmbAHHp1Q6HH2MqV/4eigAvw1yDbiI=;
 b=WDezgMdLntdbfUe61kUs+X9rKFpWGi9ZUEXyrWzpbOs/TElgATyTbxOCeb1XOwJ2aXO+7gJHL
 jqCBuZoHCf9D1TYqRVSNTMbjYgeiWFX0EwK6oNCH6NopAss9yMF5hC+
X-Developer-Key: i=balaji.kalkonda@oss.qualcomm.com; a=ed25519;
 pk=U+unGox551qPLS2mzIlN+b5cHksxTMGPnDwePd6KEnI=
X-Proofpoint-ORIG-GUID: pCmCv-4vh4e4FUxL53tllhPlPJoBkOav
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyOCBTYWx0ZWRfX86k3ul0Y6JPW
 btr4Cc0sroYwRBREt9dZeDY4UoTgww0APA2C+ySlUTLkauGDNJN5qeGzvl9qv62PyECrFpC++ww
 G46yAXutZZuj3Ed5DuQsu63mVgkUG3A=
X-Authority-Analysis: v=2.4 cv=eZSo7LEH c=1 sm=1 tr=0 ts=6ac350d6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=XqinFhvkQ7oosSToCroA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: pCmCv-4vh4e4FUxL53tllhPlPJoBkOav
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyOCBTYWx0ZWRfX29YATGh932jL
 Cf4S1CNNw7Cu84xf8PxozvA19++9NFjZrO2vGwCDEo0cNUFQznaI6ySVCqJaV2GyHD56oNeywWC
 62WlTQZDRa5ovTCdEI1MdvAbpmVcRxyKzI3ZcvVRu6nPq1wL8LBxgEoD6LvQdSRmcdpqNokluPr
 wWGtSsyrAC5llT816vjZkIRcs+rqwCyNV9L1u3yFvRifB1rBrbQMi6R21DhyhChizsto8sBUhEg
 /4akTQZjEpSm22j61oTwQo5UG6FfEHbxfR9O+heJGX18KeW0zqc3CqrAmfB9swb61Y8/KVTgOVK
 yljj0CX/iqQjiUMXoV0scAJ0HS1F9VgXeVqVvIyOjMHlqjPhsSGO6NYKnCH0kvLBWuZTjMlVga6
 KvPe1AyGj5ArzQdtbhBlH6/4ks8s/5BvfJO6lMIF3Qw7JEHIYaOSOKRDCmTcIR2XMd3LyqEdf9l
 zLh26phIdnkIuxOBvIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050028
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

MTP does not have audio jack connected and relies on USB mux (WCD9395).
Add necessary nodes for proper audio headset support along with USB
Type-C accessory mode and orientation.

Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 51 ++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
index 9eb02fd09dab..16f4dd041649 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
@@ -200,6 +200,7 @@ port@2 {
 					reg = <2>;
 
 					pmic_glink_sbu: endpoint {
+						remote-endpoint = <&wcd_usbss_sbu_mux>;
 					};
 				};
 			};
@@ -232,6 +233,15 @@ wcd939x: audio-codec {
 		vdd-px-supply = <&vreg_l1g_1p2>;
 
 		#sound-dai-cells = <1>;
+
+		mode-switch;
+		orientation-switch;
+
+		port {
+			wcd_codec_headset_in: endpoint {
+				remote-endpoint = <&wcd_usbss_headset_out>;
+			};
+		};
 	};
 
 	wcn7850-pmu {
@@ -916,6 +926,42 @@ &gpu_zap_shader {
 	firmware-name = "qcom/kaanapali/gen80200_zap.mbn";
 };
 
+&i2c3 {
+	status = "okay";
+
+	wcd_usbss: typec-mux@e {
+		compatible = "qcom,wcd9395-usbss", "qcom,wcd9390-usbss";
+		reg = <0xe>;
+
+		vdd-supply = <&vreg_l15b_1p8>;
+		reset-gpios = <&tlmm 162 GPIO_ACTIVE_HIGH>;
+
+		mode-switch;
+		orientation-switch;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				wcd_usbss_sbu_mux: endpoint {
+					remote-endpoint = <&pmic_glink_sbu>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				wcd_usbss_headset_out: endpoint {
+					remote-endpoint = <&wcd_codec_headset_in>;
+				};
+			};
+		};
+	};
+};
+
 &lpass_vamacro {
 	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";
@@ -1113,6 +1159,11 @@ &pon_resin {
 	status = "okay";
 };
 
+&qup_i2c3_data_clk {
+	/* Use internal I2C pull-up */
+	bias-pull-up = <2200>;
+};
+
 &remoteproc_adsp {
 	firmware-name = "qcom/kaanapali/adsp.mbn",
 			"qcom/kaanapali/adsp_dtb.mbn";

-- 
2.34.1

