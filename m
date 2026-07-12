Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775A4C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 11:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAEFA10E445;
	Sun, 12 Jul 2026 11:57:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z5NjY4Eb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gaxTtNZ2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 306BA10E42F
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:57:00 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CAcfiZ2402980
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=huU8utG17jHPI85uM7nl2i
 PO7/oF6BiBvt9ImUQQN6g=; b=Z5NjY4Ebe5/VWORioRXxnFGpeTLGawJSC7lUTu
 wokVVC1SfwEHzKRMA31QOhdR6m0rDAD0eK/0ta7/w0thC3hevxFuIXvZvKmXVqhd
 0lVU6YdLh6Z+cCiXoaiwgXdyQtOpgXIdDXCCpSp6jpkoyk035xWzw/v0f+4xu5Xy
 V2Sr44CQB03hNiAgaCVhGU1xoRYZw0PGdb7B3My+Hxb3UoP7/kkzEx7LIJ2/e5TN
 ZTynpyolQLbtkX/TqWPfEu5DWAv5UEewuEbgccEsC/xZfb4FxE+qZkPKNFklabay
 av6TvstVnE1UVm+mMqh6qKspTwPxv0BbDZ2dNwuS5SkqiFRg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe9hjrad-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:56:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e68cb7a3eso424185985a.2
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 04:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783857418; x=1784462218;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=huU8utG17jHPI85uM7nl2iPO7/oF6BiBvt9ImUQQN6g=;
 b=gaxTtNZ22jlmW2Z0+CMukNxkXqhtyOny3cuj9GNnstwjrMP3O6Nt/r8YxWIgjMhXf+
 sNlmFumCjE4ZfohLswXYuLrSjs8PgXExaOJ0rl3xxYlEsB4y44QNqeXVZOCP+1ZVyG0T
 XnwmoLarQZ6uqpmISlY+93hGsacqZuE2BKhi2DYXKJd1bWpCj4x3/pVpuaEQoT88OMgY
 2Be0DXIMCfMkwxUF5V2U6eM9EfmRuHMIRtaOuLEXwWU4llrPoxwsn3WVI06FmfmiCP/f
 CO0dP36SW5OBrsRCwoDYukLwR+IWlCHjc11mlHXE1btKQseMDw/drZZm5xPzeRQuDWbL
 aWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783857418; x=1784462218;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=huU8utG17jHPI85uM7nl2iPO7/oF6BiBvt9ImUQQN6g=;
 b=KkezhUUgI4+uR5cKVCnHnQG/eeXRQKvRHCDWta/JI2VJKKK14z3AicMFXpa2mqE7iL
 dDQvI6W6KTsAY8N57MQceJetrZeaA0rV4HPsdEo9lLJNbbiW6iS9kpVBIgvotE99EYn3
 XZUSI7W46JZpCehJ6swY40GZ0ELF/BcsGkDBLTX+zhYrlxVEbRl3hNH7396x0FOQTGqw
 L5J819t0uwsm9gO6ygyxAoCRs+IrW/rrs4nMGMUszbPUAAbN+bQcObwPnGJMJfiDq9re
 qDqSWtLCx8PhbvR39ri1jsh2qOcOeOccUInsi/ji0aU3/Oi4YeRibXj+8ZpZo/ObRwau
 4rjg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrIUcg++XoJdfgymejidISqvt5GZD84ExLCNxdpg+DNa83eE8lbCpu/dMxsjiEdQOsXlsoEH3Ob194=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywxnl7tXEgctarGPdN8m0hkvlddgMCtP2W9lg/mtLl1cNmfNskv
 QZapH2XZmu9ikuRrTn9VL8+Qu1gXR9nVi9+DFJSq+xWyK5NGEdQNpAeYwDGPZVlERAxFWpGawJG
 WlMpFGK3U94Vdi/rJsl9atL8/vMyvHd8gAgN7cQxM/Edc0VTPnysEMiVn/wsK0EBvmrnhsbk=
X-Gm-Gg: AfdE7cnF89LqJl88Jg3mfcnjU+2Fd4abX/DoFariv5Syp+MpxoIvdJd853KdV9AFPL7
 M9VrXOyv8gJyCUN5/9DTVNvxdQJQAZHIgHYdUsZ8lyTirjLSoFBjN3UDtxYhYvOUMOhEQZ+vw/F
 wh2ohlg+m4xS5S8HN52PXy0kDFceLBRGoRO4x6KXoH95zcongQZ8EPEEtcuFzQFZvF7I/pdgVUx
 XQ6EftiWforqfdvJE/YLljT873JHLrOt5wwVEVXpl5e7a1Yy2lftYHj4PfV13qD9nd+C4x4nZ9K
 8v24Xl2StD6PiIXa5IEn5RaruUGzfBUBfp9j1Ev5JITIxvr0RzhLOC70KOchc/iQfySoUKH8e9m
 OOF2MypEuXVbGoUwuiY4GfE7p6I033aTLybDXogZvLPJUfhjsrrY1PwNOg+BLioX+qSWCS+oG0t
 xjYk/6NxWB1fmgpW8qtinhkD/3
X-Received: by 2002:ac8:5911:0:b0:51b:fde4:cd57 with SMTP id
 d75a77b69052e-51cbf149f77mr57388311cf.31.1783857418494; 
 Sun, 12 Jul 2026 04:56:58 -0700 (PDT)
X-Received: by 2002:ac8:5911:0:b0:51b:fde4:cd57 with SMTP id
 d75a77b69052e-51cbf149f77mr57388121cf.31.1783857417994; 
 Sun, 12 Jul 2026 04:56:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01caaf999sm1978903e87.70.2026.07.12.04.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 04:56:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 12 Jul 2026 14:56:55 +0300
Subject: [PATCH] Revert "drm/msm: dsi: fix PLL init in bonded mode"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-msm-revert-dsi-pll-fix-v1-1-40122689ea25@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAaBU2oC/yWMQQ5EQBBFryK1Vknr0GKuIhaaQglGupBJxN2ns
 Hw//70ThAKTwCc6IdDBwt9FIYkjaIZ66Qm5VQZrrDN5YnGWGfVIYcNWGNdpwo5/6DNvisLlaeY
 cqLwG0vkJl9XLsvuRmu2uwXX9AY0oENh6AAAA
X-Change-ID: 20260712-msm-revert-dsi-pll-fix-b5b099674566
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mohit Dsor <mohit.dsor@oss.qualcomm.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4247;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=U8xlc4LqmG92BXJIi/W6fHc/zYAF0nG/swZlZ6Z3INc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqU4EIHWZ7Ly5h6oCyRCn5gdJDDBtWR8a3fAUam
 IyuoZg6sreJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCalOBCAAKCRCLPIo+Aiko
 1dnGB/sGMJQv7zEngalJu4Tw/zGO7hTfITIVyq6eO48phQBx8V7J2bPeYP9nJZJfJVNFOjSoJOJ
 PESZ80vZ+2vFTGknAK9QuapE359B9uRc4E/ujMaTlsA2EGkprPCq7SDxArPNQuRqz7DHgamD1KF
 3CD7j8dzIvzhHOmbAa79CHj6lSVbamXKpnoidDDOkaUMRE5BkjXc37U+EYlmj4FuJxqVIS390yU
 CXSVWAOo6E8G6wa4FeX7jxPorV7krv5DNmX4Kvfm4sy/M53EhBNGBacaqaAxM5uvcj2gWlWH2tv
 xDgKO+K/AyLysil6NS/5tmQdDMuCc1TUfXfr1j6imKnH9C3v
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: eni59D3OC4ahAdIlE0ivb4TmczXgdeM0
X-Authority-Analysis: v=2.4 cv=SajHsPRu c=1 sm=1 tr=0 ts=6a53810b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=lAgNKBcoAAAA:8 a=xpBAJsVfksFbc_DGZosA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
 a=drE6d5tx1tjNRBs8zHOc:22
X-Proofpoint-ORIG-GUID: eni59D3OC4ahAdIlE0ivb4TmczXgdeM0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDEyNCBTYWx0ZWRfX3Tte54qvKzLI
 TCMyhuNIifrEjlLC3IkJVft91+X3E0Lex/2tE0uA6JcXmFvHlYLu2cIRqyydVI8X/zRW0QBvVRr
 5SFY2AhlvgxZ1y22tOZlx+4RKJoCGEiYMCX1+tRFpdYkG39IbKiEKhUfNluXbOrXC3rUYRSVZ0r
 RuVW7L7XlFel93SukDSh8sxFak5IOLgTDTy0m3wBeg2uOVGhtSdMpwZQSU49nGQGGeZrPF+OlIF
 EOOJVo7RYnkku7xOCa4YKJ/E/TEfApdgh8bp48RIweFvSg1t53bVoBi5JhXYr56Ecj7DeEVvjOl
 KIiXYrzj5ymOwlJykEyy/G3zmDGv7+odcBXYMHI03CSvGdTDfZytQkrjloBVMI/MQ89+RBZxBiy
 gfuw25FHRROU6X+NnrpyByqtQaEQgz/KaKQUoFBcYGn7G2Y2Z9t4Ue9ZgydIE9hKWlTBNR/Nd9J
 5M6Jj0/PwI/n+mf2o2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDEyNCBTYWx0ZWRfX3O0y+YDD3ldH
 JYHXnivYQu9B9AgKp8NOW9RHB0MhKbQHu15FA1HfOPoZzyeHbySMbssF/iG9y8nLAPJyzCn6VCM
 Dov5ROyDJQ9thPGahGsutrMFSQ9XFv0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120124
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

Commit 93c97bc8d85d ("drm/msm: dsi: fix PLL init in bonded mode") fixed
one of the issues with the DSI bonded mode, but broke non-bonded usecase
for DSI as reported by Mohit Dsor. Clock divider is being programmed
incorrectly, resultin in the wrong display mode being selected. Revert
the offending commit, letting Neil to work on a better fix.

Fixes: 93c97bc8d85d ("drm/msm: dsi: fix PLL init in bonded mode")
Reported-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Closes: https://lore.kernel.org/r/ae07cef84AmXK43H@hu-mdsor-hyd.qualcomm.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h     |  1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
index 21a59d66e8dc..f5d3e806f8fd 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
@@ -111,6 +111,7 @@ struct msm_dsi_phy {
 	struct msm_dsi_dphy_timing timing;
 	const struct msm_dsi_phy_cfg *cfg;
 	void *tuning_cfg;
+	void *pll_data;
 
 	enum msm_dsi_phy_usecase usecase;
 	bool regulator_ldo_mode;
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index 984a66085dfb..5d805a797abd 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -426,8 +426,11 @@ static void dsi_pll_enable_pll_bias(struct dsi_pll_7nm *pll)
 	u32 data;
 
 	spin_lock_irqsave(&pll->pll_enable_lock, flags);
-	pll->pll_enable_cnt++;
-	WARN_ON(pll->pll_enable_cnt == INT_MAX);
+	if (pll->pll_enable_cnt++) {
+		spin_unlock_irqrestore(&pll->pll_enable_lock, flags);
+		WARN_ON(pll->pll_enable_cnt == INT_MAX);
+		return;
+	}
 
 	data = readl(pll->phy->base + REG_DSI_7nm_PHY_CMN_CTRL_0);
 	data |= DSI_7nm_PHY_CMN_CTRL_0_PLL_SHUTDOWNB;
@@ -873,6 +876,7 @@ static int dsi_pll_7nm_init(struct msm_dsi_phy *phy)
 	spin_lock_init(&pll_7nm->pll_enable_lock);
 
 	pll_7nm->phy = phy;
+	phy->pll_data = pll_7nm;
 
 	ret = pll_7nm_register(pll_7nm, phy->provided_clocks->hws);
 	if (ret) {
@@ -961,8 +965,10 @@ static int dsi_7nm_phy_enable(struct msm_dsi_phy *phy,
 	u32 const delay_us = 5;
 	u32 const timeout_us = 1000;
 	struct msm_dsi_dphy_timing *timing = &phy->timing;
+	struct dsi_pll_7nm *pll = phy->pll_data;
 	void __iomem *base = phy->base;
 	bool less_than_1500_mhz;
+	unsigned long flags;
 	u32 vreg_ctrl_0, vreg_ctrl_1, lane_ctrl0;
 	u32 glbl_pemph_ctrl_0;
 	u32 glbl_str_swi_cal_sel_ctrl, glbl_hstx_str_ctrl_0;
@@ -1084,10 +1090,13 @@ static int dsi_7nm_phy_enable(struct msm_dsi_phy *phy,
 		glbl_rescode_bot_ctrl = 0x3c;
 	}
 
+	spin_lock_irqsave(&pll->pll_enable_lock, flags);
+	pll->pll_enable_cnt = 1;
 	/* de-assert digital and pll power down */
 	data = DSI_7nm_PHY_CMN_CTRL_0_DIGTOP_PWRDN_B |
 	       DSI_7nm_PHY_CMN_CTRL_0_PLL_SHUTDOWNB;
 	writel(data, base + REG_DSI_7nm_PHY_CMN_CTRL_0);
+	spin_unlock_irqrestore(&pll->pll_enable_lock, flags);
 
 	/* Assert PLL core reset */
 	writel(0x00, base + REG_DSI_7nm_PHY_CMN_PLL_CNTRL);
@@ -1200,7 +1209,9 @@ static bool dsi_7nm_set_continuous_clock(struct msm_dsi_phy *phy, bool enable)
 
 static void dsi_7nm_phy_disable(struct msm_dsi_phy *phy)
 {
+	struct dsi_pll_7nm *pll = phy->pll_data;
 	void __iomem *base = phy->base;
+	unsigned long flags;
 	u32 data;
 
 	DBG("");
@@ -1227,8 +1238,11 @@ static void dsi_7nm_phy_disable(struct msm_dsi_phy *phy)
 	writel(data, base + REG_DSI_7nm_PHY_CMN_CTRL_0);
 	writel(0, base + REG_DSI_7nm_PHY_CMN_LANE_CTRL0);
 
+	spin_lock_irqsave(&pll->pll_enable_lock, flags);
+	pll->pll_enable_cnt = 0;
 	/* Turn off all PHY blocks */
 	writel(0x00, base + REG_DSI_7nm_PHY_CMN_CTRL_0);
+	spin_unlock_irqrestore(&pll->pll_enable_lock, flags);
 
 	/* make sure phy is turned off */
 	wmb();

---
base-commit: b9810cd75b9fb56a3425d391cba3f608502bd474
change-id: 20260712-msm-revert-dsi-pll-fix-b5b099674566

Best regards,
--  
With best wishes
Dmitry

