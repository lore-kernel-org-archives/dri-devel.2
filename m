Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F567CD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C124D10EB60;
	Tue, 19 May 2026 08:32:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VKmoXEgc";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C49B10EB5E;
 Tue, 19 May 2026 08:32:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9T5pTOGdzu27fIkzuZleyWwTq5GxX6E9aib2+pZygGGCvpco0n86mrf9JcBlB3zIVXQLu5JDeShtCbMnCkNFmANy0MhYLJT6g3FyGPe2lOL4UfyUhPRyxx9X/ASMzQQmsxyW00DplJYiUqn3cCRtVbnDz4Dzn5tpsP26tizMlDaqWLMmgjMr2SbmUxHTfyPsd8wUmRoO8/FXiClNssxgz2M5PKrwb6ONczFEpDErKoFg8QjRdgfLD4ys++h43qCtlqLWXqDA5hNdLckdo7e8fCiVGOlimHYnmQnybs0oLEFUm5aFvm5GSvtxhS5FA/Gnvl1HyOZTO4uHqU2JR7SJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owZVPB/syWEx+c5wnIP8ptLMFM5pWb+52oAopdrSX08=;
 b=XmjV4F1zYyFUGyvWx+iwfEw3dD/fghBxVDvzwFsFIrgfgG8RtQihOPJNcGhCSCjpgU427OqsTTSSNNZKeYfMVinKTTJc0sM8YRWIrxL3GOAY7759mfyWh1K86pQTiGQMM173mPz6c1oj5ckQ+jCZWZh3Vzm3cS6TbJ7g8n47CKgHYZKhoCuCdhfhle5szwqb37wtetlrkp5HHaozEjxCXihJZuDIUXBO6Waq56ASOBIY6WDRVH589om6FVnLvplWmZs/UkYIWKfM6FhvCevpgqlk9qq2siTge/iHPGOw5DURDJbN3KjRLfT4QaXvqXldYmiRU9pYTRIp//cJeozGbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owZVPB/syWEx+c5wnIP8ptLMFM5pWb+52oAopdrSX08=;
 b=VKmoXEgccyomMtGkmozruO/FXQoB3ljL1Pggo1xPWrN0o55MVNVX+DESFjj7lcgpXajOSlI2XMV81FK75ntwYQn41YEc7eCEkxTmYxIAlyuZSPrVJ28PaT2qhgzHkRCErXjbSgGvvu/+nmIU4cJpiHfiG9vtyZuMxbgRJ7R06dE=
Received: from DSZP220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::17) by
 CY1PR12MB9558.namprd12.prod.outlook.com (2603:10b6:930:fe::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Tue, 19 May 2026 08:32:34 +0000
Received: from DS2PEPF000061C7.namprd02.prod.outlook.com
 (2603:10b6:5:280:cafe::8c) by DSZP220CA0011.outlook.office365.com
 (2603:10b6:5:280::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 08:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C7.mail.protection.outlook.com (10.167.23.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 08:32:34 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 03:32:29 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V6 11/12] drm/amdgpu: add SVM ioctl entry and fault handler
 module
Date: Tue, 19 May 2026 16:30:56 +0800
Message-ID: <20260519083057.3108087-12-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519083057.3108087-1-honglei1.huang@amd.com>
References: <20260519083057.3108087-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C7:EE_|CY1PR12MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: b6fe3fed-d79b-4ce5-8417-08deb5812d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003|3023799003|22082099003|11063799005|921020;
X-Microsoft-Antispam-Message-Info: xEkoDlmsXxWE/FLncs47XYpXGCkH/j2swTIBfwEye/rh+O0e/aWDn+aHwuY4/DBIYLkuwYwND8JcBauE4Yu7IaPuHcn7HNJozUdc5nRE2kPEOuVEnnGUNry0lK5nDE4S+t89+1duuXM8G1pl2z8VpRbXphMQta56mdGbZvPTEcru0t1LIzrwJtR71hBDF4RD97K48nGg5ceyoohb5WAw9xGccYYEcw2dnMfo69xmVF2CsVt6O6K0TnuzoT1yhk8KZ1cThCz7Crt0W+Vm1s9lcTPLV5Irrhn8c1R5a7LeWT/LZwHNM9JQuWpVQ2E/3mqyVW31Ms/Qh5UA1pX0AeZk5ltENjdAUrYkw2J0gtzggHMt5F7O6WkGP9x48usRyv29s8AwQas4JIM5NmsF+G0pXtrMNPudH7GFX8So179vGUggjFbare1N/3kIBYIrNQ9v9OlVESQkdDbDs/yAMoyin6VLnImLI8U0FSsL8EIHVNRqXs6L7q56kE9XAmioM+uVTzxTQWcPKRN6FzIzqjbuTVseweebQJn5OzLDGiPlJC9qebgrG0/cBmz+kkW3ewW+z9sB1RTLK4UkseRImOtWw7b/HAxv5yt979GXO0LlVr3iJgOJCWKLg5zHphPg99J6vb34VXma63BeuUyozd1/N8u9UP7f2TrSxsgtPjihNOKayqv/Cg9l+WYrfuQRjF0T1Ko7e0gxoU1Q9/NGx/rD8njmrq1jHoowNcnsIJAQ/++PYovDpnSeY0r71WubAgWQw/iy79cDDIA5R4iSDveTVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003)(3023799003)(22082099003)(11063799005)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s6QDV9jh0X+jSu90IVQ+chHGo3aEuTOW6nuf51zPiKtDhhrepGdIWXw1RK48YP3z7VVlp1phGF+US+2qVdDpEVUUppuY4ok0jt0APBWQS3i5YfB4POntAXxENJQy9dC+5BVYmEVGZbyprKFmxyDwBEcOMy6csQMg8s2je8SqwZXYrO455Xgujce7ChsRn35NooOwCWp/Y4tG937thP9eqUop8HJpdD/F6ZT0KakWPpG1hEyxvbUIA0yK/czi4F1FfkK/ASOzWQclBYYwp4+MOBRYvzAbzX1814eECq8lMZjZKWM8q8ZHh9aKxjxOpbiqlQVHtu300RMzMVzBwLww1sov2JaeCUNCVQtqozKpRvpnvNErX9iOfJraAj8SX3uPk8hIyer5UcLr2qOaznpunNcL+qBSZbU9KTj7I57/2/aV/7gclA6dP3yFL9iohCqf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 08:32:34.3629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fe3fed-d79b-4ce5-8417-08deb5812d09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9558
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
- amdgpu_svm_gc_work_func: GC work handler (static)
- amdgpu_svm_gc_init/fini/flush: workqueue lifecycle (static)
- amdgpu_svm_work_init/work_fini: wrappers for GC lifecycle
- amdgpu_svm_sync_work: wrapper for GC flush
- amdgpu_gem_svm_ioctl: validate args, lazy-init SVM, dispatch
  SET_ATTR/GET_ATTR/RESET_ATTR with copy_to_user for GET

amdgpu_svm_fault.c (new):
- fault_check_allowed: VMA permission check for fault address
- fault_get_unregistered_attrs: create default attr range for
  faulting address not covered by explicit attributes, bounded
  by VMA and granularity alignment
- fault_map_range: fault mapping pipeline with retry (GC,
  permission check, find/insert range, timestamp dedup,
  validity check, get_pages, update_mapping).  is_valid and
  update_mapping consume the attribute set plus the read_only
  flag directly (PTE flags are recomputed per DMA segment inside
  update_gpu_range), so no range_pte_flags is pre-computed here.
  A write fault landing on a read-only range is logged via
  AMDGPU_SVM_WARN to aid debugging.
- amdgpu_svm_handle_fault: top-level entry point from VM fault path
  (PASID lookup, exiting check, xnack gate, checkpoint timestamp
  filtering, attr lookup with bounds, dispatch to fault_map_range),
  uses fault_page parameter for page-granularity fault addressing

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 172 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 382 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h |  39 ++
 3 files changed, 593 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
index 4205d82c4..b3cca1ff5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -527,4 +527,176 @@ bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
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
+		WARN_ON(!UNMAP_WORK(op_ctx.pending_ops));
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
+	AMDGPU_SVM_TRACE("ioctl op=%u va:[0x%llx-0x%llx)-0x%llx nattr=%u\n",
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
index 000000000..e22e0eb58
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
@@ -0,0 +1,382 @@
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
+	unsigned long bo_start = 0, bo_last = 0;
+	int r;
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
+	start_page = max(vma_start_page,
+		    (unsigned long)ALIGN_DOWN(fault_page, 1UL << attrs.granularity));
+	last_page = min(vma_last_page,
+		   (unsigned long)ALIGN(fault_page + 1, 1UL << attrs.granularity) - 1);
+
+	start_page = max(start_page, attr_start_page);
+	last_page = min(last_page, attr_last_page);
+
+	r = amdgpu_svm_attr_check_vm_bo(attr_tree, start_page, last_page,
+					&bo_start, &bo_last);
+	if (r == -EADDRINUSE) {
+		if (fault_page >= bo_start && fault_page <= bo_last)
+			return -EFAULT;
+
+		/* Narrow to single page if expanded range overlaps BO */
+		start_page = fault_page;
+		last_page = fault_page;
+	} else if (r) {
+		return r;
+	}
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
+	AMDGPU_SVM_TRACE(
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
+static int fault_map_range(struct amdgpu_svm *svm,
+			       unsigned long fault_addr,
+			       const struct amdgpu_svm_attr_range *attr_range,
+			       bool write_fault)
+{
+	const struct amdgpu_svm_attrs *attrs = &attr_range->attrs;
+	bool devmem_possible = false; /* TODO: add migration */
+	bool need_vram_migration = amdgpu_svm_attr_prefer_vram(svm, attrs);
+	struct drm_gpusvm_ctx map_ctx = {
+		.read_only = !!(attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_RO),
+		.devmem_possible = devmem_possible,
+		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
+		.devmem_only = need_vram_migration && devmem_possible,
+		.timeslice_ms = need_vram_migration && devmem_possible ? 5 : 0,
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
+		AMDGPU_SVM_ERR("map_fault: range_find_or_insert failed: fault=0x%lx ret=%d\n",
+				 fault_addr, ret);
+		/*
+		 * -EINVAL: fault_addr out of gpusvm range, or no chunk size
+		 *          fits within VMA/notifier/attr_range bounds.
+		 * -EFAULT: mmget_not_zero failed.
+		 * -ENOENT: No VMA at fault_addr.
+		 * -ENOMEM: Notifier or range allocation failed.
+		 */
+		if (ret == -EFAULT || ret == -ENOENT) {
+			AMDGPU_SVM_ERR("no vma or mm is dying: 0x%lx, ret=%d\n",
+					 fault_addr, ret);
+			ret = 0;
+		}
+
+		return ret;
+	}
+
+	if(write_fault && map_ctx.read_only){
+		AMDGPU_SVM_WARN("write fault on read-only range: fault=0x%lx range=[0x%lx-0x%lx)\n",
+				 fault_addr, drm_gpusvm_range_start(&range->base),
+				 drm_gpusvm_range_end(&range->base));
+	}
+
+	if (ktime_before(timestamp, ktime_add_ns(range->validate_timestamp,
+					 AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING))) {
+		AMDGPU_SVM_TRACE("already restored, skip: fault=0x%lx range=[0x%lx-0x%lx)\n",
+				 fault_addr, drm_gpusvm_range_start(&range->base),
+				 drm_gpusvm_range_end(&range->base));
+		goto out;
+	}
+
+	if (amdgpu_svm_range_is_valid(svm, range, attrs)) {
+		AMDGPU_SVM_TRACE("valid range, skip: fault=0x%lx range=[0x%lx-0x%lx)\n",
+				 fault_addr, drm_gpusvm_range_start(&range->base),
+				 drm_gpusvm_range_end(&range->base));
+		goto out;
+	}
+
+	AMDGPU_SVM_RANGE_DEBUG(range, "PAGE FAULT");
+	/* TODO: add migration*/
+
+	AMDGPU_SVM_RANGE_DEBUG(range, "GET PAGES");
+	ret = amdgpu_svm_range_get_pages(svm, &range->base, &map_ctx);
+	if (ret == -EOPNOTSUPP || ret == -EFAULT) {
+		/*
+		* -EOPNOTSUPP  Mixed page types within range.
+		* -EFAULT      (a) mm is dying.
+		*              (b) range was unmapped.
+		*              (c) DMA mapping failed.
+		*              (d) devmem_only requested but system page encountered.
+		*              (e) hmm_range_fault: no VMA, page fault error, bad pte/pmd.
+		* -EBUSY       HMM retry loop timed out.
+		* -ENOMEM      PFN or DMA address array allocation failed.
+		* -EINVAL      hmm_range_fault: invalid VMA type.
+		*/
+		map_ctx.timeslice_ms <<= 1;
+		if (!map_ctx.devmem_only && --retry_count > 0) {
+			AMDGPU_SVM_ERR("start retry: get_pages failed with %d, retries_left=%d: fault=0x%lx range=[0x%lx-0x%lx)\n",
+					 ret, retry_count, fault_addr,
+					 drm_gpusvm_range_start(&range->base),
+					 drm_gpusvm_range_end(&range->base));
+			goto retry;
+		} else {
+			AMDGPU_SVM_ERR("map_fault: get_pages failed with %d, devmem fallback allowed, but no devmem pages: fault=0x%lx range=[0x%lx-0x%lx)\n",
+					 ret, fault_addr, drm_gpusvm_range_start(&range->base),
+					 drm_gpusvm_range_end(&range->base));
+		}
+	}
+
+	if (ret == -EPERM) {
+		AMDGPU_SVM_ERR("get_pages -EPERM: fault=0x%lx range=[0x%lx-0x%lx)\n",
+			       fault_addr, drm_gpusvm_range_start(&range->base),
+				       drm_gpusvm_range_end(&range->base));
+		return ret;
+	}
+
+	if (ret) {
+		AMDGPU_SVM_RANGE_DEBUG(range, "PAGE FAULT - FAIL PAGE COLLECT");
+		goto out;
+	}
+
+	AMDGPU_SVM_RANGE_DEBUG(range, "PAGE FAULT - GPU MAP");
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
+		AMDGPU_SVM_RANGE_DEBUG(range, "PAGE FAULT - RETRY GPU MAP");
+		goto retry;
+	}
+
+	return ret;
+}
+
+int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
+			    uint64_t fault_page, uint64_t ts,
+			    bool write_fault)
+{
+	struct amdgpu_svm *svm;
+	struct amdgpu_svm_attr_range *attr_range;
+	unsigned long attr_start_page, attr_last_page;
+	uint64_t fault_addr = fault_page << PAGE_SHIFT;
+	uint64_t ckpt;
+	int ret;
+
+	svm = amdgpu_svm_lookup_by_pasid(adev, pasid);
+	if (!svm) {
+		AMDGPU_SVM_ERR("handle_fault: no SVM context for pasid %u\n", pasid);
+		return -EOPNOTSUPP;
+	}
+
+	if (atomic_read(&svm->exiting)) {
+		AMDGPU_SVM_ERR("handle_fault: SVM context is exiting for pasid %u\n", pasid);
+		ret = -EAGAIN;
+		goto out_put;
+	}
+
+	if (!svm->xnack_enabled) {
+		AMDGPU_SVM_ERR("handle_fault: SVM context does not have xnack enabled for pasid %u\n", pasid);
+		ret = -EOPNOTSUPP;
+		goto out_put;
+	}
+
+	ckpt = READ_ONCE(svm->checkpoint_ts);
+	if (ckpt != 0) {
+		if (amdgpu_ih_ts_after_or_equal(ts, ckpt)) {
+			AMDGPU_SVM_TRACE(
+			"handle_fault: draining stale retry fault, drop fault 0x%llx ts=%llu checkpoint=%llu\n",
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
+		AMDGPU_SVM_ERR("handle_fault: got -EAGAIN: fault=0x%llx\n",
+			       fault_addr);
+		amdgpu_gmc_filter_faults_remove(adev, fault_page, pasid);
+		ret = 0;
+	}
+
+	goto out_unlock;
+
+out_no_vma:
+	AMDGPU_SVM_ERR("handle_fault: no VMA for fault=0x%llx (stale retry or GPU NULL deref)\n",
+		 fault_addr);
+	ret = 0;
+
+out_unlock:
+	amdgpu_svm_unlock(svm);
+
+out_put:
+	amdgpu_svm_put(svm);
+	return ret;
+}
+
+#endif /* CONFIG_DRM_AMDGPU_SVM */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
new file mode 100644
index 000000000..c169a9660
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
2.34.1

