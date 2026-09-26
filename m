Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0316C98332
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 01:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62A4010FD0C;
	Sat, 26 Sep 2026 01:36:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R+R4wCWz";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012052.outbound.protection.outlook.com
 [40.107.200.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E04D10E2D2
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 01:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmsEE+iN4hVrVhqSjBd8LCRRRKV6cDUJQhBKTEpJbgaGoFc/+i0x65hprJZKu7/KZNqljlqvgoNKzd0O/5nokIEX06JStH7a72ysPjXOycRPjvg/OCkwsGLLSfOo8WtFy29bLupuQOMDa4fkg99Kelny5OClQ5xtbcGabrGdXzTWag5cyfkD2yoIsYiC2rkxmVyE2/UvnYnl4PUNH20aTe+iMb2Sr6tlqz4/fg/dwIxq/qvfa3K+UvUCfvjls0hwGAdzFMvfWwstJFKMxkKO7/lzS5QcX1HsoimVSpmS0Ks+SUcxQgEKAdNAPjQ8YkI4TADOCnUQafvKlHfUI+I1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6EPeIcWhdG+xyibTdsOECcc6OONrQFZ7i0zcWZVufc=;
 b=GQHzPzh+DUYQN7icoTKnF8khVzx/XT/e4CntfkzhzJ5Z+R1ujRPrSlJ39HZ3BOO9AWDQajf6cqPCIPjyyQwISm9T6w0jXL8fnn3I24aD6BVLdDD5Qaf0sRkxJa86PaQkTPstdU9xJIi9GW4cu+Gxzvfq6v9KCLuoqGZ1+JpGG6+ZD4Fvz/gaopSNY2rGH8mLI4wZ6SB1nXcItOpB+ZzXOfhfl2/ZiE2dFYxtHpTDElgQdiAxRl21YpSuEYRwFuh4pnL4mVVcIHyaA4cspQ69BHSW7slg3zTuQTnW12WcAr4F/7ACknTCAjqZuGQl8VzYo6ENFGeYCaO2gNCiWzD+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6EPeIcWhdG+xyibTdsOECcc6OONrQFZ7i0zcWZVufc=;
 b=R+R4wCWz7QXKWxKuW98Z3x/KfLhFdiqDdR5qUHkZjMMx9rhaKnu2K1Dl+Y3gIRYcoc8Dj1pYqtZvN8kNuts27+qiZfWnDjqUDVPHqBSqI83zpBX0xp/D0IfH4NjS9of1bwA9L+ParzNBzwnDTMCf8YLiYlPoijbEsks5gcMNisA=
Received: from BN0PR04CA0122.namprd04.prod.outlook.com (2603:10b6:408:ed::7)
 by PH8PR12MB8429.namprd12.prod.outlook.com (2603:10b6:510:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 26 Sep
 2026 01:35:37 +0000
Received: from BN7PEPF00000091.namprd03.prod.outlook.com
 (2603:10b6:408:ed:cafe::31) by BN0PR04CA0122.outlook.office365.com
 (2603:10b6:408:ed::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Sat,
 26 Sep 2026 01:35:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN7PEPF00000091.mail.protection.outlook.com (10.167.245.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Sat, 26 Sep 2026 01:35:37 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 20:35:34 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 25 Sep 2026 20:35:33 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V0 20/21] accel/amdxdna: Implement runtime suspend and resume
 support
Date: Fri, 25 Sep 2026 18:34:47 -0700
Message-ID: <20260926013448.3840921-21-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926013448.3840921-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260926013448.3840921-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000091:EE_|PH8PR12MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c9a258-47dc-4682-1747-08df1b6e7741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|56012099006|6133799003|3023799007|18002099003|260925022911599003|22082099003|4143699003|11063799006|260925021311599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: xJCeH7UxBUtZmPYTa82YH9Mknx4OmsGhSQ4r/PZ67didcRGlcwYbI8WVgZuLxgDWq93vKMrhFLrqq/mCb/HJ4TKfCkYXdk3hhTmS5yQTPTpS13hy2JsueDXlhtto4A5pEpjq39FmcKZpkyRYuwZLFw/ns3d1Gkwh5VLI1bGuL89TEBAQuyKT/j8WEq8vA8as8PQcUWTg2XBDMcTBgC95MyX2LNXsPYVMWI7SOZ6KVT7hvpFAibMOHznSHLrutHC64SRxHumDT1ORwo3ROV4pRQf7CdtIarl7k31G4ZTT/lcTUraQ7NzWotR+xI1xRVG2plaiBvXwqVneC0TZcTGVhKYP3VBNfJsfmIPsoH55tZoU4mVXpeWWGa874cytJDx4Fm42Z5N3qPMK3lNP22yHd59FMX3uuuWPTvFyXtkKICSKnvYF3lNe5wr3RlM5irUqkcDKSiSsHTqlJ6v9e9598dF2+IFpBwm/R+7SD7+UDonbv10cEFeFaELRM0TsuFGLfG/8wfV8E+Gp48tEQuLjkDIrLT4WxhbQtFRSjr1qRF5fUhrSsMBj+kMPldIteiqFR3obRswOozV9DiZEXhTlkEmdmSgNwoEk/I8bewQxCnldlOQHL3UJI0civQ2KJOiP6Pg6WAL1kZpyvqsFZrtKUR4KKxqKnwSsUQvFUoenk6T0kU6+s7pgJjhSU5hEr7LVxpgWUy1AGJeAsY6Jj0zlPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(56012099006)(6133799003)(3023799007)(18002099003)(260925022911599003)(22082099003)(4143699003)(11063799006)(260925021311599003)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wffJIPKHjL4Er9yAspajX3VyEdnzGxTyBy4yzbjZE3OSMAsPm/uQn7lzfqxn3vu08r5QcdnNaBm2iwJ8UWE/jJJ9314i4zzv2Ktzph/AQh9VVQ7uwzbLtJdiygZ54lm3GQDtZfs/K3KOi3TthQEHW8gmVFtVdB00kkNjL4Fi3lKVRvmzg4DhgFSRV9dSnC2auCh75/iKpuIQzQVtJ3gbJ9fGLqv7ZmXJK/09nmqlAiOeywJqBdVs+st46rgTDQHAcexUdTuoC7Gv+wRhVlo0ivLvby9bzwgQbmLuQO00t3ErtVEUmIQg6RTvy5lkqOvNFoHgcdmkKDUElzf4opeVbQAI0++MjnKuz6Lxz7O+KPmreR+hyyjGHH7vLqPEwHFEoFlCFtF/x8oX3JiHyUiVS0EAeYpWAVKatciiTO/pvQdeK0HS2PeEVsgX1ixTCQcy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 01:35:37.0619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c9a258-47dc-4682-1747-08df1b6e7741
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8429
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

Add .runtime_suspend and .runtime_resume callbacks to amdxdna_dev_ops
and wire them into RUNTIME_PM_OPS in the PCI driver.

Wake and acquire an RPM reference across amdxdna_sriov_configure()
via amdxdna_pm_resume_get_locked() and amdxdna_pm_suspend_put() so that
SR-IOV management commands execute with the device active. As part of
this, amdxdna_sriov_configure() now returns -EOPNOTSUPP instead of
-ENOENT when ops->sriov_configure is unset.

Update amdxdna_pm.c to implement amdxdna_pm_runtime_suspend() and
amdxdna_pm_runtime_resume(), update autosuspend timestamps using
pm_runtime_mark_last_busy(), and check pm_runtime_enabled().

Implement AIE4 runtime suspend and resume operations:
- For Physical Functions (PF), verify with aie4_vfs_alive() that no VFs
  are assigned to virtual machines or actively busy before suspending.
- For Virtual Functions (VF), perform hardware stop independently during
  runtime suspend (aie4_vf_runtime_suspend) and restore contexts upon
  runtime resume.
- For Classic devices, reuse the existing suspend and resume routines
  for runtime power management.
- Update AIE2 dev_ops to hook into runtime suspend and resume.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie2_pci.c        |  2 ++
 drivers/accel/amdxdna/aie4_pci.c        | 31 ++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h        |  8 ++++++
 drivers/accel/amdxdna/aie4_sriov.c      | 26 +++++++++++++++++++
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 15 ++++++++---
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  2 ++
 drivers/accel/amdxdna/amdxdna_pm.c      | 34 +++++++++++++++++++++++++
 drivers/accel/amdxdna/amdxdna_pm.h      |  4 ++-
 8 files changed, 118 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 0d209b7b6484..f90435e1f65e 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -1207,6 +1207,8 @@ const struct amdxdna_dev_ops aie2_ops = {
 	.fini = aie2_fini,
 	.resume = aie2_hw_resume,
 	.suspend = aie2_hw_suspend,
+	.runtime_resume = aie2_hw_resume,
+	.runtime_suspend = aie2_hw_suspend,
 	.get_aie_info = aie2_get_info,
 	.set_aie_state = aie2_set_state,
 	.hwctx_init = aie2_hwctx_init,
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 3c190003865a..28ac7940b200 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -1191,6 +1191,17 @@ static int aie4_pf_suspend(struct amdxdna_dev *xdna)
 	return 0;
 }
 
+static int aie4_pf_runtime_suspend(struct amdxdna_dev *xdna)
+{
+	int ret;
+
+	ret = aie4_vfs_alive(xdna);
+	if (ret)
+		return ret;
+
+	return aie4_pf_suspend(xdna);
+}
+
 static int aie4_pf_resume(struct amdxdna_dev *xdna)
 {
 	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
@@ -1243,6 +1254,20 @@ static int aie4_vf_suspend(struct amdxdna_dev *xdna)
 	return 0;
 }
 
+static int aie4_vf_runtime_suspend(struct amdxdna_dev *xdna)
+{
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+	aie4_hwctx_suspend_all(ndev, false);
+	aie4_vf_hw_stop(ndev);
+	pci_disable_device(pdev);
+
+	XDNA_DBG(xdna, "vf runtime suspend done");
+	return 0;
+}
+
 static int aie4_vf_resume(struct amdxdna_dev *xdna)
 {
 	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
@@ -1339,6 +1364,8 @@ const struct amdxdna_dev_ops aie4_pf_ops = {
 	.sriov_configure        = aie4_sriov_configure,
 	.resume			= aie4_pf_resume,
 	.suspend		= aie4_pf_suspend,
+	.runtime_resume		= aie4_pf_resume,
+	.runtime_suspend	= aie4_pf_runtime_suspend,
 };
 
 const struct amdxdna_dev_ops aie4_vf_ops = {
@@ -1353,6 +1380,8 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.set_aie_state		= aie4_set_state,
 	.resume			= aie4_vf_resume,
 	.suspend		= aie4_vf_suspend,
+	.runtime_resume		= aie4_vf_resume,
+	.runtime_suspend	= aie4_vf_runtime_suspend,
 };
 
 const struct amdxdna_dev_ops aie4_classic_ops = {
@@ -1367,4 +1396,6 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
 	.set_aie_state		= aie4_set_state,
 	.resume			= aie4_classic_resume,
 	.suspend		= aie4_classic_suspend,
+	.runtime_resume		= aie4_classic_resume,
+	.runtime_suspend	= aie4_classic_suspend,
 };
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index df15c63317b1..062275be7ee7 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -198,16 +198,24 @@ void aie4_free_notification(struct cert_comp *comp);
 int aie4_create_vfs(struct amdxdna_dev_hdl *ndev, int num_vfs);
 int aie4_sriov_configure(struct amdxdna_dev *xdna, int num_vfs);
 int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev);
+int aie4_vfs_alive(struct amdxdna_dev *xdna);
 #else
 static inline int aie4_create_vfs(struct amdxdna_dev_hdl *ndev, int num_vfs)
 {
 	return 0;
 }
+
 #define aie4_sriov_configure NULL
+
 static inline int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
 {
 	return 0;
 }
+
+static inline int aie4_vfs_alive(struct amdxdna_dev *xdna)
+{
+	return 0;
+}
 #endif
 
 extern const struct amdxdna_dev_ops aie4_pf_ops;
diff --git a/drivers/accel/amdxdna/aie4_sriov.c b/drivers/accel/amdxdna/aie4_sriov.c
index bfea6ff00ec0..10c8a2648e23 100644
--- a/drivers/accel/amdxdna/aie4_sriov.c
+++ b/drivers/accel/amdxdna/aie4_sriov.c
@@ -6,6 +6,7 @@
 #include <drm/amdxdna_accel.h>
 #include <drm/drm_print.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 
 #include "aie.h"
 #include "aie4_msg_priv.h"
@@ -120,6 +121,31 @@ static int aie4_link_vf(struct amdxdna_dev *xdna, struct pci_dev *pdev_vf)
 	return 0;
 }
 
+static int aie4_check_vf_alive(struct amdxdna_dev *xdna, struct pci_dev *pdev_vf)
+{
+	struct device_driver *drv = READ_ONCE(pdev_vf->dev.driver);
+
+	if (drv && drv->owner != THIS_MODULE) {
+		XDNA_WARN(xdna, "VF:%s is in passthrough", pci_name(pdev_vf));
+		return -EBUSY;
+	}
+
+	if (!pm_runtime_suspended(&pdev_vf->dev)) {
+		XDNA_WARN(xdna, "VF:%s is busy", pci_name(pdev_vf));
+		return -EBUSY;
+	}
+	return 0;
+}
+
+int aie4_vfs_alive(struct amdxdna_dev *xdna)
+{
+	if (pci_vfs_assigned(to_pci_dev(xdna->ddev.dev))) {
+		XDNA_WARN(xdna, "VF devices are being used in VMs, cannot suspend");
+		return -EBUSY;
+	}
+	return aie4_for_each_vfs(xdna, aie4_check_vf_alive);
+}
+
 static int aie4_link_vfs(struct amdxdna_dev *xdna)
 {
 	return aie4_for_each_vfs(xdna, aie4_link_vf);
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index 1d0b91e73260..4933962844f9 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -467,18 +467,27 @@ static void amdxdna_remove(struct pci_dev *pdev)
 
 static const struct dev_pm_ops amdxdna_pm_ops = {
 	SYSTEM_SLEEP_PM_OPS(amdxdna_pm_suspend, amdxdna_pm_resume)
-	RUNTIME_PM_OPS(amdxdna_pm_suspend, amdxdna_pm_resume, NULL)
+	RUNTIME_PM_OPS(amdxdna_pm_runtime_suspend, amdxdna_pm_runtime_resume, NULL)
 };
 
 static int amdxdna_sriov_configure(struct pci_dev *pdev, int num_vfs)
 {
 	struct amdxdna_dev *xdna = pci_get_drvdata(pdev);
+	int ret;
 
 	guard(mutex)(&xdna->dev_lock);
+
+	ret = amdxdna_pm_resume_get_locked(xdna);
+	if (ret)
+		return ret;
+
 	if (xdna->dev_info->ops->sriov_configure)
-		return xdna->dev_info->ops->sriov_configure(xdna, num_vfs);
+		ret = xdna->dev_info->ops->sriov_configure(xdna, num_vfs);
+	else
+		ret = -EOPNOTSUPP;
 
-	return -ENOENT;
+	amdxdna_pm_suspend_put(xdna);
+	return ret;
 }
 
 static struct pci_driver amdxdna_pci_driver = {
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index 45170c945d71..8c735f184f00 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -57,6 +57,8 @@ struct amdxdna_dev_ops {
 	void (*debugfs_init)(struct amdxdna_dev *xdna);
 	int (*resume)(struct amdxdna_dev *xdna);
 	int (*suspend)(struct amdxdna_dev *xdna);
+	int (*runtime_resume)(struct amdxdna_dev *xdna);
+	int (*runtime_suspend)(struct amdxdna_dev *xdna);
 	int (*sriov_configure)(struct amdxdna_dev *xdna, int num_vfs);
 	int (*hwctx_init)(struct amdxdna_hwctx *hwctx);
 	void (*hwctx_fini)(struct amdxdna_hwctx *hwctx);
diff --git a/drivers/accel/amdxdna/amdxdna_pm.c b/drivers/accel/amdxdna/amdxdna_pm.c
index 9c030b7836fb..2b4ce301bb96 100644
--- a/drivers/accel/amdxdna/amdxdna_pm.c
+++ b/drivers/accel/amdxdna/amdxdna_pm.c
@@ -37,11 +37,40 @@ int amdxdna_pm_resume(struct device *dev)
 	return ret;
 }
 
+int amdxdna_pm_runtime_suspend(struct device *dev)
+{
+	struct amdxdna_dev *xdna = to_xdna_dev(dev_get_drvdata(dev));
+	int ret = -EOPNOTSUPP;
+
+	guard(mutex)(&xdna->dev_lock);
+	if (xdna->dev_info->ops->runtime_suspend)
+		ret = xdna->dev_info->ops->runtime_suspend(xdna);
+
+	XDNA_DBG(xdna, "Runtime suspend done ret %d", ret);
+	return ret;
+}
+
+int amdxdna_pm_runtime_resume(struct device *dev)
+{
+	struct amdxdna_dev *xdna = to_xdna_dev(dev_get_drvdata(dev));
+	int ret = -EOPNOTSUPP;
+
+	guard(mutex)(&xdna->dev_lock);
+	if (xdna->dev_info->ops->runtime_resume)
+		ret = xdna->dev_info->ops->runtime_resume(xdna);
+
+	XDNA_DBG(xdna, "Runtime resume done ret %d", ret);
+	return ret;
+}
+
 int amdxdna_pm_resume_get(struct amdxdna_dev *xdna)
 {
 	struct device *dev = xdna->ddev.dev;
 	int ret;
 
+	if (!pm_runtime_enabled(dev))
+		return 0;
+
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret) {
 		XDNA_ERR(xdna, "Resume failed: %d", ret);
@@ -55,6 +84,10 @@ void amdxdna_pm_suspend_put(struct amdxdna_dev *xdna)
 {
 	struct device *dev = xdna->ddev.dev;
 
+	if (!pm_runtime_enabled(dev))
+		return;
+
+	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 }
 
@@ -66,6 +99,7 @@ void amdxdna_pm_init(struct amdxdna_dev *xdna)
 	pm_runtime_set_autosuspend_delay(dev, AMDXDNA_AUTOSUSPEND_DELAY);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_allow(dev);
+	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 }
 
diff --git a/drivers/accel/amdxdna/amdxdna_pm.h b/drivers/accel/amdxdna/amdxdna_pm.h
index 3d26b973e0e3..26df3d50d8ea 100644
--- a/drivers/accel/amdxdna/amdxdna_pm.h
+++ b/drivers/accel/amdxdna/amdxdna_pm.h
@@ -9,7 +9,9 @@
 #include "amdxdna_pci_drv.h"
 
 int amdxdna_pm_suspend(struct device *dev);
-int amdxdna_pm_resume(struct device  *dev);
+int amdxdna_pm_resume(struct device *dev);
+int amdxdna_pm_runtime_suspend(struct device *dev);
+int amdxdna_pm_runtime_resume(struct device *dev);
 int amdxdna_pm_resume_get(struct amdxdna_dev *xdna);
 void amdxdna_pm_suspend_put(struct amdxdna_dev *xdna);
 void amdxdna_pm_init(struct amdxdna_dev *xdna);
-- 
2.34.1

