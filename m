Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A5BCA5FFD
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 07:25:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9507A10EBB5;
	Mon,  5 Oct 2026 07:25:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lycGStG6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iZWlWzUm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9800D10EBB5
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 07:25:03 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69510HpE291798
 for <dri-devel@lists.freedesktop.org>; Mon, 5 Oct 2026 07:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OLb5pDtUQOaPF9wZBJMGDGKqDnkf5ns6MI9EMrBQMvY=; b=lycGStG6yYfswiNT
 C3IgCb8flMbfV+2MsAkgnBKw8P35UTlOZlYaljHDObokQHkovcoVx2oQdrY8U4pe
 tq7OOzWLaAzgkYv2/7CZG8Wx9907N7KVMRG9FJFckrD4e9gLIYYKMupQdg216An8
 giHKj2xRXkwvF4bbKSjOuMf860mJRilyE/dLtC8qJ484My3e1DxuHPex/iW+Xs+w
 hryHHRZtVhLeTibR513+IoKxYqXngTtFeOr5K1hxzSMAPOIgnl2YTDuX6uOs8tbM
 zaekAcExuZWOKaeAaA+LD+nzge742hQww4CYt5HZs0bHN61uBOdCpCfCySD1p/JU
 kNCFPw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xhs13g2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 07:25:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3a47a81e70bso1481840a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 00:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791185102; x=1791789902;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OLb5pDtUQOaPF9wZBJMGDGKqDnkf5ns6MI9EMrBQMvY=;
 b=iZWlWzUmyYocEd+IajzvATQCT6q7miOtBqMwOB29Z+CSIVn/dwHYqSE6K5RVPE+PW1
 TZcQ2vu9HNok7LstFOgdjUn18aNSSEEkKBl1hge7BBsMYYb0vCmp+Wxkszjx2fZYh0l/
 XiIWb8z9MGPdt50yApEVUKnYeWLLaBvhygQavuz0DTR8opSu4eiOiji8dTTDvqPfdIu/
 tPNFXmmprdRKGjEgwPxiuTvWN0XlTxERGW4LQSRumXN+JRBha8Bx77MLSGTXvQeHU5Gq
 3xhoATSSJuoc2HGAlEkOsCZUsMsLJjouZDR/ED+wKFAju0N2Ncy5qUhPaU7fdANITELI
 GU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791185102; x=1791789902;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OLb5pDtUQOaPF9wZBJMGDGKqDnkf5ns6MI9EMrBQMvY=;
 b=TGd7ld1EVJ+MtPEFRbRBtuaS5i3kvndU9+J4DeSVrXm8nMapySFwBrp4STagdZlhff
 QgaPGVXy10U+pQENLh9cFL1KlN3PW2L9vW5wxa9fqjYdtj+gTBqrvnCrv04n/3a6pOli
 hBEsf7V2NDzKK26Lp2Bu/ibLhbsLbqTdtbrmZR7Z9bYBwDWRoxZPhAy6qMWug1z6XS5t
 zawujX1TrFg3OOCTNy6N3UvOxEX2lp1qHG078ZWU/d9tSUPJ7thwrjg97e+YDXTTIhxm
 xIJQiCaUcbxmKtuivMKpAYdBJP/kab8XTKxUnTobyRI4apdhjqxw8Hdz3GoS+HQYLGOE
 wsPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBySMmfS6IIMk6ZLQpuzlR7FZ50nXsEJftb7w24uJyaGvCy49RdqJlHG97duoTP1924oyEsXH3yeTzM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL973igVxxqzs9N6F5wdYrBv0RmC/TLyujEjaje7XAN42030fnp
 lctu/wP1x/aq2LEI677Dx0WE0ju8Gyam7nnbfCK+EIl36RSy02EeBj755qdNh6SlzwhvQt7349w
 gI5mPS5GvkWs7Fjp5M2kZ2Ll8UGBj7SEF6JUcx8qHXOb8iaPv6yKVVVQu3QYXN70PDWk6BpE=
X-Gm-Gg: AYBFou1R57j089o4TGkqLNb6mT7/v862qB5bGI60MSwDH90UhP0sNb4xZUHMo9WYjYl
 OPeoRtR1xnYhZv4Nkm3lhGZxy8879N+bjAVxVJG5Hgb6OzEWAlHyVrN56gULFWxX72Tdb82Q8xS
 c+C/H4qo2CgjfqrUFlLOsViWiIDFoHMGQLaX0Ghy7mxHZiQh1EtdxcL21fwTkHRFydNXf+nL7ci
 QpvLJ6hO2XQpZtb0105i35zVPXqGdU0AJ2fdQCjKZi/buGkB13Nrn/z3fE4phusanOINNG9ZtcJ
 OLfO0MewoahpMC7sYCTW2w1m+Lj/lUkcUHVoK6DsGI57SLQwc5S2I/kYJ248oqBxRHM0Qt7rr2Y
 Ctb6TUV79OW+C5PhVFJNIKpOSaRdyRQCn14A=
X-Received: by 2002:a17:90b:3c07:b0:3a7:9fdf:f60 with SMTP id
 98e67ed59e1d1-3a79fdf17e1mr3283246a91.11.1791185101442; 
 Mon, 05 Oct 2026 00:25:01 -0700 (PDT)
X-Received: by 2002:a17:90b:3c07:b0:3a7:9fdf:f60 with SMTP id
 98e67ed59e1d1-3a79fdf17e1mr3283220a91.11.1791185100963; 
 Mon, 05 Oct 2026 00:25:00 -0700 (PDT)
Received: from hu-bkalkond-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a78e4f3911sm9901421a91.15.2026.10.05.00.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:25:00 -0700 (PDT)
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:54:28 +0530
Subject: [PATCH 3/5] arm64: dts: qcom: kaanapali: Add DisplayPort
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-kaanapali_dp-v1-3-6faeac3a6d59@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791185070; l=3560;
 i=balaji.kalkonda@oss.qualcomm.com; s=20261001; h=from:subject:message-id;
 bh=pp707mFFIsFOhojrFXFJDmxlQS8mlwPfd2cpcTElHgg=;
 b=z2L87++pOyLxWbsPAX3pnL+nVhC97yCtc2jN6m0+st48uoNgWCwVgLBSSfdz3diouBTpIEHZa
 93Ug54zFV1UDBkOAyGQTgWeNP3uLcUdVXHF57JoklKDvuDYFmK6k2m/
X-Developer-Key: i=balaji.kalkonda@oss.qualcomm.com; a=ed25519;
 pk=U+unGox551qPLS2mzIlN+b5cHksxTMGPnDwePd6KEnI=
X-Proofpoint-ORIG-GUID: j1IczrKPv3ji8zwn4CrhOMYXUw8TM7fB
X-Proofpoint-GUID: j1IczrKPv3ji8zwn4CrhOMYXUw8TM7fB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyOCBTYWx0ZWRfXxBeZo5ocssxg
 Yz0IvVVBCq66mmPONduDTanqPKqzdjM1sTjE459y8OIypv6PU3yQOOBl60xK4DcbGwUtweIrMkT
 jYC3m4P3QxbAwEz9C1Xrv0mg5pbpH2g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyOCBTYWx0ZWRfX7Q1MmCBtj4F2
 Sg14kTpvBm0yFXDvksuFN8LJtq9UsW9nOQP2d2yq5gCc03uI/UVisFoSQRCiToGeyJDEgcyP2Oh
 uBxp1ohYPc8FqCsVsXW79QtIrN88sfbjzkOZQyOlZC4OvmIx1RfCvlDzZ+cm20D7bbbGFfO2kMK
 ZARyxUmNA0GR2sch8CP3FDj88J+KuSIZw3ysIqagZv5lzF7lFVspmOBUKlCuvW4ePUtfyD0vxbQ
 aC0LGXqR+kz2zmgOPhuCsrxDetVNGr6DxPuWddX/5naNYMVtt1f7dkJpf/m4Fc4JPvKQZ/ER07b
 Z6B8zL2YLHHHmqvaqo8dwaZD73wdLq3WxZMR32/QJUUsUSqpXRy4sthu8hUOsGpCJXc6EFj+/kj
 uloUudgXv/N3w+5WKoyG9wnnLLe1nx2G2nNqg4W5X+K7oeinNmyJTVBDicOwS4d8Z6/etP1WeoP
 Ogyv2aS0+VR01ueAFrQ==
X-Authority-Analysis: v=2.4 cv=Q6tHcI2a c=1 sm=1 tr=0 ts=6ac350ce cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=InTVoh-5CTnzAY78DgIA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050028
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

Add device node for the DisplayPort controller, its OPP table, clocks
and power domain, and connect it to the DPU and USB/DP QMP PHY.

Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 87 ++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index e48a179d0722..155c590c8eb6 100644
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
@@ -3851,6 +3854,86 @@ mdss_dsi0_phy: phy@9ac1000 {
 
 				status = "disabled";
 			};
+
+			mdss_dp0: displayport-controller@9ad2000 {
+				compatible = "qcom,kaanapali-dp";
+				reg = <0x0 0x09ad2000 0x0 0x10c>,
+				      <0x0 0x09ad2200 0x0 0xc8>,
+				      <0x0 0x09ad3000 0x0 0x78>,
+				      <0x0 0x09ad4000 0x0 0xa0>;
+
+				interrupts-extended = <&mdss 12>;
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
+
+				clock-names = "core_iface",
+					      "core_aux",
+					      "ctrl_link",
+					      "ctrl_link_iface",
+					      "stream_pixel";
+
+				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
+				assigned-clock-parents =
+					<&usb_dp_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+					<&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
+
+				operating-points-v2 = <&dp_opp_table>;
+
+				power-domains = <&rpmhpd RPMHPD_MX>;
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
@@ -3860,8 +3943,8 @@ dispcc: clock-controller@9ba2000 {
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

