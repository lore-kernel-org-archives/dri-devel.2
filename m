Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AED1088E73
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 03:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E991210E874;
	Thu, 19 Mar 2026 03:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BNmEnLY3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OJ+NWrVH";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EED110E874
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 03:48:30 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62IHPXUR3228150
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 03:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 omnRmyUQg5dIWgAiljjvcZxQHMNx7Y0vRQtYTvOpk/4=; b=BNmEnLY3GIBW4LUT
 qu7tTWdpaA1C/APSaGUKAz+99326cWQmMl63Nkjoupy9RRLWLLxnt0VvJKl+KtuB
 wSf+JYQbVGP/GX2KcVErAKZwIwHIz9EQe1dZZpOGu3dH/Gj3YYRtZJUgFIDaFaO2
 c3SbYGgVPRVUcYLR8+x2OgLp/9R29qLns1DDPtITSKshhDXY2fDHaHYPFAN4ym7v
 te3Ep1oUq2oI7R1g2pBKdtA2NJJXAYyY9BDmEU/bemWLsS9yQ24Vq5G/GFJ+hREe
 LF7ykL2InouxOGjum33qwzq2o+skhyJ+w6a/HdawNCqe8MA86abHBE3xC2YiCVzA
 4ZFXdQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d00eg9n63-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 03:48:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50937cf66b5so71729711cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 20:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773892109; x=1774496909;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=omnRmyUQg5dIWgAiljjvcZxQHMNx7Y0vRQtYTvOpk/4=;
 b=OJ+NWrVHAIhEaMFLn2j+UTuNOzEoxUjphy4AJlbHnMZqWK+mX4VRK0sxRuYdFUDJeX
 9AQZ3RDakALsSnfRUv6BGkUBHkLG6SUjaqm32ZZjeoVjfvz1KNIl5Q2vvTfnQZyFHaLf
 XVBSMzMViBdWpZHKGjp7CRVgtz5eRl3VfAp9XRCFEOvmwO6XuwYaMWJE3tfhIwp9+UDa
 xPSel0JrQURts0sLwu2Y1CW2Q5b1LP8swFRdBz8Ctd3pjDnqZywon3MbGGsdfWjcENvo
 DbtD/c5xvzKia56w+n7o8RMrLeT2VTL/GpuyawZkrMp2e9m+MeB9hJbTOnqosXmwt+1Q
 lL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773892109; x=1774496909;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=omnRmyUQg5dIWgAiljjvcZxQHMNx7Y0vRQtYTvOpk/4=;
 b=GfGGDjRAkXqI06tykw20RwzMVmqFFtR+8gdgNjNTmvorkLwuhrz6bs4HKoIWJv026k
 8Jk1OPMIsg30MMxVr83Ou1OvVeJdB/dvlqo3uBu7KRwif5dr/PqGZh9Cnsg5nvxn0C7Y
 E9ZOjbplvnGshSUzPdA1DX3pSA9+X6iOJwszFe6rr9OH5SEwNX5NtTpVLmOXl8qQVtZo
 37kCBctWZXD1KHVgBxyqhmRrd0Lmo6aMm99xztlXS3HCvm91dP38YeZotBLV6DLo3JXj
 Qig/CEaU8BOfpIqy/pWcDUXpgBA/SO6LQmghDbZFV+yTkATvqmjXY0dbEjB/JkhUx2G9
 XI+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKfIpKGH3DZ6/fDVGxp76JKVCIDcFNHPZ16A9VZlgFFV/oFk5kSWmNidFE6TBwCYB1v2wvkzgMxlk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywctr49Z2BsjQ6kbK6CqGp0g2yAUkLRG5M7T+5GC0oZQRIbM+49
 Ff9ENczi5Rv1S/+ltAEJED+TU4to54HIJN7ke/fgjmXAWtHq1llignM5iuV9WGQIxpRm9mY1cZf
 P30xxJWxvPjVxWOHGDcig4PYkO2Rtd8pgL/WVXVbcTgCV5MomvHyjF3HKaPi4LZlphgXToTA=
X-Gm-Gg: ATEYQzyiquGsFWYdNGYFbu5EocZgchbkD+1gfEIVX7x2W7HPghdiJUxMP/Pv08nPuLV
 9zCjBO2dlQfd0SvS138j3BvW097zg2wDJwSRzmVfx+IqspiHsP6DdUkxyFy74y6AZ0DsvNxJy/p
 8xtDHfGww4qCvXkzo8mOC8cOIF14VrWhegr8n8jJ0zaQ48hgKQmfczMPHVFjzNPGciC/UQmQedY
 R49rId6Nbo8QGFu+sfFgun6511XIzlrlGobMBs2+DA+8LX92UdxKLZsEsu2W0IeyJIBSKeu15fM
 JUgUunrNDQgBWOdWzM+Z/uWXeGEtu931JWmXFpmytSjIT2/LBivFukB6hQ5ndWlxLOGwa5GgXg9
 OlhJdn0ylxn5V6Y8lB3HpZC/8ovRCzTS6VVIYx5h8wcyGWez8CWeDOmEIbpfSLP8yleoV875u1F
 jH/zAZZJ11EEAxSiBZO0+MtB5wts/EHXG1ow4=
X-Received: by 2002:a05:622a:191f:b0:509:211e:3624 with SMTP id
 d75a77b69052e-50b147459a3mr71590321cf.4.1773892108975; 
 Wed, 18 Mar 2026 20:48:28 -0700 (PDT)
X-Received: by 2002:a05:622a:191f:b0:509:211e:3624 with SMTP id
 d75a77b69052e-50b147459a3mr71590081cf.4.1773892108505; 
 Wed, 18 Mar 2026 20:48:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a279c79442sm907649e87.70.2026.03.18.20.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 20:48:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 05:48:19 +0200
Subject: [PATCH v6 2/4] phy: qcom: apq8064-sata: extract UNI PLL register
 defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-fd-hdmi-phy-v6-2-cefc08a55470@oss.qualcomm.com>
References: <20260319-fd-hdmi-phy-v6-0-cefc08a55470@oss.qualcomm.com>
In-Reply-To: <20260319-fd-hdmi-phy-v6-0-cefc08a55470@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3165;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ouscQfS7cqU8c/8/Fh7An6AeO5MKx3nAag0yIE0xM6c=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpu3IDDi645peGptL7/F79A71XAhmb6MVeBqCUx
 Bssp3LIXqWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabtyAwAKCRCLPIo+Aiko
 1RkLB/95cspi3AcyS1PADLsVFrzCyg/JkttSiEFW1tZnkZVnuslG2tzA8avFg7mtLAnlq1Gd3UA
 3uIn997wVGIos/XKYO/rSnehYJNNfFg2G6lg6mYKN05p6icobqPm6Tmy7q5C2y2q58aLoKTPlEA
 F+IHvwRc+T7QIk7JIzWUpSDsmYU/7DLcRupggEGXbmAf8McKFBBMYl6JONqQCkbSuWksYMPrJeQ
 lT1I9j8lkxj3jB2oS9tJY3ZMXmyGLzMps4TzZlDVkqgepOQURu3SMnPXKgijYnJvVjlek3HaJMM
 TFABjZlk5a4QYpQLhHrUA/GjZG1gR7uSN8i675OyJ/xcY15S
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=MMNtWcZl c=1 sm=1 tr=0 ts=69bb720d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=_xNQ4P_HJxdd5osA_owA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: KAeOzlNESp1Tyrhzepy3wtoJlRG2xqF8
X-Proofpoint-GUID: KAeOzlNESp1Tyrhzepy3wtoJlRG2xqF8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDAyNiBTYWx0ZWRfXyPO+L+mupwt0
 5Vi4+PwamWqnyF1tuxw4eGJOYZE1SmnYsJC9XmTZqEMduSRS1GRHbpwkNxygGn6eLmY56zXPTdq
 R35ylhVyIoDEOxlgxu8KfvmBibT5oJWvrH97A+3dM5siuM3jPPpBROQoN22/4X1p7Yu7LNlzKmy
 WwuejZ07bNzZA0EOPYde1SBX1104H25bwytA+BmEqJWrIJznB4yLUgVMOK8RYhNncaW7VQ83FX5
 ouYCRYSjkprmqewma7KV6wOgZXGgWH/84bxSjFT8+bVOpqMXq2wngd08/OJbu3FMETsAEIMoPJR
 aWILwXCPM+0l+sVLA1+alV+mwrdQWxouQB1Y2sxlo3JKtqq2XRA8otpPPb1XrcJo+MpGAHZU/aS
 HpAdyH91BGob8Pf2mQ2S6STrVxo4NNSAGtprh5YHwfTWcqi75uK4w2AOSNZvpE94EGzWS/XoMut
 POaE83os0YCnql3VvUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_02,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190026
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

