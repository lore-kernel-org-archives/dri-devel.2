Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65A9C79FBF
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCEFB10E1AE;
	Thu, 10 Sep 2026 19:58:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IwlYktdt";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013067.outbound.protection.outlook.com
 [40.93.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 403F510E1AE
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 19:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9Q1B/LwGsjufOCGa7/87k6oT5rz+QU3TzqPL+O3/skUPW/WC8DUCp0KcFmGXr0xsDdWZK0XbmuCorF+3fGRIwKXX2FMy8FOWetqsP2COJCyhnpOFJtQm+YP5D3Nr0A0lOoTGLpOT84Ba6kSuUUWjtqJGb/sXFYCLSMbvgSAcT8URGxmwcHtnWs7/6vNZs0yzzlAryxicuVGKbavrBGuJ93Bug4l/f6oy5OXe51LGXuywDPbBPTCQAuYszNQhYR1vF9eNnLMB/ZFXixHLYLMrHQBWmGZSISJ7p1vu1HpGXoKZOQcrWmi2SUwKw7tISFFDQHZ9xJl7u7D7rMkturiag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eF7n2fY2lL2UgLJ9njeCNH/IWTx0dWQZwrBQsVfbYEw=;
 b=a1y3/wmAnHvALQn22a44ms2VCMWQf6pZd+/x2VXXyCu2SYOzh5LM3GhvWobF5JG8VyLy0SIAATMuIZgp1o6+8MDWZLjHt/EaOoITb+GPf0GrBivxKhzZdHE1rGZP6S0f5r38XHNtvD4vWMlKsyHeB5WP9BqDafNcauknsJKq0inWgvHJMsbgb8d0dzGXo7aenSf2SyosDl4OsvGtkV+UVOhZT1a2nZyIwVJJnfgpEQSX2HSFtdJBVbDsyHQfWqOHCneOyYP/0WC7Iys2w7eo2YAEPOV0eRIWEHb2kbnhqib92QzbLV/y39pTr3wN1S+LBJGH1Qp7ZA3T6A1ykTqoJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eF7n2fY2lL2UgLJ9njeCNH/IWTx0dWQZwrBQsVfbYEw=;
 b=IwlYktdtuphTtRhsxi/XlfQgUEpLQfi+OcOrlbG1H3r1GzetWXhqgK/KuuPAVcPhBNlDmZUtaMHWf5oQeV6dQnbGYLkPnKonTL8/dDTBIOW5iR9ZjPY0sofYA2DPpxNgUnBMFbEmdqw39Q+CWm7yctb1ttrhHyfs81gk2IRrq8A=
Received: from BL1PR13CA0114.namprd13.prod.outlook.com (2603:10b6:208:2b9::29)
 by SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 19:58:16 +0000
Received: from BN7PEPF00000093.namprd03.prod.outlook.com
 (2603:10b6:208:2b9:cafe::8f) by BL1PR13CA0114.outlook.office365.com
 (2603:10b6:208:2b9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Thu, 10
 Sep 2026 19:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000093.mail.protection.outlook.com (10.167.245.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 19:58:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 14:58:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 14:58:12 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 14:58:12 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>, <max.zhen@amd.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V2] accel/amdxdna: Fix unsafe use of handle_mm_fault()
Date: Thu, 10 Sep 2026 12:58:07 -0700
Message-ID: <20260910195807.1093852-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000093:EE_|SN7PR12MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ca72f2-3894-4eba-5610-08df0f75d8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 2RI3OVpCtkIQNzqum8AMP4AAqtRYbAyDQE0T3dhzqgFDocE3F6CYPp4PNdu+PqAdbbSFJulYtb9EXCKckiIWXh2/kZq4adWkzOJH/K45VmCIoayw552JRj55w0kZXQznrPPEao1iwUXfOgFdF46V6yx1ihy73H2qNTtbEsRFywBNX5yYioppwhNzSZTyRY0j0v2w7sW685wk3O7Wb58WJGzF58ddZHXvMRNt6o5qrAplcyURcSd/AkYRrXOoDUR/NRptwYjW2UE5XPnG+BfI+g9NKN12+Aybx9kS+MVCbHAvI9uZ3ywts5SR6DCDdSovpkUuPQDxI/yzUCAK7xXDGqNDVdSw9YM2iY+pkV/tPDrTzOaCYbgBliG1P37o0zIbKF3Ql54gXI7dLNv5+P0A3vV3z+qMmkO6ZuGsKRZsymo3p9CKcw00eXVl6jneIEXSegb+Rf4C6HfPDpMvujKwlJ/FmEu7bQREMYDprvme1wIj1ccYnFRdTJPk1pYbDaVIAlt3ZBQLBEhJMf1y4E0sGiI+pCR8DTIHStTYEPSmSZBiaTs8FH71fM1yIqqWup6fgvI9hEOPsWZjacyMbq9QsR1ZcUdz/LJXsZ/DEqUC9z6QuKNjg5EjXK5t/eE+QRC9SkhVuwdPIS18Y2vq+pZZCo1JUZBGXknP81cG+4XkbodNnerW22n3RFFMfpPFKYXwRNUuvwYNRbBSPivT1AYJ6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8UYW1bMwWf/0JSfjIYGSGS1iTFMgpZXzRAeo2sNi2KISZnqyDSqg+Ev6KA2nxTWp2nCJJUTdIlmzRLAut1RiuMG9ZINS+ufeXSBM34GabTOVUDDlhyp99WnwlDVuKORlNLNap8YJ5e+ZiATWlvXpKzAk4MgjvclWeRtjg/rDT6Z7goDrvSCg+J4oYB/3u5ODyaXpvlnNQTBxAQFvHjQ57nGWc7Vyg3Vwg8tf0ZRzdt56ZX53DZtqagSMGJTmCEBmaeOENYZgWzORjHVjvvQkRUcOWAFMhyrvqcWMT5u4y3kzJMGh5di6I/0JYB+8pFoUr8LwUWazw6uoXzB49zAb7YAXJT+YHcE5U2ek7nqFHNkSQiY3rue+SWEvLBRQkeEbtskCQ+jrvLJSZbuGbb39/zbC8v6QGWSkktoT/2FgSGCVaalMCeHJOnJ5CXU3eyc8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 19:58:13.3108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ca72f2-3894-4eba-5610-08df0f75d8d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371
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

handle_mm_fault() must not be called from the mmap callback because
the VMA has not yet been linked. The handle_mm_fault() API contract
assumes that the VMA is already linked.

Remove the handle_mm_fault() call from the mmap callback. For imported
BOs, mark the mapping as invalid and rely on the first command submission
to fault in the pages.

For shmem BOs, set the VM_MIXEDMAP flag and use vm_insert_pages().
Implement amdxdna_gem_mixed_vm_ops to handle the page faults.

Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
v2:
  Fix sashiko comment.

 drivers/accel/amdxdna/amdxdna_gem.c | 144 +++++++++++++++++++++-------
 1 file changed, 111 insertions(+), 33 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 0d165b66c1fc..f4dbe165d800 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -14,6 +14,7 @@
 #include <linux/dma-direct.h>
 #include <linux/iosys-map.h>
 #include <linux/pagemap.h>
+#include <linux/swap.h>
 #include <linux/vmalloc.h>
 
 #include "amdxdna_cbuf.h"
@@ -490,16 +491,12 @@ static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
 	unsigned long num_pages = vma_pages(vma);
-	unsigned long offset = 0;
 	int ret;
 
-	if (!is_import_bo(abo)) {
-		ret = drm_gem_shmem_mmap(&abo->base, vma);
-		if (ret) {
-			XDNA_ERR(xdna, "Failed shmem mmap %d", ret);
-			return ret;
-		}
-	} else {
+	if (vma->vm_pgoff - drm_vma_node_start(&to_gobj(abo)->vma_node))
+		return -EINVAL;
+
+	if (is_import_bo(abo)) {
 		vma->vm_private_data = NULL;
 		vma->vm_ops = NULL;
 		ret = dma_buf_mmap(abo->dma_buf, vma, 0);
@@ -508,23 +505,28 @@ static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
 			return ret;
 		}
 
+		amdxdna_mark_mapp_invalid(abo, vma);
+
 		/* Drop the reference drm_gem_mmap_obj() acquired.*/
 		drm_gem_object_put(to_gobj(abo));
+		return 0;
 	}
 
-	do {
-		vm_fault_t fault_ret;
-
-		fault_ret = handle_mm_fault(vma, vma->vm_start + offset,
-					    FAULT_FLAG_WRITE, NULL);
-		if (fault_ret & VM_FAULT_ERROR) {
-			XDNA_ERR(xdna, "Fault in page failed");
-			amdxdna_mark_mapp_invalid(abo, vma);
-			break;
-		}
+	ret = drm_gem_shmem_mmap(&abo->base, vma);
+	if (ret) {
+		XDNA_ERR(xdna, "Failed shmem mmap %d", ret);
+		return ret;
+	}
 
-		offset += PAGE_SIZE;
-	} while (--num_pages);
+	vm_flags_mod(vma, VM_MIXEDMAP, VM_PFNMAP);
+	ret = vm_insert_pages(vma, vma->vm_start, abo->base.pages, &num_pages);
+	if (ret) {
+		XDNA_ERR(xdna, "Failed to insert pages %d", ret);
+		dma_resv_lock(to_gobj(abo)->resv, NULL);
+		drm_gem_shmem_put_pages_locked(&abo->base);
+		dma_resv_unlock(to_gobj(abo)->resv);
+		return ret;
+	}
 
 	return 0;
 }
@@ -536,6 +538,10 @@ static int amdxdna_gem_obj_mmap(struct drm_gem_object *gobj,
 	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
 	int ret;
 
+	XDNA_DBG(xdna, "BO map_offset 0x%llx type %d userptr 0x%lx size 0x%lx",
+		 drm_vma_node_offset_addr(&gobj->vma_node), abo->type,
+		 vma->vm_start, gobj->size);
+
 	ret = amdxdna_hmm_register(abo, vma);
 	if (ret)
 		return ret;
@@ -546,9 +552,6 @@ static int amdxdna_gem_obj_mmap(struct drm_gem_object *gobj,
 		goto hmm_unreg;
 	}
 
-	XDNA_DBG(xdna, "BO map_offset 0x%llx type %d userptr 0x%lx size 0x%lx",
-		 drm_vma_node_offset_addr(&gobj->vma_node), abo->type,
-		 vma->vm_start, gobj->size);
 	return 0;
 
 hmm_unreg:
@@ -556,33 +559,108 @@ static int amdxdna_gem_obj_mmap(struct drm_gem_object *gobj,
 	return ret;
 }
 
+/*
+ * VM operations for amdxdna shmem VMAs that use VM_MIXEDMAP.
+ *
+ * drm_gem_shmem_vm_ops cannot be used on VM_MIXEDMAP VMAs because its fault
+ * handler calls vmf_insert_pfn() → vmf_insert_pfn_prot() which contains:
+ *   BUG_ON((vma->vm_flags & VM_MIXEDMAP) && pfn_valid(pfn))
+ * All amdxdna shmem pages are ordinary struct pages so pfn_valid() is always
+ * true, making the combination fatal.
+ *
+ * These ops use vmf_insert_page() (struct-page based) instead, which is the
+ * correct API for VM_MIXEDMAP VMAs backed by real struct pages.  The open and
+ * close handlers replicate drm_gem_shmem_vm_open/close using only exported
+ * symbols.
+ */
+static vm_fault_t amdxdna_gem_mixedmap_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct drm_gem_object *gobj = vma->vm_private_data;
+	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(gobj);
+	loff_t num_pages = gobj->size >> PAGE_SHIFT;
+	vm_fault_t ret = VM_FAULT_SIGBUS;
+	pgoff_t page_offset;
+	struct page *page;
+
+	page_offset = vmf->pgoff - drm_vma_node_start(&gobj->vma_node);
+
+	dma_resv_lock(gobj->resv, NULL);
+
+	if (!shmem->pages || shmem->madv < 0 || page_offset >= num_pages)
+		goto out;
+
+	page = shmem->pages[page_offset];
+	if (WARN_ON_ONCE(!page))
+		goto out;
+
+	/*
+	 * Use vmf_insert_page() (struct-page path) not vmf_insert_pfn()
+	 * (PFN path) because this VMA carries VM_MIXEDMAP.
+	 */
+	ret = vmf_insert_page(vma, vmf->address, page);
+	if (ret == VM_FAULT_NOPAGE)
+		folio_mark_accessed(page_folio(page));
+
+out:
+	dma_resv_unlock(gobj->resv);
+	return ret;
+}
+
+static void amdxdna_gem_mixedmap_vm_open(struct vm_area_struct *vma)
+{
+	struct drm_gem_object *gobj = vma->vm_private_data;
+	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(gobj);
+
+	/*
+	 * Bump pages_use_count so the page array stays alive for the new
+	 * mapping copy created by fork().  Mirrors drm_gem_shmem_vm_open().
+	 */
+	dma_resv_lock(gobj->resv, NULL);
+	drm_WARN_ON_ONCE(gobj->dev, !refcount_inc_not_zero(&shmem->pages_use_count));
+	dma_resv_unlock(gobj->resv);
+
+	drm_gem_vm_open(vma);
+}
+
+static void amdxdna_gem_mixedmap_vm_close(struct vm_area_struct *vma)
+{
+	struct drm_gem_object *gobj = vma->vm_private_data;
+	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(gobj);
+
+	dma_resv_lock(gobj->resv, NULL);
+	drm_gem_shmem_put_pages_locked(shmem);
+	dma_resv_unlock(gobj->resv);
+
+	drm_gem_vm_close(vma);
+}
+
+static const struct vm_operations_struct amdxdna_gem_mixedmap_vm_ops = {
+	.fault  = amdxdna_gem_mixedmap_fault,
+	.open   = amdxdna_gem_mixedmap_vm_open,
+	.close  = amdxdna_gem_mixedmap_vm_close,
+};
+
 static int amdxdna_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struct *vma)
 {
 	struct drm_gem_object *gobj = dma_buf->priv;
 	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
-	unsigned long num_pages = vma_pages(vma);
 	int ret;
 
-	vma->vm_ops = &drm_gem_shmem_vm_ops;
+	vma->vm_ops = &amdxdna_gem_mixedmap_vm_ops;
 	vma->vm_private_data = gobj;
 
 	drm_gem_object_get(gobj);
+	vma->vm_pgoff += drm_vma_node_start(&gobj->vma_node);
 	ret = drm_gem_shmem_mmap(&abo->base, vma);
 	if (ret)
 		goto put_obj;
 
 	/* The buffer is based on memory pages. Fix the flag. */
 	vm_flags_mod(vma, VM_MIXEDMAP, VM_PFNMAP);
-	ret = vm_insert_pages(vma, vma->vm_start, abo->base.pages,
-			      &num_pages);
-	if (ret)
-		goto close_vma;
 
 	return 0;
 
-close_vma:
-	vma->vm_ops->close(vma);
-	return ret;
 put_obj:
 	drm_gem_object_put(gobj);
 	return ret;
@@ -878,7 +956,7 @@ static const struct drm_gem_object_funcs amdxdna_gem_shmem_funcs = {
 	.vmap = amdxdna_gem_obj_vmap,
 	.vunmap = amdxdna_gem_obj_vunmap,
 	.mmap = amdxdna_gem_obj_mmap,
-	.vm_ops = &drm_gem_shmem_vm_ops,
+	.vm_ops = &amdxdna_gem_mixedmap_vm_ops,
 	.export = amdxdna_gem_prime_export,
 };
 
-- 
2.34.1

