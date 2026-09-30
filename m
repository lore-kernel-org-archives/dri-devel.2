Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAFFCA5FBA
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AEC910E9EC;
	Wed, 30 Sep 2026 03:33:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uyRrWZfq";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA65810E9E0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:32:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXgQTQZrIfCMUecVwdysy8ywHLALmYkaIydPdCuqygnrzz4ZRwUeW2z/sSnxRh5BKDBTQZEFAP3nrmvnq5SR8w4J1430N8kJ6Y4XyWnYsc4Oxc2DJE7ARWxha0ZLtMhRi10O2lnNkKBNWtMgJB0IGSPujZ18XoFsL4HLuZwbjlQGqOWIbwRQUFpMSrlrYDUA38SZqLbQ91CZwbJ5UhTsNwYDKw3lJCmGFEB/4WIoHUQLLniM0Yq4Ua0zyPsFyEaTUIw/ciT/utvC8ZZ/oyRso6Xc/OwfNtKshEs2jgjxPCzyILZuudwwZlav1a7JmAXL3KUjeR2VjsmFJZ1m4T1uhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ByoS7oK0zCQ4rVcO3Rg5utKtvMo/eF5Dp6DYGgAl4g=;
 b=hvD3iyXKH9Yf2kJkzTGFBnOBU65CSBQDCeWT2MRQfCm0TJ5ApV8lrrCQwhhZAEgYEGcBQV+JpZ8/Irkv+zG451LsKHe0TeERlXfgl3wEjR3RQsbIJTdGGr8YVzHZV5yvjQynYTi5cHyT8nDq9NGzj+07xlt7F+WoaiWQm9z9vEsHsAuRQdDAUxnppTD3nbfkOsSZPMOW68xaIxSs9wbLE5XZuSd6b4TpF8gcNcAHpw6Fw+Aq/DGCOIuU4mGmlH8DFbvn8gaQGdg9IUzzegbAd00c31g998ls59v3pb+OQUwLfS5eNkUAe4J1/Lsxd4ksHzcp4JtUoL79EMBvPFHtpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ByoS7oK0zCQ4rVcO3Rg5utKtvMo/eF5Dp6DYGgAl4g=;
 b=uyRrWZfqMatWIMjrQdFGIStTgZ3taoA+ZNS6cbZgJIYFng8Ykt7/vQtlWvyJBqvY2hJUjyHaxs6795F+355L3ZecxZykqIZhFH3YXClWtzd3BwySQiY0IIbtuwlc5pYHvS5kxkY7bEApcfJUWW+iihhDhX62zLvFbJkiWbbXe/E=
Received: from SJ0PR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:33b::9)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Wed, 30 Sep 2026 03:32:52 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::14) by SJ0PR05CA0004.outlook.office365.com
 (2603:10b6:a03:33b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.11 via Frontend Transport; Wed,
 30 Sep 2026 03:32:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 03:32:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:32:51 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Tue, 29 Sep 2026 22:32:50 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V1 02/20] accel/amdxdna: Remove mmap for doorbell
Date: Tue, 29 Sep 2026 20:32:15 -0700
Message-ID: <20260930033233.1727265-3-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930033233.1727265-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: f03c432a-329a-48b4-b1fa-08df1ea38234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|11063799006|4143699003|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ppdM3EhZUTtBhxsh61WNsUXGo+zyGJYNShEPZtvWNLpg7o03Qitecm4hpbn4qrNtZm3/+EdVJN8QK6sWz/7hr2Vv8EJJrjfXgYmpo8y4dUlEAUl2hN0dSl1z5DZNGkb+vOGjx+F+5LI6AeDksK/HImgRWAq27BhgFpx8YAulDpuUSL74l2U4S9Z01xuhk1bPrB4/O/p8LYxX+iPRNXVb8vlRN4VJsLi1iDg8yfS+LFBqictu+9guoOjk7Ef/sJcgPdPJ4hkkgm4eVISTdIUt4PckvNkBhsoi6DJlaARJbTzD2CZUUv2XIgQNeo1/euBApLorkGovVpYtDvKwj21hWhHjTwS1i2mieBvE8jAihIug5vUUw1bYFKn+SpAau0Jor/6kcQh/FoAjoRR6IMHd0PPr5GK6sJbvVkyk4YsAqxgzxj3DppzW5eN686owKmoUeWPF2hDtu/obQs8fKMDuWUPsAKKVAbjvLiIfifGNOZlwgeoP5t04fjk76nPlVlUcFLxH+xVlP+17/e32/q0Hn8+CT27OITtW2yqYUbgomMWym2SI2f5YYKUFqVIAkY+x4eeyAZHhLjSAYCY7XVZXroeh9VyAeyEbZJCOf8xcDJbNflRLrrvEMmNFS3iXmMGXqATj/AcOTbdFNnkCc/q2H5A3giALMm39BS+AqeFFfN6L+9J6ulKWpqLaNke7L4KWfF6HuPAqIoyaNFi9KpBTjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(11063799006)(4143699003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JOffCY345AYGvYONWdAknugjhYq1OkszyBzlj4v9lYpxD0xTgHQ68rkEWxPx+tmX+fbkF8pCnqhHQMCUsH3BSpwHZ+hFXgJDUuXlUNltJhO1H5QHgVcfj2i5hPGlijiL6dIQSGBMzq6B4ySVgRr+mT8KZmwF1uGxcqcYFZtwiBSiVFTuisnRyzqNDa4tFHmDM8cgGj7qc9SVKryvSSg9nrkGVP4mmofBs/85cCr94uOCcy7wzYvM8VOOB7TPvuDX+zLDK7mRTZCgg+StJ4jrwAENcLT0g2bQ1SFMYX5wqyRtGSiLa6StPWsSwbFrUbn1ojSanu1dUk+TKohBwcILNcgOEHDXFVfOXdsoY0p3EbM9bm9EqEhdETCDobBVBvy4ADKQCpuwggvDVEFP4EnNth+U8lgdWeUx+KFegYLObxx81UVhrhRj4lbZpudKJ/6h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 03:32:52.1635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f03c432a-329a-48b4-b1fa-08df1ea38234
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271
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

Make kernel submission the default, so mapping the doorbell back to user
space is not needed:
- Remove .mmap handler and use standard drm_gem_mmap.
- Set hwctx->doorbell_offset to AMDXDNA_INVALID_DOORBELL_OFFSET on
  context creation so userspace does not receive a valid-looking BAR
  offset.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_ctx.c        | 20 +--------------
 drivers/accel/amdxdna/aie4_pci.c        | 33 -------------------------
 drivers/accel/amdxdna/aie4_pci.h        |  1 -
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 17 +------------
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  1 -
 5 files changed, 2 insertions(+), 70 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
index 8408b0d2696f..8157f2a6fd10 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -158,7 +158,7 @@ static int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
 	}
 
 	priv->hw_ctx_id = resp.hw_context_id;
-	hwctx->doorbell_offset = resp.doorbell_offset;
+	hwctx->doorbell_offset = AMDXDNA_INVALID_DOORBELL_OFFSET;
 
 	return 0;
 }
@@ -313,21 +313,3 @@ int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
 
 	return ret <= 0 ? ret : 0;
 }
-
-int aie4_hwctx_valid_doorbell(struct amdxdna_client *client, u32 vm_pgoff)
-{
-	struct amdxdna_hwctx *hwctx;
-	unsigned long hwctx_id;
-	int idx;
-
-	idx = srcu_read_lock(&client->hwctx_srcu);
-	amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
-		if (vm_pgoff == (hwctx->doorbell_offset >> PAGE_SHIFT)) {
-			srcu_read_unlock(&client->hwctx_srcu, idx);
-			return 1;
-		}
-	}
-	srcu_read_unlock(&client->hwctx_srcu, idx);
-
-	return 0;
-}
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index a58a83af42a4..db02d25e3f4a 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -518,38 +518,6 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 	return 0;
 }
 
-static int aie4_doorbell_mmap(struct amdxdna_client *client, struct vm_area_struct *vma)
-{
-	struct amdxdna_dev *xdna = client->xdna;
-	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
-	const struct amdxdna_dev_priv *npriv = xdna->dev_info->dev_priv;
-	phys_addr_t res_start;
-	unsigned long pfn;
-	int ret;
-
-	if (!aie4_hwctx_valid_doorbell(client, vma->vm_pgoff)) {
-		XDNA_ERR(xdna, "Invalid doorbell page offset 0x%lx", vma->vm_pgoff);
-		return -EINVAL;
-	}
-
-	if (vma_pages(vma) != 1) {
-		XDNA_ERR(xdna, "can only map one page, got %ld", vma_pages(vma));
-		return -EINVAL;
-	}
-
-	res_start = pci_resource_start(pdev, xdna->dev_info->doorbell_bar) + npriv->doorbell_off;
-	pfn = PHYS_PFN(res_start) + vma->vm_pgoff;
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	vm_flags_set(vma, VM_IO | VM_DONTEXPAND | VM_DONTDUMP);
-	ret = io_remap_pfn_range(vma, vma->vm_start,
-				 pfn,
-				 PAGE_SIZE,
-				 vma->vm_page_prot);
-
-	XDNA_DBG(xdna, "doorbell ret %d", ret);
-	return ret;
-}
-
 static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_info *args)
 {
 	struct amdxdna_dev *xdna = client->xdna;
@@ -661,7 +629,6 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.fini			= aie4_vf_fini,
 	.hwctx_init		= aie4_hwctx_init,
 	.hwctx_fini		= aie4_hwctx_fini,
-	.mmap			= aie4_doorbell_mmap,
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
 };
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 3fd5eace3ed7..c6219544dc0f 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -69,7 +69,6 @@ int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev);
 int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
 void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx);
 int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
-int aie4_hwctx_valid_doorbell(struct amdxdna_client *client, u32 vm_pgoff);
 
 /* aie4_sriov.c */
 #if IS_ENABLED(CONFIG_PCI_IOV)
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index d9e2e71d3e05..3140af69e29c 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -250,21 +250,6 @@ static int amdxdna_drm_set_state_ioctl(struct drm_device *dev, void *data, struc
 	return ret;
 }
 
-static int amdxdna_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
-{
-	struct drm_file *drm_filp = filp->private_data;
-	struct amdxdna_client *client = drm_filp->driver_priv;
-	struct amdxdna_dev *xdna = client->xdna;
-
-	if (likely(vma->vm_pgoff >= DRM_FILE_PAGE_OFFSET_START))
-		return drm_gem_mmap(filp, vma);
-
-	if (!xdna->dev_info->ops->mmap)
-		return -EOPNOTSUPP;
-
-	return xdna->dev_info->ops->mmap(client, vma);
-}
-
 static const struct drm_ioctl_desc amdxdna_drm_ioctls[] = {
 	/* Context */
 	DRM_IOCTL_DEF_DRV(AMDXDNA_CREATE_HWCTX, amdxdna_drm_create_hwctx_ioctl, 0),
@@ -323,7 +308,7 @@ static const struct file_operations amdxdna_fops = {
 	.poll		= drm_poll,
 	.read		= drm_read,
 	.llseek		= noop_llseek,
-	.mmap		= amdxdna_drm_gem_mmap,
+	.mmap		= drm_gem_mmap,
 	.show_fdinfo	= drm_show_fdinfo,
 	.fop_flags	= FOP_UNSIGNED_OFFSET,
 };
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index a997d27a504d..84c8973e9197 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -57,7 +57,6 @@ struct amdxdna_dev_ops {
 	int (*resume)(struct amdxdna_dev *xdna);
 	int (*suspend)(struct amdxdna_dev *xdna);
 	int (*sriov_configure)(struct amdxdna_dev *xdna, int num_vfs);
-	int (*mmap)(struct amdxdna_client *client, struct vm_area_struct *vma);
 	int (*hwctx_init)(struct amdxdna_hwctx *hwctx);
 	void (*hwctx_fini)(struct amdxdna_hwctx *hwctx);
 	int (*hwctx_config)(struct amdxdna_hwctx *hwctx, u32 type, u64 value, void *buf, u32 size);
-- 
2.34.1

