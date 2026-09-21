Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88CBC982FC
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:15:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 079FC10E324;
	Mon, 21 Sep 2026 21:15:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fb53roo5";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0DCB10E324
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 21:15:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMOqHAlVIRMGKOpoXRthhxnlXNPu0gWOSLC/2w/eyERdYjv5MbmtOxI9BlQpGbPtrc+cVObxNF1tN3W1cpbEK23NlkeWvEbwwTwuf+rzxOVyzGf/LkTLZ1qc2gC3gq49qZO86s2al151RTiD197huHR5NVKH5EGc2XLh8b0YjdbbLBAAJfyQlxW/2DDkyPyvK307UVOxlDHumBI7rAZ2W58i36Z8wDM6FZctto+buZHW/FsuTo3rYJhDwcQusr5C4xYX0olmQwrBGQs9xmP6lJiaXokFu7W/PEmSEw197knrgdbvZzaOjJHPcACggNKdawoDlk6VRIveRRQA9Qe8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuRL8IEFg8FVqyy91hI4WdLAA/vCjzVMHv7IURFZyLA=;
 b=cHodxQBEVU9pL+PLHGLTbjEhsjwk1ZCkgwOi47hFP1aPjwQ3ri1q2s9CmsXKcV6a/PTonCL3XquyD83n/3KiMy6ND+gSRzS/6ihVOYN2gBBgD4uqZUfan3Do0CCUQPeQX/GkaeoD6CbpeWsvtX+5lziTf+u6BzO76nkX79m1O/ld4hLHTruQSo132QRTdee2Lio1g9b+gXRgrHoNGjBR4MUPnshP5nl3d1S8iQ099YVzoex5V8HpVIjh9b/CSEO8CXcHEhstSD1ms7BOilycFar8raBiUh/wRF2yjA2CADya1dEe1PLhoM1aGzAbBwFFq5wCi5UX9F288wEVI4hpXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuRL8IEFg8FVqyy91hI4WdLAA/vCjzVMHv7IURFZyLA=;
 b=Fb53roo5QuX9A1Lux8OOPXY5JKDeaZv/n5ILByBlA3PFB0e+AvadOU5OflIDHeorM8+7YZGWxLPJOPXXCvChyyAnY8fyC2FH+bGUTxU/xvXHmtQd+9XnXJADKzfhNmFR7eu+pzDiPxxdr8K4guSB7fi9pj3/AfASLl0mGWEXFt4=
Received: from BYAPR21CA0017.namprd21.prod.outlook.com (2603:10b6:a03:114::27)
 by PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 21:14:56 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::17) by BYAPR21CA0017.outlook.office365.com
 (2603:10b6:a03:114::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Mon,
 21 Sep 2026 21:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 21:14:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 16:14:54 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 16:14:53 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>,
 <Christian.Koenig@amd.com>, <simona@ffwll.ch>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <linaro-mm-sig@lists.linaro.org>, <sonal.santan@amd.com>
Subject: [PATCH V2] accel/amdxdna: Drop dma-buf wrapping for ubuf
Date: Mon, 21 Sep 2026 14:14:48 -0700
Message-ID: <20260921211448.39832-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|PH8PR12MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: fdea2e81-fae9-466f-5735-08df18256287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|18002099003|56012099006|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: p13sFjIKQF4kj154QQsbBYcmu6Ch2oDOLvkMtxU0nbpC+Jb56+dWMBOoR3UWjxDXZFehw1ZCtMq0lpeZ25HtuBeggD0VXtDo0W9z/63dECcviXRQDK79WV0uPiDFYvrgjqKSrQ/icowFkN+U1ldOw8k06KJMr+E1W6NGfX/5WC9+T6HjfFGAW+7uqXH1MQp4l3Ln0L3f3P7hQNb++0Rk0rtFQnxHQEvaJYkqUELUhMd7Y0QEx1maHdpw+4anPSLxcRww/jaCYsIaHATQha5CR5pPViAQXt+23bolK/yqiphsYAh6YG0IAYQTSjrUDrjrpWBx1E7etNNAs06kk0sttKym/PQGopLr47qn8Ys/HEddP3jCCLg7tfJM29AhuMlffNuh2d04sclxr5BUTnj6xO5klXxEF1d4LQwXALZ/7CQqZ2vyvm/Z2Uk9RBFilN+fLVeTvDXg2jRXBDfwwY6NQq9zTnaggFqo/yHdp+jhUbnkyaLcVngMOMROgZpMzpu2k/qCgIrOzMLr3ruuDAoO3VI6kSzPH5GrxBLRRGulR1E6EjP/i8h7kywc4uFygsF0BtJTA02TydfkIfLwF4osHSd6VujNSutbv5ylR6qqjuhsbKOCnyMvecEBgxMR24GVzMZTgospPqXsdxiXAkPH+mkxzKdWz4vQEvBS69VBnNTK8i+lykM9L+mH1piOPHmh/8LKvfolWznpjYEbAkCeCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(18002099003)(56012099006)(11063799006)(5023799004)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l9R/nNXw03nlh9eXCd1XtpZac+IgtU44rtyrwHhD6aI6OehMAGyfNMzwKwJpxaSYqXv6gBugkso2QRNegdftiiCSbnEnsqN69EgSXaBRDvUv5WjBK6htbkMqXktYRXjfLNPGR5SHynCVXVPWWxMHdPlkiY0yjFJoyAtOhff21OK9ZeIEfHzX2i2aG1Zb/Q2bSKWL4VH06M9KBRxW1DoHuXmK1YNNBk76AQSkQtJWLjvn+FV843wFsBa3udj/Qkiv1WCOypDoKMo5FcM9aM+52fLdDN6FeU56QKEgZyu8hhUXOHC7QYXVfxP2u8Ak7xyJcPnEcOAqJZJrM9FlZ0EglrITViINNAPJeregortF06nQu2o9BpyUISIHBg8UCOP+qlMM0dTiEDZY/DuzTY210z/pzi5P4/B3qiHLd23q9bV7qCNxNi4ocIi4aAsDBgAx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 21:14:55.5121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdea2e81-fae9-466f-5735-08df18256287
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6843
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

A ubuf buffer is a range of existing userspace memory passed in through
CREATE_BO. The driver currently wraps those pages in a dma-buf, then
imports that dma-buf as a GEM object. The extra layer does not add a
sharing path: ubuf is not exportable, and the pages never belonged to
the driver in the first place.

Make ubuf a DRM GEM private object and tracks the user VA with HMM
instead of a long-term pin.

  - Create the BO directly from the VA table without going through dma-buf.
    Export stays unsupported.

  - Drop pin_user_pages(FOLL_LONGTERM). Create registers an MMU interval
    notifier over the user range and marks it invalid. Command submit
    faults the range in if it is still invalid. That only works with
    PASID, which is the only mode where ubuf is supported.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
V2:
  Fix sashiko comment: remove holding process's virtual address space.

 drivers/accel/amdxdna/amdxdna_gem.c  |  85 ++++++-----
 drivers/accel/amdxdna/amdxdna_gem.h  |  12 ++
 drivers/accel/amdxdna/amdxdna_ubuf.c | 207 ++++++++++-----------------
 drivers/accel/amdxdna/amdxdna_ubuf.h |   8 +-
 4 files changed, 138 insertions(+), 174 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index f4832337ec31..a3d9a54c6563 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -164,8 +164,7 @@ void amdxdna_gem_heap_free(struct amdxdna_client *client, struct amdxdna_gem_obj
 	mutex_unlock(&client->mm_lock);
 }
 
-static void
-amdxdna_gem_destroy_obj(struct amdxdna_gem_obj *abo)
+void amdxdna_gem_destroy_obj(struct amdxdna_gem_obj *abo)
 {
 	mutex_destroy(&abo->lock);
 	kfree(abo);
@@ -190,7 +189,9 @@ void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
 
 	if (!abo->mem.kva) {
 		ret = drm_gem_vmap(to_gobj(abo), &map);
-		if (ret)
+		if (ret == -EOPNOTSUPP)
+			XDNA_DBG(xdna, "Vmap bo is not supported");
+		else if (ret)
 			XDNA_ERR(xdna, "Vmap bo failed, ret %d", ret);
 		else
 			abo->mem.kva = map.vaddr;
@@ -291,7 +292,7 @@ static void amdxdna_hmm_unregister(struct amdxdna_gem_obj *abo,
 	up_write(&xdna->notifier_lock);
 }
 
-static void amdxdna_hmm_unreg_umaps(struct amdxdna_gem_obj *abo, bool force)
+void amdxdna_hmm_unreg_umaps(struct amdxdna_gem_obj *abo, bool force)
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
 	struct amdxdna_umap *mapp, *tmp;
@@ -335,12 +336,11 @@ static void amdxdna_hmm_unreg_work(struct work_struct *work)
 	amdxdna_hmm_unreg_umaps(abo, false);
 }
 
-static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
-				struct vm_area_struct *vma)
+int amdxdna_hmm_register(struct amdxdna_gem_obj *abo, struct vm_area_struct *vma,
+			 size_t offset, size_t len)
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
-	unsigned long len = vma->vm_end - vma->vm_start;
-	unsigned long addr = vma->vm_start;
+	unsigned long addr = vma->vm_start + offset;
 	struct amdxdna_umap *mapp;
 	unsigned long nr_pages;
 	int ret;
@@ -359,7 +359,7 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
 
 	down_read(&xdna->notifier_lock);
 	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
-		if (compare_range(mapp, current->mm, addr, addr + len)) {
+		if (compare_range(mapp, vma->vm_mm, addr, addr + len)) {
 			up_read(&xdna->notifier_lock);
 			return 0;
 		}
@@ -371,15 +371,15 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
 		return -ENOMEM;
 
 	nr_pages = (PAGE_ALIGN(addr + len) - (addr & PAGE_MASK)) >> PAGE_SHIFT;
-	mapp->range.hmm_pfns = kvzalloc_objs(*mapp->range.hmm_pfns, nr_pages);
+	mapp->range.hmm_pfns = kvzalloc_objs(*mapp->range.hmm_pfns, nr_pages, GFP_KERNEL_ACCOUNT);
 	if (!mapp->range.hmm_pfns) {
 		ret = -ENOMEM;
 		goto free_map;
 	}
 
 	mapp->range.notifier = &mapp->notifier;
-	mapp->range.start = vma->vm_start;
-	mapp->range.end = vma->vm_end;
+	mapp->range.start = addr;
+	mapp->range.end = addr + len;
 	/*
 	 * Access permissions are fixed at mmap() time. Changing them later
 	 * with mprotect() is not supported: the range keeps requesting the
@@ -393,7 +393,7 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
 	kref_init(&mapp->refcnt);
 
 	ret = mmu_interval_notifier_insert_locked(&mapp->notifier,
-						  current->mm,
+						  vma->vm_mm,
 						  addr,
 						  len,
 						  &amdxdna_hmm_ops);
@@ -417,7 +417,7 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
 	return ret;
 }
 
-static struct amdxdna_gem_obj *
+struct amdxdna_gem_obj *
 amdxdna_gem_create_obj(struct drm_device *dev, size_t size)
 {
 	struct amdxdna_gem_obj *abo;
@@ -462,8 +462,9 @@ static void amdxdna_gem_dev_obj_free(struct drm_gem_object *gobj)
 	amdxdna_gem_destroy_obj(abo);
 }
 
-static void amdxdna_mark_mapp_invalid(struct amdxdna_gem_obj *abo,
-				      struct vm_area_struct *vma)
+void amdxdna_mark_mapp_invalid(struct amdxdna_gem_obj *abo,
+			       struct mm_struct *mm,
+			       unsigned long start, unsigned long end)
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
 	struct amdxdna_umap *mapp;
@@ -471,7 +472,7 @@ static void amdxdna_mark_mapp_invalid(struct amdxdna_gem_obj *abo,
 	down_write(&xdna->notifier_lock);
 	abo->mem.map_invalid = true;
 	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
-		if (compare_range(mapp, vma->vm_mm, vma->vm_start, vma->vm_end)) {
+		if (compare_range(mapp, mm, start, end)) {
 			mapp->invalid = true;
 			break;
 		}
@@ -502,7 +503,7 @@ static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
 			return ret;
 		}
 
-		amdxdna_mark_mapp_invalid(abo, vma);
+		amdxdna_mark_mapp_invalid(abo, vma->vm_mm, vma->vm_start, vma->vm_end);
 
 		/* Drop the reference drm_gem_mmap_obj() acquired.*/
 		drm_gem_object_put(to_gobj(abo));
@@ -539,7 +540,7 @@ static int amdxdna_gem_obj_mmap(struct drm_gem_object *gobj,
 		 drm_vma_node_offset_addr(&gobj->vma_node), abo->type,
 		 vma->vm_start, gobj->size);
 
-	ret = amdxdna_hmm_register(abo, vma);
+	ret = amdxdna_hmm_register(abo, vma, 0, vma->vm_end - vma->vm_start);
 	if (ret)
 		return ret;
 
@@ -682,7 +683,7 @@ static struct dma_buf *amdxdna_gem_prime_export(struct drm_gem_object *gobj, int
 	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 
-	if (abo->private_buffer)
+	if (is_private_bo(abo))
 		return ERR_PTR(-EOPNOTSUPP);
 
 	if (abo->dma_buf) {
@@ -766,7 +767,7 @@ static void amdxdna_gem_obj_free(struct drm_gem_object *gobj)
 		drm_gem_shmem_free(&abo->base);
 }
 
-static int amdxdna_gem_obj_open(struct drm_gem_object *gobj, struct drm_file *filp)
+int amdxdna_gem_obj_open(struct drm_gem_object *gobj, struct drm_file *filp)
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(gobj->dev);
 	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
@@ -805,7 +806,7 @@ static int amdxdna_gem_obj_open(struct drm_gem_object *gobj, struct drm_file *fi
 	return 0;
 }
 
-static void amdxdna_gem_obj_close(struct drm_gem_object *gobj, struct drm_file *filp)
+void amdxdna_gem_obj_close(struct drm_gem_object *gobj, struct drm_file *filp)
 {
 	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
 	struct amdxdna_client *client = NULL;
@@ -991,40 +992,46 @@ amdxdna_gem_create_shmem_object(struct drm_device *dev, struct amdxdna_drm_creat
 }
 
 static struct amdxdna_gem_obj *
-amdxdna_gem_create_ubuf_object(struct drm_device *dev, struct amdxdna_drm_create_bo *args)
+amdxdna_gem_create_ubuf_object(struct drm_device *dev,
+			       struct amdxdna_drm_create_bo *args,
+			       struct drm_file *filp)
 {
+	struct amdxdna_client *client = filp->driver_priv;
 	struct amdxdna_dev *xdna = to_xdna_dev(dev);
 	struct amdxdna_drm_va_tbl va_tbl;
 	struct amdxdna_gem_obj *abo;
 	struct drm_gem_object *gobj;
 	struct dma_buf *dma_buf;
 
+	if (args->type == AMDXDNA_BO_DEV_HEAP || args->type == AMDXDNA_BO_CMD)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (copy_from_user(&va_tbl, u64_to_user_ptr(args->vaddr), sizeof(va_tbl))) {
 		XDNA_DBG(xdna, "Access va table failed");
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (va_tbl.num_entries) {
-		dma_buf = amdxdna_get_ubuf(dev, va_tbl.num_entries,
-					   u64_to_user_ptr(args->vaddr + sizeof(va_tbl)));
+		abo = amdxdna_alloc_ubuf_bo(client, va_tbl.num_entries,
+					    u64_to_user_ptr(args->vaddr + sizeof(va_tbl)));
+		if (IS_ERR(abo))
+			return abo;
 	} else {
 		dma_buf = dma_buf_get(va_tbl.dmabuf_fd);
-	}
+		if (IS_ERR(dma_buf))
+			return ERR_CAST(dma_buf);
 
-	if (IS_ERR(dma_buf))
-		return ERR_CAST(dma_buf);
+		gobj = amdxdna_gem_prime_import(dev, dma_buf);
+		if (IS_ERR(gobj)) {
+			dma_buf_put(dma_buf);
+			return ERR_CAST(gobj);
+		}
 
-	gobj = amdxdna_gem_prime_import(dev, dma_buf);
-	if (IS_ERR(gobj)) {
 		dma_buf_put(dma_buf);
-		return ERR_CAST(gobj);
+		abo = to_xdna_obj(gobj);
 	}
 
-	dma_buf_put(dma_buf);
-
-	abo = to_xdna_obj(gobj);
 	abo->private_buffer = true;
-
 	return abo;
 }
 
@@ -1112,7 +1119,7 @@ amdxdna_drm_create_share_bo(struct drm_device *dev,
 	struct amdxdna_gem_obj *abo;
 
 	if (args->vaddr)
-		abo = amdxdna_gem_create_ubuf_object(dev, args);
+		abo = amdxdna_gem_create_ubuf_object(dev, args, filp);
 	else if (amdxdna_use_carveout(to_xdna_dev(dev)))
 		abo = amdxdna_gem_create_cbuf_object(dev, args);
 	else
@@ -1293,7 +1300,7 @@ static int amdxdna_bo_pin(struct amdxdna_gem_obj *abo)
 	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
 	int ret;
 
-	if (is_import_bo(abo))
+	if (is_import_bo(abo) || is_private_bo(abo))
 		return 0;
 
 	ret = drm_gem_shmem_pin(&abo->base);
@@ -1306,7 +1313,7 @@ static void amdxdna_bo_unpin(struct amdxdna_gem_obj *abo)
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
 
-	if (is_import_bo(abo))
+	if (is_import_bo(abo) || is_private_bo(abo))
 		return;
 
 	drm_gem_shmem_unpin(&abo->base);
@@ -1406,7 +1413,7 @@ int amdxdna_drm_get_bo_info_ioctl(struct drm_device *dev, void *data, struct drm
 	args->vaddr = amdxdna_gem_uva(abo);
 	args->xdna_addr = amdxdna_gem_dev_addr(abo);
 
-	if (abo->type != AMDXDNA_BO_DEV)
+	if (abo->type != AMDXDNA_BO_DEV && !is_private_bo(abo))
 		args->map_offset = drm_vma_node_offset_addr(&gobj->vma_node);
 	else
 		args->map_offset = AMDXDNA_INVALID_ADDR;
diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
index 9b4aa21a37c9..815348a3c429 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.h
+++ b/drivers/accel/amdxdna/amdxdna_gem.h
@@ -60,6 +60,7 @@ struct amdxdna_gem_obj {
 
 #define to_gobj(obj)    (&(obj)->base.base)
 #define is_import_bo(obj) ((obj)->attach)
+#define is_private_bo(obj) ((obj)->private_buffer)
 
 static inline struct amdxdna_gem_obj *to_xdna_obj(struct drm_gem_object *gobj)
 {
@@ -112,10 +113,21 @@ amdxdna_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf);
 struct amdxdna_gem_obj *
 amdxdna_drm_create_dev_bo(struct drm_device *dev,
 			  struct amdxdna_drm_create_bo *args, struct drm_file *filp);
+struct amdxdna_gem_obj *
+amdxdna_gem_create_obj(struct drm_device *dev, size_t size);
+void amdxdna_gem_destroy_obj(struct amdxdna_gem_obj *abo);
+void amdxdna_hmm_unreg_umaps(struct amdxdna_gem_obj *abo, bool force);
 
 int amdxdna_gem_pin_nolock(struct amdxdna_gem_obj *abo);
 int amdxdna_gem_pin(struct amdxdna_gem_obj *abo);
 void amdxdna_gem_unpin(struct amdxdna_gem_obj *abo);
+int amdxdna_gem_obj_open(struct drm_gem_object *gobj, struct drm_file *filp);
+void amdxdna_gem_obj_close(struct drm_gem_object *gobj, struct drm_file *filp);
+int amdxdna_hmm_register(struct amdxdna_gem_obj *abo, struct vm_area_struct *vma,
+			 size_t offset, size_t len);
+void amdxdna_mark_mapp_invalid(struct amdxdna_gem_obj *abo,
+			       struct mm_struct *mm,
+			       unsigned long start, unsigned long end);
 
 int amdxdna_drm_create_bo_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
 int amdxdna_drm_get_bo_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
index 0e0cd69cd1fb..5c291786d981 100644
--- a/drivers/accel/amdxdna/amdxdna_ubuf.c
+++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
@@ -6,182 +6,127 @@
 #include <drm/amdxdna_accel.h>
 #include <drm/drm_device.h>
 #include <drm/drm_print.h>
-#include <linux/dma-buf.h>
 #include <linux/overflow.h>
 #include <linux/pagemap.h>
 #include <linux/vmalloc.h>
 
+#include "amdxdna_gem.h"
 #include "amdxdna_pci_drv.h"
 #include "amdxdna_ubuf.h"
 
-struct amdxdna_ubuf_priv {
-	struct page **pages;
-	u64 nr_pages;
-	struct mm_struct *mm;
-};
-
-static struct sg_table *amdxdna_ubuf_map(struct dma_buf_attachment *attach,
-					 enum dma_data_direction direction)
+static int amdxdna_ubuf_hmm_register(struct amdxdna_client *client,
+				     struct amdxdna_gem_obj *abo,
+				     struct amdxdna_drm_va_entry *va_ent)
 {
-	struct amdxdna_ubuf_priv *ubuf = attach->dmabuf->priv;
-	struct sg_table *sg;
+	struct vm_area_struct *vma;
 	int ret;
 
-	sg = kzalloc_obj(*sg);
-	if (!sg)
-		return ERR_PTR(-ENOMEM);
-
-	ret = sg_alloc_table_from_pages(sg, ubuf->pages, ubuf->nr_pages, 0,
-					ubuf->nr_pages << PAGE_SHIFT, GFP_KERNEL);
-	if (ret)
-		goto err_free_sg;
+	mmap_write_lock(client->mm);
+	vma = find_vma(client->mm, va_ent->vaddr);
+	if (!vma || vma->vm_start > va_ent->vaddr ||
+	    vma->vm_end - va_ent->vaddr < va_ent->len) {
+		ret = -EINVAL;
+		goto unlock;
+	}
 
-	ret = dma_map_sgtable(attach->dev, sg, direction, 0);
-	if (ret)
-		goto err_free_table;
+	ret = amdxdna_hmm_register(abo, vma, va_ent->vaddr - vma->vm_start, va_ent->len);
 
-	return sg;
+unlock:
+	mmap_write_unlock(client->mm);
 
-err_free_table:
-	sg_free_table(sg);
-err_free_sg:
-	kfree(sg);
-	return ERR_PTR(ret);
+	return ret;
 }
 
-static void amdxdna_ubuf_unmap(struct dma_buf_attachment *attach,
-			       struct sg_table *sg,
-			       enum dma_data_direction direction)
+static void amdxdna_gem_ubuf_obj_free(struct drm_gem_object *gobj)
 {
-	dma_unmap_sgtable(attach->dev, sg, direction, 0);
-	sg_free_table(sg);
-	kfree(sg);
+	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
+
+	amdxdna_hmm_unreg_umaps(abo, true);
+	cancel_work_sync(&abo->hmm_unreg_work);
+
+	drm_gem_object_release(gobj);
+	amdxdna_gem_destroy_obj(abo);
 }
 
-static void amdxdna_ubuf_release(struct dma_buf *dbuf)
+static struct dma_buf *amdxdna_gem_ubuf_obj_export(struct drm_gem_object *gobj, int flags)
 {
-	struct amdxdna_ubuf_priv *ubuf = dbuf->priv;
-
-	unpin_user_pages(ubuf->pages, ubuf->nr_pages);
-	kvfree(ubuf->pages);
-	atomic64_sub(ubuf->nr_pages, &ubuf->mm->pinned_vm);
-	mmdrop(ubuf->mm);
-	kfree(ubuf);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
-static const struct dma_buf_ops amdxdna_ubuf_dmabuf_ops = {
-	.map_dma_buf = amdxdna_ubuf_map,
-	.unmap_dma_buf = amdxdna_ubuf_unmap,
-	.release = amdxdna_ubuf_release,
+static const struct drm_gem_object_funcs amdxdna_gem_ubuf_obj_funcs = {
+	.free = amdxdna_gem_ubuf_obj_free,
+	.open = amdxdna_gem_obj_open,
+	.close = amdxdna_gem_obj_close,
+	.export = amdxdna_gem_ubuf_obj_export,
 };
 
-struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
-				 u32 num_entries, void __user *va_entries)
+struct amdxdna_gem_obj *amdxdna_alloc_ubuf_bo(struct amdxdna_client *client,
+					      u32 num_entries, void __user *va_entries)
 {
-	struct amdxdna_dev *xdna = to_xdna_dev(dev);
-	unsigned long lock_limit, new_pinned;
+	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_drm_va_entry *va_ent;
-	struct amdxdna_ubuf_priv *ubuf;
-	u32 npages, start = 0;
-	struct dma_buf *dbuf;
-	int i, ret;
-	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct amdxdna_gem_obj *abo;
+	size_t bufsize;
+	long ret;
 
-	if (!can_do_mlock())
-		return ERR_PTR(-EPERM);
+	if (!amdxdna_pasid_on(client))
+		return ERR_PTR(-EOPNOTSUPP);
 
-	ubuf = kzalloc_obj(*ubuf);
-	if (!ubuf)
-		return ERR_PTR(-ENOMEM);
+	/*
+	 * There is not any valid case to use more than 1 entry.
+	 * Hardcode maximum entries to 1.
+	 */
+	if (num_entries > 1)
+		return ERR_PTR(-EINVAL);
 
-	ubuf->mm = current->mm;
-	mmgrab(ubuf->mm);
+	if (current->mm != client->mm)
+		return ERR_PTR(-EINVAL);
 
-	va_ent = kvzalloc_objs(*va_ent, num_entries);
-	if (!va_ent) {
-		ret = -ENOMEM;
-		goto free_ubuf;
-	}
+	va_ent = kvzalloc_obj(*va_ent);
+	if (!va_ent)
+		return ERR_PTR(-ENOMEM);
 
-	if (copy_from_user(va_ent, va_entries, sizeof(*va_ent) * num_entries)) {
+	if (copy_from_user(va_ent, va_entries, sizeof(*va_ent))) {
 		XDNA_DBG(xdna, "Access va entries failed");
 		ret = -EINVAL;
 		goto free_ent;
 	}
 
-	for (i = 0, exp_info.size = 0; i < num_entries; i++) {
-		if (!IS_ALIGNED(va_ent[i].vaddr, PAGE_SIZE) ||
-		    !IS_ALIGNED(va_ent[i].len, PAGE_SIZE)) {
-			XDNA_ERR(xdna, "Invalid address or len %llx, %llx",
-				 va_ent[i].vaddr, va_ent[i].len);
-			ret = -EINVAL;
-			goto free_ent;
-		}
-
-		if (check_add_overflow(exp_info.size, va_ent[i].len, &exp_info.size)) {
-			ret = -EINVAL;
-			goto free_ent;
-		}
-	}
-
-	ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
-	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-	new_pinned = atomic64_add_return(ubuf->nr_pages, &ubuf->mm->pinned_vm);
-	if (new_pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
-		XDNA_DBG(xdna, "New pin %ld, limit %ld, cap %d",
-			 new_pinned, lock_limit, capable(CAP_IPC_LOCK));
-		ret = -ENOMEM;
-		goto sub_pin_cnt;
+	if (!IS_ALIGNED(va_ent->vaddr, PAGE_SIZE) ||
+	    !IS_ALIGNED(va_ent->len, PAGE_SIZE) ||
+	    !va_ent->len ||
+	    check_add_overflow(va_ent->vaddr, va_ent->len, &bufsize)) {
+		XDNA_DBG(xdna, "Invalid address or len %llx, %llx",
+			 va_ent->vaddr, va_ent->len);
+		ret = -EINVAL;
+		goto free_ent;
 	}
 
-	ubuf->pages = kvmalloc_objs(*ubuf->pages, ubuf->nr_pages);
-	if (!ubuf->pages) {
-		ret = -ENOMEM;
-		goto sub_pin_cnt;
+	bufsize = va_ent->len;
+	abo = amdxdna_gem_create_obj(&xdna->ddev, bufsize);
+	if (IS_ERR(abo)) {
+		ret = PTR_ERR(abo);
+		goto free_ent;
 	}
 
-	for (i = 0; i < num_entries; i++) {
-		npages = va_ent[i].len >> PAGE_SHIFT;
-
-		ret = pin_user_pages_fast(va_ent[i].vaddr, npages,
-					  FOLL_WRITE | FOLL_LONGTERM,
-					  &ubuf->pages[start]);
-		if (ret >= 0) {
-			start += ret;
-			if (ret != npages) {
-				XDNA_ERR(xdna, "Partially pinned pages %d/%u", ret, npages);
-				ret = -ENOMEM;
-				goto destroy_pages;
-			}
-		} else {
-			XDNA_ERR(xdna, "Failed to pin pages ret %d", ret);
-			goto destroy_pages;
-		}
-	}
+	abo->type = AMDXDNA_BO_SHARE;
+	abo->mem.uva = va_ent->vaddr;
+	to_gobj(abo)->funcs = &amdxdna_gem_ubuf_obj_funcs;
+	drm_gem_private_object_init(&xdna->ddev, to_gobj(abo), bufsize);
 
-	exp_info.ops = &amdxdna_ubuf_dmabuf_ops;
-	exp_info.priv = ubuf;
-	exp_info.flags = O_RDWR | O_CLOEXEC;
+	ret = amdxdna_ubuf_hmm_register(client, abo, va_ent);
+	if (ret)
+		goto put_obj;
 
-	dbuf = dma_buf_export(&exp_info);
-	if (IS_ERR(dbuf)) {
-		ret = PTR_ERR(dbuf);
-		goto destroy_pages;
-	}
+	amdxdna_mark_mapp_invalid(abo, client->mm, va_ent->vaddr,
+				  va_ent->vaddr + va_ent->len);
 	kvfree(va_ent);
 
-	return dbuf;
+	return abo;
 
-destroy_pages:
-	if (start)
-		unpin_user_pages(ubuf->pages, start);
-	kvfree(ubuf->pages);
-sub_pin_cnt:
-	atomic64_sub(ubuf->nr_pages, &ubuf->mm->pinned_vm);
+put_obj:
+	drm_gem_object_put(to_gobj(abo));
 free_ent:
 	kvfree(va_ent);
-free_ubuf:
-	mmdrop(ubuf->mm);
-	kfree(ubuf);
 	return ERR_PTR(ret);
 }
diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.h b/drivers/accel/amdxdna/amdxdna_ubuf.h
index 8900a6dc4371..f6335603da34 100644
--- a/drivers/accel/amdxdna/amdxdna_ubuf.h
+++ b/drivers/accel/amdxdna/amdxdna_ubuf.h
@@ -5,10 +5,10 @@
 #ifndef _AMDXDNA_UBUF_H_
 #define _AMDXDNA_UBUF_H_
 
-#include <drm/drm_device.h>
-#include <linux/dma-buf.h>
+#include "amdxdna_gem.h"
+#include "amdxdna_pci_drv.h"
 
-struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
-				 u32 num_entries, void __user *va_entries);
+struct amdxdna_gem_obj *amdxdna_alloc_ubuf_bo(struct amdxdna_client *client,
+					      u32 num_entries, void __user *va_entries);
 
 #endif /* _AMDXDNA_UBUF_H_ */
-- 
2.34.1

