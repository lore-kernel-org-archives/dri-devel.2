Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C801061B31
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 03:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3803410EBE3;
	Wed,  1 Apr 2026 03:39:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kWyMSHBX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dmsistu/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 461F510EBE3
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 03:39:08 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VNaD0G1831814
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 03:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c58/Sfeclx1N64rZvnt6VYgoyb1/qdvgxUAhY/kc9dc=; b=kWyMSHBXruavV91s
 r4KBfh3/2zQYc3tYcuA/aXXFlELxdSDQdKEPyzYpA2uWm9pg3DDpjNRnMLMZmUps
 Y3jv0h3proTQYSFpRQ8measxcesyFKqTqMXIE19XTGeD19mk/xfYL3wPp3aPlOXL
 UzQrC3ZCmZuLJAXWfVimoGLjAwTbKNV9lzzsWhaBPNHxSWy10Dp2aiQSAbhSAcY+
 xckn5WR+lVZkoJTFgwTsWHJBKI9i4ooMkAMuqzdBEAc1Wl+HZ/P0xk1w6KSzQBL8
 pG+tk6Xepa5aBRGvQwoDi5psr8nX/Rf2BOgU7LbPcxpOVZkuvtvszct8axI5JqZZ
 EA+BaQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8equbpfa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 03:39:07 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b2cbe7223so209544431cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 20:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775014747; x=1775619547;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c58/Sfeclx1N64rZvnt6VYgoyb1/qdvgxUAhY/kc9dc=;
 b=dmsistu/rb2bA6dGf9vD99XCE8Q0EMPN2ZkFsKHy3Nr6V4+V743dAZ29iObbphSUgl
 fsqyT9XALX/c/B3/8Nr5QBHbrCsRtoUPin6T2tH+TRPBjrf1IHmrUNcWI9MRtJMNuh/c
 tMDkAZxlaut8JGKaHj2tdsGn+OOYNXlPyQjMCQMottthXNrSv5Yth8d4VS0zG8OOmZq8
 pYxq2T1VGyHiHUeAAHDdhmEgIz94iQXb5/uUTiJiZcH4UGCOR0ep3a8Yk+M8IpiwEEk1
 4Yynwufs34K9dC4YRE5s2cU23VIYMd9wlxs5hRw6iDK8uStbZF2xZW/k6WWOUHWxDjpC
 9Clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775014747; x=1775619547;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c58/Sfeclx1N64rZvnt6VYgoyb1/qdvgxUAhY/kc9dc=;
 b=fngZ64eBTKyZKnjQbSJGegxpBll4c1TuxzNBgJbqBHzGNwejjnuVqA8so48zbUL8l/
 O/SxTIkERWEiKADhMIOm9jCCZQXIbBiKqE0e+Wx+aB1oCOFe74Wp7w6DqLhsCcWj8ALY
 /OWbGktjt1N/UglIJqxfTxpmTjqNb3eCp+y8nejt2+mvhunMlbI5toDk7L4lKplZKXDq
 v1EIo0zrmz3GhxyF0OuF9373n9I0UDvIGMwpw2x7gpRJ19sC+y60ateHO9PEIwkJZCO+
 +N2lU1kJkYIlY4Bjpvat6c9QgBKQG3TfiXeCEq8rBB3Eu+3HsKM9aYQUYFM/622+6a2W
 7YZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7EFfAo83gDRQVotg9F4NXwCUIwTBd1iuaPOiPFhChaeU8o4eJzSOje/KllrZwa6ZPYdturvcOjI4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/g+Fy1li1+9OLJfKUzyREpFyvPVgX/LKzPIIwE+jCowOthWln
 GjJkxsQ54S66fivvkZiZN00kJ4ISuEXWGCeok7XbRhJndmuDBZ74f/dKqMkEGvnMz5Z9YoaWs6m
 A+4kqlmsscxkxlp8WdKBDBtSkEGn7WRHRveyg/zv65W2N97FbRXTvnHzWPHuPa6JNVBpiMRk=
X-Gm-Gg: ATEYQzzSOTWiQ9NHNKYycXrC65LcucC+IpeJ5v1irfFJ3yZQ2YTfZn/ANdt+6FDgDi4
 aojQSqwrsk6g5NMekSyqLbNHje6yuth7eYi0F1vql2tgo+wQ8cFeLfA0RuaX7AjKaE2Qa03ZoGQ
 dNUNSY2mvTw3PtgZoS2ymTlGbNvcT3+TDLmIzwMa5Azg5eCj9El0Np27v0YCyt8iLNwKUk7E3eJ
 O0kJ9bwh4yKZ8NUX4iRT2tNjdZCzTS/ZwLml8vYY95G3tzdhoLMyd/iYLMpXgWnlo/5gEQqNeGg
 h5ZoGycZukNinf+9Qd5sK0MGXhMNxqs9+sr0s2MTL4i84MPzekWIs62g0ceekoUfvTuS7ocZKg1
 yAMKaZ56/KT4RsQC1Si2A1Ektg4jDHLhiaoRzKjiNliDL+vb+55hgv8a1iGlPI2QAWm06J5L/8H
 xpbgGylceB/T1yzZxJZ5NssbS6/RWtTZU7cTI=
X-Received: by 2002:a05:622a:a13:b0:50b:3b54:d78c with SMTP id
 d75a77b69052e-50d3bd78c0amr32199721cf.52.1775014746748; 
 Tue, 31 Mar 2026 20:39:06 -0700 (PDT)
X-Received: by 2002:a05:622a:a13:b0:50b:3b54:d78c with SMTP id
 d75a77b69052e-50d3bd78c0amr32199311cf.52.1775014746284; 
 Tue, 31 Mar 2026 20:39:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c83730f7csm24404851fa.16.2026.03.31.20.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 20:39:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 01 Apr 2026 06:38:48 +0300
Subject: [PATCH v8 3/4] phy: qcom-uniphy: add more registers from display PHYs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-fd-hdmi-phy-v8-3-51b0e98edf6c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2885;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=A0KQeSlhmmB1eMUUohCWtmSPla+2ZySmmRe5s7HDmyc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpzJNL5iRXqp1OJirSlIM8YMCd0J2GckN/Wf64w
 2wMeVZ3OgOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacyTSwAKCRCLPIo+Aiko
 1fJ7CACbeqEUhDFAb4uFedgJ/xy0En4l0uW2mMQAwEyXkpazQdH3Kwe1d4IjF66qerc3o+mv1vy
 JyMuGdrTEljp3Jz+MF9L6MWLIDlf/xO1BYyUl0k/g3v//fAXD/pJ8rUr+o3LfY1Sqx0w9bC85Ea
 FR/z+rMWgZNfZWHM+x0z6YUkilODx25BcC8PQc/B38yfXpAjQNJcmz1NoMxlO5xE/aYw7xKHfWT
 uKlCPpb9jBL3k3AysVZCmoSwBUXlEfkzQwv6x0gjd4cavJX+KrtaRVB4J7PgsQGyr/yIjTZutH6
 qKD4wp5b/gg7PK3uMZZVD7Ige9qteLlOvz+HjGUVbO06fSnq
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDAyNiBTYWx0ZWRfXxEjBVbZAxTv5
 9JRQjYhUGeG+rM2z6EvfCUjKKD1c0L8Wx7Wj85AfyYTlMRIHOlcCuwBrWRUWrH68u3KDjj+mcsC
 mxKUc0YjoyfxTytpmqnIbcact6YTUQdVqql7xaCbQDXjFZyKcxSetHA4C2+Y24AIW7jsZbR9/1E
 exLAmFHEjAS9aXhjPgS3Lbwdh9zmnoQjgG/NbcC91+wckTCVea7wq0xv6u8lqJAGnOvb7qKM5Td
 C5je++TwcaFTDi+jtdwMnvxMSggnzhInlpo2h0l86otdKrJ+NyaZBwHxk9Z0FVeVPNhUFHiij8p
 dYn7g07j5BFw4YceG6V1x2r5XSE08ZO133KcmeADQPv6YNf3TkH/L98CrqlH2RXLUxMm9xmA2t2
 +tw11QIdY/WbjcsJFh2TB2ESwXh9MJoDec9XjJbjtChFPL6OYczqeq2/uaHv6yaVV+X7+PaPI0r
 3K/FKeFY7jPfMx/psjA==
X-Proofpoint-GUID: c4RH42FSHnrXHk9kMD7pa60Q9rBYrfU2
X-Proofpoint-ORIG-GUID: c4RH42FSHnrXHk9kMD7pa60Q9rBYrfU2
X-Authority-Analysis: v=2.4 cv=YMOSCBGx c=1 sm=1 tr=0 ts=69cc935b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=NWzoLV28igjY6Ppe7YgA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
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

