Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B30FC88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6563610EDA1;
	Fri, 11 Sep 2026 15:38:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ER3OAoWv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a3sSFBYi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E87F10EDA1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:38:39 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEmFe03780696
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 544PPlpv8KTF7vSUH6ehJCfjvM1awtYfBnmsoYrqWyk=; b=ER3OAoWvCqmWe/jI
 ll7qWh1j5p9MBlGXaA7WV0SnB0UqQuwH5qBW6c2AGtqtFNlYIY1J+UjZkYdwAOsa
 sLRZH4yJlKex24p2krfY/R5EPz+YRvrn7yE6imTSrnwIEPgd4Nl+QQjsoRW9gR9C
 v2S+j1JwV8ekBrmuHKoqbBg4zkIpx4QeLkYMU3+Tpb0Ho5dppJxjXpAi73DpgCiX
 hWrvW8X8OBMel/6py9lMCf3EjgCwxoVL47b3mgbzHg41jE6qGT1hZqoObFV2wSpv
 s5exf56Q9/fHHSX3l/qDuZxY7EHWyWAU74yeRbq2+E2TSKB85F7DJRr8hGSNoM5t
 Jt4+Gw==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmcgfj7tf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:38:38 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-466d41a1d9aso1034141fac.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141117; x=1789745917;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=544PPlpv8KTF7vSUH6ehJCfjvM1awtYfBnmsoYrqWyk=;
 b=a3sSFBYiO3u0r/ff7at5YllQOd/WOt5z96c50ZF97wA7vVovz9Za3HwyAJYrN7910o
 tiex8Gl6PmMi3Y1MBHD+LCEDdIlL8XL0aGNSJfVJipY6zj8Z/qxH6JBTfoUJ3i4XjsZu
 qgQZsMDa3HeCcOzwg/RcKWKn9P3q+PfzIkM+9LL32O5vLERo1m1Qycjtc5wjYEZkr/+P
 38sKrBnZm4gBaqu/sa29f9f2RsFC9F9ECGOIZSnCt5zYMZkDgc2w7hvym4M4z2YsU/Hu
 9vmeyvdEa1r24hTK96H0OEq5cY2NDD3sjbJed2qZZPQb/CV+q+Gq+d7vqKDeIWjK2xWl
 ncZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141117; x=1789745917;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=544PPlpv8KTF7vSUH6ehJCfjvM1awtYfBnmsoYrqWyk=;
 b=bzXaSisK0P4rvdKkbPDmjExNZn3LyaG66C/r8EL44NQTCYpiFeOuHVM1rLx8VOoHSn
 ZvBib7DDExYBcJk9CS6HqPSg1sjRb42cFsADCqenW2bbwsvl/+aDiRN8dYj6WaBb+QvY
 PyQC+oeD7UkEiMJ0jjMHLe5Mg7Jd2E+o3plKmiEeKnjwly3mGeCpq8EyOTGqRh6TCZ40
 LMaABZeNj57u45hwH8kLuV9ELXuH/cWijICBOJGJPC2xqPkvhS5bxcu0BTMy7EN4mvt1
 qXGEycu5J03oCKIAFTQpkv8xrvxwYvfiwIsgmDwcHOjKLDDaj5ruvtDPkkSLw5uatla+
 xPoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOtWZTPbg9X9QPnVAeHhfKkY7RZDY5ENe1tacKNIcw8XxTyxo9ZQL/0INwqH8ptUABq7xrzTCY+XU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kCteHZhiAOX+YvCGnLHUepNfiVIVDvJMSFxgjyjdjAJurTrSwI
 VTcYflAS3o2T17jb9ShmQZdFl42IDfO64emEchXcU4td1I9im/HHVtjRtuysffNG/86P4VonC6i
 fpPYM1CVs77r+ug+9Tb+78aU+kx+Wh/cO3x9ZtFNydLJghEQTQtbqWk8dwO1AsGPYOWpoXVU=
X-Gm-Gg: AYBFou0Vf8X7RdNdU9KnBNhseLy1tqYtztiJWoNe6S8YUCErG3CpXrKIq4dYbp5yBVT
 0B6eNjf7PL+KAkTs1hGaBnozMNGmSt1bt+js4lzJl+onn9PE6Em1bhwEzyoS+ZKwuE6fsah8oRx
 fmsL8yb6B9DzxSuD6BCN24onaaeTOe2D72yzwpubLhn9BdUoutINq0Gz1sxYuy3sacTZHdAyTdw
 EUrWreyH/LXK1XUBYdQua/OWABr2Khlmk1VsnFMafZs9sfBMMcwE1CWvQ5bY9VJJ0VQ9VvvpKAP
 PId4MLBUckgcIJ4CU/auh72SnLQiHDcql93d0mC/FHXJIf/wmavVhKycz7+8/YSexXKQEYNnn7/
 Rv+L17y169NjzeQxQfvZKRBBvcqA=
X-Received: by 2002:a05:6870:252:b0:467:c40d:8920 with SMTP id
 586e51a60fabf-47de9ea8d18mr5880849fac.11.1789141117480; 
 Fri, 11 Sep 2026 08:38:37 -0700 (PDT)
X-Received: by 2002:a05:6870:252:b0:467:c40d:8920 with SMTP id
 586e51a60fabf-47de9ea8d18mr5880783fac.11.1789141117021; 
 Fri, 11 Sep 2026 08:38:37 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df90ff148sm1882160fac.14.2026.09.11.08.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:38:36 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 21:06:41 +0530
Subject: [PATCH 10/17] phy: qcom: edp: Add Nord voltage-swing and
 pre-emphasis tables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-nord-drv-dt-v1-10-e25c073cf1b6@oss.qualcomm.com>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
In-Reply-To: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789141012; l=3594;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=KK+JtcaGKxOZhpeU9EbHQrvKXGn1efmjoLj5Q2mLrks=;
 b=P63+IEbelT6qmuz4lPHsT5NeSKlrlz+E6ME+S4QOOsIk+8rALitGMqXYUzsBNWiRFI9pnFPlA
 XvcQzcbL3gfApUhx1lOoTtZlimO5WZzNi145uaaDbw4C1FDhN2O+9Yl
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX4Sjv4qK6K8HK
 iYw3mktkpvwE5cjDerBVyGbkLPcsWgNZsy59wGQKUfmuIs2uPCpXynfPSiTDhBzC+xem8VFmKyw
 8vgZKEV5K6U/hFZMau5+gFl8yMUgYF5oeJ5e8e8jEIliHTKSE+pLAh+a6uWsAQ1abq3IRBLzYMD
 bTz30WM6tp7+MOUF+wP5VyFfh2jELtjgMjVgpfrdQDh97MzyXx58wcU1MuYZQX9w3VyBvpD6Q3n
 pbcd6yIEaDqbz11oa5cIkTxHiI1Ro3Q51nJ7KcG6aK+S/sSxal+3gcGo+JMueu2NqEdU9BjKWdH
 gKzmPFxSeMNmuQWfO9RUbAA3BM5uJyzlLhmpmFmtyhtVAaCz8eyQd+So0nLRVRPFRHxLJLPVW9p
 l5aRqbk/nSp7Kuz3YSjIsgycrgbNpphDFBbGRvc2j0cCuwV5+XFXOF1jQSE1bNLw8InUrOFye09
 cPrEgPeN+Fefy8nhZgA==
X-Proofpoint-GUID: EanGA3-JKeCSbkYcSLFgrdGX6eJGPJ3A
X-Proofpoint-ORIG-GUID: EanGA3-JKeCSbkYcSLFgrdGX6eJGPJ3A
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX622V9xAPVrrX
 wJ89lURAtk04ZTvg6IKK5d1A01HZ2lL+HxOVCVydMxQ8zAjQDvJZPs3ZbBcTcJba/9oMGH5QnNI
 ixEHgS8qjxEzFK4bnroVFLOAg/RmKLM=
X-Authority-Analysis: v=2.4 cv=ULtIjyfy c=1 sm=1 tr=0 ts=6aa4207e cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=1VMeiWxxgHqCBInRz6gA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110218
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

From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>

Nord requires different TX voltage-swing and pre-emphasis levels for
both eDP and DP modes.  Add four pairs of 4x4 tables covering RBR/HBR
and HBR2/HBR3 for each mode, sourced from HPG Tables 2-2, 2-4, 2-6-a
and 2-6-b, and wrap them in qcom_edp_swing_pre_emph_cfg descriptors.

Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 85 +++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index ee0d7f1a90fe..64878398f43c 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -1527,6 +1527,91 @@ static const u8 edp_phy_vco_div_cfg_nord[4] = {
 };
 
 
+/*
+ * nord eDP swing/pre-emphasis tables (eDP mode, low HBR: RBR/HBR).
+ * From HPG Table 2-2: LDO ON 550mV (0x51).
+ * Rates: 1.62/2.16/2.43/2.7 Gbps
+ */
+static const u8 nord_edp_swing_hbr_rbr[4][4] = {
+	{ 0x07, 0x0f, 0x16, 0x1f },
+	{ 0x0d, 0x16, 0x1e, 0xff },
+	{ 0x11, 0x1b, 0xff, 0xff },
+	{ 0x16, 0xff, 0xff, 0xff },
+};
+
+static const u8 nord_edp_pre_emp_hbr_rbr[4][4] = {
+	{ 0x05, 0x11, 0x17, 0x1d },
+	{ 0x05, 0x11, 0x18, 0xff },
+	{ 0x06, 0x11, 0xff, 0xff },
+	{ 0x00, 0xff, 0xff, 0xff },
+};
+
+/*
+ * nord eDP swing/pre-emphasis tables (eDP mode, high HBR: HBR2/HBR3).
+ * From HPG Table 2-4: LDO ON 660mV (0x91).
+ * Rates: 3.24/4.32/5.4/5.94/8.1 Gbps
+ */
+static const u8 nord_edp_swing_hbr2_hbr3[4][4] = {
+	{ 0x0b, 0x11, 0x17, 0x1c },
+	{ 0x10, 0x19, 0x1f, 0xff },
+	{ 0x19, 0x1f, 0xff, 0xff },
+	{ 0x1f, 0xff, 0xff, 0xff },
+};
+
+static const u8 nord_edp_pre_emp_hbr2_hbr3[4][4] = {
+	{ 0x0c, 0x15, 0x19, 0x1e },
+	{ 0x0b, 0x15, 0x19, 0xff },
+	{ 0x0e, 0x14, 0xff, 0xff },
+	{ 0x0d, 0xff, 0xff, 0xff },
+};
+
+static const struct qcom_edp_swing_pre_emph_cfg nord_edp_swing_pre_emph_cfg = {
+	.swing_hbr_rbr		= &nord_edp_swing_hbr_rbr,
+	.swing_hbr3_hbr2	= &nord_edp_swing_hbr2_hbr3,
+	.pre_emphasis_hbr_rbr	= &nord_edp_pre_emp_hbr_rbr,
+	.pre_emphasis_hbr3_hbr2	= &nord_edp_pre_emp_hbr2_hbr3,
+};
+
+/*
+ * nord DP swing/pre-emphasis tables (DP mode, COMBO_PHYS TypeC).
+ * From HPG Table 2-6-a (HBR3/HBR2) and Table 2-6-b (HBR/RBR).
+ */
+static const u8 nord_dp_swing_hbr2_hbr3[4][4] = {
+	{ 0x02, 0x12, 0x16, 0x1a },
+	{ 0x09, 0x19, 0x1f, 0xff },
+	{ 0x10, 0x1f, 0xff, 0xff },
+	{ 0x1f, 0xff, 0xff, 0xff },
+};
+
+static const u8 nord_dp_pre_emp_hbr2_hbr3[4][4] = {
+	{ 0x00, 0x0c, 0x15, 0x1b },
+	{ 0x02, 0x0e, 0x16, 0xff },
+	{ 0x02, 0x11, 0xff, 0xff },
+	{ 0x04, 0xff, 0xff, 0xff },
+};
+
+static const u8 nord_dp_swing_hbr_rbr[4][4] = {
+	{ 0x07, 0x0f, 0x16, 0x1f },
+	{ 0x11, 0x1e, 0x1f, 0xff },
+	{ 0x16, 0x1f, 0xff, 0xff },
+	{ 0x1f, 0xff, 0xff, 0xff },
+};
+
+static const u8 nord_dp_pre_emp_hbr_rbr[4][4] = {
+	{ 0x00, 0x0e, 0x15, 0x1a },
+	{ 0x00, 0x0e, 0x15, 0xff },
+	{ 0x00, 0x0e, 0xff, 0xff },
+	{ 0x02, 0xff, 0xff, 0xff },
+};
+
+static const struct qcom_edp_swing_pre_emph_cfg nord_dp_swing_pre_emph_cfg = {
+	.swing_hbr_rbr		= &nord_dp_swing_hbr_rbr,
+	.swing_hbr3_hbr2	= &nord_dp_swing_hbr2_hbr3,
+	.pre_emphasis_hbr_rbr	= &nord_dp_pre_emp_hbr_rbr,
+	.pre_emphasis_hbr3_hbr2	= &nord_dp_pre_emp_hbr2_hbr3,
+};
+
+
 static const struct of_device_id qcom_edp_phy_match_table[] = {
 	{ .compatible = "qcom,glymur-dp-phy", .data = &glymur_phy_cfg, },
 	{ .compatible = "qcom,sa8775p-edp-phy", .data = &sa8775p_dp_phy_cfg, },

-- 
2.34.1

