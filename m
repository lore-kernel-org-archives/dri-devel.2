Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4101ACC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 687D5112276;
	Thu, 15 Oct 2026 09:55:46 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 700D511228C
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:55:34 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9jOuX2114143
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FdpJmur1cLwxlK1AYe1iK0UFkAUb6LqrJNBOhmCKcYA=; b=CUr5eOl0ecNhC1ZV
 fGt0OCv+vNt6FcYNmX2qwHHrZnM6Od+//98F/5hJVSvGLFYl1y6KbHS7peMsVYeA
 OVz0yKdPSMamlHqciNGBV5bf7Za1fGrRhvSq1YBx8dwo4lQH9pH2BddF5ShyZYeb
 IPh1Qsq2Wc/nO7o+lFuzyTRPUyWYXiNSRgwf7DOipHZhCsHM4EYdfxMw5hfs7BKE
 FDpW/RG4Sh9PRMsg9oeOErMHFhX1D8tPfPUIgKCmBCZ11pDf4skWFrrH8QfFLIvK
 /5U6XM+W3OlH/8kAHMUws7s529fGB053Qn99cswDsK3WwXdqf5QPgzqNkyww6Xg9
 HgVKcQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hajmyadsf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:55:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2df8d1e91c9so97595855ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 02:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792058133; x=1792662933;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FdpJmur1cLwxlK1AYe1iK0UFkAUb6LqrJNBOhmCKcYA=;
 b=Xl7YbBY1xXnr3QTtWV2c9d9RFhx2hat2DTgDQ7/vZ4CXW2ZXiBndRzptzJG6mrVdtL
 Y2jlAYWy1SQ0HOjDIbiWe1IFKxYGGX2p5WOR5Qdop8Ww5UUqp+8CM3LulnZYkSsljHNb
 mMeJm+0cI0DOd0VI55Au34cFKJaGgFhk3pgn4jByXuJcE9LaDfOS5Qd8UbkTuq0eeZYe
 T8eQzp10zaXMKbZn8LRHiMxAir02Jp/G5Spyd2L2uJKJKi0VCH57dX1Slg07M8mDKyMV
 f68HvTQJHTSQ3j19oaxP5jrmKHR/64H2pZYaUjIoU/Cgh+BAUgPKGBNqCCS/59D4YUbt
 T6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792058133; x=1792662933;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FdpJmur1cLwxlK1AYe1iK0UFkAUb6LqrJNBOhmCKcYA=;
 b=0Vlrs8lTM4+8W/gYWPPUmeUpFUEVjKiGtnfJ6MpzOjvnXzXAuG3vjl+6CBjzJrSJ4q
 SAghwrAlYSyxtrZrQeFDBbjyjGE6nKtwOBHy9x2coH1G9gm401ea3O+zl8dclhxLgABx
 5g24W/116DJ4wmCNn6KiibGZo2OiRXDR7Eq0xs9ZNw1RCIVndJujqmBoFVJ7lwdfxt0Q
 wjnYhwFoTlAKOXwMhZDwWxVGJdqlJw9yuigNZyj1QnozDeVkweesjRwcVly9H6ki7GyZ
 ozeclDU47BIDRb0RBT8SMNkEA2YGpjh9pA3OEBctliHhUENWtuPNn0h5KyiH4qbD1cE6
 bRlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLQ9gx7oEk29CqkkEMLE5z9g4mTz80tE5ZfxBpPiV1V9JpEEy8B6fJvPvo68t18aa42SK3CbiVB64=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLljNs+6l1oPw+OR9HMKVdAfUl/vvursbbCJ3udpAMnN9sUOQWn
 cVtt1zlPaOYewTlCYEV/LQMshQN2pKhsHSFU/ux7h96+sLmje6SQ/P/wfp9y09vkk0LxaaobTs3
 nVtg6Tk84fBNYKOUmcC/jEz1VJQVYdpXJKkeHPRI+tU7scnNuMvKyGBuDESe6XqY1RHS+Au4=
X-Gm-Gg: AYBFou3uiwQ1WUdVfq5Zj2kj531r1ylHYnzkbMwMibLSCHzBxn+D1j5khDPGSpJjtmm
 Qoy1KkAKv0VadHuHa7vf1Oa2RZM0u0MdBF0vPdZsHkVZq4rnVELYRxblrH28gBJH1RE29WHvhCd
 8XPnhpDqkJeyLf6sspcqDbBehTsde3k4cNFSbAb27+V/NV9piKhk4edefn8m0crZbRdbou+9oAa
 i12LAZtbaf580g+VLmkVodJlSiZYR+9mgXu9GphC8Mj9IfuAxFeavQOFZbUbhEoEAR3WeD9u3Ep
 +8n+C/PHkwbUC7PDQWBz7LZb9+zli0SrgBE8TqUTe2GG+TZ4KXm97Se3oocjQlF3a5u3eyk9See
 3pOquwvAJWD76o06eLJpz16M68/qEFJhKAx4X
X-Received: by 2002:a17:90a:d006:b0:39e:53a:c8d4 with SMTP id
 98e67ed59e1d1-3ab3a90e57amr14625987a91.12.1792058133083; 
 Thu, 15 Oct 2026 02:55:33 -0700 (PDT)
X-Received: by 2002:a17:90a:d006:b0:39e:53a:c8d4 with SMTP id
 98e67ed59e1d1-3ab3a90e57amr14625966a91.12.1792058132599; 
 Thu, 15 Oct 2026 02:55:32 -0700 (PDT)
Received: from hu-bkalkond-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac943e1a11sm3612322a91.7.2026.10.15.02.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 02:55:32 -0700 (PDT)
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 15:24:34 +0530
Subject: [PATCH v2 3/5] arm64: dts: qcom: kaanapali: Add DisplayPort controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-kaanapali_dp-v2-3-c15cb83d9140@oss.qualcomm.com>
References: <20261015-kaanapali_dp-v2-0-c15cb83d9140@oss.qualcomm.com>
In-Reply-To: <20261015-kaanapali_dp-v2-0-c15cb83d9140@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792058098; l=3871;
 i=balaji.kalkonda@oss.qualcomm.com; s=20261001; h=from:subject:message-id;
 bh=Jy6v2m2vqJXLK8QjgW7m+qBuTZEr3IapndMW3EXkAC4=;
 b=VDvO9b2BErkTB1pKJBRD5nt0KHjG/0FQmM5brWugmp6QZw2dTF5P0DGGr4ji8e9dCEIZ3LeWl
 PdFGDuZ8q1DDN695Hf2flBAKLPacgUJUd2FJlVMXtWmsom1xU7KUl/3
X-Developer-Key: i=balaji.kalkonda@oss.qualcomm.com; a=ed25519;
 pk=U+unGox551qPLS2mzIlN+b5cHksxTMGPnDwePd6KEnI=
X-Proofpoint-GUID: ujBJH7FpqmmGk-LfcqQcQAugoX2ByWuH
X-Proofpoint-ORIG-GUID: ujBJH7FpqmmGk-LfcqQcQAugoX2ByWuH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzOSBTYWx0ZWRfXzV16JsDjv4MP
 XzfdZbOdd4TqnoA351OvF36n0nU2/w4cJRh5oNbOnZgwXITtSlv4ySaKIEg1zb5FR4qOupYEELJ
 5dcRsYezu7KawsA6cbVBb1d8a99ZIok=
X-Authority-Analysis: v=2.4 cv=TbQDJhQh c=1 sm=1 tr=0 ts=6ad0a315 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=CcA5yJ8BMwMt8-iLN6QA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzOSBTYWx0ZWRfX5h2AwH1ZjbIQ
 oqUx0hZT6dani9DqCRqJQfUr01+8ORgnt7XgtpwRuXn2we4jiUcRbekLsKA7J+nZaVgfJ/6a0mf
 JftCNlHB65MTSdxTsHi8CyJHuLCSYl7esT0ge0im5aVeyH+6UOR+LJwD08AaaszT9pAY3ohTR3T
 ky7M0TJZ1KjM6qdYH2ZLxdqCIodUs4QEiSiSVcflKb8cJeo/QR13iHz8UhqjUociyZiXjtOrLNu
 IPXW5zAptZicWxjvr+uhEqdsdLh9P5JXCRrgVLCyWdZgRuAp6F33WBrqQgQEYlBfmZB2HmcQ8SA
 dKWWGVskg0h3oNeiI4xDrhMf8c17/ASTceuRPeSyOkm6eKxL5fb7Cr75eTqbMZHd5AwGt48CSNf
 XKfoMsyl3RJXbOyqmv/M4ae6u8+qewbWHzoy6begw4+L38A3bcC7XWhIki7CpYIRkGjq9xRKQBN
 OxhaLjwkAoVerLWvSnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150039
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

Add the DisplayPort controller node, including its OPP table,
controller clocks and power domain.

Connect the controller to the DPU and USB/DP QMP PHY, and enable
mode switching on the PHY for DisplayPort altmode.

Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 91 ++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index e48a179d0722..de856c595936 100644
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
@@ -3851,6 +3854,90 @@ mdss_dsi0_phy: phy@9ac1000 {
 
 				status = "disabled";
 			};
+
+			mdss_dp0: displayport-controller@9ad2000 {
+				compatible = "qcom,kaanapali-dp";
+				reg = <0x0 0x09ad2000 0x0 0x10c>,
+				      <0x0 0x09ad2200 0x0 0xc8>,
+				      <0x0 0x09ad3000 0x0 0x78>,
+				      <0x0 0x09ad4000 0x0 0xa0>,
+				      <0x0 0x09ad5000 0x0 0xa0>;
+
+				interrupts-extended = <&mdss 12>;
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL1_CLK>;
+
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
@@ -3860,8 +3947,8 @@ dispcc: clock-controller@9ba2000 {
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

