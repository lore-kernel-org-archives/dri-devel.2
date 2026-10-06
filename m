Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B01CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 13:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F8C210E3F0;
	Tue,  6 Oct 2026 13:35:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dVWMmzD1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 438A310E3F0;
 Tue,  6 Oct 2026 13:35:47 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696DUOrg131055; Tue, 6 Oct 2026 13:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=KvsNYuYYOqkLZkjs0Ht8Or
 XOsRjlllFCxL/rYEtnlT4=; b=dVWMmzD1X8rKNhkRiGlmRJIc4skfUe6newZ7wT
 umoTYjb+jOId6Oxlsm9NB1Q4Bnqc92L5ygJ5E2uqdj2zLhGwWOwjgF7X3GfopQZk
 BTlDTKTIHjxUXyfI+LPn81TwyphUYbwADkSSoBZNxCE8n48LsJGWjBfEeqAUf5rq
 6Ll0npWzAD7+BfOvtbVoKc1TVHOAuM4DFde2xcly4RpzvTnLXq9yrDrXACH0tAPg
 yV3bHUORwZqRDILVRTws21FjDK6RQv0rvKF3X92ylx23VQLEK902TqNCDGmgpSej
 /c9fn2Qg7Z/IZqouawxRKhkg4rnJXIwhviDYkWS/q23gLiqA==
Received: from apblrppmta02.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4vmrs8ut-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 13:35:37 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
 by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696DE57G990643; Tue, 6 Oct 2026 13:14:05 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-arpisain-hyd.qualcomm.com
 [10.147.248.17])
 by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 696DE56b990635
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 13:14:05 +0000 (GMT)
Received: from hu-arpisain-hyd.qualcomm.com (localhost [127.0.0.1])
 by hu-devc-hyd-u22-c.qualcomm.com (Postfix) with ESMTP id 15334647;
 Tue,  6 Oct 2026 18:44:04 +0530 (+0530)
From: Arpit Saini <arpit.saini@oss.qualcomm.com>
Date: Tue, 06 Oct 2026 18:43:53 +0530
Subject: [PATCH] drm/msm/dsi: fix AHB clock staying enabled across suspend
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-dsi-ahb-clk-suspend-fix-v1-1-67da848e1b0a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABD0xGoC/x2MSQqAMAwAvyI5G2iLC/oV8aBp1KBUaVAE8e8Wj
 zMw84ByFFZoswciX6KyhwQ2z4CWIcyM4hODM66yxlToVXBYRqRtRT314OBxkhtLS97VDRGNBaT
 6iJz0f+769/0Ax8pt3WkAAAA=
X-Change-ID: 20261006-dsi-ahb-clk-suspend-fix-51cd279cccb4
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mahadevan.p@oss.qualcomm.com, rajeevny@qti.qualcomm.com,
 Arpit Saini <arpit.saini@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791292444; l=7036;
 i=arpit.saini@oss.qualcomm.com; s=20260929; h=from:subject:message-id;
 bh=cRWG+AciFntQ62/nkAseUlx4YrFF//l9QVdkplVv8zM=;
 b=Bn+ch57H03oCMgIjFFv+QOQ0+uYzYA2DNZYUu6Cpax8o/iLfkLHUxn8bO/sqI86mdBehSV7FR
 m0vJMSuiE3ZCI76rtcRhLNKxept69jazrVcrk1m18gXYSexA6krdyUW
X-Developer-Key: i=arpit.saini@oss.qualcomm.com; a=ed25519;
 pk=hAgg8uNgzV2UIXcMolGFuWsdQLeg5F/siao+So2kbBc=
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=XZ4cX455 c=1 sm=1 tr=0 ts=6ac4f929 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=0UUxXAEebRRMa4xcU8YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VrZXiXrhrf5LdfbyPco4QjeQnshBwdsj
X-Proofpoint-ORIG-GUID: VrZXiXrhrf5LdfbyPco4QjeQnshBwdsj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1NCBTYWx0ZWRfX1nhBJax/yP5m
 +vqVCgUACbvewg1oxYx7LqcQxrFafFhB5jjGqMjeqYKdb3upwITrAPLrQ83isJR/3UuYki1D51x
 9VHKicqBU6F0odbpjGDxei8v8xYOG+i5M6NMUJUiE5vktbV8ykoaf3SS9n4tsdTuSQbl8G3SB8X
 0dOprvO9O7h5OkYDNrlBUPlpvA9yFnfvYXp4LGALlruC3zaDUxnjuzzU0f8wWuhUYSC5R7ohqyg
 o4VmCRNi0ZxT0MTVTdeYeRW37hPJJvp1ge2JAaF21BEvY8q4PegoLe3AiYRoIawMZcOesPDcPlk
 1YEcT1LrThXVHupIkezZtSndO0mxhd3arkWWlPFun9D2QtUDDU15P8UrXbp1GiXzS0ke4SapA+I
 uF/NOcpklZhy1u8vLONYVy6M+ghbGJH7e2PDl2JikLmDIjDYxF8qsvJb1EoWkKAS647SrllU8Rz
 aem5a8U7yswSpAwLHqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1NCBTYWx0ZWRfXznRl7bJmLs8O
 BenJjdhu1WXQ4qneWOKoFBxhzCKKhjvM2xgNg/rNGWMOxlK71XUhnvJU2IQpP5L/Jm3ibQsWtBY
 N5rJH97i5gGTGiCIlm6DBwv2reamBEc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060054
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

pm_clk_suspend()/resume() only call clk_disable()/clk_enable() for the
AHB ("iface") clock, never clk_unprepare(), so prepare_count never
reaches 0. The clock (and its source) stays reported as enabled
through s2idle suspend even though the display stack is fully
suspended:

  disp_cc_mdss_ahb_clk [19200000] ->
    disp_cc_mdss_ahb_clk_src [19200000] ->
    bi_tcxo [19200000] -> xo-board [76800000]
  disp_cc_mdss_ahb_clk_src [19200000] ->
    bi_tcxo [19200000] -> xo-board [76800000]

Calling clk_prepare_enable()/clk_disable_unprepare() directly from the
PHY's runtime_suspend/runtime_resume is not safe either, since it can
deadlock against the PHY's own PLL clocks taking the global CCF
prepare_lock during clk_prepare()/clk_unprepare().

Fix this by moving clk_prepare()/clk_unprepare() out of the runtime PM
path. clk_enable()/clk_disable() (spinlock only) stay in
runtime_suspend/runtime_resume. clk_prepare()/clk_unprepare() move to
suspend_late/resume_early, avoiding the prepare_lock collision and
actually dropping prepare_count to 0. DPM_FLAG_NO_DIRECT_COMPLETE
ensures these hooks always run on sleep.

Fixes: 0b3ccb76b95b ("drm/msm/dsi: Fix 14nm DSI PHY PLL Lock issue")
Signed-off-by: Arpit Saini <arpit.saini@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 132 +++++++++++++++++++++++++++++++---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h |   4 ++
 2 files changed, 127 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index 1fb3899b88bf..3a8b5e23f601 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -3,9 +3,9 @@
  * Copyright (c) 2015, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/platform_device.h>
-#include <linux/pm_clock.h>
 #include <linux/pm_runtime.h>
 #include <dt-bindings/phy/phy.h>
 
@@ -610,6 +610,105 @@ static int dsi_phy_get_id(struct msm_dsi_phy *phy)
 	return -EINVAL;
 }
 
+static int dsi_phy_prepare_ahb_clk(struct msm_dsi_phy *phy)
+{
+	int ret;
+
+	if (clk_is_enabled_when_prepared(phy->ahb_clk) || phy->ahb_clk_prepared)
+		return 0;
+
+	ret = clk_prepare(phy->ahb_clk);
+	if (!ret)
+		phy->ahb_clk_prepared = true;
+
+	return ret;
+}
+
+static void dsi_phy_unprepare_ahb_clk(struct msm_dsi_phy *phy)
+{
+	if (phy->ahb_clk_prepared) {
+		clk_unprepare(phy->ahb_clk);
+		phy->ahb_clk_prepared = false;
+	}
+}
+
+static int dsi_phy_runtime_suspend(struct device *dev)
+{
+	struct msm_dsi_phy *phy = dev_get_drvdata(dev);
+
+	if (phy->ahb_clk_enabled) {
+		clk_disable(phy->ahb_clk);
+		phy->ahb_clk_enabled = false;
+	}
+
+	if (clk_is_enabled_when_prepared(phy->ahb_clk))
+		dsi_phy_unprepare_ahb_clk(phy);
+
+	return 0;
+}
+
+static int dsi_phy_runtime_resume(struct device *dev)
+{
+	struct msm_dsi_phy *phy = dev_get_drvdata(dev);
+	int ret;
+
+	if (clk_is_enabled_when_prepared(phy->ahb_clk)) {
+		ret = clk_prepare_enable(phy->ahb_clk);
+		if (ret)
+			return ret;
+
+		phy->ahb_clk_prepared = true;
+	} else {
+		/* Do not enable an unprepared clock after a failed system resume. */
+		if (!phy->ahb_clk_prepared)
+			return -EIO;
+
+		ret = clk_enable(phy->ahb_clk);
+		if (ret)
+			return ret;
+	}
+
+	phy->ahb_clk_enabled = true;
+
+	return 0;
+}
+
+static int dsi_phy_suspend_late(struct device *dev)
+{
+	struct msm_dsi_phy *phy = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
+
+	/* Runtime PM is quiesced, so it is safe to release preparation now. */
+	dsi_phy_unprepare_ahb_clk(phy);
+
+	return 0;
+}
+
+static int dsi_phy_resume_early(struct device *dev)
+{
+	struct msm_dsi_phy *phy = dev_get_drvdata(dev);
+	int ret, resume_ret;
+
+	ret = dsi_phy_prepare_ahb_clk(phy);
+	/* Balance force_suspend even if restoring preparation failed. */
+	resume_ret = pm_runtime_force_resume(dev);
+
+	return ret ?: resume_ret;
+}
+
+static void dsi_phy_release_ahb_clk(void *data)
+{
+	struct msm_dsi_phy *phy = data;
+
+	/* Runtime PM is either not enabled yet or has already been quiesced. */
+	dsi_phy_runtime_suspend(&phy->pdev->dev);
+	dsi_phy_unprepare_ahb_clk(phy);
+}
+
 static int dsi_phy_driver_probe(struct platform_device *pdev)
 {
 	struct msm_dsi_phy *phy;
@@ -683,17 +782,31 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, phy);
 
-	ret = devm_pm_runtime_enable(dev);
+	phy->ahb_clk = msm_clk_get(pdev, "iface");
+	if (IS_ERR(phy->ahb_clk))
+		return dev_err_probe(dev, PTR_ERR(phy->ahb_clk),
+				     "Unable to get iface clk\n");
+
+	/*
+	 * As a clock provider, the PHY can be runtime-resumed with the CCF
+	 * prepare_lock held. Keep clocks with separate enable operations
+	 * prepared across runtime PM, and only unprepare them during system
+	 * sleep (dsi_phy_suspend_late()/dsi_phy_resume_early()).
+	 */
+	ret = dsi_phy_prepare_ahb_clk(phy);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "Unable to prepare iface clk\n");
 
-	ret = devm_pm_clk_create(dev);
+	ret = devm_add_action_or_reset(dev, dsi_phy_release_ahb_clk, phy);
 	if (ret)
 		return ret;
 
-	ret = pm_clk_add(dev, "iface");
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "Unable to get iface clk\n");
+	/* Even a runtime-suspended PHY must release preparation for sleep. */
+	dev_pm_set_driver_flags(dev, DPM_FLAG_NO_DIRECT_COMPLETE);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
 
 	if (phy->cfg->ops.pll_init) {
 		ret = phy->cfg->ops.pll_init(phy);
@@ -712,7 +825,8 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops dsi_phy_pm_ops = {
-	SET_RUNTIME_PM_OPS(pm_clk_suspend, pm_clk_resume, NULL)
+	RUNTIME_PM_OPS(dsi_phy_runtime_suspend, dsi_phy_runtime_resume, NULL)
+	LATE_SYSTEM_SLEEP_PM_OPS(dsi_phy_suspend_late, dsi_phy_resume_early)
 };
 
 static struct platform_driver dsi_phy_platform_driver = {
@@ -720,7 +834,7 @@ static struct platform_driver dsi_phy_platform_driver = {
 	.driver     = {
 		.name   = "msm_dsi_phy",
 		.of_match_table = dsi_phy_dt_match,
-		.pm = &dsi_phy_pm_ops,
+		.pm = pm_ptr(&dsi_phy_pm_ops),
 	},
 };
 
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
index f5d3e806f8fd..77ae08dcff4b 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
@@ -106,6 +106,10 @@ struct msm_dsi_phy {
 	phys_addr_t lane_size;
 	int id;
 
+	struct clk *ahb_clk;
+	bool ahb_clk_prepared;
+	bool ahb_clk_enabled;
+
 	struct regulator_bulk_data *supplies;
 
 	struct msm_dsi_dphy_timing timing;

---
base-commit: 22430ae5d90ab288b0ee2ad99ae941f4a666b694
change-id: 20261006-dsi-ahb-clk-suspend-fix-51cd279cccb4

Best regards,
-- 
Arpit Saini <arpit.saini@oss.qualcomm.com>

