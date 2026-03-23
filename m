Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D09FC72C5
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE67810E494;
	Mon, 23 Mar 2026 22:56:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TvEsgamH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eaA+mdlP";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BACDE10E4EF
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 22:56:51 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqb0T2971877
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 22:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 omnRmyUQg5dIWgAiljjvcZxQHMNx7Y0vRQtYTvOpk/4=; b=TvEsgamHgDw38zJB
 hrRkgc6tquHZaQWijZjf3jQiRxOtZ9RO28qBGDQ3ZjNtgDXLz+cGbe2sfdarjJ2y
 E2pI7O5vT9m4XAZB7xu0ToQ+BaBVg047SK4bDGKi4yL+5+skDP6dEkPxPqmq103o
 Q49U7AiGKHft6rr5L2ltwrvhnf0BE1Rri4Okgt5w7UM59UamHRFIvhmcXWFRO/G2
 sat+Jq+cRUwokanmNkguXL1Z9dqcBwmBWOCTwHv4VrtE5FXPpWntjUpUgjDeprwg
 zth/NW/0THE1qFjBK2YzEOuXEpgtocpvKlDFPHqjri1+4RFCakWsXHgZy8fy5pny
 Vxun5w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31jc328s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 22:56:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5090e08dcfcso39331011cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 15:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774306610; x=1774911410;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=omnRmyUQg5dIWgAiljjvcZxQHMNx7Y0vRQtYTvOpk/4=;
 b=eaA+mdlPrWDrLmfW5a8srxjxjW5NG9j7G8RPCmPrkmgcyvU2CBuJRqQWF9cRdqWip/
 0/aezQ++ULuPqWdZf8a/jq/6U4x7RHiYDvgqK2eh/Ks/CPg0KDAQQiL4lNVKebW/BdB0
 tmen3yuw+9dS0x4mHVjv3MWGZe/t7NS5vxpikwPfYuYOQD11jQeZGqJWbisp6cBjt/7A
 9hWAv95SW59Nm8XxZR35uZAxjRF+JEuPA00lHbhqfIAPzpt8d2x02kh2Y3yva2qO6zrs
 So2vXlelJdUSCDM78M1W8KjhaEDPiKdSylzwPzkpjaXixAqAvziM6hcej0sN7VQ7cXsk
 Sl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774306610; x=1774911410;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=omnRmyUQg5dIWgAiljjvcZxQHMNx7Y0vRQtYTvOpk/4=;
 b=DbfwfYv91zh3I14OY2Pngj6LwRj99W6BHrsAKilE/sjK+r6GQQ+dC6UXCLxV7BE+Tp
 WaWb0Or4oa8JKashS5VpWQiqNxZRgJNeZbwyjOwx03WtQTX3A4eZlGIld9S9McSzLjjL
 j84TgJnaBOQFsglY7kEU7CeSq7cZz2LI3ZC134y7R0zjooqWcexhW1VyButjv01OKkDw
 yUUo+L6SINjaWvMPf1698obTCzxQYZJZ/m1cnLzhIgktQYhhE7kLxLvdlYvu6CMjJ0PW
 tKYwZOzVjhPqtJSapEcBF8uAlpHI4J1X3AcP7S5ilXB5BupN4nRr5UuUP0qIwJ891VAt
 yscQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+KpemgoEzYVHnnia+yjMxIEe0SE2iDeFfzM+ch2GRRSYOHmEfovZaEoMOI783CRvwJDFOCrwnMdQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzJ+9uP/+E3YD355yQACdyD2xEv4jmTB2iK8BQoL9t0aZd1QsC
 zA14JYDv23CFeTfdVuEXSWsPEeMMn39VFDClsAQpGGs1qhlE3OutJC47DtW/kouEq7DjqtvINDI
 qoC3VpkPAoXSLqMBX4Hb4ZllAII+3gZiSDUXjpAoJ8oODa4zSmhZ5dm8AjN9C9lkmrUDagDc=
X-Gm-Gg: ATEYQzxCBGl1QrwcGRmrc9YcYLItBxxxTB6+cSz6A5JZEFY5yb+SdGqEfhjwj194Cy7
 3b9VBT5LLzJkUYJ/PG5YoBDCPbbw+/Me6wpdr2F8UwPrLJUc5/KvYpSFfPKCZxTjKGPs5eUR16N
 mE8IVX4sXlklVVt68bKGF7bUYr3QKkGLnBNlst74uTimuZUZ0V6N4zSv4QVR2Pggw8m2i/6uFzY
 F412kIxVMejmUSxRFWqv2i8k1diHLJ+GHsDTawtlVbdoI/9MPp85yE/dUUNgSqenLvXRu/mJxfN
 7nrgNEGe0NlPA+1lOxliCihYIsKbD+ZVZw+Z5VFidyt2Btnzf6/TtRnF3+8uKFmVxfUHS/YDPdS
 KMDjkRQsLv6smr/Y7543FsngGXHO8sfJuYEsTCPF6gEmlfgbaPloFaEy15BquY2Q4QF1XiIr1Oi
 FOxhL4I3Ij0jTFaeC/E06+rIII6y9ed/iKZxY=
X-Received: by 2002:a05:622a:480f:b0:50b:3d9f:384e with SMTP id
 d75a77b69052e-50b3d9f3a40mr216687961cf.44.1774306610113; 
 Mon, 23 Mar 2026 15:56:50 -0700 (PDT)
X-Received: by 2002:a05:622a:480f:b0:50b:3d9f:384e with SMTP id
 d75a77b69052e-50b3d9f3a40mr216687601cf.44.1774306609661; 
 Mon, 23 Mar 2026 15:56:49 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2963fa304sm156489e87.27.2026.03.23.15.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 15:56:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 00:56:35 +0200
Subject: [PATCH v7 2/4] phy: qcom: apq8064-sata: extract UNI PLL register
 defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-fd-hdmi-phy-v7-2-b41dde8d83b8@oss.qualcomm.com>
References: <20260324-fd-hdmi-phy-v7-0-b41dde8d83b8@oss.qualcomm.com>
In-Reply-To: <20260324-fd-hdmi-phy-v7-0-b41dde8d83b8@oss.qualcomm.com>
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
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3165;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ouscQfS7cqU8c/8/Fh7An6AeO5MKx3nAag0yIE0xM6c=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+bBo2pJwa6LfvUzxd9IeFTd6NSv7/Nu2v0F0939LSztZ
 b+Xu//pZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBEFF9wMEw5syHQdV2j8wzx
 VnnJ/3f8FnnmJAYITdkl9/HRD9GIN0+C2pvkFH5W3u66XluleTRV3/+RQF2WSIlniPux4BusjwQ
 DmvbcDv6YeNzq2JNzqz/JfjJ3/3tNbnNMb3SU3oLzquf0hcq1TxgXf76+ZVuHfsk1Rkdn04qgzU
 l5h/Rb/X5+51Sa5sSRrhk/S8Dp793Zq7USIzc8V1h7pIxPfesPH0U5zSfeElGnot8+lRO/93Fdz
 1T7bVLiQmvY81RZu5jbjt6bE1Nu92br9Gqnud8M6/8X7PVk2aw89Xkj8+93Fnneuu//ZtRet8p/
 286VEco2qXdHd3bvf9NfDRza5i0b1x98NYnpsuwyg+AoAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=fKc0HJae c=1 sm=1 tr=0 ts=69c1c533 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=_xNQ4P_HJxdd5osA_owA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: thPHhezolvUU2BH_Ztoaho2ECOPSun9L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2OSBTYWx0ZWRfXzDzCUguIR4Z1
 35kOi8AC4JOS0P3LJkt9ZRLme1d0lT7RwUgqPCpNi6c3bBx9SOktk0WTTZ8FShWFSeBkEKWpsPS
 yeg/QfuM0xfFuY1eJ2EiQKcMwLbbQ4R3bcKowEftD435hP7EuYmH96RVtoUaDHRrRs+46CR2z8A
 3wufSJxMmdDursylHJXp41wry/XG5F7mV0Fq0ykrdeuZUgdF2pl+NUmdLTJRW6V1YCjbASNsSPH
 +LhAyBZturbjWw2Guk9sWHRmcdxnfu+Ln4BpktrLkaYtLgox89ekImeF0x8U8YXkzg2auZErjT/
 2IDAc4hJFNA7tRI0j+Dfmg5OoMB5JTVV9f5Pc55NFLe7wSqFcv8M827DlioejK57WXWTtSBUkDq
 spPBvcoXjv+PndceYaO8mmfQwX0Fdj4jQjzC8Sin9mLsRzwRXf17zUYQJb+S9LsKeo8H7kBabEt
 Rab6Q4OW7GsAhw9oBDg==
X-Proofpoint-ORIG-GUID: thPHhezolvUU2BH_Ztoaho2ECOPSun9L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230169
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

