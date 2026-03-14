Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEF0107BCF1
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 05:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DECD10E0DE;
	Sat, 14 Mar 2026 05:06:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ApPprGA+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VVwCNvqz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E1610E22A
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 05:06:47 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62E3fxBd2919969
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 05:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k0wsfNvWullGvEtYT97Wok/Se0mUDLSlsRYhXG/S0Kc=; b=ApPprGA+1AANOoGW
 XPF8DjvGPzIIlJvJ/BHY2m1nCJ6I2N0UxXh2IwR9C9PDqU33D8oOd4i1yzsTKrm8
 1+NcU9r07FB0Adqo9de7WpEEb6gaJfr/3GjStcl58wU5GtPNl0Awa/gZy5idLIuY
 81E/0v+iX+piCSunBqdzthZBPJiPJgqRPBQR15y4y9doZecYneVsRkiZKNZpfKvS
 cpgE7ybQozThndHI8S4huKON15vyFQg58HG6wctwpbuBSGBM8VNHRn+Bf7VDSLK7
 f7msH7LCY4Cj7wa0xhtFfs5kTgJ9B7iqa6kNNFwOEbMwa06QG5NlV5QyAyKb7ZjV
 cpc6JA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw00b84at-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 05:06:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd84943c76so2675865385a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 22:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773464805; x=1774069605;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k0wsfNvWullGvEtYT97Wok/Se0mUDLSlsRYhXG/S0Kc=;
 b=VVwCNvqzg9RJEy41pZsvLjiKOmK1BCF3x3RlmUTnpETi0c0tS+s2S9IGrOBrTOFU3u
 2pnosKL6xMSYg5id6iZX/mR9p96Yd7Pty4gyZHNFkAQaTOfNcKl+f8Uuuex+Tp/hX2uw
 TLCtSkrRiwdm9GVIz4Gx2zrl8FNQ+eY2PAXqUTnK0bCGd4SpL35D+6OjLssTbn1FEajN
 UWBYzZxhfkBoReaCb/QguESnH45dFFQ/wiu97mXH+1of9trZaZ9L/4M4jHQCX2F6Vyoy
 /kKrHBrA2nxP/zRR3nY4Hw/qRqcfmnrfoJnCoy9Wpy+51UtUYtPEeih7oZ9QUt+114oE
 1RuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773464805; x=1774069605;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k0wsfNvWullGvEtYT97Wok/Se0mUDLSlsRYhXG/S0Kc=;
 b=ZWbDjG+nYxo0KF/k0Hkll7bJy9WwPnb0oQQnh91Y5j5W0uxTyhVpPtJrV3b4snVbvw
 V1x6M0jD0bAlbuelTA9xCZuOLKFg06Zl9p05aMCVr9I5E4emqa4JFyZJEiE7+QTgWGCD
 sunaUtYv/XH5YSyutqZK6YsWVtxlH0D0DBXranLcNpyX5Me0ntvc9eAw66sAnfNn3Tkp
 8Zcut4O/+QJw3lGn95/2GHiiVFn1mkNukSbbHERgCsdM4amgDy5KUFj3Mj4FpvtH2vEl
 JHvrGcp8cofzeQORRAVCsriPOm+j3Pl9CunvYPMVzsh/mGc73WNaVJuq/QMdBOBuXkZJ
 1/kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEOs2ZJLL17NdISnq9Bh7QxMQT8PV1lpATz/qeFugNIyOAdzJGd6MWbWLZ6jOWBUs7/GANjNI/jjo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/YsdaA4ACdtIb/o+mm01spF+XL402quKv1JniPnfjxVcLEKBh
 UANsLGD3PmzMF7iP0DnZ4vIkdC4oW/K9L6DMoWtLyYELPL6/KGNSgM78XoDhMWhnNgTyBWz7lBS
 G0PKmLz/O7DE2yR09BetxpHvRgCIcYtCMr3ZT1Awp2EJeuXsINYF94pghs9hKWc9W6A9RbuPqiW
 vvqHg=
X-Gm-Gg: ATEYQzy+6mIa1lNu25okAfMbjKc9tSvpem+F4QexpE1gqVYNYrjo4Raz7AkJqM72ZTU
 nAAmbhmr6VCld9Ojte8xLLzDFJyUQfIyzcBZhV/za3P5dijF66AMZ7HwxN8kliLbo7RZNZW/2y1
 l41Q/b7STDuRKpIa9iJH65lh2Z3VyRJ6E5SwG89zSl7NBjdxOX5K+zgmJl4LLDdeN6JJQBtaF35
 qsy0FchNEG1IiuCcauTBJ/JT4QjW0+LXIIDBxhBBENaNdxe9cfBL/zv6m6vZotgywrzvNAZchsZ
 AwJMh6rr4/Gp2iw71RRCF+WyUwojJJyJhn6W1wfIIDUR1IbKybdjHa/TH1tPER7kumIvpnUJbKR
 rFptTMXgHAgTHKUg1ARO05j8Sm2/n1kUy2t85d+jwfCVi6HVlZa7kq+Vit/b2kwRVVdt4ZgESzm
 WRCMz782ksi91ixr2dwlicbg8knt8GGv7qBC0=
X-Received: by 2002:a05:620a:4414:b0:8cd:8c3f:af1 with SMTP id
 af79cd13be357-8cdaa77964emr1148070785a.1.1773464805081; 
 Fri, 13 Mar 2026 22:06:45 -0700 (PDT)
X-Received: by 2002:a05:620a:4414:b0:8cd:8c3f:af1 with SMTP id
 af79cd13be357-8cdaa77964emr1148069585a.1.1773464804597; 
 Fri, 13 Mar 2026 22:06:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a15636206bsm1982771e87.67.2026.03.13.22.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 22:06:43 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 14 Mar 2026 07:06:22 +0200
Subject: [PATCH v5 4/4] phy: qualcomm: add MSM8974 HDMI PHY support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-fd-hdmi-phy-v5-4-58122ae96d3b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9463;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZRPRqgvYw64QGMW7xBPkq82I8+tZLQkRVuWBLftjJNo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBptOzV1oVV6AyCMnWCfFL76I6IzQwE9PqeuUu4+
 tqvx7SsZxiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabTs1QAKCRCLPIo+Aiko
 1YdQB/9s8lSolfCCqIRM68wWBqmcl/telYcEzjH0lseDDIpQRt44XsAQbMtH/QD0nYCWhkzpJ+i
 X1m//5Xd/ApbufumDQqAXtUn5yg1HzwcCUl3sqzO9jSJlKW855F9NiETyN0nhycfdfPnTd5c5ra
 k8ZcnyJ6xB8GSIV2IBBAh3xHaYkD3NR46cncotmSSlTqk6xOOu/XP9j1pXrQbzbxETRxWFVyHiy
 PbCPfZr8gk8Q6L5yQJR8cWFCq0RGayn+XFU0WtVuwKgBcYFxCayXzuXSg6SfotieOCkDPnz+CoK
 kFJ66GzELgPRYelkpvNiIg+ePvjNi/jCYY0NEhjj3TgbZCQf
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=IsATsb/g c=1 sm=1 tr=0 ts=69b4ece6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=wq9x00DRF7jIeu_RijoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAzNyBTYWx0ZWRfX/C3Lw2G2f46L
 aHqKqhuDyuFIcG5FozJCvQAWZ/GUC4nd+51fMXnimy9fmRwosTBitu170Vcpfv+U7S1kPpTE5Lp
 fFshDoxtubLVaMkT59XGG6IeJjtqrjtPumPg4MMzWx547VUnqPhyukIB0XoN7BaawQoefpXpji+
 Iy6722WaTfydw9cXEILVSMSgmMZWF5wMnTqL5m33cuxDYKcq+7yfSvSyBjUFNQFxB559/L/VyZO
 Xvl3LIA9qjJWR15ZjXv73wayzOereHLcQ/ok34eMmHlJy8B3e5H4KwWeD2BeCRNr/v7ywZO+bnJ
 k6ndbJq7N8EWg48r4TYyZuZn02ymwzOYs8CQDLBpIqC7DfXuKoH+dDbZ8SuriZbBkFf1PA+YTYt
 VLCEwY2q5v3/AGZsk/qc6VThR8Fko6aewjkayYFsc+1OTdoE16FOgTMY4IssBLm2z20VOSanOkz
 tepdhoSRXsW7maCgOgA==
X-Proofpoint-GUID: zb_BFFPwKnpqTL5c1HB0Nf7RSeORjwUa
X-Proofpoint-ORIG-GUID: zb_BFFPwKnpqTL5c1HB0Nf7RSeORjwUa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015
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

Add support for HDMI PHY on Qualcomm MSM8974 / APQ8074 platforms.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c | 261 +++++++++++++++++++++++++++++
 1 file changed, 261 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c b/drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c
index db7fa2df1a36..8f2bb846a93a 100644
--- a/drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c
+++ b/drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c
@@ -10,6 +10,7 @@
 #include <linux/iopoll.h>
 
 #include "phy-qcom-hdmi-preqmp.h"
+#include "phy-qcom-uniphy.h"
 
 #define REG_HDMI_8x74_ANA_CFG0					0x00000000
 #define REG_HDMI_8x74_ANA_CFG1					0x00000004
@@ -31,8 +32,263 @@
 #define REG_HDMI_8x74_BIST_PATN3				0x00000048
 #define REG_HDMI_8x74_STATUS					0x0000005c
 
+#define HDMI_8974_VCO_MAX_FREQ 1800000000UL
+#define HDMI_8974_VCO_MIN_FREQ  600000000UL
+
+#define HDMI_8974_COMMON_DIV 5
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
+	val = (ref_freq_mult_2 ? BIT(0) : 0) |
+		((refclk_div - 1) << 2);
+	writel(val, base + UNIPHY_PLL_REFCLK_CFG);
+
+	writel(sdm_mode ? 0 : 0x40 + dc_offset, base + UNIPHY_PLL_SDM_CFG0);
+
+	writel(dither ? 0x40 + dc_offset : 0, base + UNIPHY_PLL_SDM_CFG1);
+
+	writel(sdm_freq_seed & 0xff, base + UNIPHY_PLL_SDM_CFG2);
+
+	writel((sdm_freq_seed >> 8) & 0xff, base + UNIPHY_PLL_SDM_CFG3);
+
+	writel(sdm_freq_seed >> 16, base + UNIPHY_PLL_SDM_CFG4);
+
+	ref_freq = ref_freq * 5 / 1000;
+	writel(ref_freq & 0xff, base + UNIPHY_PLL_CAL_CFG8);
+
+	writel(ref_freq >> 8, base + UNIPHY_PLL_CAL_CFG9);
+
+	vco_freq /= 1000;
+	writel(vco_freq & 0xff, base + UNIPHY_PLL_CAL_CFG10);
+
+	writel(vco_freq >> 8, base + UNIPHY_PLL_CAL_CFG11);
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
+	if (refclk_cfg & BIT(0))
+		parent_rate *= 2;
+
+	val = readl(base + UNIPHY_PLL_SDM_CFG0);
+	if (val & 0x40) {
+		dc_offset = val & 0x3f;
+		fraq_n = 0;
+	} else {
+		dc_offset = readl(base + UNIPHY_PLL_SDM_CFG1) & 0x3f;
+		fraq_n = readl(base + UNIPHY_PLL_SDM_CFG2) |
+			(readl(base + UNIPHY_PLL_SDM_CFG3) << 8);
+	}
+
+	rate = (dc_offset + 1) * parent_rate;
+	rate += mult_frac(fraq_n, parent_rate, 0x10000);
+
+	rate *= (refclk_cfg >> 2) * 0x3 + 1;
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
+	u32 div_idx = hdmi_pll_read(hdmi_phy, UNIPHY_PLL_POSTDIV1_CFG);
+	unsigned long rate = qcom_uniphy_recalc(hdmi_phy->pll_reg, parent_rate);
+
+	return  rate / HDMI_8974_COMMON_DIV / qcom_hdmi_8974_divs[div_idx & 0x3];
+}
+
+static int qcom_hdmi_8974_pll_determine_rate(struct clk_hw *hw,
+					     struct clk_rate_request *req)
+{
+	req->rate = clamp(req->rate,
+			  HDMI_8974_VCO_MIN_FREQ / HDMI_8974_COMMON_DIV / 6,
+			  HDMI_8974_VCO_MAX_FREQ / HDMI_8974_COMMON_DIV / 1);
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
+	int i;
+	unsigned long long min_freq = HDMI_8974_VCO_MIN_FREQ / HDMI_8974_COMMON_DIV;
+
+	if (pixclk > HDMI_8974_VCO_MAX_FREQ / HDMI_8974_COMMON_DIV)
+		return -E2BIG;
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
+	hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_GLB_CFG, 0x81);
+
+	hdmi_pll_write(hdmi_phy, UNIPHY_PLL_GLB_CFG, 0x01);
+	hdmi_pll_write(hdmi_phy, UNIPHY_PLL_VCOLPF_CFG, 0x19);
+	hdmi_pll_write(hdmi_phy, UNIPHY_PLL_LPFR_CFG, 0x0e);
+	hdmi_pll_write(hdmi_phy, UNIPHY_PLL_LPFC1_CFG, 0x20);
+	hdmi_pll_write(hdmi_phy, UNIPHY_PLL_LPFC2_CFG, 0x0d);
+
+	qcom_uniphy_setup(hdmi_phy->pll_reg, 19200000, true, true, true, 1, vco_rate);
+
+	hdmi_pll_write(hdmi_phy, UNIPHY_PLL_LKDET_CFG0, 0x10);
+	hdmi_pll_write(hdmi_phy, UNIPHY_PLL_LKDET_CFG1, 0x1a);
+	hdmi_pll_write(hdmi_phy, UNIPHY_PLL_LKDET_CFG2, 0x05);
+
+	hdmi_pll_write(hdmi_phy, UNIPHY_PLL_POSTDIV1_CFG, div_idx);
+
+	hdmi_pll_write(hdmi_phy, UNIPHY_PLL_POSTDIV2_CFG, 0x00);
+	hdmi_pll_write(hdmi_phy, UNIPHY_PLL_POSTDIV3_CFG, 0x00);
+	hdmi_pll_write(hdmi_phy, UNIPHY_PLL_CAL_CFG2, 0x01);
+
+	hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_PD_CTRL0, 0x1f);
+	udelay(50);
+
+	hdmi_pll_write(hdmi_phy, UNIPHY_PLL_GLB_CFG, 0x0f);
+
+	hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_PD_CTRL1, 0x00);
+	hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_ANA_CFG2, 0x10);
+	hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_ANA_CFG0, 0xdb);
+	hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_ANA_CFG1, 0x43);
+	if (pixclk == 297000) {
+		hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_ANA_CFG2, 0x06);
+		hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_ANA_CFG3, 0x03);
+	} else if (pixclk == 268500) {
+		hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_ANA_CFG2, 0x05);
+		hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_ANA_CFG3, 0x00);
+	} else {
+		hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_ANA_CFG2, 0x02);
+		hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_ANA_CFG3, 0x00);
+	}
+
+	hdmi_pll_write(hdmi_phy, UNIPHY_PLL_VREG_CFG, 0x04);
+
+	hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_DCC_CFG0, 0xd0);
+	hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_DCC_CFG1, 0x1a);
+	hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_TXCAL_CFG0, 0x00);
+	hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_TXCAL_CFG1, 0x00);
+
+	if (pixclk == 268500)
+		hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_TXCAL_CFG2, 0x11);
+	else
+		hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_TXCAL_CFG2, 0x02);
+
+	hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_TXCAL_CFG3, 0x05);
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
+	hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_GLB_CFG, 0x81);
+
+	/* Power up power gen */
+	hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_PD_CTRL0, 0x00);
+	udelay(350);
+
+	/* PLL power up */
+	hdmi_pll_write(hdmi_phy, UNIPHY_PLL_GLB_CFG, 0x01);
+	udelay(5);
+
+	/* Power up PLL LDO */
+	hdmi_pll_write(hdmi_phy, UNIPHY_PLL_GLB_CFG, 0x03);
+	udelay(350);
+
+	/* PLL power up */
+	hdmi_pll_write(hdmi_phy, UNIPHY_PLL_GLB_CFG, 0x0f);
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
+	hdmi_pll_write(hdmi_phy, UNIPHY_PLL_GLB_CFG, 0);
+	udelay(5);
+	hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_GLB_CFG, 0);
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
 	hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_ANA_CFG0,   0x1b);
 	hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_ANA_CFG1,   0xf2);
 	hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_BIST_CFG0,  0x0);
@@ -49,6 +305,10 @@ static int qcom_hdmi_msm8974_phy_power_off(struct qcom_hdmi_preqmp_phy *hdmi_phy
 {
 	hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_PD_CTRL0, 0x7f);
 
+	hdmi_pll_write(hdmi_phy, UNIPHY_PLL_GLB_CFG, 0);
+	udelay(5);
+	hdmi_phy_write(hdmi_phy, REG_HDMI_8x74_GLB_CFG, 0);
+
 	return 0;
 }
 
@@ -67,5 +327,6 @@ const struct qcom_hdmi_preqmp_cfg msm8974_hdmi_phy_cfg = {
 	.power_on = qcom_hdmi_msm8974_phy_power_on,
 	.power_off = qcom_hdmi_msm8974_phy_power_off,
 
+	.pll_ops = &qcom_hdmi_8974_pll_ops,
 	.pll_parent = &msm8974_hdmi_pll_parent,
 };

-- 
2.47.3

