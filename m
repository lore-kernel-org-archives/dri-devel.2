Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A98FCA5FFD
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 03:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 582D010E71C;
	Thu,  8 Oct 2026 03:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gOWeLzHt";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011016.outbound.protection.outlook.com
 [40.93.194.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47D4810E71C
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 03:24:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmDloAYQXV7iN5EQniae6ToQ14hQjNnYJw7bAHEDsly+UDz+lrFvBmDQ8hl2aoZWFDN7NOMVTVWlwmgKCgrTNj5mweUH7695dwOmKA2mxsk/5Sz+2q61p2d+5hSoMMhbArB0n5Yf70n0ejq7PSL8UdFNE2UqNI5g0GSfLa3zEZ4H9PIicUMvNOqITBFmBj2hW7fcBX49ltv7POzTQHPHYln5AeOtXJQ4XVihBYZY+mmnl66RJLGa5HoK0GhBZrVOgWzF9G2yAYcWJcz+6xcWL4+SE9PBSukpeQltwfQMn3ChgsV5Ii5/6vdFfLVTWCp2QBrtNYWSKmE9lLJ470ULeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFjCheQDIu68iXHTjO+WkPN9myf4uczPEjGs8tsWE+k=;
 b=LFH8Tca48E3l8/CAIdBMOH9w51CZbb08ZX8xhmTAI4sj+PR7yU9USiLIDPXCexevEZ+7H2E0PwGtj1THbeZXEJc9b+3TR81BNP9wD66YnNYW/L+K3W37CBH2p0LIXrp++paDtCfJxKstVNiDQ9qZta9cVFO8vl06vbOtgTzzqfE1LT8VfLpgfPe9yCHPvHht4sB3ROeZOXHx++BG2NYV0+KNkZgln+aUuyBFE7acMloc7FlbwMNkAzTU+EabMgxi1y7HYPH3vpMdLXq8JSqkZuozxzks+dEltPNlZn9uqP4oONWdYOlP44Hw0MgT1K5Ak7TI9BldQS6pu+I24EeZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFjCheQDIu68iXHTjO+WkPN9myf4uczPEjGs8tsWE+k=;
 b=gOWeLzHt8n3LJaoxf3b15OmVbgLjzFIXk/IDwD12mXho8V+th/LGJboP9AZWgq6vC9J6LSF49zwFO33lwuRYmSRWtZYHcui8J4X4JZE+HTXOlXEPtMKlJS0Kic7IEU3Y4GOsdcf6ojOFApLuBRUtYijmekAph4VZZuNNj78APuk=
Received: from SJ0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:33b::10)
 by CY8PR12MB7754.namprd12.prod.outlook.com (2603:10b6:930:86::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 8 Oct
 2026 03:24:19 +0000
Received: from SJ1PEPF000037AC.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::58) by SJ0PR05CA0005.outlook.office365.com
 (2603:10b6:a03:33b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 03:24:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AC.mail.protection.outlook.com (10.167.244.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 03:24:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 22:24:12 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Wed, 7 Oct 2026 22:24:11 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V3 19/19] accel/amdxdna: Implement runtime suspend and resume
 support
Date: Wed, 7 Oct 2026 20:23:48 -0700
Message-ID: <20261008032348.2044667-20-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008032348.2044667-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AC:EE_|CY8PR12MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: 52323cd4-5a6f-47e1-c781-08df24eba3e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pvmJUFpi1RGLtRJ+Hhq8vvPc28R4eJwnfdi2FROE4vG5R6iQySXO4iftYkKqtyhvCh6oBDqqViYw0+aNERCsnI6O6DgDkw9shIEfB97fOhjYqes3P5FOBe955y7Huwin6vBPhtO25OIb+z4INpLoTV+XtVNC3iVqgql4QfZWE6LEDXkaxtuD1yTXslHXCM3w7x1yyzDGyUSxKcSukBBcuukJKB4V8hmTX7eRGNyu95lvSsz2Fj8cwulZzZ6TL40PBFsIeJLNZYgLUh2gOglH84Wuq4kOTPTD5VQCNX/y1A+qn8rCjYZcK4pJB615hgpr9tUv4vbO2c/Y7aDjSs4CkGvHjqXz8M7e1/wSoSJJ5jePrcjLsz6OlnKNjHnMVQE0Pb+ABI9IlmAzy4lmT7mwZDk4HwVcc4XhV4cFqDxE+8Hum6819BFq3oTSYqYIEh3yDXMRIhWpd32/4QWjaFXTOPmIdCPPffSoPTnyoA/s2zJvyFZfuHW+0MlbB/xl1GKb5NqfIlEwhd3Z5fIjtgK+67UsioawCWWi8bpvAIkER9zhIyWupw+XcChpi0T6PTeHh9Vwhk+dROUYK0VAJ3k5j2au72NZJE50KHY3zX0JvYoJcXqdf86cl2RjbghOhVzk+o4h5QDyNbA6VFgQVLrn23LLWHi66zFBroaqnFna9T07Ek8Se/nfuXAyCwExGSz1Iy8gxZayuI7XZheoNWxmag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2YjKjayUCWvUabrmjreSeelSslPxe/FPeODM8WtDxvaaOs+E1IdpCEz/KY6y+RSUORJ/nDWzePv0LEp+lHIhGMx+tGw7B53OJ2KJjqK6XIuacvI5V7laC9O8GTROzU1SFSYx3z5TzS1sBhCp4s8YpqQ5vfgtZqaduBwBBZU8yPRwtIWsgiGVlwHxU3MqFfqfISYzzhWEeVJHyyQwTuW5IW22s3XjV3qkihueeOt3888/SLGDmQFsKUoVGU2SrdIwa7zrdLdWCAReDX7PCs603Jqr9yDr7RvDAGG8dRJWIF6/oLCgeoAWXGbVx3WEt3JTgOTvbL65uf7N4Q8RYLtzHsMWrUfaayvfeae5Wjo7FQxt85HNiAr3gl7ijHdO9liECuN8779B2LKR0xSzkw3JdSAcv7mv3KfeUai7ldng64gNErd2OrrfBCAvu0vihDLx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 03:24:19.5118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52323cd4-5a6f-47e1-c781-08df24eba3e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7754
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

Add runtime suspend/resume for the AIE4 classic device by using its
system suspend/resume handlers.

Runtime suspend returns -EBUSY for a device without runtime_suspend,
so the PM core keeps it active instead of entering an error state.

Wrap .driver.pm with pm_ptr() to allow the dev_pm_ops structure and
its callbacks to be discarded as dead code when CONFIG_PM is disabled.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie2_pci.c        |  2 ++
 drivers/accel/amdxdna/aie4_pci.c        |  4 +++
 drivers/accel/amdxdna/amdxdna_pci_drv.c |  4 +--
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  2 ++
 drivers/accel/amdxdna/amdxdna_pm.c      | 34 +++++++++++++++++++++++++
 drivers/accel/amdxdna/amdxdna_pm.h      |  2 ++
 6 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 3d9ddd40908d..7f56514c5e26 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -1220,6 +1220,8 @@ const struct amdxdna_dev_ops aie2_ops = {
 	.fini = aie2_fini,
 	.resume = aie2_hw_resume,
 	.suspend = aie2_hw_suspend,
+	.runtime_resume = aie2_hw_resume,
+	.runtime_suspend = aie2_hw_suspend,
 	.get_aie_info = aie2_get_info,
 	.set_aie_state = aie2_set_state,
 	.hwctx_init = aie2_hwctx_init,
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index a368bd3c257f..ee64a5f3405d 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -1040,6 +1040,7 @@ static int aie4_classic_init(struct amdxdna_dev *xdna)
 	if (ret)
 		goto free_work_buf;
 
+	amdxdna_pm_init(xdna);
 	return 0;
 
 free_work_buf:
@@ -1063,6 +1064,7 @@ static void aie4_vf_fini(struct amdxdna_dev *xdna)
 
 static void aie4_classic_fini(struct amdxdna_dev *xdna)
 {
+	amdxdna_pm_fini(xdna);
 	aie4_classic_hw_stop(xdna->dev_handle);
 	aie4_free_fw_log_buffer(xdna->dev_handle);
 	aie4_free_work_buffer(xdna->dev_handle);
@@ -1403,4 +1405,6 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
 	.set_aie_state		= aie4_set_state,
 	.resume			= aie4_classic_resume,
 	.suspend		= aie4_classic_suspend,
+	.runtime_resume		= aie4_classic_resume,
+	.runtime_suspend	= aie4_classic_suspend,
 };
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index f5f7831c4e80..cb78f145ffa1 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -465,7 +465,7 @@ static void amdxdna_remove(struct pci_dev *pdev)
 
 static const struct dev_pm_ops amdxdna_pm_ops = {
 	SYSTEM_SLEEP_PM_OPS(amdxdna_pm_suspend, amdxdna_pm_resume)
-	RUNTIME_PM_OPS(amdxdna_pm_suspend, amdxdna_pm_resume, NULL)
+	RUNTIME_PM_OPS(amdxdna_pm_runtime_suspend, amdxdna_pm_runtime_resume, NULL)
 };
 
 static int amdxdna_sriov_configure(struct pci_dev *pdev, int num_vfs)
@@ -484,7 +484,7 @@ static struct pci_driver amdxdna_pci_driver = {
 	.id_table = pci_ids,
 	.probe = amdxdna_probe,
 	.remove = amdxdna_remove,
-	.driver.pm = &amdxdna_pm_ops,
+	.driver.pm = pm_ptr(&amdxdna_pm_ops),
 	.sriov_configure = amdxdna_sriov_configure,
 };
 
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index 505477b4a292..4d047cf3d981 100644
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
 	void (*hwctx_stop)(struct amdxdna_hwctx *hwctx);
diff --git a/drivers/accel/amdxdna/amdxdna_pm.c b/drivers/accel/amdxdna/amdxdna_pm.c
index b1fafddd7ad5..7d7bc965342d 100644
--- a/drivers/accel/amdxdna/amdxdna_pm.c
+++ b/drivers/accel/amdxdna/amdxdna_pm.c
@@ -37,11 +37,40 @@ int amdxdna_pm_resume(struct device *dev)
 	return ret;
 }
 
+int amdxdna_pm_runtime_suspend(struct device *dev)
+{
+	struct amdxdna_dev *xdna = to_xdna_dev(dev_get_drvdata(dev));
+	int ret = -EBUSY;
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
index 3d26b973e0e3..02beef6448f1 100644
--- a/drivers/accel/amdxdna/amdxdna_pm.h
+++ b/drivers/accel/amdxdna/amdxdna_pm.h
@@ -10,6 +10,8 @@
 
 int amdxdna_pm_suspend(struct device *dev);
 int amdxdna_pm_resume(struct device  *dev);
+int amdxdna_pm_runtime_suspend(struct device *dev);
+int amdxdna_pm_runtime_resume(struct device *dev);
 int amdxdna_pm_resume_get(struct amdxdna_dev *xdna);
 void amdxdna_pm_suspend_put(struct amdxdna_dev *xdna);
 void amdxdna_pm_init(struct amdxdna_dev *xdna);
-- 
2.34.1

