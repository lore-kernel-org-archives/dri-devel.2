Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE552C88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 317F710F68D;
	Fri, 11 Sep 2026 15:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KUfMlGKD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bqGbXHBD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5CAB10F68B
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:39:36 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEmYlO3962494
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TYKeXTa8aTR0bTBB6X/4VXQLUl7NXF2imUYHRSL6L6Y=; b=KUfMlGKDCYJUkNK9
 krs5AoW76Ydwk168/8HaKacxnVBbJwBkxOnwJbZLFnOqGLRigS/emZ85a9bHCdMj
 k0fuvdHDWf2T6JDb67KoF58rpj/dm9q6rsGX9WwcRmSUeBJ5mPvFFmGfFcwq/Z5l
 lNCitP0sZucMOzBzOlZyeIkbHK4iedThKhW8Dcb03G6n15biYDgVnDX6ZV5fRpPp
 e2mY8MowwTmW4yjJ5XX+yMUt/xDMX95c7YtmnigDMUn8uciuinlr1AOpzYsWrmkj
 4Bw5MaZ75BX+keYvX83+ZcKSyaWrVJGd8QTRLrVrtkF2IaZ4/o7cqW/RGqFeVNvq
 DFWZ8g==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmfbbhgnh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:39:36 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-45eb9967696so1187062fac.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141175; x=1789745975;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TYKeXTa8aTR0bTBB6X/4VXQLUl7NXF2imUYHRSL6L6Y=;
 b=bqGbXHBD+dhWb0zK7faSzZO1OloBTNGfGw4DUUACDg02o44gDJpHmavXy4GDNk3lld
 IuGc9qhEW0YF7JZPZg2tznnVDpZ8Yyq0t9Uw5WvYe5PkO/1r/T+ar7bWt9ZWbj0fxBiI
 sOi8ZMHJMf05kC4XPUIlgTb+KsRyxl/QnLmocN1cqfxncAf9eWmLR4dB5EhLaT1q9Bbs
 qYCOY5okAKLTUi3Dvf9cqPsZH6FROgtgIK/whIwyOE5MWBK7eINUJAit2WFvlYZ7i65q
 nR5S1pSaebBQAC62A+mtHpiLGdX0KRu8XHKbwTgjLrluw0DuSSRx5ApXoNaNmCaEYGf5
 3X2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141175; x=1789745975;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TYKeXTa8aTR0bTBB6X/4VXQLUl7NXF2imUYHRSL6L6Y=;
 b=bMHMQlfD4ODLGINaqVS5/nsLI7LEn2xpfUPuGOw7XbSo3bwiKP90jv0cmb+RU2RsPr
 DL7Rxvh3v1eu1jE4togdd43g6a9CP+B5aOHRRsfM/rNo8GB6TFV5KGF+0MvnGQJc1XjZ
 LknuiqXBQgu/QFPtmK1IHohgMI1P9JiKvtOdfL/PAkExoms3EQ1GTZY2y52d7XbvMUna
 QCkZVmZzxNUX+NX+I+6ss7RtBiwu1QT0i8GWUGqAc0U7FQv7dbUCyHL6UvTuF2385vNU
 CqhzMY+CMzirHp+oFFuxS8yqqWJm42N+OfhTwYEAEosgkOInu5KbZKLNor4jE3ZOovZP
 FhDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2TTP8LmsaMMV2YibBdM9nK4axeTr4aTyBNcnT1lSR1ugCVD9go1uG6LvP2qv90ir1biGUIJI1lZQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lgSihU49tT4MWAoIxkCrEfmt5BOXpC8yqNgpqHvqsV8f4R4Lbv
 VjHob7UyvZSWw8IYwAQ8HgZ+HO45GZkJCaFe9ulBrhl9Mul+/N9Ulf1SHG7npBcUJtz9ZnRbEX3
 ToHFqBuBl/wAUn6CKNYhMrqoU5UnwPHkUcdW2PFCKtjc5l75u+hkmWNdlMl+mirhLXE5xLgQ=
X-Gm-Gg: AYBFou2WwpS6PDRFwKg8AY2K9ORZQwdJMT4C5i7GVk0K2cEdlfPxljAnTX0Dp0Sz9mM
 vsEAYD7GV9ivlrYOHcFSrX38YWgl42go/xpFKYJMx2sIyUe1cKHWuo7e33GIIhvPHGtl1P3Za7L
 pRCFNOuSsIFa2hvZ3Tk7UsW2yurXSW3aCpXNGSZoduS0HdfrrMXnWJODWc0qjgNGDx4u0de/YLN
 ZBRy7OnTMHFaIi+hSkAIyCe0DOK0HXvbA0qAD1CJJKcdchfIz1tvkhBJz+lDj2GkZj3mgUyfPiU
 EfGtRfGaT/i/JlKLkk9NLim4LAeVaQOv5n0f8DEg5bqID/Hw/T3NKPDgJZViXAsNuH8RPKEu3Ou
 d73jvFcBPmq+a7iP07khCweaE/MA=
X-Received: by 2002:a05:6870:180b:b0:42f:f3b2:e2c9 with SMTP id
 586e51a60fabf-47dcdbbb17emr2893623fac.0.1789141175317; 
 Fri, 11 Sep 2026 08:39:35 -0700 (PDT)
X-Received: by 2002:a05:6870:180b:b0:42f:f3b2:e2c9 with SMTP id
 586e51a60fabf-47dcdbbb17emr2893597fac.0.1789141174947; 
 Fri, 11 Sep 2026 08:39:34 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df90ff148sm1882160fac.14.2026.09.11.08.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:39:34 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 21:06:47 +0530
Subject: [PATCH 16/17] phy: qcom: edp: Introduce Nord phy_ver_ops and
 phy_cfg descriptor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-nord-drv-dt-v1-16-e25c073cf1b6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789141012; l=1972;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=94rmdeySxa5fJHfAGld0di57h9zUDb4Ov4YG7k/0YKI=;
 b=6FCW2hLlHDUGqMX0JBT6HvN4i3iC42y74fuKbeKZlV000G80lciwX8BRZBP8TXys2iqxrET60
 2aPAk+8qpgFBX7hOiipgM7AllTxJBIHmy2S9y05wfDnVnAl+d3FZOnR
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: MMZMcSXAQV-IrLY-PyaHf5ItsWTAOdac
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfXwTUpmNAKNMEM
 TAIlPkVzaIyl9koWm1b+1RJ4OPqc4JM6gDh3VJfxeTQkl6yV8c/a63v1YsrawwBMxb5b/Rxv9kC
 kCVuLoTH0+qH/yKgCcY+2PtCAOC3bYI281LjiCC4Sfo2jVDT7vSbBD4g3t2s23Z97+OKMLWnO5C
 rtftuNL0oJVzCEjlB1bOshBeHtdMPFGjDIZLjcTSct9frpHAZsEsArifZyCMg8TOoD2bfYFW1St
 ph91DET9FmQmyxKJZ2hExdjFt8ia+qFMFsGHbKJ7MgEj5fnTu+40+uRHK4VQ67xrG5chkUCsMNB
 bcmQ7SypsbvOVYisYMRSmwysmbhIPOCZAJ0xEG81EXy5d6xpZ2xhrUrpijEUM+dhIavbrvkPIX/
 Z6hveBKFuEDIF1LX7cJ5PIdVpRsV2+UMwyFUhnI5olIWTGWjJafCSaFUtDWewSx/94Q86UbeS2h
 hRmZVswgtLu2FhucowA==
X-Authority-Analysis: v=2.4 cv=X6jHu2Te c=1 sm=1 tr=0 ts=6aa420b8 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=hnKCH8YYcLMkF2FFhooA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfXzqOf+c4l2wdo
 PhlGjMAh0Os5jn2hKGApCjdXI0FeEvqFBe+KXyAfn6Oa8v97kChXsUuQ8M93CHDZ6TKjXcT9XRC
 2AH07XS9BCMhu5SN0+Av7vjQaK+Ty44=
X-Proofpoint-ORIG-GUID: MMZMcSXAQV-IrLY-PyaHf5ItsWTAOdac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
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

Add qcom_edp_phy_ops_nord wiring all eight Nord-specific callbacks and
nord_edp_phy_cfg collecting the Nord AUX, VCO divider, swing/pre-emphasis
tables and ver_ops, with phy_status_reg overridden to DP_PHY_STATUS_NORD
(0x0110) and bias1_en_2lane set to 0x03 for correct 2-lane operation.

Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 361f4e467351..338f28cb404f 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -1847,6 +1847,29 @@ static int qcom_edp_phy_tx_res_cfg_nord(const struct qcom_edp *edp)
 }
 
 
+static const struct phy_ver_ops qcom_edp_phy_ops_nord = {
+	.com_power_on		= qcom_edp_phy_power_on_nord,
+	.com_resetsm_cntrl	= qcom_edp_phy_com_resetsm_cntrl_nord,
+	.com_bias_en_clkbuflr	= qcom_edp_com_bias_en_clkbuflr_nord,
+	.com_configure_pll	= qcom_edp_com_configure_pll_nord,
+	.com_configure_ssc	= qcom_edp_com_configure_ssc_nord,
+	.com_ldo_config		= qcom_edp_ldo_config_nord,
+	.phy_tx_lane_cfg	= qcom_edp_phy_tx_lane_cfg_nord,
+	.phy_tx_res_cfg		= qcom_edp_phy_tx_res_cfg_nord,
+};
+
+static const struct qcom_edp_phy_cfg nord_edp_phy_cfg = {
+	.is_edp			= false,
+	.aux_cfg		= edp_phy_aux_cfg_nord,
+	.vco_div_cfg		= edp_phy_vco_div_cfg_nord,
+	.dp_swing_pre_emph_cfg	= &nord_dp_swing_pre_emph_cfg,
+	.edp_swing_pre_emph_cfg	= &nord_edp_swing_pre_emph_cfg,
+	.ver_ops		= &qcom_edp_phy_ops_nord,
+	.phy_status_reg		= DP_PHY_STATUS_NORD,
+	.bias1_en_2lane		= 0x03,
+};
+
+
 static const struct of_device_id qcom_edp_phy_match_table[] = {
 	{ .compatible = "qcom,glymur-dp-phy", .data = &glymur_phy_cfg, },
 	{ .compatible = "qcom,sa8775p-edp-phy", .data = &sa8775p_dp_phy_cfg, },

-- 
2.34.1

