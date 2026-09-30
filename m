Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32498CA5FAB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8687310F160;
	Wed, 30 Sep 2026 03:34:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="03G4/ey0";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1341810F160
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:34:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NH2jiL6aX8frJ+f4bHSu7ha6gcX/5qEZ14xVTnklZ0jj/coxOmqwFIfLhIi8Nlej8ZRKFDEjdVFp1SojsQtEnv/fzbe7ml7z4t9FNwuYiTmEzk60qN3KJ8irEiGjd/houx56hAB9tCf0GOGJYOVHaYr2FF2puRiaDpCFAqMI2P5ahJ18/9CM1HAuXk8FfLy1xhCuPEdiQ7Mq22++MwL8QrtJK6PSfLVv3oX4uLIqNL1gJym8zqeVQKH9FxZ1JKuShGnpcT96m+bgZa1x1/g+mRGOCGJRkJ5u2RUegVZtX4IjVO6LsD+2NqmCdC42SlQ5Z5PMRqc2NWWbJTIMIN0rLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhjynweuZ+1Fq531tz10LojinaqkQvTsUwWe8y4KF54=;
 b=lPQslc2NBdx1sdEcfR8ci4nGRRp/sA9vY4SG3weW9L1RZBpFrlTuxo9R+XGe9lO1BrSCOY5CdCMLaTGi6ak420PQX5HFe+Dz0dkZLgZIal8Ved5+v08D7YkXPvYOExGQ4Aw6YJ5sTeqk/2i0ehtyy5RSse6nFjmvR5F6rWPwfzhP/uR4EiSLlarherHCpZD0UPckkfYt0KOtC+5DyRvF0PGNwoakyCcJSm4R9IlXwveUJ9e9ybZcO3p2FkU1aHVYuUxFxMPumgcjoVTuzEIavm4/ao8yy+qjkk4FsNR9hZ9efksSNQHxPGaYcq3mQgoim6juyaXp27D7E0hrAKBfdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhjynweuZ+1Fq531tz10LojinaqkQvTsUwWe8y4KF54=;
 b=03G4/ey0JSJ+1C5sEqw1v4uAsAOsd5L+qLaSr8tEmjx6xcGjX0gPEGwfzPzwzZabQf6ua82vOfpVymQJNmxep77ONitAKlUJt6YkTaEL5AD+ogA6vqwjxL+p1TUWqy1xhKoOv6ZWr8setg4atr1cGUqleXfRWx/xtzqqtVylfSA=
Received: from SJ0PR03CA0346.namprd03.prod.outlook.com (2603:10b6:a03:39c::21)
 by SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 03:33:11 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::a1) by SJ0PR03CA0346.outlook.office365.com
 (2603:10b6:a03:39c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 03:33:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 03:33:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:33:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:33:04 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Tue, 29 Sep 2026 22:33:04 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V1 18/20] accel/amdxdna: Implement runtime suspend and resume
 support
Date: Tue, 29 Sep 2026 20:32:31 -0700
Message-ID: <20260930033233.1727265-19-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930033233.1727265-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|SN7PR12MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eea325c-e6c0-4c4a-efa8-08df1ea38d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|4143699003|10067099003|260925022911599003|260925021311599003|260925021911599003|11063799006|56012099006|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: V1Q4lzN9c5OWVBkPuOGjNghc45ziLY3MHwmv0r7BeTIssmB/XQ/HRvP+VQx5s3aOnYu0yxOgXdrMjBE5DiM2qy8eYcWDBDgiibvhJifCeYkAyMizrq3iI8dOxQUrIzOn/dt9cpiR+ag/j41TTTspwi35HOisvxwVhqoxcodTSiO+2ap7gclCT7chOYUUHE/dQITEOr6r5U0F77s9MOHRg6VpjkJ/2CAck/wdP2pw676PPJ+gKfVhAz8nTtP2OldzPPfBeCY/sr6KboINhejbf+D92KAUMsNGECV14PYPgUO9Sf3WfOOllDRTsA4R61yboACFobqUXcrjE6alxKwpgy3H53tatKuiE364+lVuWfloL7X/12tIHqjw/1D5DGctMX0FOTmltR2ltv3QPf+iyCi17HA/tIvXpselaNHtkAFeuovUY0nc8C47nLiV5RO0EjZFOup+6ybh3ix4ywCAZWXifG+JxJXKsjFSPRkxFGtVkWfhdpyUqYYkDEOmtKvdDtE5WIwV7MwIonEN0G1JvygqE7UnrE20UPd0ue9sOquyoY0QEW7nQVquEDLFMZRYW/w9E3jI3oLMOuNxsp1bHEGFfSqJ6a7et6J8At+R696xvGGFWCVkG6vSleBknvu02leq1NRNFZl/52pz4keDvX4WGK8C1O9j/SHoAX20iLn+Q698UGp4BIqCnEt/4DK0XsrhVioERy3QccnchQEsOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(4143699003)(10067099003)(260925022911599003)(260925021311599003)(260925021911599003)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bcYWCptWO95456d+k/h4ob8GkQKT5kRkeGvpdfzrTeDVm7m5SULIc7RIehb2WoAJA1hg1kIFQpDe9DizvdVMBcucTQpoqHsrIITfHsFuAP09Yji07hhEpeWxjhnDseW1MXalZi1+z1exB3eyvz6T1KL3pZ0f/UkwBj3RzGSoLbnapOUcYiwaKmk/9eZCd47/5syMh2vgUrbl1O6JweNP43F4rsA1r//FySaIbiKZ3EbKmLK3f96SgkBSrSPx7Q1uqijaABxfEelfZnaqFve2rKCG5IxkxEt+g/4Qj3jP92clShtHzeL5kQlmizXfBQju5pl1H36d3Llyy1zs8SaXgYwna2sHRFaAW5jiwGmX188iPVuZiGXdX2nKoVbfCFY3io2Cvn7EoKx8Ebj2tkh24oGhoflO6JaJqIn1zBLRzA9m7ZKXhE+oVsxfr5KZhNH3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 03:33:10.8055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eea325c-e6c0-4c4a-efa8-08df1ea38d47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147
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

Add runtime suspend/resume for AIE4 driver.

Wake and acquire an RPM reference across amdxdna_sriov_configure() so
that SR-IOV management commands execute with the device active.

Update amdxdna_pm.c to implement amdxdna_pm_runtime_suspend() and
amdxdna_pm_runtime_resume().

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
index 6a50c1499ec9..007b14be5245 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -1192,6 +1192,17 @@ static int aie4_pf_suspend(struct amdxdna_dev *xdna)
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
@@ -1244,6 +1255,20 @@ static int aie4_vf_suspend(struct amdxdna_dev *xdna)
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
@@ -1340,6 +1365,8 @@ const struct amdxdna_dev_ops aie4_pf_ops = {
 	.sriov_configure        = aie4_sriov_configure,
 	.resume			= aie4_pf_resume,
 	.suspend		= aie4_pf_suspend,
+	.runtime_resume		= aie4_pf_resume,
+	.runtime_suspend	= aie4_pf_runtime_suspend,
 };
 
 const struct amdxdna_dev_ops aie4_vf_ops = {
@@ -1354,6 +1381,8 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.set_aie_state		= aie4_set_state,
 	.resume			= aie4_vf_resume,
 	.suspend		= aie4_vf_suspend,
+	.runtime_resume		= aie4_vf_resume,
+	.runtime_suspend	= aie4_vf_runtime_suspend,
 };
 
 const struct amdxdna_dev_ops aie4_classic_ops = {
@@ -1368,4 +1397,6 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
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

