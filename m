Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4093107BCF7
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 05:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FCCD10E338;
	Sat, 14 Mar 2026 05:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UAxFRmxz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gvNp+AOr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA9F610E137
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 05:06:43 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62E3nW4l1999501
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 05:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jLcw39wY0jkt+Tdjb18r8ObNeBl0mKoaTLbtIH1xiyU=; b=UAxFRmxzl86pEki1
 +ii6XYj/iQufNO3HT7ERGgOHDZUPM8UITAemyLHIGKG8pCVS/YXzC3YaU30hKhDL
 yzvpTGfo0AwurNQg+Kc9fJu+Vw/Q1D94KGNOOGj+bkZiMc8aWoqw7DnT1LNicxH1
 zTTlG4o2GAjs2ptOJR0w1VAegDOOjMqJ+ejGw9HczPrNNw/QStKvDLS/G2YF4OUO
 YEsFqw3G/ANrgx00g0JgJr2bUydadQc3rlFZSyTIM/EF/nqLlJ8o69X9t01dXOqk
 MiXGeRhlE5Q1ayycaRTy/j3MOWbIehgCVuDyZZNCVny6ekbMA3NxzIEJz5oQZsEd
 pUzZ1Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw04203kq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 05:06:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cb706313beso441953485a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 22:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773464802; x=1774069602;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jLcw39wY0jkt+Tdjb18r8ObNeBl0mKoaTLbtIH1xiyU=;
 b=gvNp+AOrPmT4xf1IeoKLYTBbzrZqLcnw3jZaDosc5bcEeblniLGG14bggn7L0kpiF2
 4dD0f7q9hPBVgnebtepYxmPiBrCpnxgOyB/3R3RsigNwG6QA0b3Ox31R+tvJlL0kZhdD
 2xR6r0lIysH5WBIKQdZxF0a/cMhZR0XgRLQCdvMqkJ8FPhewVjQhA/08ueKc6grLr7sC
 y77HAK17AoyibePT8jWteRaRd7LKXSdYvwBxzhbu/pYUd33PSfXjHbQ0SDzCpNuD9c83
 bi6b5JvfnCNzr9q7kz30KC+tzwKjq7xlNbwdtlOne39ZaYujpc279U/ZPwaqevWMXuzS
 6eSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773464802; x=1774069602;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jLcw39wY0jkt+Tdjb18r8ObNeBl0mKoaTLbtIH1xiyU=;
 b=VnWbtXQ6ZWZXZ63H+cOUf2XRskNaDcNUYNyDUw8DdO4K0vJgneNGwuVikisaoGSKv4
 VP/zIlMc+36hJkJJF8teYoyEkTo2BcfGhODKV5Dq+fO4GWV4xvYdYcE7wkfjtkx2Ak3K
 zPoCoND6Wy530uLG/YsvfrnrsBMtxtUjzoOxbu+ePG12UJEfYxcMl6apm5V2mb0cQuzy
 YNZRJUkCr3Rmj71buvIRxEAoafArMPQUTpGXiF8ilt5aOV0iOxa8UTbOwqd1dU786dr6
 T68ozkAk4uz/YE806qJPSmWRGI3vYZojDlzhtrU9oUbaK/YWjdzMDLW0+juABfTaRFx9
 1MmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHm/z6pEt15mjZrqrFQoN+Bae2LmUmq7i+jSYdt2neTVP0Q0tfvOH3f0QNWMf4zS7n2k+wcgpdp54=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7dMzAE6j74nAHiwBefImlqe/ieTqbZHtYNc/FwWtYchHkkjnR
 GdmQOYli0kj29mZb9QM+5OkrI/YuPhHqKsHHax54ndGBt5OL403/ymm8pSqgzphDmv0bsa28IQb
 mwo7Nr37FA5b+CqoBszgP93JyXbgaSUHCsnT62WICZ7g6knXL2tJpi6hS6CeXqKx975Kw960=
X-Gm-Gg: ATEYQzy0JjshsTA+ekPMg7zpMOGMRB6TQ355gGXHQSVOPhsJVPHL6+z09/mcdU6cQYt
 43onH2c3zithf6FNd4HCVLzobhmBvuelf4kaWr4IEkJ3ONe1xNoYn2qDp6ukMviQ3PrNOJqgzTq
 15EQ9U3F7laVY8LZvgK8c1nDj2C7vH6SAcgIZgk8tq7/LapUFr4MAotJLxBefVGf+n0OcLz5G98
 dRgzAGqMxZCe2el1o/31guwY8JtOfgN0k/DfkXPl0nBrrNoI4A6GBHY4hrB+CDT5QFO7wG6aY/4
 nFRzRp5e548AloA+0ssYtbTR2MGX0tOqanYTvH9bLoitfODt04S0gKfdPYPGwjRGzk5b+pImlvb
 7HmsDZr9xZ6Nn+aTmTVFNRq+LpRxpnEiXkgsPmb1scsN+I6K0GUTPaFDDB6BJqxzA9GHRD+L/xs
 z941mEeK1VHiG6jpf3KY5x25KSg7x7gM5BxdY=
X-Received: by 2002:a05:620a:2956:b0:8cd:b05a:a631 with SMTP id
 af79cd13be357-8cdb59ec194mr755931685a.16.1773464802334; 
 Fri, 13 Mar 2026 22:06:42 -0700 (PDT)
X-Received: by 2002:a05:620a:2956:b0:8cd:b05a:a631 with SMTP id
 af79cd13be357-8cdb59ec194mr755929385a.16.1773464801855; 
 Fri, 13 Mar 2026 22:06:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a15636206bsm1982771e87.67.2026.03.13.22.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 22:06:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 14 Mar 2026 07:06:21 +0200
Subject: [PATCH v5 3/4] phy: qcom-uniphy: add more registers from display PHYs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-fd-hdmi-phy-v5-3-58122ae96d3b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2530;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=YN5QoEM+F0T4zQEnjBPndZeQoDCtg5ulqiAWAhLkG04=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBptOzVyi6PKpjFORb4/UdmwCTrHqoqSSh/Ga4b1
 aLH+7egt6mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabTs1QAKCRCLPIo+Aiko
 1a92B/9fHs8pscVhgX9ZdgfIBdiydhNXgNgJoBDNyCIBf9mE6/Jy+SzM35HfDbFSrOvNgX7L+rG
 3AE35D0Th7sTGa0uSfvM1yjb81i/pWzZyUwYcrunl5wfIOKPTPcEPizOp+q3SK1eQD9Vg+u7DGT
 bXECEz2ew/Z58sPjKXUTor5Vba3sNSto7+8OBoe06NbcL0mjmndAjMCuzlMIRVeKkTjshL0QDJJ
 /6k/Hg1lzR7yQiLW3SBq/BhvvvmS7Y36ACx/6ru9tjrNp7IOhR2RzVzSGLh+Gy9PAYPEMKBZ6dq
 p3uBfZn+gO1NVFx/d9Aw5T+2I731/DeP9Z/2aHrq8vQKGpyA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAzNyBTYWx0ZWRfX+fvSWBkaBgXt
 Tq7CL7hSK8JRf5M+e2XS/HGS621SB16Wg94vKmkPurZrpPJEK6NBdFw4u2Rev5XZEqLPHcYPKa5
 IuGP23mPY+LRu69VDbzO8rW9lTzP/9aFSQyK4LSBaCO0y47sSOnqLTSRiAx+DfjmmylVJnvTTFV
 qP8n/PHAHRF7ZuGTKpVbuNv2xmWUZGIFHjZ6bspZlwGI0+az4rzYLyhWbeucE6662zi7RP/oPP5
 /ZPmdoZQvvSi09ELKJhhLf6XVwoBISuN/8RD7cUnf2ShsC5fdcFt/cj9stCl8ShYWJYwbp4U0GC
 YpEe7l0RPpkUR2wjfrTeqjtxXYfHOrNtS1AVG8pDjkHvaXAucPD5R5Wd7+UnembNPsqW6tculr5
 ltX97CcGATsqBdyf/km3vR8lMpcbFjDdb973ZT2qrjCoxbJmYjb+5E96zOI9aKr52sSZ+cm4BWa
 Zt4HHsAZ7I1AL2JEI7A==
X-Proofpoint-GUID: pIXbqnGrO0yue1pHYHHgLTScz6i04_43
X-Authority-Analysis: v=2.4 cv=SJJPlevH c=1 sm=1 tr=0 ts=69b4ece2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=urM--5puCODp6CsINTkA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: pIXbqnGrO0yue1pHYHHgLTScz6i04_43
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
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

Import register definitions from 28nm DSI and HDMI PHYs, adding more UNI
PHY registers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-uniphy.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy.h b/drivers/phy/qualcomm/phy-qcom-uniphy.h
index e5b79a4dc270..ce782018124b 100644
--- a/drivers/phy/qualcomm/phy-qcom-uniphy.h
+++ b/drivers/phy/qualcomm/phy-qcom-uniphy.h
@@ -8,8 +8,19 @@
 
 /* PHY registers */
 #define UNIPHY_PLL_REFCLK_CFG		0x000
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
 #define UNIPHY_PLL_SDM_CFG1		0x03c
 #define UNIPHY_PLL_SDM_CFG2		0x040
@@ -22,11 +33,33 @@
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

