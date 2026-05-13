Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD22DCD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3720210EFE4;
	Wed, 13 May 2026 18:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HdpOtto+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U0akYPeY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AED910EFE2
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:14:16 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DH0JZl2321422
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /rxOjF0YX/LqRk0erNH1VM1reWsG38dZ2KsYX/zC7SQ=; b=HdpOtto+23WHnld5
 m9XsZSf8vjqIqTFx8IKn6RUtD7/lsk+4EKewrWV6rnrS7L1hI2vSiygETvsvEngB
 MlR9inW+DbF7P+L5pldV147XYKVHXEJQPLscb60CDKVozMPwk/72DZ4rMNipITRD
 gqJubpp85cAnD1FnvAWVm018jiVRJDNdwq/701YVPr3B6ezbb+VlMdhw1B7GV20K
 32N1kSE47y25NB0KPnmOORDanknYymTFonQ0VMCk7l/aal5lbLw545PxL+WNYFKk
 wzIbgR/ILhzLPQAl6Glv38U3cs5eBNATc+y/Vu9lvc4i0U6gl7x9AuKkMlIVDxUY
 nr3J9g==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hgubbgp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:14:16 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-95f7fcf4f37so2986743241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778696055; x=1779300855;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/rxOjF0YX/LqRk0erNH1VM1reWsG38dZ2KsYX/zC7SQ=;
 b=U0akYPeYEiBq095Am8cKw8WuJxtjAN0I4PJ+YmJ3ZMjERNwGlA+l0isSzQPnT0fF//
 X37YTPb5mWzYuLQV7dqMPXdgIOk4oyQ9Qv5PUorEgo6hWTZo0RIvvD6fxxZXJZZMlp72
 yasdZf2ZOEe9nENqVIYA8+HZS1tjMHO7YbPH8oe22P0Uw0TuZxa1YszYfzrafrEDmRf8
 Bg1D/dNBJ/7JDfoxdZyZOdNTnEAmvTIhX67yzrUkze26eytkYHAxgkq7Ruyb+Fl16S7E
 cIfi3S0mVJr3JBIk7Q2FOF1ieQrDVwnKlh2J5rhKpIk2nIcWzI21iQ2WoXQdBegymwDa
 n/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778696055; x=1779300855;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/rxOjF0YX/LqRk0erNH1VM1reWsG38dZ2KsYX/zC7SQ=;
 b=sTuY3lUSdZYm05LA+7Pad8cVwkBOjn5i7kaK64t4VF9Tb3SJzXo+pNXqYT6YR6AEDU
 n5iLp0HGE8eDzVNRR9cDUP2f77GKWtT9KQ0rtIuoWLwPzSOZSxtYoNASf2Y0nhCRGoJI
 qlhlS2mvpaQ+rTNdnf1QaMefEtKu8HNcglDqUZUX66x170G1zgUa60J5IgCjFoXONyg9
 iGHhWsmbF8fHfCLQrB3Az3ohARkKwKWWdKL/AFe/gNwvt4z897S3Zqo7uMH1t+L+etzt
 6nzqQdtmUTW04SAKwvM+DDZsgiTDBWW0Epz5zb+AW8ys1Ko1320D1P2j+LPHU8Q6jIDB
 OywA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/pO/SGLQCAZy+URIboLYHK64931sbTAB1G6ZVm8vW7G81OKNsAcsn0y5MQgucLd1R0e0yvfMjP/AM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLLYQYRdcJw3+j/Ax3mk2R69ETisxodzX7qECCXQfiJxPPpBfP
 FxYWn6ZNH43A5xkRsDv621S8Z9T5xDmUUe8pG6evSJJIuMbx7oH5Ktx/pYYj8j4o8EtpDedQeP2
 xssdkmB5hUY6QEDT6WgELkdvzx+Nl3rmqEe9qE58YLbsWoCZ+P/WBG/6U1YAI1BDBdQts79A=
X-Gm-Gg: Acq92OGHtVIN+9Gm5rq9qGwOVhiBsYuDajiJwc1XNOueP9Aqvz4Pj84VZCSHYsioiB6
 uOwvrTqlZXej6zrgDnyKVz3/okcVeBi5HtX8dxtTroC0WzrcEul6mdw93OMLqjc6VqvhnJ9N/0h
 g+gwU/bfKxAe8IdWr7IR1dtxePfMAeNCdQ7MQ6MK+qda89QPG7c+34WlIqIbepJtVPlTYCRigqB
 4qFNNlLHaHAjqR6tl6i9vkjrrgKP76l7lkuauL7gGaV/Q/yxG6xtTTAtVqKLhB1OqCkYkpA+M93
 LvIHyxYOEAyYx/+nNaN0nq4u6jILktdKLyncnmi5a5MxoSi8B/ypqLMXEoslJe5KZtHWwidOEG+
 q1T1SDw/MEdp7wJsCq7XmyVKZLoJw0OcAWMhsHHSmHl7PZLIIvVH1JSW0sJggYBHm0kGZA7l9XV
 lTiaV3BemmrERmf53g/cWv9qaqgDOW2XQIBlM=
X-Received: by 2002:a05:6102:3e0b:b0:637:ad7:f57 with SMTP id
 ada2fe7eead31-637aaa5a6f5mr2136041137.25.1778696054962; 
 Wed, 13 May 2026 11:14:14 -0700 (PDT)
X-Received: by 2002:a05:6102:3e0b:b0:637:ad7:f57 with SMTP id
 ada2fe7eead31-637aaa5a6f5mr2136024137.25.1778696054522; 
 Wed, 13 May 2026 11:14:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8bd7d8974sm3174770e87.64.2026.05.13.11.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 11:14:12 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 13 May 2026 21:14:07 +0300
Subject: [PATCH v9 4/5] phy: qcom-uniphy: add more registers from display PHYs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-fd-hdmi-phy-v9-4-ca98c72f1f9f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2924;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=zXUnJKheGLXFIh2NeGjJnci3b8qeGjvnWTuieLLb4mc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqBL9t68jSUNFaly1KX3iQ5b/7/WNJg90DoXXSF
 URoUFQz3aeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCagS/bQAKCRCLPIo+Aiko
 1XUfB/wIlFw2c2IYwvDoS2FUSiaPjh3z/fuDn6ICL4Z65bKcyRXkqDKfFscu81X085BbcVczwkG
 kqiPpIT6gYmKtUbpCWMcpxMDhYNoE1WJEsoHg0S1piUbeqJBMSPMFfUZ6Irt9QaaG7i202FYTBU
 pcncuJXwDLEajYKKk7GNdK59AJM3sxwWaGzfpV76nZtBxz+BTyrSmhKr7rQ+FBe00+cRsPyu8mh
 mUkZOSBrAIjAUDzsjIr0S5mYaSBBrmTv+T/cjOiGqTbi+mJeXwY6LTQxxtT92n4xrVdU+HX6A9p
 leqYJo7jpCehRzYwoyxal9cQ8KwoBxEoWKpiIeR90o6AqMX4
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a04bf78 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=NWzoLV28igjY6Ppe7YgA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 1N-DKBqy8yGv7CK5oQbdxRRGj1lXOt6P
X-Proofpoint-ORIG-GUID: 1N-DKBqy8yGv7CK5oQbdxRRGj1lXOt6P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4MiBTYWx0ZWRfX/JKTLa262EX+
 zb3iM9kD7poO0tIUd70gi3XI8mbHzKFqIDyUi3V6mAw0dH5Ib9+nDMl+IBLxSh22qZrdVB6E8FE
 k4RnLVMurF9U+QJiVcYPqKt2+94Ht4QFao1ApurjLUxxLI7yDYncbUkkmlviqz6AXfLCeC9RBTa
 9dpZ5d+PS/S2wdVt1Y82aolt39sxFdHMiInwjCsnehxCf4YF84ybIXaEXY90YU3orsHXTRI6rnY
 zH435iR2m6z388wV9gkwb252+lwNZBpVy6TTrzj4BRCY44dy4lxwWfo6+Cyrdmx9RKrgt+foDiB
 2Ek4L7rAo++mkdUGYZ5LV8ax2tC8my7M7xQE23USdCwl6aKNVTuCMkhx+ZchfCwLGKmqKVRiqzX
 yQ2dNxhx8C+59I8dxNzMtChWiLQKCYJSSklnhGsnQ+gpQxqLcsgF4YXwoxrp07pq7twaak+w9yB
 8SjBldV6NqsSbD8ljGA==
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

Import register definitions from 28nm DSI and HDMI PHYs, adding more UNI
PHY registers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-uniphy.h | 43 ++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy.h b/drivers/phy/qualcomm/phy-qcom-uniphy.h
index 5f18f9593cda..e02bcc5e8150 100644
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
@@ -22,12 +42,35 @@
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
 #define UNIPHY_PLL_LOCK				BIT(0)
 
+#define UNIPHY_PLL_DEBUG_BUS0		0x0c4
+#define UNIPHY_PLL_DEBUG_BUS1		0x0c8
+#define UNIPHY_PLL_DEBUG_BUS2		0x0cc
+#define UNIPHY_PLL_DEBUG_BUS3		0x0d0
+#define UNIPHY_PLL_CTRL_54		0x0d4
+
 #endif

-- 
2.47.3

