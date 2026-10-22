Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78D9606A330
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iS2jglrx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j7NxMa11
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BFA611247F;
	Thu, 22 Oct 2026 09:50:50 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F48A112483
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:50:39 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M6xqjJ2171930
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9ehR7tMmYRyLJIX3GU7vP2bshuwvUW0eepQwQOphNmY=; b=iS2jglrxAjtO05tv
 LmqC75CUX8Mp+UTUCzscD6XK2go64y+oCCPNxI8aigstHn8Z4t9oODQj2HsmZ16r
 oaNQGg4pjn+dg2lncrYbtJhZekEBpFkrh8wzSLcVIOacqD2Cn2KI0bWP+IXdS5w/
 /MDwlpZzV3q/ikvkYfdquKt7fzRH507TGdLfS2NlDhwRxJUoA4dOlkvdS7/VFQ6s
 qDYRe+Z3NfAYPypNK7GFJ52FalBjyXdSFX9PjNeLyWBxYDBLeW7M3zisNUoGgX0i
 UVg3LN63UzwLSTgrCA2CIpkQHMH4q53oIf6WSytBWWeyPI5mKgpELO1FnrHQDNfY
 4L37GQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ahssp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:50:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35c3c370b17so2806174eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792662638; x=1793267438;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9ehR7tMmYRyLJIX3GU7vP2bshuwvUW0eepQwQOphNmY=;
 b=j7NxMa11ssEfBjSxfQKtWHs8nEo+VQu9NJ8gQvWzvk9/9kDFnyb6aBOQXMNtiXb2J7
 jZ7mk6A+sUmYXf06ifAnMdp/Zv46UhjgjRekWgplIu9nSvW/HnuRgvpnmUJIWYene0LR
 x2xOrXW3eN8fnm2iFGoHYH4VH/hDD6qDSEs4ZLmRMKaQUtCqso2r0W+7ttx2da5lok03
 32cCYQ7imgpMrS5WF6RaIrtwgQMRZthy69fUwcQ5fLs2dFE3VmjNJf0o7cyuP0ighWEf
 WHEUICPCq07UinVZ0K9zbqxrbnYY0p+YhKMxEEfb43HuRlJws/A2qFYdCW+SrjSRlz7M
 Si+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792662638; x=1793267438;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9ehR7tMmYRyLJIX3GU7vP2bshuwvUW0eepQwQOphNmY=;
 b=wtc79sQLpTHcQ+z5sPkkeoveDbQOguT230xaMNOklfyNJa39QrrXKTkw1nvB0SjE0E
 2DGcy1nNaaQmug1qoEr640qHmHYzqChHGPTzT+Ka0dNqx0XMOaNIdKBvps2qZIX6sgDc
 ktB1yemP/PbJS4S91mTAJ7sC2ZvkYBFhJDUaRUbdnFK4m64sTG0q8TLdxS1PewQ/PuQd
 KKbOHNOpbQP30VusWK4vJOIAnM9uTshQJbJs3PUr+cBAGkins9420NNDeRiKOTzzOjoi
 /PT6LZorgeAgLlb/ZpYIFhvxfe43UFmBQq8fvZUo0yYsrc961h67cGGrFfIGHf2RTH9/
 w1xg==
X-Forwarded-Encrypted: i=1;
 AKwUvByw3GSubHkEuOvvpPazK/1lNYErosq3WW3rKXR0hdTUM0n+rC1992UYDpsHJxUQzjV8jK8xKbOaoxo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKzGUnrx0VMSNlkcE53Mwj1y6nSAKu6E4S0OUobu06PvbssvIcf
 dXDemfunKiAckLFWCOP/ilxI0FQL8Wp2gJVB1F/3ODAStl+7EzrbQcr0TZiMteLATP/jMankp5N
 KawcASyyLPRifUBfRDG71J/hxEG6RXnCUiTGJUG0H8Vys0E0AgUvTAHTPghO+Mpm+9jO6C64=
X-Gm-Gg: AYBFou0IfFc9WlQYOSOHmeKLQe1janFWIVQoggJaa6aQeOkaUm5QJecWj62C05vPI8r
 SD5e/BnmYC9oLww029Diyn9W51iQq85xEbRBpyprC6sLg1457+YQUGbGM65I12JDXGqfgH/+GZP
 3+lz1ibdaH8h6nzAYBO8+S327XP1CNinK5Pb9mVwx6+Xv8+g9lsjhaps16y/5c4TTtl58W+Yl6I
 tNzDCp5dQr9vLnI0zkzlWiVRB11mTFUuJSesASNJQdZz0OikSpPMAfGZgaWwSU1MXdiB4VNBQWz
 VeHnkhPOBpKoWeM8bJf6hTwcZgxcqIrPwCLZiNaVuXpDt6DX9Mx82jZgDm0fM5tRo6rEtOgroYR
 iQVLP3SyNB2D3J1auAyfwO3MMG1sm3eCzMSQ=
X-Received: by 2002:a05:7300:ff48:b0:368:6e2a:af3b with SMTP id
 5a478bee46e88-3686e2ac00cmr3365626eec.16.1792662637545; 
 Thu, 22 Oct 2026 02:50:37 -0700 (PDT)
X-Received: by 2002:a05:7300:ff48:b0:368:6e2a:af3b with SMTP id
 5a478bee46e88-3686e2ac00cmr3365580eec.16.1792662636961; 
 Thu, 22 Oct 2026 02:50:36 -0700 (PDT)
Received: from hu-bkalkond-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367417a2fadsm14418035eec.21.2026.10.22.02.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 02:50:36 -0700 (PDT)
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 15:19:45 +0530
Subject: [PATCH v3 4/5] arm64: dts: qcom: kaanapali-mtp: Enable USB headset
 and Type-C accessory mode
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-kaanapali_dp-v3-4-b5ae8e6083c3@oss.qualcomm.com>
References: <20261022-kaanapali_dp-v3-0-b5ae8e6083c3@oss.qualcomm.com>
In-Reply-To: <20261022-kaanapali_dp-v3-0-b5ae8e6083c3@oss.qualcomm.com>
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
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792662591; l=2296;
 i=balaji.kalkonda@oss.qualcomm.com; s=20261001; h=from:subject:message-id;
 bh=WzodycgshZu1zmZaPE3luzfQaJD3tQB9g+hnXzzcEI8=;
 b=4Qb6ct+RTMlJN9XUHeGuiQs/wD4nFaiMZ/8tSqJyLThvnYyeMy2+ICYTPsWXXn4so5/rFjRgJ
 8TB7PomdJ5lBZLYojSQiET/wj8IqXjiJpPE6/vuWXyDgdzKggcI7bk7
X-Developer-Key: i=balaji.kalkonda@oss.qualcomm.com; a=ed25519;
 pk=U+unGox551qPLS2mzIlN+b5cHksxTMGPnDwePd6KEnI=
X-Proofpoint-GUID: -ulnc_QYZu6hvqUxPonzdguhHT79uems
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzOSBTYWx0ZWRfX9cOPVAtH2AcE
 uUQt4F6p2mcCUqqgMBRoGssJxBi44gfWrvrD99tcrWeGEK0Y4El7v0v3B64wy4QX1ulciIeQ2FM
 lL/vq2Dm8l1G4G9s4pKw2sl0qnIp0s4=
X-Proofpoint-ORIG-GUID: -ulnc_QYZu6hvqUxPonzdguhHT79uems
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzOSBTYWx0ZWRfX0+pW1YRqoa4E
 5Ac0Mh1Jc1Q9jFf6U14WTqAyIAVe7UQ2mcD8DdwTzzzCdh4u3rift+Pb18iI2egbBiXcR+oa/Gb
 Tj0LrpII8lrBfpzWrnobfJ9FmpKZ0H54IZDMTueyuEeJ6z6WbMC68XnwTCQzte5eprYv+Vtyh6H
 Uva9QzyfPArvXI+2aNoi+QgzW+ImpoJI4e38JZWl6lqrwcc75R8FvR2iPmMYA80MF9plOUy9ZN4
 d1TYKrV4h0ii5Wggjx0cLLNtWBek0w6CmW6p3ymdRdQs63yoXmzfdZcoUPWUA/Td3AiVvRf1JN0
 TVG0oNgvzS8tVycBhi9DwukoZz2i6qnzdgvO2vtX0GHdXBlhFMbINv+HIWOLLWZsmT+ZMnKa+N9
 wW1GY/ZcPjPOE1+zntMGHQufP54oyxVS/VTm0kf4uMr22RArhzyKnVJbBWM7agCd90CSFZDfUqb
 MhEgwuq/0zh+wuibIAw==
X-Authority-Analysis: v=2.4 cv=dOszC+Zb c=1 sm=1 tr=0 ts=6ad9dc6e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=XqinFhvkQ7oosSToCroA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220039
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

MTP does not have audio jack connected and relies on USB mux (WCD9395).
Add necessary nodes for proper audio headset support along with USB
Type-C accessory mode and orientation.

Set the I2C bus clock frequency to 100 kHz for the WCD9395 USBSS mux.

Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 53 ++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
index 9eb02fd09dab..22eeacd7aecd 100644
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
@@ -916,6 +926,44 @@ &gpu_zap_shader {
 	firmware-name = "qcom/kaanapali/gen80200_zap.mbn";
 };
 
+&i2c3 {
+	clock-frequency = <100000>;
+
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
@@ -1113,6 +1161,11 @@ &pon_resin {
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

