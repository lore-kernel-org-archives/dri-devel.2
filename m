Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5067ACA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 04:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A99CC10EF71;
	Tue,  6 Oct 2026 04:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n3yoZ23A";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011067.outbound.protection.outlook.com [52.101.57.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3242F10EF71
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 04:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0R0aHJR576KkoMyaRlE5bnoW5RYPJtS+FCT03wKmbcTa7iMg8V7u1F3YvmfUwSMwkzEcsuDfwo5bpKyq21+km/5Z179BO6ts6XwTw4iaHClPYAEGYjzBYexq9KBkamQX2H6Pzy7V+rctC8+5lrzo4hbVi70Q6nmbbzV+ufoL8YKscJjYUUGknoL/nBAsBihMTEv+asF6P2tQdwgut9wPG2lT55Jk857h09JiSuwSK6pA0gY8wVEpxswV7C4Um5HcnujIR9sGeUtbx4nymW0jafZhIahvcbmS0yXX5oigSBA+Kmbaq3kJYl2b7XaStRN1jRSDKScSwfiig1T8/weDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ByoS7oK0zCQ4rVcO3Rg5utKtvMo/eF5Dp6DYGgAl4g=;
 b=NFPGATj11TG7oIowUJuGPKpRp1t0uc98MSsz08AC1+Kl07JhfSJkC6DQvZgAiJI6GsGXn6ly+w1UD546hLSj1EExtirWRy2cu1KYj1DrwQu6H5ux6kZb/JafEaZSGy/DPom8JXWUhjd3fLLr7038EmSCeOhFILIYfQ/qtRK8PNKklzB7tsB1FXhpHZfjVpB0WA3jbV9TZsPmCnITwRKEbq/sG910Ie5hUQi5+Ztdg3MQUUgVwmpjAUU9O8QJ31n2SFMhL2XPB+rxw6Yxp2uOoX3g4CxZj3Jh4uBQPVDNVa82CzvhGvPsrr/Fnd9XOHKckfRg8Sx7vh81Q3ZZbAOC2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ByoS7oK0zCQ4rVcO3Rg5utKtvMo/eF5Dp6DYGgAl4g=;
 b=n3yoZ23ASzpuL3p85/JTv1rjBXlYHGgddTYXZVQoHdFdCijv3hQYCkN56B+IUKtqOt4rUxe6IQHSaA3Npk4xxIJ5OsbMz8pEP6hpz4qDEUmvRXKnc4wme8wYn5snCSI5whfEovX5dSPA9mfi8Fb9O5XakbmaXIbCoS+UpdDhTCA=
Received: from BN0PR02CA0046.namprd02.prod.outlook.com (2603:10b6:408:e5::21)
 by CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 04:22:54 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::96) by BN0PR02CA0046.outlook.office365.com
 (2603:10b6:408:e5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 04:22:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 04:22:54 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:22:48 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Mon, 5 Oct 2026 23:22:46 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V2 02/20] accel/amdxdna: Remove mmap for doorbell
Date: Mon, 5 Oct 2026 21:22:12 -0700
Message-ID: <20261006042230.547807-3-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006042230.547807-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261006042230.547807-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|CH2PR12MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: 5045e074-8111-4f3a-c192-08df23617e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|10067099003|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: o3AY/azpIEu/w+InhCc3pDpLu6sHA2sTq3kA2UclL4KAIo1MHTIhxKaCicEOirChvJjt/+6moFgUqZpFSK9sPnnmlsMXM+XQ2LVa8KS6t/nbk4XOFlb4rY5smc9dyV4+t5nlN9AHZp45HvL4cJh2xBqPLNC4PTvsiAzHrHrM/VOEECKECET0xy1y2KmmIK5ADmoAeLgqIoIsx8TI94MqLCS3U2yE9i2opC4AtG9g7b1ukQ1Ats0JBzxTusibQO1XvGlnCYdoETo1JElESG99fWeX+nklK5EWYGHaf1Br14UcT+AfujKCyOxtII2Auh32EV80oIVwbYZV6E912LnXAviExFkOygftCPWZ7MbJGCHgDToooJXwxP+vlAripVxLzdeQeyjpoIJ44DozMrtWDaAk2ehubUpJ5rK9W+K8dNvDp5+GxQX9ucXCIdmjNgMGPKVmYLMfklaX4vAzVCGQeYEHlhRKl0vqWWzYSJq+8aNRgjzmM79dElQ2fRiPQtmIjBgoLvXI0JcAv3JuKk9FMIOz1K19I4CopGDNLeExJlTcAkpb6pxFElVSrWX0Dcg3bIuoJbswz/OtFYoKrjNtdPs4FvRfsedNU38vuggCbWCHwEa/KyvoLfYZ/2RhoAvVQX00BD3sfq9x4QsZAtioxnIsrnLzpU51TbTpkLhGH4RZeESuiCjpfRv8LC1unzIXkOL/gxwNx88ftaC+nYtTWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WaBAMfCMcAhRST4D00eWwBCi7HNouYJwantLX9ZoeWEjTlFlcU+lJKWYsHe+CqqvU8zO/2E/v++V1Eez4APVPItAWJZPP/MIU9DoP7Qjb0XvMMbgznQq5t7KA9zLHuOJMpA5cNecaIXXfI5dOlc/I+gYDsRgiEWekiBR5uAgNgECx4/lYurQ9uHlnWJIHWLx71ltr97FzZOguWLNmPbdvNtn8yazbe5p9DfX0mDJ1ABcTNf0znpSGJmb4zoFQqvpKt59K0qJJtDoIpYEuwQG7rPhs2dylX9FRLNEhKtzOc8loRf0k3om9pofeGKk94DC17zfREECaekhVqiJV3Q8BxzLa3QNSQnoptdemvRbWCUmFR8EUUgbwPYNmOREGdVTN6JSWwV1+l+AydEuTGwywGgMLI4uYe8BW6q4qrvHFHIf1rPnYtT/Y8dtlPj26ELt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 04:22:54.5593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5045e074-8111-4f3a-c192-08df23617e33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9544
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

