Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26368CA9EDE
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48EEA10F10E;
	Mon, 12 Oct 2026 13:34:31 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4047510F118
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:34:19 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC07Ff1933164
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1ZO9HNLLNqcZbFHntk3RATNGGcfmE74k0W1y+uxwR6k=; b=CpOuWOIZk9ag2DlI
 cALe4RDuNCgZqete2ha44vZAThVKLX4mveYdEk9vKfmSsVeoxt1N1WgaZf4xPCer
 xpzexobcirKwxYCEFUI6HDs9ym9oXuKMST26S3QG4KhEDJwccHcxk/UB3SC5j9SK
 AGaZmSHCak83GnNcP4Xxx5Mc9xqkYF897lCTagUU1/2GNl9URFqW6/s8wpnVJ63h
 w6ZMYIwtKeCGNH/siQ9t4o6jKggYtuvOrBQGWrWvzo/pr4vd8ndoq4vJrEhDHDAe
 CjZW0Ifu8OMLLdudkT/Ls08+mPKSEYi+cuneZL18jY8qyq42uc9OKHwgnSZX7sOc
 EZ/dAg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8qtkjdkd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:34:18 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33713e5e6daso3169543eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791812057; x=1792416857;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1ZO9HNLLNqcZbFHntk3RATNGGcfmE74k0W1y+uxwR6k=;
 b=dSeQ4yi+dCtbbjRQITqUmBRCqSu6E/gZPA9a1gvX+sLQPHHFzIdyYkymoZ6jWeB0f5
 gh9ZVS8lSIzFeB1g3F5X/5ALcaS+yMsz+OzvQQ+7dCi3VXQp7JheEQGS2Y3rmcYBmy8H
 E4+fVmk1tqA5Z7TQOd6lZUNlwfP/K3Hqaih8WXhkIprlrQq5aY29rinLjuCrDeN/0H2O
 aYrsjPLtHfjTwQSgz+bfCjXe1FTdwOCspRD3SxCZwfYiWNNDSDematvhs7Ga8ayh1//O
 ZhIeVGeVj/KM2SfY9guHWqeejjTmCvQXQRlfgnCcBKwiegI1Ciodp5YLQNXsclA3GYns
 rGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791812057; x=1792416857;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1ZO9HNLLNqcZbFHntk3RATNGGcfmE74k0W1y+uxwR6k=;
 b=SEWUCjGgu5EXoF9c+mSUswIl3RdWFTp2lCWGUWMtzO1grzIc8PfdUzuYgf50lcfU92
 hv+KAjafqK6Ffcy7a1qECsMhe4Qg5i2wB5aUpkPsNxowV+BO6LqWRywVgYlE0qjAoY6Z
 V2+a1feCUPXY/8H6qHzphXpotuIUKKYepLMInQJS/sdTStoQn7ci1i1h3fWGyN5a/vlj
 EmZJu4cPJV70vY+B4XGaWxWMmJI6ziITgcIY+zNtHqpODY0exhJEKw6OIO9N59PTB8tp
 FoWqtd4pU9czHh+0WuLcHd510YqTy9NTIzwuZvIUEqE62WcnV/n58ZL+0xdFZhIrM87n
 9FMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCeJZF6ykDZsawBo/5A/qd9TdchxEW8coHGkm7xIM5X9LAwOTDt1kHNO+jnqY2Or+04n6MDU3q+m8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI6F3Q9HDuwrJwIVAelXqPMgJaJ1gm4u7hpSoNFvIeiTH+2g9p8
 gSlcorgaJe2E8zM/mEnHY29QpLfxwKL9BH+bTp0+jNsfRJnT5E3xNo4tcmkSD3y68P0pjH62jhN
 uC+6t1++T48FS4I2wgHyYq/OqX8lhW0Ihop6zXTYrX25w3fdrYexaEaOfFWb1w4U4auScX+0=
X-Gm-Gg: AYBFou2FovKpN9adDHEMTgylVnMicUkCWxFifeODqFDV06xLNyef4YFfuxo2EQIZVp9
 fadGprHpNFPeklm/py7zzuYkZ9FBPRUzmk/mNK5SyHDOYlRq19W803QPO1gA5IFBSSlCCUZeShD
 +wqR6d9dZU4FXV5hh9XPsgzdUL7MsinvDBsCb3B6QBoCZreX66aB/3XcL1Nld5vwL0Mvy+QwZxV
 xSm3QD4h5EvUOHsZxvuLINBkNY0Nc9CvbCRPU43OgClzrobNL+4bTvaJoQFHHF4dA34+LOBl2B8
 yrx81kWBUntWbQti0gnCx87/Hc7MvqvzmamxrzOPdjEpJ58WBwruWIDgQ+nlfPOBrsCQzI4D9iR
 qn1pY5hP7EYtmYhFv3+0IRmJcpXo=
X-Received: by 2002:a05:7301:f24:b0:351:595:750b with SMTP id
 5a478bee46e88-3537e2964f7mr14905683eec.36.1791812056945; 
 Mon, 12 Oct 2026 06:34:16 -0700 (PDT)
X-Received: by 2002:a05:7301:f24:b0:351:595:750b with SMTP id
 5a478bee46e88-3537e2964f7mr14905657eec.36.1791812056418; 
 Mon, 12 Oct 2026 06:34:16 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca1b556sm44740397eec.9.2026.10.12.06.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:34:15 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 19:02:21 +0530
Subject: [PATCH v2 11/13] phy: qcom: edp: Add Nord PLL configuration callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-nord-drv-dt-v2-11-a2ab9af954d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791811948; l=4783;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=a5XRl2SA0hyveR2kRhO0hXsLMrPVZAn2FeKG/SbK1s0=;
 b=MRmRCsYT29d/XMuAeE3OCY6Sz58JMZtl8zQgVvmaVSzML6Ox8JKoC/1kMoc5vsqlDzaQVZPML
 6JtvlNFTVpQDqrYRinG9QIqunEFz0eXzpAhz63XhsYsU5gi2wyPR8md
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfXxCIo3ExXoIp4
 psc4TLSM3F2VewjYzGzQ1LltgH5Rf9qftFbvJLYUYPDzTuZ6oEju2HVBRfYAE6QR8y/NksDI8Wu
 6G2mGGZStfml1cdSfi4Zgc2zDsS2bljSZSzHP7Lk1z1bVBepjLWobZ/AQAQKDPDg7UTIiYdgrtC
 tuGzDGZQnyh1WrzDF5Fq4ofAKH70neSIjhxy1MRqxzg1ds6Beh9xpp/b3yQ0NjINu9HYbY0UpwY
 LTXX7av9FpU66sYsqIe40Y0BScnFSExI1qIHSCKyEnS0beD+4GXDYodzadQTuGZL6JYkptzy1a0
 hKAXJ9OWkf5lEQQLlq8NtOQ+XKKaWgxf6t+Hg5SwvVH1dsj4iKmhR42/sMt4Qv7qTrh91IzWpzY
 Y8lLl1YcJeXCELhXtYlU1WOc48YBMEhmOomgw1rq5G2/DMzlFJVS070Wv56hbLLhGSi+zsT6Ypg
 EGx26oELWHO58KFm0tw==
X-Authority-Analysis: v=2.4 cv=c8U+0h9l c=1 sm=1 tr=0 ts=6acce1da cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=PRaozp5Bz6Goyj2T3wIA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfXymNGO5zkoruS
 MvVgwzqN9CIXvlTc1PNrPyhjVXqYlK29y1Vw0Ck4ildhOfjS7tG6AwL/6GB75eqQ/UiKFlBF88o
 /Lif7Pg7mu4HKYYqkgWLvkD5H48djrQ=
X-Proofpoint-ORIG-GUID: MulP0u3AVNzKGaWlcSxix3hPIRccxgCz
X-Proofpoint-GUID: MulP0u3AVNzKGaWlcSxix3hPIRccxgCz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
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

Nord uses a 38.4 MHz CXO reference with a different QSERDES v8 COM
register layout and PLL coefficients.  Add
qcom_edp_com_configure_pll_nord() which programs all QSERDES COM PLL
registers with link-rate-dependent values for RBR, HBR, HBR2 and
HBR3, per HPG Table 2-1-d.

Assisted-by: LLM
Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 103 ++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 66c31684c48e..3e857d105668 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -1638,6 +1638,109 @@ static int qcom_edp_com_configure_ssc_nord(const struct qcom_edp *edp)
 	return 0;
 }
 
+static int qcom_edp_com_configure_pll_nord(const struct qcom_edp *edp)
+{
+	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	u32 div_frac_start2_mode0;
+	u32 div_frac_start3_mode0;
+	u32 dec_start_mode0;
+	u32 lock_cmp1_mode0;
+	u32 lock_cmp2_mode0;
+	u32 lock_cmp_en;
+	u32 hsclk_sel;
+	u32 code1_mode0;
+	u32 code2_mode0;
+	u32 core_clk_div_mode0 = 0x14;
+
+	switch (dp_opts->link_rate) {
+	case 1620:
+		hsclk_sel = 0x0c;
+		dec_start_mode0 = 0x54;
+		div_frac_start2_mode0 = 0x00;
+		div_frac_start3_mode0 = 0x06;
+		lock_cmp1_mode0 = 0x37;
+		lock_cmp2_mode0 = 0x04;
+		lock_cmp_en = 0x04;
+		code1_mode0 = 0x8d;
+		code2_mode0 = 0x27;
+		break;
+
+	case 2700:
+		hsclk_sel = 0x04;
+		dec_start_mode0 = 0x46;
+		div_frac_start2_mode0 = 0x00;
+		div_frac_start3_mode0 = 0x05;
+		lock_cmp1_mode0 = 0x07;
+		lock_cmp2_mode0 = 0x07;
+		lock_cmp_en = 0x08;
+		code1_mode0 = 0xf6;
+		code2_mode0 = 0x20;
+		break;
+
+	case 5400:
+		hsclk_sel = 0x01;
+		dec_start_mode0 = 0x46;
+		div_frac_start2_mode0 = 0x00;
+		div_frac_start3_mode0 = 0x05;
+		lock_cmp1_mode0 = 0x0f;
+		lock_cmp2_mode0 = 0x0e;
+		lock_cmp_en = 0x08;
+		code1_mode0 = 0xf6;
+		code2_mode0 = 0x20;
+		break;
+
+	case 8100:
+		hsclk_sel = 0x03;
+		dec_start_mode0 = 0x4f;
+		div_frac_start2_mode0 = 0xa0;
+		div_frac_start3_mode0 = 0x01;
+		lock_cmp1_mode0 = 0x17;
+		lock_cmp2_mode0 = 0x15;
+		lock_cmp_en = 0x08;
+		code1_mode0 = 0x14;
+		code2_mode0 = 0x25;
+		core_clk_div_mode0 = 0x0a;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	writel(0x01, edp->pll + DP_QSERDES_V8_COM_SVS_MODE_CLK_SEL_NORD);
+	writel(0x0b, edp->pll + DP_QSERDES_V8_COM_SYSCLK_EN_SEL);
+	writel(0x02, edp->pll + DP_QSERDES_V8_COM_SYS_CLK_CTRL);
+	writel(0x0c, edp->pll + DP_QSERDES_V8_COM_CLK_ENABLE1);
+	writel(0x06, edp->pll + DP_QSERDES_V8_COM_SYSCLK_BUF_ENABLE);
+	writel(0x30, edp->pll + DP_QSERDES_V8_COM_CLK_SELECT);
+	writel(hsclk_sel, edp->pll + DP_QSERDES_V8_COM_HSCLK_SEL_1);
+	writel(0x07, edp->pll + DP_QSERDES_V8_COM_PLL_IVCO);
+	writel(lock_cmp_en, edp->pll + DP_QSERDES_V8_COM_LOCK_CMP_EN);
+	writel(0x36, edp->pll + DP_QSERDES_V8_COM_PLL_CCTRL_MODE0);
+	writel(0x16, edp->pll + DP_QSERDES_V8_COM_PLL_RCTRL_MODE0);
+	writel(0x06, edp->pll + DP_QSERDES_V8_COM_CP_CTRL_MODE0);
+	writel(dec_start_mode0, edp->pll + DP_QSERDES_V8_COM_DEC_START_MODE0);
+	writel(0x00, edp->pll + DP_QSERDES_V8_COM_DIV_FRAC_START1_MODE0);
+	writel(div_frac_start2_mode0, edp->pll + DP_QSERDES_V8_COM_DIV_FRAC_START2_MODE0);
+	writel(div_frac_start3_mode0, edp->pll + DP_QSERDES_V8_COM_DIV_FRAC_START3_MODE0);
+	writel(0x12, edp->pll + DP_QSERDES_V8_COM_CMN_CONFIG_1);
+	writel(0x3f, edp->pll + DP_QSERDES_V8_COM_INTEGLOOP_GAIN0_MODE0);
+	writel(0x00, edp->pll + DP_QSERDES_V8_COM_INTEGLOOP_GAIN1_MODE0);
+	writel(0x00, edp->pll + DP_QSERDES_V8_COM_VCO_TUNE_MAP);
+	writel(lock_cmp1_mode0, edp->pll + DP_QSERDES_V8_COM_LOCK_CMP1_MODE0);
+	writel(lock_cmp2_mode0, edp->pll + DP_QSERDES_V8_COM_LOCK_CMP2_MODE0);
+	writel(0x0a, edp->pll + DP_QSERDES_V8_COM_BG_TIMER);
+	writel(core_clk_div_mode0, edp->pll + DP_QSERDES_V8_COM_CORECLK_DIV_MODE0);
+	writel(0x00, edp->pll + DP_QSERDES_V8_COM_VCO_TUNE_CTRL);
+	writel(0x1f, edp->pll + DP_QSERDES_V8_COM_BIAS_EN_CLKBUFLR_EN);
+	writel(0x0f, edp->pll + DP_QSERDES_V8_COM_CORE_CLK_EN);
+	writel(0xa0, edp->pll + DP_QSERDES_V8_COM_VCO_TUNE1_MODE0);
+	writel(0x01, edp->pll + DP_QSERDES_V8_COM_VCO_TUNE2_MODE0);
+	writel(code1_mode0, edp->pll + DP_QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE1_MODE0);
+	writel(code2_mode0, edp->pll + DP_QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE2_MODE0);
+
+	return 0;
+}
+
 static const struct of_device_id qcom_edp_phy_match_table[] = {
 	{ .compatible = "qcom,glymur-dp-phy", .data = &glymur_phy_cfg, },
 	{ .compatible = "qcom,sa8775p-edp-phy", .data = &sa8775p_dp_phy_cfg, },

-- 
2.34.1

