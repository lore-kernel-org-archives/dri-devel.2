Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9368DF3ED74
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A42FD10E544;
	Mon, 20 Apr 2026 12:08:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TpF1ZYoo";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 403E310E542;
 Mon, 20 Apr 2026 12:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b40npHA5/Ick0X2PG+W8TOBx5/w1VINXX9alYCVhbmVKWxkJR8c9vMXlYrfbe0jtQpmNfGS8bIFXwb8xUsUZKQI/SZAuksHfEvoN37kqZIgCxgvHQg9nJBZeakiYNOlQPJrCxEV28mcVLuesvjb9XRNAgvVMugFuxma4xuflnAtjCYDI2rEUe4YIL4qfEixbcVAtMjmmdMhv0TNAwM8G579q+H+vLKOm2RS6Tf8cJL1frWHhZNFjumc/r3Ic30NPENUIhdesfcT7YtieT7mzf6q33Koj4xtmQIuqCV38B2kI/B+VnfrH9CvgUOxuqY4g6hYd7xl7ZPhfJB+aODVeow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gS6sSmU1T9xuw5OXFYZcOniVHD5cNs00kxbt9SnhsPQ=;
 b=sYwOdmJyTPy5gWvRHPXqBPNIXQqaY3cVkEHTLRcpyU+T6Lmf88d17VU8GyRo1ceIe3qtBMu0EOXEn81n986X6HrLIzDjRHfXUAFTOOdvEHclQ3x7YRzfi8gaCJL7+A2tU84zcdGf4Nw7U5/cTY8qU5z0TmEGKSAKNdBCorOXMDnWnwmJkr/UXQILoxt1zqHPi854SxmjjMZZf+ZH/Mtt2rYsWte5FA2MV2YBGG9d5Dy2E0pmUIsIDMc3rGAs1NzeStRJs7249zx5gsqn/tngUOnIhwpLiMv+tyCtzI93hjt0f7nHg3B6kOsSDDl8SDCNJxdQ2x53FOx+usgDglGjxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS6sSmU1T9xuw5OXFYZcOniVHD5cNs00kxbt9SnhsPQ=;
 b=TpF1ZYooDaNwYU1/a5QeUkGdm5dOYU31rJYElpLcJmxsgZ4e/tCKri3deTTO9OGHKVUpHzy7AG26kxNs2nUOOiGpeQQW0LXuPT4P6H4aJsXAbSYmedp2CVZ1ZMlJYPHUIW2kOdH14AlqU76Av6bzhUoUA4ZYY9dMRxJhZdhat54=
Received: from BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::17)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 12:08:28 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::d9) by BY1P220CA0026.outlook.office365.com
 (2603:10b6:a03:5c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 12:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 12:08:26 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 07:08:22 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC/POC PATCH 06/12] drm/amdgpu: add SVM range data structures
Date: Mon, 20 Apr 2026 20:07:33 +0800
Message-ID: <20260420120739.1811731-7-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420120739.1811731-1-honglei1.huang@amd.com>
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|IA1PR12MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d4d497-4580-4bb4-295b-08de9ed58721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|22082099003|921020|18096099003|56012099003;
X-Microsoft-Antispam-Message-Info: 51jD2SLNXfioKxfa103Hm7gFFwSfxD+hJPdxRJX6woccSQK9L9L2vB6TINZJN7pwo+CM22dh2R2OIKxd+uiFgpCLMe2a4v3bRxYT2a3kGgHPDLtgZSLga1kwH5C5JSSZITpX4a18eFe46YTpVB1/vMSG9foVRi1x77kANAU7E3+rbiEklFU4Dy/DMjBSs+U1lTtuvnKd7/XFgffRIdnPw5xEJ0h55g1fNOGkJbeamqk5lzJLzUL5R6t+n1PoMAwCuxZV+yK0/ntPI41B/Rlwh5V8GVWoDR65/pycRCg/b3/iouPukmlY6XZwyrwhv9v87z9kWgVKwRd37xYd+FCLftOF5XDcRqirvroKC3GMNpuYjaaiJjRwvLRUmOlE6eXEj92B60drch+IQfGLDZCXeO5PKhGN12MMtPNr3JWXVIltgxbvUM49YLuT3MJr2Vo344ypMRVRtPSX5h5QWH8QV69E5L7RW1G5ZjFCWT+bV/Q7sopObgitkGeSpHfArqGJ6UEIUnTYewGQKjdtdvld8xTPcPZJyLd7tJzoh0guQouD7UXKmQjaxjt019gX5LU67GzXjEtsByxjgNOXdHOtxIWNP6GAcVEiB3DLpI7ErOEvZOf9wRmGnLldFNBbYX/DJtCL86T4OSWMWawMtSmTh/rg9CmddPm1LFOdCFgAX8eK7Dh7mPGXud0+8RYoVQN+r+58YuTu5eE/I1K8Vt1CDzlPIi2/leQLWctkrBWrt7Zvna1air8VcaravZ0C0oiFLDogz4CAcTQSnKGMFtBsdzBUodW7OH/5ZH+tfkzXJctsEZZyxiOmPtVtkQw2fx8C
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(921020)(18096099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xtHwAEirHSmIno/Pb4aWOQyGqH5ibdiTNADyVrF01/vVrnEdv7M0INAaOiQGJ9MRSi2yQ3qyb/f+RqnYKLuAvOnmIDiv/sK43Unsinrl6vQNUeLuRCFrCZzPsiL5U8ieZ+WfphQwQoAFYOTur4R652bDvSCA64YuRWCvq8KTpGk+pTkwHB2V4iEpT2S3tRTVaw8y/YU5RVDpmrTvS+5genq/IVOxAIQ1bn+gg65qu3tHgpMyrYRGGkD2qeaBrIX9DiEob1HL9TwTM7CTP84iSgKoZ7BeiW1rvb7wzmbrzmrAfcaWpChdLHiO897WHqal7xMNFuZ/RkmWHBv1q6LKpszmaGBJkZsegFrwnW/9rKWwmuCJgZgETY+gfh0zHP1Dfwabt7P53R/UHe9GGZzCccTh8EoodM9NKOvDBLIuGZyFvHJ+UPeTRA670TSscfgT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:08:26.4825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d4d497-4580-4bb4-295b-08de9ed58721
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044
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

Add the SVM range header:
- struct amdgpu_svm_range: extends drm_gpusvm_range with mapping state
- helper functions
- Function declarations for range work init/fini, flush, sync,
  mapping, attribute change application, invalidation, and queue
  stop/restore.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
new file mode 100644
index 000000000..18bf3dad1
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
@@ -0,0 +1,76 @@
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
+#ifndef __AMDGPU_SVM_RANGE_H__
+#define __AMDGPU_SVM_RANGE_H__
+
+#include <drm/drm_gpusvm.h>
+
+#include <linux/list.h>
+#include <linux/types.h>
+
+struct amdgpu_svm;
+struct amdgpu_svm_attrs;
+struct drm_gpusvm_notifier;
+struct drm_gpusvm_range;
+struct mmu_notifier_range;
+
+struct amdgpu_svm_range {
+	struct drm_gpusvm_range base;
+	struct list_head gc_node;
+	bool gpu_mapped;
+	bool gc_queued;
+	bool restore_queued;
+	bool in_queue;
+	u8 pending_ops;
+	unsigned long pending_start;
+	unsigned long pending_last;
+	uint64_t pte_flags;
+	uint32_t attr_flags;
+};
+
+static inline struct amdgpu_svm_range *
+to_amdgpu_svm_range(struct drm_gpusvm_range *range)
+{
+	return container_of(range, struct amdgpu_svm_range, base);
+}
+
+int amdgpu_svm_range_work_init(struct amdgpu_svm *svm);
+void amdgpu_svm_range_work_fini(struct amdgpu_svm *svm);
+void amdgpu_svm_range_flush(struct amdgpu_svm *svm);
+void amdgpu_svm_range_sync_work(struct amdgpu_svm *svm);
+int amdgpu_svm_range_map_attr_ranges(struct amdgpu_svm *svm,
+				     unsigned long start_page,
+				     unsigned long last_page);
+int amdgpu_svm_range_apply_attr_change(
+	struct amdgpu_svm *svm, unsigned long start, unsigned long last,
+	uint32_t trigger, const struct amdgpu_svm_attrs *prev_attrs,
+	const struct amdgpu_svm_attrs *new_attrs);
+void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm,
+				 struct drm_gpusvm_notifier *notifier,
+				 const struct mmu_notifier_range *mmu_range);
+void amdgpu_svm_range_restore_begin_compute(struct amdgpu_svm *svm);
+void amdgpu_svm_range_restore_end_compute(struct amdgpu_svm *svm);
+
+#endif /* __AMDGPU_SVM_RANGE_H__ */
-- 
2.34.1

