Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35C5F588C3
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D9D910E5E2;
	Mon, 20 Apr 2026 13:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wiFlOkQ/";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6444C10E5E2;
 Mon, 20 Apr 2026 13:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZ4oBoHT48fuyhICgclLVOXGDANu3vH+2gSitxne2uoaRu11cYg6OyYAT9DpAqywovu0vPbXoam18DAGWSLB/7PGFYQcuMrRoLy1hSBcKYkr+0eQOgOnT+12paRO4MssXxa3NSzdMASR2caZE0wvEyeCpJD/8pRbkTaL/YOZxPdgoKIVnrAzsVpT4XF8g9wfrJpUS56X3JnOMnQPIOGZRcp8rrWzYQiJQm5Cw6bypxatX8l+wGP0JAXLBOkMjSIHyO0tZ5RO0GueH3Iyc9L9d+K7TpfKat9UHwY2GAqyTb29PrVkQkU1HVsp8XH2Vu0pjcvQZ9QVOHMFjWTxharZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsMdIUXMvG9qF+XRHjHnj0hDv9uyZXaTGIXa1ZV+ipY=;
 b=v8GXXdR1ELc4sJpHOYtAtZBzXHAlfg8IK3rdB2J8mv/A+bujcSW1J23hmIF8qPlmu73fxTK4QbFtPbItYEDrMZ3ETjTmX3ocIhYVt9+KgN3t4BBTCxhMB334eqY52h9X0d6pSROAj3btCAXQXR9gaQUU9A4AoUvD/gjWSU+/T/UfkmEp1yWqCquVzYE/H7Ld2XNTFXuPiCOFHdV6nKoJCzmyRaTka2wL/Qjx93y8LbHzWcKZqUbKL1UjX52WdVHfkzRDga2FzAOyD6SZGRnmr4G00iXRCqnpSnxvH+SvDkRjNns+0GEjGqKbo7gmFG0Oe1JhBH1HJJZU80vj7wYNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsMdIUXMvG9qF+XRHjHnj0hDv9uyZXaTGIXa1ZV+ipY=;
 b=wiFlOkQ/9AKzTgpT5wWDdtsmYx7TPsF+8bNKDGCx9FJr/nthAtPDkdDtSL7HgUxXGEKc92vNQ5m+k65xJ7YknYXUF99QltmT9tQuwkl4q7vcWRHGIC0zQ7ECFly0NC+IwTI3zBVH1D4fSHdvyWut/jE4pm10uCHLN4xzL2inokE=
Received: from CH0PR04CA0046.namprd04.prod.outlook.com (2603:10b6:610:77::21)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 13:14:24 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::4b) by CH0PR04CA0046.outlook.office365.com
 (2603:10b6:610:77::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 13:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 13:14:24 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 08:14:19 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>, Honghuan He <honghuan.he@amd.com>
Subject: [RFC V3 11/12] drm/amdgpu: add SVM ioctl, garbage collector,
 and fault handler
Date: Mon, 20 Apr 2026 21:13:06 +0800
Message-ID: <20260420131307.1816671-12-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420131307.1816671-1-honglei1.huang@amd.com>
References: <20260420131307.1816671-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|MN2PR12MB4158:EE_
X-MS-Office365-Filtering-Correlation-Id: 7216c16f-646d-4c4d-71e7-08de9edebe33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|921020|18096099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 3Lf87TyUp8lwtBKAhlrZqHkFv06TEo1B2YCQqBnVFLV4jL581WRH6fXvVX74rsruTaH/6+nrRSglIxqI2iUWN+urt9FxFLNIXDuUzLDnSqLF3Qn9iKyZVI97iJYmmIQS6NRE/hM5QXKsvv0kIkfUz3fBabH3Fs6g5UD5bjVs7YPpz5OZfjpfEfE/z9t80TdvREej4cHq1zFyefm8QIVDoaX8IIOQdGMacZFvBVZZRoQRiiHWqlOSbnWd5aM7zaHkVaQQNgqVXZGWmm2uiAgRRfpAUt4IvencceRIdavkPOaNp+FCY5ZRX94LSui50VeM5S6YZ8EsAXcDz8lGJiwTWndTGEjFRrPhkDZt6EIHGCCL6Sy915ntuZvXoMexwHDN+slZttEPRi1Jfr8Uf1ad2yQ/Ke1DfrAJ638Ifx21vHvHh/mjcbNuEinwEBjfeuomHDnBUKdnMjBdWtpc+26rKjzduwf6fqpr5K/CAlTuUoN10i08G3mGh9UCl1E/IeUFQFWFd8EvfNufJOVikOILXBbFpIUrhE/ms8wMQ105VX0A4C4u3gESxSaXDVbYCC84gjrgAFQS7fyrRIOMP225Khkl2ux2hs+j3W8NJg9/rYv10ZBRlOBT1WqqOb32QUwhue/sOz2bRsgrvC2XmAdGUWs4rUvE+W5/uLOTU8AFJvPdNeM4Wamsa5Uo+pSaTp8uqFTyT3ToydQjKaclrO5ORzhAsySyI8LtICIXAE5f8Xt3b5vsc0w0h7dfO4A938GiNlIKQnPNcQXDMdxwMnP4cb2r3m/CaLEKoc27gZTcOiN94gKnKAckdp+ZFBvhG5vc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(921020)(18096099003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sNP4DSraIGlkKPmBANl1lmVUHdDqDKJDxa2kgFjEQrlWG2EdRLes6FG9R8WXK3b38GlVun7y4OxTRjdr4H4/x8Cs/z9k7k88AXqdZ/ZVPzZyLTx4p5XSDk6TQpEWZKq049PHK6YmdY/E/N4T1nNTkwWweKu+Sjgg+c9ckdKejUQbqg7PnpSskIaIdNpNMx8W79jC9PTtCtiWW43PobnKyd2QPgn+daD4NEYnu/FILhSrj3kOizsiz38qi8J90kCqPYq2zfTTk5NRKyHKapcuifxRcCkdC6puGt2V1nb0MxOlWjt+ktW/l64BMNutOfKzz2NOaGYwiklbYcWc+QBYdpQ/9RxWdeG3cKru52LzNhJemkecz0ab3sSu8DrnYsApN0AuodG43I+FdPx0B6Z9UzcAlDFcPoQg/LZkq4zdM4Ji641OGNJ39+GtJA1+LQRt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:14:24.3619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7216c16f-646d-4c4d-71e7-08de9edebe33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
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

Add the ioctl entry point and garbage collector to amdgpu_svm.c,
and introduce amdgpu_svm_fault.c and amdgpu_svm_fault.h as a
dedicated fault handler module.

Ioctl (amdgpu_svm.c):
- amdgpu_svm_copy_attrs(): copy and validate user attribute array
  from userspace with size and alignment checks
- amdgpu_gem_svm_ioctl(): handle DRM_AMDGPU_GEM_SVM dispatching
  to SET_ATTR or GET_ATTR with copy_to_user for GET results

Garbage collector (amdgpu_svm.c):
- amdgpu_svm_garbage_collector(): dequeue and remove GC-listed
  ranges under svm_lock, clear corresponding attributes
- amdgpu_svm_range_clean_queue(): batch cleanup for dequeued
  work items
- amdgpu_svm_garbage_collector_work_func(): GC work handler
- amdgpu_svm_gc_init/fini/flush(): lifecycle management for
  the GC workqueue

Fault handler (amdgpu_svm_fault.c):
- AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING: 2ms dedup threshold
- amdgpu_svm_range_get_unregistered_attrs(): derive default
  attributes for faulting addresses without explicit registration,
  using VMA properties and GPU IP capabilities
- svm_check_fault_allowed(): validate fault access against
  attribute permissions and read-only enforcement
- amdgpu_svm_range_map_fault(): core fault mapping that finds or
  creates a gpusvm range, gets pages, maps into GPU page tables,
  retries on -EAGAIN up to 3 times
- amdgpu_svm_handle_fault(): main entry called from
  amdgpu_vm_handle_fault(). Looks up SVM by PASID, acquires
  mmap_read_lock and svm_lock, runs garbage collector, resolves
  attributes from the tree or derives defaults, uses timestamp
  deduplication to skip stale faults, dispatches to map_fault

Fault header (amdgpu_svm_fault.h):
- Forward declarations and amdgpu_svm_handle_fault() prototype

Signed-off-by: Honghuan He <honghuan.he@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 149 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 368 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h |  39 ++
 3 files changed, 556 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
index 5fbed9b9f..a672deede 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -316,3 +316,152 @@ bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
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
+	int ret;
+	struct amdgpu_svm_range_op_ctx op_ctx;
+
+	lockdep_assert_held_write(&svm->svm_lock);
+
+	spin_lock(&svm->work_lock);
+	while (amdgpu_svm_range_dequeue_locked(svm, &svm->gc.list, &op_ctx)) {
+		spin_unlock(&svm->work_lock);
+
+		if (UNMAP_WORK(op_ctx.pending_ops)) {
+			ret = amdgpu_svm_attr_clear_pages(
+				svm->attr_tree, op_ctx.start_page, op_ctx.last_page);
+			if (ret)
+				return ret;
+
+			drm_gpusvm_range_remove(&svm->gpusvm,
+						&op_ctx.range->base);
+		}
+
+		amdgpu_svm_range_put_if_dequeued(svm, op_ctx.range);
+		spin_lock(&svm->work_lock);
+	}
+	spin_unlock(&svm->work_lock);
+	return 0;
+}
+
+void
+amdgpu_svm_range_clean_queue(struct amdgpu_svm *svm,
+			     struct list_head *work_list)
+{
+	struct amdgpu_svm_range_op_ctx op_ctx;
+
+	spin_lock(&svm->work_lock);
+	while (amdgpu_svm_range_dequeue_locked(svm, work_list,
+				    &op_ctx)) {
+		spin_unlock(&svm->work_lock);
+		amdgpu_svm_range_put_if_dequeued(svm, op_ctx.range);
+		spin_lock(&svm->work_lock);
+	}
+	spin_unlock(&svm->work_lock);
+}
+
+static void amdgpu_svm_garbage_collector_work_func(struct work_struct *w)
+{
+	struct amdgpu_svm_gc *gc = container_of(w, struct amdgpu_svm_gc, work);
+	struct amdgpu_svm *svm = container_of(gc, struct amdgpu_svm, gc);
+
+	down_write(&svm->svm_lock);
+	amdgpu_svm_garbage_collector(svm);
+	up_write(&svm->svm_lock);
+}
+
+int amdgpu_svm_gc_init(struct amdgpu_svm *svm)
+{
+	svm->gc.wq = alloc_workqueue(AMDGPU_SVM_GC_WQ_NAME,
+					WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
+	if (!svm->gc.wq)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&svm->gc.list);
+	INIT_WORK(&svm->gc.work, amdgpu_svm_garbage_collector_work_func);
+
+	return 0;
+}
+
+void amdgpu_svm_gc_fini(struct amdgpu_svm *svm)
+{
+	flush_work(&svm->gc.work);
+	amdgpu_svm_range_clean_queue(svm, &svm->gc.list);
+	destroy_workqueue(svm->gc.wq);
+	svm->gc.wq = NULL;
+}
+
+void amdgpu_svm_gc_flush(struct amdgpu_svm *svm)
+{
+	flush_work(&svm->gc.work);
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
+	ret = amdgpu_svm_copy_attrs(args, &attrs, &attrs_size);
+	if (ret)
+		return ret;
+
+	switch (args->operation) {
+	case AMDGPU_SVM_OP_SET_ATTR:
+		ret = amdgpu_svm_set_attr(vm, args->start_addr, args->size,
+					 args->nattr, attrs);
+		break;
+	case AMDGPU_SVM_OP_GET_ATTR:
+		ret = amdgpu_svm_get_attr(vm, args->start_addr, args->size,
+					 args->nattr, attrs);
+		if (!ret && copy_to_user(u64_to_user_ptr(args->attrs_ptr),
+					 attrs, attrs_size))
+			ret = -EFAULT;
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
+#endif /* CONFIG_DRM_AMDGPU_SVM */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
new file mode 100644
index 000000000..968fb402b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
@@ -0,0 +1,368 @@
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
+static int amdgpu_svm_range_get_unregistered_attrs(struct amdgpu_svm *svm,
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
+	start_page = max(vma_start_page,
+		    (unsigned long)ALIGN_DOWN(fault_page, 1UL << attrs.granularity));
+	last_page = min(vma_last_page,
+		   (unsigned long)ALIGN(fault_page + 1, 1UL << attrs.granularity) - 1);
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
+static int svm_check_fault_allowed(struct amdgpu_svm *svm,
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
+static int amdgpu_svm_range_map_fault(struct amdgpu_svm *svm,
+			       unsigned long fault_addr,
+			       const struct amdgpu_svm_attr_range *attr_range,
+			       bool write_fault)
+{
+	const struct amdgpu_svm_attrs *attrs = &attr_range->attrs;
+	bool devmem_possible = amdgpu_svm_attr_devmem_possible(svm, attrs);
+	bool need_vram_migration = amdgpu_svm_attr_prefer_vram(svm, attrs);
+	devmem_possible = false; /* TODO: add migration */
+	struct drm_gpusvm_ctx map_ctx = {
+		.read_only = !!(attrs->flags & AMDGPU_SVM_FLAG_GPU_RO),
+		.devmem_possible = devmem_possible,
+		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
+		.devmem_only = need_vram_migration && devmem_possible,
+		.timeslice_ms = need_vram_migration && devmem_possible ? 5 : 0,
+	};
+	struct amdgpu_svm_range *range;
+	ktime_t timestamp = ktime_get_boottime();
+	uint64_t range_pte_flags;
+	int retry_count = 3;
+	int ret;
+
+	lockdep_assert_held_write(&svm->svm_lock);
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
+	ret = svm_check_fault_allowed(svm, fault_addr, write_fault);
+	if (ret)
+		return ret;
+
+	range = amdgpu_svm_range_find_or_insert(svm, fault_addr,
+						 attr_range, &map_ctx);
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
+	if (ktime_before(timestamp, ktime_add_ns(range->validate_timestamp,
+					 AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING))) {
+		AMDGPU_SVM_TRACE("already restored, skip: fault=0x%lx range=[0x%lx-0x%lx)\n",
+				 fault_addr, drm_gpusvm_range_start(&range->base),
+				 drm_gpusvm_range_end(&range->base));
+		goto out;
+	}
+
+	range_pte_flags = amdgpu_svm_range_attr_pte_flags(
+					svm, attrs, map_ctx.read_only);
+
+	if (!(write_fault && map_ctx.read_only) &&
+	    amdgpu_svm_range_is_valid(svm, range, attrs, range_pte_flags)) {
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
+	ret = amdgpu_svm_range_update_mapping(svm, range,
+					      range_pte_flags, attrs->flags,
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
+			    uint64_t fault_addr, uint64_t ts,
+			    bool write_fault)
+{
+	struct amdgpu_svm *svm;
+	struct amdgpu_svm_attr_range *attr_range;
+	unsigned long attr_start_page, attr_last_page;
+	unsigned long fault_page;
+	uint64_t ckpt;
+	int ret;
+
+	fault_addr = fault_addr << PAGE_SHIFT;
+	fault_page = fault_addr >> PAGE_SHIFT;
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
+				adev, fault_addr >> PAGE_SHIFT, pasid);
+			ret = 0;
+			goto out_put;
+		} else {
+			WRITE_ONCE(svm->checkpoint_ts, 0);
+		}
+	}
+
+	down_write(&svm->svm_lock);
+
+retry:
+	mutex_lock(&svm->attr_tree->lock);
+	attr_range = amdgpu_svm_attr_get_bounds_locked(svm->attr_tree,
+						       fault_page,
+						       &attr_start_page, &attr_last_page);
+	mutex_unlock(&svm->attr_tree->lock);
+	if (!attr_range) {
+		ret = amdgpu_svm_range_get_unregistered_attrs(svm, fault_addr,
+							      attr_start_page,
+							      attr_last_page,
+							      &attr_range);
+		if (ret) {
+			if (ret == -EFAULT)
+				goto out_no_vma;
+			goto out_unlock;
+		}
+	}
+	ret = amdgpu_svm_range_map_fault(svm, fault_addr, attr_range,
+					 write_fault);
+
+	if (ret == -EAGAIN) {
+		AMDGPU_SVM_ERR("handle_fault: got -EAGAIN: fault=0x%llx\n",
+			       fault_addr);
+		amdgpu_gmc_filter_faults_remove(adev, fault_addr>>PAGE_SHIFT, pasid);
+		goto retry;
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
+	up_write(&svm->svm_lock);
+
+out_put:
+	amdgpu_svm_put(svm);
+	return ret;
+}
+
+#endif /* CONFIG_DRM_AMDGPU_SVM */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
new file mode 100644
index 000000000..1c8f6c15e
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
+			    uint64_t fault_addr, uint64_t ts,
+			    bool write_fault);
+
+#endif /* __AMDGPU_SVM_FAULT_H__ */
-- 
2.34.1

