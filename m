Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D354CA5FFE
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 04:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E41B110EF8E;
	Tue,  6 Oct 2026 04:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SOoTfiTB";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0263210EF74
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 04:23:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmeSEtd6W5J1XKAMsybAAn617xr/MmF/Y9TshJ8Ks98GdQIrwV3/r7k+ZajoGh8/dmO5kJ8TPxW53jCfMCFwZsj+xV/z2arZusxmZjq1eYcfna+2lWFgKWYgUjq29lmzS7eJPqZMXmfjoPesq2njbx+EJRPH+atCJtcymQrlyQTMmbPsspu1vD2JxqJd1I8xijXjSGt85RvKco/HehZUBK7XNCKfQjxbDi+Y3Qu9svd/hV7uvTp/icm2G342gDXN8LVEl7QHG7Y0PRyrSaN90//68TfMILnu+yZ6Pe6B2F5Ur36KJqqObiDvCSTV7gGoI5uBo9taO/deSQIH7zfpDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p28TTDfB3VT3YtyDawsczzsp/uTuE87VbqG0iMbGfI0=;
 b=XBuwBU1MPQUuj3l0ffn00ytlIF9dzZn44YTRyUyxrE5/as+8Ug/nbhEWZVm6/nRtlunseUoQlhSZbrSOiGxT1fawxG8DgAkzy3nsYJvF78MsDEdfmXjHbBKd0/cDIHyXRvhrdaGkRhRW5Dt5TO+0W2Me/WPqruhsZ7Iqp5m3m7pmQYfKB3Q4HeYIWK2j4s5xBlIm+vJIg8q8OyWtYyklE2C+i6adjkKP2KxUFjfHCN/o73KO+T0pd56+iE6Dlod25rGAmWolz583NBuNwljFSUWizXQG95quc77IDp2JW8f0JZzESZxj3qpWjP4aST9aUn+05aapNAwQwsHo25A8Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p28TTDfB3VT3YtyDawsczzsp/uTuE87VbqG0iMbGfI0=;
 b=SOoTfiTBnu81b7oY5pF5/WUknRQ+o6T/FtZYGjkJuKdX8pqLZMXdybn3ATYcZnAwKVfQTZ3kXwHWLip1RwdcxTxD2mNwOBXNJeyq1iasveu+vgCic27+MqDSTvONwQP11+cZGD6eB9Jjne6EIukYVOWY1xc6v9NOQBTJMs3IHeg=
Received: from BN9PR03CA0141.namprd03.prod.outlook.com (2603:10b6:408:fe::26)
 by CH1PPF189669351.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::608) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 04:23:00 +0000
Received: from BN2PEPF0000A7FE.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::5) by BN9PR03CA0141.outlook.office365.com
 (2603:10b6:408:fe::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 04:23:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A7FE.mail.protection.outlook.com (10.167.245.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 04:23:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:22:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:22:59 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Mon, 5 Oct 2026 23:22:58 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V2 16/20] accel/amdxdna: Finalize runtime PM before acquiring
 dev_lock on removal
Date: Mon, 5 Oct 2026 21:22:26 -0700
Message-ID: <20261006042230.547807-17-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006042230.547807-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261006042230.547807-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FE:EE_|CH1PPF189669351:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a9ea3a-0d0f-4943-5abb-08df236181bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|6133799003|22082099003|18002099003|10067099003|4143699003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: 9NQx9RNVmea71cwbI2gAh0GsyEWHYOHY0jQ1ZLmyKywzrzXhe2p9Nk3ZsFHBKr/3/0AeM+zVGlntNBQq9aXPBsx7jGVKtt0plnBviWAJWv5KE+RELJPA+CZASbLKTaq8basgN78c9JVxUbq3M/8T8GULYu43SJnhOSJjejtAxGuskGaVMRb9um7NlyFKgVLEpGGSTIeOxPKMRzYM8iCuQiicM2jeJnC96kXk7BbMu6TjMI+dSoFgXbiQZk2g6BYYc9enR2xNw3ombEZWFTL9KVSdJ8ZF8+li4ALDW661XOaz9QmanZO/rPOqgLRHO3hSPfbtUb7TnCUVbSvODlxfJf7kHFCeTfvouvjfxtTEQjh7YhlcYXzvdT4uwYplbMHIITFd2uLskXsWY84SYZwS+UG9u+axtD0gnMuYVcoxspYWKu3Ham/XLxFjvVuOJfRYtDRzNDqMM+LMF/avtmqjPTTGe3OPuH9PodV1QxhdQ4PscsaDOHSpLj7vQViWHYL8QromMminb/m9GAdIjxbSFMwWRth1iSmi0cho8CN6tx2qiRJPpXfsU4OGQGOb0rs1sY2Mno4Y69/yykaib86YfkTaOcR+cHkH/CQMdfYsshGAYmGgwJDaV1sciOOxsfbBld6NKlVeTMSq+6EfurMvgy9qZBrMKkfff9adxilFPI1OF3lS0Vd3kr5yTwzefWUnuBTFYP6dfxh83dCsIV6dLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SwMEkD03lMGfOPifdbKKjA0u80rAfnvLZBDrvD9+73JGG/vLqQvO37wKhSzQ2WDpKaTOcH7KvXXi2/u+Wg5U8D3mLA97QPg2oxXsgvP+lxT1PKek3rhdQlrJvzMr5QzUnmrNbvlw4eMMgkjV6yoiKuGXteArO4kPPtwfpCwnVobV1NvzZcjz09unqcSqGrn9Itrs62fCOy60tLPmCvYA9uij7x0BQjZvQquBrD0Dw0pCnNhvEH0hZLIUgDSYHPfbt/a705YT9ipaw+Zsqb16ygEoluEcVHgjsxxgnGNL0taCua96pPoRNgDHOWUN75/COwixKFlszkon1TvO5zeRM9fdZOPdl3cBkwc2nxKQpXeSE9NsivL6J48OO7i6bQjWgzUIqqwP53Jy7Jlre9DXukqyV45gNKY3SfZV3+Svx65INaUbLq/HF+iALMcpG8Q5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 04:23:00.4947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a9ea3a-0d0f-4943-5abb-08df236181bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF189669351
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
index c4e916e832cb..bee3d973e6bc 100644
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
index f5f7831c4e80..8faf651fb534 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -415,6 +415,8 @@ static int amdxdna_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto iommu_fini;
 	}
 
+	amdxdna_pm_init(xdna);
+
 	ret = amdxdna_sysfs_init(xdna);
 	if (ret) {
 		XDNA_ERR(xdna, "Create amdxdna attrs failed: %d", ret);
@@ -433,6 +435,7 @@ static int amdxdna_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 failed_sysfs_fini:
 	amdxdna_sysfs_fini(xdna);
 failed_dev_fini:
+	amdxdna_pm_fini(xdna);
 	mutex_lock(&xdna->dev_lock);
 	xdna->dev_info->ops->fini(xdna);
 	mutex_unlock(&xdna->dev_lock);
@@ -448,6 +451,7 @@ static void amdxdna_remove(struct pci_dev *pdev)
 
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

