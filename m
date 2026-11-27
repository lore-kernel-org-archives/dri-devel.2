Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB01606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MqNoEmYN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 834A811285C;
	Fri, 27 Nov 2026 08:42:30 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013000.outbound.protection.outlook.com
 [40.93.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2F3310E454;
 Fri, 27 Nov 2026 08:42:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoNVv7Ih0hZzA8UzMyZK/1siqgqxdlxfgN3Rq9fYV1R+I76wx8hUZa3pBGjybI7sOp6dZ9xRzi4MhwcKzO4gFUxETYqmC4VVcIv7YstNUaYiPLtw+qfEcWwe0ipm/hTgStUe+I2t8xOhLXr/fO8cS1LRRhUqlzkTwmFHKJfZp1MosnAY1ZCmvRRBPkNeH/CZQB3deTY5Ri6frOHAI5UkUNJmVbaEZ19AijxvlCA64Thg6vNoHTIqoC6imWUCnW0JJokiutArv53uf0SBDBzTnI/hXDbEj68nBe5Q90+/Go6XTWkeU61b35nNQYRS5Nn2UCGHfUOLcG02mxz4kFaAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgWbmIx++B/G4aw+ZQihWZrkLC5R8VlUTlYVSPMQZJY=;
 b=lZwI1TpTMt8rjh0fjQaj/eJA4qhCICnCHkKnZthaLMHHquqyFO1ao6V/w5kg0MkKj+NSsd/phms0EAW8/rmfUBkqOSUvwJjr2fvZrfaCpx3gpMwqBaZazTs/8T0YfxN4kqMuvanp134NlHPyG7t2641gTO6DaV3ff69nbuWTnPEheIh8nKg6EmUzMTg4KXK2LSK+qo6WNG7GNRxpzfNv+00sEIH9atc9dd7iUp0duDox76U+4F/hS1wpiXVULAwC2zdFyB6hGIhAn2sBm7rqpLJZ8DEH8LNjXeOea15JEasfLvCDWCchzZmIuLwIScrmlmRgtxSzTeW6+K5sRTAj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgWbmIx++B/G4aw+ZQihWZrkLC5R8VlUTlYVSPMQZJY=;
 b=MqNoEmYNbohZkfw+Els/8M7AZA01KGBIQrbr5LYh//bF0Cig7RC8KjLGf2W90J84xvRvA2Om4rEFu+bvvcoyFWSEgGxbgl/VgUkPOFlE2iiWgPpznhEShcGEAlKy93rs9xtvikzos4EVlrEXgQ7KIHaSjECyErIU8JtSWs7g/gc=
Received: from CH3P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::33)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 27 Nov
 2026 08:42:06 +0000
Received: from CH2PEPF000166C0.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::22) by CH3P220CA0026.outlook.office365.com
 (2603:10b6:610:1e8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 08:42:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166C0.mail.protection.outlook.com (10.167.252.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:42:05 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:42:00 -0600
From: Huang Rui <ray.huang@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>, "Matthew
 Brost" <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Aveline Noir <jm5905938@gmail.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>, "Jenny
 Liu" <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 "Honglei
 Huang" <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [PATCH v11 03/22] drm/amdgpu: add SVM core header and VM integration
Date: Fri, 27 Nov 2026 16:41:26 +0800
Message-ID: <20261127084149.925625-4-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127084149.925625-1-ray.huang@amd.com>
References: <20261127084149.925625-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C0:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: e82b143c-0872-49d0-11f5-08df4c6250f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|22082099003|6133799003|261009221227099003|261009223027099003|261009221727099003|18002099003|3023799007|261009223327099003|261009220027099003|921020|56012099006|261026140227099003|11063799006|10067099003|261026121527099003|261021121427099003|261022105027099003|261102123227099003|261022113327099003|261022115727099003|261022075727099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: k7op3CalGANHpekE/7e5Xc1Jr2cIFoIioHlqRXRu4UhpSb7rJF2ahez5y4eqFYyK0HpyC48dJA74SrIaLR2RL1ucz5XemHYyXckzsPyxa/aAAQFbnuHUqrAOt17d8RUaXqvKk4yZgv+UB6n6bv8KKiwI1LFBh2hDDiPdc40Lwl+NPVTNRP9NlJ2lgLJHc751vQNz3WiktCNyXSDlfGRQmjehuyPyvk9bKFSSRtxmb3Lq8DQdtFPedMUeK0kyrkRxWpWUp+WU+0nRKDmdcU+/zMwXaPtLjYfdw/08LeujZEO1xYQEcXGJAcwt2leN7qmH5phqFjC6SjP/y0qW3B4fZHQ+Jrvae5BTSMZWyidCPbpITvg8Nl2YAvuy4aFf+4DvhBogkvLAGIILDBWQL2gt7ao6CmOs8miZt0fjKk7YwnL9VsZJoSHmY6L6IxzxG/J6ZoUg1LTVuLx7L1C3Kxq72uLu9/IohmhT/ydiDvSo6p+243Kz8OCWg4eFRL3jwGL+Y0ThbhUBVi3XWmE7GI8dEqj9v+4YHZhk13V4ai1Bgx21j0gigyr8DsJB4ZnHxmoGEsibd+1DQK9SogwiqAhzKTv+1AenhzqpsvCR19+H0BsyzTIwYE6Uv4RX8vkk6nn4nHRxds7FIZy1D+bG1zgj7Kcz37X2lnUhpcGfE+lm3Lg2Z8v/MViMKrkpLy0/MHvk4BSbyA+4TJ5Hkp0QjLBg1eLpAKnYrKHvMYMCMSpgtV+QT5fQuXxIFfc+Ph3aZUfC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(22082099003)(6133799003)(261009221227099003)(261009223027099003)(261009221727099003)(18002099003)(3023799007)(261009223327099003)(261009220027099003)(921020)(56012099006)(261026140227099003)(11063799006)(10067099003)(261026121527099003)(261021121427099003)(261022105027099003)(261102123227099003)(261022113327099003)(261022115727099003)(261022075727099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LZxxsVdDijh1vPFuzouBR1X7oHUbTlo3mnhraVld5EmaLlpOgxOlfld+hKUJEeE3J2jzi/Z2rkVra97H2ZkDJC/xo2pUHR1hqjOcDj08DUmIeYn1eMT5EVkl3s+3zIQQQ3FY+Db+Eqw4mR0O9zx1VZAJIAf5LddwO2Or12HPkQ2/czEQkhDSfobv1lABdcUrL3NxyMy+gSyF7Jxfyyi3Hc3j/afHSW6TcMPWJBO0wL4lae8jbFureRVWI2taP8SvZe1GRxsFGv6FCYmOwNhNpKR2bivltF9esVSti4fE6mWyme+b7JgoYC0Ybk7BGmrHa0G20s4lQaQHv2TYHjfpyEvnJxbZYUHYZ2Tcm7VIkRi6PKN17whzyXIqAthdjGYTqLz59wIvEChbwRmMdRSuc96T32DOUA27lnK3zSvtxqBv51a6uslyCQgtKzhxkuXq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:42:05.8355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e82b143c-0872-49d0-11f5-08df4c6250f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166C0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964
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

From: Honglei Huang <honghuan@amd.com>

Add amdgpu_svm.h with SVM data structures and public API:
- enum amdgpu_svm_xnack_mode: OFF, ON and DEFAULT mode
- struct amdgpu_svm: core context with drm_gpusvm, kref lifecycle,
  attribute tree, rw_semaphore, GC workqueue, xnack state.
- struct amdgpu_svm_gc: garbage collector with workqueue and work_struct
- Kmem cache helpers: AMDGPU_SVM_KMEM_CACHE_CREATE/DESTROY
- Locking helpers: amdgpu_svm_lock/unlock/assert_locked
- Public API declarations (including clean_queue, sync_work)

Expose TLB flush errors so invalidation can stop before releasing
DMA mappings when the compute flush fails.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h | 175 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   4 +
 2 files changed, 179 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
new file mode 100644
index 0000000000000..c21690c2d2117
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
@@ -0,0 +1,175 @@
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
+ * @default_granularity: Default range granularity.
+ * @xnack_enabled: Whether retry (XNACK) faults are enabled.
+ */
+struct amdgpu_svm {
+	struct drm_gpusvm gpusvm;
+	struct kref refcount;
+	struct amdgpu_device *adev;
+	struct amdgpu_vm *vm;
+	struct amdgpu_svm_attr_tree *attr_tree;
+	struct rw_semaphore svm_lock;
+	spinlock_t work_lock; /* Protects GC queue state and pending work. */
+	struct amdgpu_svm_gc gc;
+	atomic_t exiting;
+	u8 default_granularity;
+	bool xnack_enabled;
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
+int amdgpu_svm_flush_tlb(struct amdgpu_svm *svm);
+
+int amdgpu_svm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+void amdgpu_svm_close(struct amdgpu_vm *vm);
+void amdgpu_svm_fini(struct amdgpu_vm *vm);
+
+void amdgpu_svm_put(struct amdgpu_svm *svm);
+struct amdgpu_svm *amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev, u32 pasid);
+int amdgpu_svm_handle_fault(struct amdgpu_device *adev, u32 pasid, u64 fault_page,
+			    bool write_fault);
+bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm);
+
+int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
+void amdgpu_svm_clean_queue(struct amdgpu_svm *svm, struct list_head *work_list);
+void amdgpu_svm_sync_work(struct amdgpu_svm *svm);
+int amdgpu_svm_garbage_collector(struct amdgpu_svm *svm);
+int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm, const struct amdgpu_svm_attrs *old_attrs,
+				 const struct amdgpu_svm_attrs *new_attrs, unsigned long start_page,
+				 unsigned long last_page);
+bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm);
+#else
+static inline int amdgpu_svm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
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
+static inline int
+amdgpu_svm_handle_fault(struct amdgpu_device *adev, u32 pasid, u64 fault_page, bool write_fault)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
+{
+	return false;
+}
+
+static inline int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_DRM_AMDGPU_SVM */
+
+#endif /* __AMDGPU_SVM_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ee07982b0a141..bf752c6959b5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -43,6 +43,7 @@ struct amdgpu_bo_va;
 struct amdgpu_job;
 struct amdgpu_bo_list_entry;
 struct amdgpu_bo_vm;
+struct amdgpu_svm;
 
 /*
  * GPUVM handling
@@ -382,6 +383,9 @@ struct amdgpu_vm {
 
 	/* cached fault info */
 	struct amdgpu_vm_fault_info fault_info;
+
+	/* SVM experimental implementation */
+	struct amdgpu_svm *svm;
 };
 
 struct amdgpu_vm_manager {
-- 
2.53.0

