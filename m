Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5A5606A334
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sSCcKaXF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A1E110E12D;
	Tue, 10 Nov 2026 20:27:14 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010046.outbound.protection.outlook.com [52.101.85.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4A5910E12D
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 20:27:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnGNJnfVTujv+7RVInUv7v+MEmyMIYBLSZndq0hXdscvcWAQJBEqhdIP0XllybxBY0pOfhKnDF9FTEzYdijd5s622wb/k6weMyxdzbJI++k1f3J+3ZAaHZYKyzgraor5hfhOmTRSHG/2BuST/VGg8erfEQNWU1x6koz78wdJrYatbSCHkJc8RcJNbzHtrLKaDo07gD3Rdbu5kF6L3h/IdS9mkoxQaqpub7qXGHbn0dqjzqR+TFosGIXnWES5wWx/qJ99OHXZawwzUTAUsmn3pexgp+2GPatjP8s8B8Y4FQaIlLQnIf/dKHBPHGvNczwpaE25xco1n6qOOsA5nlVc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vW/on/bxFv0w5UaEAHO2pLxWAlQxOEe6mXim4gItsXw=;
 b=DFBIeRXzHwB9dA8cdBXPpAhIOsT7I/5GLEWVwzzKRvCAV5avSWZdEkj6j/WDjD3jkkoO/+3hnBxxTVlToyE9sjVdeapo6WPLs2Nd5A28XrzgPelw9xKYS9/t3lpuVYQTs9ANcX4+vFr7mrDbI8ndq6FaiRIRd2eMTtiweQDOUTdo7YlJlrj+VH4UBtYcqoj2yhKMpAE72UuY4lRqMkRiBd/WwwXq1G5bT0nz6NWSgwkF1intOl6B6W3MJjI3tCCnSpUR69o2A3P9wHPtQ0nsGcE/qfShVRQYirtEgNXrHohMbJAm4ui2lAUp2pGZXig3ba1RG4Fkd6CgrDOyal9VfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW/on/bxFv0w5UaEAHO2pLxWAlQxOEe6mXim4gItsXw=;
 b=sSCcKaXFzsU2qkIZm5ZmvTM2gXLDyjKJIWDzmPZhQzve1/v9VT6XHFmtobUml6QiQxrtvyICaZWq2eHE5ie+5Bc/mCfN3S9hvnuEnIzd8HEDlhXqAB1a0M3mPLGOjx8uniKIZ/LEok81+BCFflINkv6CO+BeauOSTfAs6pI1BGs=
Received: from BN0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:408:e4::24)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:27:00 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::80) by BN0PR02CA0019.outlook.office365.com
 (2603:10b6:408:e4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Tue,
 10 Nov 2026 20:26:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 20:26:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 14:26:59 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 14:26:59 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 14:26:58 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>,
 <Christian.Koenig@amd.com>, <simona@ffwll.ch>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <linaro-mm-sig@lists.linaro.org>, <sonal.santan@amd.com>
Subject: [PATCH V3] accel/amdxdna: Drop dma-buf wrapping for ubuf
Date: Tue, 10 Nov 2026 12:26:44 -0800
Message-ID: <20261110202644.3270432-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: b9906dca-4c1c-4088-8d08-08df3f68f92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|56012099006|5023799004|11063799006|18002099003|10067099003|261009223027099003|261009221227099003|261021121427099003|261028144727099003|261021123027099003|261102130727099003|261102123227099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: 0zAxqnKEs3cMefENUij+ZH8uVvRep4Zy/JLCdwrB/XMifcEw+EAXImTVnm8FYLK2CP3iaFcluSMBjyEMWFXUX4w5z5CyqK+N++zjutY0DNFKS2B6mSF8n+/w1jtinfX+2+NYhnMRpTYT4P6J+r5AUbpa6wg8W4/yO5CvfEgbB3yRksQ1lKiL6YzqcJYztX0+xmeR0pjVXH92kUVQy6DywPWNJkHwwQ0+gw3QdueIFd0Q+OR9+U/qxXkVLsBwrP3GOslItgKfAeIc6Ha4Xl76FZiiF7T+b1+m4nqRRQC2556wUm0lzWyZG84Tog5v3CfLZMBO8vqxHJigUBT4r3Yd7cOvsLU4hHvrrQC4mmlK3byt7XBzEYwptobvbI+r3RpdLU6oAPTgRSfHpLUdWSE7YDZGZ2+OjFhQeEAMw4yKSh/n4d3amDo/tkbDrPyOdXmpzzL8SLefBvhpctEJZJ8+YBrabfgZFsQkiVfAmsCDsJNiL33IB2Yxsao+urDihD/ND6mSMWfDc8csHKhOitYKS44rXnb5tIr5Bh4Ed6XDR6ttrghJfhP8UZjNnrdv1Ln41k5YsK3A5LG5i4M7BhIP+0qt3YYL/OWc2kfcBJ/Lmkyeq4ekSZ6oHehObLv+5Fb5MjXcojR9u1U5jHti4ojsgF8Q7j5B/UKW5BXKvIckyXj8+5e4ixNZVxwEOZcit4XlrIjDdHPSzuX+6xcZN3Am6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(56012099006)(5023799004)(11063799006)(18002099003)(10067099003)(261009223027099003)(261009221227099003)(261021121427099003)(261028144727099003)(261021123027099003)(261102130727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ns5pRdVM/2MTYVuJqNjBy657CqUiuYiM6oYfrvQUX375UjWH35gkTKdw8h0GJeXRNo4LWrGYL/SglgGjUWDp0D5je8GFTdhdxK3NKcMCt3pZMHR1Cr9T3ak2wKnI0EB864FPAT8U0N6p6SdIw3wVtzIHCEVF6IjXHR9edDsJg0M8ZLANjLcU75zq206XglZIFuGyOD16ROeYYChIoM3GLGygL5Mtop/JC/kpULHZvMVnjFIywwlcCJSa9DQVVz/e7LXQBgyEZiwr+Rfk0DZq0d3A01BrYwxoqubKiA0uEvv1eYhqrcgSflKG4HHD7iVfduMDTC+riweFq08E+dIcAI1M1TST2szH11uy+R9t6XdKhYJaGIoezCJ9Q8so6c55s+wylCF5ZBgUrHM7I0GnTlBM/ur9d2pSxy5YoO8+I1vS3VluQh+ts2DlP6hFI6Ry
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 20:26:59.8917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9906dca-4c1c-4088-8d08-08df3f68f92a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248
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
V3:
  Sync to the latest code.
V2:
  Fix sashiko comment: remove holding process's virtual address space.

 drivers/accel/amdxdna/amdxdna_gem.c  |  70 ++++-----
 drivers/accel/amdxdna/amdxdna_gem.h  |  10 ++
 drivers/accel/amdxdna/amdxdna_ubuf.c | 207 ++++++++++-----------------
 drivers/accel/amdxdna/amdxdna_ubuf.h |   8 +-
 4 files changed, 128 insertions(+), 167 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index ffe12a722dfea..a94195ea4e045 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -165,8 +165,7 @@ void amdxdna_gem_heap_free(struct amdxdna_client *client, struct amdxdna_gem_obj
 	mutex_unlock(&client->mm_lock);
 }
 
-static void
-amdxdna_gem_destroy_obj(struct amdxdna_gem_obj *abo)
+void amdxdna_gem_destroy_obj(struct amdxdna_gem_obj *abo)
 {
 	mutex_destroy(&abo->lock);
 	kfree(abo);
@@ -191,7 +190,9 @@ void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
 
 	if (!abo->mem.kva) {
 		ret = drm_gem_vmap(to_gobj(abo), &map);
-		if (ret)
+		if (ret == -EOPNOTSUPP)
+			XDNA_DBG(xdna, "Vmap bo is not supported");
+		else if (ret)
 			XDNA_ERR(xdna, "Vmap bo failed, ret %d", ret);
 		else
 			abo->mem.kva = map.vaddr;
@@ -331,7 +332,7 @@ static void amdxdna_umap_put(struct amdxdna_umap *mapp)
 	kref_put(&mapp->refcnt, amdxdna_umap_release);
 }
 
-static void amdxdna_hmm_unreg_umaps(struct amdxdna_gem_obj *abo, bool force)
+void amdxdna_hmm_unreg_umaps(struct amdxdna_gem_obj *abo, bool force)
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
 	struct amdxdna_umap *mapp, *tmp;
@@ -452,12 +453,11 @@ bool amdxdna_gem_umap_stale(struct amdxdna_gem_obj *abo)
 	return false;
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
 	int ret;
 
@@ -524,7 +524,7 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
 	return 0;
 }
 
-static struct amdxdna_gem_obj *
+struct amdxdna_gem_obj *
 amdxdna_gem_create_obj(struct drm_device *dev, size_t size)
 {
 	struct amdxdna_gem_obj *abo;
@@ -569,7 +569,7 @@ static void amdxdna_gem_dev_obj_free(struct drm_gem_object *gobj)
 	amdxdna_gem_destroy_obj(abo);
 }
 
-static void amdxdna_mark_map_invalid(struct amdxdna_gem_obj *abo)
+void amdxdna_mark_map_invalid(struct amdxdna_gem_obj *abo)
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
 
@@ -678,7 +678,7 @@ static int amdxdna_gem_obj_mmap(struct drm_gem_object *gobj,
 		 drm_vma_node_offset_addr(&gobj->vma_node), abo->type,
 		 vma->vm_start, gobj->size);
 
-	ret = amdxdna_hmm_register(abo, vma);
+	ret = amdxdna_hmm_register(abo, vma, 0, vma->vm_end - vma->vm_start);
 	if (ret)
 		return ret;
 
@@ -748,7 +748,7 @@ static struct dma_buf *amdxdna_gem_prime_export(struct drm_gem_object *gobj, int
 	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 
-	if (abo->private_buffer)
+	if (is_private_bo(abo))
 		return ERR_PTR(-EOPNOTSUPP);
 
 	if (abo->dma_buf) {
@@ -832,7 +832,7 @@ static void amdxdna_gem_obj_free(struct drm_gem_object *gobj)
 		drm_gem_shmem_free(&abo->base);
 }
 
-static int amdxdna_gem_obj_open(struct drm_gem_object *gobj, struct drm_file *filp)
+int amdxdna_gem_obj_open(struct drm_gem_object *gobj, struct drm_file *filp)
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(gobj->dev);
 	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
@@ -871,7 +871,7 @@ static int amdxdna_gem_obj_open(struct drm_gem_object *gobj, struct drm_file *fi
 	return 0;
 }
 
-static void amdxdna_gem_obj_close(struct drm_gem_object *gobj, struct drm_file *filp)
+void amdxdna_gem_obj_close(struct drm_gem_object *gobj, struct drm_file *filp)
 {
 	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
 	struct amdxdna_client *client = NULL;
@@ -1057,40 +1057,46 @@ amdxdna_gem_create_shmem_object(struct drm_device *dev, struct amdxdna_drm_creat
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
+		abo->private_buffer = true;
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
-	abo->private_buffer = true;
-
 	return abo;
 }
 
@@ -1178,7 +1184,7 @@ amdxdna_drm_create_share_bo(struct drm_device *dev,
 	struct amdxdna_gem_obj *abo;
 
 	if (args->vaddr)
-		abo = amdxdna_gem_create_ubuf_object(dev, args);
+		abo = amdxdna_gem_create_ubuf_object(dev, args, filp);
 	else if (amdxdna_use_carveout(to_xdna_dev(dev)))
 		abo = amdxdna_gem_create_cbuf_object(dev, args);
 	else
@@ -1364,7 +1370,7 @@ static int amdxdna_bo_pin(struct amdxdna_gem_obj *abo)
 	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
 	int ret;
 
-	if (is_import_bo(abo))
+	if (is_import_bo(abo) || is_private_bo(abo))
 		return 0;
 
 	ret = drm_gem_shmem_pin(&abo->base);
@@ -1377,7 +1383,7 @@ static void amdxdna_bo_unpin(struct amdxdna_gem_obj *abo)
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
 
-	if (is_import_bo(abo))
+	if (is_import_bo(abo) || is_private_bo(abo))
 		return;
 
 	drm_gem_shmem_unpin(&abo->base);
@@ -1477,7 +1483,7 @@ int amdxdna_drm_get_bo_info_ioctl(struct drm_device *dev, void *data, struct drm
 	args->vaddr = amdxdna_gem_uva(abo);
 	args->xdna_addr = amdxdna_gem_dev_addr(abo);
 
-	if (abo->type != AMDXDNA_BO_DEV)
+	if (abo->type != AMDXDNA_BO_DEV && !is_private_bo(abo))
 		args->map_offset = drm_vma_node_offset_addr(&gobj->vma_node);
 	else
 		args->map_offset = AMDXDNA_INVALID_ADDR;
diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
index 2deead107d6b1..b55c5f11cbb18 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.h
+++ b/drivers/accel/amdxdna/amdxdna_gem.h
@@ -67,6 +67,7 @@ struct amdxdna_gem_obj {
 
 #define to_gobj(obj)    (&(obj)->base.base)
 #define is_import_bo(obj) ((obj)->attach)
+#define is_private_bo(obj) ((obj)->private_buffer)
 
 static inline struct amdxdna_gem_obj *to_xdna_obj(struct drm_gem_object *gobj)
 {
@@ -121,10 +122,19 @@ amdxdna_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf);
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
+void amdxdna_mark_map_invalid(struct amdxdna_gem_obj *abo);
 
 int amdxdna_drm_create_bo_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
 int amdxdna_drm_get_bo_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
index 0e0cd69cd1fbf..a5e202fbc72b9 100644
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
+	if (!ret && !(vma->vm_flags & (VM_PFNMAP | VM_IO)))
+		amdxdna_mark_map_invalid(abo);
 
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
index 8900a6dc4371b..f6335603da348 100644
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

base-commit: 41b5458595c60143d0ebaa1e032c9cda5d764dff
-- 
2.34.1

