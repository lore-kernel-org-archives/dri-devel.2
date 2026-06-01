Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98188CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 09:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F003C10E75C;
	Mon,  1 Jun 2026 09:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LeZT8Gq/";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011020.outbound.protection.outlook.com [52.101.57.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6508710E75C
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 09:55:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0ahYAt010pjhlC4mRsXEGSd03mpJbcndOF10h7LJf2jztJuz5rw5fweO/LiShA585CxqL1jt5j5yeyKOKUMFq/WaQbXenav3dQqcZqh4IsGJSB3HqN/WaD1H0SURoxufFg4xJfpuW29r82lDrmgmiMkeXp0NTSWoCCwWNTUm1gyvI3eRj7cMT9QH+UOT6+lFiKm9ru0IHoyHSNdS/JI+O/K+gdFx7b5eiuKDdHpY6DgnMI04nkTsTfcvoTP9X+ysXjqDnuIfhWBCZZsW30Dr3GEOzIAh9Yb0IjgVRMz7WtBiz1WZMY+BMJ6sbOM2n/AsM7eYIg+3QXP8DlGY8RGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jY4GR1LyaTkxaQTJGAebfXUUmr8+mbfwKXvCwzAI6a0=;
 b=hueGRlA78bM14Mh7G+vp8DASQde9WC7kVJuYRnLQuOESn8vkdNFpOgOG1Zz+uzhczKtKwlkvM6YBcEqXzoPfycOEyv0O2dsdakwtOjYgMe+77uHR0hX8VcU2JlDgLPPTk13iX464/JzsMDfzD7D71kfwINuEnKEdy7xQkoaj5gdGTg+IJYZbaOoGNUMdvuC+ptE+esfJff6NJykyfnN6HYcMrRc8iyRVKMdxmNu5SDc36HlzLiqLUZG1WuWgNxYv3wI6WklPsxdN2v9V6M3ZjDM2COVTBCkQBYuIYJExQ+LEtjFYXPK68HVtlSVvcrbsemuHUh9nnMpqPvZgZ6gSGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jY4GR1LyaTkxaQTJGAebfXUUmr8+mbfwKXvCwzAI6a0=;
 b=LeZT8Gq//fdDv8h3aPenJWV+0eK6pLxvCyPbcrMhR+gzN22mW8LWe0hB+HuThgoAOBr8XVwijG7+LHeMk2adrGC4FZPMhiIT29zA8bdLx33SPCVnGkf/dJghRzXdKVHoZJvFo84qe0aZcXn4R+qm5/oMpO1ZHH5qruFrhRZ7wx4=
Received: from MN2PR11CA0002.namprd11.prod.outlook.com (2603:10b6:208:23b::7)
 by PH0PR10MB997570.namprd10.prod.outlook.com (2603:10b6:510:385::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 09:55:04 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::5c) by MN2PR11CA0002.outlook.office365.com
 (2603:10b6:208:23b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 09:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 09:55:03 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 04:54:52 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 04:54:52 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 1 Jun 2026 04:54:52 -0500
Received: from uda0543015.dhcp.ti.com (uda0543015.dhcp.ti.com [10.24.50.243])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 6519skhx765246; Mon, 1 Jun 2026 04:54:47 -0500
From: Abhash Kumar Jha <a-kumar2@ti.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
 <rfoss@kernel.org>, <mripard@kernel.org>, <tzimmermann@suse.de>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <devarsht@ti.com>, <u-kumar1@ti.com>, 
 <sjakhade@cadence.com>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <s-jain1@ti.com>, <y-d@ti.com>,
 <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v3] drm/bridge: cdns-mhdp8546: Add suspend resume support to
 the bridge driver
Date: Mon, 1 Jun 2026 15:20:41 +0530
Message-ID: <20260601095041.3042950-1-a-kumar2@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|PH0PR10MB997570:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f31e7cc-6b3c-478a-8d76-08debfc3da1c
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info: Hv681asz1jZHQ9HuDbeHloHE9uQsF6a7hWtLkasEicaWMyNgF1NtxRq2DW1bsNXLlgoWblOZL9cM22PLfkbQu7Xlwfst5xnP2ti93sYCoflH3jsHpmSBPj30fmLKyKINsuC2I54kQg5uzjIje6Jgb7N4B0LNq6JRJpDHhP83bz/82e5w1WxqbzJR4h16XzLY40vDDaNiETVxXhkFOShh82dqZLzsBZP/zL2ubH9XvaoSG79EuUvHNt3IG76B9c+AWrKOF7cLQUYtSIaLzH9YIY4/oq7nyMl6CAhPOl2IcdWmM4j45efSwCp/ai0lBvp3eIQ4qwPBQodSYu0CrQ5OwXjn49U8vRO61idfLl7RDT4KMtdzVJ9aivNj0zeWffNU82egk6lGDoNHt6v/Fn1fshGF7qW/YOBPo2vEdaJ9pZlyLv4oQnLAW24VhR7iH1e0z1khLIQLvQgRSVSZiY03yEGS8FZeKxcgbUzShYGnBFlpaYXsSkWSeb81qMiPdvcILAUTF1qufduON+uTS/mHA9wr7J8y9W/4PgrWm5i7tx48Vpku5nO+39nuAHyYpTBu3V7q/jg0bbKUe7v794owK7gRGoNdN5UGQ6PEw378RZrngsYsEuHMx42anifRZreVFd5m0YyRzTjLVDC0/lZbbbERSCsuO90Q5n+/TKLAAe3ZgKEcfDC6xH8Sjx4COmG+ouDbtWqAbG1zotiQoKztrxZajwPQLKmf2OWUTnxVZoWzS849taYJ0UH/7NS9P1mgFi7uLVpOIFnrwOaqBaqgiAb/v9X/CM13gGG/uPhqERs=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(56012099006)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B/AxiX6qnR97RyB6VsAGKuHy6IjaB5DrLDg1gQ/dyt5Yt4srgFKlzeOStVa1VVzRrQ+AVk9rrDCcbNyKxGjFBUfotVkZJ3u3tYJ+FVtfq+jms7c+dZIkj4Fj4A6m2ctwUarN0WQtY4oH1laROzHlsATyQuUhEfUyUa6PNM5SfZ1sI65R9hh37x4mlviODJPHtTAV1lpnoB/mYW/py2+cYm3y9etSRJs+hbz3AcdVFFyy/IAROta+e10Pe0SGQNrnNP/rfZtEXzd+ji4hKOgJQtf03Q+J66kQ5p0/12AJ04Y7KtnxCk1i12Cxs3B9GpdQdqh4CXkAzqsVn1X079dPWSSxqgcJaZRW3CrxATiVjmmOF2CgZiHKMq4qgw0Slijn22Y/XavVV7pbIsFq63M6SFwmDeKD5LeSOmN72oan4JLIpfD6tpgpnH9PxvpuCb8U
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 09:55:03.0782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f31e7cc-6b3c-478a-8d76-08debfc3da1c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997570
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

Add system suspend and resume hooks to the cdns-mhdp8546 bridge driver.

While resuming we either load the firmware or activate it. Firmware
is loaded only when resuming from a successful suspend-resume cycle.

If resuming due to an aborted suspend, loading the firmware is not
possible because the uCPU's IMEM is only accessible after a reset and the
bridge has not gone through a reset in this case. Hence, Activate the
firmware that is already loaded.

Use genpd_notifier to get the power domain status of the bridge and
accordingly load the firmware.

Additionally, introduce phy_power_off/on to control the power to the phy.

Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
---
Hi,

Changes in v3:
- Register genpd_notifier callback only when genpd is available.
- Mark mhdp->powered_off = false after resume is successful.
- Use SIMPLE_DEV_PM_OPS instead of SET_SYSTEM_SLEEP_PM_OPS.
- Set mhdp->hw_state appropriately in error paths.
- Link to v2: https://lore.kernel.org/all/20260205085233.81678-1-a-kumar2@ti.com/

Changes in v2:
- Fixed defined but not used [-Wunused-function] warning for suspend and resume calls.
- Link to v1: https://lore.kernel.org/all/20260129112016.2448037-1-a-kumar2@ti.com/

Thanks and Regards,
Abhash

 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 138 +++++++++++++++++-
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |   4 +
 2 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 99888f8d55736..90d8c037a2220 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -32,6 +32,7 @@
 #include <linux/phy/phy.h>
 #include <linux/phy/phy-dp.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 
@@ -2287,6 +2288,121 @@ static void cdns_mhdp_hpd_work(struct work_struct *work)
 	drm_bridge_hpd_notify(&mhdp->bridge, cdns_mhdp_detect(mhdp));
 }
 
+static int cdns_mhdp_resume(struct device *dev)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
+	unsigned long rate;
+	int ret;
+
+	ret = clk_prepare_enable(mhdp->clk);
+	if (ret)
+		return ret;
+
+	rate = clk_get_rate(mhdp->clk);
+	writel(rate % 1000000, mhdp->regs + CDNS_SW_CLK_L);
+	writel(rate / 1000000, mhdp->regs + CDNS_SW_CLK_H);
+	writel(~0, mhdp->regs + CDNS_APB_INT_MASK);
+
+	ret = phy_init(mhdp->phy);
+	if (ret) {
+		dev_err(mhdp->dev, "Failed to initialize PHY: %d\n", ret);
+		goto disable_clk;
+	}
+	ret = phy_power_on(mhdp->phy);
+	if (ret < 0) {
+		dev_err(mhdp->dev, "Failed to power on PHY: %d\n", ret);
+		goto error;
+	}
+
+	if (mhdp->powered_off) {
+		ret = cdns_mhdp_load_firmware(mhdp);
+		if (ret)
+			goto phy_off;
+
+		ret = wait_event_timeout(mhdp->fw_load_wq,
+					mhdp->hw_state == MHDP_HW_READY,
+					msecs_to_jiffies(1000));
+		if (ret == 0) {
+			dev_err(mhdp->dev, "%s: Timeout waiting for fw loading\n",
+				__func__);
+			ret = -ETIMEDOUT;
+			goto phy_off;
+		}
+	} else {
+		ret = cdns_mhdp_set_firmware_active(mhdp, true);
+		if (ret) {
+			dev_err(mhdp->dev, "Failed to activate firmware (%pe)\n", ERR_PTR(ret));
+			goto phy_off;
+		}
+	}
+
+	mhdp->powered_off = false;
+	return 0;
+
+phy_off:
+	phy_power_off(mhdp->phy);
+error:
+	phy_exit(mhdp->phy);
+disable_clk:
+	clk_disable_unprepare(mhdp->clk);
+
+	return ret;
+}
+
+static int cdns_mhdp_suspend(struct device *dev)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
+	unsigned long timeout = msecs_to_jiffies(100);
+	int ret = 0;
+
+	cancel_work_sync(&mhdp->hpd_work);
+	ret = wait_event_timeout(mhdp->fw_load_wq,
+				 mhdp->hw_state == MHDP_HW_READY,
+				 timeout);
+
+	spin_lock(&mhdp->start_lock);
+	if (mhdp->hw_state != MHDP_HW_READY) {
+		spin_unlock(&mhdp->start_lock);
+		dev_err(mhdp->dev, "%s: Timeout waiting for fw loading\n", __func__);
+		return -ETIMEDOUT;
+	}
+	mhdp->hw_state = MHDP_HW_STOPPED;
+	spin_unlock(&mhdp->start_lock);
+
+	ret = cdns_mhdp_set_firmware_active(mhdp, false);
+	if (ret) {
+		dev_err(mhdp->dev, "Failed to stop firmware (%pe)\n", ERR_PTR(ret));
+		spin_lock(&mhdp->start_lock);
+		mhdp->hw_state = MHDP_HW_READY;
+		spin_unlock(&mhdp->start_lock);
+		goto error;
+	}
+
+	phy_power_off(mhdp->phy);
+	phy_exit(mhdp->phy);
+	clk_disable_unprepare(mhdp->clk);
+
+	/* if no power domain available, always reload firmware on resume */
+	if (!mhdp->dev->pm_domain)
+		mhdp->powered_off = true;
+
+error:
+	return ret;
+}
+
+static int mhdp_pd_notifier_cb(struct notifier_block *nb,
+			unsigned long action, void *data)
+{
+	struct cdns_mhdp_device *mhdp = container_of(nb, struct cdns_mhdp_device, pd_nb);
+
+	if (action == GENPD_NOTIFY_OFF)
+		mhdp->powered_off = true;
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(cdns_mhdp_pm_ops, cdns_mhdp_suspend, cdns_mhdp_resume);
+
 static int cdns_mhdp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -2401,6 +2517,11 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 		dev_err(mhdp->dev, "Failed to initialize PHY: %d\n", ret);
 		goto plat_fini;
 	}
+	ret = phy_power_on(mhdp->phy);
+	if (ret < 0) {
+		dev_err(mhdp->dev, "Failed to power on PHY: %d\n", ret);
+		goto phy_exit;
+	}
 
 	/* Initialize the work for modeset in case of link train failure */
 	INIT_WORK(&mhdp->modeset_retry_work, cdns_mhdp_modeset_retry_fn);
@@ -2411,15 +2532,26 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 
 	ret = cdns_mhdp_load_firmware(mhdp);
 	if (ret)
-		goto phy_exit;
+		goto power_off;
 
 	if (mhdp->hdcp_supported)
 		cdns_mhdp_hdcp_init(mhdp);
 
-	drm_bridge_add(&mhdp->bridge);
+	mhdp->powered_off = false;
+	if (mhdp->dev->pm_domain) {
+		mhdp->pd_nb.notifier_call = mhdp_pd_notifier_cb;
+		ret = dev_pm_genpd_add_notifier(mhdp->dev, &mhdp->pd_nb);
+		if (ret) {
+			dev_err_probe(dev, ret, "failed to add power domain notifier\n");
+			goto power_off;
+		}
+	}
 
+	drm_bridge_add(&mhdp->bridge);
 	return 0;
 
+power_off:
+	phy_power_off(mhdp->phy);
 phy_exit:
 	phy_exit(mhdp->phy);
 plat_fini:
@@ -2457,6 +2589,7 @@ static void cdns_mhdp_remove(struct platform_device *pdev)
 				ERR_PTR(ret));
 	}
 
+	phy_power_off(mhdp->phy);
 	phy_exit(mhdp->phy);
 
 	if (mhdp->info && mhdp->info->ops && mhdp->info->ops->exit)
@@ -2488,6 +2621,7 @@ static struct platform_driver mhdp_driver = {
 	.driver	= {
 		.name		= "cdns-mhdp8546",
 		.of_match_table	= mhdp_ids,
+		.pm = pm_sleep_ptr(&cdns_mhdp_pm_ops),
 	},
 	.probe	= cdns_mhdp_probe,
 	.remove = cdns_mhdp_remove,
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
index 2041ffbc019a5..31dbeaf33ccb6 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
@@ -413,6 +413,10 @@ struct cdns_mhdp_device {
 
 	struct cdns_mhdp_hdcp hdcp;
 	bool hdcp_supported;
+
+	/* Power domain status notifier */
+	struct notifier_block pd_nb;
+	bool powered_off;
 };
 
 #define connector_to_mhdp(x) container_of(x, struct cdns_mhdp_device, connector)
-- 
2.34.1

