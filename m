Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BB6606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 02:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lOSt9dpi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADF4F10F88B;
	Wed, 21 Oct 2026 02:59:52 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7347C10F834;
 Wed, 21 Oct 2026 02:59:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVYWTWwe/9///W5iSAHtKnEG9nAkazBH6T1QIEbwjsPp/fyqDakxuGvB9q+CzwK9f7MknkZpGHPxmQ1GKD+OwHub6uEy2adaUVrV8JtKK/6S+AF9HOVB773DKNNoxk+bG7g7N+8m4wjefB7toulyXXdcylPoK6BfbB17BCyP9mouEWTdhwSsDl4JYuHW/15D7OYya7Z6DyfhbtmZgtsxi5xw/EGOafgLni09u7Mw4fbTyJQzhjNA4vQ2bXTpjhmi7zLr73+iXHCUaS1+bwgKd0LSUu8J/G2CJMpgvn5LY23xI9aRTZhYQijAbjs+4xBgc94Tdu6oVJ0QnfK8/M/Xrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWl3DklHF/YNie0B2XdTwDfJoTp8lxF3K/IG92UFnnU=;
 b=hD2/8w2R6O9sttMNwKmw7Yp2sCAOqeARlX/Yyme5TtBNh061AH4glhaLvn00pD56eJZNlBN8swCLkCqUIs/7mmKeT2nN6TudS1eMcRkHbRCaLRQ0EDa1j11Sj9WopnMFzvXb4yf8MYiJ8832M23n8iEr2ETzPEF919tD3XLbbOX5qCIJlt80B5KeajqLshN/eojdxwH1u1F3SpmyIcV9SQRBe5jVj/eQLjRvPrMKz6+zI13hbL3jgoLDF4pMppmi72m5nZ+FH8qb6yc62Sgpd++8SZ0uZLJ9Tu6kzAWCGEYhMP0nQttY7cKcpNua6djVlbIef2K2sC/FahwI8j13cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWl3DklHF/YNie0B2XdTwDfJoTp8lxF3K/IG92UFnnU=;
 b=lOSt9dpihnA/dAT5+7BSfYDq+eSMFU1Dq5PuasACr36xi2iwbAqOz1w8jcW0kjZxBF8q4iya8OBrSH/IuLa19oUpY4QGuJ4UlKw5l0AsotHGC2YqZhzZ9+bwosxn0MCokn7J6KL7QUIwDXqs+WACO/a8XsgfEx5oBtHSqLLC6Jo=
Received: from SJ0PR03CA0275.namprd03.prod.outlook.com (2603:10b6:a03:39e::10)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:59:39 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::2) by SJ0PR03CA0275.outlook.office365.com
 (2603:10b6:a03:39e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 02:59:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 02:59:38 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 21:59:32 -0500
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
Subject: [PATCH v10 02/22] drm/amdgpu: add SVM core header and VM integration
Date: Wed, 21 Oct 2026 10:58:41 +0800
Message-ID: <20261021025915.2433837-3-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf2533b-1dc0-4907-6848-08df2f1f58a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|921020|56012099006|261009223327099003|261009220027099003|11063799006|261009221227099003|261009221727099003|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: vErvR4Og/F9ioCacnzBUa71ulXhDkGHuDtZHEHlE0i6/d3mhgxFAvt04orFp49v53di4+6fJNws/f9VW/TXeKOzY2D94bo888iVIha5N7/wypd0TJk0StcxmVToIfAyHraG8TEyhFkvHaQvjYgQ1CAFrvPmh8vtFVYR+/TeMEwPf1MW1ZRfBXct2punRO5cEuLcMIRQJLKgpelIVLNP5bbLX2pK9/xxKIWLcLxekiluNUGuNcfPwATnDB2zJoTy5lApx8svlgAkGsfK6jPqFdxONUuuCMyHdFfdU5YcMnyPgC348OQegOJc8mEwkdgdFrQ6uorLFiEzX8oSdS0/kcLOOid5WN9T8Xj4bQzHG7yDhPl80SBRAlU3rT5Qm/fpQzMX6AFF+K4SY/hcOG85yFm/HzF9eh7We9cCsU1dHdgg8SkmS27S5HvB0r7Qq+rVkuPUDNUz3LZVrNlRNmfdNOKUjdCQ/buWJQuN6XR71VNecuoPvYSgPPq5v9J9b1wm40qWnoZWH2deL1JDIIlV+7ki67gJaKJO/WzWbgZg7yWzTxtBzWTuEQbiI2qAeYVgDxsnFX6NzkvM2oPQR025qAVyb7yh5DlIEHpZrwNFHWtKlecJ/iix1aq47BpuFGabApnVgx3VZ9/OOr8oxfBSaIrRJeibwtkppdOfOmqdsoMKrosvOMccdJQgpTOEcmR6hPHl5gGNXcSYvEMWdhf+PWHyr34T9P0JexEklk6pNMfwMuwrOhkenoUQRKQbabAWl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(921020)(56012099006)(261009223327099003)(261009220027099003)(11063799006)(261009221227099003)(261009221727099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cnLDi2Y+leyReccRjC/XqtXtlYDiOkxF6BjuRiP6Ivx7KsLQer4a641Mgd6As9xHVqBmTFws97c+fKRHtVJYmYTju2qkKp3X8F2CCkKURJASSRPZmKolDuBH41jGHH/7aisrRcBH1N1TYpcI6EKFLloWt8ZJ1JfUK6HsenAVqOkZWZkcmjpqhEWuFDZicz5fQ9SMNqGwrpSAHf2aps6xJgs1bLMp76MKWcOuU85zcR1J/eodISoOeYe5v+fFINrUN7nHvLbYsL/A4bUOEWyA/kpUtq5yLmQq5M50CkqlYWBWs22JfzjdjMgZpHEHj1LtNd536ryMR97H9qjAvjGO4uoNdUwERg7Vnh6MKkGOarCHoejjl9FvSPZr6nmHsPPnnUvA3kbLYU2cuSZZs9vLQGPvPr6N0GY7i4DXm8isSa2/elxgtnQkfOSVzTxRAfQu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:59:38.6172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf2533b-1dc0-4907-6848-08df2f1f58a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467
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

Add amdgpu_svm.h with SVM data structures and public API:
- enum amdgpu_svm_xnack_mode: OFF, ON and DEFAULT mode
- struct amdgpu_svm: core context with drm_gpusvm, kref lifecycle,
  attribute tree, rw_semaphore, GC workqueue, xnack state.
- struct amdgpu_svm_gc: garbage collector with workqueue and work_struct
- Kmem cache helpers: AMDGPU_SVM_KMEM_CACHE_CREATE/DESTROY
- Locking helpers: amdgpu_svm_lock/unlock/assert_locked
- Public API declarations (including clean_queue, sync_work)

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h | 195 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   4 +
 2 files changed, 199 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
new file mode 100644
index 0000000000000..72f954d2df39e
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
+#define amdgpu_svm_assert_in_notifier(svm__) \
+	lockdep_assert_held_write(&(svm__)->gpusvm.notifier_lock)
+
+/**
+ * struct amdgpu_svm_gc - SVM range garbage collector used for unmapping
+ * SVM ranges in response to mmu_notifier events.
+ * @wq: Workqueue where @work runs on.
+ * @list: Ranges list in garbage collector. Protected by amdgpu_svm.work_lock.
+ * @work: Drains @list under amdgpu_svm.svm_lock.
+ */
+struct amdgpu_svm_gc {
+	struct workqueue_struct *wq;
+	struct list_head list;
+	struct work_struct work;
+};
+
+/**
+ * struct amdgpu_svm - shared virtual memory context
+ * @gpusvm: Embedded drm_gpusvm base, manages the range/notifier trees.
+ * @refcount: Reference count guarding the lifetime of this instance.
+ * @adev: The amdgpu device this SVM context belongs to.
+ * @vm: Back pointer to the owning amdgpu_vm.
+ * @attr_tree: Interval tree of SVM attributes.
+ * @svm_lock: The driver_svm_lock described in the GPU SVM locking section.
+ *            registered by drm_gpusvm_driver_set_lock().
+ * @work_lock: Protects the deferred work queues such as @gc.list.
+ * @gc: garbage collector for ranges queued for destruction.
+ * @exiting: Set once when the context starts tearing down.
+ * @checkpoint_ts: IH ring timestamp captured on unmap, used to drop stale
+ *                 faults.
+ * @default_granularity: Default range granularity.
+ * @xnack_enabled: Whether retry (XNACK) faults are enabled.
+ * @invalidate_ranges: Callback of the MMU notifier invalidate event.
+ */
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
+/*
+ * Helpers for amdgpu_svm.svm_lock, the driver_svm_lock registered with GPU SVM.
+ * Hold it in write mode around structural GPU SVM updates, including
+ * drm_gpusvm_range_find_or_insert() and drm_gpusvm_range_remove().
+ */
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
+void amdgpu_svm_flush_tlb(struct amdgpu_svm *svm);
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
+bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm);
+#else
+static inline int amdgpu_svm_init(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm)
+{
+	return 0;
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
index 9b07df5a2b816..b435e393be154 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -43,6 +43,7 @@ struct amdgpu_bo_va;
 struct amdgpu_job;
 struct amdgpu_bo_list_entry;
 struct amdgpu_bo_vm;
+struct amdgpu_svm;
 
 /*
  * GPUVM handling
@@ -381,6 +382,9 @@ struct amdgpu_vm {
 
 	/* cached fault info */
 	struct amdgpu_vm_fault_info fault_info;
+
+	/* SVM experimental implementation */
+	struct amdgpu_svm *svm;
 };
 
 struct amdgpu_vm_manager {
-- 
2.53.0

