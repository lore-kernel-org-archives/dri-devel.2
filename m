Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5184C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8FA710F686;
	Fri, 11 Sep 2026 15:39:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DNcvZsXh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KEWTsXpF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32F4810F686
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:39:10 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEmFQ8798910
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7GNl5Ol7V171vLY4SOIszaya0H3xLldgY2l7ienkQzY=; b=DNcvZsXhmARZ35ye
 zktBb0/2OfN3xCnrw2BrlTi7/7yEOxpVAFohELuLfYHmX5IyYyQVFYQ1rv8F9kS5
 UUt9/0hFtP/Urh4UBFUKrLkqyJCLll3hEkaXEWBAoSoIcWDXIy4bwHz3F7zq02T9
 fcO+h1g1Qc6KkMSzUwVxHnYi5obTEWXmU45nvXdSI8nzaYoUJXHsP/9wRbjoYfqp
 s8w+uTJYGhZ8r4VXwOBbvFCHty+/IdqLwvPnMZ9FJJM86lEUAW6Te2FbXnpFbkBB
 gFNGpL6UcSuOp8G2XN52kjvLW8gvR32Jt1PXjbr9JHSLQYGEadxCUQkQhf1Jeje+
 plOLcA==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm2q14a6r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:39:08 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-467c2c754f8so603412fac.3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141148; x=1789745948;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7GNl5Ol7V171vLY4SOIszaya0H3xLldgY2l7ienkQzY=;
 b=KEWTsXpFb1/N+yBxIl5ysDSllqYEw5SsyjzSqTiengCeSqR/gaQsAZ6OrN57V6XCGN
 Ekz/GuCgR9LmbO1gOlYeQBPffodbc5C73WYd5cAw/5XfXSeNN8AzVdspfCGEsX9bgrSv
 pVxUsEUK6xzg4RWMNWkIgM3rW0ruTQSvCPem6u8KN4GT0x0DfCRX0bSqpIY+atBTkXRM
 GH3b5WA2d6gaPtdbfedunQc8wEbDE4LMv0NxFgqTv4K7qtU9bMOp0Qc/YjIszu/KJWIi
 61dDKXblEtEDHGpqDxc3qLbPBwbl+chhE1K0DGFZTZFFyLcq7qnR+kWafJ95tcmY6c+t
 48gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141148; x=1789745948;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7GNl5Ol7V171vLY4SOIszaya0H3xLldgY2l7ienkQzY=;
 b=rUMVFm8RM2ekrt81O5kKQG0RZihLtFE7YtH2GNmfyU2C8X778vXrqYhuZJtTJlxNBc
 J2yhF2qLc7eHVlfnlO6+/q3fRe7kRTlB/pk3qMHSl2Advn3Xdtv9pOs6oC4vBEAbm4q7
 VNGQ6Yrhfm41Dyk+eUcj7Yts5akvzNHMtQaYVoVaFLPv259Q3Jk05xaa82pVg5DK477Q
 2CZvpCscwU+TEtUJ2azz3aaTDUJ3x5T2fvNr9cAhJp1wBHwhCAh23r3o7TsZTKG04ElA
 We1Pa0/1/JzvQfzjHOYl8aaHuTL9cyBUTeHajvqGrM57f6jHU8C5L7gKy724Gp+oTjVT
 mpQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxx4hoW+N2Dw6K0xI11vcO5Csf4zYGzSjcJRSkfKpynILfM4yFb7ZuqsCFSMZ4sBo7lgK0TpI4VxaM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++niKVCynd7TCwOTD7HGp3rRvOQFqWA5yWn1bB8LiS8afBVlsYp2
 bCGc/nUcgF4Zwhwp93IilYAKkoPuTTe51OEKnT+YmS4TEwZXhpC71Nq+p5tgtv9kMEqH910Ewh7
 u8W01rQCWIQkr9yUwk2GTnBveKoyrEkJEHhPzn8lm6NIqz43PmSi7OUxY46RXVlpjRkcXhpE=
X-Gm-Gg: AYBFou2xTUD6ipSv/jYLKJ2tCcKeH3d9TjJFkQpY+4jFUp3tIO7rv+9BYlsYfP7vKD1
 ZCh8CZlhKIgj0qN01WPVRHIoEoc2txG8KLN1uYwI0ovqg+J2nnfZ+xBFggiwUDzQKhcB2dfe3qv
 aZDi2NcMxJUcVhAfRjbosuFpPnzz9nwYg62/e0sIUTke70oDeFJGRywJOZgtqK/1xlq3WmlFuOP
 c2LI4mG2DwsoYATBIrrbVwb0s5msYtZ3MR/cX61PHoZ5rFQhGbX+Yv0QYHJVv5mGviAkh/dwfXR
 nvQiHJdNXKRuNSffi9CDBKC1BHY81/i0R3zO7HbBpTlEj4wIaPEX9QIwfsy1pIZhaFqsypVwh7I
 WBcV3n/SkV90JbGluSt+WDRswJm4=
X-Received: by 2002:a05:6870:b017:b0:475:e0a7:9f2b with SMTP id
 586e51a60fabf-47de8f960b1mr3322084fac.25.1789141147987; 
 Fri, 11 Sep 2026 08:39:07 -0700 (PDT)
X-Received: by 2002:a05:6870:b017:b0:475:e0a7:9f2b with SMTP id
 586e51a60fabf-47de8f960b1mr3322042fac.25.1789141147541; 
 Fri, 11 Sep 2026 08:39:07 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df90ff148sm1882160fac.14.2026.09.11.08.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:39:06 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 21:06:44 +0530
Subject: [PATCH 13/17] phy: qcom: edp: Add Nord spread-spectrum clocking
 configuration callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-nord-drv-dt-v1-13-e25c073cf1b6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789141012; l=2061;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=FwJzTy5VClUwUHMCnyi7dHL7Mwmhf3eI0myaOfAWa3U=;
 b=DiWqQ5UZ5j739oSBkbZhMvv/suocnQ9Xj3QcKzoOKXRHYMnmqYPhStGPTKG47qOZElQeh7Ny1
 iyiVuZ1MPvtCsZRvX9BXs07CT/rnTDWTwPf/jphP1/whRtnfvYtBNuG
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Authority-Analysis: v=2.4 cv=d6lgWhjE c=1 sm=1 tr=0 ts=6aa4209c cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=guHe4NRHSy_fFtsU4t4A:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX5N1+PoNjc3X1
 I1sy9ifQ0DUQvciaklgh8MyWTj+C3bagSHKrQhwZYU9aKE6ag4tBpkTYDC/gkjEKyGngGEeV8SX
 3eMLuTUbfZ+pCEvDlR7laythntWiIncaix2fmJvbMCTPKpzdgNi/J1p2ZyPAzn8Cu3eVJBmoH5e
 NrZipa1302yR74m4bF90f2FCvqJGO7TlW+9yGeh1Uvu5OgEkgf/2/h5VNkTsSYdeA+sqsmUF2ba
 HLl5enLsXXtEbbIV5XX7T3BDke4AlujmY1HhcDbxt0LREiHqbAi7Q+BSd2JiX8qs+16bY5VmBr/
 NMvkZLOmMvZwBaQ0iEe7iiC/tq0nMR6akxTLhpNFC0jogKCnfQvPMBTQ45Re+FjZZTH6NFHiZiE
 S3Ma78Dn5CtrJoBRYmfIR+8XcAVM24wzvzd+JD/eGOZAxzsKC1kfoYUYhmM7ABgs3Cb7okgFSRu
 uh5ufhUs+kJaPamBprQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX93J+ronW/hJJ
 thFezENG1wZ5NW1TD1l50d8v8CiEaqxE0miFKo4B7G7UXd9O2tPRoKahxy8tMW0T3oclC5wXkl2
 +zZv51P8dlHumwwgysmR98LHNNXPSQc=
X-Proofpoint-GUID: GS6Ja84TZTHuPfesY5wYuYfXJ-sBpy-p
X-Proofpoint-ORIG-GUID: GS6Ja84TZTHuPfesY5wYuYfXJ-sBpy-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
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

Nord requires different SSC register values compared to existing SoCs.
Add qcom_edp_com_configure_ssc_nord() which programs SSC_PER1/2 with
fixed values and link-rate-dependent SSC_STEP_SIZE1/2 for RBR, HBR,
HBR2 and HBR3, per HPG Table 2-9.

Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 43 +++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index ec4220cffe69..a0f4b12e561e 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -1645,6 +1645,49 @@ static int qcom_edp_com_bias_en_clkbuflr_nord(const struct qcom_edp *edp)
 }
 
 
+/*
+ * Nord SSC settings per HPG Table 2-9.
+ * SSC_PER1 = 0x6b and SSC_PER2 = 0x02 are fixed across all link rates.
+ * SSC_STEP_SIZE1/2 are link-rate dependent.
+ */
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
+	writel(0x01, edp->pll + DP_QSERDES_V8_COM_SSC_EN_CENTER);
+	writel(0x00, edp->pll + DP_QSERDES_V8_COM_SSC_ADJ_PER1);
+	writel(0x6b, edp->pll + DP_QSERDES_V8_COM_SSC_PER1);
+	writel(0x02, edp->pll + DP_QSERDES_V8_COM_SSC_PER2);
+	writel(step1, edp->pll + DP_QSERDES_V8_COM_SSC_STEP_SIZE1_MODE0);
+	writel(step2, edp->pll + DP_QSERDES_V8_COM_SSC_STEP_SIZE2_MODE0);
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

