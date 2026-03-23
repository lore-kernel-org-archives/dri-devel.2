Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05C4FC72CA
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 127BA10E452;
	Mon, 23 Mar 2026 22:56:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WXc4F6jC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PcBpNSpW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B265110E452
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 22:56:55 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqbr41762120
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 22:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c58/Sfeclx1N64rZvnt6VYgoyb1/qdvgxUAhY/kc9dc=; b=WXc4F6jCyeX50i2q
 9vQZrUqXSHHdr1oyMCXOobR9IQplNrsd6ZBJU12Klp1jO6N9I9AzUkpSoOV2C9KY
 pC1M1QdM3EwwJsm4L21aFVIjPfkmyMn6mTIlPKWQfg4b2fOp1IBzvWMVw441NCa0
 +HYg2LNipTJ6lbEEVMnx2ji4t1/9RKjJ7O05Vgrhb/4VKKRZZ2gO/Lssz3+M+lXA
 zkYhdcIUgBY/KTA2hfsgMsIisG9i/Qx/q/RZ5l0gFgK2YI3yeOaan3Yrk2Gh2deb
 UhL2Et9VCmeBspLpoKFc1qs8mCjMkUJNaTVi26T/H/jYXROPrdPE9Mm95D0+TvWT
 vgnu4g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d36f09u36-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 22:56:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-509044f54aaso38701861cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 15:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774306614; x=1774911414;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c58/Sfeclx1N64rZvnt6VYgoyb1/qdvgxUAhY/kc9dc=;
 b=PcBpNSpWt57IEGXDQZX60SyNDvBOrrkIUeK3cz9+oTuDM/1cHwCPBVY+/V+Z2exAT6
 SocU3rJcEUcu3Tin5+BwjvE50+JRC109/hcx6JLW587lxCRoQ9GFas+b5M42a2aGnM/I
 naL4ElB7nMgbATFJwP+EFh01vEdbDtyI44vdtTtAgVNBYeiuu16DVN0Wk7WIvUPqaURp
 oDOwsoEiCnuX1LBEJL6ChnM6lQibkNQrs/7vcaQ1gjVLc3q9vM3/aPpwpV8ePPLtpNOs
 wKitgJW9rHaebTurvhdmHj4gjw32ao9RcTODwC0gnQ7V3HNdNt4aTLyKvBJkmUnBwZEf
 BvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774306614; x=1774911414;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c58/Sfeclx1N64rZvnt6VYgoyb1/qdvgxUAhY/kc9dc=;
 b=gn3JvR7SDMQh2Ww+hQVc28FBv0QOrG6H6xD8QmL4T72G63FvWf9KPlKzXWrsI1imnn
 DsyJSsbkzXtz2VDAV8V1BXjlpaecHsvvgsnbwIkDzLHCbEch8VD76nGWqcL51dQWz8hX
 qgUWQFwuj5Jum8vyKPpPzbKKS/fk5MxBfEGYenyaQPNe8ORxiM/3IRr8cIWFUtFKoxTG
 FWbwLGMyRXVZGROrgyqXPnczimYDEqBDx54jp8mdFcqy/TMcCQCGXzKcqe5LBYM0zZep
 uSBctXp1etc/GioLV9oOAjDXpYsDSfinzB0QIBJAZqoTMAO/poMlQcB+MMiQZD/5lrXG
 6Yqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxQXPW0R4rbfAnTpseh5uaEwIrkcxZK3aduNW53tIoYdhQVQuZRo73BhGdxbNSSVCwZJi6iD1Sgxk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtON+c0Q2M2Y3LL+VKFHMW2BO4IpMDzKVpWx4GhaStnCS3FMJs
 HpuFgg2QmR5MrjiOpqFCJemd0kRPcyGsayc5B2l0HOGaUYQRscuutwFUFuLQRl66XeheLg+R0N3
 LnmJBn4ewPbz+3zqhMkV0iFYAFb4PkM8CE9PJLMIzLezrXpXDzLJOMNdK4Q+yMyMV2BmA2WU=
X-Gm-Gg: ATEYQzyBL6PvQW+PTqvF+chAJvLD9TENdnTppx4HdGLFdzPnnBvnBbKIG+erDRvyFc6
 xvMkAdNLPWGNaoWZMNjHC5ozZeiipC1htij1r/qe5RTyJZFxfoS8ApINHy4zymc/6PDVFk0i+bS
 7XfvoFzyeezAb5FekLqKbkIFgGmwTiS4l2li+wSub/Fo9bszzug3f54sKNY9aCr1h0B6VCml/o4
 weMxfB9fbplA6sKnBe1CRoSiofuAs4zPUzXlZdmbCOR7lNddmJJqRA2QzVWAfGjmUxfiTcosI+Q
 DAbFhhE2h911g6cMh67Z0lTOFBTFuyatILIHIYQBUqMWcogqfwkTw3MUH6Pto7WXg7irEK+6NvE
 QZckIIRJCANfIFZ681UWFZfLErKov1Dy532GQkJMXfJTuZIUBW+SFPeuAFefXbtYw+OgnVkbbKQ
 RjQB4bU/Q6Mlh5UnwVw0W74mWizbzt0Xl8e74=
X-Received: by 2002:a05:622a:20d:b0:50b:4eb9:a97c with SMTP id
 d75a77b69052e-50b4eb9ade8mr133913941cf.15.1774306614019; 
 Mon, 23 Mar 2026 15:56:54 -0700 (PDT)
X-Received: by 2002:a05:622a:20d:b0:50b:4eb9:a97c with SMTP id
 d75a77b69052e-50b4eb9ade8mr133913741cf.15.1774306613584; 
 Mon, 23 Mar 2026 15:56:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2963fa304sm156489e87.27.2026.03.23.15.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 15:56:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 00:56:36 +0200
Subject: [PATCH v7 3/4] phy: qcom-uniphy: add more registers from display PHYs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-fd-hdmi-phy-v7-3-b41dde8d83b8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2885;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=A0KQeSlhmmB1eMUUohCWtmSPla+2ZySmmRe5s7HDmyc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpwcUmGLIzcnXBqY37D0iMQAO5l7qaw0cK45eJc
 860JogvHIeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacHFJgAKCRCLPIo+Aiko
 1VbnB/4laU/pBpznNLavxzW1loPsnZHQsmSaicyVWUApoMv9SBYQnLRsgj89AuuxLwqxkf3dgnx
 Lxa1m6BoU32InHZ9A7rbvXDfgXv07vuVmqo8/pGh7GI2CUbxxVUF8Y/MjFkPYscIRI5kewNj+cE
 HGmS4RLGVBLQiE2Eu/gJH6BWJoCHfM8sG6ZcoBR/YvbhsGudI+gNFZ846Ui7ixbE81iAKbLad4V
 bkNw9sO1o0L6QvtismtTrxirwUTcLJH5ZDqcWq1M/S0fCLFLMm0iZvW55uSQm+GV9KLpA76LMN4
 s1kbyu7R0pfMeWzzVHws2EDbuGw1RTIXf42SMWmyWe57zDFs
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=b+q/I9Gx c=1 sm=1 tr=0 ts=69c1c536 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=NWzoLV28igjY6Ppe7YgA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: QmjoK-A3bqQtXe_edrCp7RLapsPnhh3b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2OSBTYWx0ZWRfX3QbM9GWHl4sh
 PM4iTjkzyECU/XIGe/vKitCYS44zknDeEfvVV3goZLLYkNw3bVY/fo/edpcs3duE86N4nDDyWJb
 ToI+r6vwNq7NNrYJKlc7zaWZxeVRvm5KOzyiWNhdUEcDbnWuA2f1r5RteBLvrzUOitj3Js7W6Yf
 NZxqy1Jrn0rlRtHHb+a4l+j0ZIeAE4k0ES8cMh6bg6kBgIL8uiy9MRQK7yxD1I6o2jA9yDwyQn7
 pr3Ehh0aUxvFXP8UDBDWxzaKMyobIwzQNi9F1DmldxFSM8xskG+JvylYNCkiLKti4jmIoe+O2ih
 MnMCPzTDEK8by/VAo0f4u+rmIBFLFaAETJM2D6DCT7p+J9iaLeRs+tSWnzszeo0pCSnok/92HYX
 R/mv2WnwvqZ16Zalv9e2p0HeElchy5gFuyW8sAJmLVuMHOTTOSj6Fqo1qBf/YKuFA5Xj7Zrv2IJ
 RBIVz8t5SeoXHNseyTg==
X-Proofpoint-GUID: QmjoK-A3bqQtXe_edrCp7RLapsPnhh3b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
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

