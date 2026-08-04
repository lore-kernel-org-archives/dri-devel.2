Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C566C55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 09:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3F5610E973;
	Tue,  4 Aug 2026 09:44:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DtHRwQsa";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E193E10E978;
 Tue,  4 Aug 2026 09:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJRd8PyU9gItbclHBHwUj2w7Y1O8NpJZBpaw2tO62ONAjKORL2iauoiinWutgysxgvIvxg13omtGuwdMvr9sdTww+ZMWFitEbgJTFpbPNColby/rxf4u6HAxAy1T2VLobPe0D3VDzw4v1Bd0aWjoKOmRm5fJS21cbwRZJVkY16KZw1kGIfeecdDF5XNqeXFtC8TDQmmxP8eLlfCT9KDTsH3e0OlTW45hZCMeF79aZkDYPmYRLuuewcjfDHBqqgmMVop+WCG+Xk8h+M/NmKxdwbAkdUb6ndBw9hfos5y4MnNBccW/7OR8zoVDNCmKox87MXw7H87M2Dloi+KUpvR76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nP8ipM57a5YrxOKCLJhVOjW+0jD9QsUxUNDRK7g9RMY=;
 b=WGd5A+r0vBiTwc32x/PcJM1B51UMW9EbREdivoBcGXq6AYHxMTQWETnouf3D6Nyy08J1uhTHzip+F2HwVWODKOm+zyvNs8s4Cz0V6rSWTmorAQeuduBY3KVNFkc0Fyj4bF4J7VH95/Shv14XTl5sUB2dopZ5Zms5mJrVXbAwESRO+pGT/PxiH3KUEphWKlXujb9d9QIgfUwm9s3T9ewQz5+JHw8x9eD4wib9YtrHMpRw0+TC/swciruccmLu1ZrFuy/16usTIBDCCBOSzbItgdpyhuc6iuji1uBgNA0gpVneCaFNPVdTu4uSotsLrBN/dHlpIlAmFkTxxWWndpIAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nP8ipM57a5YrxOKCLJhVOjW+0jD9QsUxUNDRK7g9RMY=;
 b=DtHRwQsaDTCsS6Ny2alDPDLFzsHxTSjOevf4cSo3XCECenVRPeu62IkCFENvNwzrgtsNSvlfX3jkiVemqXEQ6M3Rr8+wtX3TtSa7NYXRk2CbighlkUEbaAdPmzvqG8WH7PYMj8S2M7hrwhgY/iX8XJMwQDzCg0q98UsrmqyVdZY=
Received: from MW4PR03CA0081.namprd03.prod.outlook.com (2603:10b6:303:b6::26)
 by MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 09:43:56 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::7b) by MW4PR03CA0081.outlook.office365.com
 (2603:10b6:303:b6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 09:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 09:43:56 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:43:51 -0500
From: Huang Rui <ray.huang@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>, "Matthew
 Brost" <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>, "Jenny
 Liu" <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 "Honglei
 Huang" <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [PATCH v9 11/18] drm/amdgpu: add SVM ioctl entry and fault handler
 module
Date: Tue, 4 Aug 2026 17:42:37 +0800
Message-ID: <20260804094246.1719318-12-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804094246.1719318-1-ray.huang@amd.com>
References: <20260804094246.1719318-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d2518c-d0ec-4004-1460-08def20ce6fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|18002099003|22082099003|11063799006|3023799007|10067099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: +ryMOV3R1SoyqrejlrLIIJYxS7Pz9vmSZsHjaAhKn87NISEEcX7IUBYAF1RaXQsL4/DC2jZYQYOmK0BXW86W5MOnjPt09JwEzyS5ttsqrSRNcaPgfvm2Til0IEsIISPnHdrE76Pn1nOuXJyk3GYXhN5WxGeMylbIBEP0Pfgb3muOd3ON2hO3W6G9bmZPg71gd0+KzhUGiFIawJfzGO++MSIWOUBgfK+lCTAj/wsHFQdEy7YLTxxIavicL1iRApSP3rfUVdUncbfaBNxn6G23DSM4eRYM7Bbu71Bi1q7hoLLVlD/WVfT7NF4TEDWooRQmrNKOmbzuoVK4ecj2odiXVoHj65V8UBeQ95OhpsSzBuHevdhy/qXNrHMtUtf+PSJySMXkldRPVDsX8MKjezu+7eVtxRtuD+YVUk+C417ALFU0HgHGW0QXyqHaNmalcuK5LtDrcIN2b0oAVetb4CoP2c1DEmnma+qc55WTeZajCpG2QochOkCuV82vDZlaqs872xcMDGMsDUoPqEyYjoPafV115tyZdL/ZMdybuESXUrR1GOoKHcDbTPHCvVLkRe9Z/4nGh1txdFot1nEUHMwDahJvRSEfL9P8c0DBoz+PZhT6oz4H+0ly8KWRK37+uDQkAufuyWEiWgmdsXahXLl1LWwZPPMXcSfIaoKsf48fkPcUjx+MtioFcU5YRW1G6mu/r+4XyIqBN/SBUaSUdS+rb5hpBQ56bP0tL9k1HYC8/MHBsS+h2uP7ltbsdssZdUVn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(3023799007)(10067099003)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uidLd+lN8Xrbucn2UB5yXs9BPhJbBTvp0gAThcLGEetSzlkT9/HihC1XXWO7/AtswEAQWDkcPhndahIr6FAsx14jMcEfVh3Tc4rN2Ix4D/N0x2ACNMOmFJYXKQiI9KHnaPGwZynYgcS/eNNRbIaaDxFyl3aO2z4AvLarmhWiWW01hHgVc26saeIHwsikKsSM54+BnAVyqeErEJGb3Jgn6VCtY303Vldp6YChnmaP4xDz4i1z8qk6o6yMgyiXdJihvdSJ//5HPLvxiW5U6jATV4idqMJDYWXHd2Ea7OnAcVD2zXmHvbGZsqXlVTlKBcyu5Pyy9ppnVAbfxXk67F7TP37St8/2DQPsN2f63CwHOG1OwpapJHcK01DoB+raHc/d9TCW04lzuZ7n3QzE/jiKoBEv/puNvn5VAaSvwY8SeATDgxD7MV5L24QFdZhktnGk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:43:56.0743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d2518c-d0ec-4004-1460-08def20ce6fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484
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

From: Honglei Huang <honghuan@amd.com>

Add ioctl entry point and fault handling:

amdgpu_svm.c additions:
- amdgpu_svm_copy_attrs: memdup_user for attribute array
- amdgpu_svm_garbage_collector: dequeue and remove unmapped ranges
- amdgpu_svm_clean_queue: drain work list releasing refs
- amdgpu_svm_gc_work_func: static GC work handler
- amdgpu_svm_gc_init/fini/flush: static workqueue lifecycle
- amdgpu_svm_work_init/work_fini: wrappers for GC lifecycle
- amdgpu_svm_sync_work: wrapper for GC flush
- amdgpu_gem_svm_ioctl: validate args, dispatch
  SET_ATTR/GET_ATTR/RESET_ATTR with copy_to_user for GET

amdgpu_svm_fault.c (new):
- fault_check_allowed: VMA permission check for fault address
- fault_get_unregistered_attrs: create default attr range for
  faulting address not covered by explicit attributes, bounded
  by VMA and granularity alignment
- fault_map_range: fault mapping pipeline with retry, GC,
  permission check, find/insert range, timestamp dedup,
  validity check, get_pages, update_mapping.
- amdgpu_svm_handle_fault: top level entry point from VM fault path

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 200 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 450 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h |  39 ++
 3 files changed, 689 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
index 7dc43470037d2..ac101574bd61d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -621,4 +621,204 @@ bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
 	return vm->svm != NULL;
 }
 
+static int amdgpu_svm_copy_attrs(const struct drm_amdgpu_gem_svm *args,
+					   struct drm_amdgpu_svm_attribute **attrs,
+					   size_t *size)
+{
+	if (!args->nattr || args->nattr > AMDGPU_SVM_MAX_ATTRS)
+		return -EINVAL;
+	if (!args->attrs_ptr)
+		return -EINVAL;
+
+	*size = args->nattr * sizeof(**attrs);
+	*attrs = memdup_user(u64_to_user_ptr(args->attrs_ptr), *size);
+
+	return PTR_ERR_OR_ZERO(*attrs);
+}
+
+/**
+ * amdgpu_svm_garbage_collector() - Remove ranges queued for unmapping
+ * @svm: The SVM context.
+ *
+ * Drain the GC list: for each queued range, remove it from the gpusvm trees
+ * and drop the reference held while queued. Caller must hold the SVM lock.
+ *
+ * Return: 0 on success.
+ */
+int amdgpu_svm_garbage_collector(struct amdgpu_svm *svm)
+{
+	struct amdgpu_svm_range_op_ctx op_ctx;
+
+	amdgpu_svm_assert_locked(svm);
+
+	spin_lock(&svm->work_lock);
+	while (amdgpu_svm_range_dequeue_locked(svm, &svm->gc.list, &op_ctx)) {
+		spin_unlock(&svm->work_lock);
+
+		WARN_ON(!(op_ctx.pending_ops & AMDGPU_SVM_RANGE_OP_UNMAP));
+
+		drm_gpusvm_range_remove(&svm->gpusvm,
+					&op_ctx.range->base);
+
+		amdgpu_svm_range_put_if_dequeued(svm, op_ctx.range);
+		spin_lock(&svm->work_lock);
+	}
+	spin_unlock(&svm->work_lock);
+	return 0;
+}
+
+/**
+ * amdgpu_svm_clean_queue() - Drain a work list, releasing range references
+ * @svm: The SVM context.
+ * @work_list: The work list to drain.
+ *
+ * Dequeue every range on @work_list and drop the reference held while it was
+ * queued, without performing any unmapping. Used during teardown.
+ */
+void amdgpu_svm_clean_queue(struct amdgpu_svm *svm,
+			   struct list_head *work_list)
+{
+	struct amdgpu_svm_range_op_ctx op_ctx;
+
+	spin_lock(&svm->work_lock);
+	while (amdgpu_svm_range_dequeue_locked(svm, work_list,
+						 &op_ctx)) {
+		spin_unlock(&svm->work_lock);
+		amdgpu_svm_range_put_if_dequeued(svm, op_ctx.range);
+		spin_lock(&svm->work_lock);
+	}
+	spin_unlock(&svm->work_lock);
+}
+
+static void amdgpu_svm_gc_work_func(struct work_struct *w)
+{
+	struct amdgpu_svm_gc *gc = container_of(w, struct amdgpu_svm_gc, work);
+	struct amdgpu_svm *svm = container_of(gc, struct amdgpu_svm, gc);
+
+	amdgpu_svm_lock(svm);
+	amdgpu_svm_garbage_collector(svm);
+	amdgpu_svm_unlock(svm);
+}
+
+static int amdgpu_svm_gc_init(struct amdgpu_svm *svm,
+			      void (*gc_work_func)(struct work_struct *))
+{
+	svm->gc.wq = alloc_workqueue(AMDGPU_SVM_GC_WQ_NAME,
+					WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
+	if (!svm->gc.wq)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&svm->gc.list);
+	INIT_WORK(&svm->gc.work, gc_work_func);
+
+	return 0;
+}
+
+static void amdgpu_svm_gc_fini(struct amdgpu_svm *svm)
+{
+	flush_work(&svm->gc.work);
+	amdgpu_svm_clean_queue(svm, &svm->gc.list);
+	destroy_workqueue(svm->gc.wq);
+	svm->gc.wq = NULL;
+}
+
+static void amdgpu_svm_gc_flush(struct amdgpu_svm *svm)
+{
+	flush_work(&svm->gc.work);
+}
+
+static int amdgpu_svm_work_init(struct amdgpu_svm *svm,
+				void (*gc_work_func)(struct work_struct *))
+{
+	int ret;
+
+	init_rwsem(&svm->svm_lock);
+	spin_lock_init(&svm->work_lock);
+
+	ret = amdgpu_svm_gc_init(svm, gc_work_func);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void amdgpu_svm_work_fini(struct amdgpu_svm *svm)
+{
+	amdgpu_svm_gc_fini(svm);
+}
+
+void amdgpu_svm_sync_work(struct amdgpu_svm *svm)
+{
+	amdgpu_svm_gc_flush(svm);
+}
+
+/**
+ * amdgpu_gem_svm_ioctl() - SVM GEM ioctl entry point
+ * @dev: The DRM device.
+ * @data: The ioctl argument (struct drm_amdgpu_gem_svm).
+ * @filp: The DRM file.
+ *
+ * Validate the arguments and dispatch to the SET_ATTR / GET_ATTR /
+ * RESET_ATTR operation, copying results back to user space for GET.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
+			 struct drm_file *filp)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct drm_amdgpu_gem_svm *args = data;
+	struct drm_amdgpu_svm_attribute *attrs = NULL;
+	struct amdgpu_vm *vm;
+	size_t attrs_size = 0;
+	int ret = 0;
+
+	AMDGPU_SVM_DBG("ioctl op=%u va:[0x%llx-0x%llx)-0x%llx nattr=%u\n",
+			 args->operation, args->start_addr, args->start_addr + args->size,
+			 args->size, args->nattr);
+
+	vm = &fpriv->vm;
+	if (!amdgpu_svm_is_enabled(vm)) {
+		ret = amdgpu_svm_init(adev, vm);
+		if (ret)
+			return ret;
+	}
+
+	if ((args->start_addr & ~PAGE_MASK) || (args->size & ~PAGE_MASK))
+		return -EINVAL;
+
+	if (!args->start_addr || !args->size)
+		return -EINVAL;
+
+	if (args->operation != AMDGPU_SVM_OP_RESET_ATTR) {
+		ret = amdgpu_svm_copy_attrs(args, &attrs, &attrs_size);
+		if (ret)
+			return ret;
+	}
+
+	switch (args->operation) {
+	case AMDGPU_SVM_OP_SET_ATTR:
+		ret = amdgpu_svm_op_set_attr(vm, args->start_addr, args->size,
+					 args->nattr, attrs);
+		break;
+	case AMDGPU_SVM_OP_GET_ATTR:
+		ret = amdgpu_svm_op_get_attr(vm, args->start_addr, args->size,
+					 args->nattr, attrs);
+		if (!ret && copy_to_user(u64_to_user_ptr(args->attrs_ptr),
+					 attrs, attrs_size))
+			ret = -EFAULT;
+		break;
+	case AMDGPU_SVM_OP_RESET_ATTR:
+		ret = amdgpu_svm_op_reset_attr(vm, args->start_addr, args->size);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	kvfree(attrs);
+	return ret;
+}
+
 #endif /* CONFIG_DRM_AMDGPU_SVM */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
new file mode 100644
index 0000000000000..f28b3eb14500d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include "amdgpu_svm.h"
+#include "amdgpu_svm_attr.h"
+#include "amdgpu_svm_fault.h"
+#include "amdgpu_svm_range.h"
+#include "amdgpu.h"
+#include "amdgpu_vm.h"
+#include "amdgpu_gmc.h"
+#include "amdgpu_ih.h"
+#include "amdgpu_trace.h"
+
+#include <drm/drm_exec.h>
+#include <drm/drm_gpusvm.h>
+
+#include <linux/delay.h>
+#include <linux/mm.h>
+#include <linux/sched/mm.h>
+
+#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
+
+#define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING	(2UL * NSEC_PER_MSEC)
+
+/**
+ * fault_get_unregistered_attrs() - Create a default attr range for a fault
+ * @svm: The SVM context.
+ * @fault_addr: The faulting address.
+ * @attr_start_page: Lower bound (first page) of the surrounding attribute gap.
+ * @attr_last_page: Upper bound (last page) of the surrounding attribute gap.
+ * @out: Output, the newly created attribute range.
+ *
+ * For a fault that lands in an address gap not covered by any explicit
+ * attribute range, create a default attribute range. Its bounds are the
+ * faulting page's granularity aligned window, clamped to the CPU VMA and to
+ * the surrounding attribute gap [@attr_start_page, @attr_last_page].
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int fault_get_unregistered_attrs(struct amdgpu_svm *svm,
+					    unsigned long fault_addr,
+					    unsigned long attr_start_page,
+					    unsigned long attr_last_page,
+					    struct amdgpu_svm_attr_range **out)
+{
+	struct amdgpu_svm_attr_tree *attr_tree = svm->attr_tree;
+	struct amdgpu_svm_attr_range *range;
+	struct amdgpu_svm_attrs attrs;
+	struct mm_struct *mm = svm->gpusvm.mm;
+	struct vm_area_struct *vma;
+	unsigned long fault_page = fault_addr >> PAGE_SHIFT;
+	unsigned long start_page, last_page;
+	unsigned long vma_start_page, vma_last_page;
+
+	amdgpu_svm_attr_set_default(svm, &attrs);
+
+	mmap_read_lock(mm);
+
+	vma = amdgpu_svm_check_vma(mm, fault_addr);
+	if (IS_ERR(vma)) {
+		mmap_read_unlock(mm);
+		AMDGPU_SVM_ERR("get_unregistered_attrs: invalid VMA for fault_addr=0x%lx\n",
+		       fault_addr);
+		return PTR_ERR(vma);
+	}
+	vma_start_page = vma->vm_start >> PAGE_SHIFT;
+	vma_last_page = (vma->vm_end >> PAGE_SHIFT) - 1;
+
+	if (vma_is_initial_heap(vma) || vma_is_initial_stack(vma))
+		attrs.preferred_loc = AMDGPU_SVM_LOCATION_SYSMEM;
+
+	mmap_read_unlock(mm);
+
+	start_page = max_t(unsigned long, vma_start_page,
+			   ALIGN_DOWN(fault_page, 1UL << attrs.granularity));
+	last_page = min_t(unsigned long, vma_last_page,
+			  ALIGN(fault_page + 1, 1UL << attrs.granularity) - 1);
+
+	start_page = max(start_page, attr_start_page);
+	last_page = min(last_page, attr_last_page);
+
+	mutex_lock(&attr_tree->lock);
+	range = amdgpu_svm_attr_range_alloc(start_page, last_page, &attrs);
+	if (!range) {
+		mutex_unlock(&attr_tree->lock);
+		return -ENOMEM;
+	}
+	amdgpu_svm_attr_range_insert_locked(attr_tree, range);
+	mutex_unlock(&attr_tree->lock);
+
+	AMDGPU_SVM_DBG(
+		"Created unregistered range for fault_addr=0x%lx: attr range=[0x%lx-0x%lx] size: 0x%lx attrs={preferred_loc=%d, prefetch_loc=%d, flags=0x%x, granularity=%u, access=%u}\n",
+		fault_addr, amdgpu_svm_attr_start_page(range),
+		amdgpu_svm_attr_last_page(range) + 1,
+		amdgpu_svm_attr_last_page(range) -
+			amdgpu_svm_attr_start_page(range) + 1,
+		range->attrs.preferred_loc, range->attrs.prefetch_loc,
+		range->attrs.flags, range->attrs.granularity,
+		range->attrs.access);
+
+	*out = range;
+	return 0;
+}
+
+/**
+ * fault_check_allowed() - Verify the CPU VMA
+ * @svm: The SVM context.
+ * @fault_addr: The faulting address.
+ * @write_fault: True if the fault was caused by a write.
+ *
+ * Check that the VMA covering @fault_addr grants the requested access
+ *
+ * Return: 0 if allowed, -EPERM if the required permission is missing.
+ */
+static int fault_check_allowed(struct amdgpu_svm *svm,
+				   unsigned long fault_addr, bool write_fault)
+{
+	struct mm_struct *mm = svm->gpusvm.mm;
+	struct vm_area_struct *vma;
+	unsigned long requested = VM_READ;
+	int ret = 0;
+
+	if (write_fault)
+		requested |= VM_WRITE;
+
+	mmap_read_lock(mm);
+	vma = vma_lookup(mm, fault_addr);
+	if (vma && (vma->vm_flags & requested) != requested) {
+		AMDGPU_SVM_ERR("fault addr 0x%lx no %s permission\n",
+			 fault_addr, write_fault ? "write" : "read");
+		ret = -EPERM;
+	}
+	mmap_read_unlock(mm);
+
+	return ret;
+}
+
+/**
+ * fault_map_range() - Map the faulting range into the GPU page tables
+ * @svm: The SVM context.
+ * @fault_addr: The faulting address.
+ * @attr_range: The attribute range covering @fault_addr.
+ * @write_fault: True if the fault was caused by a write.
+ *
+ * Run the fault mapping pipeline under the SVM lock: drain the garbage
+ * collector, check VMA permissions, find or insert the gpusvm range, skip
+ * work that a concurrent fault already handled, collect the pages and do
+ * the GPU mapping. Transient failures (HMM retry, changed CPU mappings)
+ * are retried a bounded number of times.
+ *
+ * Return: 0 on success or a benign drop, negative error code on failure.
+ */
+static int fault_map_range(struct amdgpu_svm *svm,
+			       unsigned long fault_addr,
+			       const struct amdgpu_svm_attr_range *attr_range,
+			       bool write_fault)
+{
+	const struct amdgpu_svm_attrs *attrs = &attr_range->attrs;
+	bool devmem_possible = amdgpu_svm_devmem_possible(svm);
+	bool need_vram_migration = devmem_possible &&
+				   amdgpu_svm_attr_prefer_vram(attrs);
+	struct drm_gpusvm_ctx map_ctx = {
+		.read_only = !!(attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_RO),
+		.devmem_possible = devmem_possible,
+		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
+		.devmem_only = need_vram_migration,
+		.timeslice_ms = need_vram_migration ? 5 : 0,
+	};
+	struct amdgpu_svm_range *range;
+	ktime_t timestamp = ktime_get_boottime();
+	int retry_count = 3;
+	int ret;
+
+	amdgpu_svm_assert_locked(svm);
+	WARN_ON(!svm->xnack_enabled);
+
+retry:
+	ret = amdgpu_svm_garbage_collector(svm);
+	if (ret) {
+		AMDGPU_SVM_ERR(
+			"fault garbage collector failed: ret=%d, fault_addr=0x%lx\n",
+			ret, fault_addr);
+		return ret;
+	}
+
+	ret = fault_check_allowed(svm, fault_addr, write_fault);
+	if (ret)
+		return ret;
+
+	range = amdgpu_svm_range_find_or_insert(
+		svm, fault_addr,
+		amdgpu_svm_attr_start(attr_range),
+		amdgpu_svm_attr_end(attr_range),
+		&map_ctx);
+	if (IS_ERR(range)) {
+		ret = PTR_ERR(range);
+		/*
+		 * -EINVAL: fault_addr out of gpusvm range, or no chunk size
+		 *          fits within VMA/notifier/attr_range bounds.
+		 * -EFAULT: mmget_not_zero failed (mm is dying).
+		 * -ENOENT: No VMA at fault_addr.
+		 */
+		if (ret == -EFAULT || ret == -ENOENT) {
+			AMDGPU_SVM_DBG("no vma or mm dying: 0x%lx ret=%d\n",
+					 fault_addr, ret);
+			ret = 0;
+			goto out;
+		}
+
+		AMDGPU_SVM_ERR("map_fault: range_find_or_insert failed: fault=0x%lx ret=%d\n",
+				 fault_addr, ret);
+		return ret;
+	}
+
+	if (write_fault && map_ctx.read_only) {
+		AMDGPU_SVM_WARN("write fault on read-only range: fault=0x%lx range=[0x%lx-0x%lx)\n",
+				 fault_addr, drm_gpusvm_range_start(&range->base),
+				 drm_gpusvm_range_end(&range->base));
+	}
+
+	if (ktime_before(timestamp, ktime_add_ns(range->validate_timestamp,
+					 AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING))) {
+		AMDGPU_SVM_DBG("already restored, skip: fault=0x%lx range=[0x%lx-0x%lx)\n",
+				 fault_addr, drm_gpusvm_range_start(&range->base),
+				 drm_gpusvm_range_end(&range->base));
+		goto out;
+	}
+
+	if (amdgpu_svm_range_is_valid(range, attrs)) {
+		AMDGPU_SVM_DBG("valid range, skip: fault=0x%lx range=[0x%lx-0x%lx)\n",
+				 fault_addr, drm_gpusvm_range_start(&range->base),
+				 drm_gpusvm_range_end(&range->base));
+		goto out;
+	}
+
+	AMDGPU_SVM_RANGE_TRACE(range, "PAGE FAULT");
+	/* TODO: add migration*/
+
+	AMDGPU_SVM_RANGE_TRACE(range, "GET PAGES");
+	ret = amdgpu_svm_range_get_pages(svm, &range->base, &map_ctx);
+	if (ret == -EOPNOTSUPP || ret == -EFAULT || ret == -EBUSY) {
+		/*
+		 * -EOPNOTSUPP  Mixed page types within range.
+		 * -EFAULT      mm is dying，range was unmapped，DMA mapping failed，
+		 *              devmem_only requested but system page encountered，
+		 *              no VMA, page fault error, bad pte/pmd.
+		 * -EBUSY       HMM retry loop timed out.
+		 * -ENOMEM      PFN or DMA address array allocation failed.
+		 * -EINVAL      hmm_range_fault: invalid VMA type.
+		 */
+		map_ctx.timeslice_ms <<= 1;
+		if (!map_ctx.devmem_only && --retry_count > 0) {
+			AMDGPU_SVM_DBG(
+				"retry: get_pages failed %d, left=%d: fault=0x%lx range=[0x%lx-0x%lx)\n",
+				ret, retry_count, fault_addr,
+				drm_gpusvm_range_start(&range->base),
+				drm_gpusvm_range_end(&range->base));
+			goto retry;
+		}
+		AMDGPU_SVM_ERR(
+			"map_fault: get_pages retry exhausted, ret=%d: fault=0x%lx range=[0x%lx-0x%lx)\n",
+			ret, fault_addr,
+			drm_gpusvm_range_start(&range->base),
+			drm_gpusvm_range_end(&range->base));
+	}
+
+	if (ret == -EPERM) {
+		/* According to AMD UMD contract, treat -EPERM as a error fault */
+		AMDGPU_SVM_ERR("get_pages -EPERM: fault=0x%lx range=[0x%lx-0x%lx)\n",
+			       fault_addr, drm_gpusvm_range_start(&range->base),
+				       drm_gpusvm_range_end(&range->base));
+		return ret;
+	}
+
+	if (ret == -ENOMEM) {
+		AMDGPU_SVM_ERR("get_pages -ENOMEM: fault=0x%lx range=[0x%lx-0x%lx)\n",
+			       fault_addr, drm_gpusvm_range_start(&range->base),
+			       drm_gpusvm_range_end(&range->base));
+		return ret;
+	}
+
+	if (ret) {
+		AMDGPU_SVM_RANGE_TRACE(range, "PAGE FAULT - FAIL PAGE COLLECT");
+		goto out;
+	}
+
+	AMDGPU_SVM_RANGE_TRACE(range, "PAGE FAULT - GPU MAP");
+
+	ret = amdgpu_svm_range_update_mapping(svm, range, attrs,
+					      map_ctx.read_only,
+					      false, false, false);
+
+	if (ret)
+		goto err_out;
+
+out:
+	return 0;
+
+err_out:
+	if (ret == -EAGAIN && --retry_count > 0) {
+		map_ctx.timeslice_ms <<= 1;
+		AMDGPU_SVM_RANGE_TRACE(range, "PAGE FAULT - RETRY GPU MAP");
+		goto retry;
+	}
+
+	return ret;
+}
+
+/**
+ * amdgpu_svm_handle_fault() - Top-level SVM retry fault handler
+ * @adev: The amdgpu device.
+ * @pasid: PASID of the faulting context.
+ * @fault_page: Faulting page index.
+ * @ts: IH ring timestamp of the fault.
+ * @write_fault: True if the fault was caused by a write.
+ *
+ * Entry point from the VM fault path. Look up the SVM context, drop the
+ * fault if the context is gone/exiting or the mm is dying, filter stale
+ * retry faults using the checkpoint timestamp, then resolve the covering
+ * attribute range (creating a default one if needed) and map it.
+ *
+ * Return: 0 on success or a dropped fault, negative error code on failure.
+ */
+int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
+			    uint64_t fault_page, uint64_t ts,
+			    bool write_fault)
+{
+	struct amdgpu_svm *svm;
+	struct amdgpu_svm_attr_range *attr_range;
+	unsigned long attr_start_page, attr_last_page;
+	uint64_t fault_addr = fault_page << PAGE_SHIFT;
+	struct mm_struct *mm = NULL;
+	uint64_t ckpt;
+	int ret;
+
+	if (amdgpu_in_reset(adev))
+		return 0;
+
+	svm = amdgpu_svm_lookup_by_pasid(adev, pasid);
+	if (!svm) {
+		AMDGPU_SVM_DBG("no SVM context for pasid %u, drop fault 0x%llx\n",
+				 pasid, fault_page << PAGE_SHIFT);
+		return 0;
+	}
+
+	if (atomic_read(&svm->exiting)) {
+		AMDGPU_SVM_DBG("SVM context is exiting for pasid %u, drop fault 0x%llx\n",
+				 pasid, fault_page << PAGE_SHIFT);
+		ret = 0;
+		goto out_put;
+	}
+
+	mm = svm->gpusvm.mm;
+	if (!mm || !mmget_not_zero(mm)) {
+		AMDGPU_SVM_DBG("mm dying for pasid %u, drop fault 0x%llx\n",
+				 pasid, fault_page << PAGE_SHIFT);
+		mm = NULL;
+		ret = 0;
+		goto out_put;
+	}
+
+	if (!svm->xnack_enabled) {
+		AMDGPU_SVM_ERR("xnack not enabled for pasid %u\n",
+			       pasid);
+		ret = -EOPNOTSUPP;
+		goto out_put;
+	}
+
+	ckpt = READ_ONCE(svm->checkpoint_ts);
+	if (ckpt != 0) {
+		if (amdgpu_ih_ts_after_or_equal(ts, ckpt)) {
+			AMDGPU_SVM_DBG(
+				"draining stale retry fault, drop fault 0x%llx ts=%llu checkpoint=%llu\n",
+				fault_addr, ts, ckpt);
+			amdgpu_gmc_filter_faults_remove(
+				adev, fault_page, pasid);
+			ret = 0;
+			goto out_put;
+		} else {
+			WRITE_ONCE(svm->checkpoint_ts, 0);
+		}
+	}
+
+	amdgpu_svm_lock(svm);
+
+	mutex_lock(&svm->attr_tree->lock);
+	attr_range = amdgpu_svm_attr_get_bounds_locked(svm->attr_tree,
+						       fault_page,
+						       &attr_start_page, &attr_last_page);
+	mutex_unlock(&svm->attr_tree->lock);
+	if (!attr_range) {
+		ret = fault_get_unregistered_attrs(svm, fault_addr,
+							      attr_start_page,
+							      attr_last_page,
+							      &attr_range);
+		if (ret) {
+			if (ret == -EFAULT)
+				goto out_no_vma;
+			goto out_unlock;
+		}
+	}
+	ret = fault_map_range(svm, fault_addr, attr_range,
+					 write_fault);
+
+	if (ret == -EAGAIN) {
+		AMDGPU_SVM_DBG("retry fault=0x%llx\n",
+				 fault_addr);
+		amdgpu_gmc_filter_faults_remove(adev, fault_page, pasid);
+		ret = 0;
+	}
+
+	goto out_unlock;
+
+out_no_vma:
+	AMDGPU_SVM_ERR("no VMA for fault=0x%llx (stale retry or GPU NULL deref)\n",
+		 fault_addr);
+	ret = 0;
+
+out_unlock:
+	amdgpu_svm_unlock(svm);
+
+out_put:
+	if (mm)
+		mmput_async(mm);
+	amdgpu_svm_put(svm);
+	return ret;
+}
+
+#endif /* CONFIG_DRM_AMDGPU_SVM */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
new file mode 100644
index 0000000000000..c169a96600de4
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __AMDGPU_SVM_FAULT_H__
+#define __AMDGPU_SVM_FAULT_H__
+
+#include <linux/types.h>
+
+struct amdgpu_device;
+struct amdgpu_svm;
+struct amdgpu_svm_attr_range;
+struct amdgpu_svm_attrs;
+
+int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
+			    uint64_t fault_page, uint64_t ts,
+			    bool write_fault);
+
+#endif /* __AMDGPU_SVM_FAULT_H__ */
-- 
2.53.0

