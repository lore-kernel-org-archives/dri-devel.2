Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1984DC88E58
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4128810F25E;
	Fri, 11 Sep 2026 15:38:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Egft1HCQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TmGmJES/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BAF410F25E
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:38:30 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEm2We442908
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +mNRMQrZ5y0e+hJEEvMCoWzyOuVlsmUuJyJuMBp/Tlo=; b=Egft1HCQxEjac6n5
 Kxz4sUj4Gq226o2oikunn4kHRSQlvlU2adMRjavco7lHKyDIqDFbjWQQZbSeKHSV
 XNbY2kcD2Q6dtzz64dLpQyj92wFF0mcfWCCB5O23G0D25u155iqaBP/f1Tls82ts
 uFqXwzBqU2NfpdX0V+FVV3sXI5DKWzeCYv62VA1LP/SZQ7g1ni//ZtIN+W/J3EB7
 f9aZ3VeR+vCjHVXKzgcHKlnxXJ9v7yj2hrqMdy6uZcp3xc1fy8XVhXdXSU1kZ8j1
 zzkwpy55xM+VNu2fQxLqulLa8dnEsc2YYvdYGVeaST24KNVrdI1LMxv5CgnwxX87
 j5/E2A==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmapg2nug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:38:29 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4c467e19391so22240b6e.3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141108; x=1789745908;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+mNRMQrZ5y0e+hJEEvMCoWzyOuVlsmUuJyJuMBp/Tlo=;
 b=TmGmJES/+Hk+HMh54VyWaEavzNcp3JiQrVIuBEu7NZjuV5EQxOS3h/n7ljvl+yvMfI
 vJExStA0NzL6thuqa11+GhJY0cR/khxB42PXVC42QGgo9jXSxCdD+twKgZ9StDOIJyGX
 MWyUpQ7gi97jtY21P6+ODlZ449zQzt3bBruaIoG8NWdiexxvFBGNSZc95YM2Z+eEoeQ7
 7NBou86cT/vAwMDWyrB0bD4FUgyWhGT1ya/Nb9GaLBmENLarG0XD27ssbc2JdYxAj47P
 tp5pwxpdLJwJ7Q8ssIF2CBq8f6406Anduf5E6a7tzs7wyU9GN5A9QZwNnDwaS9og9wgA
 Jzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141108; x=1789745908;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+mNRMQrZ5y0e+hJEEvMCoWzyOuVlsmUuJyJuMBp/Tlo=;
 b=D0AoghgCAc0Htn+YM3JtTre4PpUkXgBzqXBJPe38OIGyDAeBNlKQMEoxRGzGXIWJFS
 Lmw56AOx0qvLUDwGV0NPBDd/YNUbcfVClQ1uqOb/lK5h0gXgV7zmcDT5EpcdxZNiOguq
 mwkiCSSxBnceNsg5N7lhXAvIZzqxSg4vGG1PyOJ2G+uMTVHQ/XUNyzwkMwjsgERW6bpP
 ADlrG/E84xavbgdiMpvGKTnc32mS/ojVqhr/FSJk9nLvP5Y0c2OkZjA3RGT8OhOSK3Fm
 t7EVjiuqW7pKuYT2KFc8NkpPU4cfeAkTqMFT0xVEOfgAtO7OSg8NGDEuvfYpYFmpfW8D
 f8ZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWoKob0O8sj8vgtFNNJt5UAGSXLRYn3BDbr1wJoMzKkINn4vJCw+gCYGQ9ezRu61aVRUlAfRWC3Yo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k8h1BbJMy59hc9Flf5mT+QZ1Wapwosie/QCi+adi3sMgr9P5so
 0oBeVaYyvHMK3iLMxhccNzRhMJ+Z/l61RThmQfzBmXBPb1hgJM/pxBrlHtdlIfceUcDbjMgRdDU
 c9s/aPW5KIACE1lm2S2k0i1MWEqFZ36+B6JMigrr2fw+eQfiDIB7EWf3NwI5YmKrRjhxwTqY=
X-Gm-Gg: AYBFou2InspkQ6lQJxT7jNP/d6z8sIp6dqiswjsg8lDdC+12Xof/rKC48x5pHSVAA3H
 EwYBb5F193mNXjOqo7vcvEyh76A2JCUpN6TT9e3bD4Stmdw4i5f4uAtpMrH545sgRJz619oRz/x
 qNUUqDbPajGsWO7kxIFByy76YhpjWKnjelzHcraluPAZQbiTlPEzAH9rr6Ef2g6bCDwhfTKuJHA
 dRkDqWlf850PWUXdZtBo+Rw15oezpis1x3YgUkyEZL9znLvwqTP81hTdgJ6FQZc4W1sp7m5P9PH
 klXRLk11JrU9b0OY643nFkddd4vRrKrlDbP2X8yD/nsbEhsFjBLDScglPyd/wxF5LkdKmM16Av5
 6v4SYHRs0MdmP82jlraizaNMTcDY=
X-Received: by 2002:a05:6808:1452:b0:4b9:e6ab:d085 with SMTP id
 5614622812f47-4c3200d5179mr3580130b6e.37.1789141108343; 
 Fri, 11 Sep 2026 08:38:28 -0700 (PDT)
X-Received: by 2002:a05:6808:1452:b0:4b9:e6ab:d085 with SMTP id
 5614622812f47-4c3200d5179mr3580066b6e.37.1789141107848; 
 Fri, 11 Sep 2026 08:38:27 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df90ff148sm1882160fac.14.2026.09.11.08.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:38:26 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 21:06:40 +0530
Subject: [PATCH 09/17] phy: qcom: edp: Add Nord AUX channel and VCO divider
 configuration tables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-nord-drv-dt-v1-9-e25c073cf1b6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789141012; l=1610;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=BecAQlq3TaHMxBVo38m4lxEAqYxStsb1bM863V68CZw=;
 b=f1//ctHCbi4gWmftu37Crl+H2W96k9QXUGf1z4eqL0/hZ77TEn1HIzExaxlaKiarHv4/sqaZG
 seJoInzNAJpBtQqw4GdKwEPGZ10iN99MUzD/l9kF0WDuoqk6ABNPG9X
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-ORIG-GUID: 2gpL8Wwvzn6Z4_rmUjk5B_jazeTmNyhE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX7DN0wqSMFkaK
 +TMKhRvb869Uy2ioLcLpPbM7umuqTMQAF2C13DIDg5hycQ3L8bL/O/BOe8C0JZa86RPjuKAtY8M
 BEq73FyPL7hNzAQCeN3WVTCUKD6ofUQ=
X-Proofpoint-GUID: 2gpL8Wwvzn6Z4_rmUjk5B_jazeTmNyhE
X-Authority-Analysis: v=2.4 cv=DLoacCNb c=1 sm=1 tr=0 ts=6aa42075 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1Vbz-4btua6vGiN1ejwA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX7X3bU9J21XTL
 uEeg0usHatKvu6qoVQElPzrZtwYkMhEBeUE7S1rDNYUdjA/ry/sFItNfOduH68lg1mFF+Xp4hNN
 fAZCqA3ZzHvfLhP7miIgNOZXLfy8o2YP9Igioqh3T0txFGBCXMRxO6cOkl3EPI4bvneJjr+IDle
 oL+fwI1jxqvXaCH6W/8SUHLnQPyizlHiRLBoiKuTvVU7du/8JfKV1vc1SgXBj3okxvgAMnQHUpS
 x7tYXknVLIi4KtCA5CWDy/IBv0CrNua6sC+8NCijXDSFPzk9jWbWxNOiGxnYJbAUVIMyYPzfou0
 XainHGTqf2s/Ajwpqw+hxU8SZ/oZplaRX60zXl64+U8MbTeW4CavAmYa33UgX7cQNRkUvvJmJY1
 7zBNPe2RUdyIr/iwvTGaW83gOQyBwUxDqzRCsD6TV4OnICTKg03tpXBYYzydac8aFeFq9bv5DWU
 PXompnBPnX5A4HTV+TQ==
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

Nord requires different AUX channel and VCO divider settings compared
to existing SoCs.  Add edp_phy_aux_cfg_nord and edp_phy_vco_div_cfg_nord
with values sourced from HPG Tables 2-1-a and 2-1-b respectively.

Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 373f13b3d6d5..ee0d7f1a90fe 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -1508,6 +1508,25 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
+/*
+ * nord AUX config (eDP mode).
+ * From HPG Table 2-1-a: edp_phy_aux_bist.csv
+ * Index:  0     1     2     3     4     5     6     7     8     9    10    11    12
+ */
+static const u8 edp_phy_aux_cfg_nord[DP_AUX_CFG_SIZE] = {
+	0x00, 0x13, 0xa4, 0x00, 0x0a, 0x26, 0x0a, 0x03, 0x37, 0x03, 0x02, 0x02, 0x04,
+};
+
+/*
+ * nord VCO_DIV config for eDP mode.
+ * From HPG Table 2-1-b AUX Clock Settings (eDP mode) - Nominal/Turbo column.
+ * Indices: [0]=1620, [1]=2700, [2]=5400, [3]=8100
+ */
+static const u8 edp_phy_vco_div_cfg_nord[4] = {
+	0x00, 0x00, 0x02, 0x01,
+};
+
+
 static const struct of_device_id qcom_edp_phy_match_table[] = {
 	{ .compatible = "qcom,glymur-dp-phy", .data = &glymur_phy_cfg, },
 	{ .compatible = "qcom,sa8775p-edp-phy", .data = &sa8775p_dp_phy_cfg, },

-- 
2.34.1

