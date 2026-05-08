Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED85CD37AC
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06B4210F3AB;
	Fri,  8 May 2026 07:52:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FaMcGFDe";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B5E10F3B5;
 Fri,  8 May 2026 07:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gys5wmTNnyCA5EFLnIKM7L7YrYvCzY7Mmdfyf00AMpsTpiyA+Pr3OV2WHWusCe+1Y87W1pON3mSH+mWpkX1PqTquTAzC8JUP0YpdZfsYEsK+5Bjx6IPvS5t8MzshCxJ9g2xjNvGM7v/2vdeoMeCZJAQaW8xidnvpGp9D3QT1dzg/XVx0GeSG16vtofO2ZYje6MEfIoLvAWDajM6/2QNVaI+IvyNaEEiZnXyrixJPCIxNtNUZagjgwdeWzM46enK6kjifFiIX8PUd/80NmI53sTZKyf0G68viGc/eykyjETk+TFceZlGKxM2NBpuYCxgBY7QXdQv8RCzNHYv/eRfDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClYEGTMAGQJMi27uXOzoGxjRXSRxLGfJBxME+6HcLPM=;
 b=QItyu2wjddRLlzD9RQh7uM51MdANhG0Q/ACEY9qyez8tOJA7hV5Cf/QI/lt3PhgkQ9wSP+oxHqF3rCwxq2AQAEcgOnHJQVwzQv9PDpnn3zJvFkMCjB+J+wdx1TWgCEPwNzvQbobtU05fl0F//y42a20wp8KmWvjpsKIleU+Ma3nHSv13OBlwXYaJ8El66RF894WLfWl9/Tadj4OzHjyrAtjVqM6Z8tLQEm4Sy6QBMnCtEJEDjhGhe8hG5+F6OgnLEJDsnGeUMd+f8KdPGdaUJVq2Ss3PMdZUrVBYbbZJeiCiw1EA7vxZLkH21JLr+rcELHljet2VoSm4DlnHneYORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClYEGTMAGQJMi27uXOzoGxjRXSRxLGfJBxME+6HcLPM=;
 b=FaMcGFDehOI9fDK15XoN8cpKHf1WWEn5I6GC07iMINAz+1k8Wt6eXNmxN37r4oF4dOJhWyTUrT9xHbYda06yLNmSqPdDoYoMF0rXsYidBF6pvDGd7vUgoiCXPCT9KS3stSQQPoLgEHyAhnOoM0jFpxvSH/9tVUHmlp4yhdB9I5I=
Received: from MN0P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::13)
 by IA1PR12MB8585.namprd12.prod.outlook.com (2603:10b6:208:451::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 07:52:38 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::2) by MN0P222CA0003.outlook.office365.com
 (2603:10b6:208:531::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 07:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 07:52:38 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 02:52:33 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V5 11/12] drm/amdgpu: add SVM ioctl entry and fault handler
 module
Date: Fri, 8 May 2026 15:51:28 +0800
Message-ID: <20260508075129.1161157-12-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508075129.1161157-1-honglei1.huang@amd.com>
References: <20260508075129.1161157-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|IA1PR12MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f70e409-130b-4429-1c58-08deacd6c626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|921020|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: BwLrY5RTo4xQp9rpRHxmdLnV2MMhO/mD5T6/t9mrQNANLsDL33kaNGvYRgulJQUY4tf7NrSfpTYeBONa9ZFzJqQVnXZHRpJfUNIx8ZkasjdpMbhKnk+tPg1Pg9l2I5UwdRAvXy1Fr6kQdGRO5o3eTJMMhWDCWoNHpy32HXoUhfx98WDql+L20Z94fDW66PWphSKxSQwrLIXdV7XaasE+eLf8bruL7WUqNtxxJICTkB/0pN29GdJIQBDWubyARMNkd/zNJOagC3VkogeT0q7FnYcPEyPXpOr/5KaWawgRVOUe+TfdO08Nbwtnnj1kMeoAtE6CWt6ga8qLUIzI3IKQrsoDz/QrjmiZg+vwz4Tab60TWYvjXxRNHaOXbh7LwweEkBD4VGPTpnG1d6kpO1tHG6G9xkl40I6HSmx4DgeG5kDeu4/cv7QI0zuYDSysZSFv+oCsHYeMUMb//suihmUDW+iZOD3IYPiCq0bT+LDcZ9Lcj9C37xLME4dbzfhMCVLsjbMzTYiBRx1Iw17ctt3EgMeyvkTjYeZ+FlPAGb1JXCAnv7p3sxEPgLdIKiufc0oxhlNaYUhj0GwBzyf/xWKyaoZwBYFVSTT0AaDdDVRfLhOcYGwWpR40l8lPFaBupQyy0DbdtF2+nqNZ5lZ1eiHQ2leQN66m8BWlF1Emm+GqmZ3E4APdXc0Gypo7mqLnbrPpXm4TWLmDd2iN2IWTZcS+H+1L4tnyWrKbptLXZ3JAqPZxfjkbSYnffXXDj+VKNOgMsJ6IX/34k9RYJk8HdGuC8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(921020)(22082099003)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +ykwdQqGluCUSYVzDoMhJTpuTU2yeZCfKowPLqT7r4RiJmM8Eqt6oy3Hl93Mn2z7L86/iAWQ3f2munb7EOsTu4Kpr241lQ24PnBs7JnRSXwsUY20XXfhwBqVcWI9uUl3d8rboML1GaaR4GpHShx+zzgKz5aFxvHj99k7DUQMJI7Nlkaf1xZGYNBp0iQpkK7xihynTG1/ueyyV4uTatvRnMOqiQxG37CGbgLfIHNrXN0MTNk0gz67Vr/Z4mgnhFkyVgw3iCGdUI7RNn0UFDPUXDFzH107oWuXGPLaav51Z1T8gVpHsrDBb4mEbAY0Yr0c6dTh1pfrT7X0gLDSNsNUwLNgeBVu2c3DMRbOejJU7I2/a6yGZbBBKzjZHv/3JgqqGu+xg/5wrRNhUYwjBhJzomXMiT1qHcrlM1u5gwx7PpzVxbDn/6AtwMGGwMMvzJHx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:52:38.0129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f70e409-130b-4429-1c58-08deacd6c626
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8585
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
- amdgpu_svm_range_clean_queue: drain work list releasing refs
- amdgpu_svm_garbage_collector_work_func: GC work handler
- amdgpu_svm_gc_init/fini/flush: workqueue lifecycle
- amdgpu_gem_svm_ioctl: validate args, lazy-init SVM, dispatch
  SET_ATTR/GET_ATTR/RESET_ATTR with copy_to_user for GET

amdgpu_svm_fault.c (new):
- svm_check_fault_allowed: VMA permission check for fault address
- amdgpu_svm_range_get_unregistered_attrs: create default attr range
  for faulting address not covered by explicit attributes, bounded
  by VMA and granularity alignment
- amdgpu_svm_range_map_fault: fault mapping pipeline with retry
  (GC, permission check, find/insert range, timestamp dedup,
  validity check, get_pages, update_mapping)
- amdgpu_svm_handle_fault: top-level entry point from VM fault path
  (PASID lookup, exiting check, xnack gate, checkpoint timestamp
  filtering, attr lookup with bounds, dispatch to map_fault)

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 148 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 386 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h |  39 ++
 3 files changed, 573 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
index f88bad1d6..1fd09a1bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -434,4 +434,152 @@ bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
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
+	amdgpu_svm_lock(svm);
+	amdgpu_svm_garbage_collector(svm);
+	amdgpu_svm_unlock(svm);
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
index 000000000..7763eb029
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
@@ -0,0 +1,386 @@
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
+		.read_only = !!(attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_RO),
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
+	ret = svm_check_fault_allowed(svm, fault_addr, write_fault);
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
+	amdgpu_svm_lock(svm);
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

