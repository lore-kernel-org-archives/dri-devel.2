Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D5C606D807
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KSHcbzzt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D976A10F7B8;
	Tue,  3 Nov 2026 19:08:41 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012068.outbound.protection.outlook.com
 [40.93.195.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 708B410E826
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 19:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuXgDYHyPSw/TKHhipJvBA+Lkd23ZaQlWAwiidR6PiAdw8e5TEkDunx/PvKIA7WWbn9BtB1oSHnDvHDqhwLAj1oIbskFLoE1ri488vKUmMJafHiybxL91YLLAz9xf2PcrANbGnChgva5tyfmMLFk46ndb7oUTk3megW1lp4BrFirX5QCDBonlnzA9/3o2sKI+ImePNPLf4tXy7zflaz9D84Ej5qEmSiI9kmaFbKYiuNHM5LO+1ZN1ryVLpO+Ef3j8lgWK4koUufx8HMPBP8yHwCypAwZxM7Ukcs/kgCExj2y6GUZBthjRMfUlWyEWjjeiOyf9zJXlKOiP3scSErKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwipAATj3m61n1Pz5ouy3ufUS/IQqEsy94sujF8vBtk=;
 b=c4WNGRI/Td3IoA0zlvvqgWzIQ09vGwwV3twDm0wtRl7J6VngO/7YfdjOUpXE56upIAE6/SQOBCfDTLsDarvk0+bq3jcCe4MhukZDrVzqcr3OgZCA5/sxFdytN/n2Jj7CS+3xWFLvnXRS8ro0Er3tKSPENWkb4COmvZnKJXBn7/zP2wQJJzmkSfSE0EKczwOg9kl+S9t8x3HSiO1pryX6vXcBohwesuQNZetiupUzGv7qJgyWEcc2G3ji0q/NbOUG5l/RYHmgcuVP2fj3jcmP28vluXuj2x43eJR60QD2zW+IKcWVfTuk6vJvzZEzRGxyFo+Z5/eqBqrfTI+Cd3VRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwipAATj3m61n1Pz5ouy3ufUS/IQqEsy94sujF8vBtk=;
 b=KSHcbzztv5CoR+REc1zxly/2P93GMZ8yjEOlFbwWaOXKh3yCLYm+j4AZrjHLCRVkGkHxTwuT5yByqTSElY1t2mK4V1W38N6g0wbt5hS6wrcXI6QJRWW3sXNK8el/yYdFumWfzfdou9BbEUHFrZ4V7dU+Z/+fUMTv/loPgNO5DBY=
Received: from BY5PR04CA0009.namprd04.prod.outlook.com (2603:10b6:a03:1d0::19)
 by IA1PR12MB6068.namprd12.prod.outlook.com (2603:10b6:208:3ec::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 19:08:29 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::6d) by BY5PR04CA0009.outlook.office365.com
 (2603:10b6:a03:1d0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 19:08:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 19:08:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 13:08:23 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 13:08:23 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 13:08:23 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Remap BO pages instead of using
 vm_insert_pages
Date: Tue, 3 Nov 2026 11:08:21 -0800
Message-ID: <20261103190821.2019203-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|IA1PR12MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: 011c790e-63e9-4ae2-3897-08df39ddd5cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|261102123227099003|18002099003|261102130727099003|56012099006|5023799004|11063799006|261026121527099003|261022105027099003|261009223027099003|261026140227099003|261021121427099003|261028144727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: DvaaLVeSI8Y32Ip7KqCMwqadvIrhPjoZKkY/AdkDgIt3iNDN5Jk8YerDJCU7SCrlWprX9/gKy4KaTnJ6/Mcq/NR4SOQqQJEtlIFcnl8tiMy+6LKxa9uhsLS1SE1hR1zBShBkHDWURS20SJvsRZJPydMVB3AXwr4iWItbtwaijaZ/H3f7PClqXKqd9uNcLs4l/h5jPqG5giF1DaCrJMVAmEkf7cMUisuWVkH4N9viNOzm5oDzMSThbDLAr6qjoEQxjzVT7tTEfK0XKzhFHL2E0t1TasY+Py5G+GkB/uz3YnJMiRZDkMxOKhZ2kfPGiDy0utfsvC2NpU1I/fc2tx8Gufvcqkb2HfbooZXbB+a2kCYTN3v+yEnxXk4iSI6Qryxr7WQzzaBpksLNFE9tMBNerVO41KGbw774x6GFPGDhK4TbbGXcoWJcqWC+NmdxspuevodEKxzhfy+xJUi4vs/AdXuVg7WR3ysu3/RbBrn/attdyorzO9wqzcSnAKJycRIpSgQZLUjpBkHE6nq75y1LHKHYZbBbiUYaQg9wvzu19UnCKw59pdItkMBBWdgLUiN36Aekry5H/53gQIJaCrD2CwIPcotkqfZE9/JcnPpYz/aI8O74qPgwt0AYtChhj8r3z5hTCFuT1jqU8bLbUr5aR/wP/xSHXbketbLUR+xgrVaDZdjqTfZfyJMmfHk+F5+ESK9XTkQ1YUovBuu94eqn0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(261102123227099003)(18002099003)(261102130727099003)(56012099006)(5023799004)(11063799006)(261026121527099003)(261022105027099003)(261009223027099003)(261026140227099003)(261021121427099003)(261028144727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qZ822wz1e0+8R4DRftv+nHfwTkeGv9TKfskELkD2qfX1RrtEoZiBAfNpzyRNk/qqhQ6tv/LMAfnS1EJHRwaoCwpASwBOuyXnSnlOiXRbeNn9fUjlP880yMD1dcNms94r54c7ZMOkStCZK5NGcRmE9Z7NGoTOY0fRLoV7hI6vHXWK/YnXHL0m29stha1nxC1hMj3ES823OLqCrfKFXRKd4v9RXXlve6Ex1dc228RRfyFPdrJf46ek2Gq9VyuNQ2AjtoQ1gjAs5n5vFcLYA2jqjpC2Vrxo54Qr2EQudB5o1VTb71pzPMNnJmAqXVItPLB+yQrwwJVoceQUoitTZqnY5y0BRPFacPeU/iylRa+k2MOA4nbjo9oJAnif3PVpA739iR1eYG4qp7T/6VUxKD0URiX2acESqLW399MSzBpxi0Pi0ZZMMSOyqk11lOMp7aKY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 19:08:24.6874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 011c790e-63e9-4ae2-3897-08df39ddd5cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6068
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VM_PFNMAP is set for shmem BO to prevent pin_user_pages() from pining BO
memory. Replacing it with VM_MIXEDMAP breaks this behavior.

Keep the VM_PFNMAP mapping established by drm_gem_shmem_mmap() and
populate its page tables with remap_pfn_range() immediately after
creating the mapping.

Fixes: df4d5352063a ("accel/amdxdna: Fix unsafe use of handle_mm_fault()")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 157 +++++++++++-----------------
 1 file changed, 62 insertions(+), 95 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 46b9f6c960d7..09e48c794e1b 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -564,11 +564,51 @@ static void amdxdna_mark_mapp_invalid(struct amdxdna_gem_obj *abo,
 	up_write(&xdna->notifier_lock);
 }
 
+static int amdxdna_remap_pages(struct amdxdna_gem_obj *abo,
+			       struct vm_area_struct *vma)
+{
+	unsigned long num_pages = vma_pages(vma);
+	struct page **pages = abo->base.pages;
+	unsigned long i, nr;
+	int ret;
+
+	for (i = 0; i < num_pages; i += nr) {
+		unsigned long pfn = page_to_pfn(pages[i]);
+
+		for (nr = 1; i + nr < num_pages; nr++) {
+			if (page_to_pfn(pages[i + nr]) != pfn + nr)
+				break;
+		}
+
+		ret = remap_pfn_range(vma, vma->vm_start + (i << PAGE_SHIFT), pfn,
+				      nr << PAGE_SHIFT, vma->vm_page_prot);
+		if (ret) {
+			zap_special_vma_range(vma, vma->vm_start, i << PAGE_SHIFT);
+			return ret;
+		}
+	}
+
+	/*
+	 * The page tables are populated upfront, thus the CPU never takes a
+	 * write fault and drm_gem_shmem_vm_ops.pfn_mkwrite() never marks the
+	 * folios dirty. The device writes to the pages through the IOMMU
+	 * without any notification either. And the PTEs are special in a
+	 * VM_PFNMAP VMA, so unmapping does not transfer their dirty bits
+	 * back to the folios. Mark the pages dirty when they are released,
+	 * the same way drm_gem_shmem_vmap() does.
+	 */
+	dma_resv_lock(to_gobj(abo)->resv, NULL);
+	abo->base.pages_mark_dirty_on_put = true;
+	abo->base.pages_mark_accessed_on_put = true;
+	dma_resv_unlock(to_gobj(abo)->resv);
+
+	return 0;
+}
+
 static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
 				struct vm_area_struct *vma)
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
-	unsigned long num_pages = vma_pages(vma);
 	int ret;
 
 	/*
@@ -587,7 +627,8 @@ static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
 			return ret;
 		}
 
-		amdxdna_mark_mapp_invalid(abo, vma);
+		if (!(vma->vm_flags & VM_PFNMAP))
+			amdxdna_mark_mapp_invalid(abo, vma);
 
 		/* Drop the reference drm_gem_mmap_obj() acquired.*/
 		drm_gem_object_put(to_gobj(abo));
@@ -600,10 +641,9 @@ static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
 		return ret;
 	}
 
-	vm_flags_mod(vma, VM_MIXEDMAP, VM_PFNMAP);
-	ret = vm_insert_pages(vma, vma->vm_start, abo->base.pages, &num_pages);
+	ret = amdxdna_remap_pages(abo, vma);
 	if (ret) {
-		XDNA_ERR(xdna, "Failed to insert pages %d", ret);
+		XDNA_ERR(xdna, "Failed to remap pages %d", ret);
 		dma_resv_lock(to_gobj(abo)->resv, NULL);
 		drm_gem_shmem_put_pages_locked(&abo->base);
 		dma_resv_unlock(to_gobj(abo)->resv);
@@ -641,99 +681,21 @@ static int amdxdna_gem_obj_mmap(struct drm_gem_object *gobj,
 	return ret;
 }
 
-/*
- * VM operations for amdxdna shmem VMAs that use VM_MIXEDMAP.
- *
- * drm_gem_shmem_vm_ops cannot be used on VM_MIXEDMAP VMAs because its fault
- * handler calls vmf_insert_pfn() → vmf_insert_pfn_prot() which contains:
- *   BUG_ON((vma->vm_flags & VM_MIXEDMAP) && pfn_valid(pfn))
- * All amdxdna shmem pages are ordinary struct pages so pfn_valid() is always
- * true, making the combination fatal.
- *
- * These ops use vmf_insert_page() (struct-page based) instead, which is the
- * correct API for VM_MIXEDMAP VMAs backed by real struct pages.  The open and
- * close handlers replicate drm_gem_shmem_vm_open/close using only exported
- * symbols.
- */
-static vm_fault_t amdxdna_gem_mixedmap_fault(struct vm_fault *vmf)
-{
-	struct vm_area_struct *vma = vmf->vma;
-	struct drm_gem_object *gobj = vma->vm_private_data;
-	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(gobj);
-	loff_t num_pages = gobj->size >> PAGE_SHIFT;
-	vm_fault_t ret = VM_FAULT_SIGBUS;
-	pgoff_t page_offset;
-	struct page *page;
-
-	/*
-	 * Partial free of vma is unexpected. Otherwise, the wrong page
-	 * will be faulted in and the user application may crash itself.
-	 */
-	page_offset = linear_page_delta(vma, vmf->address);
-
-	dma_resv_lock(gobj->resv, NULL);
-
-	if (!shmem->pages || shmem->madv < 0 || page_offset >= num_pages)
-		goto out;
-
-	page = shmem->pages[page_offset];
-	if (WARN_ON_ONCE(!page))
-		goto out;
-
-	/*
-	 * Use vmf_insert_page() (struct-page path) not vmf_insert_pfn()
-	 * (PFN path) because this VMA carries VM_MIXEDMAP.
-	 */
-	ret = vmf_insert_page(vma, vmf->address, page);
-	if (ret == VM_FAULT_NOPAGE)
-		folio_mark_accessed(page_folio(page));
-
-out:
-	dma_resv_unlock(gobj->resv);
-	return ret;
-}
-
-static void amdxdna_gem_mixedmap_vm_open(struct vm_area_struct *vma)
-{
-	struct drm_gem_object *gobj = vma->vm_private_data;
-	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(gobj);
-
-	/*
-	 * Bump pages_use_count so the page array stays alive for the new
-	 * mapping copy created by fork().  Mirrors drm_gem_shmem_vm_open().
-	 */
-	dma_resv_lock(gobj->resv, NULL);
-	drm_WARN_ON_ONCE(gobj->dev, !refcount_inc_not_zero(&shmem->pages_use_count));
-	dma_resv_unlock(gobj->resv);
-
-	drm_gem_vm_open(vma);
-}
-
-static void amdxdna_gem_mixedmap_vm_close(struct vm_area_struct *vma)
-{
-	struct drm_gem_object *gobj = vma->vm_private_data;
-	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(gobj);
-
-	dma_resv_lock(gobj->resv, NULL);
-	drm_gem_shmem_put_pages_locked(shmem);
-	dma_resv_unlock(gobj->resv);
-
-	drm_gem_vm_close(vma);
-}
-
-static const struct vm_operations_struct amdxdna_gem_mixedmap_vm_ops = {
-	.fault  = amdxdna_gem_mixedmap_fault,
-	.open   = amdxdna_gem_mixedmap_vm_open,
-	.close  = amdxdna_gem_mixedmap_vm_close,
-};
-
 static int amdxdna_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struct *vma)
 {
 	struct drm_gem_object *gobj = dma_buf->priv;
 	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
 	int ret;
 
-	vma->vm_ops = &amdxdna_gem_mixedmap_vm_ops;
+	/*
+	 * vm_pgoff is the page offset within the dma-buf, see dma_buf_mmap().
+	 * drm_gem_shmem_vm_ops indexes the BO pages by the page offset within
+	 * the VMA. Thus the mapping has to start at the beginning of the BO.
+	 */
+	if (vma->vm_pgoff)
+		return -EINVAL;
+
+	vma->vm_ops = &drm_gem_shmem_vm_ops;
 	vma->vm_private_data = gobj;
 
 	drm_gem_object_get(gobj);
@@ -741,11 +703,16 @@ static int amdxdna_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struc
 	if (ret)
 		goto put_obj;
 
-	/* The buffer is based on memory pages. Fix the flag. */
-	vm_flags_mod(vma, VM_MIXEDMAP, VM_PFNMAP);
+	ret = amdxdna_remap_pages(abo, vma);
+	if (ret)
+		goto put_pages;
 
 	return 0;
 
+put_pages:
+	dma_resv_lock(gobj->resv, NULL);
+	drm_gem_shmem_put_pages_locked(&abo->base);
+	dma_resv_unlock(gobj->resv);
 put_obj:
 	drm_gem_object_put(gobj);
 	return ret;
@@ -1043,7 +1010,7 @@ static const struct drm_gem_object_funcs amdxdna_gem_shmem_funcs = {
 	.vmap = amdxdna_gem_obj_vmap,
 	.vunmap = amdxdna_gem_obj_vunmap,
 	.mmap = amdxdna_gem_obj_mmap,
-	.vm_ops = &amdxdna_gem_mixedmap_vm_ops,
+	.vm_ops = &drm_gem_shmem_vm_ops,
 	.export = amdxdna_gem_prime_export,
 };
 
-- 
2.34.1

