Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EC9C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B84BF10E507;
	Fri, 28 Aug 2026 14:06:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VwCD4dLo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FKVnK7JJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFBAA10F3DF
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:59 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDkbHk3075307
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7S42qkfhoToVEYy/FsQ080jT2C6K7HXx1NfxPU2yAE8=; b=VwCD4dLoAzD8N4dr
 LLUEvS2ahZRwbDsYPXkb8GI1OEVLwv1y8ArrGOd+5h0/FX22zw29Ck7jZMFy5LCV
 TRKniVInuRMhWTbUrH1epIu2notpicVY25m4JqBOmH3Z6Ro2X09ORiyFKHykj+X7
 bAfy/tM6bVMKAC8s8WyxlrRrfX1qm4/oFwnF0aP2iq00BMYvZgP7mcZuzfy/ji/Y
 UJMQNARJSm0nVp1IKICpIT9xk2+jH6W2QNm7EesVdeh3NibnHH3wT+LcqrWrmTSo
 ZYan83EWZD/Vz2VYf1mEhGqUPa7KLcE4DapI73IEDQwPI/omNCw9h6cjWYNgHs1B
 RDAoyw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb1v3ahja-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:58 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7475c666b20so862276137.3
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787925958; x=1788530758;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7S42qkfhoToVEYy/FsQ080jT2C6K7HXx1NfxPU2yAE8=;
 b=FKVnK7JJtKkM4+Nm2V/03ON3eJic0OE4QEDdsg9/ayjXKYv2doem+JlWgmB8saMoUH
 waxWfwqp9a3EUwQXfwQWwiGs4VVtfNOPCpbnyKOAcN89AVEt1hDYN7QwM4BUfRGG8AZT
 AqbSIY783OdtJ763H1d+le5b26dZZA57shxMoCcv0eCBkBWAz/HpAW1MRmQQzGYwe2PY
 5D1c+ozixSIMfK69z54bQfXtq1RjcMO07URNpgTRwQtdLbBjS0wWTEwnxLCVHc1MGnaQ
 dgoN/+7EKsRIDhq0l6me7Sq07ocF619vzgSWCQidU/L4R02DhM/ZN6EizeEmUnCtPr0X
 wVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787925958; x=1788530758;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7S42qkfhoToVEYy/FsQ080jT2C6K7HXx1NfxPU2yAE8=;
 b=A1yxqrKmho2r8/Xhi/hWjHUeX/WpWmHEG4QJXBCO1fRieo1fEDo7Npwc6gvdvZgseE
 07Q9HXyi22i3PARDB3UXFwNidfaKpGJVt7V7b+1Ma58SMjx58A9KMMfq4kR6e/cbGzos
 qCnF1Qz3lknxUTJCGOAqpMHAontAit920aGr41Jz3rm3G3hdlZKzKkhTfoZvh/XUKC9i
 fw8D540zfpZ6SAhZRDsVzH1H1NWgRDA4PsrFBSlcrtOzAHhHuACoJpxFRfiWD3K6/jBW
 kaXNYWLkDzdP281h5rStFQ9lR8n+exsflkG7mCPMwACCmGisLk0WhyJ/0xabjL5ajQxe
 kofg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrdlximUclrd2VWYUvLX7DbsXINDPEw+QlAI28vprQZZXdjFvzaZuthKAY6G2OpUyPPtK/+R+9TuoM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mWNfww0E4TC9tpmY9XrkFvO/GQcgHabFy+CoWVA1jfd6MSGNOZ
 Kmolu+h85JwzjLe4GSZlY51z4dQsidDG7qfiOBYjz9WyVxqb+0snP1FBec4JPSmpjsO/0CYXzIa
 5icyy2n3d+1biDtcwgx23IYxFfV2T15iXBYR8+h6jzHbtnBK/jbQf9rSaZG4vOkzk7FnfbI4=
X-Gm-Gg: AR+sD13rYy6hw4NU4A2zbjQ7G81gMQq9RK5IljdTo4osuYsJATomsbW/+qsu+gHYvVP
 Q8iFRuXvVmJh+zHUZeAXI/0XGRF8dUHurasNilbITI3afp46A80HqZ2xSP4+auK8ZhsehUg1Nfw
 jzaR9mZ8aPKZWsOLCjR79UlWcG/9/Q8mJMILuZBhQjDPpTpx75mlxnvEPR4NsPp2BvGdjk5/hwh
 Ng1uePPL32UWKMFY+AsRwyruU0KtlhlWqj0PGK2tnY++Fu16Lf6Lzx6nWsMzXT7LRi06BrATwy3
 jpYF6aNrces0LJaXMwwkLOZrwZThQFAY+fSt2JAPKAVMT30q4mtwkE/Xaa3NyXf3AiT7KSbM+jq
 JTN0d2BkHFijJUjVP6pfXu0g=
X-Received: by 2002:a05:6102:14a0:b0:785:8f76:654d with SMTP id
 ada2fe7eead31-7859996dea3mr2555576137.13.1787925958208; 
 Fri, 28 Aug 2026 07:05:58 -0700 (PDT)
X-Received: by 2002:a05:6102:14a0:b0:785:8f76:654d with SMTP id
 ada2fe7eead31-7859996dea3mr2555540137.13.1787925957739; 
 Fri, 28 Aug 2026 07:05:57 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20122sm3908633f8f.20.2026.08.28.07.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:05:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 16:05:09 +0200
Subject: [PATCH RFC/DO NOT MERGE 11/12] arm64: dts: qcom: eliza: Add HDMI
 display with HDMI PHY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-drm-msm-hdmi-eliza-v1-11-67843277de17@oss.qualcomm.com>
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 linux-phy@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3332;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=1brovUppJvb6ttZNs7kwMEVpoh0akbg09pFKeVhGO2I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqkZWh434bFUqmEnSRcqsBUTydZhsSgPv4+miDG
 XMlneJoAQ2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCapGVoQAKCRDBN2bmhouD
 1wsCD/9Mr2Zz4eadLs8rLbHZ5HLoj8IHcYC6XeDJBJ1hq4JmXgA9jzZ+iJwEmqmCHO+hd3lbluM
 L1ufQWKSIRAP93y/MLCFtw77XbOtvmpCg6nKr1393bd6hMFwzpwJn4E8VlMojR7kl+PnXamsAsh
 pPuK6s6pnv/uY5yZfWO0gMCBdTuwXjpUbpYYnMhP88AgUFUykJ55+9Ba5DSZVAtmK7ZjetkAv61
 I/u2P1IbLdsIKgUUQiR1wbXa0phdVCUoVr8ziBhkOVT60LBNksyXoKjGZPr8EzQpAgU9LUhxJ3d
 TjiM3PLC6Ur1wPvN8ANHOxQtnDkCdY4He9djZ5266iTpV1ZrAHpqGNhbMWnsjXVuTBwv3QeKRXA
 hlppN+whNMClQuLSY12GNHRINbI1bSyh5gWk7bHKsO988VkutbnhSgOnGUTBpjTz1OC5bNaxFNs
 6pPhgIq8plNv3MOhsu6rpno+QcujtZ4y1k5oIFHp0kbkLK60F5WP5urqGNR0sUBD7XmqwmzlyJs
 eFQYX2MnjvFzese4jNfjZHcapT7f6R8OKRxGRH4kP9pOYIkCkzNQ/tQXxUC/gxdnBigh/riykcV
 O9mPclqIeHGQSjF7S2fHOvChM2pvK5j+L6J4aCQe+FpFYpo7edImd/Kub32vtHP1DtbIKgp6Eb+
 0RMxMekt3ocM8ZA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfX/VIZZCHzo3WE
 MbVyQwVDsJof+sjmdRJcd7JQvWvFVPQEcrx36f57KGcarga3WuKb59OcEQBxM1doKO9Vlk2WUjw
 f6X1C0zInv1y625rROQZoO+zbYhoPnBEpNJxZxZVdJ7aKXRpz/a5zdPrCHatgPry6rhPNxRkRu9
 4uNy93vHJFIEGeydzaBOQJ8DfdpfLlwzd04DLolE/muH8PvKwAocssMAloYvtkZmWIr++iIsDvS
 8WC3/FauCqA5CUa5kKhDYMt9tz0PI/pWT1fpkFK+XDzHz2EibNaSrYlQWjh91V4V33rnX6G4X1N
 +pAaxg/HJnY7VLeU6wp1D0eC4gPK8TsuOwVaHFOc2lpiGhyfxWQ1WdILrGIe78k1AesdtsEg+YX
 BoAOUC4jgLyfjw9gP97PdLAecjjvKmigL7qh1Mnc91B3lcTul/G/H4Y1Pf2jMd9iSjJnmfXh3xK
 Ruzxs3GzP61DMp4wuVg==
X-Proofpoint-ORIG-GUID: aIYyDyI7Cil67emBwU3Ad1rjgwpdHpXR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfX2Yrx1JUIvUK+
 ZV6GZulrfb+iSvJce7SCb+egjPdaX7S7JpMUhJ8JTTEMYqnx6iiUyl4vPFTfEiFszIBcLVM5iTd
 iKlJEo0LcGjRQWldCRnnaxNbO3n54vo=
X-Authority-Analysis: v=2.4 cv=faedDUQF c=1 sm=1 tr=0 ts=6a9195c6 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=BhlsTWrtbvULCAht3EwA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: aIYyDyI7Cil67emBwU3Ad1rjgwpdHpXR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280122
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

Add device nodes for HDMI (similar to previous one in MSM8998) and HDMI
PHY (new Synopsys-based block).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza.dtsi | 94 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
index 66ea4aaafd73..27dd15766f51 100644
--- a/arch/arm64/boot/dts/qcom/eliza.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
@@ -2570,7 +2570,14 @@ dpu_intf0_out: endpoint {
 							remote-endpoint = <&mdss_dp0_in>;
 						};
 					};
-					/* TODO: HDMI */
+
+					port@3 {
+						reg = <3>;
+
+						dpu_intf4_out: endpoint {
+							remote-endpoint = <&mdss_hdmi_in>;
+						};
+					};
 				};
 
 				mdp_opp_table: opp-table {
@@ -2805,6 +2812,89 @@ mdss_dsi1_phy: phy@ae97000 {
 				status = "disabled";
 			};
 
+			mdss_hdmi: hdmi@aea0000 {
+				compatible = "qcom,eliza-hdmi-tx";
+				reg = <0x0 0x0aea0000 0x0 0x1000>,
+				      <0x0 0x0aee0000 0x0 0x1000>;
+				reg-names = "core_physical",
+					    "hdcp_physical";
+
+				interrupts-extended = <&mdss 8>;
+
+				clocks = <&dispcc DISP_CC_MDSS_HDMI_AHBM_CLK>,
+					 <&dispcc DISP_CC_MDSS_HDMI_APP_CLK>,
+					 <&dispcc DISP_CC_MDSS_HDMI_PCLK_CLK>,
+					 <&dispcc DISP_CC_MDSS_HDMI_INTF_CLK>,
+					 <&mdss_hdmi_phy>,
+					 <&dispcc DISP_CC_MDSS_HDMI_PCLK_CLK_SRC>;
+				clock-names = "iface",
+					      "core",
+					      "extp",
+					      "phy_iface",
+					      "pll",
+					      "pixel_src";
+
+				operating-points-v2 = <&mdss_hdmi_opp_table>;
+
+				phys = <&mdss_hdmi_phy>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				#sound-dai-cells = <1>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						mdss_hdmi_in: endpoint {
+							remote-endpoint = <&dpu_intf4_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						mdss_hdmi_out: endpoint {
+						};
+					};
+				};
+
+				mdss_hdmi_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-150000000 {
+						opp-hz = /bits/ 64 <150000000>;
+						required-opps = <&rpmhpd_opp_low_svs_d1>;
+					};
+
+					opp-300000000 {
+						opp-hz = /bits/ 64 <300000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+				};
+			};
+
+			mdss_hdmi_phy: phy@aea1000 {
+				compatible = "qcom,eliza-hdmi-phy";
+				reg = <0x0 0x0aea1000 0x0 0x1000>;
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&tcsr TCSR_HDMI_CLKREF_EN>,
+					 <&bi_tcxo_div2>;
+				clock-names = "iface",
+					      "ref",
+					      "xo";
+
+				#clock-cells = <0>;
+				#phy-cells = <0>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
+
+				status = "disabled";
+			};
+
 			mdss_dp0: displayport-controller@af54000 {
 				compatible = "qcom,eliza-dp", "qcom,sm8650-dp";
 				reg = <0x0 0x0af54000 0x0 0x200>,
@@ -2913,7 +3003,7 @@ dispcc: clock-controller@af00000 {
 				 <0>,
 				 <0>, /* dp3 */
 				 <0>,
-				 <0>; /* HDMI phy */
+				 <&mdss_hdmi_phy>; /* HDMI phy */
 
 			power-domains = <&rpmhpd RPMHPD_MX>;
 			required-opps = <&rpmhpd_opp_low_svs>;

-- 
2.53.0

