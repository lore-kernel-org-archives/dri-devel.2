Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7A9CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B91710F101;
	Mon, 12 Oct 2026 13:34:02 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47CB210F110
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:33:51 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CBxuQW1404987
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8r1kV/MAEEpfQTf+AOryDk8Vy/mH2u41tx3zHMQnDLs=; b=fsJKWlen8cXn9aN3
 x1mqBsH2Gai2+XOlzFBW287kmVwW1OE1Gdi+3o/ZtISt2fFwUpNTYWV6fZONsYGS
 MEOiwLJqf2+jR8CAUgqemkKiywP6L+6+/q+ESiGUMNRJQPREgrbPRo5kfVqYFWW7
 rWO/EH6h9fvw+QARDwDbJTUcSXjerzd7E8wzU9gcotMTXnx9LH0kucBLb7Q/BVVM
 /FILor4ikjsMP0vKUDsKR645Ga6RWpyL8nJao49Do1B9jb/NfL4kBVG+Y1vIdSJM
 PM6OX1hcT3xjRnMxg7EFwKlFu5y6PSBT275u02j9JiXlHPgWc0F9tJYwIw1wWnfI
 xCNn0A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8v7ks9ye-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:33:50 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35a04491c56so1127892eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791812030; x=1792416830;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8r1kV/MAEEpfQTf+AOryDk8Vy/mH2u41tx3zHMQnDLs=;
 b=BWT2fINHyfh36GfeLb9jAx0BOKjA4uZ2rxRZQOpGNB6hieFeRMAWdUj8+4vCymGD9C
 WT1FMe7q08LvuUhtEaBhbIJjVj15VtK6TyU0PTIONKGbxSp/BsPN+LIzFrb4SPYb1QMW
 7eq1jcopeymKMBBx5KQy7wqhdE7wJFvh+HgoRAcJ2j5DnXBMCz9iK17JVl5J3rHQBsCe
 EzxkYNvjmhZxkxoyasIvyraFat6S28skMaUhrrMVSlEYtHvd1Y3gAJ5wLGZFpWH7WFzl
 qS9dbmq1WJ23A4dH1lhM7eLBTDRM+hriIaIlEaYCxiuqkDhAa+wJZ7Erhr2J2RFxy1WC
 z3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791812030; x=1792416830;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8r1kV/MAEEpfQTf+AOryDk8Vy/mH2u41tx3zHMQnDLs=;
 b=eI9AXs+mG8qDIghTyCTizpHU88j7Bii1ZB+5bbjVaMtf2rEnowkL7jz/xBwlM/Zmx/
 SRf6ERHsstTcyGV/WvOVFni7eq4urvdcypgCNd8jI4ZybsfF4EkG5WjHRYOKiyxtwuZg
 K95NRjGPWqxaRtNwot3gOu5kjYhhGFXFvRUNy1jxJ8lpi0TrySYJpVr/KH1ZGtAevPMl
 I8n/5W2bg+eU6dKav3RxYP2ktjsrpSlRjquvGxFV13fkFLPEiXYGJoAzpqwsqnKDAcsU
 oaRRTfpv+MWhaKqcsV1lhFMm2LcMsqWNTfhDjKUcMgADzdfAz/UyD5bW7emP+mMkn+EF
 8aMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByV408B1UoseKyztCQfNL3qc3tUy2gubKA5kGyzxHxMS7dLrOxGLm3vlHiqZY6awZs47yqBU405OhY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJx14WvP1yxL/Yy8BV1N2qx4PCefebc9OIyL5nOYNJ1BmgbWngB
 K9fWc/V/lW0zFQQnE1K7lmeDEYlMK+pXpaVnXCNtLz7n7YUUaDk5URiWfpQItk5f4dG3SFMcMDp
 ng86Z3hxUJYp07f9/AGT0O5UujPpOFdSPwAgkbPhhNlVlBdzE66ZmEBhFGDXmioac60U/5y4=
X-Gm-Gg: AYBFou3mH7bZY36V/HaQdpY841TBG2RTV4x0FLjobnAbwfCpZIjDWvBAFqrc2L3Skgg
 nkfiIfp8Gy+cRAOU7BCG2yqzzS2oKW8y5U7zHAXH1LHw/ZmxmiYRZAe+jtY94e5pVrc/xJTzYBu
 H0fQZ+5gLzfa8GVqOSZpSwyKdEkHFsuPN07VVh42uGlARKSEvW0EPGe8VcYCA5EKRpgzUSajOkH
 pRZm/8vG45P8n2X5gLmwO12Q+V6DFfVdhNiw5XpVkL0wo9gmEd/MFZDBO8wbsAr1dnsBx8n+fbg
 pVHmOPCpvm5MWEJdIlmsv5yuOPmwjRo9Yk1BNn8leK4aWPv9Up9btj1Ec/g2Rxr7VTGcVJ1eY2X
 pa2oYch8QaJKuB/ecQjzlAu7QE04=
X-Received: by 2002:a05:7301:dd95:b0:353:58b7:b5fa with SMTP id
 5a478bee46e88-3535f48136amr13942078eec.1.1791812029568; 
 Mon, 12 Oct 2026 06:33:49 -0700 (PDT)
X-Received: by 2002:a05:7301:dd95:b0:353:58b7:b5fa with SMTP id
 5a478bee46e88-3535f48136amr13942024eec.1.1791812028880; 
 Mon, 12 Oct 2026 06:33:48 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca1b556sm44740397eec.9.2026.10.12.06.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:33:48 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 19:02:18 +0530
Subject: [PATCH v2 08/13] phy: qcom: edp: Generalize power-on path for
 per-SoC overrides
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-nord-drv-dt-v2-8-a2ab9af954d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791811948; l=8737;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=eF1Jpyt1qNMVw5DgVtoI8D/ioyJheTfzXdIRzkvKdK4=;
 b=fwlb3gaIOBYoqJ9GsBeBjI590rDx6+zP7ejlXPPM6qNRoGsR12CAKqd2bP3WQXqQYVdKa0I6F
 DMDo8LsAbNsDT3zv7KjfMBDrwDRiZ0NDTsfZHhc9TWVm254LK2/+pPv
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfXwY6X+x2HjpJ7
 Go4wzoioLlHVrOXB6YM0RQLZZnA+XTK2GrvCv/TnVgNoTlt7vLwPBA06hsCJlbMLtiwBw6Dy9W3
 89Mt6KSGuZ7HfIc7cTBV6aZ7BJl8w8ie9rUxmlMZQ2icQFw8XWBismS1J1qCBvmz89W2p9vnN5z
 pmP+B+fRecGNHns2Dzvb41OLrj9yfNE3CeynmYFIZ8NsgRvG0OT36RX5XTfr7ffeLWXijbqRL0K
 10HGiByJmNx2SMCenR04plhXUs6qGP+Xt5Pvg4TYDXJUwtBS1sIWCHxHCp08c849rq0UsbQzfhi
 DwqxyWnmq2MfqCT2gHEDBRx10WuKbSK//StySwlNIuWpgep4p5ClRkMf8L8UD9EvnyPn5FMwt04
 vCflfQ9P4/hOnTieqFLcoqa8I/J1N2ugqXwAVT5YdW5s1cBwTAFnW+p3mKETMu5NMqSTTxflHSH
 dt3+7uyIug+vml+v7tg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfXwI25B6ox/9le
 2Gig3DLC7pkt8IJmcd6z9mszx00rE6/YZLNdKHmcYMEJmen9MPtR/ZC6yYElPC4Z42R/XiYrMKx
 S+uxoI2d5hbdnGx/RL0EI4iIcSYC1No=
X-Authority-Analysis: v=2.4 cv=VOtIDNPX c=1 sm=1 tr=0 ts=6acce1be cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=-OCD7epTopYbqN3EProA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: S9JRq6KFCJhZWLr4eASrr1Akc9RtbmNy
X-Proofpoint-ORIG-GUID: S9JRq6KFCJhZWLr4eASrr1Akc9RtbmNy
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

Nord has a different register layout that the existing hard-coded
power-on path cannot accommodate.  Introduce qcom_edp_tx_res_entry
and replace open-coded TX resistor writes with a data-driven loop
that also handles base=2 (PHY/edp base) for Nord.  Add
phy_status_reg, bias1_en_2lane, tx2_tx3_lane_ctl, tx_res_cfg,
cmn_status_reg and c_ready_status_reg to qcom_edp_phy_cfg, and
make com_clk_fwd_cfg optional.  No functional change for existing
SoCs.

Assisted-by: LLM
Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 82 +++++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index d5c6835b6c70..c5df1086607f 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -81,6 +81,15 @@ struct qcom_edp_swing_pre_emph_cfg {
 
 struct qcom_edp;
 
+struct qcom_edp_tx_res_entry {
+	u8  base;
+	u32 offset;
+	u32 val;
+};
+
+#define QCOM_EDP_TX_RES_ENTRY_END { .offset = 0, .val = 0, .base = 0xff }
+#define qcom_edp_tx_res_entry_is_end(e) ((e)->base == 0xff)
+
 struct phy_ver_ops {
 	int (*com_power_on)(const struct qcom_edp *edp);
 	int (*com_resetsm_cntrl)(const struct qcom_edp *edp);
@@ -98,6 +107,12 @@ struct qcom_edp_phy_cfg {
 	const struct qcom_edp_swing_pre_emph_cfg *dp_swing_pre_emph_cfg;
 	const struct qcom_edp_swing_pre_emph_cfg *edp_swing_pre_emph_cfg;
 	const struct phy_ver_ops *ver_ops;
+	u32 phy_status_reg;
+	u8 bias1_en_2lane;
+	u32 tx2_tx3_lane_ctl;
+	const struct qcom_edp_tx_res_entry *tx_res_cfg;
+	u32 cmn_status_reg;
+	u32 c_ready_status_reg;
 };
 
 struct qcom_edp {
@@ -313,9 +328,11 @@ static int qcom_edp_phy_init(struct phy *phy)
 
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
@@ -672,6 +689,16 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v4 = {
 	.com_ldo_config		= qcom_edp_ldo_config_v4,
 };
 
+static const struct qcom_edp_tx_res_entry tx_res_cfg_default[] = {
+	{ 0, TXn_RES_CODE_LANE_OFFSET_TX0, 0x11 },
+	{ 0, TXn_RES_CODE_LANE_OFFSET_TX1, 0x11 },
+	{ 1, TXn_RES_CODE_LANE_OFFSET_TX0, 0x11 },
+	{ 1, TXn_RES_CODE_LANE_OFFSET_TX1, 0x11 },
+	{ 0, TXn_TX_EMP_POST1_LVL,         0x10 },
+	{ 1, TXn_TX_EMP_POST1_LVL,         0x10 },
+	QCOM_EDP_TX_RES_ENTRY_END,
+};
+
 static const struct qcom_edp_phy_cfg sa8775p_dp_phy_cfg = {
 	.is_edp = false,
 	.aux_cfg = edp_phy_aux_cfg_v5,
@@ -679,6 +706,9 @@ static const struct qcom_edp_phy_cfg sa8775p_dp_phy_cfg = {
 	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
 	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v4,
+	.phy_status_reg = DP_PHY_STATUS,
+	.tx2_tx3_lane_ctl = DP_PHY_TX2_TX3_LANE_CTL,
+	.tx_res_cfg = tx_res_cfg_default,
 };
 
 static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
@@ -687,6 +717,9 @@ static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
 	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
 	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v3,
 	.ver_ops = &qcom_edp_phy_ops_v3,
+	.phy_status_reg = DP_PHY_STATUS,
+	.tx2_tx3_lane_ctl = DP_PHY_TX2_TX3_LANE_CTL,
+	.tx_res_cfg = tx_res_cfg_default,
 };
 
 static const struct qcom_edp_phy_cfg sc8180x_dp_phy_cfg = {
@@ -695,6 +728,9 @@ static const struct qcom_edp_phy_cfg sc8180x_dp_phy_cfg = {
 	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg_v2,
 	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v2,
 	.ver_ops = &qcom_edp_phy_ops_v3,
+	.phy_status_reg = DP_PHY_STATUS,
+	.tx2_tx3_lane_ctl = DP_PHY_TX2_TX3_LANE_CTL,
+	.tx_res_cfg = tx_res_cfg_default,
 };
 
 static const struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
@@ -703,6 +739,9 @@ static const struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
 	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
 	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v4,
+	.phy_status_reg = DP_PHY_STATUS,
+	.tx2_tx3_lane_ctl = DP_PHY_TX2_TX3_LANE_CTL,
+	.tx_res_cfg = tx_res_cfg_default,
 };
 
 static const struct qcom_edp_phy_cfg sc8280xp_edp_phy_cfg = {
@@ -712,6 +751,9 @@ static const struct qcom_edp_phy_cfg sc8280xp_edp_phy_cfg = {
 	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
 	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v4,
+	.phy_status_reg = DP_PHY_STATUS,
+	.tx2_tx3_lane_ctl = DP_PHY_TX2_TX3_LANE_CTL,
+	.tx_res_cfg = tx_res_cfg_default,
 };
 
 static int qcom_edp_phy_power_on_v6(const struct qcom_edp *edp)
@@ -913,6 +955,9 @@ static struct qcom_edp_phy_cfg x1e80100_phy_cfg = {
 	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
 	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v6,
+	.phy_status_reg = DP_PHY_STATUS,
+	.tx2_tx3_lane_ctl = DP_PHY_TX2_TX3_LANE_CTL,
+	.tx_res_cfg = tx_res_cfg_default,
 };
 
 static int qcom_edp_com_configure_ssc_v8(const struct qcom_edp *edp)
@@ -1045,8 +1090,8 @@ static int qcom_edp_phy_com_resetsm_cntrl_v8(const struct qcom_edp *edp)
 
 	writel(0x20, edp->pll + DP_QSERDES_V8_COM_RESETSM_CNTRL);
 
-	return readl_poll_timeout(edp->pll + DP_QSERDES_V8_COM_C_READY_STATUS,
-				     val, val & BIT(0), 500, 10000);
+	return readl_poll_timeout(edp->pll + edp->cfg->c_ready_status_reg,
+				  val, val & BIT(0), 500, 10000);
 }
 
 static int qcom_edp_com_clk_fwd_cfg_v8(const struct qcom_edp *edp)
@@ -1074,8 +1119,8 @@ static int qcom_edp_phy_power_on_v8(const struct qcom_edp *edp)
 	       edp->edp + DP_PHY_PD_CTL);
 	writel(0xfc, edp->edp + DP_PHY_MODE);
 
-	return readl_poll_timeout(edp->pll + DP_QSERDES_V8_COM_CMN_STATUS,
-				     val, val & BIT(7), 5, 200);
+	return readl_poll_timeout(edp->pll + edp->cfg->cmn_status_reg,
+				  val, val & BIT(7), 5, 200);
 }
 
 static const struct phy_ver_ops qcom_edp_phy_ops_v8 = {
@@ -1094,6 +1139,11 @@ static struct qcom_edp_phy_cfg glymur_phy_cfg = {
 	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg_v8,
 	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v8,
+	.phy_status_reg = DP_PHY_STATUS,
+	.tx2_tx3_lane_ctl = DP_PHY_TX2_TX3_LANE_CTL,
+	.tx_res_cfg = tx_res_cfg_default,
+	.cmn_status_reg = DP_QSERDES_V8_COM_CMN_STATUS,
+	.c_ready_status_reg = DP_QSERDES_V8_COM_C_READY_STATUS,
 };
 
 static int qcom_edp_phy_power_on(struct phy *phy)
@@ -1128,7 +1178,7 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 
 	/* TX Lane configuration */
 	writel(0x05, edp->edp + DP_PHY_TX0_TX1_LANE_CTL);
-	writel(0x05, edp->edp + DP_PHY_TX2_TX3_LANE_CTL);
+	writel(0x05, edp->edp + edp->cfg->tx2_tx3_lane_ctl);
 
 	/* TX-0 register configuration */
 	writel(0x03, edp->tx0 + TXn_TRANSCEIVER_BIAS_EN);
@@ -1166,13 +1216,13 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	writel(0x00, edp->tx1 + TXn_TX_POL_INV);
 	writel(0x10, edp->tx0 + TXn_TX_DRV_LVL_OFFSET);
 	writel(0x10, edp->tx1 + TXn_TX_DRV_LVL_OFFSET);
-	writel(0x11, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX0);
-	writel(0x11, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX1);
-	writel(0x11, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX0);
-	writel(0x11, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX1);
+	for (const struct qcom_edp_tx_res_entry *e = edp->cfg->tx_res_cfg;
+	     !qcom_edp_tx_res_entry_is_end(e); e++) {
+		void __iomem *base = e->base == 2 ? edp->edp :
+				    e->base ? edp->tx1 : edp->tx0;
 
-	writel(0x10, edp->tx0 + TXn_TX_EMP_POST1_LVL);
-	writel(0x10, edp->tx1 + TXn_TX_EMP_POST1_LVL);
+		writel(e->val, base + e->offset);
+	}
 	writel(0x1f, edp->tx0 + TXn_TX_DRV_LVL);
 	writel(0x1f, edp->tx1 + TXn_TX_DRV_LVL);
 
@@ -1184,7 +1234,7 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 		cfg1 = 0x1;
 	} else if (edp->dp_opts.lanes == 2) {
 		bias0_en = 0x03;
-		bias1_en = 0x00;
+		bias1_en = edp->cfg->bias1_en_2lane;
 		drvr0_en = 0x04;
 		drvr1_en = 0x07;
 		cfg1 = 0x3;
@@ -1207,7 +1257,7 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 
 	writel(0x19, edp->edp + DP_PHY_CFG);
 
-	ret = readl_poll_timeout(edp->edp + DP_PHY_STATUS,
+	ret = readl_poll_timeout(edp->edp + edp->cfg->phy_status_reg,
 				 val, val & BIT(1), 500, 10000);
 	if (ret)
 		return ret;

-- 
2.34.1

