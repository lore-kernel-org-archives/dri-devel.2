Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7DC10F931D
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 03:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B908E10EC22;
	Wed,  1 Apr 2026 03:39:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pElYl/Hc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E57iMfsO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBCCE10EC1B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 03:39:05 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63105JSt1831888
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 03:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 omnRmyUQg5dIWgAiljjvcZxQHMNx7Y0vRQtYTvOpk/4=; b=pElYl/Hc3H1CCT8y
 mZ3LDc/acK820bG1wLb5+OAoRCygFovt+Nrpq5KmiMEGut/832L16uQDnOgYfut0
 HpYS8Rk8+bpSAMWdtTXRU0s33DiBdWlGFPgMwnL0ima3tyL+yUyxATRlxHAIz/iT
 7NNVtS7YEvoFfwmB5YTKDVHIdpxX0pdT1rPy0nlY5uFMf7kNJ8qWRk8CC0WQclrC
 V9RkLm8IUi5AD/vvwRcRmJoSLvuRtD22h7Yppc6B+a5woapNNrmISwth1KcfytXm
 drx9/E7eGX5Wcmm/JkjclzSxGt0rUbyRa86uhdPUulikphdiMFt/q3wFqfoXxNaU
 weofqg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8equbpf0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 03:39:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b323c43fdso55728311cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 20:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775014744; x=1775619544;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=omnRmyUQg5dIWgAiljjvcZxQHMNx7Y0vRQtYTvOpk/4=;
 b=E57iMfsOwY7iheNd3CUOvJX94fwrmDbmCanrNw2lpx5y3Z2caSf2McATqsu5CBLXNH
 56qMxbjy8BWCgxCc0ridCO7ZgCg657HVKamRsb/12TyBBsKMf7JalWJ2iEYtJQZ5WuiV
 fvJi0aDqQ1xYlCTfjHcVdkxMLl1khDGS9nXfPq3quMIoUyv/PfWa/EId4UNqnw5r37Ke
 6g3pef95CyoFsJD0ZLQKZ4MekOPRHVYUnnUU5jI0vibVq4yFMMd8R/lhlRklmVQYDdng
 BQ+RUCGaLXZncAXck1ZTnqxNHVeU7p92xcnftEyxyRGH33ipZ4e+/MSZhlflMSwKrrmJ
 o6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775014744; x=1775619544;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=omnRmyUQg5dIWgAiljjvcZxQHMNx7Y0vRQtYTvOpk/4=;
 b=G3SGuw5fKPhp+x57PrZs+I955mX8wzHuMwmo9P1o5bXTWSvFP3aROKCIahLg6v7Fph
 UFS7JtAbpcsJ5Mm01iMqSHwJ8RxPHdQrMjSu/43+mwB7IqFiSioxlOn39mtEyom7fh3Q
 K5+FukXh7SSraLLfb7UFE+fli2cGzTlyhp+q/bndlSMUlE8rdv9XpqncJ+Vs9pH5YPlf
 i0lId1GvTKZc3DY/uZ1+eQgjbAFWtUgauSDzV25j1av8KsDs97AlFX5ahz1tvInEUBle
 iiIuJuaKhNAJTlZxoNmgmhXUpwmvsei5DK/rfDpEvWlxeLh7ZbR0u1enT43jRYELFjQF
 +AJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi2apR6i6ygvM6TA8+2ACR4JcIDUOJ3eaakzvRUegQbaulWooQTacR9Y0HuZl9DsunhZa1De3LbOE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyjsymY9UqWkOnBeqKcDPaH7yKioO7ryiHjVzqGlFtiA5cY7UUl
 uEM3d72AW8jV/IBdvwR9BnxtPpyyI7dJKE2BGNLEr9yK8yQckXONb7hFIcRmoKoyRxu9Y+fEU8R
 wWtHqUjK1vpmiSfX3qC50UwpoUHpJsv52+a3+4Cxfp/rJpeTPlRPJ2lbtwcu73eibMUFD+hc=
X-Gm-Gg: ATEYQzwhfmGuBy6tJiI4IXWMV5erKy0TiH7+5WQsMY/UqVQOHdB6KzOkVVP9IPZpC4e
 rFErEZ0APaLSqlghSLHqo8mO5LuLVf6SnEHbKT5lIGrBBcfCi+bPVta5elNat3pGoFLml390cv6
 iG77dpXJIfayMilC1fjCivhkd+cFMO4tCjrLDoxEYmjl40OfZVVJ1scRYYQ/9/TS/OTF7Sdnz/d
 ZNGo3nUyUNXevzfBX4aSfm7/aSPzE0d3oWJMSyROE4NtCMXXHqMk82hoLRg1acuRMjIdzyvYimh
 fnhQdgnf5VzPoH9F6ZB1bxrpSxair7Z/ClnOHd0ZjImYDILnt5wCnLY2IwEasJgZQQatVbWrmkl
 JpLewjWubP8U9lTRxgqjcGFPWSWQtdybXspfCwn0ffLwYxiOyBkRbTjOpsAN3+bLDCJ/aq68wfw
 SP7ktq+lnFvX3kFEgqSwEa2Fz1uOIsPJcmfUQ=
X-Received: by 2002:a05:622a:208:b0:50b:3e64:9b2a with SMTP id
 d75a77b69052e-50d3bbba0e5mr30945591cf.20.1775014744006; 
 Tue, 31 Mar 2026 20:39:04 -0700 (PDT)
X-Received: by 2002:a05:622a:208:b0:50b:3e64:9b2a with SMTP id
 d75a77b69052e-50d3bbba0e5mr30945391cf.20.1775014743505; 
 Tue, 31 Mar 2026 20:39:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c83730f7csm24404851fa.16.2026.03.31.20.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 20:39:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 01 Apr 2026 06:38:47 +0300
Subject: [PATCH v8 2/4] phy: qcom: apq8064-sata: extract UNI PLL register
 defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-fd-hdmi-phy-v8-2-51b0e98edf6c@oss.qualcomm.com>
References: <20260401-fd-hdmi-phy-v8-0-51b0e98edf6c@oss.qualcomm.com>
In-Reply-To: <20260401-fd-hdmi-phy-v8-0-51b0e98edf6c@oss.qualcomm.com>
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
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3165;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ouscQfS7cqU8c/8/Fh7An6AeO5MKx3nAag0yIE0xM6c=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpzJNLmOEeHDlMQsEi8WfV2M/FU+7jv6unYshVp
 BRBShnAhbeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacyTSwAKCRCLPIo+Aiko
 1WXBB/0YQwCQumGtJGpmrCgUNvTNsMRnD8+VpK4wTT4nxIRaWiJmMASu4yQFBjrJLDlFTRmeM1E
 FmF19X7t3V+1yLDgx4SQ8pBLXFRTzph7z1R7CUgKDizPxyowFBwNBpMivdXhuYCQgidC/ykiA8W
 PGyqv9YPnSwC5MCSij2RAADe8Z+jWFXLNJH7YsADl5ukdE1+QYZbPo+8i/XKWTPROuM8HYf1vyl
 iKla8x0FpYpg28/JCXnoOktQwMggiYPTk4tU/GU0ewQ2YTpBQ9uSU+ztMJkXGrqaQeTIEL/k+EE
 4k+DNJmwRkT5lpkiDn+3qHtlJ13eDT8Pi5ZGsGCTSqsIw52O
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDAyNiBTYWx0ZWRfX2cEjGR6RJuae
 vtz2L0XdngAQ0xYL48mdCHl/LvAMgeq8ELkW4iyyCb10CwF/qIfy3CoAPUkxB385sMQj6S2BCcu
 pI6khbeKrxPKwGAGISjxvPeixQwS3/peBWdkoymDQgPLEV2i0NDGOC2scGVpBwW6eTCrHBTttYO
 t76ZJFIP2hwoFpI31rsLfpwbJtOM0eRgnLRe6v2mB5BRyTGKIs4zvAr4nnwy5cUu6NIbIbNjMkz
 J1hqplv2UeW4CF3mcXIDG3ZgpskdCsxMq96CqQal00OaXvV8Xb2iOEjADlD4k19l16FlEziUlqk
 NH4aIYqt1n1jj3F1fn7JLPkq3+cbG4qceO/EGpqhmKAnjryxkt6b3vq7cKvAk8Bqj5jo/zQCcv1
 b7MNEZoagc2P28JV2GSFzCeolTyD7atnsTr59lq7VIDPUgJ5ZxME5KDGTg5IebR9uTPCbMSyjWl
 0Es5WXX/zmGYhKKSyKg==
X-Proofpoint-GUID: qYbbXVf12tvdPRDfqlGzdoT_EY9jD-nk
X-Proofpoint-ORIG-GUID: qYbbXVf12tvdPRDfqlGzdoT_EY9jD-nk
X-Authority-Analysis: v=2.4 cv=YMOSCBGx c=1 sm=1 tr=0 ts=69cc9359 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=_xNQ4P_HJxdd5osA_owA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_01,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010026
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
MSM8974/APQ8084 HDMI, MSM8916 DSI, MSM8974/APQ8084 DSI. Extract the
common register names to a separate header with the hope of later having
the common code to handle PLL in those PHYs.

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

