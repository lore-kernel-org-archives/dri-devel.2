Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DC51088E70
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 03:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0666C10E879;
	Thu, 19 Mar 2026 03:48:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a8Fn53io";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BQxKQTpl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BFEF10E868
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 03:48:34 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J3KEGX2067154
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 03:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c58/Sfeclx1N64rZvnt6VYgoyb1/qdvgxUAhY/kc9dc=; b=a8Fn53ioPyLd2UN6
 c58T25imiz5da+jf6qy1c/GOiOxhdSwTPZeeSDp6qsO2zLb8ICxF+ryXJAqnS+Lq
 KSToZ3snDYI6makzp6MtAAo3jP0lZkGeywB7VAjGwXaSzx6Ti5ZflRKwF7Vx+XSz
 Tud6TD1Sm+Rimgcn81XhCYS1sC/8RaK/lNlgSLMny8greDLYZC2Jgxxb1EsNzUny
 utNRZJXvgFn3/y1gYWqCYO0bd8oR0EXxalApSOyk77Q3sWoUAiocvrGm1rwmBa2A
 o8pXlJqBCsclv0E4pyXInTwxcy7HNYyzmLxN2EruCWgRiDe/C+tVdcNpybEdi7iB
 2qdAmQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0957r2aj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 03:48:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b274f94f8so25608481cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 20:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773892113; x=1774496913;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c58/Sfeclx1N64rZvnt6VYgoyb1/qdvgxUAhY/kc9dc=;
 b=BQxKQTpltNPgUEYUYOClXyu8oFYjcsusjXDGG0VXoFKbuY/SW2ZorFaa7Ee9/dOMEZ
 wnR7g0fZZHV1RFgtGnu6N28jjW4vuOeP76XNaNZXPrhDFIFyfnwtGYdL5TlZ85Aw01Kz
 11ghsQEu1FAqa30sYBavc6DrQVIaYLK+/HPpHohhuklamDdd/HqUKbVNfxOmsI+A1RDA
 +sfUIJKQ8zp1q9a0lHyUWJK4TzzWlwtbQgAezrbXtLBvqdtPRS+xMTLn0NXHdMw7BM+O
 puoSRVA3OdzBFWHvjIpiArqQvxtLd+5yXvvbUvWrY21KGCuXY61C2kASpdUff5HtAtFa
 aFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773892113; x=1774496913;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c58/Sfeclx1N64rZvnt6VYgoyb1/qdvgxUAhY/kc9dc=;
 b=GUcFFd7F91pGk7zgUacVKGQ+QLoFceODL3pvbeVdg2TiDfUzxudTii1Ko/dg9h+KG8
 DAuVsu4J7y2XtPrbPGiuDi9ybs//+LoAd5awkSy9C8zhenQkLLClLsjaq1BypgoEnWnX
 hoZytbEYvlqKpg7tH1DKRKHPoGn+72e4YPi3hiwrDy7p+hMeILVQ00EGkINcNtPVXUGK
 W6xmlV4bs9SgyEpg/otKEUsECNdBVLwyfnpuBqjTbWrsXUi3oThVZsWWSwBZ/sVy7c88
 74TXGr5fbnOaK7l6/0W2WfqQNr7+T2iM7yXrECXBVzaluKaHoekiclCH/CF59K37rvf0
 313g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3l1hKo3Kz3WJ7qCpqI1US0ovpLdSlvMJIGrPBLKVT/uzzCyo4O12Khjkvt9O0q5Lqy6zWGy3dwdE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzryeR3Jcf2zZjCA+M7MkSNOKOJtnwUN7BkcHNUopMOFS0y72x0
 eJEWKALJGcKRfg11X+1wucpaM/mqwlscP3L2nxLbanHLr6bn7wOdLu3ciOdqcjdjYGYml1Yz74l
 cOsDSy8ui75h0bQAtQbadsGWzXiMjrnJwbivdPm46LOBx8wrY2WW4paQUttL9igVz+Qi0Fh0=
X-Gm-Gg: ATEYQzyLKszlVSLXGy1wdW8PvvcGY97seIjvJD+9UbZ6r/9BxEEcpQRzZnmY2JclF7o
 SK7KPGY+Wj4MjM5Vz7wpzTMb8XCheK/qVjPw1exP88l6bO+cg9VGyp7SfqKuTjfBVShQx/AzBPz
 1mVQRWaRzyVTrH8aS77IeahOBYlZ+ROJqpwABp/hO1RXgWroCpQv6xUcqZK4Kn4IqqP0eH2f3hH
 ktu5ulUYddGMH/FSvlyh6gEPtENz7nB/e5gjFhPByr8u7WavuXspHOI+WDN2ILegrY/GYgVhe7q
 PSbrWXzuUnS7QYIPrZiAJM6isDvP7UcfB1X/RtRDkfnprS4E7o3Rq0Mjae3cIjVG2mXZAUVcZVd
 NsfDcEfdrD2RdjL6jOIvz5vwz8U9O3MC38sLHF/qQwmVcphh48yW5LKEQc6KzXGdmrQX6eDM3h1
 t96QMmcD8W/5yJcWYyrR69OdLvuuyFa3wFJXc=
X-Received: by 2002:a05:622a:10:b0:4ee:1bdb:a547 with SMTP id
 d75a77b69052e-50b2461a932mr29074251cf.14.1773892112931; 
 Wed, 18 Mar 2026 20:48:32 -0700 (PDT)
X-Received: by 2002:a05:622a:10:b0:4ee:1bdb:a547 with SMTP id
 d75a77b69052e-50b2461a932mr29074061cf.14.1773892112468; 
 Wed, 18 Mar 2026 20:48:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a279c79442sm907649e87.70.2026.03.18.20.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 20:48:30 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 05:48:20 +0200
Subject: [PATCH v6 3/4] phy: qcom-uniphy: add more registers from display PHYs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-fd-hdmi-phy-v6-3-cefc08a55470@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2885;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=A0KQeSlhmmB1eMUUohCWtmSPla+2ZySmmRe5s7HDmyc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpu3ID1p9OtdtONIroVWJ4ofNJlQ0FRMyd22GAG
 GkG11xtlheJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabtyAwAKCRCLPIo+Aiko
 1QuwB/9Y5mflvk48vBMF2X6bgfx5G2s53oNW7k4Je/PGMIao8D+Iw5jt3r+8MZ7306+xOp43zpp
 A1blzkF0vmQbYgS851guQqkfO/P1LErGeeZ6Ir7iRUYGSZnDqfQ/2Si8yLPbiKPl/6nFt/Ow7Dn
 mPS04Mq5caROA+i3B6y8H1iNgcx2w+MB501+eT9WJ1g0dFWNPKLAtZqiZEaVZ5JD8kANn5J7RCI
 NR3GMgRAV1VByesZWXXiq8uxkBAkgHK7V6HdyMnrRTh3ijASnYLb4afO+33mHrjxwCbmlFbXgc0
 qeScWAhzGcb2KI8ZZVakjx67DZu+QMA3JCAwGQiJjzNbgW3e
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: zwYEX8qZIPggBPtLaouOqiEvPADcY0vd
X-Proofpoint-GUID: zwYEX8qZIPggBPtLaouOqiEvPADcY0vd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDAyNiBTYWx0ZWRfX4+QqgoOAEzF2
 0P/i6ghrLAtFSDzdPJBaNNS8NsQtbMcNgi5azxwxJ77mKw6RXKZprTKMnY2uJGSbN/PK67Tdn5B
 V3nmJ87EotCNyiRdkSzxesgCrcuqGAVHh2ItxdmMHmXYfnbpiOU4Gb6biBbKo6xBtJCUy20tmpz
 UqHMzkiROP93/Jvzd4G8qRy91+566fOlYI2hhiSRrvUCAI5rRaNeg5qn4p8IiIIXEtHMjOmq7rc
 6Q8MAoJjkbLmkwYHLMFCSmQUGUrL8rzMjqBpIQlmB22GjEm/IbEoSt3LK3UAyQEg2wdMbSQ9gFt
 6b6NZZKokXyjbEkSkWoZXqpJDriuEUhj/4pH+S2JZd0FHnjon1AnE9EaczFZ6+DjEs57563wEx/
 EpHYFK/ox9CcQPD9yxdXEAoEgRgAaiUtmNnWTiyv9c53fWuGv3krv440h1VNDJMG/AMmZ0U3K1x
 vLJ14SG5qIgchNdgGpQ==
X-Authority-Analysis: v=2.4 cv=RZedyltv c=1 sm=1 tr=0 ts=69bb7211 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=NWzoLV28igjY6Ppe7YgA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_02,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
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

Import register definitions from 28nm DSI and HDMI PHYs, adding more UNI
PHY registers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-uniphy.h | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy.h b/drivers/phy/qualcomm/phy-qcom-uniphy.h
index e5b79a4dc270..ba9d14aae682 100644
--- a/drivers/phy/qualcomm/phy-qcom-uniphy.h
+++ b/drivers/phy/qualcomm/phy-qcom-uniphy.h
@@ -8,10 +8,30 @@
 
 /* PHY registers */
 #define UNIPHY_PLL_REFCLK_CFG		0x000
+#define UNIPHY_PLL_REFCLK_DBLR			BIT(0)
+#define UNIPHY_PLL_REFCLK_DIV			GENMASK(3, 2)
+
+#define UNIPHY_PLL_POSTDIV1_CFG		0x004
+#define UNIPHY_PLL_CHGPUMP_CFG		0x008
+#define UNIPHY_PLL_VCOLPF_CFG		0x00c
+#define UNIPHY_PLL_VREG_CFG		0x010
 #define UNIPHY_PLL_PWRGEN_CFG		0x014
+#define UNIPHY_PLL_DMUX_CFG		0x018
+#define UNIPHY_PLL_AMUX_CFG		0x01c
 #define UNIPHY_PLL_GLB_CFG		0x020
+#define UNIPHY_PLL_POSTDIV2_CFG		0x024
+#define UNIPHY_PLL_POSTDIV3_CFG		0x028
+#define UNIPHY_PLL_LPFR_CFG		0x02c
+#define UNIPHY_PLL_LPFC1_CFG		0x030
+#define UNIPHY_PLL_LPFC2_CFG		0x034
 #define UNIPHY_PLL_SDM_CFG0		0x038
+#define UNIPHY_PLL_SDM_BYP			BIT(6)
+#define UNIPHY_PLL_SDM_BYP_DIV			GENMASK(5, 0)
+
 #define UNIPHY_PLL_SDM_CFG1		0x03c
+#define UNIPHY_PLL_SDM_DITHER_EN		BIT(6)
+#define UNIPHY_PLL_SDM_DC_OFFSET		GENMASK(5, 0)
+
 #define UNIPHY_PLL_SDM_CFG2		0x040
 #define UNIPHY_PLL_SDM_CFG3		0x044
 #define UNIPHY_PLL_SDM_CFG4		0x048
@@ -22,11 +42,33 @@
 #define UNIPHY_PLL_LKDET_CFG0		0x05c
 #define UNIPHY_PLL_LKDET_CFG1		0x060
 #define UNIPHY_PLL_LKDET_CFG2		0x064
+#define UNIPHY_PLL_TEST_CFG		0x068
 #define UNIPHY_PLL_CAL_CFG0		0x06c
+#define UNIPHY_PLL_CAL_CFG1		0x070
+#define UNIPHY_PLL_CAL_CFG2		0x074
+#define UNIPHY_PLL_CAL_CFG3		0x078
+#define UNIPHY_PLL_CAL_CFG4		0x07c
+#define UNIPHY_PLL_CAL_CFG5		0x080
+#define UNIPHY_PLL_CAL_CFG6		0x084
+#define UNIPHY_PLL_CAL_CFG7		0x088
 #define UNIPHY_PLL_CAL_CFG8		0x08c
 #define UNIPHY_PLL_CAL_CFG9		0x090
 #define UNIPHY_PLL_CAL_CFG10		0x094
 #define UNIPHY_PLL_CAL_CFG11		0x098
+#define UNIPHY_PLL_EFUSE_CFG		0x09c
+#define UNIPHY_PLL_DEBUG_BUS_SEL	0x0a0
+#define UNIPHY_PLL_CTRL_42		0x0a4
+#define UNIPHY_PLL_CTRL_43		0x0a8
+#define UNIPHY_PLL_CTRL_44		0x0ac
+#define UNIPHY_PLL_CTRL_45		0x0b0
+#define UNIPHY_PLL_CTRL_46		0x0b4
+#define UNIPHY_PLL_CTRL_47		0x0b8
+#define UNIPHY_PLL_CTRL_48		0x0bc
 #define UNIPHY_PLL_STATUS		0x0c0
+#define UNIPHY_PLL_DEBUG_BUS0		0x0c4
+#define UNIPHY_PLL_DEBUG_BUS1		0x0c8
+#define UNIPHY_PLL_DEBUG_BUS2		0x0cc
+#define UNIPHY_PLL_DEBUG_BUS3		0x0d0
+#define UNIPHY_PLL_CTRL_54		0x0d4
 
 #endif

-- 
2.47.3

