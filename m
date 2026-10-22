Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC89E606A337
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LPG0aXT+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KrWfZIKT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 368A5112479;
	Thu, 22 Oct 2026 09:50:41 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41CCC112479
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:50:30 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M70Em32516156
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0BSM0N2JW8/qC2xIwahgqEQhwwj/Oaqli2yB2iYA0Ho=; b=LPG0aXT+wbIDw5By
 zduC5v5SMhALUeA+JfhOhTFI37hZWTIDYx/yZA2vI13KOV+EqLZCZ5LuYVpvbUk2
 anrscltO0pi9+d8IUz7ptn5ro3zruSBBShaZmiFvLOSbUESVGn6MgvXO+ENzvBsh
 yUsaXXdhnrGADE70Gct3X/22TClRJlUuaY+NHCOFxsQZK5bJmCOhxbO3GX1Ub05g
 mk75xBjtLDXVzaCkKcF4wDGyhUz9ioRiWOIF3hVO6uUy65E21IGABaCMd4dKVvUI
 SqZCBVFF2XWv7LZq61FOSImyH0Rw6TlxNTsWBPRL7Apiiw6+X3PGu/QO9+r5RGIQ
 LrY1BQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93a9t0c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:50:29 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36998507c13so34019eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792662629; x=1793267429;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0BSM0N2JW8/qC2xIwahgqEQhwwj/Oaqli2yB2iYA0Ho=;
 b=KrWfZIKT8gDON2H5/Tc1DacdxbjrwigxXNpXWvNZMytvMVG6Ync08sNi4CubfXV22B
 b2eGLTZiScO9U9SqHXY7wWQ8VMPmgvcxHSDIRHCvcBIpO+ubiWfY6rpkMIzgwHgjRz7y
 V+PHpSIc7km7uV40UUU6s/SoJbTy2XU/zwi/LrwJosKlNNXSSlj0ffacAJ7uVIGIc/T3
 SdQIGCax4Vrbb6RxDljKT3ZyrsLsXqiIV0/sn2DW6PE4jxq0NzQsI7HZ+FouBk7PLYDG
 NqKa3YibTJEWX27tAUWxi3lBwH1a38aKAuTYiGFzJfBpTxgg/vw4SoMx6SWXBteKWs6a
 3Gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792662629; x=1793267429;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0BSM0N2JW8/qC2xIwahgqEQhwwj/Oaqli2yB2iYA0Ho=;
 b=m3a32WDeT7ZOlwWLiAWJUuy9EsvbB+hl5Z7fsUJdvPsWINUopLOR6NSYTmGyeWs4bU
 onEdvdemsH6lIOUVRkwjmNWGXXzhO9UV28/rhOCrKExuW/6PUmiuiLhA4dI+Jjrs9978
 64Yo7eHtMPpkV8bZ6Dc18EGD0lmL1dPn8S2bkSm7nKU1POShvQp+vy/58j2uvkh+2nRV
 loUu5jYLmOwjVKW5xKBvMfje+mO4wbU2zT7caqToluC+/Ixma6xTvmHzm3tH+nsGtMn5
 S5q1lkMr2c8Tf9as4baSoXLDPxDA/UHNVhbLcnl+KmxLswPrcZLrks2ECIeJ0hW9f6+j
 +YLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHCfaUUshdBIevjz3lEh9VmtxVBZ2yGAdpFZPHq/DaTvykJvbXmdG8WUM+toKq4FN9jeHs3OKYHMw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJOVBP/bcXhBM3+bwpYawbYcOg+iuW+me+ztqt2cULGqmQAA485
 wRagrV40TpMFJaHrWDxaoM77zdUVu/5gxegl97Vkzdpd7HO8hC6PT/ia23dk++Mse//Q3f60Ctv
 OdaJzIBBTYY2GPqwdW+2UghZ1uDzwQYh+0Z61TpAtdpdU8MGxa0GSoisreDR8unQfl7CUFCk=
X-Gm-Gg: AYBFou0wa+plhyA4odlvCS7UbMFF8ciXC9RSLsPaBexBphTZe2IxukRNBcaQnZ4eVcB
 MUslgw0NJaShj0qwKeOofgVo6Nxp5irV3iI3PqumHTTTkpt44F80GHNPbJtpS1TE2t7l3kE1Us4
 j+2ZwesMqeuFFzqoNK8RPQSc1Uc/Lrzd15HYWSLpVsTICmZt1kv7fXzONv+EIDqumLEIoJOtv+n
 U6jXbqCD+06wSAvyB76Y0HAF+XUzlLN50AOeCTHO4hQ7XPF1FHy/mLr6HZ7QUH8RvZ62tl/OPhh
 SpOo+7muLv6HZVPlYZgMP6VK7ffAfeirXSD7RaY06Cc3h5XTIbEZYfMApRInOa70Il5Iv1rARDP
 uRQAfxZgZVNgoGj7xQYN9Fpaw64gwsd6vOfU=
X-Received: by 2002:a05:7301:2411:b0:34c:fb30:3e30 with SMTP id
 5a478bee46e88-36858cac5cemr3317457eec.7.1792662628625; 
 Thu, 22 Oct 2026 02:50:28 -0700 (PDT)
X-Received: by 2002:a05:7301:2411:b0:34c:fb30:3e30 with SMTP id
 5a478bee46e88-36858cac5cemr3317420eec.7.1792662628073; 
 Thu, 22 Oct 2026 02:50:28 -0700 (PDT)
Received: from hu-bkalkond-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367417a2fadsm14418035eec.21.2026.10.22.02.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 02:50:26 -0700 (PDT)
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 15:19:44 +0530
Subject: [PATCH v3 3/5] arm64: dts: qcom: kaanapali: Add DisplayPort controller
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-kaanapali_dp-v3-3-b5ae8e6083c3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792662591; l=3872;
 i=balaji.kalkonda@oss.qualcomm.com; s=20261001; h=from:subject:message-id;
 bh=kPYPcZOWZuwHUS12Mgjdh0g+aFqX48seESi4efFzydM=;
 b=7lerbAuO+khdCd/pqmyfNxB3meVJT9ZMCEUpz9JyvrHFx7v+qfVZ0sF+uM/K3YcVHpP6xpA36
 Wy/qYQfM3NlDtJqkZeWBQ49J7mlckxdEpqXZ5CXEU+dWWKMszb85deG
X-Developer-Key: i=balaji.kalkonda@oss.qualcomm.com; a=ed25519;
 pk=U+unGox551qPLS2mzIlN+b5cHksxTMGPnDwePd6KEnI=
X-Authority-Analysis: v=2.4 cv=JudkP84C c=1 sm=1 tr=0 ts=6ad9dc65 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=CcA5yJ8BMwMt8-iLN6QA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: CogUVD3I6pTafmLKeMZPgoCu74Efib7P
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzOSBTYWx0ZWRfX9EOMq+wtpvzw
 uz5BJOAsTn+BCSQToXg/Bxx57KmEUaprZAzqFrLa1fAZOW5Be95FxrMbDcA+VePtEsL5riWUC8B
 59GA4TGazbeyKUcDPH7jtviOJTwnxk4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzOSBTYWx0ZWRfX9tCv53LsM+7Z
 9voedURMqmh+HQnpwuTmMFrUTNJTdk878injJav/wO7vLw91+UX/tGjPzmJYIzdEDF1UkGcf910
 H/oI3KWDlExBYvy7M+H0ybrd9CIBr0CzRaWmmB9AHuWEl6ZSDg7w/md2FICYYOs/B8rxu6ty+bm
 OTKHLVbVf2Bhy3jTkKiaJO45LKmb1BmlgkMFDIyBe7fc1Fqu6PUtmJzUsabwMCrW/Bk2rchdR9m
 7oRmwCsRXrTcgso0J2Yx+YKokDGJ7eadTITjbTFlBKS2YzqLbgpnFlplCbgWW0MTVGmgrE3Vj2E
 /VUtsGPnHuVTgJ623HYiEki0dCf3rXfIAt6izuKQVvYKl4TqKGt40ldaraZSWfI4pK2Y2rvyUpA
 EvyZnYMUwc8m5lSH8th6Cm2LBPtp43lNy3yLC/FC6pVWm2Wh7AQpXX2bmdy5XEi/BzSw91ZMPDM
 t0/JwT01OeuHdmKk/cw==
X-Proofpoint-GUID: CogUVD3I6pTafmLKeMZPgoCu74Efib7P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
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

Add the DisplayPort controller node, including its OPP table,
controller clocks and power domain.

Connect the controller to the DPU and USB/DP QMP PHY, and enable
mode switching on the PHY for DisplayPort altmode.

Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 90 ++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index e48a179d0722..ee1fa830b6b1 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -3565,6 +3565,7 @@ usb_dp_qmpphy: phy@88e8000 {
 			#clock-cells = <1>;
 			#phy-cells = <1>;
 
+			mode-switch;
 			orientation-switch;
 
 			status = "disabled";
@@ -3592,6 +3593,7 @@ port@2 {
 					reg = <2>;
 
 					usb_dp_qmpphy_dp_in: endpoint {
+						remote-endpoint = <&mdss_dp0_out>;
 					};
 				};
 			};
@@ -3699,6 +3701,7 @@ port@2 {
 						reg = <2>;
 
 						dpu_intf0_out: endpoint {
+							remote-endpoint = <&mdss_dp0_in>;
 						};
 					};
 				};
@@ -3851,6 +3854,89 @@ mdss_dsi0_phy: phy@9ac1000 {
 
 				status = "disabled";
 			};
+
+			mdss_dp0: displayport-controller@9ad2000 {
+				compatible = "qcom,kaanapali-dp";
+				reg = <0x0 0x09ad2000 0x0 0x200>,
+				      <0x0 0x09ad2200 0x0 0x200>,
+				      <0x0 0x09ad3000 0x0 0xc00>,
+				      <0x0 0x09ad4000 0x0 0x400>,
+				      <0x0 0x09ad5000 0x0 0x400>;
+
+				interrupts-extended = <&mdss 12>;
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL1_CLK>;
+				clock-names = "core_iface",
+					      "core_aux",
+					      "ctrl_link",
+					      "ctrl_link_iface",
+					      "stream_pixel",
+					      "stream_1_pixel";
+
+				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC>;
+				assigned-clock-parents = <&usb_dp_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
+							 <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
+
+				operating-points-v2 = <&dp_opp_table>;
+
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+				phys = <&usb_dp_qmpphy QMP_USB43DP_DP_PHY>;
+				phy-names = "dp";
+
+				#sound-dai-cells = <0>;
+
+				status = "disabled";
+
+				dp_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-270000000 {
+						opp-hz = /bits/ 64 <270000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-540000000 {
+						opp-hz = /bits/ 64 <540000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-810000000 {
+						opp-hz = /bits/ 64 <810000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+				};
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						mdss_dp0_in: endpoint {
+							remote-endpoint = <&dpu_intf0_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						mdss_dp0_out: endpoint {
+							data-lanes = <0 1 2 3>;
+							remote-endpoint = <&usb_dp_qmpphy_dp_in>;
+						};
+					};
+				};
+			};
 		};
 
 		dispcc: clock-controller@9ba2000 {
@@ -3860,8 +3946,8 @@ dispcc: clock-controller@9ba2000 {
 				 <&bi_tcxo_ao_div2>,
 				 <&gcc GCC_DISP_AHB_CLK>,
 				 <&sleep_clk>,
-				 <0>,
-				 <0>,
+				 <&usb_dp_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+				 <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 				 <0>,
 				 <0>,
 				 <0>,

-- 
2.34.1

