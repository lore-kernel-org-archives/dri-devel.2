Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45A5C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E10710F1CE;
	Fri, 11 Sep 2026 15:38:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FN7b2rgO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AVGNYEsp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 082EA10EDA1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:38:19 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEm2kF442955
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DROZeLrjFsEoOpdq3MSx8VXdFphleILDmRHCwOjsEHw=; b=FN7b2rgOGLRdbXwq
 yelWNls1Gb0ILWw0J2KIPsxiglGGu52Xfln9X+oiDJ1HHRe36QAoR59emDKLFXJA
 FpZzaSXUGzVDfAleSASezVAVIOx3HYDc7ENWV1hVmnJ93rclu1wMY5GG0sGOupbm
 JZX0tKWvY2YsRRK9n0LbjIsgwbA+43dgv4oJGVgWJ3gf8wWj+DIdQLO1lFvkLyEx
 xlH2HGJKnshX9PlmBx7UDDLiEb1V4KHzmwd7NH3A5sSWrgGO/nUzLiPEaRzKAvRj
 wQtA68+iGNeFY1UtnoqWqas5kXXS+pkwBEVeWR7sl8elLUQnIKPvcH8/NGv0oOIW
 1zSezA==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmapg2ntw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:38:18 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-4519ef1babeso788330fac.2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141098; x=1789745898;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DROZeLrjFsEoOpdq3MSx8VXdFphleILDmRHCwOjsEHw=;
 b=AVGNYEsp+BW8hyCvDVveJCWmGf2w4NSvjy8ltepZzan9119mVCsugq4O7PeicjfO2O
 MFEbnFfCz8j749GvWxNXl5YFs3zgIaveCtCVXGnvXTRXbTXIhYx9BsaMvAECcXTBkpFR
 2xWhjIQnAoSosXkCLbLnFA0/5lHpqdgLbZxdsWxdK2zqF6Nb+mtPz6zbuPapQw4WElmQ
 K3GVzju9Sw9KcPQc+bScXKCHeeOjgV+oSWCB4da+jlsWNY1/oCZtKh0cDScF5b0GEksG
 Xs6jHuu+fCDJwjYKT7DtvuqCwprLJEL4LQJxR0ryJiE2T7LV89EYnR8OCBV/wrBuB3Yd
 GKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141098; x=1789745898;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DROZeLrjFsEoOpdq3MSx8VXdFphleILDmRHCwOjsEHw=;
 b=TwvAZayY7YJCJwioH8Fqfbsn62+9buOtZwXj+gf89lI3WaVd/cqhpsTLF1HTQoVKsT
 dUqENOiPI+IkmGeCmxSIAgHLoV2MvCM/OTjEia7OLaxzLzNRqP8NK/jyOkDH8FIAtDDK
 IOWEiKRqUYaEqtR8kJQqmWrrTxqajhrNgtaMUYOYyblIp5xKjSynnVs5A/UXfSE/DI74
 Ti9aMAADc8lzf2pzkmjNKhysYqCmNPY8RxBSn3KQLkE3wGnUKBuMDFAfeHqqAf9Skvhs
 LUpT3daNA25THk1aemZwNaLfa5g75CTYDjxuL8GbNpqw5vbtTqjXlHeAlZWtwpJkNlUS
 1phw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8w4VSDqLNTwK8fsdNB4yIqWfm12Cz7WfZSd8zVdhClk+DjzpqyKgD346pIQUYJ58G3hXY0BT3oSQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lf6YT5QzzjU0lI/HdMt0WLBJs9Oua3BKockuE4faulRmFIkuYW
 wMPmmnzIsqIFOaGL87chP58fmaMUluR8V4F/JKYdGSEZnjovm734mMhe9WtFfadu8xI72kBWEW2
 kGO8dRy3nkt0xw7/vythlOs7izlEf69brU5gzAScKAGM9x3MWKl9q2+1cMw2H8BRdgPh2Has=
X-Gm-Gg: AYBFou1g+gd0wgMmq0ky9LSNZUSsOkR2VXxBz6x+f4OGfiAnpdq/qhHIM+ukr/16C0U
 xEh9wGccIImzSG32ZUVrPSm7svKW2b57yPKOtDYqLDZX5lYtRo7wKNEhrrKVW6y2bXHosD5PiMA
 0LAM43jrE6teJ+S+Ei+0uoUO4vPo6t84QDkXMRtw4bnu0XHqejhqe+AfnwyU8OZptSk83PPkKvP
 GCfYObWLc0MQnZa8dl5Y6uXyBxqrEjG0ZvV6rB73FCg13CkFFDsZNdiKohAC/CI2ai7J4l7HwAF
 XxIkhoQ4pr6kez8KxkCeRk/90BikksWpPhDxI/pvZ3YkSpvSiTZu6P5fusCHbFhySWafe7tbyDi
 eCvicqycBFUf9tFBW9AAFxjhcPTw=
X-Received: by 2002:a05:6871:340e:b0:448:7667:2e96 with SMTP id
 586e51a60fabf-47de7836203mr3346173fac.9.1789141097923; 
 Fri, 11 Sep 2026 08:38:17 -0700 (PDT)
X-Received: by 2002:a05:6871:340e:b0:448:7667:2e96 with SMTP id
 586e51a60fabf-47de7836203mr3346126fac.9.1789141097479; 
 Fri, 11 Sep 2026 08:38:17 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df90ff148sm1882160fac.14.2026.09.11.08.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:38:16 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 21:06:39 +0530
Subject: [PATCH 08/17] phy: qcom: edp: Generalize power-on path to support
 per-SoC overrides
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-nord-drv-dt-v1-8-e25c073cf1b6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789141012; l=4227;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=FpM14k9zoSvyybc0wXfwBuVOIjzNap9teV8zKiWlGF8=;
 b=OkS2dOi9eVbTtaegQB8+t+tTY6ndETEabUOuASZ8N3o8BfzK9ic4LBhA3pKKmOE/ajPo8An6m
 OFfAMW/PCzQCVB2CItOWlNTb9ivgJYLkJXRucx0rmEQl1trjPbQxkGV
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-ORIG-GUID: Hl_ndh7-t9emfx8jBQHr3D8c3OeRjs_3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX4QVSM95NUWi4
 M6oltaE7T+jYcWDuOYgnzfcoTa5Hx7tNQZgpP+XcuiaP4TUODojlinpFszwfL3fqrPd9cLXtc8U
 k/dIUm3jCGyHwUt6IqVM5GIPkdbcUTI=
X-Proofpoint-GUID: Hl_ndh7-t9emfx8jBQHr3D8c3OeRjs_3
X-Authority-Analysis: v=2.4 cv=DLoacCNb c=1 sm=1 tr=0 ts=6aa4206a cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=v4S7s_oVI5aw80GBEmEA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX6Xr+cbrabra4
 2x/aOsNRq3u41F2Wc7C+JO2s5GVZUN8e1omLo7BOKdIEihMpAndCQBQWjas2LwfGWrSqmlufHQ8
 5i9gOx5KWazLHp8WOajlefn/+rd1Mxky5MnF2HNClLeIDOHOX8seY/4kfPPRx0tvQjpCnJS/gTY
 UnnmBkfWo/XDeZ8y3EMFTtTc4Is4T2RczRFGLvqROzPUoZ+FJ9eldSEsL9bT/+eVzNz8iEbDw59
 NykA6tJGLvoUI+IKjj0YZt5TlUEXbl67OUpiYqwjINEsoPF4PJVw+PHaVOUn+qQeVaIKpIMUOHY
 dg71DvGu864mufzxQnTiUKuNz8rjzucMTI9Dow0fZPU3pe3vI5qSi86PHIwFefUGib6FQIqIMhF
 4hqjr25PqcfaxNkNjI0rpX4gfwJN6oAIHwfpN04I1WjAIXIveOPmStc9XNfueLyvht0Xo/c7o4R
 wtE7DPJWL8t7fLACWHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
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

Nord has a different register layout and power-on sequence that the
existing hard-coded paths cannot accommodate.  Make com_clk_fwd_cfg
optional, add phy_tx_lane_cfg and phy_tx_res_cfg callbacks to
phy_ver_ops, and add phy_status_reg and bias1_en_2lane fields to
qcom_edp_phy_cfg so each SoC can override the defaults.  No
functional change for existing SoCs; new fields default to zero/NULL.

Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 43 ++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index bf8a17336c7e..373f13b3d6d5 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -92,6 +92,8 @@ struct phy_ver_ops {
 	int (*com_configure_pll)(const struct qcom_edp *edp);
 	int (*com_configure_ssc)(const struct qcom_edp *edp);
 	int (*com_ldo_config)(const struct qcom_edp *edp);
+	int (*phy_tx_lane_cfg)(const struct qcom_edp *edp);
+	int (*phy_tx_res_cfg)(const struct qcom_edp *edp);
 };
 
 struct qcom_edp_phy_cfg {
@@ -101,6 +103,8 @@ struct qcom_edp_phy_cfg {
 	const struct qcom_edp_swing_pre_emph_cfg *dp_swing_pre_emph_cfg;
 	const struct qcom_edp_swing_pre_emph_cfg *edp_swing_pre_emph_cfg;
 	const struct phy_ver_ops *ver_ops;
+	u32 phy_status_reg;
+	u8 bias1_en_2lane;
 };
 
 struct qcom_edp {
@@ -316,9 +320,11 @@ static int qcom_edp_phy_init(struct phy *phy)
 
 	memcpy(aux_cfg, edp->cfg->aux_cfg, sizeof(aux_cfg));
 
-	ret = edp->cfg->ver_ops->com_clk_fwd_cfg(edp);
-	if (ret)
-		return ret;
+	if (edp->cfg->ver_ops->com_clk_fwd_cfg) {
+		ret = edp->cfg->ver_ops->com_clk_fwd_cfg(edp);
+		if (ret)
+			return ret;
+	}
 
 	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
 	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
@@ -1131,7 +1137,13 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 
 	/* TX Lane configuration */
 	writel(0x05, edp->edp + DP_PHY_TX0_TX1_LANE_CTL);
-	writel(0x05, edp->edp + DP_PHY_TX2_TX3_LANE_CTL);
+	if (edp->cfg->ver_ops->phy_tx_lane_cfg) {
+		ret = edp->cfg->ver_ops->phy_tx_lane_cfg(edp);
+		if (ret)
+			return ret;
+	} else {
+		writel(0x05, edp->edp + DP_PHY_TX2_TX3_LANE_CTL);
+	}
 
 	/* TX-0 register configuration */
 	writel(0x03, edp->tx0 + TXn_TRANSCEIVER_BIAS_EN);
@@ -1169,13 +1181,18 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	writel(0x00, edp->tx1 + TXn_TX_POL_INV);
 	writel(0x10, edp->tx0 + TXn_TX_DRV_LVL_OFFSET);
 	writel(0x10, edp->tx1 + TXn_TX_DRV_LVL_OFFSET);
-	writel(0x11, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX0);
-	writel(0x11, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX1);
-	writel(0x11, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX0);
-	writel(0x11, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX1);
-
-	writel(0x10, edp->tx0 + TXn_TX_EMP_POST1_LVL);
-	writel(0x10, edp->tx1 + TXn_TX_EMP_POST1_LVL);
+	if (edp->cfg->ver_ops->phy_tx_res_cfg) {
+		ret = edp->cfg->ver_ops->phy_tx_res_cfg(edp);
+		if (ret)
+			return ret;
+	} else {
+		writel(0x11, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX0);
+		writel(0x11, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX1);
+		writel(0x11, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX0);
+		writel(0x11, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX1);
+		writel(0x10, edp->tx0 + TXn_TX_EMP_POST1_LVL);
+		writel(0x10, edp->tx1 + TXn_TX_EMP_POST1_LVL);
+	}
 	writel(0x1f, edp->tx0 + TXn_TX_DRV_LVL);
 	writel(0x1f, edp->tx1 + TXn_TX_DRV_LVL);
 
@@ -1187,7 +1204,7 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 		cfg1 = 0x1;
 	} else if (edp->dp_opts.lanes == 2) {
 		bias0_en = 0x03;
-		bias1_en = 0x00;
+		bias1_en = edp->cfg->bias1_en_2lane;
 		drvr0_en = 0x04;
 		drvr1_en = 0x07;
 		cfg1 = 0x3;
@@ -1210,7 +1227,7 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 
 	writel(0x19, edp->edp + DP_PHY_CFG);
 
-	ret = readl_poll_timeout(edp->edp + DP_PHY_STATUS,
+	ret = readl_poll_timeout(edp->edp + (edp->cfg->phy_status_reg ?: DP_PHY_STATUS),
 				 val, val & BIT(1), 500, 10000);
 	if (ret)
 		return ret;

-- 
2.34.1

