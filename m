Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1C7C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 09:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8730D10E978;
	Tue,  4 Aug 2026 09:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lwxfxG26";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 679C310E978;
 Tue,  4 Aug 2026 09:44:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAIAJ+LwiiRquVqpCuUysF23HXzKALMcVIeUk/1llGIOLv3lsipm64DrYZPImkVR2kJr+tThbFWYw+MSUxNo8faO1mpwjLZcFSu+WNKnf2Mu9CYoz6Tdk/YGZ35afPFT0hVuVvvTsmEOeRJ9hzyY9FAgYunyZUKlxwu1eYUBtWFApw78FwVNGzXxzt/StRdRP6tRdwD8R1aAMXWDXqaSJ4PSdUlSxU0wwk2xIczMykm73VpmsQB/zldtFVsjPTSxQQrSjt+KY5QjDINZls359iRp3yy3+/gnF1SKa+m03GnL1oisnYsuVmzfm6HbZmGyq0FizRp9pCf9aMGOslsw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spqt3+6zChctD4WQljFbUPfcgx/kM7suVZ9lbqzdXRE=;
 b=lsFS3rw3+mYivAK+WPnduiWfxsDkXL6Up912S3fdv64btZINqrQZao0p4RJ+SaXlf/ZmiVKwzMS+yu57yN/FZXfu/sRai9IHOnMridOkF4yZML8KLeuU4rvsR7GEHwenoMLC976nvFhWqm4AaAFleZ16Urc2AN/tKd1jjWmwSFLFredkrrPUpmEY8oEbYaLcNkxj3mBkQOjS5OV7/v80JYdl5MIC50Vj6qtaGxuiR3MNRalAYJpNraL2pv+j71QDUsJPwGF/R7ztHcEAjuPuK6aeyDo8sJZbf9g9oiJYhnx7wISWPCcPnOBIM+xSALgfSZP9k1zEKRhjP2Po+cNfBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spqt3+6zChctD4WQljFbUPfcgx/kM7suVZ9lbqzdXRE=;
 b=lwxfxG266PSsiY3B1FBoggUV7JXcpVkgjl+jENg/FUpuA4Mhqz4QFgtK13hNSNXlax830KTCzLxdmonNDHH73rrmhHat5Sq7YaXKBPlKkaRfabdsG0Nh+R4nMglWssJsleXT2gpHVjArbhMxL6MBNGR3H4gT2zgAN8g3TyJD7wM=
Received: from SJ0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:a03:33e::8)
 by LV0PR12MB999068.namprd12.prod.outlook.com (2603:10b6:408:32d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 09:44:25 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::50) by SJ0PR03CA0033.outlook.office365.com
 (2603:10b6:a03:33e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 09:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 09:44:24 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:44:19 -0500
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
Subject: [PATCH v9 17/18] drm/amdgpu: add SVM range migration helpers for
 drm_pagemap
Date: Tue, 4 Aug 2026 17:42:43 +0800
Message-ID: <20260804094246.1719318-18-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804094246.1719318-1-ray.huang@amd.com>
References: <20260804094246.1719318-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|LV0PR12MB999068:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2782dd-92de-443f-fefa-08def20cf7e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|921020|56012099006|22082099003|18002099003|3023799007|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: AMWy/NG/xl5guycNmOznD16pcRqVjWCA+/gTfcz6kt7DNSaMRW1WQJHw165XiObO6j0G5llcu1OKcgk+c2PmoO6944wgXN6moC9UpbyxJ1iJMKwhMvG3ig1M7bWEzgVXKnHNf5QvAZKV96vi+D6NYY8c2RMQBVTOwdgVxNuY0sxtqF+rQbPsbTMiQanRvoDh/BjP/c4qyWZ+pIEbcktokPa5WOQ+84ljJkqSzHKhKwSN//bNbsDT/bkFPX6xzNzP0INpV907eT1QCVkmujvuVEqbCWThKen1Clwgfkmb1j26sX0szq0nHgLU+gRvdDw78UCkjye8NPTtm22Z2KdrcN9COkZpp+augPbuLf95v/f2IdAcTLBUsVRtFo8KF4Ft2sauDAz+S1ysRc/Mf33Y3iWKG1+tyrPnmW5IL0AqlyJJqhEACAMEx/mrUltuF54btJluNuzHzrmy/KNtKpyoI7fIWblGXoyo7Ia0txpqFlQwumrdPRl2hoVPFn5UMFQluvuqeFmGJU8yO6kIa641FdaeEQZSBwavCqFDEjDEhYWGLDkufFDMZ704TXHAVS5k0HjlUuT3+733w3zRHkH/WucNPTfZ1YGar4gaVurTIksH/eKftqthvZT8i5Oy044Gls7pNSPsakczgAFRqU167TL/44WpQZ42i/QfVPQhYnCq2k9KhzZkH211xSLkStoSfuP7olnhvM2M+8q7aCFPWbK4XfTur7mf00t5g2+uj0eJDHyH5DtORl0d38HHoj3K
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(921020)(56012099006)(22082099003)(18002099003)(3023799007)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MlOSva7V5VvqoYUmvaFKMvulzcz3caXwKs0AFIfJD67OKAsqjZpsFJ2YL0uQNmtjETaafYBTcXHMmOF49PYgwS4bo/x4R6IlB14Zjtp/YqePv17d8ccDLDGCy5854bhJz5lNytHsKrYWKX7GnYpLGXmJnpG3chDm6B2m9ZlzJ9C7mEX61GHFSiXVW4H1PapC7v/B9kfHFTxQkCjcriwvsAEVpn45V4nX6DYazHjLX7cdFXz8kfN/4KdxSkRHBmHzB4IW8phN7BbQUXaNbKpBEWMP4LkQQG+T6PudxrY/Fo5zwZ1qEmYhHgGWKFD3OmqX3BM+s4VtBlMIIio1kOLpF7C+LMGwmH/Jt66xCbkQR7AnlpfdGOujWmpEg2lmVyEfp5q2w5dbmccRY54BW3ONv3wVQo/Y5ZV2mdwA8u7pzMKD5+QzUqPsWPAE8sE/CWnU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:44:24.4684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2782dd-92de-443f-fefa-08def20cf7e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999068
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
 drivers/gpu/drm/amd/amdgpu/Makefile           |   6 +-
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.c | 120 ++++++++++++++++++
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.h |  35 +++++
 3 files changed, 158 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 75047adbdd57b..0d08561b4922a 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -324,14 +324,14 @@ amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
 
 # svm support
 amdgpu-$(CONFIG_DRM_AMDGPU_SVM) += amdgpu_svm.o amdgpu_svm_attr.o \
-	amdgpu_svm_fault.o amdgpu_svm_range.o amdgpu_migrate.o
+	amdgpu_svm_fault.o amdgpu_svm_range.o amdgpu_svm_range_migrate.o amdgpu_migrate.o
 
 .PHONY: clean-svm
 clean-svm:
 	rm -f $(obj)/amdgpu_svm.o $(obj)/amdgpu_svm_attr.o $(obj)/amdgpu_svm_fault.o $(obj)/amdgpu_svm_range.o \
-	      $(obj)/amdgpu_migrate.o \
+	      $(obj)/amdgpu_svm_range_migrate.o $(obj)/amdgpu_migrate.o \
 	      $(obj)/.amdgpu_svm.o.cmd $(obj)/.amdgpu_svm_attr.o.cmd $(obj)/.amdgpu_svm_fault.o.cmd $(obj)/.amdgpu_svm_range.o.cmd \
-	      $(obj)/.amdgpu_migrate.o.cmd
+	      $(obj)/.amdgpu_svm_range_migrate.o.cmd $(obj)/.amdgpu_migrate.o.cmd
 
 include $(FULL_AMD_PATH)/pm/Makefile
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
new file mode 100644
index 0000000000000..a908989964f4b
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
+		AMDGPU_SVM_ERR("migrate_to_vram failed: ret=%d [0x%lx-0x%lx]\n",
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

