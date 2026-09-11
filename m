Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861E3C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9CF910F689;
	Fri, 11 Sep 2026 15:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TMUrNJLG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VqRBqSO1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29D7410F689
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:39:19 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BFA6rn658277
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UnGddGWrJdF1zxB4VFc2RF/9fwOZjjhxSTnj+Nzo7/I=; b=TMUrNJLGo4CfY+H4
 wgrvvueXkD+Bu3I8ogPvOQXkz2Iu5I5U3QVc31Ty94A3eR8c6upfwrQy09SftJAS
 ltmCCdwbF5QZLBA2A2GTMem/ogime0uTbSFG1kN/wulxeDj8bsemN95Khe+g3gZr
 Ml1frnnXtYs5nxntFynfTJGSumZdfpkEoxfDlxqvP21vyL3UsOKUKKXSgzRZ4ULR
 2DtVb/b1EKDM9I0MMVeapD2/Bu+QVacM25AGehap+/nX3ZzqOSUxSNZue57Lo+Od
 gbqDS4lhEBctFmoELwtZmy3zggF6cRdWfaJyAOMFMgJQEo3brMbvpY/pgBucwuwV
 bOon+g==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmm22r46u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:39:17 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-46a12cfc288so1346004fac.2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141157; x=1789745957;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UnGddGWrJdF1zxB4VFc2RF/9fwOZjjhxSTnj+Nzo7/I=;
 b=VqRBqSO12Q0H8N9cd51/fV/3EUTKf+JWqAVxl5Cn7+sLnJQXD5qzegH8gDetNW3e9S
 64TtT0sZVRiTGIBMmsjPdY5GsOqJC1eY3q61oLcOGvwZB0OMG4vOZ0J70GUJ+vhwvykb
 NN/1LpfPMG8hJCWDvD2jsTr5z4oSZWguPB7X6d4dPG78KLybcAlOJwLNh73V5G7YRt/r
 oxYU/+txE4I7HUF0vJ0l07/4og0lMs+7rpjsyISWCVv4njCYse0rRsSzKaWlBiXrqos2
 FNa9HST9lRqQOfs1B7lvobrD4NTNnnIVYYVdtL2sdvA08T0e3Oe1fjRdQoqLaSE8FMgJ
 unig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141157; x=1789745957;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UnGddGWrJdF1zxB4VFc2RF/9fwOZjjhxSTnj+Nzo7/I=;
 b=GLcBzT2ZLLegEbucPVD/sVINoBZYIgCIeiKxeSn9iyWRWLZLxyze/vZ+6cXjoBWJgF
 NJZrcV0Q7/UQDorz5A60TjP0o8beHgyghfWYKwTi6suPpjbggpVMe8ltjjiLECEfkTbi
 tTep35/dc84EPbe6Rnbwou/1BvtLAgoBU2aijXNjtzK8PWk5DsAOIf0NsMfJamyL4xON
 k6KcshguR6bzVD7oZJJHK0mB5cXT7JyvFAqocxpA4rEVTlpGzSdBhJ1Lu9nHgg1cG1kJ
 OCazs44f5SL3vm0I8Xzow3dThX+6BX1ctOw0W/Wn7riHazIZstK4H+hCAyK6W1/GzkeE
 y3PA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTip/jikYoAXewubLDQPXXsEcvMzXkkzxqWfDLVd5x9frW8Eok9FKfsFwhtDCn97jMaZogWx+Yd70=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mDdD+0RggQMSOW2yj2mpjzRcQJl9dPPdTO+ASfw+lImyToc7ul
 n/IvzDd89R6pviGxNemTDjqymuMT5uNb1HrRJc3Wh5bTtPGKX9/1KgpymTn9NrR2HF++EZDs5iY
 bT/vQV0CXHeK4L6Wzkp0j5h/8gOPo9rUBP9gjW38UlKIyCNnh/rEhdj6opW22ZFvz15e7mDQ=
X-Gm-Gg: AYBFou2mL7I1HS6g9qUAK7HSsqmEtPBK/Cp95wVr3g5y5i223IgOw2a7cq+eoLKtj4f
 EsDZZ2nY+ViC5OtcZ10m+iP8Pp8hM1cF6aF59dP3ARBxS9/Ld9cQXTec74UkSYt1fHsuI7f+l55
 fpG/2TXJW/n1mVniPjxamfCvsosKdT41FwcZ1EyUtfl0Dj21npO7fpuZeuYm+P4A54Qnskdr2Gq
 rvmA32Ri2XtGICGXiWJkbJDhIExHjKronVQyCUMNeuJWPffKYEd1MLtDPfLgcJvD1Y9aTEHzStC
 L6pLn9tmgk4EOzuflrhb5tB9CCCNHnNyawwmCc74y/e+FfIvf/Hv+PclTg/W/5FI1C001CfGUoS
 IFC9KGo4iZ0B+dBU/RxyQYC0fwkM=
X-Received: by 2002:a05:6871:4527:b0:45e:4deb:92e7 with SMTP id
 586e51a60fabf-47de9ea1f6cmr5600506fac.10.1789141157217; 
 Fri, 11 Sep 2026 08:39:17 -0700 (PDT)
X-Received: by 2002:a05:6871:4527:b0:45e:4deb:92e7 with SMTP id
 586e51a60fabf-47de9ea1f6cmr5600455fac.10.1789141156830; 
 Fri, 11 Sep 2026 08:39:16 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df90ff148sm1882160fac.14.2026.09.11.08.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:39:16 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 21:06:45 +0530
Subject: [PATCH 14/17] phy: qcom: edp: Add Nord PLL configuration callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-nord-drv-dt-v1-14-e25c073cf1b6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789141012; l=5018;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=z9E4EG9wSuZ5+j69xkzxnB+1Nroa+6lja69Qmbxvx1A=;
 b=6id+SyRX/F4n99lfnbRmoSJL5H686LP5GjLFNv025TolLH4cDG8X4GLI5HRPD/xCoO2AJe5E4
 ilic7KghrJ5BbCGAhfAEvuRO4nGuGvV0eaptA9ltOIaTgvhNfhqQtoC
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfXyX+QaLt7gph4
 hbZmUenlEA3VR0LoJ7DNb5P+TTL+Qzlj+t9JJriL94ElQq1v7MKPfiSkBlr6Cl01wc0hhKETwf+
 m/7M46HvM6SqdMiBK+UfHpiYEh5zGRDu7O5oCFh42njzrOeM82Nb7NnAh60b++ptvcjLaKcBR8d
 ihtssCshv0IVngpjjW3UT53y1QDYKYV+JBhlYY/jH0oVR9Qi2K+UPSvrw4UOZLYyw3CpnhG5/DT
 FE1KtxjhOV/bcmisuAOqe3h9jXNNtOFKV2r3nTEL1t2VvUMqDi+EITXcCh3SCMW/lT053tVS2k6
 1o/nwCqLII0lp+8Iyq5DXbzp1UdY0bkZamNQBxz9oTM/kQp03fKZeFibdHlo/T3olXYUiXAlgPY
 o5oHMvp+A3bGLulXaEfttBTC2T0tXyTRKBW0RZ5OcNryVnr3ZecjDIiE11JSb85rHox6ODwB7+E
 xcj77p8LTK5FBL0YLig==
X-Authority-Analysis: v=2.4 cv=LPDz05W9 c=1 sm=1 tr=0 ts=6aa420a5 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=LM-BLXuauT-zrwgKAhAA:9 a=QEXdDO2ut3YA:10
 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-ORIG-GUID: ZucaOt44I434ittkLgzWfxMV_ctK6f0s
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX5N10pq4ImN9P
 YdlucdQ5phFq1Y9Z2eF9z094UvfZJV+ONIGvtB+zFde8GpUsYLhe7iDDVpyJs3dAzBUwFpG/X3H
 YB6xF70FIvNsNBrUUHiRLDCuR8e0/Es=
X-Proofpoint-GUID: ZucaOt44I434ittkLgzWfxMV_ctK6f0s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 phishscore=0
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

Nord uses a 38.4 MHz CXO reference with a different QSERDES v8 COM
register layout and PLL coefficients.  Add
qcom_edp_com_configure_pll_nord() which programs all QSERDES COM PLL
registers with link-rate-dependent values for RBR, HBR, HBR2 and
HBR3, per HPG Table 2-1-d.

Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 112 ++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index a0f4b12e561e..4d1b2c81d956 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -1688,6 +1688,118 @@ static int qcom_edp_com_configure_ssc_nord(const struct qcom_edp *edp)
 }
 
 
+/*
+ * Nord PLL configuration per HPG Table 2-1-d, CXO = 38.4 MHz.
+ * Supported link rates: 1.62 Gbps (RBR), 2.7 Gbps (HBR),
+ * 5.4 Gbps (HBR2), 8.1 Gbps (HBR3).
+ */
+static int qcom_edp_com_configure_pll_nord(const struct qcom_edp *edp)
+{
+	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	u32 div_frac_start1_mode0;
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
+		hsclk_sel		= 0x0c;
+		dec_start_mode0		= 0x54;
+		div_frac_start1_mode0	= 0x00;
+		div_frac_start2_mode0	= 0x00;
+		div_frac_start3_mode0	= 0x06;
+		lock_cmp1_mode0		= 0x37;
+		lock_cmp2_mode0		= 0x04;
+		lock_cmp_en		= 0x04;
+		code1_mode0		= 0x8d;
+		code2_mode0		= 0x27;
+		break;
+
+	case 2700:
+		hsclk_sel		= 0x04;
+		dec_start_mode0		= 0x46;
+		div_frac_start1_mode0	= 0x00;
+		div_frac_start2_mode0	= 0x00;
+		div_frac_start3_mode0	= 0x05;
+		lock_cmp1_mode0		= 0x07;
+		lock_cmp2_mode0		= 0x07;
+		lock_cmp_en		= 0x08;
+		code1_mode0		= 0xf6;
+		code2_mode0		= 0x20;
+		break;
+
+	case 5400:
+		hsclk_sel		= 0x01;
+		dec_start_mode0		= 0x46;
+		div_frac_start1_mode0	= 0x00;
+		div_frac_start2_mode0	= 0x00;
+		div_frac_start3_mode0	= 0x05;
+		lock_cmp1_mode0		= 0x0f;
+		lock_cmp2_mode0		= 0x0e;
+		lock_cmp_en		= 0x08;
+		code1_mode0		= 0xf6;
+		code2_mode0		= 0x20;
+		break;
+
+	case 8100:
+		hsclk_sel		= 0x03;
+		dec_start_mode0		= 0x4f;
+		div_frac_start1_mode0	= 0x00;
+		div_frac_start2_mode0	= 0xa0;
+		div_frac_start3_mode0	= 0x01;
+		lock_cmp1_mode0		= 0x17;
+		lock_cmp2_mode0		= 0x15;
+		lock_cmp_en		= 0x08;
+		code1_mode0		= 0x14;
+		code2_mode0		= 0x25;
+		core_clk_div_mode0	= 0x0a;
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
+	writel(div_frac_start1_mode0, edp->pll + DP_QSERDES_V8_COM_DIV_FRAC_START1_MODE0);
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
+	writel(0x1d, edp->pll + DP_QSERDES_V8_COM_BIAS_EN_CLKBUFLR_EN);
+	writel(0x0f, edp->pll + DP_QSERDES_V8_COM_CORE_CLK_EN);
+	writel(code1_mode0, edp->pll + DP_QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE1_MODE0);
+	writel(code2_mode0, edp->pll + DP_QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE2_MODE0);
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

