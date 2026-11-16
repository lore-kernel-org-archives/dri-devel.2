Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A50C606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KPlmW6Qj;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NpgS7wOU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8517210F182;
	Mon, 16 Nov 2026 13:19:13 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38F1910F182
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:19:02 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGC0uDs2472430
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FIVPnD50EX4S0ADQSI/wOp6ZVRAhbJD8QVbyPX8w2gY=; b=KPlmW6QjmfepMvGy
 AqFuZYuZqe+SdBCkb9Q8TzIz2KeR+bmRF74k7Ncmwbq3aB0z5wzfoFbnKkq9meh2
 +wXqzycPdSLn3SCirhKC66VCUnUuiDvxwH9j9dz6yEQU9xBIQFSOjIVhchrofQtK
 d60fBNQzt7x0sDiNTXNRbYQWxFUY+4m00iqj0av1rEKXbz9L3jOOPFf85up7dg5R
 v5kl3fXTfmOY5zIbVRNVUfhHtYb3U3Cixo7w3mw3N6mTzl8wof7RjhMGA5sckRAp
 kvxWyti3Acg+WQYuVsWNxuXWXz2Y+NQr5TBTRrs29Gte+Evy8Lwt/KQwx2D5pkaL
 y7Bnyg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhdxhum-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:19:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f26dd2165so1068240485a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 05:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794835141; x=1795439941;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FIVPnD50EX4S0ADQSI/wOp6ZVRAhbJD8QVbyPX8w2gY=;
 b=NpgS7wOU2b7lVKcxZ0YWNVyPwuO514fqxpGmLI9IPhLNSxi1SwtP6zlPrUNA/G2JR0
 ODiUKZ/nI7zfKh8cwdHm+LfcUxZ/8ksu6RLgcmr0W5NUI2i5AG+rD/Srs7VAA0a3F/57
 z5Y3fEIqwua1fFYyKjxJEqSfq8BSfkC1inhbR2fhymaGc52izxOUnYry9zYuhCZmRJma
 xLidAB+ns5Y+l5K9f6GR9Wc/L9uWOxgrsBhX9/EsdwtDpxINaHje49TUOPLqrb+Z3VJA
 aWXyoWDuNj2xDffV+x4QKlQuKNi/Ucsu48XbMkU792Lcn8ETw2s73K9yPn8iNDglM+bV
 QwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835141; x=1795439941;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FIVPnD50EX4S0ADQSI/wOp6ZVRAhbJD8QVbyPX8w2gY=;
 b=xitiMuFX17H9flOqrcnhBmhIFDwSqCteMmc6VJrIHjU//lY8xo4Mt54o6Zy6xYMnph
 d6dozSWoj0Sp9Sqnx5MrZtG8nJtySw1e2pIT5CNSgGNGl3Ssl5nolpa18H6igwrtySqN
 jg2oqxzn5MiFhJSMgOu+rDG83jK8WNwOYogdWIlQviRx+/fNcalwE/0tA7f7eiU/tPJk
 QiHlfeGuJWQ5dxmjxB/vmm9J5zKanZV/ZIYr6eaXmwCITESD/3aGUVjG8xOSeXyg0Mb6
 T8QTTDJr/GxvHcMvSeMyz4myjuxyzp371n2P/zfXlyh2wzMy64tWn1lACWOeXvWe1dIs
 W14Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGny9LTtLG4T03DSOwHQoQ+jBn7UvSapu/WxW+cu7dDDaL2z7yRK2EHVgsBXBI+sY4TtFK0L+kFcsM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9PRfPBdLO94yhcuG37Ce6WEzQG4hKmuP/LysaD76sbNgpPeYYD
 x6wwlBNvAOuwpMYAee+NC0ui7ugjmXLj9rMvJ1LpyLhFNnKtI2T6coEkcgshl5AafuS6URTpdMa
 uuXTiIV/JdWh5qvyGJ9GeaKjXEW5NVYGHugPOvO7ATWkQ4wwziE94RzS+JKit2bX7KQ3+ORY=
X-Gm-Gg: AYBFou2MKv7dYGGb4158gTONnXavkffXuICgSLtREtnoQ86AwQ5d85/W2GVjQ+5mqAG
 fc4TLvH4MSeoVr3ppFMxiR4pkpyhfnCgrIYnt9eTDZvNgzD4oYW/dlrZn/IdOAR8fpMbI1MzDpL
 HkFLMfng22VFqoxW3QPgo/QqFF/ZgqkWOICQx2ojT2mvqOWxBJYsC/H8eR+trsSpNsPzWyGdCP4
 j7KDreI5uS7kiEQzoxoI/ppkoqGQDf82MeC3wZNziYhysdo79lW6RIgo+C4rwMDq9yaU+WuBMlS
 te5isA7kg2ugEgaglNm30gzydxRiLbSH7n6LS0ctf7TbQ4tTmTXuy/xthrD64j53JF2jYfvHO5l
 J41lwlNQ57oS+lqhJIVq6EspT230svnqolwwedCIwuLzm3eSLdymYim9WgOqb1c6TRg+WQapenw
 N3
X-Received: by 2002:a05:620a:439b:b0:93f:35a7:cd4 with SMTP id
 af79cd13be357-9494bc708femr1447444385a.67.1794835140575; 
 Mon, 16 Nov 2026 05:19:00 -0800 (PST)
X-Received: by 2002:a05:620a:439b:b0:93f:35a7:cd4 with SMTP id
 af79cd13be357-9494bc708femr1447439685a.67.1794835140037; 
 Mon, 16 Nov 2026 05:19:00 -0800 (PST)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c8e1c94sm843927285a.39.2026.11.16.05.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:18:59 -0800 (PST)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 18:46:50 +0530
Subject: [PATCH v3 11/11] phy: qcom: edp: Add Nord eDP/DP PHY support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-nord-drv-dt-v3-11-e3d3bf0e2c49@oss.qualcomm.com>
References: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
In-Reply-To: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
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
Cc: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794835013; l=10721;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=Eu0id8yu9Mzw5aOSnQtYz/XfuowTz3vy5rElr+dtuHg=;
 b=u2Eug5hdnMG0guprkqGEqoE0Gg3EQX09UXBDRfRETnd8rEGlzxeHXzkwS2TwR0LU34fk/eI/a
 mH16VHEtxrDDCXyt5Kuo+fQjq9itkT1nevf8dhTijeEMO4X6e5SAOaY
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Authority-Analysis: v=2.4 cv=VOVIDNPX c=1 sm=1 tr=0 ts=6afb02c5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=USxDkvc5C5W9gJns0o8A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfXwH9t4AYnZCbW
 QdE6z6uXvlWtyNqDVf1Cfw+A5vvemFjqGTXeGh07jl1pHO9NcAG+quN9xP2QXC3sLzMk6OKbUET
 Nnje1WFVi+YCJQCoipQZSJ+QnDbmcf0=
X-Proofpoint-ORIG-GUID: xcLrdZOdp3DBYMSSDPPGaRZiqMkyvj3w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfX5YVVND4WK9fJ
 y35b9wXNRon+/BJZVwwzd2h8VR4BlhEoufrpPPTC3F12DkBCiBeiOk/MV3cDxDXCv2sucfdOZ0H
 PG7C14EH6VVS82pXVKO9Yhd74gUovTAbKPKGhgEMLW0mCt8SmGVHoJocimlLvbedQ2kCahFdGqL
 3l+CMgHOE+1t7f5QTHUIIggHwL6B2FyVUAOUj1TXppWdexPNWmpcyeAl/tALY5S2zfXL0x3QKT1
 gSvOxhMuf3S3deMK0nudowYp2ELW4smO7/JZSbicmiR2fIt8e0gPaoNPZJawM48WeU/Woer4wVW
 xkUulO2iMFolM2NmYxhyzaH0l+ErBsVcTXR3F9WoC+zrqLNxlNz5elklOm0HGNlWdbLXWKAAyV4
 vGuZ8xHpdQLvpXQOUPWXzRVekqo7k4Rn3Abe+891A/nbB7B+QX6xb9MGM2AneVCA5/1D7oVKjse
 zpDmRQCDlZPXCw0qGrQ==
X-Proofpoint-GUID: xcLrdZOdp3DBYMSSDPPGaRZiqMkyvj3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160052
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>

Add eDP/DP PHY support for the Qualcomm Nord SoC.  Nord uses a
different QSERDES COM register layout from existing v8 SoCs, so
dedicated NORD_DP_QSERDES_COM_* offsets are used throughout.

Key additions:
- SSC and PLL configuration per HPG Tables 2-8 and 2-9
- Power-on and reset-SM callbacks polling the relocated COM status
  registers
- Voltage-swing and pre-emphasis tables for RBR/HBR and HBR2/HBR3
- LDO, TX resistor calibration, and set_voltages callbacks
- AUX channel and VCO divider config tables
- 'qcom,nord-dp-phy' OF compatible

Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 258 ++++++++++++++++++++++++++++++++++++
 1 file changed, 258 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 41bcfffbb357..eb8beda84196 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -27,6 +27,7 @@
 #include "phy-qcom-qmp-qserdes-com-v6.h"
 
 #include "phy-qcom-qmp-qserdes-dp-com-v8.h"
+#include "phy-qcom-qmp-qserdes-dp-com-v8-nord.h"
 
 /* EDP_PHY registers */
 #define DP_PHY_CFG                              0x0010
@@ -1514,6 +1515,262 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
+static const u8 nord_dp_pre_emp_hbr_rbr[4][4] = {
+	{ 0x00, 0x0e, 0x15, 0x1a },
+	{ 0x00, 0x0e, 0x15, 0xff },
+	{ 0x00, 0x0e, 0xff, 0xff },
+	{ 0x02, 0xff, 0xff, 0xff },
+};
+
+static const struct qcom_edp_swing_pre_emph_cfg nord_dp_swing_pre_emph_cfg = {
+	.swing_hbr_rbr		= &dp_swing_hbr_rbr,
+	.swing_hbr3_hbr2	= &dp_swing_hbr2_hbr3,
+	.pre_emphasis_hbr_rbr	= &nord_dp_pre_emp_hbr_rbr,
+	.pre_emphasis_hbr3_hbr2	= &dp_pre_emp_hbr2_hbr3,
+};
+
+/* Nord DP PHY register offsets (relocated from v8 base) */
+#define DP_PHY_TX2_TX3_LANE_CTL_NORD		0x00c0
+#define DP_PHY_STATUS_NORD			0x0110
+#define DP_PHY_LDO_CFG_NORD			0x00f0
+#define DP_PHY_TX_LN0_DRV_LVL_NORD		0x00e4
+#define DP_PHY_TX_LN1_DRV_LVL_NORD		0x00e8
+#define TXn_TX_BAND_NORD			0x0024
+
+static int qcom_edp_com_configure_ssc_nord(const struct qcom_edp *edp)
+{
+	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	u32 step1;
+	u32 step2;
+
+	switch (dp_opts->link_rate) {
+	case 1620:
+		step1 = 0x83;
+		step2 = 0x02;
+		break;
+
+	case 2700:
+	case 5400:
+		step1 = 0x18;
+		step2 = 0x02;
+		break;
+
+	case 8100:
+		step1 = 0x5b;
+		step2 = 0x02;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	writel(0x01, edp->pll + NORD_DP_QSERDES_COM_SSC_EN_CENTER);
+	writel(0x00, edp->pll + NORD_DP_QSERDES_COM_SSC_ADJ_PER1);
+	writel(0x6b, edp->pll + NORD_DP_QSERDES_COM_SSC_PER1);
+	writel(0x02, edp->pll + NORD_DP_QSERDES_COM_SSC_PER2);
+	writel(step1, edp->pll + NORD_DP_QSERDES_COM_SSC_STEP_SIZE1_MODE0);
+	writel(step2, edp->pll + NORD_DP_QSERDES_COM_SSC_STEP_SIZE2_MODE0);
+
+	return 0;
+}
+
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
+	writel(0x01, edp->pll + NORD_DP_QSERDES_COM_SVS_MODE_CLK_SEL);
+	writel(0x0b, edp->pll + NORD_DP_QSERDES_COM_SYSCLK_EN_SEL);
+	writel(0x02, edp->pll + NORD_DP_QSERDES_COM_SYS_CLK_CTRL);
+	writel(0x0c, edp->pll + NORD_DP_QSERDES_COM_CLK_ENABLE1);
+	writel(0x06, edp->pll + NORD_DP_QSERDES_COM_SYSCLK_BUF_ENABLE);
+	writel(0x30, edp->pll + NORD_DP_QSERDES_COM_CLK_SELECT);
+	writel(hsclk_sel, edp->pll + NORD_DP_QSERDES_COM_HSCLK_SEL_1);
+	writel(0x07, edp->pll + NORD_DP_QSERDES_COM_PLL_IVCO);
+	writel(lock_cmp_en, edp->pll + NORD_DP_QSERDES_COM_LOCK_CMP_EN);
+	writel(0x36, edp->pll + NORD_DP_QSERDES_COM_PLL_CCTRL_MODE0);
+	writel(0x16, edp->pll + NORD_DP_QSERDES_COM_PLL_RCTRL_MODE0);
+	writel(0x06, edp->pll + NORD_DP_QSERDES_COM_CP_CTRL_MODE0);
+	writel(dec_start_mode0, edp->pll + NORD_DP_QSERDES_COM_DEC_START_MODE0);
+	writel(0x00, edp->pll + NORD_DP_QSERDES_COM_DIV_FRAC_START1_MODE0);
+	writel(div_frac_start2_mode0, edp->pll + NORD_DP_QSERDES_COM_DIV_FRAC_START2_MODE0);
+	writel(div_frac_start3_mode0, edp->pll + NORD_DP_QSERDES_COM_DIV_FRAC_START3_MODE0);
+	writel(0x12, edp->pll + NORD_DP_QSERDES_COM_CMN_CONFIG_1);
+	writel(0x3f, edp->pll + NORD_DP_QSERDES_COM_INTEGLOOP_GAIN0_MODE0);
+	writel(0x00, edp->pll + NORD_DP_QSERDES_COM_INTEGLOOP_GAIN1_MODE0);
+	writel(0x00, edp->pll + NORD_DP_QSERDES_COM_VCO_TUNE_MAP);
+	writel(lock_cmp1_mode0, edp->pll + NORD_DP_QSERDES_COM_LOCK_CMP1_MODE0);
+	writel(lock_cmp2_mode0, edp->pll + NORD_DP_QSERDES_COM_LOCK_CMP2_MODE0);
+	writel(0x0a, edp->pll + NORD_DP_QSERDES_COM_BG_TIMER);
+	writel(core_clk_div_mode0, edp->pll + NORD_DP_QSERDES_COM_CORECLK_DIV_MODE0);
+	writel(0x00, edp->pll + NORD_DP_QSERDES_COM_VCO_TUNE_CTRL);
+	writel(0x1f, edp->pll + NORD_DP_QSERDES_COM_BIAS_EN_CLKBUFLR_EN);
+	writel(0x0f, edp->pll + NORD_DP_QSERDES_COM_CORE_CLK_EN);
+	writel(0xa0, edp->pll + NORD_DP_QSERDES_COM_VCO_TUNE1_MODE0);
+	writel(0x01, edp->pll + NORD_DP_QSERDES_COM_VCO_TUNE2_MODE0);
+	writel(code1_mode0, edp->pll + NORD_DP_QSERDES_COM_BIN_VCOCAL_CMP_CODE1_MODE0);
+	writel(code2_mode0, edp->pll + NORD_DP_QSERDES_COM_BIN_VCOCAL_CMP_CODE2_MODE0);
+
+	return 0;
+}
+
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
+static int qcom_edp_tx_res_config_nord(const struct qcom_edp *edp)
+{
+	writel(0x06, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX0);
+	writel(0x06, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX1);
+	writel(0x06, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX0);
+	writel(0x06, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX1);
+	writel(0x06, edp->tx0 + TXn_TX_EMP_POST1_LVL);
+	writel(0x06, edp->tx1 + TXn_TX_EMP_POST1_LVL);
+	writel(0x05, edp->tx0 + TXn_TX_BAND_NORD);
+	writel(0x05, edp->tx1 + TXn_TX_BAND_NORD);
+	writel(0x12, edp->edp + DP_PHY_TX_LN0_DRV_LVL_NORD);
+	writel(0x12, edp->edp + DP_PHY_TX_LN1_DRV_LVL_NORD);
+
+	return 0;
+}
+
+static int qcom_edp_phy_power_on_nord(const struct qcom_edp *edp)
+{
+	u32 val;
+
+	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
+	       DP_PHY_PD_CTL_LANE_0_1_PWRDN | DP_PHY_PD_CTL_LANE_2_3_PWRDN |
+	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
+	       edp->edp + DP_PHY_PD_CTL);
+	writel(0xfc, edp->edp + DP_PHY_MODE);
+
+	return readl_poll_timeout(edp->pll + NORD_DP_QSERDES_COM_CMN_STATUS,
+				  val, val & BIT(7), 5, 200);
+}
+
+static int qcom_edp_phy_com_resetsm_cntrl_nord(const struct qcom_edp *edp)
+{
+	u32 val;
+
+	writel(0x20, edp->pll + NORD_DP_QSERDES_COM_RESETSM_CNTRL);
+
+	return readl_poll_timeout(edp->pll + NORD_DP_QSERDES_COM_C_READY_STATUS,
+				  val, val & BIT(0), 500, 10000);
+}
+
+static int qcom_edp_set_voltages_nord(struct qcom_edp *edp, u8 swing, u8 emph)
+{
+	writel(swing, edp->edp + DP_PHY_TX_LN0_DRV_LVL_NORD);
+	writel(emph, edp->tx0 + TXn_TX_EMP_POST1_LVL);
+
+	writel(swing, edp->edp + DP_PHY_TX_LN1_DRV_LVL_NORD);
+	writel(emph, edp->tx1 + TXn_TX_EMP_POST1_LVL);
+
+	return 0;
+}
+
+static const struct phy_ver_ops qcom_edp_phy_ops_nord = {
+	.com_power_on		= qcom_edp_phy_power_on_nord,
+	.com_resetsm_cntrl	= qcom_edp_phy_com_resetsm_cntrl_nord,
+	.com_bias_en_clkbuflr	= qcom_edp_com_bias_en_clkbuflr_v8,
+	.com_clk_fwd_cfg	= qcom_edp_com_clk_fwd_cfg_v4,
+	.com_configure_pll	= qcom_edp_com_configure_pll_nord,
+	.com_configure_ssc	= qcom_edp_com_configure_ssc_nord,
+	.com_ldo_config		= qcom_edp_ldo_config_nord,
+	.tx_res_config		= qcom_edp_tx_res_config_nord,
+	.set_voltages		= qcom_edp_set_voltages_nord,
+};
+
+static const struct qcom_edp_phy_cfg nord_edp_phy_cfg = {
+	.is_edp			= false,
+	.aux_cfg		= edp_phy_aux_cfg_nord,
+	.vco_div_cfg		= edp_phy_vco_div_cfg_nord,
+	.dp_swing_pre_emph_cfg	= &nord_dp_swing_pre_emph_cfg,
+	.edp_swing_pre_emph_cfg	= &edp_phy_swing_pre_emph_cfg,
+	.ver_ops		= &qcom_edp_phy_ops_nord,
+	.phy_status_reg		= DP_PHY_STATUS_NORD,
+	.bias1_en_2lane		= 0x03,
+	.tx2_tx3_lane_ctl	= DP_PHY_TX2_TX3_LANE_CTL_NORD,
+};
+
 static const struct of_device_id qcom_edp_phy_match_table[] = {
 	{ .compatible = "qcom,glymur-dp-phy", .data = &glymur_phy_cfg, },
 	{ .compatible = "qcom,sa8775p-edp-phy", .data = &sa8775p_dp_phy_cfg, },
@@ -1522,6 +1779,7 @@ static const struct of_device_id qcom_edp_phy_match_table[] = {
 	{ .compatible = "qcom,sc8280xp-dp-phy", .data = &sc8280xp_dp_phy_cfg, },
 	{ .compatible = "qcom,sc8280xp-edp-phy", .data = &sc8280xp_edp_phy_cfg, },
 	{ .compatible = "qcom,x1e80100-dp-phy", .data = &x1e80100_phy_cfg, },
+	{ .compatible = "qcom,nord-dp-phy", .data = &nord_edp_phy_cfg, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_edp_phy_match_table);

-- 
2.34.1

