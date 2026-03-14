Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE3DFD88ED
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 05:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80CBC10E0DF;
	Sat, 14 Mar 2026 05:06:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lQZjx5vx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ds33+cZ7";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE9B510E0DC
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 05:06:41 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62E3fxBa2919969
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 05:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8AwSPheloTpUNoYn+5istaBSV5cxl2twt/OKxdGnStw=; b=lQZjx5vxbYVo39sE
 onPIbuvqFzbOqPXIoeXfPDeYECu9wpVTh4xxCTsf8qWcfX4Whyo+xnkiW1w0LGwk
 wASaA+DtyVWs5P1wG1/7O3Fq+1F3bXVgu80r9X6ael1P/CFLjbYZ+FZig8thtMUF
 iW4DhUbw+XYoZda0cZMkFlujPNWnuCO95+A/oCEyisTFdqy5tPt0MWdmCwg9WpLE
 M9XryWuabgUlANBQXWJzYZyjRK6Nj128lzcAyLugC0hX2c0VW/dRU7Wo+sPa4dCG
 z7VW7d/9/xMjq7COZ8lcLEMnTDsjNA0gELleRbhzv+wLfivdANSo62uG9eeUaTrr
 m958pQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw00b84a9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 05:06:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cd722c1a69so1696817185a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 22:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773464800; x=1774069600;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8AwSPheloTpUNoYn+5istaBSV5cxl2twt/OKxdGnStw=;
 b=ds33+cZ7SoX5Gn1I9idk10Kor9GEVZ2aqkKnXlo4IgzP2Snqq5F/76E0+gtiSMRIpA
 WGdl+UhBYZ5JzCLGdqRlwgoT36NwlkRPGuEmN7TE7oLmwz+MrKrtaFpjSrcVVZPjLolM
 4qy79py0GSrXIK2nUnH1P2D70md+bX3Uxbs3XJ4kRmVL+hyhfF95jnwHuqRK3lnVoo58
 8dt5D2b14F0tLl9rP87Y4vCvGLu5DTO7Jo1hfZq4LTJT1USTMK24F/tI83Nb3nG5P8uQ
 ETeAEVxRmHxfHMj6w2hMXbvywz0FFfoiaUVJlhfzwN3tT/TH493k+lKSe9954+Shybcq
 X6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773464800; x=1774069600;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8AwSPheloTpUNoYn+5istaBSV5cxl2twt/OKxdGnStw=;
 b=K2sxUkbyrlugZek/kc5sjZg0K2cuGA0xayyj1LwfCkbivY3agnLQWgHKeFPNjospJ+
 kaRsep8B0BaOCMACtbCE/jOXlEn8whxlkEb4WMDdxLHI6NU46KzxMi2D6+dWvn+QBnvl
 H31zIbk6kn2idsutCmJLSspB6QtZXUh3WR3tTQXRQVEQgff1p3UR/BzmGbLdP4NgBeGt
 q64q0qAQBAHGMtTgEnG371pnB+kmQsUkhwqQWmtMW6NyslSfFxpNJ6MTnJbfXYjD+2ad
 /TbZYC23SvARylX/Fm4VD7/RPUhMhRNzSFiFMNPo6EPlEJ7dpZYrtu6xf9vDAwwvpp0a
 RYRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8NMwUnPlkBKmCsF+LUXIVEPI62MY0QO2xdO/NgRgENYBWXKZ998Tst+EbtM5EEdg3jOB2KIeFTso=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyS48F/GxgDNQipinemZeKPS3YEXMxGDBVAaNJjfFPHLD4JYYwe
 76en/p7hSHJPtfrYOe67de8tcjf55UPX2p9j691GnRJvvZ7LGXU0mpWMKxIYddUaghxHBhFXYnq
 RAyx44LuRr+tUsjafxr0UcpZsrSjsLM9J0IT/TQyer99WR3f5kz8/jlTj4zVUHql0J4Ek7MM=
X-Gm-Gg: ATEYQzyoOtzp8lvstpxcNejJQoevbgAFd/tCAtSlIz4+ybpy2UGRnlRDcrJwMX7yHU1
 x4QJkTx7aWFWAM+vxjKiII1H4Z/Yk62ZR9iSPyZUjbdvv84K7AJzdxyWjFmsTR/vqaAxSyW0xlt
 ThxM3pMvPsRft0w58I4GV/JXS+ea6qSOqMKZD0lTt5ZUg13aW6YuNuE6578wqwFQlqdsx3yoQmQ
 ums+ZYOR/H5RF8UmoV2aAN5Ed4fkeVMBkt5UF83zVD7vrm189zserzGqcS0Dw0vxgjIF463PApW
 +gCZD6mXF59T3v5e3bspZMvl9tCoxOaakmU1AwFC+0joh2b3WokYUhDhfWce/cMFHOrd4E2dqTc
 74lz9+IIuWWfE2ee4pRUYF1oDNhO2lsNCAYVAqYk8Ep2S9RvtV8yc2mjV+t2jk8ZF9cCJMWQOmU
 pZ+mo8TNgjPG96i5woQyB2Mp4NuEZUcxn75fg=
X-Received: by 2002:a05:620a:28c7:b0:8cb:3e86:d98b with SMTP id
 af79cd13be357-8cdb5b7cfe1mr760120385a.70.1773464800203; 
 Fri, 13 Mar 2026 22:06:40 -0700 (PDT)
X-Received: by 2002:a05:620a:28c7:b0:8cb:3e86:d98b with SMTP id
 af79cd13be357-8cdb5b7cfe1mr760117985a.70.1773464799747; 
 Fri, 13 Mar 2026 22:06:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a15636206bsm1982771e87.67.2026.03.13.22.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 22:06:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 14 Mar 2026 07:06:20 +0200
Subject: [PATCH v5 2/4] phy: qcom: apq8064-sata: extract UNI PLL register
 defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-fd-hdmi-phy-v5-2-58122ae96d3b@oss.qualcomm.com>
References: <20260314-fd-hdmi-phy-v5-0-58122ae96d3b@oss.qualcomm.com>
In-Reply-To: <20260314-fd-hdmi-phy-v5-0-58122ae96d3b@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-phy@lists.infradead.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3033;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/2opfqPS0Z1wOkjLcsVaxdSxpYtXDoOpRdO9yoyCyhk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBptOzV9dQ3IRR3dl2CePfQ3h2lOGFzcWFc5DwB/
 QC8aeToTeeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabTs1QAKCRCLPIo+Aiko
 1Rf2B/9IsNKOTt8CRhTBF2S1R2VxM1pu6ZXCj0A+LmADjJAZE8h8Ojxm566dhtlDA5iZ1tOyqD7
 S12ow6wqPrWtMM1Tc0/3t/YLscu3+YDuH5WvSPBfasreNVQjR2JYnREgN4YPioqAiZrWilkb2Yj
 oQYCDofTswSf0a+FHmRqKJg+AxJXpOcCyWJ9UTYJs6T6mhySlmBI0t5WcYyWBRu/mPxEB0py4jK
 9SpgR0GbWShMKaNfZ/FLcWfmmzRjeOO414ZnaDzODPK88kWOid6acA1TrdCJ6bLvsd/n8Y9WNgh
 qoiXAzxiNIuWKxUPu+do1DXWuIp1057kJvHKL2UaJf660A5V
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=IsATsb/g c=1 sm=1 tr=0 ts=69b4ece0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=_xNQ4P_HJxdd5osA_owA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAzNyBTYWx0ZWRfX0Fw0s+MWZG8G
 zbAPnnY/wU5y8SOGTL0HcgV+Zp9pnxWOEUVkJGO59P6kMndyeYYtctCQU0EKsYPLBwR7myo5ocA
 4A0x1QB/Er38QvuXSBdUYthHfwo35fg/Ua9xVpl0+BXGtyIbnf0RlnwUMugo1Qc8MRTGwFvU+0y
 NreTtSFR1EIHcH5fAn9N1GsnNfv0hwfRvkUSsX4nUrT/TOhGRFZTjwecjD1bkNfyLHUOEQzRW8j
 lPMAy7Dyjs049QVjNIEqD/Ik06oRT2yDT4nGFgE7aoBm5U43Ekd07Pu7E6KnEtB/oA7xOFQ18SE
 cpkFxURS1X3lI+kOYs/bc3516B9eERaY3zB1sNBOeBLkICI76X/V2RJNJ+Qj6RYyldnURMPkWT5
 PGVwgGFXjFaiN3prvyHrWy983krnrofSF3zR33N5zF/O3mBBzrvY/xBQLRLZEx9kmx3JiNbvPGO
 ADI54nA0JAH9zaCxTuQ==
X-Proofpoint-GUID: fuhGHgTcZ_2wgJaN7lI4z39N_2mt85IY
X-Proofpoint-ORIG-GUID: fuhGHgTcZ_2wgJaN7lI4z39N_2mt85IY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140037
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

The "uni" PLL is shared between several PHYS: APQ8064's SATA,
MSM8974/APQ8084 HDMI, MSM8916 DSI, MSM8974/APQ8084 DSI.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-apq8064-sata.c | 23 +-------------------
 drivers/phy/qualcomm/phy-qcom-uniphy.h       | 32 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-apq8064-sata.c b/drivers/phy/qualcomm/phy-qcom-apq8064-sata.c
index cae290a6e19f..dd9929429f9a 100644
--- a/drivers/phy/qualcomm/phy-qcom-apq8064-sata.c
+++ b/drivers/phy/qualcomm/phy-qcom-apq8064-sata.c
@@ -15,28 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
 
-/* PHY registers */
-#define UNIPHY_PLL_REFCLK_CFG		0x000
-#define UNIPHY_PLL_PWRGEN_CFG		0x014
-#define UNIPHY_PLL_GLB_CFG		0x020
-#define UNIPHY_PLL_SDM_CFG0		0x038
-#define UNIPHY_PLL_SDM_CFG1		0x03C
-#define UNIPHY_PLL_SDM_CFG2		0x040
-#define UNIPHY_PLL_SDM_CFG3		0x044
-#define UNIPHY_PLL_SDM_CFG4		0x048
-#define UNIPHY_PLL_SSC_CFG0		0x04C
-#define UNIPHY_PLL_SSC_CFG1		0x050
-#define UNIPHY_PLL_SSC_CFG2		0x054
-#define UNIPHY_PLL_SSC_CFG3		0x058
-#define UNIPHY_PLL_LKDET_CFG0		0x05C
-#define UNIPHY_PLL_LKDET_CFG1		0x060
-#define UNIPHY_PLL_LKDET_CFG2		0x064
-#define UNIPHY_PLL_CAL_CFG0		0x06C
-#define UNIPHY_PLL_CAL_CFG8		0x08C
-#define UNIPHY_PLL_CAL_CFG9		0x090
-#define UNIPHY_PLL_CAL_CFG10		0x094
-#define UNIPHY_PLL_CAL_CFG11		0x098
-#define UNIPHY_PLL_STATUS		0x0C0
+#include "phy-qcom-uniphy.h"
 
 #define SATA_PHY_SER_CTRL		0x100
 #define SATA_PHY_TX_DRIV_CTRL0		0x104
diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy.h b/drivers/phy/qualcomm/phy-qcom-uniphy.h
new file mode 100644
index 000000000000..e5b79a4dc270
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-uniphy.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef PHY_QCOM_UNIPHY_H
+#define PHY_QCOM_UNIPHY_H
+
+/* PHY registers */
+#define UNIPHY_PLL_REFCLK_CFG		0x000
+#define UNIPHY_PLL_PWRGEN_CFG		0x014
+#define UNIPHY_PLL_GLB_CFG		0x020
+#define UNIPHY_PLL_SDM_CFG0		0x038
+#define UNIPHY_PLL_SDM_CFG1		0x03c
+#define UNIPHY_PLL_SDM_CFG2		0x040
+#define UNIPHY_PLL_SDM_CFG3		0x044
+#define UNIPHY_PLL_SDM_CFG4		0x048
+#define UNIPHY_PLL_SSC_CFG0		0x04c
+#define UNIPHY_PLL_SSC_CFG1		0x050
+#define UNIPHY_PLL_SSC_CFG2		0x054
+#define UNIPHY_PLL_SSC_CFG3		0x058
+#define UNIPHY_PLL_LKDET_CFG0		0x05c
+#define UNIPHY_PLL_LKDET_CFG1		0x060
+#define UNIPHY_PLL_LKDET_CFG2		0x064
+#define UNIPHY_PLL_CAL_CFG0		0x06c
+#define UNIPHY_PLL_CAL_CFG8		0x08c
+#define UNIPHY_PLL_CAL_CFG9		0x090
+#define UNIPHY_PLL_CAL_CFG10		0x094
+#define UNIPHY_PLL_CAL_CFG11		0x098
+#define UNIPHY_PLL_STATUS		0x0c0
+
+#endif

-- 
2.47.3

