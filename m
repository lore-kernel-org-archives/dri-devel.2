Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE44CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4198010F118;
	Mon, 12 Oct 2026 13:34:47 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF49C10F11F
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:34:36 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CBxxjX800868
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MH8WUhN/uk47zXTtBziw108eq20eC3q5Tm23CfZZvYk=; b=Kecer+CPGi5EW48l
 CUbVCVIAcHqQf9LzC1kzPQyKKOtTBOBRgoEzU7SnsI8tZBXTxBOL6BgZoyo7Ybwo
 Bszi8xFwdosh69R2Apl1BjozI7fAkKSqeqsfLxv05A9yZuABl1rpiOoh3XYcSLys
 1TSB/+RaiN00/lqPtZs5Fgp3plGv7g/cGCgqotqXOl0oU2dnahcF6bRynNUx0R0a
 iAb2E0+LbZXVUNruoIJfp36gLJ5w7sZuqZRuNzq/jDlhB5hlVsnFXzZOqlfBCtau
 +8bQ+qdsx/3EtTMWJfG2+Ur1GojvDkYKoS/yMYJIt/KeHO2VtN+rfk2P1c/a34/e
 TE4RlQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wfcrwg0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:34:36 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so5651395eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791812075; x=1792416875;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MH8WUhN/uk47zXTtBziw108eq20eC3q5Tm23CfZZvYk=;
 b=VAFAu+yXnewRnrpXkJVoic2NjgRvcEUupHauqLQCM369kKDCflq3Z1LY1PWWaToyOV
 hnmYMEdbr8iP2ujU5PR+JScjW7QYuYsfxho8im4Smpbiz6fVeYZkggqsIt161wpZ908o
 rSpkjx9/08BoRB8GzeZqaWhk80ARUAGaJkdHfU88MZ7Lwf91T9mZWJ9EjY1Rz2DdIkmB
 XZoax+h7S0VVrQCH2PEe6IdUMyGBapzhk/pnAvPwI7acYkLWiN9tBa4qRpCr+x7ahmqV
 QYBjjRmjWG3YC0ln9T3h6M0bWCesxP34VhYWmtqEpewtPem5o3JyPRLQZO1T9OvgHb9I
 U5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791812075; x=1792416875;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MH8WUhN/uk47zXTtBziw108eq20eC3q5Tm23CfZZvYk=;
 b=I15B5mwwxyIR1xbZH485/RBFyBd4B4ZJ3TR+U/Mx4KSo0DaqDIT02ZQI3Z4lfy62BE
 AVU0En7W4NbiN/2dYc85lzhsRHKZVilxkgAc7DJicpyoryOjsP6AlH7qpWBYCNX6uYAL
 yyPVLqxPXiK7jL927Bzednb6QNxmj1+66aKBRqIrSF8rKBMli58XLsbTcxyrGvVcUesU
 lJNEMEs4CW9WepQAxYhRcPqIEybvS5l4ALXaLsUiEbv/PHmIop4eAI4WhSbSXdSgPA/q
 tKgEiV4stEoVnR7U5Xzlhtpu3je7mrvcOhWuQEN4rvnWrLMsB6KEco/KP7RvRrM7iWh1
 i1jA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4nIN+WNHxXR6os4vSYMhI5WnyiCzXvXf2UrYn07z0Nk0PsBmze7FF7TjiOnno0xPCAZaRpJ6ZdF8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIOOFui4c1ecZ6vJQZxvSON1Gj/myNlR/27k6sh1hiheXoJoU5I
 lmKroYs84GwPmp1OCh2iJr+Xg3UbRebzIxxBYP1N4jKfI22uUEv1U5WqDd7w6mSGQaSbIPkgmRR
 p0cYNtZxH5lz97n+lpE64bY3MsXXgpYjaCBRynoigkAJ/zrbGljbxPog3TRGgVjfZb1Z6gws=
X-Gm-Gg: AYBFou1MI977qWgugAcuPtTWOzDRf7D9pd+FLINnkdIj+4Mhw05sOUoqaRjB1oE8wb3
 x8VgMHhXjkt68NzMe63S+MzsPMQyYW1KTdjs8EONCzGWu5BSrH3BgXDMtH57tWjUEaE8W+t5p9p
 SnCczqKJPooHeHivhUrstLwZ1LFompVEaCBnRH0AXr6E5KNIBuirDikBkg7rnxoTcz6B8Ztr+kC
 mv8ZES8apXE20QJVAiePIDGwbBsr85+dZrv23rsrlrnPSVFNCMERmz8fAeEnVoovnGOmCiWDzOw
 QjwPR+NUkGdUAqLbtZ17mlTnQeB8mJ7OklkPHY+uerOnjd63G1dnCR9Xled1tWd2sOjv0coa7//
 oE+UdJuXGBocJbiiCI/0FbUZuFqU=
X-Received: by 2002:a05:7301:1a04:b0:359:3460:bc1c with SMTP id
 5a478bee46e88-3593460bce0mr7259952eec.12.1791812075393; 
 Mon, 12 Oct 2026 06:34:35 -0700 (PDT)
X-Received: by 2002:a05:7301:1a04:b0:359:3460:bc1c with SMTP id
 5a478bee46e88-3593460bce0mr7259889eec.12.1791812074536; 
 Mon, 12 Oct 2026 06:34:34 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca1b556sm44740397eec.9.2026.10.12.06.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:34:33 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 19:02:23 +0530
Subject: [PATCH v2 13/13] phy: qcom: edp: Add Nord phy_cfg, ops and OF
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-nord-drv-dt-v2-13-a2ab9af954d2@oss.qualcomm.com>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
In-Reply-To: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
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
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791811948; l=2577;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=WRyL8CMWIhLtCVdKv+p4xo6VqSv7gN1Tojlh5IqU2kM=;
 b=0iT/5hPFnYhWK4aFKy2lRGhmL8bjiXZ0Y13HRMcmL7Zsnt9guI5XnKjtZJfIfkIcxaZhw0kw3
 a2RCqqMd8QbBy5CU5aVOPVbdlRqdGrY/tTvGdFnNF6qXVkIU6L6jCwu
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: uCIgb2G5YOBhFDjvAVQbr5taudKmd12G
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfX7uuwGZqRPYWh
 vCcShbiah+yDEFwaX47oBxSokpYA5m0ZGif73JqOxr7HDvrgAVZJX+nXcle67FiYi+onH5GdrAo
 BN5GNtHscE8sguSWaeoMIwoK2ejVYdg=
X-Proofpoint-ORIG-GUID: uCIgb2G5YOBhFDjvAVQbr5taudKmd12G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfX1KdLzi+nhXdA
 w7YxxLqUtHkmiMCk2lVk/Ztg3FBJnZbDJmPJziLia6gNwDp9bp33QmVL4A0HdJl7DFityaShYAQ
 lL+UixFazqjdXCUktKQkYaD95aT6Rsvl3FyLh1ZFXn4Gm260cqf8L499q6FYxzftP1MEwR1EceX
 i+YPqWSffsUI0DF7s/mijluPjHNyNiAuqZ9M+JgGGfdV92ZioCA0B7S3EKoOOI07ZR4pSZ8fvTr
 ADTraA3ysJXH5vjmaN9iMVkeZ2o7plrW48YqWOnifazK0f/r6D/tZRPpXolgVNIqaXA0Dgm5+lF
 lX9jdt7xoEwLAp95sV05hft5UyWs9EbX7zSNkytr1Euc9VN17ImQ69zhLiog5CrW8XCOKZP8GKI
 PpffhsaQ92GL/VpGTj86NUCR/p3kL5qSPdoXmDg8I25vjl7l6KNpoBT0jEo4DN3xzbkVTA6WgXC
 vhftH4lkOy59XdlCcjQ==
X-Authority-Analysis: v=2.4 cv=PbhqFShd c=1 sm=1 tr=0 ts=6acce1ec cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=EQFMWDaH4iPFUakZLHgA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120053
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

Wire up Nord-specific callbacks into qcom_edp_phy_ops_nord and
assemble nord_edp_phy_cfg with all Nord-specific values: AUX/VCO
tables, swing/pre-emphasis tables, relocated status register offsets
and TX lane control.  Register "qcom,nord-dp-phy" in the OF match
table so the driver binds to Nord DP PHY device-tree nodes.

Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index cb5f6e0ae607..87400d61323a 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -1774,6 +1774,30 @@ static const struct qcom_edp_tx_res_entry tx_res_cfg_nord[] = {
 	QCOM_EDP_TX_RES_ENTRY_END,
 };
 
+static const struct phy_ver_ops qcom_edp_phy_ops_nord = {
+	.com_power_on		= qcom_edp_phy_power_on_v8,
+	.com_resetsm_cntrl	= qcom_edp_phy_com_resetsm_cntrl_v8,
+	.com_bias_en_clkbuflr	= qcom_edp_com_bias_en_clkbuflr_v8,
+	.com_configure_pll	= qcom_edp_com_configure_pll_nord,
+	.com_configure_ssc	= qcom_edp_com_configure_ssc_nord,
+	.com_ldo_config		= qcom_edp_ldo_config_nord,
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
+	.tx2_tx3_lane_ctl	= DP_PHY_TX2_TX3_LANE_CTL_NORD,
+	.tx_res_cfg		= tx_res_cfg_nord,
+	.cmn_status_reg		= DP_QSERDES_V8_COM_CMN_STATUS_NORD,
+	.c_ready_status_reg	= DP_QSERDES_V8_COM_C_READY_STATUS_NORD,
+};
+
 static const struct of_device_id qcom_edp_phy_match_table[] = {
 	{ .compatible = "qcom,glymur-dp-phy", .data = &glymur_phy_cfg, },
 	{ .compatible = "qcom,sa8775p-edp-phy", .data = &sa8775p_dp_phy_cfg, },
@@ -1782,6 +1806,7 @@ static const struct of_device_id qcom_edp_phy_match_table[] = {
 	{ .compatible = "qcom,sc8280xp-dp-phy", .data = &sc8280xp_dp_phy_cfg, },
 	{ .compatible = "qcom,sc8280xp-edp-phy", .data = &sc8280xp_edp_phy_cfg, },
 	{ .compatible = "qcom,x1e80100-dp-phy", .data = &x1e80100_phy_cfg, },
+	{ .compatible = "qcom,nord-dp-phy", .data = &nord_edp_phy_cfg, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_edp_phy_match_table);

-- 
2.34.1

