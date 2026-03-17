Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDE0FD8744
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 11:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9451610E60D;
	Tue, 17 Mar 2026 11:30:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SjEdiqZ1";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7295210E609;
 Tue, 17 Mar 2026 11:30:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZWQIYlKO4nqoLDjxh6Ud0hw3Sk6WDs3SO32/U9TZCaX8SaxndgFeBTVn/+axrwG9hU7EeKs/ne1w6+nXBwC+v4XmSYkA6549wLdA0/kuD8qXtORnTMOwClBgXDmo3RRnca3XtVm+Z7l/tIKeMVmc7CKoBns7eyAjUFXVkJ8mey8NyYgMRfvxdaj4nsZMiIlowLgKeXdasZfwgRzAIxbnXYoaAGm5Lfmq/+5OCrlFuNwQxmOBCyCicu/g5X7Sm8wwVZv/sgNJN2yYa3BYkz+74jO5CfomfhUMZCZeCSIOC+v1KdKkxDU7EEbwWFMRsuVshCj9DflKGKV67RzxmnFOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gS6sSmU1T9xuw5OXFYZcOniVHD5cNs00kxbt9SnhsPQ=;
 b=CeuCSfn3QU3FlHNkW9Nc8/y/rmlxA7lhw5TWeOc68hE9p6LisNmDSISrWExVUe8jAxN5p8/58FfN6nOjT6n+gx/kQmFyHB/ibRSCyHEifPs4J0F6SrCjHiUFnw1VgGg8MOCbYzJYrcO5hYr+eBjw8DuHzayRw72yTTPbwkJyg4+S+zpjPg+hYhbDWBQUZH86WlYXKL2XELel4lkyPckNDJbXa0BQtDs/5+fZdyM/2C0gc+buD8ZszudXVYlm7RVvJJtxzUCi0DdFLC9Yg43h9yWY3zpXw9Ua4R2kn2aK+G+Z6gt7DBKcUswyUmTaDGLJaSTu5luIDfd2z58FQH3JYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS6sSmU1T9xuw5OXFYZcOniVHD5cNs00kxbt9SnhsPQ=;
 b=SjEdiqZ1WaSjQlLoG/7ZF9KwAaEH5xRxn4BzXrDqbAKuPuenVmUwCP+rrBFUVbkUYyHCFKdj3JJ6bjU+9PxjRgj++/ArVxHXo4kzfM97JLUGjb+QTM30FyHqyZmXxgTjoDtkYYkAu0djKtc+W9wCEiEAeTY3787OmddVl9HhIU4=
Received: from BY3PR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:39b::12)
 by LV2PR12MB999096.namprd12.prod.outlook.com (2603:10b6:408:353::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 11:30:35 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::58) by BY3PR05CA0037.outlook.office365.com
 (2603:10b6:a03:39b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 11:30:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 11:30:34 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 06:30:31 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC/POC PATCH 06/12] drm/amdgpu: add SVM range data structures
Date: Tue, 17 Mar 2026 19:29:52 +0800
Message-ID: <20260317112958.2925370-7-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317112958.2925370-1-honglei1.huang@amd.com>
References: <20260317112958.2925370-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|LV2PR12MB999096:EE_
X-MS-Office365-Filtering-Correlation-Id: 39bd288f-d3b9-4040-c770-08de84189b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: G4NkZVgloAIcepCOlftPVBn+0ZE/59TS6DKovyQLcQ3lMNLLFkmSiOQGVt+3pYxwD3J56PFkFdi+NC3Cy081DVnusTMsxObs44flUlUNa9UDGmDrDd8F9uDXmXz5v3RJhuKbJeWv5W+J3ifRrUFyxojP5rvsbMQnxPk/oVBHHzFP0pX08cTbTAlMQWxvXJv7eiz9k1J7zyaXOM0ZUVTxwT5AWyKFYxwZisL8k0Vlqd5XZIM2cM3FIe9URsLTlBKAquU/fOgyWPpZYFdIBjhI8Jna4C5da8pRBsZIzlGcLgV2+6Ohva2Fcyghq4mw0Tad/vBW6g2EftChqiH7FcU398wSDyCJHWRoCYaQPrwU+x/cGKxY3bIykPVgIVM+XGLzzdKAowiu+TVzggsHR4hw3uH9FAfaPbaIjaUzn0nVVhAxRBGEpOFcYYwU5W3Ctlwo0kg8ekhC/bfy0NsdEMttxwZssSKo6qNTp9Z3LK+3Nd/x0PcI/GVYEBLgvvLzq+jn5DYniXe47W84Wye88LjCjHsBD8Z4xXohoWSHX1tRxBSrmxAkHq6lIjLogYRgpOMGX83mg7hkgJUHivNiM2qa6WW7ARBj+IYtXwS5QpQI7KOdo0IyeZiInU1Aofl0xD9ehRcxZrRubLQ5edbRAqrnjZQnWuLS/lXr0fZL6h5gZlhn41iLTKxJZyfHEWPVcyog3dVau8XOUsvpuz26zh0zoJimAOvfg3RQD1BETkSwZz94om2oOy31RIgv3VDulG8ai0QOtOW/SwB2Q21gSIITAvJ/UK5f0q5iQt3Rv2Wozsv//87+WGzN7EuIuJrwFixC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZIrsualcPfG3jnfyos8hD0PVpUei9RyvzZwPlyOOK0ML+U/YMZ/5CwOyHbs5kMVx4MeVIdYw3y/hqJkpJF9ErSPBEOQoUM+X4deLjExaVerUsXWqUCOSEjasTAWsBWW7Kf7yzO2/lU4rI8jOHOm6LLujwpNZi+7qRZ1UNG0WTxdCN2zUNoz7dla3Y4MuzO/Uv/OwXFSl5gNfIZI5ALGDP86Z910pHqI5GzQG983ULo+gkruOFaCU35oZ8lxi0UJef134iNMMlJGkFSd98DpUc+Ld9NGNpbng7zJfFA6hrAbasx6aJX7WD4SR+bf7Ib/7xxZiadhsApaCkJcxxlgRVY1v80PG8de1+0okyOedtOCU/HCHUK1XHorxB51tzBpS4pxCZsZoUI+8gP20xn3uVKWA1ybhxD5b1tanY8ZU8vpNJklMu3VeWZPDjCJKWydf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:30:34.8002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bd288f-d3b9-4040-c770-08de84189b0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999096
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

