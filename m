Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B704DC88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4AAC10F68C;
	Fri, 11 Sep 2026 15:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H+EEQtfa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y9D6DLwr";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF9DB10F57A
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:39:35 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEm0GS269302
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gsOL6A/XqlNEcKVc6fhAS5j/vIAUWo9Ol5uSSyj0hsA=; b=H+EEQtfarwqUIvmS
 Vy7Qi9Oeyq1ghH/qfUBnTvbZ/YgZiRSHfnyUNLpzAYuebisbueA2OTDIkfRfO7Wc
 OYPv2BYVpt7SPEEYoxgCiQwHEHTDsGZ+dQb2f7ohn655GiKLfhWo9tByi8fLWvKp
 fjBqFxvO1EexVxrYvW1BI3zUOzsf9I6ZQJyB81FLGj6sh9BncLCCUW4ZZWk/5En9
 H/1QLCPjBUQB8hPHSIHwwYHB9pFveTyUIWzla1rBHL7gUTh+IqCzOVZQQSyx5nmB
 4cg+DJF5OLCJrFhW4WWmrpHl5Iy/jRSS7pIgx5Miuk68c/e172oJ0W2eXyw8W+vG
 IPPEiQ==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbd52j11-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:39:35 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-47d75bcf3ebso958402fac.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141168; x=1789745968;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gsOL6A/XqlNEcKVc6fhAS5j/vIAUWo9Ol5uSSyj0hsA=;
 b=Y9D6DLwrSF+H9jf9nWYw61YcnyUcS7XDfiDSWwv/N7Q0h4qoxeFV6o21DVfcs4VD0n
 A/s+z7vurAwfyPu18Ha0V2GAAelFNpe1g6qrqCCSxbVz70r+OPVHgOjRKplleDMgqDuv
 LXL3l5lJJ1sFW7pZ2n8eNeo08BW+UL1/q/f7AZDojWhO/qqrCEEPW3mhM2F5+ubexRbl
 N1PDJQE/fqGugmlelyoxuGrYZCzRP35XPmeiI8Z4YEZj8UQvt/gEFFwvSLopJK8drA9W
 v9m7fNtTHQPgxz9OQVWPPX5L8Vz0BWw4YLU3HmMYePMTUahCyU0N0Yg/tEjW6VjEYeCM
 uJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141168; x=1789745968;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gsOL6A/XqlNEcKVc6fhAS5j/vIAUWo9Ol5uSSyj0hsA=;
 b=A78NhuHOr0nHkxS1QEbPU7EkcZuyh9L9z1s0gEEkl3fHXTQllUxDONkyEtUJq2kSz1
 rnlDPumFcHClM4un3OJkoBlwdKu7NDnZszsmBboKfjSL65FbTt+i4okGfCMp249VEY3X
 7exKY8c2T+zLFhiNofgdOcmZym/wSRZGrNHF5kGMMbSihT6FJd/zjUYxJcDmL7q9I6VF
 YDsQnTyAI4/6w8AwazUXmDAInFDuwAW5dlZlU6BEVHCeoUqQ3a4ONyql+blfBXNj7Knf
 BgNhP9WQ/bZk3esE0emUy0BumU5O704blEIawW/K8dTWdbZ48yzZbRCYEc0m0nJqLW9z
 PlsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8/T/n+oibgbkrOd7PwXsIAn/xHzRPc/VmV3pRU6LxeJ36aOYi0eMIJzHD1OspuUOItp4MmOdZDkE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mdHqoE7hgSezb/rZhEAoss26fQyK8AkCAOLfW74a+hL8TMZyoF
 nQiJzwn2XkiiI8e0QDtHj6GM1o4ZwG/BuDQFGznEtS/uKkMPQozJeHpoJ1lvGtrAmtWYDxyYuIG
 Au4zzoyBPYx4IojblZ3gAuSUrzPtjmpAqcfLwrLDjJ/cqF9Qejz3oqKL4R0478nA6ICkyW0E=
X-Gm-Gg: AYBFou3aNL7nmzmyE/7f9klNMgYXwwbVl2ZXomoQqw5mEIOlwr/Aka1AH6tje3E0umD
 kcaRvLswY6aBh8jeVJ9YUllzeM4OKAIi3HSTPUz4+OaNDg7q2JkBxxfq5iPJ4oK0hYQmpBuAqam
 g+UM1q3bucT/HlAAgvRzgmIXTtEugJyNPKw58J++dy0k75siZRdFIStP/MFGesJzq1TR7eIIKbs
 LdEI2mw+cagt175V25Yx5VFpXHNCJYyQ+nMDcNSJRFAK7Ywi8MljpqszgeD5dEf5mxwWzFexyUE
 958lFcqhSIuvcoNGiAGtrhh8SwaBWFse6AJ9dShybl0X+jP4gMf8dYra/p6ZUyLXcfGalGwhOmB
 GXnwaAechO2lS5FM9W5XVgQ6ysLE=
X-Received: by 2002:a05:6870:a788:b0:457:b657:b084 with SMTP id
 586e51a60fabf-47dea52533emr6576801fac.18.1789141167928; 
 Fri, 11 Sep 2026 08:39:27 -0700 (PDT)
X-Received: by 2002:a05:6870:a788:b0:457:b657:b084 with SMTP id
 586e51a60fabf-47dea52533emr6576494fac.18.1789141165861; 
 Fri, 11 Sep 2026 08:39:25 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df90ff148sm1882160fac.14.2026.09.11.08.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:39:25 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 21:06:46 +0530
Subject: [PATCH 15/17] phy: qcom: edp: Add Nord LDO, TX lane and TX
 resistor calibration callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-nord-drv-dt-v1-15-e25c073cf1b6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789141012; l=2541;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=Xy/VEWguip0tUXARr40NV4wwp5carfCh+h9B3ClOARc=;
 b=fCVipWrCI9H3CCZKDDD14z5Es5pRMhlle8YcU1NBrHBqtRPMssWUK43GOknyyVMcKJWene/D+
 tVmDRWKwXQyB5+I7VXQ5EnFrpSRBAEc5kM069eafOWLHDQgUEcpXd5X
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: 7Eq5Ym5QJZAuBMpnhESDmAUnXaPRvXht
X-Proofpoint-ORIG-GUID: 7Eq5Ym5QJZAuBMpnhESDmAUnXaPRvXht
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX+cQ+XGTFCHqI
 OgDk55mDJ5BNmOHRNSnh2Jo1Su5Pg56Ucuoo06v/Gc2Ug1nMhEtZaJPlU9I+dx1yATD6P6Iy/Bz
 Yfa4S7ra5tNrHPT70O4ORbn8QW03Itw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX7XMOUTXpWjMO
 JGQ33p41DMsJaVO2Jah8WpgXPqTy6M1CPtddrHucuW/SbaVTou9q7wcWVCHqDqf/LbFcbAQWykk
 SzE0jlPfnCykDzdayRg/9c1wb2Tzbr95okHOjSOP04YQQMqJmpu3+ySk6t6+cA0I7u0aaLSMCvu
 0HhXBsw98szrv56202o6r7EwM9S2i9hJdkxj9vNg7hj20DRfEy18mI24OyJmeUUEPaCiq655qJ5
 VfGIuVtYOLTSYkHLNztuRHKHZZFUMoIMaOX/YdQciJZDPYo8bYiWjuNgtCQ+9qEn45pQit6YINW
 xP37XEHjYXgFSVFQMx4xW5UaGx3qm81jlyHLS7wfn5uOvaj9+m140eSeIfQSUFref4W8eQVQKoh
 DTWM99W1j3dFguZbEIcv9fryY1QiL8/U5vzlWYTMqKkc0daWMQy+JZ/gahFd9zQ9HpQX9RZ0kWx
 K89QmpNs6WggijD7bcw==
X-Authority-Analysis: v=2.4 cv=db0VTnXe c=1 sm=1 tr=0 ts=6aa420b7 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Ap641EtHlGqqo4O5a_8A:9 a=QEXdDO2ut3YA:10
 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0
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

Nord requires different LDO levels, TX lane control offsets and TX
resistor calibration codes compared to existing SoCs.  Add
qcom_edp_ldo_config_nord(), qcom_edp_phy_tx_lane_cfg_nord() and
qcom_edp_phy_tx_res_cfg_nord() with values per HPG Table 2-1-d.

Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 47 +++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 4d1b2c81d956..361f4e467351 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -1800,6 +1800,53 @@ static int qcom_edp_com_configure_pll_nord(const struct qcom_edp *edp)
 }
 
 
+/*
+ * nord LDO configuration.
+ * From HPG Table 2-1-d: LDO Configuration section.
+ * eDP mode: 0xD1 for rates <= 8.1 Gbps, 0x00 for UHBR (>8.1 Gbps).
+ * DP mode: always 0x00.
+ * Also programs EDP2_DP_PHY_LDO_CFG: 0x03 for eDP rates <= 8.1G, 0x00 otherwise.
+ */
+static int qcom_edp_ldo_config_nord(const struct qcom_edp *edp)
+{
+	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	u32 ldo_config;
+	u32 phy_ldo_cfg;
+
+	ldo_config = 0xd0;
+	phy_ldo_cfg = 0x03;
+
+	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
+	writel(dp_opts->lanes > 2 ? ldo_config : 0x00, edp->tx1 + TXn_LDO_CONFIG);
+	writel(phy_ldo_cfg, edp->edp + DP_PHY_LDO_CFG);
+
+	return 0;
+}
+
+static int qcom_edp_phy_tx_lane_cfg_nord(const struct qcom_edp *edp)
+{
+	writel(0x05, edp->edp + DP_PHY_TX2_TX3_LANE_CTL_NORD);
+	writel(0x12, edp->edp + DP_PHY_TX_LN0_DRV_LVL_NORD);
+	writel(0x12, edp->edp + DP_PHY_TX_LN1_DRV_LVL_NORD);
+	writel(0x05, edp->tx0 + TXn_TX_BAND_NORD);
+	writel(0x05, edp->tx1 + TXn_TX_BAND_NORD);
+
+	return 0;
+}
+
+static int qcom_edp_phy_tx_res_cfg_nord(const struct qcom_edp *edp)
+{
+	writel(0x06, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX0);
+	writel(0x06, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX1);
+	writel(0x06, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX0);
+	writel(0x06, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX1);
+	writel(0x06, edp->tx0 + TXn_TX_EMP_POST1_LVL);
+	writel(0x06, edp->tx1 + TXn_TX_EMP_POST1_LVL);
+
+	return 0;
+}
+
+
 static const struct of_device_id qcom_edp_phy_match_table[] = {
 	{ .compatible = "qcom,glymur-dp-phy", .data = &glymur_phy_cfg, },
 	{ .compatible = "qcom,sa8775p-edp-phy", .data = &sa8775p_dp_phy_cfg, },

-- 
2.34.1

