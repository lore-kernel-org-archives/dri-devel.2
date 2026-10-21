Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1B0606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kmGI03Eh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 277C710F89D;
	Wed, 21 Oct 2026 03:00:40 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013030.outbound.protection.outlook.com
 [40.107.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B27B910F89C;
 Wed, 21 Oct 2026 03:00:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBLFdFIES0T1Ppk4dM4Lfb+s3FVFTdKW0yGy0DO/sTxeUddVtD2tKVlESZqBzvCpkQt1o5Sjbd9hNBeo0jbALsC5UxyhDY42SxcNIsOo4YTpWNgTz/BVQICSm/r/cchgqi8h4+bhsFq7KK1vmAALDB2KMtLlxa380fGwmujOqyVKu/Rvl6lMQXNE8NJZcObtrksu3fL8qNyJEKmOsXderAyW9nrzSbkEoKAr9EVsu9fqZh2TxUfqr7hdBsqDy6stUpBTz3w6As67IDsp/ZrPVEOyEofFKVCqtkooXzvjLGgdCqPQ7r/6zGipGQEJLPF+p5gPgCV/Gy+ZmjCsNEyKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCe5BC93l/K9mL/xaRI+Bz/0RFBaB6LMi0OONfZl3wA=;
 b=pr6SW5kV+3aufa0We/H6o+khVB19w3AnWZ0kzqrXNQmSwsIV/ERf+VN8aXaxWJBbrsJxSs5trgjp4iS8wzhWhAb6SMks1cfPUntlwj+aD9cZ+eYmgToLWj09Xhe+Y9CjnfoVD18BABmguBaYsppyBrxO1e1gwzd1iEZ89QnBKfWnlP/6XpYskbkA78KrPHJeQDMQT7f0Ozhus48GloQ0Ho3P5s9G5CfCrc04/+uHAaRDZS2sZ14Bpqp1sr6t+0JbRUoOy5PDjGHWUHpO2fkRO6grvDMpcSfZKVC5v2mT206tLjkg/qMlO3NEzGneJLgORLyR1s2zESDJVZzkHPzgwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCe5BC93l/K9mL/xaRI+Bz/0RFBaB6LMi0OONfZl3wA=;
 b=kmGI03EhgHqmqaxJTH/Mf4y1dIf7vNdNrjbXjVFGhx4TF5jG6gcvtqAcT4taCzPeJ/Ge9oZcQ4jTeZXxOu02T7AYQ4XRGoK7NXbHvYw1VNCXGQ6FjkruCkpCUeUM55OCYo+MG/Dh0DcQN7qNpO6fB2dsmGB+ZoBMA/XBfdBRxY8=
Received: from BY3PR03CA0017.namprd03.prod.outlook.com (2603:10b6:a03:39a::22)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 21 Oct
 2026 03:00:25 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::43) by BY3PR03CA0017.outlook.office365.com
 (2603:10b6:a03:39a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 03:00:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 03:00:25 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 22:00:16 -0500
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
Subject: [PATCH v10 11/22] drm/amdgpu: add SVM ioctl entry and fault handler
 module
Date: Wed, 21 Oct 2026 10:58:50 +0800
Message-ID: <20261021025915.2433837-12-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021025915.2433837-1-ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: deb5adf7-f0c3-4f76-2449-08df2f1f7465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|18002099003|3023799007|10067099003|22082099003|921020|261009220027099003|11063799006|261009221727099003|261009221227099003|261009223327099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: SWICHZPhVjluBod5xE2867jxjas9KRoizZIOToAqCKKQnppBV+PhbiHF+GlAwDfbdOMl1lM/IOZU/iCeAjADrNNm7TqAOgOnYS6+fKK9S3X+jd2SjZink/LvKJVB/7c56iX9x3Gjh9790mILXleBZsuQlGG0j6ptuvBSCiN5DMZ5izl1fV+pvzKYGOcKpskI0Hg8qHCo8GypXRFdQ9goYtOvWeR0t9uFiWadsyNPSmz9N04FQ3zdtdSXTTjlkLIqrVXDBkmYpX2J1nDyfEU5Gi5KadzXigPDXh3Fh1evqTgQKqt1/jHWUloLvGC6WSqrertheasmoWt3WEl3oUfDV6HBVUrcuDGTate7K7P9fd3RXJ04QY/AXbMXJMraSvxfVi+15cUVE/Shz1Q9FLv95JnCpOaKEvgpLf+9moF/J/JkyWUkATRObD75KFuSs0VZPeiz9nLYKx3tE+qxPqBaTs+Spm5TIiupQVyIfgNfL5/47FspCRCp7KV0+AamOPsGvQzD1iYD6FhzfI0MPEIjuDElxDc8+hM90ghy3P/UbQFEyBfFz9R5CY7BQw4sZUA5yU2o6bNFcHWH2VoCE8a/uti5DLyvt7Z0nmA5RaZzSAwE5kf89DoTPvICNLeOGAPe8XfCHrBH7fbWI+eArKWVnfLMjX+fs1PQEUdbOfw2VMHAL1e2voSRcojB5ttS0LAzH1pzD1UDIDns3HLzPbT9XttW93f06/S7BzVFOBBzP+L5Pl7XCcJs64+BrcrqgAJa
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(18002099003)(3023799007)(10067099003)(22082099003)(921020)(261009220027099003)(11063799006)(261009221727099003)(261009221227099003)(261009223327099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RVwFZf932446I64YTFEk8kVQe8O1/pnWvTTEIC082aCtCQceS5y4ZmCPufIsUgAX10ZOBSAaSf6yzyhwZmeaqLTwRYZIU8HwYwwwcCK/SSpamYJFwHmAwiJm3Scyef7X04BaO/Grp3GDMgHv/JEik7LxBer+9LL1BZ0CGEuKtrqCklLUDf6Cpd7BpowjrKMsmr6dzlYrUr0UKf8UvljBq5MRLbgw3cb9Z3BReJBMaCeVd+DMOTtJI2DEkQBAyJD38a3NNMb8+9FnRxPzw2gnqskcH741qKkxl1+lFPSpHn9yJoZxP/UZ1Q9Cou9gdbycIPxIu48B68z3gYx9pxHZdF0uXE8eJw7xpQXd0/9bB5lUEcF+7zqlxLn/PvQK+59dpRAGzjZZ/L/1mmcKhYDX8X8jeGDqBDtgahV26KQ6RVPBoIaDH4MUgU4hMXTNZEEN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 03:00:25.2463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deb5adf7-f0c3-4f76-2449-08df2f1f7465
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

The VM fault path treats zero as a successfully serviced or benignly
dropped fault. Return an error for faults which cannot be serviced so the
caller installs AMDGPU_VM_NORETRY_FLAGS and terminates the faulting wave.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 196 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 467 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h |  39 ++
 3 files changed, 702 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
index f5ed917329944..c7810e6d3035f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -638,4 +638,200 @@ bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
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
+	struct drm_amdgpu_gem_svm *args = data;
+	struct drm_amdgpu_svm_attribute *attrs = NULL;
+	struct amdgpu_vm *vm;
+	size_t attrs_size = 0;
+	int ret = 0;
+
+	pr_debug("ioctl op=%u va:[0x%llx-0x%llx)-0x%llx nattr=%u\n",
+			 args->operation, args->start_addr, args->start_addr + args->size,
+			 args->size, args->nattr);
+
+	vm = &fpriv->vm;
+	if (!amdgpu_svm_is_enabled(vm))
+		return -EOPNOTSUPP;
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
+					 args->nattr, attrs, &args->size);
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
index 0000000000000..2dd77fe78303c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
@@ -0,0 +1,467 @@
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
+ * @out_attrs: Output, a snapshot of the attributes for the new range.
+ * @out_start_page: Output, first page of the new range.
+ * @out_last_page: Output, last page of the new range.
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
+					    struct amdgpu_svm_attrs *out_attrs,
+					    unsigned long *out_start_page,
+					    unsigned long *out_last_page)
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
+		pr_debug("get_unregistered_attrs: invalid VMA for fault_addr=0x%lx\n",
+			 fault_addr);
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
+	*out_attrs = range->attrs;
+	*out_start_page = amdgpu_svm_attr_start_page(range);
+	*out_last_page = amdgpu_svm_attr_last_page(range);
+	mutex_unlock(&attr_tree->lock);
+
+	pr_debug(
+		"Created unregistered range for fault_addr=0x%lx: attr range=[0x%lx-0x%lx] size: 0x%lx attrs={preferred_loc=%d, prefetch_loc=%d, flags=0x%x, granularity=%u, access=%u}\n",
+		fault_addr, *out_start_page, *out_last_page + 1,
+		*out_last_page - *out_start_page + 1,
+		out_attrs->preferred_loc, out_attrs->prefetch_loc,
+		out_attrs->flags, out_attrs->granularity,
+		out_attrs->access);
+
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
+		pr_err_ratelimited("fault addr 0x%lx no %s permission\n",
+				   fault_addr, write_fault ? "write" : "read");
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
+ * @attrs: Snapshot of the attributes covering @fault_addr.
+ * @attr_start_page: First page covered by @attrs.
+ * @attr_last_page: Last page covered by @attrs.
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
+			       const struct amdgpu_svm_attrs *attrs,
+			       unsigned long attr_start_page,
+			       unsigned long attr_last_page,
+			       bool write_fault)
+{
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
+		pr_err_ratelimited("fault garbage collector failed: ret=%d, fault_addr=0x%lx\n",
+				   ret, fault_addr);
+		return ret;
+	}
+
+	ret = fault_check_allowed(svm, fault_addr, write_fault);
+	if (ret)
+		return ret;
+
+	range = amdgpu_svm_range_find_or_insert(
+		svm, fault_addr,
+		attr_start_page << PAGE_SHIFT,
+		(attr_last_page + 1) << PAGE_SHIFT,
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
+			pr_debug("no vma or mm dying: 0x%lx ret=%d\n",
+					 fault_addr, ret);
+			ret = 0;
+			goto out;
+		}
+
+		pr_err_ratelimited("map_fault: range_find_or_insert failed: fault=0x%lx ret=%d\n",
+				   fault_addr, ret);
+		return ret;
+	}
+
+	if (write_fault && map_ctx.read_only) {
+		pr_debug("write fault on read-only range: fault=0x%lx range=[0x%lx-0x%lx)\n",
+			 fault_addr, drm_gpusvm_range_start(&range->base),
+			 drm_gpusvm_range_end(&range->base));
+		ret = -EPERM;
+		goto err_out;
+	}
+
+	if (READ_ONCE(range->gpu_mapped) &&
+	    ktime_before(timestamp,
+			 ktime_add_ns(range->validate_timestamp,
+				      AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING))) {
+		pr_debug("already restored, skip: fault=0x%lx range=[0x%lx-0x%lx)\n",
+				 fault_addr, drm_gpusvm_range_start(&range->base),
+				 drm_gpusvm_range_end(&range->base));
+		goto out;
+	}
+
+	if (amdgpu_svm_range_is_valid(range, attrs)) {
+		pr_debug("valid range, skip: fault=0x%lx range=[0x%lx-0x%lx)\n",
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
+			pr_debug(
+				"retry: get_pages failed %d, left=%d: fault=0x%lx range=[0x%lx-0x%lx)\n",
+				ret, retry_count, fault_addr,
+				drm_gpusvm_range_start(&range->base),
+				drm_gpusvm_range_end(&range->base));
+			goto retry;
+		}
+		pr_err_ratelimited("map_fault: get_pages retry exhausted, ret=%d: fault=0x%lx range=[0x%lx-0x%lx)\n",
+				   ret, fault_addr,
+				   drm_gpusvm_range_start(&range->base),
+				   drm_gpusvm_range_end(&range->base));
+	}
+
+	if (ret == -EPERM) {
+		/* According to AMD UMD contract, treat -EPERM as a error fault */
+		pr_err_ratelimited("get_pages -EPERM: fault=0x%lx range=[0x%lx-0x%lx)\n",
+				   fault_addr, drm_gpusvm_range_start(&range->base),
+				   drm_gpusvm_range_end(&range->base));
+		return ret;
+	}
+
+	if (ret == -ENOMEM) {
+		pr_err_ratelimited("get_pages -ENOMEM: fault=0x%lx range=[0x%lx-0x%lx)\n",
+				   fault_addr, drm_gpusvm_range_start(&range->base),
+				   drm_gpusvm_range_end(&range->base));
+		return ret;
+	}
+
+	if (ret) {
+		AMDGPU_SVM_RANGE_TRACE(range, "PAGE FAULT - FAIL PAGE COLLECT");
+		goto err_out;
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
+	struct amdgpu_svm_attrs attrs;
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
+		pr_debug("no SVM context for pasid %u, drop fault 0x%llx\n",
+				 pasid, fault_page << PAGE_SHIFT);
+		return 0;
+	}
+
+	if (atomic_read(&svm->exiting)) {
+		pr_debug("SVM context is exiting for pasid %u, drop fault 0x%llx\n",
+				 pasid, fault_page << PAGE_SHIFT);
+		ret = 0;
+		goto out_put;
+	}
+
+	mm = svm->gpusvm.mm;
+	if (!mm || !mmget_not_zero(mm)) {
+		pr_debug("mm dying for pasid %u, drop fault 0x%llx\n",
+				 pasid, fault_page << PAGE_SHIFT);
+		mm = NULL;
+		ret = 0;
+		goto out_put;
+	}
+
+	if (!svm->xnack_enabled) {
+		pr_err_ratelimited("xnack not enabled for pasid %u\n",
+				   pasid);
+		ret = -EOPNOTSUPP;
+		goto out_put;
+	}
+
+	ckpt = READ_ONCE(svm->checkpoint_ts);
+	if (ckpt != 0) {
+		if (amdgpu_ih_ts_after_or_equal(ts, ckpt)) {
+			pr_debug(
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
+	if (attr_range) {
+		attrs = attr_range->attrs;
+		attr_start_page = amdgpu_svm_attr_start_page(attr_range);
+		attr_last_page = amdgpu_svm_attr_last_page(attr_range);
+	}
+	mutex_unlock(&svm->attr_tree->lock);
+	if (!attr_range) {
+		ret = fault_get_unregistered_attrs(svm, fault_addr,
+							      attr_start_page,
+							      attr_last_page,
+							      &attrs,
+							      &attr_start_page,
+							      &attr_last_page);
+		if (ret) {
+			if (ret == -EFAULT)
+				goto out_no_vma;
+			goto out_unlock;
+		}
+	}
+	ret = fault_map_range(svm, fault_addr, &attrs, attr_start_page,
+			      attr_last_page, write_fault);
+
+	if (ret == -EAGAIN) {
+		pr_debug("retry fault=0x%llx\n",
+				 fault_addr);
+		amdgpu_gmc_filter_faults_remove(adev, fault_page, pasid);
+		ret = 0;
+	}
+
+	goto out_unlock;
+
+out_no_vma:
+	pr_debug("no VMA for fault=0x%llx (stale retry or GPU NULL deref)\n",
+		 fault_addr);
+	ret = -EFAULT;
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

