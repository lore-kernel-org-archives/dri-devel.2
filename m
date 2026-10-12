Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9D6CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5B1C10F126;
	Mon, 12 Oct 2026 13:34:41 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48BDA10F113
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:34:27 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CBxuQc1404987
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AWuxUBcrInqnBnXrIjvNWBh+kSHK0gado8CZLpJNc6o=; b=b9AgZ7hVkss9ozdw
 1dWWNsBJBCUFaQgtPt6SpfZGaHdDI0pJq7MEgHYBTA7/XV6DD+snyQtPpwwV0piQ
 wwl/jd8CJAvovvkRbDnbwtmxbPhsu4QCxkbqU3A/+1uO7wTO7lUcqosu8+vBhh06
 aul+Qg/fe4lnM6h7q1cizMJsLhrngVnUt5eKK4Zhf/C6dyhdNKMo1Xj7vXUDUeAZ
 xW2guuXU/AwN+1nEr4WOfj6NS8QYqtNXCu6uCbSb5MsQIv1TcXjXMrMiAM5iPQtz
 GiLescQqKGvX8cRF+g9WmrSlMRrLz6zBoXeKclzn5L1UyFLpGqILrasg1r8VMQIS
 4JQRZQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8v7ksa15-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:34:26 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510d0baf63so5397312eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791812066; x=1792416866;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AWuxUBcrInqnBnXrIjvNWBh+kSHK0gado8CZLpJNc6o=;
 b=ZxVSFDygwDJ7aFvqclb113/w8ztxKLys8ZaIk83kBGeXezhQQOH8xuzM0ju6hE6Xmc
 u1tGYXq4Xzp7B2KgWXLzoMI/t1P0bePvVzcuqQdinQBqW/qGYBlg4/GbTS7mJmDm7vWF
 VXYo8YqBrDSevpEoqunSNwaLTPqjucVa7VG3DxiGAwt0kZQ3t3Q2qi34NgILioaV492y
 rUPAv/0FruEXKA/Mu2YDtJtV0gGspbB/wHX8PZryiJwVEAAwPbEFTJOgYFuFJ8KmDwg0
 cLukDg4lGFNvhZT7r3/ow3dXWsALCdzS6hCgeH1YJ51w48ph3NdmWGP56WkE/IvoWej1
 C+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791812066; x=1792416866;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AWuxUBcrInqnBnXrIjvNWBh+kSHK0gado8CZLpJNc6o=;
 b=bYOhhTMFqEh1gMB8+97DCsL1kRhvG7h+2FwMfoy2y9ibHG/uRPPjTl7EwqyzEFuM1Q
 H47T1hoWyTR+bxyAGGWttHQAdjTeKETbScU6HBH+mGZ/hgzHNfMBjr0MlzsW32I2rrq/
 Ch+hDKz+JJbCbHfDxgMyJ96Hs99Ao92FA3BvLItlueHBgEyOOx+zrF07i2khxwvkjTTm
 m58C4Yy3YV3pugnJeaqzltRB7IS7/S8zYJgESdCw/HPr2XKJ84oxQd81Vv9KldLGSYrr
 PkXo10MyUvfzZ4lmJqOD8OzZdWWa5dlNXMnOGuWLGfBa5iysazuZuieMpH1IcKVRujz3
 XtEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx17uWM+vzPBFG0nW5AiA81uaiSJaYsJ9GXKkK+nd0uG1UYMPKQgpPosZRUx0i+f5qoj2stOLMETJY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKwYViFr9p57rVcnUBDGTwRnAKuWXu39BMMOrPp9GA3UxP9H2mU
 ZfJDzX99siBhYsZwCocCaFa2WOh6msT5fcwFk1sl/avLPldtNjYPSvkgbYWaZBRieBWm318skic
 G7c0hDa6mj+IYVm31Y5OHcJP8e2nqNvjWE+ywugs4rHmNFJw6zcxs8cCYRNNExEFp+d3RpeI=
X-Gm-Gg: AYBFou1xaXDXjXtvqSs+29xcso6am6q7W1o1FzoC+JlSaBvqkBJFKHF7r3AsuKXR35c
 8ExqJVMpDOAaKEuKA46grS/gOgatTQxCNp9BYCz3eszP980dbMjIOSgLumozYqe2TNgsPcG9xvS
 eHX5T9f1bqWzxqknXaIwXe3zeAirCPwJ4QWvt73nbmxhJFg1etGaRjfe0m/9td+sJjSSPm2iDTO
 NFct1FGy1lkbdcFXLykGBDw8cuQd66S2sPp9Gyewx9KVuZANFhK0ZJdYm1m+0jNWcT5dqyQFDJ3
 hq/ll9ICwK0aF2Lv4G1005cqdPwvhhK+js8zA0flX9AkRC8ZabTrcT0uZw/PpeWtCWhDKA3tZC+
 qaawxTEG8nyzzx2Z+9PYKenzoeJM=
X-Received: by 2002:a05:7301:4707:b0:359:c5c1:1561 with SMTP id
 5a478bee46e88-359c5c124afmr6226011eec.13.1791812065823; 
 Mon, 12 Oct 2026 06:34:25 -0700 (PDT)
X-Received: by 2002:a05:7301:4707:b0:359:c5c1:1561 with SMTP id
 5a478bee46e88-359c5c124afmr6225974eec.13.1791812065235; 
 Mon, 12 Oct 2026 06:34:25 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca1b556sm44740397eec.9.2026.10.12.06.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:34:24 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 19:02:22 +0530
Subject: [PATCH v2 12/13] phy: qcom: edp: Add Nord PHY configuration data
 tables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-nord-drv-dt-v2-12-a2ab9af954d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791811948; l=2153;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=mc70GfhABlJEcIgszTS9OYEd+47rUg6PffkmKCnmkaA=;
 b=Rtaxo/Nh7eGn0ieiVqBP2KN9g33OKo536bTfySr6a9ADjYIHd80Dbex/t241gIRSnoVRjQRgj
 /oYuBiVbkZcC1tnPnA/IuOsx6QfOu0PrlLstteaT6LPSojTMVB9dae0
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfXw1OS9bc6T5Zr
 3rrGIlfbQmF8CIoks+qNYPOWu2Sh2nMTwhx/Clh/0KnXyN817VldA+8HrX/tDgE5MNU8BQD+PGE
 T8L3Wlao2ydUSYOs8exVF2A72T2UPiEDn23NFLkiC6oaxUIrCrtKgO5yGCywv/H5fRr0R7/9bGg
 m0Wshptkm2dIe8oipcd/G3SgbUAqm2ZcZA+ifJWZ1YtnJiKbspSOftY/g0duFWgDxAK286NE1Xa
 8T3Ytx294kFOlwZsPq/yR+cYKcsEvwtLfMgwzC0dTjoe32HDwPalSCHnUulzzMx+OYcxVZW/JFX
 IHWn0naIZQBS1wIWJGo+R0NlwloWff5pQbTvKt6+/hB1dYzemsHpT6hT7ftqDnWB5C+kD5m6w5Y
 HdC10Fq3U2xQQOjw0AnUK6lg4w6LFjqt+HXBuf0DZPbWC9mtwzevcP/bbH4zIeinAAoJxaT6Lww
 v7u6/Pj+b7czaLg3FXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfXwHWbYfVmK+q/
 ZcRH70EkNv/vAMlJVaccjLCDr721GSH9p0ASVHCGMFOiqZLSds9u93MDQYSjkOh3Mb6ZuYO3yOQ
 fqfaANQuhmbqo2W1qhvfd4EDxf4q0KE=
X-Authority-Analysis: v=2.4 cv=VOtIDNPX c=1 sm=1 tr=0 ts=6acce1e2 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=44JGFhAfC3nl-4BMLwQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: mrJJz3arY1dww6ed-jbsu_Ptl0RKX2O0
X-Proofpoint-ORIG-GUID: mrJJz3arY1dww6ed-jbsu_Ptl0RKX2O0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120053
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

Add Nord-specific AUX channel, VCO divider, LDO and TX resistor
calibration data: edp_phy_aux_cfg_nord[], edp_phy_vco_div_cfg_nord[],
qcom_edp_ldo_config_nord() and tx_res_cfg_nord[], sourced from HPG
Tables 2-1-a, 2-1-b and 2-1-d.

Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 3e857d105668..cb5f6e0ae607 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -1741,6 +1741,39 @@ static int qcom_edp_com_configure_pll_nord(const struct qcom_edp *edp)
 	return 0;
 }
 
+static const u8 edp_phy_aux_cfg_nord[DP_AUX_CFG_SIZE] = {
+	0x00, 0x13, 0xa4, 0x00, 0x0a, 0x26, 0x0a, 0x03, 0x37, 0x03, 0x02, 0x02, 0x04,
+};
+
+static const u8 edp_phy_vco_div_cfg_nord[4] = {
+	0x00, 0x00, 0x02, 0x01,
+};
+
+static int qcom_edp_ldo_config_nord(const struct qcom_edp *edp)
+{
+	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+
+	writel(0xd0, edp->tx0 + TXn_LDO_CONFIG);
+	writel(dp_opts->lanes > 2 ? 0xd0 : 0x00, edp->tx1 + TXn_LDO_CONFIG);
+	writel(0x03, edp->edp + DP_PHY_LDO_CFG_NORD);
+
+	return 0;
+}
+
+static const struct qcom_edp_tx_res_entry tx_res_cfg_nord[] = {
+	{ 0, TXn_RES_CODE_LANE_OFFSET_TX0, 0x06 },
+	{ 0, TXn_RES_CODE_LANE_OFFSET_TX1, 0x06 },
+	{ 1, TXn_RES_CODE_LANE_OFFSET_TX0, 0x06 },
+	{ 1, TXn_RES_CODE_LANE_OFFSET_TX1, 0x06 },
+	{ 0, TXn_TX_EMP_POST1_LVL,         0x06 },
+	{ 1, TXn_TX_EMP_POST1_LVL,         0x06 },
+	{ 0, TXn_TX_BAND_NORD,             0x05 },
+	{ 1, TXn_TX_BAND_NORD,             0x05 },
+	{ 2, DP_PHY_TX_LN0_DRV_LVL_NORD,  0x12 },
+	{ 2, DP_PHY_TX_LN1_DRV_LVL_NORD,  0x12 },
+	QCOM_EDP_TX_RES_ENTRY_END,
+};
+
 static const struct of_device_id qcom_edp_phy_match_table[] = {
 	{ .compatible = "qcom,glymur-dp-phy", .data = &glymur_phy_cfg, },
 	{ .compatible = "qcom,sa8775p-edp-phy", .data = &sa8775p_dp_phy_cfg, },

-- 
2.34.1

