Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437FDCA600D
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 03:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 329B310FC07;
	Thu,  8 Oct 2026 03:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ycxfg6Fp";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 518D810FBFC
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 03:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TenyccvT8wje9pmrZ2ylR0k5IHw9j1iXlmmUFCBlt7Dh6JhNkuO7pLOtsB5CytcB1i1mkhtOPamm8vrg5tg+pe9d373fKXJkL3VoqN8/po79I/OQFnc2p8dMrkiKEGuMK7l9z8SrV+RMI9RxsYP02w+0JP4sT1CtTkrPiVHFV6pXRgLFtKCrhzfZiARiwlpeiWxmvxfl8zt2R2YimhP4sG/gjtP5drnB25urw9Xx9qZQ9fj0w18tQAJuuzOKF3qukOVrhlHFx5Hy3MVi2+HFs5/3MlONyvdFqqRaAYdto9d6vWDl2UCeqXoFtX9+0CIQqYY0swjDaYUrSD7WVQBEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMoIy/d3Bej6C+RG9iGO0emagvw8npUWaI4zQ35uN4c=;
 b=i8rMEkhvdULeDQlRQ8e0oTmaRbDPJmspBhUb7azye7VWE9uPEDKQWQGDoODKzF0Iubc/A4KM9x1eAPgTvrCjwEBrEIuW0kD57tfuOxzR4BqwUFmAgFJQx8lrTAKkt2+SDgg1pLNZpZQuWEcfEjwX016rgYNpvbTIXelySiZsTJnDjSSL73s9JHQwUOD8rbczEH8sslTIPqLa9hZe+lcNLJX1t5GoMfVu999YMnBfTVDdPHBWmpRVxlbm/eczykF7gg7qD35WyHbDAN1l9WQhAAWefalVaRKKxcy9uIw97jMOJN3hEsDyY3FzJrcRYhSMLZ22Zq6hV60u0OYCuoUyVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMoIy/d3Bej6C+RG9iGO0emagvw8npUWaI4zQ35uN4c=;
 b=Ycxfg6FpncYL0qDgkze+ZuBXfGUiPvoLcEwJ1AGXEHK0v/FHVyoozIwvqu+LA/ztAGk/tzoTjHZF+GBvAJAzhuVRPYoiplw362kqIozL/z/0hR02XlBGsXfPMup3NxcV7PAtWKV9PMmxaDwTacfGg1kb/NdDy+RY4M6dspbx49Q=
Received: from SJ0PR05CA0185.namprd05.prod.outlook.com (2603:10b6:a03:330::10)
 by DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 03:23:58 +0000
Received: from SJ1PEPF000037AE.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::3f) by SJ0PR05CA0185.outlook.office365.com
 (2603:10b6:a03:330::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 03:23:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AE.mail.protection.outlook.com (10.167.244.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 03:23:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 22:23:56 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 22:23:56 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Wed, 7 Oct 2026 22:23:55 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V3 02/19] accel/amdxdna: Remove mmap for doorbell
Date: Wed, 7 Oct 2026 20:23:31 -0700
Message-ID: <20261008032348.2044667-3-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008032348.2044667-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AE:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cec2072-e382-4dbb-f37f-08df24eb971f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|11063799006|4143699003|6133799003|10067099003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: wMlv0wkw2cGwIwrpItKXKv0keVJO+lNjKjVvp0+Zj+SB4i4k2T1fpQkzZX/mrPQ3Uw8U/TsnTUkLsWVJ5hlOILjJ1uwCA4nQT9axyGAtngkrFAcKXNqtcKxrg0P/nc5309C9ekOfvJUW+Y/4e+7YcUfqef3jRXM7naAhg2Ez/mO2hLZTjAswK7fxtXgNEgVrUJ7XtMwk29MHc9NUV9nbkrzEbqXirnnGfQaF6L1GWlcFr+ohWMnqZ2k5QIdZWyd4BRyO4t+uQ4X40IKqq1Bjqi5X+CbBBxkiIZnifMw1Zrv1rr0lCD5mbiNW8MJjcgeJUojswuwO4ZKlacNQiwTIbTY+PhmPg/yLHJu50f08w0lGV1XPusWyOgkVGscMs37jrS9PbfqAq9oJ1nnrLo+A/LHso9zAAxY8GxdxHpWWXvHnZrKp9bHWMiyupoGwEU7b64Pr0mqygQzMluqkQIRSf2Wv3C1vG0rLvlmxcn2Y9ZFayF4aH9J705BPH0e+LFXCH+VF8K6vbuQ3A8qKJnrkuRx+PHIeOSYP4XYT+bXhqNYird8h1jgJ12avHEtF3QyaagIzNb3VRSEMd56Q75gcNOG9gljqpSvuNcdawmd7bTBa+SmfK5B2UPoovH0+pUDBTOnHIjt7mlKyPzlaJCZeV725obJVFqcC1QMnsQMYCjM4DmpdxDVtrw3xpVJgC7rXrpv/xBtaNz6iomhwmZn4hQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(11063799006)(4143699003)(6133799003)(10067099003)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OViddBBjsXJa19PN11PoukFkqnELWWBk3KKlBoVn0As37A2q/UwUIgThSex9bd4ADg8xKsZrw2clrhI72lCjOGnnI2oAoa5jDPvacQUu5uh9pXFhjum6z0x1nYp22dOQRr96CQOCnLh8DyXXXTAqr+Hx7pCrJaIY0231jSH2ZHOvmRhbFEpgnNsZJJUoBAcI9zlKbSnhINGgCfM59lRhf9MvCwIxsLVIlWIHY5tBSvg+w+LaMnKpjiFcimAxdCms/fd7cxwHAKwnwHfuJeUjql1tUlrLzwlOZQT2fZqF9ituiz+VRr13EOzJN6+QXQKM+JXsYJo+XVT8EaNW7h1CmwSfCX6mafNnu1/bJDiQCLf3T5piKHBjJiVfn8RSXAWpubekNXa+ue+3E8o8IxEQt0xhBgcYxPyMjXShCMtgo8awUKoWYICCP8Q363AzzS8k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 03:23:58.0011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cec2072-e382-4dbb-f37f-08df24eb971f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444
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

