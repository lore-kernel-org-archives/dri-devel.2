Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A749CF4613F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 140FD10E4EF;
	Mon, 23 Mar 2026 22:57:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="g31sc3Eh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ULK+0mgg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14CE910E548
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 22:57:00 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHrDAs618994
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 22:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QTdfC4nGBF2mKs0lzPAEtgSSWOxV9yn6Q30CnsG8EJA=; b=g31sc3Eh5Qa1BTZc
 3SDn/nV86q4BqB7G9Ma2LsaVEVsgDrpeMW2zODduE2nSg2y8tvd4Bwpl4K5rI+6L
 UR1eOA5YOZwx82/OAYdDi32G1IAw+xu34vTaKDaLCrgqqUo2A+jEKFRxOcrirh7K
 4dK515InqFQCD1vHQddgiehWq90cssVODHs7QQJCUz2TlxW+tWD8YjpGknD8ZDkO
 nUw98YOhTmyF9zWBb7hlv5ZkszvKzrjeSxNvbC0AA1569vohKJtZFppEnSP3QTta
 wA8rKqCYXghm9k6rbw+TtcQFVjXaPA1LRNN0sfUnp8B714lttnG6IPYr6iDgPHMB
 MQ+cHA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31jgk1t1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 22:56:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5091327215dso187703291cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 15:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774306618; x=1774911418;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QTdfC4nGBF2mKs0lzPAEtgSSWOxV9yn6Q30CnsG8EJA=;
 b=ULK+0mgg6FePFdMHoN54Nni1aRFv05LEIcfehlJ9CagXG1K2Des7yKLbogZdzBR5QO
 8fkY9IOCZ0c/ZN8DXArM2jQ6+uOMV4TufOMdPTBaugr3Gyl3Vor6glTekwGNzbcRa692
 885KXnPigfoOAMzv4ro7KU9ga1xD9BgMNmDk8ZOOueGstEKC7RIbgI2jWKEVldttcxIN
 46T3lHDzqBT1NmRCTJniyDSnZhVZRiG7KMA4MYJxq5wFcymsZ+Jtw2F5om20agZDOqq7
 fzKSg2yAUXtG3+Q1FMrxn8QsLad+g7783tGSIJAhSaNhhejbhFZJr1utWQUmPO8MjHRm
 DUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774306618; x=1774911418;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QTdfC4nGBF2mKs0lzPAEtgSSWOxV9yn6Q30CnsG8EJA=;
 b=LqaIIc9IpfVEkmaOwIxEEkb4gL8Lxuyp61cKXRso7hLchRZiHMB9OjN+UeidZ3KT2G
 RnBFxvhVeQK71K2Gx5eJFW8wkUphN2jeN293nbvRqtvC7RecIrsVuXIdqTpPjQRaql6A
 FnpoSWn6ML7GcN02nQCurEgPPxexHLMsNfHBc+tDUgSIw8a3gqLtV26IZqtZuwGt/pBI
 nu1ijUXge63tFkVfRdq1NWZSGA8rLWP0XUSi/K7HopXVRZ+UTLXY7fRIvX8cLlYgyePZ
 rG3avCy1Dtq6lbZdRQh4X0BY0qyYCqkZevKK+xl/fGRdzAeRmZMKipuux+0qNMI6iWNO
 xHuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ0hPw5XfNwnNRV4o0gEYN7dAqBZn+G7uvHxAPeDyTwN/zYtzWkiEeRHhFsbFRdacyviZ5M4fO2r8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGrvrbtI+iUF4Mmaq8bco/vpXAYgcLXAnwZDkhowi7UNz516m1
 sBHhEfFZwtTgyDhMT0mBP6RQQqLtdf5IAtokVwOS2576VkkfFk7pYzAM7+S00Q0Ebgco4+eeav7
 NC2pTBfHq3tjyAy5MYzj1pjLJnthKTNpPMDhMfkXQMOjUypmG3evv2G2tU+T5JsuwAfL68ls=
X-Gm-Gg: ATEYQzxvJLXcbhFCIETarhIRldIfgTqksnuq7KcrKZ67jUx4LMDZDQEmkN4sKK6P/cC
 frPUp8T+qTyAHdcsLeRV9naqiZ9sE6kv+BYzEUkRHFogxxWdf9hA7vAlMHlxdGTcry1tLTco66v
 WRtnzbdBAQ6QgDS1MRbPkFhyO92jekCuwTfZYT6JqbmCyhn1gjmfNXza3x5Mj5ySSmUrRTYgQIL
 J76Qq4F6oNqIjtVRoJtKZRL0fA1UX1/oVMjFBp/sVBEibyVAMpTdWLKY7GdSC6NBSfHN8pnIHqs
 MhLHVMSyuXxd6flGovdQiP4DhwC6frnPlemc08VTxaGvRi8cKcDBnEUVgdTZ+rHmUAiFuY/x7Jk
 N9JxdSBMX0WIO7/tFZoIw9ssBS61r1yThc/x7CkXFbdDUBBfSUMPoubzLv9zIjTYZpOOm7ddr8v
 Io61AD0M6dMy9F4J9oLcnsvRHUQrN/pswjd4c=
X-Received: by 2002:a05:622a:1f13:b0:50b:49d4:e54 with SMTP id
 d75a77b69052e-50b49d41096mr139663061cf.15.1774306618372; 
 Mon, 23 Mar 2026 15:56:58 -0700 (PDT)
X-Received: by 2002:a05:622a:1f13:b0:50b:49d4:e54 with SMTP id
 d75a77b69052e-50b49d41096mr139662771cf.15.1774306617951; 
 Mon, 23 Mar 2026 15:56:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2963fa304sm156489e87.27.2026.03.23.15.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 15:56:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 00:56:37 +0200
Subject: [PATCH v7 4/4] phy: qualcomm: add MSM8974 HDMI PHY support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-fd-hdmi-phy-v7-4-b41dde8d83b8@oss.qualcomm.com>
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
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10286;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=aH8HvhrBKlUwZlE1dew356KH3tu53xTzXh1q4gq4OLQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpwcUn8holeR+IM4FJk7NwU4JxiMOFrLi24SVZ/
 Dyj+XSTFLSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacHFJwAKCRCLPIo+Aiko
 1ekvCACAJS7NoHWtUcz2I33dfLqhy+ktUzKaia8lVwHeccG1DM53VKFLFbrCF6ve6RagidoUxI+
 uKqQu/v5ul6KLqfndQHay8wcVZXtd566KuSjVvM9LyfI2ynnr5JeFmpdUvO2EIdGYiI/7xOopgz
 iouP78g61imyQGnCCF7guIVwqeY7vmBVG+w0qnXGSwgdvNfm9xvtyZupytLj4QE1+FU8FoOp5lw
 8yqabuqnCy5FQlR0a7erI0QiV76fAjuBdLAO4tCAoTS75vquSaGl07wx26eLXSaZ1e+fJ4gGFBb
 G2VkfbNkVBRsU0P/6WrtSOT64jBvHOvOzOyf2cZLjWAgCqoy
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 570IQW868e_4xRBUAHBAFrueOkJBKsgL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2OSBTYWx0ZWRfXztGJvUVkDcVV
 lKIh/a5qcMqbhU4leLlQsHBBj7iwv2v7oroj24gcCeRta8C6iUStly/hQgqZzu8rUqGKprjVWni
 eLQ14nGj2flJFHTe0nKjOji/9yVw3MwFxPU1J90lcm48oV+24V1lU2WjVeXHq61mMHvRm5RduhJ
 3DPkpGOmG0e3tnsNwe+vWlS5MlNkKzvoW04j1dJOf5GrxSSErGtlanbkEEbNYZFVa7ms8pGIAhp
 9pERqUeHlQjZOJdYFEp3idx61ZKgA9+Hqll8pI5sjkpaX4Ky6IlhZBJKuekIO9c8CeXsE9aLAY4
 EPLxbNSCZGtXhHsnq4aaLQSw5Up16xfp3D8t8UwQPNMrKdD3jz3S02kAOyW7n7T/bvctyPGBRIC
 s++/26cT6l+BGC305ji4t7/1Wru/+LTepSp3+yB6mudkMjr1fBsNVAcKPjv0SJO0vOZhcYaO53y
 dAJ8XlhACoh2kmIxfLQ==
X-Authority-Analysis: v=2.4 cv=CMInnBrD c=1 sm=1 tr=0 ts=69c1c53b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=wq9x00DRF7jIeu_RijoA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 570IQW868e_4xRBUAHBAFrueOkJBKsgL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230169
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
 drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c | 281 +++++++++++++++++++++++++++++
 1 file changed, 281 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c b/drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c
index 720757f8f393..a1a73586be53 100644
--- a/drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c
+++ b/drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c
@@ -6,10 +6,12 @@
  * Author: Rob Clark <robdclark@gmail.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 
 #include "phy-qcom-hdmi-preqmp.h"
+#include "phy-qcom-uniphy.h"
 
 #define REG_HDMI_8x74_ANA_CFG0					0x00000000
 #define REG_HDMI_8x74_ANA_CFG1					0x00000004
@@ -31,8 +33,282 @@
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
+	unsigned int remain = div_in_freq - (dc_offset + 1) * int_ref_freq;
+
+	sdm_freq_seed = mult_frac(remain, 0x10000, int_ref_freq);
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
+	write16(mult_frac(ref_freq, 5, 1000), base + UNIPHY_PLL_CAL_CFG8);
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
+	rate += mult_frac(fraq_n, parent_rate, 0x10000);
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
+	writel(div_idx,
+	       hdmi_phy->pll_reg + UNIPHY_PLL_POSTDIV1_CFG);
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
+	if (pixclk == 297000) {
+		writel(0x06, hdmi_phy->phy_reg + REG_HDMI_8x74_ANA_CFG2);
+		writel(0x03, hdmi_phy->phy_reg + REG_HDMI_8x74_ANA_CFG3);
+	} else if (pixclk == 268500) {
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
+	if (pixclk == 268500)
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
+				 status, status & BIT(0),
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
@@ -49,6 +325,10 @@ static int qcom_hdmi_msm8974_phy_power_off(struct qcom_hdmi_preqmp_phy *hdmi_phy
 {
 	writel(0x7f, hdmi_phy->phy_reg + REG_HDMI_8x74_PD_CTRL0);
 
+	writel(0, hdmi_phy->pll_reg + UNIPHY_PLL_GLB_CFG);
+	udelay(5);
+	writel(0, hdmi_phy->phy_reg + REG_HDMI_8x74_GLB_CFG);
+
 	return 0;
 }
 
@@ -67,5 +347,6 @@ const struct qcom_hdmi_preqmp_cfg msm8974_hdmi_phy_cfg = {
 	.power_on = qcom_hdmi_msm8974_phy_power_on,
 	.power_off = qcom_hdmi_msm8974_phy_power_off,
 
+	.pll_ops = &qcom_hdmi_8974_pll_ops,
 	.pll_parent = &msm8974_hdmi_pll_parent,
 };

-- 
2.47.3

