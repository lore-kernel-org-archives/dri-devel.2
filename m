Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32ACDCD6E45
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 05:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 989E110F8E5;
	Fri, 29 May 2026 05:48:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MDjJ6Oig";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A434E10F8E7;
 Fri, 29 May 2026 05:48:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/dQv5npXHyBLZtbat3lv8Ibi7Ich7wpSsrZV3KKGJMm6gP2xps3cuv533fIf58ZzbWWgqxkGotBYd62+8msypPZ4805AEllN39Y5rvg8N4fVKRZecrAJiYFLxowkSec3scaNr1GL1PoSGfqBiBkweGPk9pADfis+C3CMPWZQynpZJh1aLR+ME+mdhQnPL9+aMWdKjGRSdTk93J1AmMM6FdeDmnfwOYZZ4rR9tjl0vh442pvLpdtdDTYDHxPlsQALuOItQ18L9RM9oKqfBxak2wlm0PU80gBWAKEPaIveIvpkUisXvctMUZP6QLbsv7CHqecOhBcDI/swxzQmeTFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzuXxtNAwYRimlLVUrqrsyYBEjkpjKJLpT14P+D5F6A=;
 b=hBkntUBPlxK2aBEo/BD4faTWXtyulNVvbVOnydX9C5JbmIdI6e3ww7YgWw5Lxh5VGXD2uLA+INxe1JejXAltNXHz1uVWaM7WSABjLSv0uSQjB3m0u3w96CEY6rBmPmKwLIFGmd74FBYlA5oydaQdUo6pxh22/rlL4iVMygkf/1CTlA4osPQdYOyqFyms6KZ8BBs1PToIJimF81FyO4ktRKRe/x88NLshBHPq0kXnHeY3mjopSmkQuoTH2KFlWxPtQMFvsbVj/jq41X6ULlfqd8gREC3wMi5mQzg+1Dg/CEflMyIuiO8HUyxRbAVI52V9sWf1wudQ7xtPLZ7ffE/6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzuXxtNAwYRimlLVUrqrsyYBEjkpjKJLpT14P+D5F6A=;
 b=MDjJ6OigPU1t60yMyea7nR8Q301p8xJNLVucByd7ayzy0gFs508CAGW2PGEiMA0O3nTLaqTmaRiwYc0E95dotL3q2uPSIUrMTSSTYSoGONMGA5WZZH0sC+Q0qdD7mAjpQt9iB9/3YAoCSNAq7FL4WdCjMJUavKiW9fr5HbUv7eU=
Received: from BY3PR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:217::20)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 05:48:32 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::a5) by BY3PR04CA0015.outlook.office365.com
 (2603:10b6:a03:217::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 05:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 05:48:31 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 00:48:26 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V7 02/12] drm/amdgpu: add SVM core header and VM integration
Date: Fri, 29 May 2026 13:47:54 +0800
Message-ID: <20260529054804.596214-3-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529054804.596214-1-honglei1.huang@amd.com>
References: <20260529054804.596214-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 60966fc7-e55d-4006-e665-08debd45ea63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|921020|22082099003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ekg/3BRoPtyHQC2JzLX6B6QizufQsxlBSXGT4RLbvZIV2wktG18Typ75d6QiWye7HZ9TWzFs1dNmVJWIPMNoB1VdDQM3QSYPiQdbOImY35fJudLNvpri0hAxSA8mW7BErHJRusFiGaSGs4lZpSzndf68buzIvymnb0RIIUEYMgiN+oPJSaDP7a3OCTnOrpBIunujlLVJyo1BYJrmAlroq77QLRI3unX+fc8fSDRKP6nOihsV9TBL3TLvSLLsgUDSKWNUR9h7gdvGCbJA47BlOs8NCNE8hg0s6isRkBlZ2deS+d8YBpyg2o6jUKpfsV7sAIK/gXWmZcDEM1w+cmrSoIxwK0mOLHlnfWt5W7nuxe4VB4fBROlxcQnt7iwcfB55KUIZRDYw316LqQU69iBkdoUqEVwimRupKnspx7gct42zl9gSAJ0SCcuVsq0PFxK6wJHEbyeBevhn9T7sOPAxC0q/CXeXcqjN36Z9SRtAfT6v5CoJZFWiqlDsw7y7wyfTcyPRLhvqHbodgD1A4V/EbG4CbIwtBphqctzd38irhe5LC7pm3rd//bTPuyWSyXfQ/vjyCvjuenFB2sAGF7PYHWEZssBE0QHkxlffaCMotxCBxs1VnLw1RCSUFOQ9km9FRUoYPRn30J3b90ouuBbICPm82sa5eCx6AcDEkthAMdsKz+uvCQSrfzeSBk2yEaCfot8sdf548dcf/L+5Bk/M/0NCY3KKy2NCVULi+0lo0WdmH/zxtBmKN5JfJUmRyBcXd39wQcYALDqufuiV2iA1DQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(921020)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NYz7gNXXS7mAc8S/4R2Jw9nmkZeCwj8GcbenE4BySxky0lVrpj6ncE2C5ybOtz/3P476xjbjj2XsCi39V5zg5DGZUp1cM14ToTNjSJR2IUA0Pp9og31Y6XlT3OsAZF8dzlikBgq76+8AUe8BSgPwyKAyQdIuQWnk7yuIHvXKpcDhy+5QBbV3Mrxptr9vb/SebFyLrTFPBQFszJr45PV8uYFkFEQoDeKikjiVo5VedQATX7im4zK+jd7ytZ+TEethmOdlTiHGPHgt12mzf5mEN3ZmEbi3Z+sriN2KNX9G3QqBGL06ppho9uz7UGFwrwNaKyCXpZhjxFjgnvwOyk8gwUyTju3lqCG6uW77qj+TThbWeALOBOGGoqj3gzbhkLkDLVAN0c9wSZImR5GN8sjQB2xuOYRzqdzV8Fq75ZqMNjukwOIbqXGwj5wo7VJB1XI6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:48:31.4915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60966fc7-e55d-4006-e665-08debd45ea63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643
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

Add amdgpu_svm.h with SVM data structures and public API:
- enum amdgpu_svm_xnack_mode: OFF, ON, DEFAULT mode selection
- struct amdgpu_svm: core context with drm_gpusvm, kref lifecycle,
  attribute tree, rw_semaphore, GC workqueue, xnack state,
  flush_tlb and invalidate_ranges function pointers
- struct amdgpu_svm_gc: garbage collector with workqueue and work_struct
- Debug/trace macros: AMDGPU_SVM_TRACE, AMDGPU_SVM_WARN, AMDGPU_SVM_ERR
- Kmem cache helpers: AMDGPU_SVM_KMEM_CACHE_CREATE/DESTROY
- Locking helpers: amdgpu_svm_lock/unlock/assert_locked
- Public API declarations (including clean_queue, sync_work) with
  static inline stubs when CONFIG_DRM_AMDGPU_SVM is disabled

Add struct amdgpu_svm forward declaration and svm pointer to amdgpu_vm.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h | 195 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   4 +
 2 files changed, 199 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
new file mode 100644
index 000000000..49f8b8f06
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
@@ -0,0 +1,195 @@
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
+#ifndef __AMDGPU_SVM_H__
+#define __AMDGPU_SVM_H__
+
+#include <drm/amdgpu_drm.h>
+#include <drm/drm_gpusvm.h>
+#include <linux/atomic.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/printk.h>
+#include <linux/rwsem.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+struct amdgpu_device;
+struct amdgpu_vm;
+struct amdgpu_svm_attr_tree;
+struct amdgpu_svm_attrs;
+struct drm_device;
+struct drm_file;
+
+enum amdgpu_svm_xnack_mode {
+	AMDGPU_SVM_XNACK_OFF,
+	AMDGPU_SVM_XNACK_ON,
+	AMDGPU_SVM_XNACK_DEFAULT,
+};
+
+#define AMDGPU_SVM_TRACE(fmt, ...) \
+	pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
+
+#define AMDGPU_SVM_WARN(fmt, ...) \
+	pr_warn("%s: " fmt, __func__, ##__VA_ARGS__)
+
+#define AMDGPU_SVM_ERR(fmt, ...) \
+	pr_err("%s: " fmt, __func__, ##__VA_ARGS__)
+
+#define AMDGPU_SVM_KMEM_CACHE_CREATE(name, type) \
+	kmem_cache_create((name), sizeof(type), 0, 0, NULL)
+
+#define AMDGPU_SVM_KMEM_CACHE_DESTROY(cache) \
+	do { \
+		if ((cache) != NULL) { \
+			kmem_cache_destroy((cache)); \
+			(cache) = NULL; \
+		} \
+	} while (0)
+
+#define amdgpu_svm_assert_in_notifier(svm__) \
+	lockdep_assert_held_write(&(svm__)->gpusvm.notifier_lock)
+
+struct amdgpu_svm_gc {
+	struct workqueue_struct *wq;
+	struct list_head list;
+	struct work_struct work;
+};
+
+struct amdgpu_svm {
+	struct drm_gpusvm gpusvm;
+	struct kref refcount;
+	struct amdgpu_device *adev;
+	struct amdgpu_vm *vm;
+	struct amdgpu_svm_attr_tree *attr_tree;
+	struct rw_semaphore svm_lock;
+	spinlock_t work_lock;
+	struct amdgpu_svm_gc gc;
+	atomic_t exiting;
+	uint64_t checkpoint_ts;
+	u8 default_granularity;
+	bool xnack_enabled;
+	void (*flush_tlb)(struct amdgpu_svm *svm);
+	void (*invalidate_ranges)(struct amdgpu_svm *svm,
+				  struct drm_gpusvm_notifier *notifier,
+				  const struct mmu_notifier_range *mmu_range,
+				  struct drm_gpusvm_range *first,
+				  uint64_t adj_start, uint64_t adj_end);
+};
+
+static inline struct amdgpu_svm *to_amdgpu_svm(struct drm_gpusvm *gpusvm)
+{
+	return container_of(gpusvm, struct amdgpu_svm, gpusvm);
+}
+
+static inline void amdgpu_svm_lock(struct amdgpu_svm *svm)
+{
+	down_write(&svm->svm_lock);
+}
+
+static inline void amdgpu_svm_unlock(struct amdgpu_svm *svm)
+{
+	up_write(&svm->svm_lock);
+}
+
+static inline void amdgpu_svm_assert_locked(struct amdgpu_svm *svm)
+{
+	lockdep_assert_held_write(&svm->svm_lock);
+}
+
+#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
+int amdgpu_svm_cache_init(void);
+void amdgpu_svm_cache_fini(void);
+
+int amdgpu_svm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+void amdgpu_svm_close(struct amdgpu_vm *vm);
+void amdgpu_svm_fini(struct amdgpu_vm *vm);
+
+void amdgpu_svm_put(struct amdgpu_svm *svm);
+struct amdgpu_svm *amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev,
+					       uint32_t pasid);
+int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
+			    uint64_t fault_page, uint64_t ts,
+			    bool write_fault);
+bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm);
+
+int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
+			 struct drm_file *filp);
+void amdgpu_svm_clean_queue(struct amdgpu_svm *svm,
+			    struct list_head *work_list);
+void amdgpu_svm_sync_work(struct amdgpu_svm *svm);
+int amdgpu_svm_garbage_collector(struct amdgpu_svm *svm);
+int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
+				 const struct amdgpu_svm_attrs *old_attrs,
+				 const struct amdgpu_svm_attrs *new_attrs,
+				 unsigned long start_page,
+				 unsigned long last_page);
+#else
+static inline int amdgpu_svm_init(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm)
+{
+	return 0;
+}
+
+static inline int amdgpu_svm_cache_init(void)
+{
+	return 0;
+}
+
+static inline void amdgpu_svm_cache_fini(void)
+{
+}
+
+static inline void amdgpu_svm_close(struct amdgpu_vm *vm)
+{
+}
+
+static inline void amdgpu_svm_fini(struct amdgpu_vm *vm)
+{
+}
+
+static inline int amdgpu_svm_handle_fault(struct amdgpu_device *adev,
+					  uint32_t pasid,
+					  uint64_t fault_page,
+					  uint64_t ts,
+					  bool write_fault)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
+{
+	return false;
+}
+
+static inline int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
+				       struct drm_file *filp)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_DRM_AMDGPU_SVM */
+
+#endif /* __AMDGPU_SVM_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index cc096c005..9e6a668e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -43,6 +43,7 @@ struct amdgpu_bo_va;
 struct amdgpu_job;
 struct amdgpu_bo_list_entry;
 struct amdgpu_bo_vm;
+struct amdgpu_svm;
 
 /*
  * GPUVM handling
@@ -448,6 +449,9 @@ struct amdgpu_vm {
 
 	/* cached fault info */
 	struct amdgpu_vm_fault_info fault_info;
+
+	/* SVM experimental implementation */
+	struct amdgpu_svm *svm;
 };
 
 struct amdgpu_vm_manager {
-- 
2.34.1

