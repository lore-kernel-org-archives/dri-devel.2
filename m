Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3AE606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=X0+d06y8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A62B7112896;
	Fri, 27 Nov 2026 08:43:56 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FDDE112894;
 Fri, 27 Nov 2026 08:43:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfmBpkuNC5Svj4HlAwXyAqQ0rBSlZXCr4RId0zq0PGzCPDQIsUG3ik5JmH0Q/MOQhKbOeV2fUFl3KGuyMD8R/WbTF/I9JPm1GsGy9y3D3DP4oPU5nTkvE5a2YvU+wRb98HS2IshML7p9p3BqJZMyinQu2ilZQmSRlLBGc2X1tIVaPADV2525dIPS/njeLdAuWqq6BqbO3Btf4dcBKOPmRGc3oTYu81f11NuyotOhz+FeHIeka9bPFPaki4HdMeuyNfduNaNF/ZuM2sEiE5dK9jHIpe7f60C++93iCIoujWHA3100Xu4SsOwb0gyepPWvtTcGk3e8RNLR8hhcSPfpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxJk4GAzuzpeXPQ1G2m956CSHw/WfO8k3AZzt9O0Jc8=;
 b=jw0RkyVW2sC+lsZ4BWAl4LkwmZo2N+AtoFupolXVdSrCwzmNM7HBqBAyCwjuVfTTf/E8Fp5gSFY4xkGe7vNngdNs8DvR2SOdf77O8a7UpOGfpZTtMtz0r8giSZnUrkaZvig2cxzTLDHSV5J7b+wI9L6nGnPykucQdaq20nH61oWL8C3AiXSaWUL0KFae7m6UUZjeSQPS+BqjXqZhfqLGlOE5lwlRCwkIc/1S6J5oX8f40IhwzKFnAIAtX0pZmpmGdufn76M7ZlWrzMQKFuB22VSgC/sfsOGcmfVNWR8j7J671laK6E0yBdkRLZUYRmCdEr0rtK1AYBynLrETlI0cmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxJk4GAzuzpeXPQ1G2m956CSHw/WfO8k3AZzt9O0Jc8=;
 b=X0+d06y8JGS7IxntNySPaIfh5tk1mFXG81IY4fYAA5NOPEEvtMnvDUHcF3apkIoHAhD3WHe/nseSw5BY4TOPHKBxo6s20+uBX1gnxhQFAIMkNi6EftpB5ERwJxNEt/Nc8JXLsDK+s7bYph7oNAJLmhrhYQVGNr3Kj0fjP6I2Xa8=
Received: from CH0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:610:b1::21)
 by SJ0PR12MB6736.namprd12.prod.outlook.com (2603:10b6:a03:47a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 08:43:41 +0000
Received: from CH2PEPF000166C1.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::7e) by CH0PR13CA0016.outlook.office365.com
 (2603:10b6:610:b1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.4 via Frontend Transport; Fri, 27
 Nov 2026 08:43:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166C1.mail.protection.outlook.com (10.167.252.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:43:40 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:43:30 -0600
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
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v11 21/22] drm/amdgpu: add SVM range migration helpers for
 drm_pagemap
Date: Fri, 27 Nov 2026 16:41:44 +0800
Message-ID: <20261127084149.925625-22-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127084149.925625-1-ray.huang@amd.com>
References: <20261127084149.925625-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C1:EE_|SJ0PR12MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de7437d-ac45-4829-4a84-08df4c62899e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|22082099003|18002099003|3023799007|921020|11063799006|5023799004|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261022075727099003|261022115727099003|261022105027099003|261022113327099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 1r5b+SWBvg2mHgR1Ak12cNfyjlNMveFRhMvWF8ny1wkCOkB+6Fn83NQLaY5I9LGf6Ug9Vt6Fse/1AHCVU6nHIR+8VTQWCJkmoP7c50p8DiEqCFU6bcCahgbBKoyE4sdo0nVUY/Mml+dy7R3YCKr/YfMVGLbM27yI0vsCwRjfrf3Q4SHA+gy/3/c/8N5UmidxZKNy006e7yXgDZqw0USuBdFoeSkODudTGeKyaYn33VpsBH31t+o48T0gpkCXvhr8C+6I18yEzn0WUUOZtsmNWOIJVCRiftj9Z4IWPqbfFlCxJiVjTG0ZOHzMEQkswo8IL8C/OAhvSczwkey7FEk98MQj+iDNRTKuwv11XeHapWMl9KhcqGNVWYy8rTeq+cJDNmV4j1irTGbXghK138X+Urv+gCWJ6j81Ik57xW8/db1inKojg7lkjE6jDwqs2kgm8RTjhaYjNENtHhhZoaMjC07jzQILGj6vvnS/u0ZC8TmoPTDPOHka82sDYhTEcZ+abBpXoeAn1UYn5ehmiJPyZl4rpdQ9aNuhpo2wbHUJH7C63zDsmS+bMM2W4KlwEJZjjaPUfwDTmUPON7XcthDxcVsMMPBnqdvgMj10sMHnTUDWBw24/Jp8MRgpdcPSmo/Z9RdadM7io+3oZG57KOyo75zELoxcMfjHHTBNoAmzg2ajjZ4OjKTo4dx6uITyxijen7zoVozGwfWLv5c/MJEHO7mdYc0IlkyFDpEGoZt+9vytCXw1S7y20Doyak67Gbv0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(22082099003)(18002099003)(3023799007)(921020)(11063799006)(5023799004)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261022075727099003)(261022115727099003)(261022105027099003)(261022113327099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PuLeqMa3KezuEyvP4qp202ypQs/USsw46lOKU/0J53L24wxGcSbbRlNd2D9Q/0W1jOE6VF9QPqTIE80uNIE8wnCeh9j8EIaAjgm2C7YAv3Yd0WLEIldiQfyf9OXWb/84udSYkmVj8nSVKDJUYyV76VXhJkF+0H5U929ywDheZ7zOwBNLqHsAqvR5Z6n0mWEHKDQWlQixQQVVfBqihA89n+2zNjv4uFqV4dzVEvThLohfPJNbGtrIlXL1iIf3LkPjL4ipdo3MM4cUsyeAEN+F6IaFntlFsGPuQJNPpTIUHV65sY2gf4lq4L+eCCKWwMTB37evdlHHbymb9OMPhq/ozVBWKfioG6w1t6r/vztH/Bev7kj5j/pz4KFNHi1D9xgvNB6exCbEzG3GPKB65CiBzMnl2B35z3sBs/oW33J4R/fwwb68D9Elm6+iOYUVRe3p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:43:40.8720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de7437d-ac45-4829-4a84-08df4c62899e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166C1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6736
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

From: Junhua Shen <Junhua.Shen@amd.com>

Add amdgpu_svm_range_migrate.c/.h implementing the per-range migration
helpers for SVM VRAM migration via drm_pagemap:

- Implement range_needs_migrate_to_vram() checking migrate_devmem
  capability and current backing location.
- Add amdgpu_svm_range_migrate_to_vram() wrapping
  drm_pagemap_populate_mm() for RAM-to-VRAM migration. On -EBUSY
  (partial migration due to races), evict conflicting pages back to
  system memory via drm_gpusvm_range_evict() and retry once.
- Add amdgpu_pagemap_capable() to check device memory support.

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.c | 120 ++++++++++++++++++
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.h |  35 +++++
 3 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 66f4a4d2d451e..a110576ba1b2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -332,7 +332,7 @@ amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
 
 # svm support
 amdgpu-$(CONFIG_DRM_AMDGPU_SVM) += amdgpu_svm.o amdgpu_svm_attr.o \
-	amdgpu_svm_fault.o amdgpu_svm_range.o amdgpu_migrate.o
+	amdgpu_svm_fault.o amdgpu_svm_range.o amdgpu_svm_range_migrate.o amdgpu_migrate.o
 
 include $(FULL_AMD_PATH)/pm/Makefile
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
new file mode 100644
index 0000000000000..587f601a61361
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
@@ -0,0 +1,120 @@
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
+#include "amdgpu.h"
+#include "amdgpu_svm.h"
+#include "amdgpu_svm_range.h"
+#include "amdgpu_migrate.h"
+#include "amdgpu_svm_range_migrate.h"
+
+static bool
+range_in_vram(struct drm_gpusvm_range *range)
+{
+	struct drm_gpusvm_pages_flags flags = {
+		/* Pairs with WRITE_ONCE in drm_gpusvm_get_pages() */
+		.__flags = READ_ONCE(to_amdgpu_svm_range(range)->pages.flags.__flags),
+	};
+
+	return flags.has_devmem_pages;
+}
+
+static bool
+range_needs_migrate_to_vram(struct drm_gpusvm_range *range)
+{
+	if (!range->flags.migrate_devmem)
+		return false;
+	if (range_in_vram(range))
+		return false;
+
+	return true;
+}
+
+static struct drm_pagemap *
+amdgpu_svm_get_dpagemap(struct amdgpu_svm *svm)
+{
+	struct amdgpu_pagemap *apagemap = svm->adev->apagemap;
+
+	if (!apagemap || !apagemap->initialized)
+		return NULL;
+
+	return &apagemap->dpagemap;
+}
+
+bool
+amdgpu_pagemap_capable(struct amdgpu_svm *svm)
+{
+	if (svm->adev->gmc.is_app_apu)
+		return false;
+
+	if (!amdgpu_svm_get_dpagemap(svm))
+		return false;
+
+	return true;
+}
+
+/**
+ * amdgpu_svm_range_migrate_to_vram - Migrate range pages to VRAM
+ * @svm: Pointer to the AMDGPU SVM structure
+ * @range: The GPU SVM range to migrate
+ *
+ * Wraps drm_pagemap_populate_mm() to migrate system memory pages
+ * backing the given range into device VRAM. Skips migration if the
+ * range doesn't support devmem or is already in VRAM.
+ *
+ * Return: 0 on success or no-op, negative error code on failure
+ */
+int
+amdgpu_svm_range_migrate_to_vram(struct amdgpu_svm *svm,
+				 struct drm_gpusvm_range *range)
+{
+	struct drm_pagemap *dpagemap;
+	unsigned long start, end;
+	int ret, retries = 1;
+
+	if (!range_needs_migrate_to_vram(range))
+		return 0;
+
+	dpagemap = amdgpu_svm_get_dpagemap(svm);
+	if (!dpagemap)
+		return -ENODEV;
+
+	start = drm_gpusvm_range_start(range);
+	end = drm_gpusvm_range_end(range);
+
+	do {
+		ret = drm_pagemap_populate_mm(dpagemap, start, end,
+					      svm->gpusvm.mm, 0);
+
+		if (ret == -EBUSY && retries)
+			drm_gpusvm_range_evict(&svm->gpusvm, range);
+	} while (ret == -EBUSY && retries--);
+
+	if (ret) {
+		pr_debug("migrate_to_vram failed: ret=%d [0x%lx-0x%lx]\n",
+				 ret, start, end);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h
new file mode 100644
index 0000000000000..6e4b6e45512e7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h
@@ -0,0 +1,35 @@
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
+#ifndef __AMDGPU_SVM_RANGE_MIGRATE_H__
+#define __AMDGPU_SVM_RANGE_MIGRATE_H__
+
+struct amdgpu_svm;
+struct drm_gpusvm_range;
+
+bool amdgpu_pagemap_capable(struct amdgpu_svm *svm);
+int amdgpu_svm_range_migrate_to_vram(struct amdgpu_svm *svm,
+				     struct drm_gpusvm_range *range);
+
+#endif /* __AMDGPU_SVM_RANGE_MIGRATE_H__ */
-- 
2.53.0

