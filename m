Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1352ACA5FBB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A17F10F162;
	Wed, 30 Sep 2026 03:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5fMHi81E";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010052.outbound.protection.outlook.com
 [52.101.193.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80F2210E9E0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:33:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULr2bAgHyAyfeKg+SlZK8HkckHuQQ7rBo8QQteYlqznb+O7moMwxIWIwW7gYAHxUjWDADqgixRDCtaYDwndAAmVHyYmvuxmIoMHmZU5udUSRekUtjv6sVMEszsPBhcHXspbY6KryIWOazq174CgeNKxBigXRgsrDvM/7PGN2eVqI0VpVKYPetyxO80CgjXcFMZaK9uF23FeVet3TlbGxw14xmFCr+znvdYgjTK/5JX1D1dMYQBEWBOlaes/5DUcD3qj7A8rG6IzhAFB+8vUDfJ72GLkDD6XtrXhH4sio9CyfKSjgzefm8UzEKG+Y3LMS0uSJzBmuh40FmO1VrdZkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HA0zttWW/ehuxxC6lucK0ylCrr2dbLjo6l5uDPINy9Y=;
 b=vX7Z0k9gUKW3vgOXqXPtZtXOVFHcDi6w7OTqcXwcGiEEivyUcFi2FtlClsEL1j+sV1PWkj8gTiDe6PkoT6LYd5aRwdTdaPNBa9iFKd62aY0vWLNGiGX87v4TqaD3QQVNvXMiRSMkZ0TrTAcH0TSg6X8xa8gzdDYDUQa2zHhlXVzLl/sLf2tEP0RyvAduaqivEuc/uiJvVM2co1NqKbYFmDbUv3LyJhJB01oa5F0pZeJO4uxiJRfval0buBV6Xq2YSRIQoKruzaR36RXRMBjh+D6Mih/7RCnT8K/Mc1mtMr7B0CGdWO5c5kRFUsP+Ru/vYNRDjLF0ZKH4iYpXD3dhog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HA0zttWW/ehuxxC6lucK0ylCrr2dbLjo6l5uDPINy9Y=;
 b=5fMHi81EvotslTz4J3rjDXFVca3Lrh/cLJlS6vHZN8LRN8l+G7+iJfbll5lkKC0+G6m1Bs08RGQ8YQRTqWVBNP3LSrE9JoKQ/qayb5Woe4qHhDmkyzi1HMgUfA7CubEEK2DB6l6jfQQx+O3cWmWtig6BljDC5vTXANSXp5nK+EA=
Received: from CH0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:610:32::22)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 03:33:03 +0000
Received: from DS2PEPF000061C1.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::2) by CH0PR07CA0017.outlook.office365.com
 (2603:10b6:610:32::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 03:33:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF000061C1.mail.protection.outlook.com (10.167.23.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 03:33:02 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:33:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:33:01 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Tue, 29 Sep 2026 22:33:01 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V1 15/20] accel/amdxdna: Finalize runtime PM before acquiring
 dev_lock on removal
Date: Tue, 29 Sep 2026 20:32:28 -0700
Message-ID: <20260930033233.1727265-16-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930033233.1727265-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C1:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce51d9d-67a0-4aa9-e377-08df1ea38883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|6133799003|10067099003|5023799004|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Cox1SWN8k91pZF67AhlXzNQv1Xg9zOVkUyRI8h56R1Tfdhp6wmDZYij5LG7FYHmzL4p5bQEnm8Qh0y2qCdOBdEJO3ouGE58D6MnqRlEeOd4GdkkC2YTFXW7tAxfl3xya7Dokjf7Ij7NOAo1E/7CUGe7si/TkCDdnuOAJs97szqnAS2FqcyUnnqXSMn8Lp1lxod1AUKKjqjnM5MkFCYpX9ANeTo7myBpmO5sGfKg03CfzuWuzrCmK3HDSfmlUTcuD3ngpQ8IB/Btr6eTR3cbJBqLbcLuN+SgV2rzAsjDwOvdfKIRy5Gkv3sfL6mlNtuIi+fV/LYbcQAyUOtvA9Rnlp9qJSTvp1S3fI9B0BHhkQZHYpPXtLvjtse0Xo+CroVieAXP22u1FJ62K7Aq+OHJVIuEyae+LICFxMI8lAwPdu1ywjLF0Mjo92QE5Ie9pRQ3MWX84IOpuyjYewmUhFQnRf5AaX8rADf/I+MU6+7t3VWskogahvY5D5y20IBZRaf3tvBOWUbjCn1JL/Qwg+B8DY99ZYeBUKxoqo+qRWAJwG6qXbQ1OGM96VJG/GVoY+kbYnueYVcZjggSoLU/1KSTDks+1FNh4lGI+SCtYAiRoKNU4hlKbDEbIGRJMAUaielDVdm4gwpbGeZrIiVcrCoPdsQgm2+3G4Rj4Pg1m04rBIP0arhYiVy3qjmEtdwrBLeWdFsHyN8mP0S/lJCTCZFV/Ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(6133799003)(10067099003)(5023799004)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oenluqp+bnWM6BeX1AFP7fRPG/R/Tix25lqKeHtEIEnFzD524u/pg6rjPRMpIOwda6LwM0ywpc4UPIqiAEKoOPEHpb+X1Jk1Hl8BVNpRmqdhq4M5FuXK3guaXqXhK1viPDFBxH5uotDWdJ+cNqvWMyWg0CFCWGN8/UxguRURgn4mF+wYNql4rpROC25F4ZVAwerMHYiOncrPRrxSfa1ilvVVZYfFaqGcNj22tFKiPdkn6ZMg6wHx3zvsYo5rb/o/JozkqY/IjJHdtcVcbu7Dej3fn3CZi7Vn7EVBovoBtzk7nt7zip6PjPATnKwBe3GTmGQXX8B1vuDIe5nVUeqPVS9fZ8Dz62/wnWR9bJjpcVBYMcEoUMXRdoo7LVjO0bOJeQrK5hJHpBw8nnLD0hP7PeYAvSf6De81nuuy4r+Xcn5eiq1VB4s/RMPa6wZgE1gR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 03:33:02.8174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce51d9d-67a0-4aa9-e377-08df1ea38883
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273
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

When the device is runtime-suspended, pm_runtime_forbid() synchronously
resumes the device via rpm_resume(), which invokes
amdxdna_pm_runtime_resume(). Because amdxdna_pm_runtime_resume()
acquires dev_lock, calling amdxdna_pm_fini() inside ops->fini() while
holding dev_lock in amdxdna_remove() causes a deadlock.

Move amdxdna_pm_fini() out of ops->fini() and invoke it before acquiring
dev_lock in amdxdna_remove() as well as the probe failure unwind path.
Also call pm_runtime_dont_use_autosuspend() in amdxdna_pm_fini() to
disable autosuspend upon teardown.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie2_pci.c        | 2 --
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 4 ++++
 drivers/accel/amdxdna/amdxdna_pm.c      | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index b70af1923643..0d209b7b6484 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -623,7 +623,6 @@ static int aie2_init(struct amdxdna_dev *xdna)
 	release_firmware(fw);
 	aie2_msg_init(ndev);
 	amdxdna_vbnv_init(xdna);
-	amdxdna_pm_init(xdna);
 	return 0;
 
 stop_hw:
@@ -638,7 +637,6 @@ static int aie2_init(struct amdxdna_dev *xdna)
 
 static void aie2_fini(struct amdxdna_dev *xdna)
 {
-	amdxdna_pm_fini(xdna);
 	aie2_hw_stop(xdna);
 	aie2_hwctx_sched_fini(xdna->dev_handle);
 }
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index 8b6e7283e057..1d0b91e73260 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -413,6 +413,8 @@ static int amdxdna_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto iommu_fini;
 	}
 
+	amdxdna_pm_init(xdna);
+
 	ret = amdxdna_sysfs_init(xdna);
 	if (ret) {
 		XDNA_ERR(xdna, "Create amdxdna attrs failed: %d", ret);
@@ -431,6 +433,7 @@ static int amdxdna_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 failed_sysfs_fini:
 	amdxdna_sysfs_fini(xdna);
 failed_dev_fini:
+	amdxdna_pm_fini(xdna);
 	mutex_lock(&xdna->dev_lock);
 	xdna->dev_info->ops->fini(xdna);
 	mutex_unlock(&xdna->dev_lock);
@@ -446,6 +449,7 @@ static void amdxdna_remove(struct pci_dev *pdev)
 
 	drm_dev_unplug(&xdna->ddev);
 	amdxdna_sysfs_fini(xdna);
+	amdxdna_pm_fini(xdna);
 
 	mutex_lock(&xdna->client_lock);
 	mutex_lock(&xdna->dev_lock);
diff --git a/drivers/accel/amdxdna/amdxdna_pm.c b/drivers/accel/amdxdna/amdxdna_pm.c
index b1fafddd7ad5..9c030b7836fb 100644
--- a/drivers/accel/amdxdna/amdxdna_pm.c
+++ b/drivers/accel/amdxdna/amdxdna_pm.c
@@ -75,4 +75,5 @@ void amdxdna_pm_fini(struct amdxdna_dev *xdna)
 
 	pm_runtime_get_noresume(dev);
 	pm_runtime_forbid(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 }
-- 
2.34.1

