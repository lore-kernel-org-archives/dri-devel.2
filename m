Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C09CD4F3E
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7815E10EFCC;
	Wed, 13 May 2026 18:14:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OGuYv31N";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W1/lP4PO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B434210EFC2
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:14:14 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DGAPNl2321233
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /zVPSIIUWKZIXl9Pgp6/Eie1lp8Tnk+2GrtmbNvXeno=; b=OGuYv31NAgMi70jX
 sb07jsqMpvjddqFhCaI9Lsi1KVHPbuyo0+LDz1E1EHLTOnAHNjd5I4c5lRv2rmCT
 SmspIkjRIcAmqDZlHVl13K8sF63vRDPXnAao2YmtSrvz57BR1FkWjo6tMLcewSfr
 v/5DP46+gKZhb26zBSNP/SHAzo/DZM/vGr3OzA52gm1OBUHWVCfuRpjfVYZDqCMS
 LeRuHfRdDVcyMlFksMhlWB0G/hVX/9BEBxaxlYVSYtzsbmPeuMB5XKiP27UT/M57
 mB6xoHXYYWchvzNn3w5/zwyEFZ6vFvhBIlFrUUhUrpzCgdf41pqlsz+a7kFGZJu3
 V2Af6g==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hgubbgg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:14:13 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6326fc1256aso6127862137.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778696053; x=1779300853;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/zVPSIIUWKZIXl9Pgp6/Eie1lp8Tnk+2GrtmbNvXeno=;
 b=W1/lP4POZ9aHrH3E5NqL4InZN/3ET+B8uB/p38Ubq0IucWFlkef5sW6fFno56d5MxK
 LIIcRMI+8NrtBxOm3EvxPOEUabYhCZZ8N5c7cRyboHARo/d9YYwlCuFJsQccsN9jTbiu
 Fhn5FtkWmmyMCGeRagawYUx9LOpELkIH/+1vBnd1gq3nDJN1BAtWTJNS88vnUO5nZr8j
 iEyTGMRE8BR7cq+E6TiDQGh17PlSktHK0CCIOibHVW7kf5BnH+L4E8RkUPZ1vnAai28O
 N0J19GumNgzcv6JkLz7F3xH3w211i5JoCJ1BQJYfTKtJB8LE6cc9TQKV37wLaazVUV7i
 0eVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778696053; x=1779300853;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/zVPSIIUWKZIXl9Pgp6/Eie1lp8Tnk+2GrtmbNvXeno=;
 b=BPOi0a5F+s2NMPBb2maGsKgC50FKHjtsVYOl4nre9Q6fK6xa3gx+fRC5VSpC77EwXH
 eMMEri30nT0Eh+aJfAtwxdK60UMY+bIBsZfy5kFpUp5KcyhtAZWF8aOwL1E9KHak17/I
 ko5VSxyCwJc5qe6chkiRvWj8JjnH1rq5OYC/mU+MJkv5DqijN7Wah/n66yNR0h0ORmJ9
 SQttqQh2oMLXHElz7eirYmtn/G2dNgLqGUNFr+i9iTi6rJolPW+pyzpE+FFds/DcYiTV
 9STqWn8Ao5NoZEvNuCWiGsSat1ylEuinBKi7pKhUg90wOPMAUWcJYYCn1MN5GvoeT4qN
 bsug==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+L4kF3KXVch5QXpZtW2z+U/IkGdv2n2DZG+2JS2CBtE7Xpr5MKw2Z2cvgy+mwMEzHTwErpqGEbqk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwB1iLYwH3aAJWvjchnc3E1Xo0hEE2taudVp33E6zNh+5oUwf1S
 L6lejLLXUlhHLcICFiqptqsIUXHTx3xHvtadvJI2ezwrqCczbNrt6J+/Ylb9e8Cgx3LC8eSiWlM
 KDiTHNvOUERo2fo4QRx7peUUMLNSG/KzCHiOXphagjHwV5qJlsMxUUco8jBSlz6rcnMCB0fs=
X-Gm-Gg: Acq92OGhLanB76MXtb7BJyGlfixWjSiDelubvM7VJOyxUoNzbyyfxnsosVVHfHGmceq
 JqMfXY6b1IntCjVT8MGkh3EsiFXJgQafQxTh5BAGRAbKPYuAPwohZoPEV8NXf27KDnFMRK9du3+
 dICdMFKpBC6qyvmeucVBd0rW8OUhe8cpJyfgcm3jczjt5LLOh4LV0iTTWYI8b0T8o8xjtXeM7dL
 2JLDD7bvuNsGfbVqqIiK2A1BTyKnZQO6UD/PvOnJkn62eIhinF7M0af0MZJ+XeqOTI5itDzU0hl
 xIBqh6GdSER5Z8VMosGDoVRIMHIlNdT2/8UIGZSCfzjsk6euB9DXOFGXNQlNYn0jc7sQ4vX7jqu
 w8K88MtKr1Jk3xqNlASEuCSveN9oBSu+NCQagttMs/O6xraBb3XNo9BdZM4sYc1VuED7Pm5LbZv
 6Mw/NN9giTV9gooTgoaGk7SJpxa1l+8R2T7aE=
X-Received: by 2002:a05:6102:3581:b0:631:4e9a:ba3 with SMTP id
 ada2fe7eead31-63775d35309mr2383186137.21.1778696052941; 
 Wed, 13 May 2026 11:14:12 -0700 (PDT)
X-Received: by 2002:a05:6102:3581:b0:631:4e9a:ba3 with SMTP id
 ada2fe7eead31-63775d35309mr2383166137.21.1778696052465; 
 Wed, 13 May 2026 11:14:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8bd7d8974sm3174770e87.64.2026.05.13.11.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 11:14:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 13 May 2026 21:14:06 +0300
Subject: [PATCH v9 3/5] phy: qcom: apq8064-sata: extract UNI PLL register
 defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-fd-hdmi-phy-v9-3-ca98c72f1f9f@oss.qualcomm.com>
References: <20260513-fd-hdmi-phy-v9-0-ca98c72f1f9f@oss.qualcomm.com>
In-Reply-To: <20260513-fd-hdmi-phy-v9-0-ca98c72f1f9f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3408;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=HsnaYsV5sY0OkAw5eu/o4daj/nHtfAshF8JWidON18Q=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqBL9tjLrY83UXLmEunVYGYLAM+Hg0YNzJYpfrq
 96k9e4FlDeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCagS/bQAKCRCLPIo+Aiko
 1VZzB/9B2E/N1NfXzdEpQOpWpJYaqJ4JY4cFaruTvIQuvIIOydYHm/rnl4TPJ+Dzk0xu/XU3C4h
 kgKr8ffT+PaJ2nzpHU8ccDCD+GVLpY1N6+UhPNRcLQ0DLgSG/9kMZXe1G80EGO4+gAOjaMEhP3I
 Zo1w635FY2rocR/XSEOL26z9fv68ZtKLRKQQ2QBfwqnQbGO7y/mtKRsECKPdiSF7kJLXBfQi1lU
 yCz5JUFTY+s6XL/VHZUk5S+4CZ9VD6kqhjXKFwWNBXmjORys4v87YpGQxsPceXilHESDLF9BdMP
 ob7h0vrDH5CXPlsNO5fzEnWbqwbpnUn8u90DPvj5SzPxgdxQ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a04bf75 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=_xNQ4P_HJxdd5osA_owA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ZgDzbazkzvWZ0weZp_N8Wy_16IxvsR_z
X-Proofpoint-ORIG-GUID: ZgDzbazkzvWZ0weZp_N8Wy_16IxvsR_z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4MiBTYWx0ZWRfX+XsYm1rwPsDO
 KrFOVwFoax678zfNG6d3J3QPItxZ+6cU6vWQoqItPyNuJZqI3GMKrZveWsnPC6gteRs+VpkqBhg
 9ZHlyH3+L3kHUT1Xa0AuKCgLt1F3AWLoZxqjiV+uS8p4i6gSMVBMrOJgePNiMdCbRfhp4UIHlkf
 2obyBWklgSFadHGbQTyhu8OCtu7VRZno0giUpGWe9UZJwBciRHGoyKy/TEvtmnHLM/lYnb4pbuY
 +C/eP4DsU+3jna90258LJDQcjAAsLl/cWQPvQ+GDfoWUPO9Ay0QAdG2/37PLB9wPfSbiPMpf7Oc
 zJeT1Veb16RE0SPpkMBZMAzz61GTkOulmxAkpUfBV8GZ/1qrdT/0AxOHcELVwlFIbwpDFcO9O3s
 begZBj8dTpV35/FORLv+VEx2IFk58mU81vVlPKJRrhv1nWamgOVWrrAu0mkM4p24WvvVXd5G7fF
 X6a9tUmciCqXniNCpyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130182
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
 drivers/phy/qualcomm/phy-qcom-apq8064-sata.c | 24 +-------------------
 drivers/phy/qualcomm/phy-qcom-uniphy.h       | 33 ++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-apq8064-sata.c b/drivers/phy/qualcomm/phy-qcom-apq8064-sata.c
index cae290a6e19f..52f180e0cfb4 100644
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
@@ -58,7 +37,6 @@
 #define SATA_PHY_TX_IMCAL_STAT		0x1E4
 #define SATA_PHY_RX_IMCAL_STAT		0x1E8
 
-#define UNIPHY_PLL_LOCK		BIT(0)
 #define SATA_PHY_TX_CAL		BIT(0)
 #define SATA_PHY_RX_CAL		BIT(0)
 
diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy.h b/drivers/phy/qualcomm/phy-qcom-uniphy.h
new file mode 100644
index 000000000000..5f18f9593cda
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-uniphy.h
@@ -0,0 +1,33 @@
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
+#define UNIPHY_PLL_LOCK				BIT(0)
+
+#endif

-- 
2.47.3

