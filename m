Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49648CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA71410EFE6;
	Wed, 13 May 2026 18:14:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PXb1bli7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hga1kTVO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D3310EFE4
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:14:18 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DH1wpg2321270
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3o2dYgGq0E5lPn5vU0FBECkmJVwMp6ZZWkBRjZuUung=; b=PXb1bli76W6OLUK6
 B/EctDeA7IUNRWW5kS6MN+a8KUVkTnbJIZdRloTzaMnRYwmi935yjV0Op4h8XowJ
 xRBtPeOIM/IvXV4pvdh2woarzpZtQHmWIw0Lot1ek1FDwlItibqffxrCEqLjrsWV
 i/dEi6FXTCO/YYgYa6gVnz7rlh7NvEyoNTV9Yb063DxFak8Rs7kcrffse/Jl3cVz
 RakNe11se/Y+SjLQIkO3DBTVc3K9of2ZHivAI3WCPJE28mZvFabO7ypY5ZB10Q32
 tc0bZ4m3eh2qzO/aT90FTjDLQkxRnB+At2R5ES7j3bvlT7+8k5yRPrW50R3rQktG
 SV28LA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hgubbgu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:14:17 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-632ad092bc5so5838693137.2
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778696057; x=1779300857;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3o2dYgGq0E5lPn5vU0FBECkmJVwMp6ZZWkBRjZuUung=;
 b=Hga1kTVOivYFYhLqW2JT75B/TrN/bKjRBlzOIb6NXGmv/VLLSdOu/O73cWEoOuV86k
 +r6+i6RVl3cwEabTlXJND8OQ++Eg9PmCtQjPctenkq/1So/5Mh0VqOhVeE3BzVCgajJs
 YSWpYB5aTBOQkd2oSrjQDom9AkZrEKkEHSjGkUtOSlW5KB/FITFJAdkxNaKlYgZw30yh
 3cs4sYfF6iqY2oDThZJlvUYHc5FKEJ5U4Sn2Q6vPv1UHyYB8rlQhlhFvL99LT1dY+slQ
 pekBO+dxaZ75122k/4WLuKlJ1VbVfjIPBjYTIYPlxSNIIRYOR/wLVbeOLKdDMs8qyHuy
 TIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778696057; x=1779300857;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3o2dYgGq0E5lPn5vU0FBECkmJVwMp6ZZWkBRjZuUung=;
 b=GXZIKUQssPl5GOi5gp9q15jVxcnJc7LIvnGb1WTdTOjj30kh5Gx6IcEHZ2WpiJn2+x
 G/g2NypS32rrCh7ED5Md9JyrTB4Ve6qsAJnD9j+Rs5uCVcorGVfJ1CzAKHpUOhVyVmva
 D8cczgYNKVkbm3Y9odfCVHIpCuv8r9PDjX40Iv/EdL3POwNdAN68rPBlD90jyJPqq5gU
 N0sPx63xh0rXl5Xseg4Goy9RPiL07M2FA1UxZWbLk+ZayijyVJXbeU0CLJJaHrQOZYJf
 UzLZf7EYilBd0YAeFiCsdBOJGiuz5iZDTDOSu5qIMwzX3U7T+Mdvt1PhB18t7C4yRum/
 H+Jg==
X-Forwarded-Encrypted: i=1;
 AFNElJ833IH2WRikh9Tp8hGn68tdNA9ALOYdwntFHpIqT3go/qF73ftOrn8wRIysGBoX4iH12c9J+niPlC8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyqZaGXNMSU0honB81sjMD4DWUggPY3vNWD7qx8I13hE2XVMWcD
 7pH4XA/8jOefmHO22FBdqI/ijBYyPPDQ0C8bFHkDBt/95Ev3Y0hhEB3TQa74K/Tn5AOJC8igq3K
 mwFpTYEiCteS0BXI6MxIQR37M1iSfrAJIc9S94SHMAr8iBYg1I7hFK6udy43CbCiUmt7QErY=
X-Gm-Gg: Acq92OHLEmWArHZGjP5Mx6V0ITAaWXHGPLc2jglf6WmVX0v/P7Dc7y7T3B0qdXOI2z6
 uQJfx8U1dzLe48vcVmsw8EKGUIXdNdwZ+opEy2xU9tYm5M6xLZBPOpRKbyX3wD5dpjbzy1TqTNl
 IZTAmgXel5P+ypS4oeF9YEsNRQ9uMPLtEUpv0phdJs8aqcgNWtKyDqVkzp48TkZrJX2hKRW0Lbx
 v0Gad5BifWNTRlDXk9IJwUfmn8TzIJ7eNA+rhwe3mSR9uDWBRIUCRkTdYHloXPyZ4T5OgsOf527
 H7cNJMl0IJEkY+aJ/TC0bcj4+IjIo2RXxpVttS64xqcCDZDNJBlMcBlEqCNfHn66jTGJ2up8zfU
 GzhuMWHjvpmEUAHXDdBQcKwPRbaRfq/o+3OU/3gZzdygMzqjV30TKn+SXusrMzhaCoSZRrI6zS3
 HzJYC+NcxdXLiB7L16Pqit2xnbJyetCOE/ilHi9CR1dITZEA==
X-Received: by 2002:a67:e703:0:b0:632:78bc:2bdf with SMTP id
 ada2fe7eead31-637ab388366mr2362443137.31.1778696056630; 
 Wed, 13 May 2026 11:14:16 -0700 (PDT)
X-Received: by 2002:a67:e703:0:b0:632:78bc:2bdf with SMTP id
 ada2fe7eead31-637ab388366mr2362417137.31.1778696056073; 
 Wed, 13 May 2026 11:14:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8bd7d8974sm3174770e87.64.2026.05.13.11.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 11:14:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 13 May 2026 21:14:08 +0300
Subject: [PATCH v9 5/5] phy: qualcomm: add MSM8974 HDMI PHY support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-fd-hdmi-phy-v9-5-ca98c72f1f9f@oss.qualcomm.com>
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
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=10299;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=fiAxSKr0MiXtgdMoguQGBGHvUIsEFSFdo1fVWLdz2eA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqBL9t2xJILDiTUglQXAPwOJoAblLE9eTWuCWxM
 UG7ow3AGp6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCagS/bQAKCRCLPIo+Aiko
 1YR1B/44Qhu2PZRI2XldEMpcilSgnWABIFpUPMlVRyggw/TwqvHsEJkI/Y2Delv9Zpv5/wooIeH
 ksgXuJeIrM8I+/5MWjCXRpcczv0rAxiHZby9NojAzo2kIWbxJoi/3GrhTylYoDFeXXLK0HDEIEO
 ZlyVyonGAx4O8WW7psKY7yUXxMOQ1843A8Inth3mNIkC10m274Jhoakc9jCWGt7i0sTLrcn5Uz0
 sVYvDSW/vpnKQQsoSOdDm8KAizpItql6lGSIkm6JOOyTGcQC8vdEu9Vo3mGeAZj2nT+aqZWi6n/
 TEXqqRd0CaTU675gqmbeDi7rVNZBeVdeatN1kzNEjUj+/E/3
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a04bf79 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=U0NZ41NzsMKYcVuMMSoA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: COodnhxCO5ie3U5VUFcgAXC8xWDDVmKT
X-Proofpoint-ORIG-GUID: COodnhxCO5ie3U5VUFcgAXC8xWDDVmKT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4MiBTYWx0ZWRfX3wP9KPEVitgb
 Bktp1+zWaFQ5IAKeW9Oi0ovPBRwFQx5T9HSvGYQqDOLerguVCQkJRxxM/l1TBu1nF1+t0BA8+67
 EXn4FN1s+wSy5PZx4K+eSQAiO6NPtskWlXZd8tCNSKj2sGP2fKseUToEYEfC3jdsX7kLplr7eke
 qqpLsY09klOIHsCphbW9KdImQqVqPodecormqisd8To2Zt7/mV+s/G8j8V24Zu8J7iS+tFSefle
 GcxmFLBYcGOdQb1yGmN0aTpOQoqH64e6jUsPXskkV++Pu6oSHTI33RaH+WtxNFntupHGGfvHDNJ
 xguLfU+ldrBPBkrm9Ripk13l+YPAwN52A87sTQe2pgLfBJ5L9sCokxIJ19vR7xM2X4awcAx/lWU
 Ohp/qg17aFcum3w/fQ+g+uzPoU3u9z36yZmxIhheP/On4zCaGi3EGqW27qKiKeP0shybyVNcy8T
 85m3e6xfJ6jT/gQiTgQ==
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

Add support for HDMI PHY on Qualcomm MSM8974 / APQ8074 platforms.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c | 282 +++++++++++++++++++++++++++++
 1 file changed, 282 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c b/drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c
index 720757f8f393..7d398060b3a3 100644
--- a/drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c
+++ b/drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c
@@ -6,10 +6,13 @@
  * Author: Rob Clark <robdclark@gmail.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
+#include <linux/math64.h>
 
 #include "phy-qcom-hdmi-preqmp.h"
+#include "phy-qcom-uniphy.h"
 
 #define REG_HDMI_8x74_ANA_CFG0					0x00000000
 #define REG_HDMI_8x74_ANA_CFG1					0x00000004
@@ -31,8 +34,282 @@
 #define REG_HDMI_8x74_BIST_PATN3				0x00000048
 #define REG_HDMI_8x74_STATUS					0x0000005c
 
+#define HDMI_8974_VCO_MAX_FREQ 1800000000UL
+#define HDMI_8974_VCO_MIN_FREQ  600000000UL
+
+#define HDMI_8974_COMMON_DIV 5
+
+static inline void write16(u16 val, void __iomem *reg)
+{
+	writel(val & 0xff, reg);
+	writel(val >> 8, reg + 4);
+}
+
+static inline void write24(u32 val, void __iomem *reg)
+{
+	writel(val & 0xff, reg);
+	writel((val >> 8) & 0xff, reg + 4);
+	writel(val >> 16, reg + 8);
+}
+
+static inline u32 read24(void __iomem *reg)
+{
+	u32 val = readl(reg);
+
+	val |= readl(reg + 4) << 8;
+	val |= readl(reg + 8) << 16;
+
+	return val;
+}
+
+static void qcom_uniphy_setup(void __iomem *base, unsigned int ref_freq,
+			      bool sdm_mode,
+			      bool ref_freq_mult_2,
+			      bool dither,
+			      unsigned int refclk_div,
+			      unsigned int vco_freq)
+{
+	unsigned int int_ref_freq = ref_freq * (ref_freq_mult_2 ? 2 : 1);
+	unsigned int div_in_freq = vco_freq / refclk_div;
+	unsigned int dc_offset = div_in_freq / int_ref_freq - 1;
+	unsigned int sdm_freq_seed;
+	unsigned int val;
+	u64 tmp = div_in_freq % int_ref_freq;
+
+	tmp *= 0x10000;
+	sdm_freq_seed = div_u64(tmp, int_ref_freq);
+
+	val = FIELD_PREP(UNIPHY_PLL_REFCLK_DBLR, ref_freq_mult_2) |
+	      FIELD_PREP(UNIPHY_PLL_REFCLK_DIV, refclk_div - 1);
+	writel(val, base + UNIPHY_PLL_REFCLK_CFG);
+
+	if (sdm_mode) {
+		writel(0, base + UNIPHY_PLL_SDM_CFG0);
+		writel(FIELD_PREP(UNIPHY_PLL_SDM_DITHER_EN, dither) | dc_offset,
+		       base + UNIPHY_PLL_SDM_CFG1);
+		write24(sdm_freq_seed, base + UNIPHY_PLL_SDM_CFG2);
+	} else {
+		writel(UNIPHY_PLL_SDM_BYP | dc_offset, base + UNIPHY_PLL_SDM_CFG0);
+		writel(0, base + UNIPHY_PLL_SDM_CFG1);
+		write24(0, base + UNIPHY_PLL_SDM_CFG2);
+	}
+
+	write16(mult_frac(ref_freq, 5, 1000000), base + UNIPHY_PLL_CAL_CFG8);
+	write16(vco_freq / 16, base + UNIPHY_PLL_CAL_CFG10);
+}
+
+static unsigned long qcom_uniphy_recalc(void __iomem *base, unsigned long parent_rate)
+{
+	unsigned long rate;
+	u32 refclk_cfg;
+	u32 dc_offset;
+	u64 fraq_n;
+	u32 val;
+
+	refclk_cfg = readl(base + UNIPHY_PLL_REFCLK_CFG);
+	if (refclk_cfg & UNIPHY_PLL_REFCLK_DBLR)
+		parent_rate *= 2;
+
+	val = readl(base + UNIPHY_PLL_SDM_CFG0);
+	if (FIELD_GET(UNIPHY_PLL_SDM_BYP, val)) {
+		dc_offset = FIELD_GET(UNIPHY_PLL_SDM_BYP_DIV, val);
+		fraq_n = 0;
+	} else {
+		dc_offset = FIELD_GET(UNIPHY_PLL_SDM_DC_OFFSET,
+				      readl(base + UNIPHY_PLL_SDM_CFG1));
+		fraq_n = read24(base + UNIPHY_PLL_SDM_CFG2);
+	}
+
+	rate = (dc_offset + 1) * parent_rate;
+	rate += div_u64(fraq_n * parent_rate, 0x10000);
+
+	rate *= FIELD_GET(UNIPHY_PLL_REFCLK_DIV, refclk_cfg) + 1;
+
+	return rate;
+}
+
+static const unsigned int qcom_hdmi_8974_divs[] = {1, 2, 4, 6};
+
+static unsigned long qcom_hdmi_8974_pll_recalc_rate(struct clk_hw *hw,
+						    unsigned long parent_rate)
+{
+	struct qcom_hdmi_preqmp_phy *hdmi_phy = hw_clk_to_phy(hw);
+	u32 div_idx = readl(hdmi_phy->pll_reg + UNIPHY_PLL_POSTDIV1_CFG);
+	unsigned long rate = qcom_uniphy_recalc(hdmi_phy->pll_reg, parent_rate);
+
+	return rate / HDMI_8974_COMMON_DIV / qcom_hdmi_8974_divs[div_idx & 0x3];
+}
+
+static int qcom_hdmi_8974_pll_determine_rate(struct clk_hw *hw,
+					     struct clk_rate_request *req)
+{
+	unsigned long min_freq = HDMI_8974_VCO_MIN_FREQ / HDMI_8974_COMMON_DIV;
+	unsigned long max_freq = HDMI_8974_VCO_MAX_FREQ / HDMI_8974_COMMON_DIV;
+
+	req->rate = clamp(req->rate, min_freq / 6, max_freq);
+
+	return 0;
+}
+
+static const struct clk_ops qcom_hdmi_8974_pll_ops = {
+	.recalc_rate = qcom_hdmi_8974_pll_recalc_rate,
+	.determine_rate = qcom_hdmi_8974_pll_determine_rate,
+};
+
+static int qcom_hdmi_msm8974_phy_find_div(unsigned long long pixclk)
+{
+	unsigned long long min_freq = HDMI_8974_VCO_MIN_FREQ / HDMI_8974_COMMON_DIV;
+	int i;
+
+	if (pixclk > HDMI_8974_VCO_MAX_FREQ / HDMI_8974_COMMON_DIV)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(qcom_hdmi_8974_divs); i++) {
+		if (pixclk >= min_freq / qcom_hdmi_8974_divs[i])
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int qcom_hdmi_msm8974_phy_pll_set_rate(struct qcom_hdmi_preqmp_phy *hdmi_phy)
+{
+	unsigned long long pixclk = hdmi_phy->hdmi_opts.tmds_char_rate;
+	unsigned long vco_rate;
+	unsigned int div;
+	int div_idx = 0;
+
+	div_idx = qcom_hdmi_msm8974_phy_find_div(pixclk);
+	if (WARN_ON(div_idx < 0))
+		return div_idx;
+
+	div = qcom_hdmi_8974_divs[div_idx];
+	vco_rate = pixclk * HDMI_8974_COMMON_DIV * div;
+
+	writel(0x81, hdmi_phy->phy_reg + REG_HDMI_8x74_GLB_CFG);
+
+	writel(0x01, hdmi_phy->pll_reg + UNIPHY_PLL_GLB_CFG);
+	writel(0x19, hdmi_phy->pll_reg + UNIPHY_PLL_VCOLPF_CFG);
+	writel(0x0e, hdmi_phy->pll_reg + UNIPHY_PLL_LPFR_CFG);
+	writel(0x20, hdmi_phy->pll_reg + UNIPHY_PLL_LPFC1_CFG);
+	writel(0x0d, hdmi_phy->pll_reg + UNIPHY_PLL_LPFC2_CFG);
+
+	qcom_uniphy_setup(hdmi_phy->pll_reg, 19200000, true, true, true, 1, vco_rate);
+
+	writel(0x10, hdmi_phy->pll_reg + UNIPHY_PLL_LKDET_CFG0);
+	writel(0x1a, hdmi_phy->pll_reg + UNIPHY_PLL_LKDET_CFG1);
+	writel(0x05, hdmi_phy->pll_reg + UNIPHY_PLL_LKDET_CFG2);
+
+	writel(div_idx, hdmi_phy->pll_reg + UNIPHY_PLL_POSTDIV1_CFG);
+
+	writel(0x00, hdmi_phy->pll_reg + UNIPHY_PLL_POSTDIV2_CFG);
+	writel(0x00, hdmi_phy->pll_reg + UNIPHY_PLL_POSTDIV3_CFG);
+	writel(0x01, hdmi_phy->pll_reg + UNIPHY_PLL_CAL_CFG2);
+
+	writel(0x1f, hdmi_phy->phy_reg + REG_HDMI_8x74_PD_CTRL0);
+	udelay(50);
+
+	writel(0x0f, hdmi_phy->pll_reg + UNIPHY_PLL_GLB_CFG);
+
+	writel(0x00, hdmi_phy->phy_reg + REG_HDMI_8x74_PD_CTRL1);
+	writel(0x10, hdmi_phy->phy_reg + REG_HDMI_8x74_ANA_CFG2);
+	writel(0xdb, hdmi_phy->phy_reg + REG_HDMI_8x74_ANA_CFG0);
+	writel(0x43, hdmi_phy->phy_reg + REG_HDMI_8x74_ANA_CFG1);
+	if (pixclk == 297000000) {
+		writel(0x06, hdmi_phy->phy_reg + REG_HDMI_8x74_ANA_CFG2);
+		writel(0x03, hdmi_phy->phy_reg + REG_HDMI_8x74_ANA_CFG3);
+	} else if (pixclk == 268500000) {
+		writel(0x05, hdmi_phy->phy_reg + REG_HDMI_8x74_ANA_CFG2);
+		writel(0x00, hdmi_phy->phy_reg + REG_HDMI_8x74_ANA_CFG3);
+	} else {
+		writel(0x02, hdmi_phy->phy_reg + REG_HDMI_8x74_ANA_CFG2);
+		writel(0x00, hdmi_phy->phy_reg + REG_HDMI_8x74_ANA_CFG3);
+	}
+
+	writel(0x04, hdmi_phy->pll_reg + UNIPHY_PLL_VREG_CFG);
+
+	writel(0xd0, hdmi_phy->phy_reg + REG_HDMI_8x74_DCC_CFG0);
+	writel(0x1a, hdmi_phy->phy_reg + REG_HDMI_8x74_DCC_CFG1);
+	writel(0x00, hdmi_phy->phy_reg + REG_HDMI_8x74_TXCAL_CFG0);
+	writel(0x00, hdmi_phy->phy_reg + REG_HDMI_8x74_TXCAL_CFG1);
+
+	if (pixclk == 268500000)
+		writel(0x11, hdmi_phy->phy_reg + REG_HDMI_8x74_TXCAL_CFG2);
+	else
+		writel(0x02, hdmi_phy->phy_reg + REG_HDMI_8x74_TXCAL_CFG2);
+
+	writel(0x05, hdmi_phy->phy_reg + REG_HDMI_8x74_TXCAL_CFG3);
+	udelay(200);
+
+	return 0;
+}
+
+static int qcom_hdmi_msm8974_phy_pll_enable(struct qcom_hdmi_preqmp_phy *hdmi_phy)
+{
+	int ret;
+	unsigned long status;
+
+	/* Global enable */
+	writel(0x81, hdmi_phy->phy_reg + REG_HDMI_8x74_GLB_CFG);
+
+	/* Power up power gen */
+	writel(0x00, hdmi_phy->phy_reg + REG_HDMI_8x74_PD_CTRL0);
+	udelay(350);
+
+	/* PLL power up */
+	writel(0x01, hdmi_phy->pll_reg + UNIPHY_PLL_GLB_CFG);
+	udelay(5);
+
+	/* Power up PLL LDO */
+	writel(0x03, hdmi_phy->pll_reg + UNIPHY_PLL_GLB_CFG);
+	udelay(350);
+
+	/* PLL power up */
+	writel(0x0f, hdmi_phy->pll_reg + UNIPHY_PLL_GLB_CFG);
+	udelay(350);
+
+	/* Poll for PLL ready status */
+	ret = readl_poll_timeout(hdmi_phy->pll_reg + UNIPHY_PLL_STATUS,
+				 status, status & UNIPHY_PLL_LOCK,
+				 100, 2000);
+	if (ret) {
+		dev_warn(hdmi_phy->dev, "HDMI PLL not ready\n");
+		goto err;
+	}
+
+	udelay(350);
+
+	/* Poll for PHY ready status */
+	ret = readl_poll_timeout(hdmi_phy->phy_reg + REG_HDMI_8x74_STATUS,
+				 status, status & BIT(0),
+				 100, 2000);
+	if (ret) {
+		dev_warn(hdmi_phy->dev, "HDMI PHY not ready\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	writel(0, hdmi_phy->pll_reg + UNIPHY_PLL_GLB_CFG);
+	udelay(5);
+	writel(0, hdmi_phy->phy_reg + REG_HDMI_8x74_GLB_CFG);
+
+	return ret;
+}
+
 static int qcom_hdmi_msm8974_phy_power_on(struct qcom_hdmi_preqmp_phy *hdmi_phy)
 {
+	int ret;
+
+	ret = qcom_hdmi_msm8974_phy_pll_set_rate(hdmi_phy);
+	if (ret)
+		return ret;
+
+	ret = qcom_hdmi_msm8974_phy_pll_enable(hdmi_phy);
+	if (ret)
+		return ret;
+
 	writel(0x1b, hdmi_phy->phy_reg + REG_HDMI_8x74_ANA_CFG0);
 	writel(0xf2, hdmi_phy->phy_reg + REG_HDMI_8x74_ANA_CFG1);
 	writel(0x00, hdmi_phy->phy_reg + REG_HDMI_8x74_BIST_CFG0);
@@ -49,6 +326,10 @@ static int qcom_hdmi_msm8974_phy_power_off(struct qcom_hdmi_preqmp_phy *hdmi_phy
 {
 	writel(0x7f, hdmi_phy->phy_reg + REG_HDMI_8x74_PD_CTRL0);
 
+	writel(0, hdmi_phy->pll_reg + UNIPHY_PLL_GLB_CFG);
+	udelay(5);
+	writel(0, hdmi_phy->phy_reg + REG_HDMI_8x74_GLB_CFG);
+
 	return 0;
 }
 
@@ -67,5 +348,6 @@ const struct qcom_hdmi_preqmp_cfg msm8974_hdmi_phy_cfg = {
 	.power_on = qcom_hdmi_msm8974_phy_power_on,
 	.power_off = qcom_hdmi_msm8974_phy_power_off,
 
+	.pll_ops = &qcom_hdmi_8974_pll_ops,
 	.pll_parent = &msm8974_hdmi_pll_parent,
 };

-- 
2.47.3

