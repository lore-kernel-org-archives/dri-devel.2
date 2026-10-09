Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D43CA9EC1
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E318B10EB64;
	Fri,  9 Oct 2026 22:53:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L8veNQD/";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013054.outbound.protection.outlook.com
 [40.93.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBBC410EB7A
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 22:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKpGkiTBZXIq68s/KCpEu+zU72g0w1Q5ZdxGszElX89WHcz+sIYLZdWAf3iHW4O0ZFE4ds7aniiX3OD11OH025cyQp9aLgHjmkfXKkx2MVb9z4UA2ZjU5hskgo34IKN5n2GWRBkCQjtaKfNKHvsoD7Vmd89Uz2dWgNwbbRd10MzpJ/vJ8zjFVTcFKQykxRjOV+WSTfbNhvrGFDpwjnB6mXJZUg9Jmlc6OWEj6q3FKTchUQXA+6YJsfQdnRa3eZGm0ftAmO/q51tSfE8b6B28yIWzK2sfN6ko9qCbx5nfc279AcQ7dgtdchnHi8NRwceYMZmvdqetVyCUOTXr1wPxJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMoIy/d3Bej6C+RG9iGO0emagvw8npUWaI4zQ35uN4c=;
 b=kLaLrk2DFmkUlQ0dI+THwqIqUvdFcYB5DWnmWyGMMXZR9lfHCDJ0OxnDVYj5GwjCZd3wDnZ+SOHSs44PbKPLiC+/343Ms4uTjZ98ukb/QzuGcGBx7q8EB+OW50KEXYSX1A5g3JUm9flkc8C+JFx3aV9iSw/T0SLfLomvpTC1vuboXtIkaqf8rl/7U/ttHANWtdOQw+3P5yq11/HULPUxFNGjZeqbpFvRl+CRixeYjP2LtdxfWVWP5CoV7saHKS9dsyMXP/5+dbmSQ0rbRbD44Z1KvdgFIQyhwbSJ7ssBw4KSFf6oAZdjD2j2nlQlDIj8ljLf9wyZoe78yk22PeahAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMoIy/d3Bej6C+RG9iGO0emagvw8npUWaI4zQ35uN4c=;
 b=L8veNQD/uo5sia9TmMAdEz03zhS/eBlzS7I84LyPAHrEvb+AS9VkM5RTEl/t2XVscCzpIeN9r0WWvosb/5clOMbzG98er90BGZkiz0Zv++CtK8slS2/Cy1PbJ4z29Y7Oc+M5oD/VmzfE7MUd9ltOrEH3b5S1wJAC2BJAZ4fkWgc=
Received: from BL1P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::22)
 by CH3PR12MB9283.namprd12.prod.outlook.com (2603:10b6:610:1cd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 22:53:52 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:2c7:cafe::21) by BL1P222CA0017.outlook.office365.com
 (2603:10b6:208:2c7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri, 9
 Oct 2026 22:53:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Fri, 9 Oct 2026 22:53:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:43 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:43 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 9 Oct 2026 17:53:42 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V4 02/19] accel/amdxdna: Remove mmap for doorbell
Date: Fri, 9 Oct 2026 15:53:26 -0700
Message-ID: <20261009225343.3079074-3-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009225343.3079074-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|CH3PR12MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: 6805c3ce-03ee-4353-37e2-08df26583069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|4143699003|11063799006|56012099006|10067099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 1aj6nzrMHm3QCbgeQcBkMU8fHeNOt1EVPJpA12EYV+NNgXQpHowjFbblQgYkPlwDNDFNmo8gChmsKwen8bS7ndD8kBdtVmy64J1lUK8oZFqeacMaVCdmAWQnK8/g6WW1gExzNZ6UT9GpyGdkdYSjA6OLCezv/Ja1n80ZoJLL40bLZxPuqewAKIOVCLUVeI8mpRJvEefWj6ezWeieqOfH4XYBrxFwrDIaqQMFd+pNyMBF/wcxEhsEcqpvZESrcIXYigZfqFh0mNsP4+qp/Ii70OGPea4vJojDtWQZlK9i1xJPne4r2ik0gmaCDMcgd61xLQlVIIxTzJKjKOO5Fm2QXRdm4lLGK9vK0b1KbHjVwpy1EgHBV9i2NABJN0vPXxQsyX7InbOt20sHoJF17AC2Ag+Yt98PdKIuT6edWwYRYwx5hbrmzWTHefdMOzSyj2QuKZv2O78lKP+wfEyXRQqR0FbYbOYXF1zdMp6nTTGTb6FR7AyQ1KRCHo5K9BBEJKWS0shfHsSAUQe+OIF6P/v5k+sevJqfvSXPH5e+IyDBkPMLZWSGupHzQGmeqXxnc11XkoXlaHoZ3z+4SBxi/lg6WkMhLvX8Flbaphx+4wgG+fmwN3e4hMAd6vfIQKoNDwveN4OgT4/vu31G3QUsNcnk8VvEPohmwYQd0r+WWDTRSh0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6cRZiSwXHTrZr11cU4u2YfIUXmjU4kanUsvepk2jBw9knhpovu1ocvifMHtN5sHF65ZbvgpsQ+qpasWgAUBweTN13Vwg05hKIlV1DdQl3CZQrAE2WJvEicRwvPWkPJndS0sF7Y03QuwBeNaFH3cc2uq1AA5TJkDbJnk9cnQvoOVF42VjrOhOS7Lh0um2iSVNXz9osDXzBnukghFwtqA2uByyrZF4n2yXCGq9bbwZgqIJMW8aY90gSU9cBNZQH9jwGgsiM6DOSuckFStafChAYFjSs5Kk2LVEMGnmknYsHbNqw6b4k6KOcvtiVtU4Z4M4p+5MT0vn92j4S9YILU3VDpQVzWObg5h8Ex5RN3MSEUd6hvM0nQv2e8H4Dl28pTyOzsg3QgLbDuvi1mNt0WzR7SpocyEuXhyMli7rUjY1yDYgmdjAi7NrsLVidpZGJC8D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 22:53:52.0618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6805c3ce-03ee-4353-37e2-08df26583069
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9283
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
index e99ad35870ef..f81c43a1f884 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -524,38 +524,6 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
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
@@ -667,7 +635,6 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
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

