Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50013606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VLv4su7h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADBA110F8B5;
	Wed, 21 Oct 2026 03:03:08 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2CC810F8BB;
 Wed, 21 Oct 2026 03:03:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjUjyDj6vEzo/QsrsLJ4rvdIxCu9A8zlOzzRONYcKZ4stVxPztY+jS7rsJaRKNsaPnxmP2vtpdPO/kksulxre6dNCURDZ9X5UjpoIBMpdIYUQ77qgeqevhpVD9OCelz7k04+utx0itR4jhm+rIwZcyvII7d6XRPOay8NSYNq9LFHEhNQyaL/+c9vNwYQ8cP2dzSBht6BmElACGneez3p4p3n1F0E+rJlZyzcDJHRwvcl6JQfbcIi/m2deTqhy7mepKyuSixIhf+fCwApa3ZFJ9fxFuA5z5DvOHbsd1fQKySWtgSEj1puQ7JG85JB7EzCq3IYNQ8H+RoYD0k3GKC7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqBg6/yuMw4ydVTsHGvBO2R8PBlwQ0HMC6HbNXQZMJM=;
 b=nrOgfbq7Ff/fdl9lM0jr+/Gxsi+kXsGpkDkX/kAZmRL2QPIcacEkajvKb7uoj3fs8Hu/9blnRIJfLMRIIZp6cv619fiO+OtWGCk0e99X5hMm8CZ/4ydzf+jfHSO55MV3IyPk+hokIE8OnPP9rCreIxDHvwAQoczBZBK7SIPXVFTK0OnpQW8ijez2ykWeK0X9buMdfxlnPVH568UpGYCfk6Da7lDDGepv0BharDo+9DomNTC4dArKfCm+WgVbWd0sKpWrFwF0kSkGPL7ppN+1Juth2p3O7umD91t3xhX6SxS+8q4rU1JcAyl+8IuJSfflpYllU1y/u3WCM6D4DdSWZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqBg6/yuMw4ydVTsHGvBO2R8PBlwQ0HMC6HbNXQZMJM=;
 b=VLv4su7hYptlKK9pQI71rPe5JRCo2PSD7/Ak8nY6cM8cFFngO6S9eP2wrbo2uLFGeq42tncrk4/5dfpVlVR5yR+Ziz/m3Np1K0G3fN433SQ81gRSNbEQvZ9Z3dfmZm+4NxW95ig+ukZAVUg1z0yxao4Le/Yx5GHs5pvFWfMesoo=
Received: from SJ0PR13CA0076.namprd13.prod.outlook.com (2603:10b6:a03:2c4::21)
 by DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 03:02:25 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::32) by SJ0PR13CA0076.outlook.office365.com
 (2603:10b6:a03:2c4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 03:02:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 03:02:24 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 22:02:08 -0500
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
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v10 21/22] drm/amdgpu: add SVM range migration helpers for
 drm_pagemap
Date: Wed, 21 Oct 2026 10:59:00 +0800
Message-ID: <20261021025915.2433837-22-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021025915.2433837-1-ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f3a4552-f3d7-4496-1e90-08df2f1fbba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|261009223027099003|10067099003|56012099006|3023799007|22082099003|18002099003|5023799004|11063799006|921020;
X-Microsoft-Antispam-Message-Info: CxOEMblXiJIewef70k1qxEafFQzJmpe1kJYJdXyxVEHqtmj29beOib+QtiFJ68/BLbkCyhkpaV1iSsHScqWBWMuFhNnB8wVTWicV+AVU5iMYrrSWVftPefkd4OCHJrQM1rirgiFH6ChpJHNDi1d+Tbmp/sxDnsIX38J6UEIasoNEkQESbvPGe0G5rMTB+8BAY7Oqz/KO7frWYkg+8CIpdRrMCroYhzCboAj7QOO17brXI2D1KjTJssJ2y7/I17M8CSnjQWcRtkF4aVg5aKSZbnwvvFPTVp/vwH+Nc+1IBAXuOIIBwkJBmbgTCTq39+bq31hqcip9sPvMK7UjY29R5Pti1XTYNUVX+q0EAugHvnvj5w9khmxMY/4YNHJkqwjNO6w9wmWSFecfHv7QfTgJhanjJdkZqGC71dg/k/weD/k+YjoSzjri4fTD5qi7d7f+Et2D4opk0i/gzLi7PXHfZqjdRSsIf0+tsMyMP54bin5SZg31DNL1B65JvGpZ60fIpch4GFzlDzU5NGkSQxYYg8oxqDdr4cHcM06O1BtOPC0UVLUn0Qx8/6qhGTbloD9W3/44pQfWVD5DQ+9zUNB3Vm4B7PzkS2mzSsShL0+/CYj4voBZ/tDJWHgzT0Y1ruyrG/tLK9ltqXbIrrb8/n2vtOUwGm+fxW2JEZtC+msIFk1uH074AABZuY4tqK3xnEfTLxJQLeessJ+6ufYekfC+hVtw/JMM70EneQWpHsYs2sC0hUPPOpeIopEM50KZyMpS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(261009223027099003)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(5023799004)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bdLWJI37cW5a1A0BoChv7qGHcYwmsUt6caDF5OMKSaPHnOMZSp1CltSdlCy7A8zaJKtSMnc0JmLI8QGOYNNXDk0qYNZDSkUmPS+gDRzhXrCc1JhoafnsZGlKi389RwxMxcwcbvvkuFNZdAw2MXVUvxybJqnLdahrc4aqhnAD516a0wEF3o72YnZ3N/bx5+SGDfRvldb7a4ZlrE0qgbWPE3XJiBWpO/PrJljDJTIPPn7kSHtZwUaTK/55OC1EUC+Hm4VjSaBlqp1DGrUP2r7ooJRcwFFsYdWq7i/Au89QI9dmhvVbsQASakPQLVllHuGcMc4WUDNqSgOfIMjcCvz7eggVZLjsjxhYucAUt31BDg2kUohYXmmsbwQEloVU6/yNpTD/g2O77RKgPyBI/sqwb2CYDtLDWSN2yP/s0+uy8MS4gF4F4JpN1etefh5HJBJu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 03:02:24.7415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3a4552-f3d7-4496-1e90-08df2f1fbba7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
index c78e9a0474425..9a233012beb44 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -328,7 +328,7 @@ amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
 
 # svm support
 amdgpu-$(CONFIG_DRM_AMDGPU_SVM) += amdgpu_svm.o amdgpu_svm_attr.o \
-	amdgpu_svm_fault.o amdgpu_svm_range.o amdgpu_migrate.o
+	amdgpu_svm_fault.o amdgpu_svm_range.o amdgpu_svm_range_migrate.o amdgpu_migrate.o
 
 include $(FULL_AMD_PATH)/pm/Makefile
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
new file mode 100644
index 0000000000000..0c44ad2920328
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
+		.__flags = READ_ONCE(range->pages.flags.__flags),
+	};
+
+	return flags.has_devmem_pages;
+}
+
+static bool
+range_needs_migrate_to_vram(struct drm_gpusvm_range *range)
+{
+	if (!range->pages.flags.migrate_devmem)
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

